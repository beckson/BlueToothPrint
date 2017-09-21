//
//  OKSellerPrinter.h
//  OkdeerSeller
//
//  Created by 雷祥 on 2017/4/17.
//  Copyright © 2017年 Okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLPrinter.h"
//#import "OkProductDetailModel.h"
//#import "OkServiceDetailModel.h"

//商家打印小票
@interface OKSellerPrinter : HLPrinter

@property (nonatomic, copy) NSString *orderNo;    /**<  */
@property (nonatomic, copy) NSString *createTime; /**< 下单时间 */
@property (nonatomic, copy) NSString *address;      /**< 详细地址，模型中的area和address拼接 */
@property (nonatomic, copy) NSString *totalAmount;    /**<  */
@property (nonatomic, copy) NSString *preferentialPrice;
@property (nonatomic, copy) NSString *actualAmount;   /**<  */
@property (nonatomic, copy) NSString *mobile; /**< 电话 */
@property (nonatomic, copy) NSString *invoice;    /**< 有无发票(0:无,1:有) */
@property (nonatomic, copy) NSString *pickUpType; /**< (0:送货上门,1:到店自提) */
@property (nonatomic, copy) NSString *remark; /**< 备注 */
@property (nonatomic, copy) NSString *consigneeName;    /**< 收货人 */
@property (nonatomic, copy) NSString *head; /**< 发票抬头 */
@property (nonatomic, copy) NSString *payWay; /**< 支付方式:(0:在线支付、1:货到付款,2:未支付,3:线下支付,4:线下确认价格并当面支付) */
@property (nonatomic, copy) NSString *fare;     /**< 运费（配送费） */
@property (nonatomic, copy) NSString *orderBarcode; /**< 订单条形码 */
@property (nonatomic, copy) NSString *twoDimensionalCode;   /**< 二维码 */
@property (nonatomic, copy) NSString *goodsTotalAmount;     /**< 商品总金额 */

@property (nonatomic, strong) NSArray *tradeOrderItemVoList;
//优惠信息
@property (nonatomic, copy) NSString *platformPreferential; //平台补贴
@property (nonatomic, copy) NSString *realFarePreferential; //实际运费补贴
@property (nonatomic, copy) NSString *storePreferential;    //店铺补贴

///**
// * 通过productModel得到属性值
// */
//- (void)setDataWithProductModel:(OkProductDetailModel *)productModel;
//
///**
// * 通过serviceModel得到属性值
// */
//- (void)setDataWithServiceModel:(OkServiceDetailModel *)serviceModel;

@end
