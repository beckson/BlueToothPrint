//
//  OKBLEManager.m
//  OkdeerSeller
//
//  Created by 雷祥 on 2017/4/14.
//  Copyright © 2017年 Okdeer. All rights reserved.
//

#import "OKBLEManager.h"
#import "HLBLEManager.h"


@interface OKBLEManager ()
@property (nonatomic,strong) HLBLEManager *manager;
@property (nonatomic,strong, readwrite) NSMutableArray *deviceArray;
@property (nonatomic,strong, readwrite) __block NSMutableArray <CBService *>*infos;
//@property (nonatomic,strong) CBPeripheral *selectedPeripheral;
@property (nonatomic,strong) CBCharacteristic *selectedCharacteristic;
@property (nonatomic,strong) dispatch_source_t timer;
//@property (nonatomic,assign) CBManagerState centerManagerState; 
//@property (nonatomic, weak) UIViewController *printVC;


@end

static OKBLEManager *instance = nil;
@implementation OKBLEManager

+ (instancetype)shareInstace {
    return [[self alloc] init];
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super init];
        _infos = [[NSMutableArray alloc] init];
        _deviceArray = [[NSMutableArray alloc] init];
        _manager = [[HLBLEManager alloc] init];
    });

    return self;
}

+ (instancetype)allocWithZone:(NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });

    return instance;
}

/**
 * 为了解决提示信息问题（iOS10无法直接跳设置界面），在蓝牙断开情况下，重新初始化中心设备,用初始化时系统检测是否连接的提示
 */
- (void)recreatCenteral {
    [self.manager recreatCenteral];
}

/**
 * 清除缓存的设备
 */
- (void)clearDevices {
    [self.deviceArray removeAllObjects];
}

#pragma mark -------------蓝牙连接相关---------------

- (void)scanForPeripheralWithCompleteBlock:(ScanPeripheralBlock)completeBlock {
    if (self.manager.centralManager.state == CBManagerStatePoweredOn) {    //已经初始化过，直接判断当前的状态
        [self scanPeripheralsWithComplete:completeBlock];
    }
    else {
        __weak typeof(self)weakSelf = self;
        NSLog(@"中心设备的状态:%zd",self.manager.centralManager.state);
        self.manager.stateUpdateBlock = ^(CBCentralManager *centralManager){ //没有初始化，等待回调
            if (centralManager.state == CBManagerStatePoweredOn) {
                [weakSelf scanPeripheralsWithComplete:completeBlock];
            }
        } ;
        //第一次扫描时，如果没有开启，self.manager.centralManager.state == CBManagerStateUnknown，系统自动提示
        //第二次扫描，如果没有开启,状态为CBManagerStatePoweredOff
        if (self.manager.centralManager.state == CBManagerStatePoweredOff) {
            [self.manager recreatCenteral];  //重新初始化时会有提示
        }
    }
}

- (void)scanPeripheralsWithComplete:(ScanPeripheralBlock)completeBlock {
    [self.manager scanForPeripheralsWithServiceUUIDs:nil options:nil didDiscoverPeripheral:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        
        if (peripheral.name.length <= 0) {
            if (completeBlock) {
                completeBlock([self.deviceArray copy]);
            }
            return ;
        }

        if (self.deviceArray.count == 0) {
            [self.deviceArray addObject:peripheral];
        } else {
            BOOL isExist = NO;
            for (int i = 0; i < self.deviceArray.count; i++) {
                CBPeripheral *selectPeripheral = [self.deviceArray objectAtIndex:i];

                if ([selectPeripheral.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString]) {
                    isExist = YES;
                    [_deviceArray replaceObjectAtIndex:i withObject:peripheral];
                }
            }

            if (!isExist) {
                [self.deviceArray addObject:peripheral];
            }
        }

        if (completeBlock) {
            completeBlock([self.deviceArray copy]);
        }
    }];

}


- (NSMutableArray *)deviceArray {
    if (!_deviceArray) {
        _deviceArray = [[NSMutableArray alloc] init];
    }

    return _deviceArray;
}

- (NSMutableArray *)info {
    if (!_infos) {
        _infos = [[NSMutableArray alloc] init];
    }

    return _infos;
}


