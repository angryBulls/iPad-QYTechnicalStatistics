//
//  TSSpeechRecognizer.m
//  QYTS
//
//  Created by lxd on 2017/7/20.
//  Copyright © 2017年 longcai. All rights reserved.
//

#import "TSSpeechRecognizer.h"
#import "TSDBManager.h"

// ifly class
//#import "iflyMSC/IFlySpeechRecognizer.h"
//#import "iflyMSC/IFlySpeechConstant.h"
//#import "iflyMSC/IFlySpeechUtility.h"// add host player number view#import "iflyMSC/IFlyResourceUtil.h"
//#import "iflyMSC/IFlySpeechError.h"
//#import "RecognizerFactory.h"
//#import "iflyMSC/IFlyDataUploader.h"
//#import "ISRDataHelper.h"

#define GRAMMAR_TYPE_BNF @"bnf"

@interface TSSpeechRecognizer ()
@property (nonatomic, strong) TSDBManager *dbManager;

// ifly properties
//语法识别对象
//@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
//@property (nonatomic, copy) NSString *engineType; //引擎类型
//@property (nonatomic, copy)  NSString *grammarType; //语法类型
//@property (nonatomic, copy) NSString *localgrammerId; //本地识别生成的grammarID
//@property (nonatomic, strong) IFlyDataUploader *uploader;
//@property (nonatomic, strong) NSMutableString *curResult; //当前session的结果
//@property (nonatomic) BOOL isCanceled;
@end

@implementation TSSpeechRecognizer
- (TSDBManager *)dbManager {
    if (!_dbManager) {
        _dbManager = [[TSDBManager alloc] init];
    }
    return _dbManager;
}

- (instancetype)init {
    if (self = [super init]) {
        [self p_setupSpeechRecognizer];
    }
    
    return self;
}

- (void)p_setupSpeechRecognizer {
    [self p_setupIfly];
    
    [self p_buildIflyGrammer];
}

/**
 * @fn      onVolumeChanged
 * @brief   音量变化回调
 *
 * @param   volume      -[in] 录音的音量，音量范围1~100
 * @
 */
//- (void)onVolumeChanged:(int)volume {
////    NSString *currentVolume = [NSString stringWithFormat:@"音量：%d",volume];
//    if ([self.delegate respondsToSelector:@selector(onVolumeChanged:)]) {
//        [self.delegate onVolumeChanged:volume];
//    }
//}

/**
 * @fn      onBeginOfSpeech
 * @brief   开始识别回调
 */
//- (void)onBeginOfSpeech {
//    NSLog(@"正在录音");
//}

/**
 * @fn      onEndOfSpeech
 * @brief   停止录音回调
 */
//- (void)onEndOfSpeech {
//    NSLog(@"停止录音");
//    if ([self.delegate respondsToSelector:@selector(onEndOfSpeech)]) {
//        [self.delegate onEndOfSpeech];
//    }
//}

/**
 * @fn      onError
 * @brief   识别结束回调
 *
 * @param   error   -[out] 错误类，具体用法见IFlySpeechError
 */
//- (void)onError:(IFlySpeechError *)error {
//    NSLog(@"error=%d",[error errorCode]);
//    
//    NSString *text ;
//    if (self.isCanceled) {
//        text = @"识别取消";
//    } else if (error.errorCode == 0 ) {
//        if (self.curResult.length==0 || [self.curResult hasPrefix:@"nomatch"]) {
//            text = @"无匹配结果";
//        } else {
//            text = @"识别成功";
//        }
//    } else {
//        text = [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
//    }
//    
//    NSLog(@"%@",text);
//}

/**
 * @fn      onResults
 * @brief   识别结果回调
 *
 * @param   results      -[out] 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，value为置信度
 */
- (void)onResults:(NSArray *)results isLast:(BOOL)isLast {
    NSMutableString *result = [[NSMutableString alloc] init];
//    NSMutableString * resultString = [[NSMutableString alloc]init];
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
//        if([self.engineType isEqualToString:[IFlySpeechConstant TYPE_LOCAL]]) {
//            NSString * resultFromJson =  [ISRDataHelper stringFromJson:result];
//            [resultString appendString:resultFromJson];
//        } else {
//            NSString * resultFromJson =  [ISRDataHelper stringFromABNFJson:result];
//            [resultString appendString:resultFromJson];
//        }
    }
    
    if (isLast) {

    }
//    [self.curResult appendString:resultString];
    
    // 保存当前识别结果
    NSDictionary *resultDict = [TSToolsMethod dictionaryWithJsonString:[dic allKeys][0]];
    
    [self.dbManager saveOneResultDataWithDict:resultDict saveDBStatusSuccessBlock:^(NSDictionary *insertDBDict) {
        if ([self.delegate respondsToSelector:@selector(onResultsString:insertDBDict:)]) {
//            NSString *returnString = self.curResult;

            if (0 == [insertDBDict[BnfBehaviorType] intValue]) { // 如果这是一条暂停数据，则过滤掉“号”这个文字
//                returnString = [returnString stringByReplacingOccurrencesOfString:@"号" withString:@""];
            }
            
            if ([insertDBDict[NumbResultStr] length]) { // 如果识别结果中有号码
                int playerNumb = [insertDBDict[NumbResultStr] intValue];
                if (playerNumb <= 10) {
//                    returnString = [returnString stringByReplacingCharactersInRange:NSMakeRange(2, 1) withString:insertDBDict[NumbResultStr]];
                } else if (playerNumb > 10 && playerNumb < 20) {
//                    returnString = [returnString stringByReplacingCharactersInRange:NSMakeRange(2, 2) withString:insertDBDict[NumbResultStr]];
                } else if (0 == playerNumb%10) {
//                    returnString = [returnString stringByReplacingCharactersInRange:NSMakeRange(2, 2) withString:insertDBDict[NumbResultStr]];
                } else {
//                    returnString = [returnString stringByReplacingCharactersInRange:NSMakeRange(2, 3) withString:insertDBDict[NumbResultStr]];
                }
            }
#pragma mark 回调到controller
            
            [self.delegate onResultsString:nil insertDBDict:insertDBDict];
        }
    } saveDBStatusFailBlock:^(NSString *error) {
        
    }];
}

