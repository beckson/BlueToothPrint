//
//  OKBLEManager.h
//  OkdeerSeller
//
//  Created by 雷祥 on 2017/4/14.
//  Copyright © 2017年 Okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef NS_ENUM(NSInteger,OKPrintError) {
    OKPrintErrorUnknow          = 0,
    OKPrintErrorNodata          = 1,
    OKPrintErrorUnConnected     = 2,
    OKPrintErrorNoService       = 3,
    OKPrintErrorNoCharacteristic= 4
};

typedef void(^ScanPeripheralBlock)(NSArray <CBPeripheral *>*peripherals);

@interface OKBLEManager : NSObject
@property (nonatomic, strong, readonly) CBPeripheral *connectedPer; /**< 连接的外设 */

/**
 * 获取单例实例
 */
+ (instancetype)shareInstace;

/**
 * 为了解决提示信息问题（iOS10无法直接跳设置界面），在蓝牙断开情况下，重新初始化中心设备
 */
- (void)recreatCenteral ;

/**
 * 清除缓存的设备
 */
- (void)clearDevices;

#pragma mark - 蓝牙相关
/**
 * 搜索外设
 */
- (void)scanForPeripheralWithCompleteBlock:(ScanPeripheralBlock)completeBlock;

/**
 * 连接(连接前内部做了断开之前的连接)
 */
- (void)connectPeripheral:(CBPeripheral *)peripheral complete:(void (^)(CBPeripheral *peripheral))completeBlock;

/**
 * 写入数据，不一定会有completeBlock的回调
 */
- (void)writeData:(NSData *)data complete:(void(^)(CBCharacteristic *characteristic, NSError *error))completeBlock;

/**
 * 断开连接
 */
- (void)disConnectPeripheral;

/**
 * 停止扫描外设
 */
- (void)stopScanPeripheral;

#pragma mark - 打印相关

///**
// * 注释，不一定会有回调
// */
//- (void)printData:(NSData *)data inVC:(UIViewController *)vc complete:(void(^)(NSError *error))completeBlock;


@end
