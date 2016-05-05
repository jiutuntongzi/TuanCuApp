//
//  AllHeaderAdress.h
//  666Tuangou
//
//  Created by jifeng on 16/1/9.
//  Copyright © 2016年 shanghaijifeng. All rights reserved.
//

#ifndef AllHeaderAdress_h
#define AllHeaderAdress_h


/*
 
 首页数据获取:POST http://api.new0815.tuancu.com/api/index/get
 
 商品列表: POST http://api.new0815.tuancu.com/api/item/lists
 data={"cate_id":"","key":"miaosha","order":"ordid","order_by":"desc","page":1,"perPage":"10"}&token
 (sales, ordid, add_time)
 
 女装:{"cate_id":"1","key":"nvzhuang","order":"ordid","order_by":"desc","page":1,"perPage":"10"}&token
 男装:data={"cate_id":"2","key":"nanzhuang","order":"ordid","order_by":"desc","page":1,"perPage":"10"}&token
 母婴:data={"cate_id":"4","key":"muying","order":"ordid","order_by":"desc","page":1,"perPage":"10"}&token
 
 品牌: POST http://api.new0815.tuancu.com/api/item_brand/get_item_lists
 data={"brand_id":"1094"}
 刷新加上这个:data={"page":3,"perPage":"10","key":"index"}
 
 今日秒杀:  POST http://api.new0815.tuancu.com/api/item/miaosha
 */


/**首页数据*/

#define  KHOMEPAGE_URL @"http://api.new0815.tuancu.com/api/index/get"

/**
 *  限时热卖 更多数据
 */

#define KHOTSALES_URL @"http://api.new0815.tuancu.com/api/item/lists"


/**
 *  商品详情信息
 */

#define KDETAIL_URL(a)  [NSString stringWithFormat:@"http://www.tuancu.com/jump-%@.html",a]

/**
 *  品牌馆
 */
#define KBRANDS_URL @"http://api.new0815.tuancu.com/api/item_brand/get_item_lists"

/**
 *  分类
 */

#define KCATEGORY_URL @"http://api.new0815.tuancu.com/api/item_cate/lists_new"


/**
 *  品牌团 参数: data	{"page":1,"perPage":"10"}
 */

#define  KBRANDSTEAM_URL @"http://api.new0815.tuancu.com/api/item_brand/lists"


/*
 
 获取验证吗 POST http://api.new0815.tuancu.com/api/sms/send_verify_code
 data	{"tele":"13048936294"}
 注册
 POST http://api.new0815.tuancu.com/api/user/register
 data	{"password":"87D6B6F0E550B7F86226185FCAF8C832","tele":"13048936294"}

 登录
 POST http://api.new0815.tuancu.com/api/user/login
 data	{"password":"87D6B6F0E550B7F86226185FCAF8C832","tele":"13048936294"}


 POST http://api.new0815.tuancu.com/api/user/get 获取用户信息
 token	aGybaJhlYJOWZmRoYJ1kY5M=
 token	aGybaJhlYJOWZmRoYJ1kY5M=


 淘宝订单网页
 GET http://h5.m.taobao.com/awp/mtb/mtb.htm
 物流网页
 GET http://h5.m.taobao.com/awp/mtb/mtb.htm

 帮助网页
 GET http://h5.m.taobao.com/awp/mtb/mtb.htm

 意见反馈
 POST http://api.new0815.tuancu.com/api/user/feedback
 data	{"info":"çé¢ç®åï¼å®¹ææä½ï¼ç¨èµ·æ¥å¾ç½ï¼","title":"è¿ä¸éï¼ç»ä¸ªèµï¼"}
 token	aGybaJhlYJOWZmRoYJ1kY5M=


 签到
 GET http://www.tuancu.com/app/sign/?uid=289270&token=aGybaJhlYJOWZmRoYJ1kY5M=

 
 */


//获取验证码
#define KSMSSENDCODE_URL @"http://api.new0815.tuancu.com/api/sms/send_verify_code"

//注册
#define KREGISTER_URL @"http://api.new0815.tuancu.com/api/user/register"

//登录
#define KLOGIN_URL @"http://api.new0815.tuancu.com/api/user/login"

//获取用户信息 保存token
#define KUSERTOKEN_URL @"http://api.new0815.tuancu.com/api/user/get"

//淘宝订单接口
#define KTAOBAOORDER_URL @"http://h5.m.taobao.com/awp/mtb/mtb.htm"

//物流
#define KWULIU_URL @"http://h5.m.taobao.com/awp/mtb/mtb.htm"


//帮助
#define KHELP_URL @"http://h5.m.taobao.com/awp/mtb/mtb.htm"

//意见反馈

#define KREQUESTTAGET_URL @"http://api.new0815.tuancu.com/api/user/feedback"

//签到
#define KARRIIVER_URL @"http://www.tuancu.com/app/sign/?uid=289270&token=aGybaJhlYJOWZmRoYJ1kY5M="






#endif /* AllHeaderAdress_h */
