//
//  RYNetWorkHelper.m
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import "RYNetWorkHelper.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "HeaderModel.h"
#import "RYConstants.h"
#import "RYKitHear.h"
//#import "AES/AESCipher.h"
//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])

@implementation RYNetworkHelper : NSObject
static BOOL _isOpenAES;   // 是否已开启加密传输
static NSMutableArray *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;
//static NSMutableDictionary *_params;

#pragma mark - 开始监听网络
+(void)networkStatusWithBlock:(RYNetworkStatus)networkStatus {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(RYNetworkStatusUnknown) : nil;
                    RYLog(@"未知网络");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(RYNetworkStatusNotReachable) : nil;
                    RYLog(@"无网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(RYNetworkStatusReachableViaWWAN) : nil;
                    RYLog(@"手机自带网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(RYNetworkStatusReachableViaWiFi) : nil;
                    RYLog(@"WIFI");
                    break;
            }
        }];
    });
}

+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

+ (void)openAES {
    _isOpenAES = YES;
    [_sessionManager.requestSerializer setValue:@"text/encode" forHTTPHeaderField:@"Content-Type"];
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

+ (void)closeAES {
    _isOpenAES = NO;
    [_sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
}

#pragma mark - ——————— 加密 Header ————————
+(void)encodeHeader{
   // NSString *contentStr = [[HeaderModel new] mj_JSONString];
    NSString *contentStr = [[NSString alloc] init];
    [_sessionManager.requestSerializer setValue:contentStr forHTTPHeaderField:@"App-Common-Params"];
}

//#pragma mark - ——————— 加密 header 和 Body ————————
//+(void)encodeParameters:(id)param{
//    //加密 Header
//    [self encodeHeader];
//    //参数不为空 且 已经开启加密
//    if (ValidDict(param) && _isOpenAES) {
//        [_sessionManager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
//            NSString *contentStr = [parameters jsonStringEncoded];
//            NSString *AESStr = aesEncrypt(contentStr);
//            return AESStr;
//        }];
//    }
//}

#pragma mark - GET请求
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                  success:(RYHttpRequestSuccess)success
                  failure:(RYHttpRequestFailed)failure {
    NSURLSessionTask *sessionTask = [_sessionManager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        RYLog(@"responseObject = %@",[self jsonToString:responseObject]);
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        RYLog(@"error = %@",error);
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - POST请求
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(RYHttpRequestSuccess)success
                   failure:(RYHttpRequestFailed)failure {
    //加密header
    [self encodeHeader];
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL
                                               parameters:parameters
                                                 progress:^(NSProgress * _Nonnull uploadProgress) {
                                                     
                                                 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                     NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                                                     NSDictionary *allHeaders = response.allHeaderFields;
                                                     RYLog(@"请求头header部分 = %@",[self jsonToString:allHeaders]);
                                                     
                                                     if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                                         if ( [[(NSDictionary *)responseObject objectForKey:@"errcode"] intValue] != 0) {
                                                            // [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
                                                             [[self allSessionTask] removeObject:task];
                                                             success ? success(nil) : nil;
                                                             return ;
                                                         }
                                                     }
                                                     
                                                     RYLog(@"responseObject = %@",[self jsonToString:responseObject]);
                                                     [[self allSessionTask] removeObject:task];
                                                     success ? success(responseObject) : nil;
                                                     
                                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                     RYLog(@"error = %@",error);
                                                     [[self allSessionTask] removeObject:task];
                                                     failure ? failure(error) : nil;
                                                     
                                                 }];
    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}



#pragma mark - 上传文件
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:(RYHttpProgress)progress
                                success:(RYHttpRequestSuccess)success
                                failure:(RYHttpRequestFailed)failure {
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
        (failure && error) ? failure(error) : nil;
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        RYLog(@"responseObject = %@",[self jsonToString:responseObject]);
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RYLog(@"error = %@",error);
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 上传多张图片
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(RYHttpProgress)progress
                                  success:(RYHttpRequestSuccess)success
                                  failure:(RYHttpRequestFailed)failure {
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = NSStringFormat(@"%@%ld.%@",str,i,imageType?:@"jpg");
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? NSStringFormat(@"%@.%@",fileNames[i],imageType?:@"jpg") : imageFileName
                                    mimeType:NSStringFormat(@"image/%@",imageType ?: @"jpg")];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        RYLog(@"responseObject = %@",[self jsonToString:responseObject]);
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        RYLog(@"error = %@",error);
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(RYHttpProgress)progress
                              success:(void(^)(NSString *))success
                              failure:(RYHttpRequestFailed)failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self allSessionTask] removeObject:downloadTask];
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    //开始下载
    [downloadTask resume];
    // 添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil ;
    
    return downloadTask;
}


+ (void)cancelAllRequest {
    // 锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) { return; }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}


/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data {
    if(data == nil) { return nil; }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 */
+ (void)initialize {
    _sessionManager = [[AFHTTPSessionManager alloc] init];
    // 设置超时时间
    [_sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _sessionManager.requestSerializer.timeoutInterval = 30.f;
    [_sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    // 设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    //    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"text/encode", nil];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //开启加密模式
    //[self openAES];
}

#pragma mark - 重置AFHTTPSessionManager相关属性

+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    sessionManager ? sessionManager(_sessionManager) : nil;
}

+ (void)setRequestSerializer:(RYRequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = requestSerializer==RYRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(RYResponseSerializer)responseSerializer {
    _sessionManager.responseSerializer = responseSerializer==RYResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)openNetworkActivityIndicator:(BOOL)open {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [_sessionManager setSecurityPolicy:securityPolicy];
}
@end

#pragma mark - NSDictionary,NSArray的分类
/*
 ************************************************************************************
 *新建NSDictionary与NSArray的分类, 控制台打印json数据中的中文
 ************************************************************************************
 */

#ifdef DEBUG
@implementation NSArray (RY)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendFormat:@")"];
    
    return strM;
}

@end

@implementation NSDictionary (RY)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendFormat:@"}\n"];
    
    return strM;
}
@end
#endif
