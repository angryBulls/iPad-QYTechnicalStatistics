#import <Foundation/Foundation.h>

typedef void (^SaveDBStatusSuccessBlock)(NSDictionary *insertDBDict);
typedef void (^SaveDBStatusFailBlock)(NSString *error);
typedef void (^UpdatePalyerTableSuccessBlock)();

@interface TSDBManager : NSObject
- (void)saveOneResultDataWithDict:(NSDictionary *)resultDict saveDBStatusSuccessBlock:(SaveDBStatusSuccessBlock)saveDBStatusSuccessBlock saveDBStatusFailBlock:(SaveDBStatusFailBlock)saveDBStatusFailBlock;
- (void)deleteObjectByInsertDBDict:(NSDictionary *)insertDBDict;
- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;

// 修改一条球员数据（包括：罚球、2分和3分命中数）
- (void)updateDBPlayerTabelByPlayerId:(NSString *)playerId dataType:(NSString *)dataType newValue:(NSString *)newValue successReturnBlock:(UpdatePalyerTableSuccessBlock)successReturnBlock;

// 更新一次所有球员的上场时间
- (void)udatePlayingTimesOnce;

// 初始化一次球员的上场时间
- (void)initPlayingTimesOnce;

- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName; // 保存数据
- (NSMutableArray *)getAllHostTeamPlayerData; // 获取所有主队球员的数据
- (NSMutableArray *)getAllGuestTeamPlayerData; // 获取所有客队球员的数据



@end
