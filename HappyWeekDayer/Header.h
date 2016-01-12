//
//  Header.h
//  HappyWeekDayer
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#ifndef Header_h
#define Header_h
#import <Foundation/Foundation.h>
//http://blog.sina.com.cn/s/blog_aa7579f60102uxpg.html
//http://blog.csdn.net/zhangkongzhongyun/article/details/45824183
/**
 typedef enum : NSInteger{
 ClassifyTypeShowRepertorie = 1,           //= 演出剧目
 ClassifyTypeTouristPlace,                //= 景点场馆
 ClassifyTypeStudyPUZ,                   //= 学习益智
 ClassifyTypeFamilyTravel               //= 亲子旅游
 }ClassifyType;
 */
typedef NS_ENUM(NSInteger,ClassifyType){
    ClassifyTypeShowRepertorie = 1,           //= 演出剧目
    ClassifyTypeTouristPlace,                //= 景点场馆
    ClassifyTypeStudyPUZ,                   //= 学习益智
    ClassifyTypeFamilyTravel               //= 亲子旅游
};
//首页数据接口
#define kIndexDataList @"http://e.kumi.cn/app/v1.3/index.php?_s_=02a411494fa910f5177d82a6b0a63788&_t_=1451307342&channelid=appstore&cityid=1&lat=34.62172291944134&limit=30&lng=112.4149512442411&page=1"

//活动详情接口
#define kActicityDetail @"http://e.kumi.cn/app/articleinfo.php?_s_=6055add057b829033bb586a3e00c5e9a&_t_=1452071715&channelid=appstore&cityid=1&lat=34.61356779156581&lng=112.4141403843618"

//活动专题接口
#define kActicityTheme @"http://e.kumi.cn/app/positioninfo.php?_s_=1b2f0563dade7abdfdb4b7caa5b36110&_t_=1452218405&channelid=appstore&cityid=1&lat=34.61349052974207&limit=30&lng=112.4139739846577&page=1"
//=====================================================================
//精选活动接口
#define khuodong @"http://e.kumi.cn/app/articlelist.php?_s_=a9d09aa8b7692ebee5c8a123deacf775&_t_=1452236979&channelid=appstore&cityid=1&lat=34.61351314785497&limit=30&lng=112.4140755658942&type=1"

//热门专题接口
#define kzhuanti @"http://e.kumi.cn/app/positionlist.php?limit=10&lng=112.426761&page=1&lat=34.618815&channelid=huawei_ad&cityid=1"

//分类列表接口
#define kclass @"http://e.kumi.cn/app/v1.3/catelist.php?_s_=dad924a9b9cd534b53fc2c521e9f8e84&_t_=1452495193&channelid=appstore&cityid=1&lat=34.61356398594803&limit=30&lng=112.4140434532402"


#endif


//分类列表接口
/**
 http://e.kumi.cn/app/v1.3/catelist.php?_s_=dad924a9b9cd534b53fc2c521e9f8e84&_t_=1452495193&channelid=appstore&cityid=1&lat=34.61356398594803&limit=30&lng=112.4140434532402&page=1&typeid=6
 
 
 
 
 http://e.kumi.cn/app/v1.3/catelist.php?_s_=de59e1198abce565595b4f141a1515ea&_t_=1452495035&channelid=appstore&cityid=1&lat=34.61356398594803&limit=30&lng=112.4140434532402&page=1&typeid=23
 
 http://e.kumi.cn/app/v1.3/catelist.php?_s_=23525abd1e9cfbf2abdcc7c2449f582a&_t_=1452495137&channelid=appstore&cityid=1&lat=34.61356398594803&limit=30&lng=112.4140434532402&page=1&typeid=22
 
 http://e.kumi.cn/app/v1.3/catelist.php?_s_=78284130ab87a8396ec03073eac9c50a&_t_=1452495156&channelid=appstore&cityid=1&lat=34.61356398594803&limit=30&lng=112.4140434532402&page=1&typeid=21
 */


//精选活动接口
//http://e.kumi.cn/app/articlelist.php?_s_=a9d09aa8b7692ebee5c8a123deacf775&_t_=1452236979&channelid=appstore&cityid=1&lat=34.61351314785497&limit=30&lng=112.4140755658942&page=1&type=1

//热门专题接口
//http://e.kumi.cn/app/positionlist.php?_s_=e2b71c66789428d5385b06c178a88db2&_t_=1452237051&channelid=appstore&cityid=1&lat=34.61351314785497&limit=30&lng=112.4140755658942&page=1





















