#import "SceneDelegate.h"
#import "CEViewController.h"
#import "UIWindow+Extension.h"


@interface SceneDelegate ()

@end



@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

//    self.window  = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//
//    self.window.rootViewController = [[CEViewController alloc]init];
//
//    self.window.rootViewController.view.backgroundColor = [UIColor orangeColor];
//
//    //UIWindowScene *windowScene = [[UIWindowScene alloc]initWithSession:session connectionOptions:connectionOptions]; //bad
//
//
//
//    self.window.windowScene = (UIWindowScene *)scene;
//
//    [self.window makeKeyWindow];
//
//    [self.window makeKeyAndVisible];
    
    //统一修改图片文字颜色
    //[[UITabBar appearance] setTintColor:[UIColor redColor]];
    
    
    //初始化windos
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.windowScene = (UIWindowScene *)scene;
    
    //成为keywindow
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
    
    
    // 2.判断显示默认界面还是显示新特性或者欢迎界面
    CEAccount *account = [CEAccountTool accountFromSandbox];
    if (account == nil) {
        // 显示默认界面
        CEViewController *tabBarVc = [[CEViewController alloc] init];
        self.window.rootViewController = tabBarVc;
    }else
    {
        // 如果在此之后才调用makeKeyAndVisible, 那么在chooseRootViewController方法中去到的keywindow是nil
        [self.window chooseRootViewController];
        
       
        
        
    }



}


- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    
//    NSLog(@"=== DID ENTER BACKGROUND ===");
//    self.bgTask = [[UIApplication  sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//           NSLog(@"End of tolerate time. Application should be suspended now if we do not ask more 'tolerance'");
//           // [self askToRunMoreBackgroundTask]; This code seems to be unnecessary. I'll verify it.
//       }];
//
//       if (self.bgTask == UIBackgroundTaskInvalid) {
//           NSLog(@"This application does not support background mode");
//       } else {
//           //if application supports background mode, we'll see this log.
//           NSLog(@"Application will continue to run in background");
//       }
//

    

    
}


@end
