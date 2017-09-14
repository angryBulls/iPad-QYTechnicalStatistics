//
//  TSDBManager.m
//  QYTS
//
//  Created by lxd on 2017/7/21.
//  Copyright © 2017年 longcai. All rights reserved.
//

#import "TSDBManager.h"
#import "YTKKeyValueStore.h"

@interface TSDBManager ()
@property (nonatomic, strong) YTKKeyValueStore *store;
@property (nonatomic, strong) NSArray *playerIdArray;
@end

@implementation TSDBManager
- (instancetype)init {
    if (self = [super init]) {
        [self p_initDataBase];
    }
    
    return self;
}

- (void)p_initDataBase {
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:TSDBName];
    self.store = store;
}

- (void)saveOneResultDataWithDict:(NSDictionary *)resultDict saveDBStatusSuccessBlock:(SaveDBStatusSuccessBlock)saveDBStatusSuccessBlock saveDBStatusFailBlock:(SaveDBStatusFailBlock)saveDBStatusFailBlock {
    if (0 == resultDict.count) {
        return;
    }
    
    NSArray *restltArray = resultDict[@"ws"];
    if (0 == restltArray.count) {
        return;
    }
    
//    NSLog(@"result array is:%@", restltArray);
    NSMutableDictionary *insertDBDict = [NSMutableDictionary dictionary];
    [restltArray enumerateObjectsUsingBlock:^(NSDictionary *subDict, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *slotType = @"";
        
        if ([subDict[@"slot"] isEqualToString:BnfTeameType]) {
            slotType = BnfTeameType;
        } else if ([subDict[@"slot"] isEqualToString:BnfTenNumberType]) {
            slotType = BnfTenNumberType;
        } else if ([subDict[@"slot"] isEqualToString:BnfBitsNumberType]) {
            slotType = BnfBitsNumberType;
        } else if ([subDict[@"slot"] isEqualToString:BnfBehaviorType]) {
            slotType = BnfBehaviorType;
        } else if ([subDict[@"slot"] isEqualToString:BnfResultType]) {
            slotType = BnfResultType;
        }
        
        if (slotType.length) {
            insertDBDict[slotType] = subDict[@"cw"][0][@"id"];
        }
    }];
    
    NSLog(@"self.insertDBDict is:%@", insertDBDict);
    
    if (!insertDBDict[BnfTeameType]) { // 如果未识别主客队，则放弃存储
        saveDBStatusFailBlock(@"");
        return;
    }
    
#pragma mark - 保存暂停的数据
    if (0 == [insertDBDict[BnfBehaviorType] intValue]) { // 这是一条暂停数据
        [self p_updateDBByGameTabelKey:GameId insertDBDict:insertDBDict count:1];
        saveDBStatusSuccessBlock(insertDBDict);
        return;
    }
    
    if (!insertDBDict[BnfTenNumberType] && !insertDBDict[BnfBitsNumberType]) { // 如果未识别球员号码，则放弃存储
        saveDBStatusFailBlock(@"");
        return;
    }
    
    if (!insertDBDict[BnfBehaviorType] && !insertDBDict[BnfBehaviorType]) { // 如果没有球员行为，则放弃存储
        saveDBStatusFailBlock(@"");
        return;
    }
    
    if (1 == [insertDBDict[BnfBehaviorType] intValue] || 2 == [insertDBDict[BnfBehaviorType] intValue] || 3 == [insertDBDict[BnfBehaviorType] intValue]) { // 如果识别行为是罚篮、2分、3分则必须确认是否投中再存储
        if (!insertDBDict[BnfResultType]) {
            return;
        }
    }
    
    if (insertDBDict[BnfTenNumberType] && insertDBDict[BnfBitsNumberType]) {
        NSInteger tenNumb = [insertDBDict[BnfTenNumberType] integerValue];
        NSInteger bitNumb = [insertDBDict[BnfBitsNumberType] integerValue];
        insertDBDict[NumbResultStr] = [NSString stringWithFormat:@"%ld", tenNumb + bitNumb];
    } else if (insertDBDict[BnfTenNumberType] && !insertDBDict[BnfBitsNumberType]) {
        insertDBDict[NumbResultStr] = [NSString stringWithFormat:@"%ld", [insertDBDict[BnfTenNumberType] integerValue]];
    } else if (insertDBDict[BnfBitsNumberType] && !insertDBDict[BnfTenNumberType]) {
        insertDBDict[NumbResultStr] = [NSString stringWithFormat:@"%ld", [insertDBDict[BnfBitsNumberType] integerValue]];
    }
    
    // 拼接好球员号码后，删除没用号码的数据
    [insertDBDict removeObjectForKey:BnfTenNumberType];
    [insertDBDict removeObjectForKey:BnfBitsNumberType];
    
    NSString *playerId = [self p_getPlayerIdWithinsertDBDict:insertDBDict];
    if (0 == playerId.length) {
        NSLog(@"该球员id不存在数据库表中！！！！！！！！");
        return;
    }
    
    // 更新球员在场状态
    if ((11 == [insertDBDict[BnfBehaviorType] intValue]) || (12 == [insertDBDict[BnfBehaviorType] intValue])) { // 这是一条球员上场或下场的数据
        [self p_updateDBTeamCheckPlayingStatusWithInsertDBDict:insertDBDict];
        saveDBStatusSuccessBlock(insertDBDict);
        return;
    }
    
    saveDBStatusSuccessBlock(insertDBDict);
    [self p_insertObjectByInsertDBDict:insertDBDict playerId:playerId];
}

