//
//  OKSellerPrinter.m
//  OkdeerSeller
//
//  Created by 雷祥 on 2017/4/17.
//  Copyright © 2017年 Okdeer. All rights reserved.
//

#import "OKSellerPrinter.h"
#import "HLPrinter.h"
//#import "OKDataManager.h"
#import "OKPrinterHelp.h"
//#import "OkProductTradeItemVo.h"
//#import "NSObject+OKRuntime.h"
//#import "OkdeerCommDealData.h"


#define OKToString(x) (x.length) ? (x) : @""

@interface OKSellerPrinter ()
//@property (nonatomic,strong) OkProductDetailModel *productModel;    /**< 便利店订单详情 */
//@property (nonatomic,strong) OkServiceDetailModel *serviceModel;    /**< 服务店订单详情 */
@end

@implementation OKSellerPrinter


/**
 * 通过productModel得到属性值
 */
//- (void)setDataWithProductModel:(OkProductDetailModel *)productModel {
//    if ([self getFinalData].length) {
//        [self resetData];
//    }
//    _productModel = productModel;
//    if (productModel) {
//        self.orderNo = OKStringFromDic(productModel.orderNo) ;
//        self.createTime = OKStringFromDic(productModel.createTime) ;
//        self.totalAmount = OKStringFromDic(productModel.totalAmount) ;
//        self.preferentialPrice = OKStringFromDic(productModel.preferentialPrice) ;
//        self.actualAmount = OKStringFromDic(productModel.actualAmount) ;
//        self.mobile = OKStringFromDic(productModel.mobile) ;
//        self.invoice = OKStringFromDic(productModel.invoice) ;
//        self.pickUpType = OKStringFromDic(productModel.pickUpType) ;
//        self.remark = OKStringFromDic(productModel.remark) ;
//        self.consigneeName = OKStringFromDic(productModel.consigneeName) ;
//        self.head = OKStringFromDic(productModel.head) ;
//        self.orderBarcode = OKStringFromDic(productModel.orderBarcode) ;
//        self.address = [NSString stringWithFormat:@"%@%@",OKToString(productModel.area) ,OKToString(productModel.address)];
//        self.tradeOrderItemVoList = productModel.tradeOrderItemVoList;
//        self.twoDimensionalCode = OKStringFromDic(productModel.twoDimensionalCode);
//        self.fare = OKStringFromDic(productModel.fare);
//        self.payWay = OKStringFromDic(productModel.payWay);
//        self.goodsTotalAmount = OKStringFromDic(productModel.goodsTotalAmount);
//        self.platformPreferential = OKStringFromDic(productModel.platformPreferential);
//        self.realFarePreferential = OKStringFromDic(productModel.realFarePreferential);
//        self.storePreferential = OKStringFromDic(productModel.storePreferential);
//    }
//    else {
//        self.orderNo = @"";
//        self.createTime = @"";
//        self.totalAmount = @"";
//        self.preferentialPrice = @"";
//        self.actualAmount = @"";
//        self.mobile = @"";
//        self.invoice = @"";
//        self.pickUpType = @"";
//        self.remark = @"";
//        self.consigneeName = @"";
//        self.head = @"";
//        self.orderBarcode = @"";
//        self.tradeOrderItemVoList = nil;
//        self.fare = @"";
//        self.payWay = @"";
//        self.platformPreferential = @"";
//        self.realFarePreferential = @"";
//        self.storePreferential = @"";
//    }
//    if ([OKDataManager shareManager].appInfModel.printSellerSheet) {
//        [self setSellerData];
//        [self appendNewLine];
//        [self appendSeperatorLine];
//        [self appendNewLine];
//        [self setUserData];
//    }
//    else {
//        [self appendNewLine];
//        [self setUserData];
//    }
//}
//
///**
// * 通过serviceModel得到属性值
// */
//- (void)setDataWithServiceModel:(OkServiceDetailModel *)serviceModel {
//    if ([self getFinalData].length) {
//        [self resetData];
//    }
//    CCLog(@"写入数据开始====--");
//    _serviceModel = serviceModel;
//    if (serviceModel) {
//        self.orderNo = OKStringFromDic(serviceModel.orderNo) ;
//        self.createTime = OKStringFromDic(serviceModel.createTime) ;
//        self.totalAmount = OKStringFromDic(serviceModel.totalAmount) ;
//        self.preferentialPrice = OKStringFromDic(serviceModel.preferentialPrice) ;
//        self.actualAmount = OKStringFromDic(serviceModel.actualAmount) ;
//        self.mobile = OKStringFromDic(serviceModel.mobile) ;
//        self.invoice = OKStringFromDic(serviceModel.invoice) ;
//        self.pickUpType = OKStringFromDic(serviceModel.pickUpType) ;
//        self.remark = OKStringFromDic(serviceModel.remark) ;
//        self.consigneeName = OKStringFromDic(serviceModel.consigneeName) ;
//        self.head = OKStringFromDic(serviceModel.head) ;
//        self.orderBarcode = OKStringFromDic(serviceModel.orderBarcode) ;
//        self.address = [NSString stringWithFormat:@"%@%@",OKToString(serviceModel.area) ,OKToString(serviceModel.address)];
//        self.tradeOrderItemVoList = serviceModel.tradeOrderItemVoList;
//        self.twoDimensionalCode = OKStringFromDic(serviceModel.twoDimensionalCode) ;
//        self.fare = OKStringFromDic(serviceModel.fare);
//        self.payWay = OKStringFromDic(serviceModel.payWay);
//        self.goodsTotalAmount = OKStringFromDic(serviceModel.goodsTotalAmount);
//        self.platformPreferential = OKStringFromDic(serviceModel.platformPreferential);
//        self.realFarePreferential = OKStringFromDic(serviceModel.realFarePreferential);
//        self.storePreferential = OKStringFromDic(serviceModel.storePreferential);
//    }
//    else {
//        self.orderNo = @"";
//        self.createTime = @"";
//        self.totalAmount = @"";
//        self.preferentialPrice = @"";
//        self.actualAmount = @"";
//        self.mobile = @"";
//        self.invoice = @"";
//        self.pickUpType = @"";
//        self.remark = @"";
//        self.consigneeName = @"";
//        self.head = @"";
//        self.twoDimensionalCode = @"";
//        self.orderBarcode = @"";
//        self.tradeOrderItemVoList = nil;
//        self.fare = @"";
//        self.payWay = @"";
//        self.platformPreferential = @"";
//        self.realFarePreferential = @"";
//        self.storePreferential = @"";
//    }
//
//    if ([OKDataManager shareManager].appInfModel.printSellerSheet) {
//        [self setSellerData];
//        [self appendNewLine];
//        [self appendSeperatorLine];
//        [self appendNewLine];
//        [self setUserData];
//    }
//    else {
//        [self appendNewLine];
//        [self setUserData];
//    }
//}