- (void)connectPeripheral:(CBPeripheral *)peripheral complete:(void (^)(CBPeripheral *peripheral))completeBlock {
    if (![peripheral isKindOfClass:[CBPeripheral class]]) {
        return;
    }
    HLBLEManager *manager = self.manager;
    __weak typeof(self)weakSelf = self;
    [manager connectPeripheral:peripheral
                connectOptions:@{CBConnectPeripheralOptionNotifyOnDisconnectionKey:@(YES)}
        stopScanAfterConnected:NO
               servicesOptions:nil
        characteristicsOptions:nil
                 completeBlock:^(HLOptionStage stage, CBPeripheral *peripheral, CBService *service, CBCharacteristic *character, NSError *error) {
                     switch (stage) {
                         case HLOptionStageConnection:
                         {
                             if (error) {
//                                 [SVProgressHUD showErrorWithStatus:@"连接失败"];
                                 NSLog(@"连接失败");
                             } else {
//                                 [SVProgressHUD showSuccessWithStatus:@"连接成功"];
                             }
                             break;
                         }
                         case HLOptionStageSeekServices:    //扫描一次只回调一次
                         {
                             if (error) {
//                                 [SVProgressHUD showSuccessWithStatus:@"查找服务失败"];
                                 NSLog(@"查找服务失败");
                             } else {
//                                 [SVProgressHUD showSuccessWithStatus:@"查找服务成功"];
//                                 [self.infos addObjectsFromArray:peripheral.services];
                                 //接收服务时，服务还没有特性及描述，在回调后会自动添加到服务中
                                 [peripheral.services enumerateObjectsUsingBlock:^(CBService * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                                     BOOL matched = NO;
                                     for (CBService *service in weakSelf.infos) {
                                         if ([service.UUID.UUIDString isEqualToString:obj.UUID.UUIDString]) {
                                             matched = YES;
                                         }
                                     }
                                     if (!matched) {
                                         [weakSelf.infos addObject:obj];
                                     }
                                     else {
                                         [weakSelf.infos replaceObjectAtIndex:idx withObject:obj];
                                     }
                                 }];
                             }
                             if (completeBlock && self.infos.count) {
                                 completeBlock(peripheral);

                             }
                             break;
                         }
                         case HLOptionStageSeekCharacteristics:
                         {
                             // 该block会返回多次，每一个服务返回一次
                             if (error) {
                                 NSLog(@"查找特性失败");
                             } else {
                                 NSLog(@"查找特性成功");
                                 NSLog(@"特性个数character:%@---%zd",character,peripheral.services.count);
                             }
                             break;
                         }
                         case HLOptionStageSeekdescriptors:
                         {
                             // 该block会返回多次，每一个特性返回一次
                             if (error) {
                                 NSLog(@"查找特性的描述失败");
                             } else {
                                 NSLog(@"查找特性的描述成功");
                             }
                             break;
                         }
                         default:
                             break;
                     }


                 }];
}

/**
 * 断开连接
 */
- (void)disConnectPeripheral{
    [self.manager cancelPeripheralConnection];
    NSLog(@"HLBLEManager:%@",self.manager);
}

/**
 * 停止扫描外设
 */
- (void)stopScanPeripheral {
    [self.manager stopScan];
}


/**
 * 写入数据，不一定会有completeBlock的回调
 */
- (void)writeData:(NSData *)data complete:(void(^)(CBCharacteristic *characteristic, NSError *error))completeBlock {
    if (!data) {
        NSLog(@"没有要写入的数据");
        if (completeBlock) {
            completeBlock(nil,[NSError errorWithDomain:@"没有打印数据" code:10 userInfo:nil]);
        }
        return;
    }

    self.selectedCharacteristic = nil;
    CBCharacteristic *tempCharacteristic = nil; //保存可写但写入完成没有回调的特性
    for (CBService *service in self.infos) {
        for (CBCharacteristic *characteristic in service.characteristics) {
            if (characteristic.properties & CBCharacteristicPropertyWrite) {    //特性有可写属性
                NSLog(@"可以答应的特性(有回调):characteristic:%@",characteristic);
                self.selectedCharacteristic = characteristic;

                break;
            }

            if (characteristic.properties & CBCharacteristicPropertyWriteWithoutResponse) {
                NSLog(@"可以答应的特性(没有回调):characteristic:%@",characteristic);
                tempCharacteristic = characteristic;
            }
        }
    }

    HLBLEManager *bleManager = self.manager;

    if (!self.selectedCharacteristic) {  //如果没有可写并有有回调的特性,就写入可写但没有回调的特性
        self.selectedCharacteristic = tempCharacteristic;
        if (!self.selectedCharacteristic) {//没有特性，直接返回
            if (completeBlock) {
                [self disConnectPeripheral];
                NSLog(@"没有可用的服务");
                NSLog(@"不可打印服务个数:%zd",self.infos.count);
                completeBlock(nil,[NSError errorWithDomain:@"没有可用的服务" code:OKPrintErrorNoCharacteristic userInfo:nil]);
            }
            return;
        }
        NSLog(@"没有回调可以打印服务个数:%zd",self.infos.count);
//        [[OkdeerAnimation instanceAnimation] startAnimationSubmitToView:nil message:@"正在打印" fullScreen:YES stopAnimationTime:0];
        [bleManager writeValue:data forCharacteristic:self.selectedCharacteristic type:CBCharacteristicWriteWithoutResponse];
//        [[OkdeerAnimation instanceAnimation] stopAnimationWithDuration:5 completion:nil];

    }
    else {  //CBCharacteristicPropertyWrite
//        [[OkdeerAnimation instanceAnimation] startAnimationSubmitToView:nil message:@"正在打印" fullScreen:YES stopAnimationTime:0];
        NSLog(@"有回调可以打印服务个数:%zd----self.selectedCharacteristic：%@",self.infos.count,self.selectedCharacteristic);
        [bleManager writeValue:data forCharacteristic:self.selectedCharacteristic type:CBCharacteristicWriteWithResponse completionBlock:^(CBCharacteristic *characteristic, NSError *error) {
//            [[OkdeerAnimation instanceAnimation] stopAnimationWithDuration:0 completion:nil];
            if (completeBlock) {
                completeBlock(characteristic,error);
            }
        }];
//        [[OkdeerAnimation instanceAnimation] stopAnimationWithDuration:5 completion:nil];
    }
}

- (CBPeripheral *)connectedPer {
    return self.manager.connectedPerpheral;
}


#pragma mark -------------打印相关---------------
//- (void)printData:(NSData *)data inVC:(UIViewController *)vc complete:(void(^)(NSError *error))completeBlock{
//    _printVC = vc;
//    if (data) {
//        [self writeData:data complete:^(CBCharacteristic *characteristic, NSError *error) {
//            if (completeBlock) {
//                completeBlock(error);
//            }
//        }];
//    }
//}











- (void)dealloc {

    
}




@end