#pragma mark - 新增一条数据
- (void)p_insertObjectByInsertDBDict:(NSDictionary *)insertDBDict playerId:(NSString *)playerId {
    [self p_updateDBByPlayerTabelKey:playerId insertDBDict:insertDBDict count:1];
}

#pragma mark - 删除上一条
- (void)deleteObjectByInsertDBDict:(NSDictionary *)insertDBDict {
    if (0 == [insertDBDict[BnfBehaviorType] intValue]) { // 这是一条暂停数据，从gameTable表中删除
        [self p_updateDBByGameTabelKey:GameId insertDBDict:insertDBDict count:-1];
    } else if ((11 == [insertDBDict[BnfBehaviorType] intValue]) || (12 == [insertDBDict[BnfBehaviorType] intValue])) { // 这是一条球员上场或下场的数据
        [self p_updateDBTeamCheckPlayingStatusWithInsertDBDict:insertDBDict];
    } else { // 这是一条球员数据，从playerTable表中删除
        NSString *playerId = [self p_getPlayerIdWithinsertDBDict:insertDBDict];
        if (0 == playerId.length) {
            NSLog(@"该球员id不存在数据库表中！！！！！！！！");
            return;
        }
        [self p_updateDBByPlayerTabelKey:playerId insertDBDict:insertDBDict count:-1];
    }
}

#pragma mark - 根据识别结果新增或者删除数据库中的一条球员数据
- (void)p_updateDBByPlayerTabelKey:(NSString *)key insertDBDict:(NSDictionary *)insertDBDict count:(int)count {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *stageCount = [self.store getObjectById:GameId fromTable:GameTable][CurrentStage];
        
        // 先从数据库中取出该球员之前保存的所有数据
        NSLog(@"search player data is:%@", [self.store getObjectById:key fromTable:PlayerTable]);
        NSMutableDictionary *queryPlayerDict = [[self.store getObjectById:key fromTable:PlayerTable] mutableCopy];
        NSMutableDictionary *newQueryPlayerDict = [NSMutableDictionary dictionary];
        if (queryPlayerDict.count) {
            newQueryPlayerDict = [NSMutableDictionary dictionaryWithDictionary:[queryPlayerDict[stageCount] mutableCopy]];
        } else {
            queryPlayerDict = [NSMutableDictionary dictionary];
        }
        
        // 根据当前识别的结果数据，更新原有数据库中的数据
        NSArray *playerStatisticsArray = PlayerStatisticsArray;
        [playerStatisticsArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[obj stringByReplacingOccurrencesOfString:BehaviorNumb withString:@""] isEqualToString:[NSString stringWithFormat:@"%@", insertDBDict[BnfBehaviorType]]]) {
                newQueryPlayerDict[obj] = [NSString stringWithFormat:@"%ld", [newQueryPlayerDict[obj] integerValue] + count];
                
                if ([obj isEqualToString:FreeThrow]) { // 如果是罚篮
                    if (1 == [insertDBDict[BnfResultType] intValue]) { // 命中数+1
                        newQueryPlayerDict[FreeThrowHit] = [NSString stringWithFormat:@"%ld", [newQueryPlayerDict[FreeThrowHit] integerValue] + count];
                    }
                } else if ([obj isEqualToString:TwoPoints]) { // 如果是2分
                    if (1 == [insertDBDict[BnfResultType] intValue]) { // 命中数+1
                        newQueryPlayerDict[TwoPointsHit] = [NSString stringWithFormat:@"%ld", [newQueryPlayerDict[TwoPointsHit] integerValue] + count];
                    }
                } else if ([obj isEqualToString:ThreePoints]) { // 如果是3分
                    if (1 == [insertDBDict[BnfResultType] intValue]) { // 命中数+1
                        newQueryPlayerDict[ThreePointsHit] = [NSString stringWithFormat:@"%ld", [newQueryPlayerDict[ThreePointsHit] integerValue] + count];
                    }
                }
            }
        }];
        
        // 将统计好的数据，按节保存
        queryPlayerDict[stageCount] = newQueryPlayerDict;
        queryPlayerDict[PlayerId] = key;
        
        [self.store putObject:queryPlayerDict withId:key intoTable:PlayerTable];
        NSLog(@"queryPlayerDict after inser one data is:%@", queryPlayerDict);
    });
}