/**
 * 将model数据转化为data
 */
- (void)setSellerData {
//    if ( _productModel || _serviceModel) {
        [self appendNewLine];
        [self appendText:@"拣货单(商家留存)" alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
        [self appendText:[self shopName] alignment:HLTextAlignmentCenter fontSize:(HLFontSizeTitleSmalle)];
        [self appendSeperatorLine];

        if (self.orderBarcode.length) {
            [self appendBarCodeWithInfo:self.orderBarcode];
            [self appendText:self.orderBarcode alignment:HLTextAlignmentCenter fontSize:(HLFontSizeTitleSmalle)];
            [self appendSeperatorLine];
        }
        if (self.consigneeName.length) {
            [self appendText:[NSString stringWithFormat:@"订购人姓名:%@",OKToString(self.consigneeName)] alignment:(HLTextAlignmentLeft) fontSize:(HLFontSizeTitleSmalle)];
        }
        if (self.mobile.length) {
            [self appendText:[NSString stringWithFormat:@"订购人电话:%@",OKToString(self.mobile)] alignment:(HLTextAlignmentLeft) fontSize:(HLFontSizeTitleSmalle)];
        }
        
        if (self.head.length) {
            [self appendText:[NSString stringWithFormat:@"发票信息:%@",self.head] alignment:(HLTextAlignmentLeft) fontSize:(HLFontSizeTitleSmalle)];
        }
        [self appendText:[NSString stringWithFormat:@"下单时间:%@",OKToString(self.createTime)] alignment:(HLTextAlignmentLeft) fontSize:(HLFontSizeTitleSmalle)];

        if (self.remark.length) {
            [self appendSeperatorLine];
            [self appendText:[NSString stringWithFormat:@"客户备注:%@",OKToString(self.remark)] alignment:(HLTextAlignmentLeft) fontSize:(HLFontSizeTitleSmalle)];
        }
        //每个商品的价格
        [self appendMoney];
        if (self.actualAmount.length) {
            [self appendText:[NSString stringWithFormat:@"实付金额:  ￥%@",self.actualAmount] alignment:(HLTextAlignmentLeft) fontSize:(HLFontSizeTitleBig)];
        }
        
        [self appendNewLine];
//    }
}

/**
 * 设置用户联数据
 */
- (void)setUserData {

    [self appendImage:[UIImage imageNamed:@"public_print_title"] alignment:(HLTextAlignmentCenter) maxWidth:450];
    [self appendNewLine];
    [self appendText:[self shopName] alignment:(HLTextAlignmentCenter) fontSize:(HLFontSizeTitleSmalle)];
    [self appendSeperatorLine];

    [self appendText:[NSString stringWithFormat:@"订单编号: %@",OKToString(_orderNo)] alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
//    NSString *payWay = [OkdeerCommDealData getPayMethod:_payWay payType:@""];
    NSString *payWay = @"0";
    if (![_payWay isEqualToString:@"0"]) {
        payWay = @"货到付款";
    }

    if (payWay.length) {
        [self appendText:[NSString stringWithFormat:@"支付方式: %@",OKToString(payWay)] alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    }

    if (_consigneeName.length) {
        [self appendText:[NSString stringWithFormat:@"客户姓名: %@",OKToString(_consigneeName)] alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    }

    if (_mobile.length) {
        [self appendText:[NSString stringWithFormat:@"客户电话: %@",OKToString(_mobile)] alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    }

    if (_address.length) {
        [self appendText:[NSString stringWithFormat:@"客户地址: %@",OKToString(_address)] alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    }

    [self appendMoney];
    NSString *shouldPay = @"";

    shouldPay = [NSString stringWithFormat:@"实付金额: ￥%@",self.actualAmount];

    if (![_payWay isEqualToString:@"0"]) {
        shouldPay = [NSString stringWithFormat:@"%@(未付款)",shouldPay];
    }

    if (self.actualAmount.length) {
        [self appendText:shouldPay alignment:(HLTextAlignmentLeft) fontSize:(HLFontSizeTitleSmalle)];
    }

    if (self.remark.length) {
        [self appendText:[NSString stringWithFormat:@"客户备注:%@",OKToString(self.remark)] alignment:(HLTextAlignmentLeft) fontSize:(HLFontSizeTitleSmalle)];
    }

    [self appendSeperatorLine];
//    [self appendText:@"好吃的便利店" alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleSmalle];

    if (self.twoDimensionalCode.length) {
        [self appendQRCodeWithInfo:self.twoDimensionalCode size:6 alignment:(HLTextAlignmentCenter)];
    }
    [self appendImage:[UIImage imageNamed:@"public_print_footer"] alignment:(HLTextAlignmentCenter) maxWidth:200];
    [self appendNewLine];
    [self appendNewLine];
    [self appendNewLine];
}


#pragma mark - 设置格式
- (void)appendName:(NSString *)name number:(NSString *)number price:(NSString *)price sum:(NSString *)sum
{
    [self setAlignment:HLTextAlignmentLeft];
    [self setFontSize:HLFontSizeTitleSmalle];
    NSInteger offset = 10;
    CGFloat text0Width = [self textWidthOfSamllText:name];
    [self setText:name];
    if (text0Width >= 100){
        [self appendNewLine];
    }

    if (number) {
        [self setOffset:100 + offset];
        [self setText:number];
    }

    if (price) {
        [self setOffset:200 + offset];
        [self setText:price];
    }

    if (sum) {
        [self setOffset:300 + offset];
        [self setText:sum];
    }
    [self appendNewLine];
}

- (void)appendMoney {
//    [self appendFullLine];
//    [self appendName:@"名称" number:@"数量" price:@"单价" sum:@"金额"];
//    [self appendSeperatorLine];
//    for (OkProductTradeItemVo *item in self.tradeOrderItemVoList) {
//        NSString *totalAmount = item.totalAmount;
//        if (!item.totalAmount.length) {
//            totalAmount = [NSString stringWithFormat:@"%0.2f",[item.quantity integerValue] * [item.unitPrice floatValue]];
//        }
//        [self appendName:item.skuName number:[NSString stringWithFormat:@"(x%@)",item.quantity] price:item.unitPrice sum:totalAmount];
//    }
//    [self appendFullLine];
//
//    [self appendText:[NSString stringWithFormat:@"商品金额:  ￥%@",self.goodsTotalAmount] alignment:(HLTextAlignmentLeft) fontSize:(HLFontSizeTitleSmalle)];
//
//
//    //添加优惠信息
//    if ([self.platformPreferential floatValue] > 0) {
//        [self appendText:[NSString stringWithFormat:@"平台优惠:  -￥%@",OKToString(self.platformPreferential)] alignment:(HLTextAlignmentLeft) fontSize:(HLFontSizeTitleSmalle)];
//    }
//
//    if ([self.storePreferential floatValue] > 0) {
//        [self appendText:[NSString stringWithFormat:@"店铺优惠:  -￥%@",OKToString(self.storePreferential)] alignment:(HLTextAlignmentLeft) fontSize:(HLFontSizeTitleSmalle)];
//    }
//
//    if ([self.realFarePreferential floatValue] > 0) {
//        [self appendText:[NSString stringWithFormat:@"运费优惠:  -￥%@",OKToString(self.realFarePreferential)] alignment:(HLTextAlignmentLeft) fontSize:(HLFontSizeTitleSmalle)];
//    }
//
//    if ([self.fare floatValue] > 0) {
//        [self appendText:[NSString stringWithFormat:@"运费金额:  ￥%@",OKToString(self.fare)] alignment:(HLTextAlignmentLeft) fontSize:(HLFontSizeTitleSmalle)];
//    }
}


#pragma mark - 获取数据信息
- (NSString *)shopName {
//    NSString *showName = [OKDataManager shareManager].storeInfoModel.storeName;
//    NSString *shopTypeName = [OKPrinterHelp shopTypeName];
//    if (shopTypeName.length) {
//        showName = [NSString stringWithFormat:@"%@(%@)",showName,shopTypeName];
//    }
//
//    return showName;
    return @"店铺名称";
}

/**
 * 计算小字体的大小
 */
- (CGFloat)textWidthOfSamllText:(NSString *)text {
    if (!text.length) {
        return 0.0;
    }

    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:22.0]};
    NSAttributedString *valueAttr = [[NSAttributedString alloc] initWithString:text attributes:dict];
    return valueAttr.size.width;
}


@end