/**
 * @fn      onCancal
 * @brief   取消识别回调
 *
 */
- (void)onCancel {
    NSLog(@"正在取消");
}

#pragma mark - ifly set up method
- (void)p_setupIfly {
//    self.iFlySpeechRecognizer = [RecognizerFactory CreateRecognizer:self Domain:@"asr"];
//    [self.iFlySpeechRecognizer setParameter:@"1" forKey:@"asr_wbest"];
//    self.isCanceled = NO;
//    self.curResult = [[NSMutableString alloc] init];
//    self.engineType = [IFlySpeechConstant TYPE_LOCAL];
//    self.grammarType = GRAMMAR_TYPE_BNF;
//    self.localgrammerId = nil;
//    self.uploader = [[IFlyDataUploader alloc] init];
//    [self p_buildIflyGrammer];
}

- (void)p_buildIflyGrammer {
//    NSString *grammarContent = nil;
//    NSString *documentsPath = nil;
//    NSArray *appArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    if ([appArray count] > 0) {
//        documentsPath = [appArray objectAtIndex:0];
//    }
//    NSString *appPath = [[NSBundle mainBundle] resourcePath];
//    [TSToolsMethod createDirec:@"grm"];
//    
//    if([self.engineType isEqualToString: [IFlySpeechConstant TYPE_LOCAL]])
//    {
//        //grammar build path
//        NSString *grammBuildPath = [documentsPath stringByAppendingString:@"/grm"];
//        
//        //aitalk resource path
//        NSString *aitalkResourcePath = [[NSString alloc] initWithFormat:@"fo|%@/aitalkResource/common.mp3",appPath];
//        
//        //bnf resource
//        NSString *bnfFilePath = [[NSString alloc] initWithFormat:@"%@/bnf/5V5Basketball.bnf",appPath];
//        
//        NSDictionary *gameTableDict = [self.dbManager getObjectById:GameId fromTable:GameTable];
////        if (2 == [gameTableDict[@"ruleType"] intValue]) { // 3V3 加载的bnf
////            bnfFilePath = [[NSString alloc] initWithFormat:@"%@/bnf/3V3Basketball.bnf",appPath];
////        }
//        
//        grammarContent = [TSToolsMethod readFile:bnfFilePath];
//        
//        [[IFlySpeechUtility getUtility] setParameter:@"asr" forKey:[IFlyResourceUtil ENGINE_START]];
//        
//        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
//        [_iFlySpeechRecognizer setParameter:@"utf-8" forKey:[IFlySpeechConstant TEXT_ENCODING]];
//        [_iFlySpeechRecognizer setParameter:self.engineType forKey:[IFlySpeechConstant ENGINE_TYPE]];
//        
//        [_iFlySpeechRecognizer setParameter:grammBuildPath forKey:[IFlyResourceUtil GRM_BUILD_PATH]];
//        
//        [_iFlySpeechRecognizer setParameter:aitalkResourcePath forKey:[IFlyResourceUtil ASR_RES_PATH]];
//        [self.iFlySpeechRecognizer setParameter:@"asr" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
//        [_iFlySpeechRecognizer setParameter:@"utf-8" forKey:@"result_encoding"];
//        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
//    }
//    
//    //开始构建
//    [_iFlySpeechRecognizer buildGrammarCompletionHandler:^(NSString *grammerID, IFlySpeechError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (![error errorCode]) {
//                NSLog(@"上传成功");
//            } else {
//                NSLog(@"上传失败");
//                NSLog(@"errorCode=%d",[error errorCode]);
//            }
//            
//            if ([self.engineType isEqualToString: [IFlySpeechConstant TYPE_LOCAL]]) {
//                _localgrammerId = grammerID;
//                [_iFlySpeechRecognizer setParameter:_localgrammerId  forKey:[IFlySpeechConstant LOCAL_GRAMMAR]];
//            }
//        });
//    } grammarType:self.grammarType grammarContent:grammarContent];
}

#pragma mark - return method ************************************************************************
//- (void)startListening {
//    BOOL ret = [IFlySpeechRecognizer.sharedInstance startListening];
//    if (ret) {
//        NSLog(@"识别开启成功");
//        [self.curResult setString:@""];
//    } else {
//        NSLog(@"启动识别服务失败，请稍后重试");//可能是上次请求未结束
//    }
//}
//- (void)stopListening {
//    [IFlySpeechRecognizer.sharedInstance stopListening];
//}
//- (void)cancel {
//    [IFlySpeechRecognizer.sharedInstance cancel];
//}
@end