#pragma mark - 根据识别结果新增或者删除数据库中的一条比赛数据
- (void)p_updateDBByGameTabelKey:(NSString *)key insertDBDict:(NSDictionary *)insertDBDict count:(int)count {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *stageCount = [self.store getObjectById:GameId fromTable:GameTable][CurrentStage];
        
        // 先从数据库中取出该球员之前保存的所有数据
        NSDictionary *queryGameDict = [[self.store getObjectById:key fromTable:GameTable] mutableCopy];
        NSMutableDictionary *newQuerygameDict = [NSMutableDictionary dictionary];
        if (queryGameDict.count) {
            newQuerygameDict = [NSMutableDictionary dictionaryWithDictionary:queryGameDict];
        }
        
        NSLog(@"search game table is:%@", newQuerygameDict);
        
        if (!newQuerygameDict[stageCount]) { // 如果没有保存过本节的暂停数据
            // 创建主队和客队的暂停字典数据
            NSMutableDictionary *behaviorHDict = [NSMutableDictionary dictionary];
            NSMutableDictionary *behaviorGDict = [NSMutableDictionary dictionary];
            if (0 == [insertDBDict[BnfTeameType] intValue]) {
                [behaviorHDict setObject:@"1" forKey:[NSString stringWithFormat:@"%@", Timeout]];
                [behaviorGDict setObject:@"0" forKey:[NSString stringWithFormat:@"%@", Timeout]];
            } else {
                [behaviorHDict setObject:@"0" forKey:[NSString stringWithFormat:@"%@", Timeout]];
                [behaviorGDict setObject:@"1" forKey:[NSString stringWithFormat:@"%@", Timeout]];
            }
            
            NSMutableDictionary *hostDict = [NSMutableDictionary dictionary];
            [hostDict setObject:behaviorHDict forKey:@"0"];
            
            NSMutableDictionary *guestDict = [NSMutableDictionary dictionary];
            [guestDict setObject:behaviorGDict forKey:@"1"];
            
            NSMutableDictionary *stageDict = [NSMutableDictionary dictionary];
            [stageDict addEntriesFromDictionary:hostDict];
            [stageDict addEntriesFromDictionary:guestDict];
            
            [newQuerygameDict setObject:stageDict forKey:stageCount];
//            NSLog(@"newQuerygameDict is:%@", newQuerygameDict);
        } else { // 如果已经保存过本节的暂停数据
            // 将不可变字典转换为可变字典
            NSMutableDictionary *currentStageDict = [NSMutableDictionary dictionary];
            [newQuerygameDict[stageCount] enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *obj, BOOL * _Nonnull stop) {
                NSMutableDictionary *subDict = [obj mutableCopy];
                [currentStageDict setObject:subDict forKey:key];
            }];
            newQuerygameDict[stageCount] = (NSMutableDictionary *)currentStageDict;
            
            NSString *currentTimeOut = currentStageDict[[NSString stringWithFormat:@"%@", insertDBDict[BnfTeameType]]][Timeout];
            currentStageDict[[NSString stringWithFormat:@"%@", insertDBDict[BnfTeameType]]][Timeout] = [NSString stringWithFormat:@"%d", [currentTimeOut intValue] + count];

        }
        
        [self.store putObject:newQuerygameDict withId:key intoTable:GameTable];
        NSLog(@"newQuerygameDict after inser one data is:%@", newQuerygameDict);
    });
}

#pragma mark - 更新检录数据库表中球员在场的状态
- (void)p_updateDBTeamCheckPlayingStatusWithInsertDBDict:(NSDictionary *)insertDBDict {
    NSString *TeamCheckID = TeamCheckID_H;
    NSMutableArray *playerCheckArray = [NSMutableArray array];
    if (0 == [insertDBDict[BnfTeameType] intValue]) { // 更新主队球员在场状态
        playerCheckArray = [[self.store getObjectById:TeamCheckID fromTable:TSCheckTable] mutableCopy];
    } else { // 更新客队球员在场状态
        TeamCheckID = TeamCheckID_G;
        playerCheckArray = [[self.store getObjectById:TeamCheckID fromTable:TSCheckTable] mutableCopy];
    }
    
    NSMutableArray *newPlayerCheckArray = [NSMutableArray array];
    [playerCheckArray enumerateObjectsUsingBlock:^(NSDictionary *subDict, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *newDict = [subDict mutableCopy];
        [newPlayerCheckArray addObject:newDict];
    }];
    
    [newPlayerCheckArray enumerateObjectsUsingBlock:^(NSMutableDictionary *subDict, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([subDict[@"gameNum"] intValue] == [insertDBDict[NumbResultStr] intValue]) {
            BOOL playingStatus = [subDict[@"playingStatus"] intValue];
            subDict[@"playingStatus"] = [NSString stringWithFormat:@"%d", !playingStatus];
        }
    }];
    
    [self.store putObject:newPlayerCheckArray withId:TeamCheckID intoTable:TSCheckTable];
}

#pragma mark - 更新一次所有球员的上场时间
- (void)udatePlayingTimesOnce {
    // 异步执行
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSMutableArray *playerCheckArrayH = [[self.store getObjectById:TeamCheckID_H fromTable:TSCheckTable] mutableCopy];
        NSMutableArray *newPlayerCheckArrayH = [NSMutableArray array];
        [playerCheckArrayH enumerateObjectsUsingBlock:^(NSDictionary *subDict, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *newDict = [subDict mutableCopy];
            if (1 == [newDict[@"playingStatus"] intValue]) { // 如果该球员在场，则增加该球员的上场时间
                newDict[@"playingTimes"] = [NSString stringWithFormat:@"%d", [newDict[@"playingTimes"] intValue] + 30];
            }
            [newPlayerCheckArrayH addObject:newDict];
        }];
        [self.store putObject:newPlayerCheckArrayH withId:TeamCheckID_H intoTable:TSCheckTable];
        
        NSMutableArray *playerCheckArrayG = [[self.store getObjectById:TeamCheckID_G fromTable:TSCheckTable] mutableCopy];
        NSMutableArray *newPlayerCheckArrayG = [NSMutableArray array];
        [playerCheckArrayG enumerateObjectsUsingBlock:^(NSDictionary *subDict, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *newDict = [subDict mutableCopy];
            if (1 == [newDict[@"playingStatus"] intValue]) { // 如果该球员在场，则增加该球员的上场时间
                newDict[@"playingTimes"] = [NSString stringWithFormat:@"%d", [newDict[@"playingTimes"] intValue] + 30];
            }
            [newPlayerCheckArrayG addObject:newDict];
        }];
        [self.store putObject:newPlayerCheckArrayG withId:TeamCheckID_G intoTable:TSCheckTable];
    });
}

 // 每节数据提交完成后，初始化球员的上场时间
- (void)initPlayingTimesOnce {
    NSMutableArray *playerCheckArrayH = [[self.store getObjectById:TeamCheckID_H fromTable:TSCheckTable] mutableCopy];
    NSMutableArray *newPlayerCheckArrayH = [NSMutableArray array];
    [playerCheckArrayH enumerateObjectsUsingBlock:^(NSDictionary *subDict, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *newDict = [subDict mutableCopy];
        newDict[@"playingTimes"] = @"0";
        [newPlayerCheckArrayH addObject:newDict];
    }];
    [self.store putObject:newPlayerCheckArrayH withId:TeamCheckID_H intoTable:TSCheckTable];
    
    NSMutableArray *playerCheckArrayG = [[self.store getObjectById:TeamCheckID_G fromTable:TSCheckTable] mutableCopy];
    NSMutableArray *newPlayerCheckArrayG = [NSMutableArray array];
    [playerCheckArrayG enumerateObjectsUsingBlock:^(NSDictionary *subDict, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *newDict = [subDict mutableCopy];
        newDict[@"playingTimes"] = @"0";
        [newPlayerCheckArrayG addObject:newDict];
    }];
    [self.store putObject:newPlayerCheckArrayG withId:TeamCheckID_G intoTable:TSCheckTable];
}

- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName {
    return [self.store getObjectById:objectId fromTable:tableName];
}

- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName {
    [self.store putObject:object withId:objectId intoTable:tableName];
}

 // 修改一条球员数据（包括：罚球、2分和3分命中数）
- (void)updateDBPlayerTabelByPlayerId:(NSString *)playerId dataType:(NSString *)dataType newValue:(NSString *)newValue successReturnBlock:(UpdatePalyerTableSuccessBlock)successReturnBlock {
    NSString *stageCount = [self.store getObjectById:GameId fromTable:GameTable][CurrentStage];
    
    // 先从数据库中取出该球员之前保存的所有数据
    NSLog(@"search current player data is:%@", [self.store getObjectById:playerId fromTable:PlayerTable]);
    // 取出该球员的所有数据，转换为可变字典，等待修改
    NSMutableDictionary *queryPlayerDict = [[self.store getObjectById:playerId fromTable:PlayerTable] mutableCopy];
    
    // 取出该球员当前节需要修改的字典数据，并转换成可变字典
    NSMutableDictionary *stagePlayerDict = [queryPlayerDict[stageCount] mutableCopy];
    stagePlayerDict[dataType] = newValue;
    // 修改成功后，更新该球员的数据库表
    queryPlayerDict[stageCount] = stagePlayerDict;
    
    // 该球员数据修改成功，更新到数据库中
    [self.store putObject:queryPlayerDict withId:playerId intoTable:PlayerTable];
    NSLog(@"修改球员数据后的数据为:%@", queryPlayerDict);
    successReturnBlock ? successReturnBlock() : nil;
}

#pragma mark - tools method ****************************************************************
- (NSString *)p_getPlayerIdWithinsertDBDict:(NSDictionary *)insertDBDict { // 根据GameId、主客队类型和球员号码获取本条语音统计数据的playerId
    NSString *playerIdKey = [NSString stringWithFormat:@"%@+%@", insertDBDict[BnfTeameType], insertDBDict[NumbResultStr]];
    self.playerIdArray = [self.store getObjectById:GameId fromTable:PlayerIdTable];
    
    __block NSString *playerId = @"";
    [self.playerIdArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj allKeys][0] isEqualToString:playerIdKey]) {
            playerId = [obj allValues][0];
        }
    }];
    
    return playerId;
}

- (NSMutableArray *)getAllHostTeamPlayerData {
    // 获取所有主队球员id列表
    NSArray *playerArrayH = [self.store getObjectById:TeamCheckID_H fromTable:TSCheckTable];
    NSMutableArray *hostTeamPlayerIdArray = [NSMutableArray array];
    [playerArrayH enumerateObjectsUsingBlock:^(NSDictionary *playerInfoDict, NSUInteger idx, BOOL * _Nonnull stop) {
        [hostTeamPlayerIdArray addObject:playerInfoDict[@"id"]];
    }];
    
    NSMutableArray *allHostPlayerDataArray = [NSMutableArray array];
    [hostTeamPlayerIdArray enumerateObjectsUsingBlock:^(NSString *playerId, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *playerDataDict = [self.store getObjectById:playerId fromTable:PlayerTable];
        if (playerDataDict.count) {
            [allHostPlayerDataArray addObject:playerDataDict];
        }
    }];
    
//    NSLog(@"所有主队球员的统计数据为:%@", allHostPlayerDataArray);
    return allHostPlayerDataArray;
}

- (NSMutableArray *)getAllGuestTeamPlayerData {
    // 获取所有客队球员id列表
    NSArray *playerArrayG = [self.store getObjectById:TeamCheckID_G fromTable:TSCheckTable];
    NSMutableArray *guestTeamPlayerIdArray = [NSMutableArray array];
    [playerArrayG enumerateObjectsUsingBlock:^(NSDictionary *playerInfoDict, NSUInteger idx, BOOL * _Nonnull stop) {
        [guestTeamPlayerIdArray addObject:playerInfoDict[@"id"]];
    }];
    
    NSMutableArray *allGuestPlayerDataArray = [NSMutableArray array];
    [guestTeamPlayerIdArray enumerateObjectsUsingBlock:^(NSString *playerId, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *playerDataDict = [self.store getObjectById:playerId fromTable:PlayerTable];
        if (playerDataDict.count) {
            [allGuestPlayerDataArray addObject:playerDataDict];
        }
    }];
    
//    NSLog(@"所有客队球员的统计数据为:%@", allGuestPlayerDataArray);
    return allGuestPlayerDataArray;
}
@end
