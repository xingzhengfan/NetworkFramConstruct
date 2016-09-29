//
//  RACCaseController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/17.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "RACCaseController.h"

#import <ReactiveCocoa.h>

#import "RACCaseClient.h"
#import "RACCaseUser.h"
#import "RACCaseDatabaseClient.h"
#import "RACCaseObservedModel.h"

static void * ObservationContext = &ObservationContext;
static NSString * UserDidLogOutNotification = @"UserDidLogOutNotification";

@interface RACCaseController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField   *usernameTextField;
@property (nonatomic, strong) UITextField   *passwordTextField;
@property (nonatomic, strong) UITextField   *passwordConfirmationTextField;
@property (nonatomic, strong) UIButton      *loginButton;
@property (nonatomic, strong) UIImageView   *avatar;

@property (nonatomic, strong) RACCaseClient *client;

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *passwordConfirmation;
@property (nonatomic, copy) NSNumber *createEnable;

@property (nonatomic, strong) RACCommand    *loginCommand;
@property (nonatomic, assign) BOOL          hasLogin;

@property (nonatomic, strong) RACCaseObservedModel  *model;
@property (nonatomic, copy)   NSString              *observedTitle;
@end

@implementation RACCaseController

- (void)dealloc {
#if 0
    [self.client removeObserver:self forKeyPath:@"loginned"];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UserDidLogOutNotification object:self.client];
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.usernameTextField.frame = CGRectMake(20, 100, 250, 40);
    self.passwordTextField.frame = CGRectMake(20, 150, 250, 40);
    self.passwordConfirmationTextField.frame = CGRectMake(20, 200, 250, 40);
    self.loginButton.frame = CGRectMake(20, 250, 100, 44);
    self.avatar.frame = CGRectMake(280, 100, 80, 80);
    
    [self RACObserve];
//    [self RAC_combineLastest_reduce];
//    [self RAC_button_rac_command];
//    [self RAC_asynchronize_request];
//    [self RAC_merge_signal];
//    [self RAC_flattenMap_signal];
//    [self RAC_asynchornize_combine];
    
//    [self traditionSignal];
//    [self RACSignal];
    
//    [self traditional_chaintype_dependent];
//    [self RAC_chaintype_dependent];
    
//    [self traditional_asynchronize];
//    [self RAC_asynchronize];
    
//    [self traditional_sequence];
//    [self RAC_sequence];
    
//    [self RAC_Observe_difference];
}

- (void)RACObserve {
    
    // 当self.username变化时,在控制台打印新的名字.
    //
    // RACObserve(self, username) 创建一个新的 RACSignal 信号对象,它将会发送self.username当前的值,和以后 self.username 发生变化时 的所有新值.
    // -subscribeNext: 无论signal信号对象何时发送消息,此block回调都将会被执行.
//    [RACObserve(self, username) subscribeNext:^(NSString *newName) {
//        NSLog(@"RACObserve: self.username->%@",newName);
//    }];
    
//    [[self rac_valuesAndChangesForKeyPath:@"username" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld observer:self] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    
//    [self addObserver:self forKeyPath:@"username" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)RACObserve_filter {
    
    // 只打印以"f"开头的名字.
    //
    // -filter: 当其bock方法返回YES时,才会返回一个新的RACSignal 信号对象;即如果其block方法返回NO,信号不再继续往下传播.
    
    [[RACObserve(self, username) filter:^BOOL(NSString *newName) {
        return [newName hasPrefix:@"f"];
    }] subscribeNext:^(NSString *newName) {
        NSLog(@"RACObserve_filter: self.username->%@",newName);
    }];
}

- (void)RAC_combineLastest_reduce {
    
    // 创建一个单向绑定, self.password和self.passwordConfirmation 相等
    // 时,self.createEnabled 会自动变为true.
    //
    // RAC() 是一个宏,使绑定看起来更NICE.
    //
    // +combineLatest:reduce:  使用一个 signals 信号的数组;
    // 在任意signal变化时,使用他们的最后一次的值来执行block;
    // 并返回一个新的 RACSignal信号对象来将block的值用作属性的新值来发送;
    // 简单说,类似于重写createEnabled 属性的 getter 方法.
    
    RAC(self, createEnable) = [RACSignal combineLatest:@[RACObserve(self, password), RACObserve(self, passwordConfirmation)] reduce:^NSNumber *(NSString *newPassword, NSString *newPasswordConfirmation){
        return @([newPasswordConfirmation isEqualToString:newPassword]);
    }];
    
    // 使用时,是不需要考虑属性是否是派生属性以及以何种方式绑定的:
    [RACObserve(self, createEnable) subscribeNext:^(NSNumber *enabel) {
        self.loginButton.enabled = enabel.boolValue;
        NSLog(@"enable->%d",[enabel boolValue]);
    }];
}

- (void)RAC_button_rac_command {
    
    // 任意时间点击按钮,都会打印一条消息.
    //
    // RACCommand 创建代表UI事件的signals信号.例如,单个信号都可以代表一个按钮被点击,
    // 然后会有一些额外的操作与处理.
    //
    // -rac_command 是NSButton的一个扩展.按钮被点击时,会将会把自身发送给rac_command
    
    self.loginButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"button was pressed!");
        return [RACSignal empty];
    }];
}

- (void)RAC_asynchronize_request {
    
    // 监听"登陆"按钮,并记录网络请求成功的消息.
    
    // 这个block会在来任意开始登陆步骤,执行登陆命令时调用.
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // 这是一个假想中的 -logIn 方法, 返回一个 signal信号对象,这个对象在网络对象完成时发送 值.
        // 可以使用 -filter 方法来保证当且仅当网络请求完成时,才返回一个 signal 对象.
        return [self.client loginIn];
    }];
    
    // -executionSignals 返回一个signal对象,这个signal对象就是每次执行命令时通过上面的block返回的那个signa
    [self.loginCommand.executionSignals subscribeNext:^(RACSignal *loginSingal) {
        // 打印信息,不论何时我们登陆成功.
        [loginSingal subscribeCompleted:^{
            NSLog(@"loginIn successfully");
        }];
    }];
    
    // 当按钮被点击时,执行login命令.
    self.loginButton.rac_command = self.loginCommand;
}

- (void)RAC_merge_signal {
    
    // 执行两个网络操作,并在它们都完成后在控制台打印信息.
    //
    // +merge: 传入一组signal信号,并返回一个新的RACSignal信号对象.这个新返回的RACSignal信号对象,传递所有请求的值,并在所有的请求完成时完成.即:新返回的RACSignal信号,在每个请求完成时,都会发送个消息;在所有消息完成时,除了发送消息外,还会触发"完成"相关的block.
    //
    // -subscribeCompleted: signal信号完成时,将会执行block.
    
    [[RACSignal merge:@[[self.client fetchUserRepos],[self.client fetchOrgRepos]]] subscribeCompleted:^{
        NSLog(@"they are both done!");
    }];
}

- (void)RAC_flattenMap_signal {
    
    // 用户登录,然后加载缓存信息,然后从服务器获取剩余的消息.在这一切完成后,输入信息到控制台.
    //
    // 假想的 -logInUser 方法,在登录完成后,返回一个signal信号对象.
    //
    // -flattenMap: 无论任何时候,signal信号发送一个值,它的block都将被执行,然后返回一个新的RACSignal,这个新的RACSignal
    
    [[[[self.client loginInUser] flattenMap:^RACStream *(RACCaseUser * user) {
        
        // Return a signal that loads cached messages for the user.
        return [self.client loadCachedMessagesForUser:user];
    }] flattenMap:^RACStream *(NSArray * messages) {
        
        // Return a signal that fetches any remaining messages.
        return [self.client fetchMessageAfterMessage:messages.lastObject];
    }] subscribeNext:^(NSArray *newMessages) {
        NSLog(@"New Messages -> %@",newMessages);
    } completed:^{
        NSLog(@"fetch all message");
    }];
}

- (void)RAC_asynchornize_combine {
    
    // 创建一个单向的绑定,遮掩self.imagView.image就可以在用户的头像下载完成后自动被设置.
    //
    // 假定的 -fetchUserWithUsername: 方法返回一个发送用户对象的signal信号对象.
    //
    // -deliverOn: 创建一个新的 signals 信号对象,以在其他队列来处理他们的任务.
    // 在这个示例中,这个方法被用来将任务移到后台队列,并在稍后下载完成后返回主线程中.
    //
    // -map: 每个获取的用户都会传递进到这个block,然后返回新的RACSignal信号对象,这个
    // signal信号对象发送从这个block返回的值.
    
    RAC(self.avatar, image) = [[[[self.client fetchUserAvatarWithUsername:@"thomas"] deliverOn:[RACScheduler scheduler]] map:^(RACCaseUser *user) {
        return [UIImage imageWithData:[NSData dataWithContentsOfURL:user.avatarURL]];
    }] deliverOn:RACScheduler.mainThreadScheduler];
}

#pragma mark - tradition RAC -- Signal
- (void)traditionSignal {
    
    [self.client addObserver:self forKeyPath:@"loginned" options:NSKeyValueObservingOptionInitial context:ObservationContext];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(logout:) name:UserDidLogOutNotification object:self.client];
    
    [self.usernameTextField addTarget:self action:@selector(updateButtonState) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(updateButtonState) forControlEvents:UIControlEventEditingChanged];
    
    [self.loginButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)RACSignal {
    @weakify(self);
    
    RAC(self.loginButton, enabled) = [RACSignal combineLatest:@[self.usernameTextField.rac_textSignal,
                                                           self.passwordTextField.rac_textSignal,
                                                           RACObserve(self.client, loginned),
                                                           RACObserve(self, hasLogin)]
                                                  reduce:^id (NSString *usernameStr, NSString *passwordStr, NSNumber *loginnedValue, NSNumber *hasLoginValue){
                                                      return @(usernameStr.length > 0 && passwordStr.length > 0 && !loginnedValue.boolValue && !hasLoginValue.boolValue);
                                                  }];
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
        @strongify(self);
        
        RACSignal *loginSignal = [self.client rac_loginWithUsername:self.usernameTextField.text password:self.passwordTextField.text];
        [loginSignal subscribeError:^(NSError *error) {
            @strongify(self);
            [self presentError:error];
        } completed:^{
            @strongify(self);
            self.hasLogin = YES;
        }];
    }];
    
#warning todo
    RAC(self, self.hasLogin) = [NSNotificationCenter.defaultCenter rac_addObserverForName:UserDidLogOutNotification object:nil];
}

- (void)logout:(NSNotification *)notification {
    self.hasLogin = NO;
    [self.client traditional_logout];
}
- (void)updateButtonState {
    BOOL textFieldNonEmpty = self.usernameTextField.text.length > 0 && self.passwordTextField.text.length > 0;
    BOOL readyToLogin = !self.hasLogin && !self.client.loginned;
    
    self.loginButton.enabled = textFieldNonEmpty && readyToLogin;
}
- (void)buttonPressed:(UIButton *)sender {
    [self.client traditional_loginWithUsername:self.usernameTextField.text password:self.passwordTextField.text success:^{
        self.hasLogin = YES;
    } failure:^(NSError *error) {
        [self presentError:error];
    }];
}
- (void)presentError:(NSError *)error {
    NSLog(@"error -> %@",error);
}

#pragma mark - traditional RAC -- chaintype dependent
- (void)traditional_chaintype_dependent {
    [self.client loginInUserWithSuccess:^(RACCaseUser *user) {
        [self.client loadCachedMessagesForUser:user success:^(NSArray *messages) {
            [self.client fetchMessageAfterMessage:messages.lastObject success:^(NSArray *messages) {
                NSLog(@"fetchedMessages -> %@",messages);
            } failureBlock:^(NSError *error) {
                [self presentError:error];
            }];
        } failureBlock:^(NSError *error) {
            [self presentError:error];
        }];
    } failure:^(NSError *error) {
        [self presentError:error];
    }];
}

- (void)RAC_chaintype_dependent {
    
    //    [[[[self.client loginInUser] then:^RACSignal *{
    //        return [self.client loadCachedMessagesForUser];
    //    }] flattenMap:^RACStream *(id value) {
    //        return [self.client fetchMessageAfterMessage];
    //    }] subscribeError:^(NSError *error) {
    //        [self presentError:error];
    //    } completed:^{
    //        NSLog(@"fetch all messages");
    //    }];
    
    [[[[self.client loginInUser] flattenMap:^RACStream *(RACCaseUser * user) {
        return [self.client loadCachedMessagesForUser:user];
    }] flattenMap:^RACStream *(NSArray * messages) {
        return [self.client fetchMessageAfterMessage:messages.lastObject];
    }] subscribeNext:^(NSArray * messages) {
        NSLog(@"new messages -> %@",messages);
    } error:^(NSError *error) {
        [self presentError:error];
    } completed:^{
        NSLog(@"fetch all messages!");
    }];
}

#pragma mark - tradition RAC -- asynchronize
- (void)traditional_asynchronize {
    
    NSArray *files = @[@"1",@"2",@"3"];
    
    __block NSArray *databaseObjects;
    __block NSArray *fileContents;
    
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    NSBlockOperation *databaseOperation = [NSBlockOperation blockOperationWithBlock:^{
        databaseObjects = [RACCaseDatabaseClient fetchObjectsMatchingPredicate:nil];
    }];
    NSBlockOperation *filesOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSMutableArray *filesInProgress = [NSMutableArray array];
        for (NSString *file in files) {
            [filesInProgress addObject:[file stringByAppendingString:@".jpg"]];
        }
        fileContents = [filesInProgress copy];
    }];
    
    NSBlockOperation *finishOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self finishProgressingDatabaseObjects:databaseObjects fileContents:fileContents];
        
        NSLog(@"asynchronic progress finish!");
    }];
    
    [finishOperation addDependency:databaseOperation];
    [finishOperation addDependency:filesOperation];
    [backgroundQueue addOperation:databaseOperation];
    [backgroundQueue addOperation:filesOperation];
    [backgroundQueue addOperation:finishOperation];
}
- (void)RAC_asynchronize {
    
    NSArray *files = @[@"1",@"2",@"3"];
    
    //通过复合使用signals信号对象来优化
    RACSignal *databaseSignal = [[RACCaseDatabaseClient rac_fetchObjectsMatchingPredicate:nil] subscribeOn:RACScheduler.scheduler];
    RACSignal *filesSignal = [RACSignal startEagerlyWithScheduler:RACScheduler.scheduler block:^(id<RACSubscriber> subscriber) {
        NSMutableArray *filesInProgress = [@[] mutableCopy];
        for (NSString *file in files) {
            [filesInProgress addObject:[file stringByAppendingString:@".jpg"]];
        }
        
        [subscriber sendNext:[filesInProgress mutableCopy]];
        [subscriber sendCompleted];
    }];
    
    [[RACSignal combineLatest:@[databaseSignal, filesSignal] reduce:^id(NSArray *databaseObjects, NSArray *filesContent){
        [self finishProgressingDatabaseObjects:databaseObjects fileContents:filesContent];
        return nil;
    }] subscribeCompleted:^{
        NSLog(@"asynchronic progress finish!");
    }];
}

- (void)finishProgressingDatabaseObjects:(NSArray *)databaseObjects fileContents:(NSArray *)fileContents {
    NSLog(@"databaseObjects->%@\nfilesContent->%@",databaseObjects,fileContents);
}

#pragma mark - traditional RAC -- sequence
- (void)traditional_sequence {
    NSArray *strings = @[@"fan",@"f",@"thomas",@"carve"];
    
    NSMutableArray *results = [NSMutableArray array];
    for (NSString *string in strings) {
        if (string.length < 3) {
            continue;
        }
        
        [results addObject:[string stringByAppendingString:@"foobar"]];
    }
    
    NSLog(@"results->%@",results);
}

- (void)RAC_sequence {
    NSArray *strings = @[@"fan",@"f",@"thomas",@"carve"];
    
    RACSequence *results = [[strings.rac_sequence filter:^BOOL(NSString * string) {
        return string.length >= 3;
    }] map:^NSString *(NSString * string) {
        return [string stringByAppendingString:@"foobar"];
    }];
    
    NSLog(@"%@",results.array);
}

#pragma mark - different RACObserve
- (void)RAC_Observe_difference {
    RAC(self, observedTitle, @"") = RACObserve(self, model.title);
//    RAC(self, observedTitle, @"") = RACObserve(self.model, title);
    
    NSLog(@"self->observedTitle = %@, self.model.title = %@",self.observedTitle,self.model.title);
    
    RACCaseObservedModel *tempModel = [RACCaseObservedModel new];
    tempModel.title = @"thomas";
    self.model = tempModel;
    
//    self.model.title = @"fan";
    NSLog(@"self->observedTitle = %@, self.model.title = %@",self.observedTitle,self.model.title);
}

#pragma mark - getter
- (UITextField *)usernameTextField {
    if (nil == _usernameTextField) {
        _usernameTextField = [[UITextField alloc] init];
        _usernameTextField.backgroundColor = [UIColor greenColor];
        _usernameTextField.placeholder = @"type username";
        
        _usernameTextField.delegate = self;
        
        [self.view addSubview:_usernameTextField];
    }
    
    return _usernameTextField;
}

- (UITextField *)passwordTextField {
    if (nil == _passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.backgroundColor = [UIColor brownColor];
        _passwordTextField.placeholder = @"type password";
        
        _passwordTextField.delegate = self;
        
        [self.view addSubview:_passwordTextField];
    }
    
    return _passwordTextField;
}

- (UITextField *)passwordConfirmationTextField {
    if (nil == _passwordConfirmationTextField) {
        _passwordConfirmationTextField = [[UITextField alloc] init];
        _passwordConfirmationTextField.backgroundColor = [UIColor brownColor];
        _passwordConfirmationTextField.placeholder = @"type passwordConfirmation";
        
        _passwordConfirmationTextField.delegate = self;
        
        [self.view addSubview:_passwordConfirmationTextField];
    }
    
    return _passwordConfirmationTextField;
}

- (UIButton *)loginButton {
    if (nil == _loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginButton.backgroundColor = [UIColor brownColor];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        _loginButton.enabled = NO;
        
        [self.view addSubview:_loginButton];
    }
    
    return _loginButton;
}

- (UIImageView *)avatar {
    if (nil == _avatar) {
        _avatar = [[UIImageView alloc] init];
        _avatar.backgroundColor = [UIColor cyanColor];
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius = 20;
        
        [self.view addSubview:_avatar];
    }
    
    return _avatar;
}

- (RACCaseClient *)client {
    if (nil == _client) {
        _client = [RACCaseClient new];
    }
    
    return _client;
}

- (RACCaseObservedModel *)model {
    if (nil == _model) {
        _model = [RACCaseObservedModel new];
    }
    
    return _model;
}

#pragma mark - Key Value Observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (context == ObservationContext) {
        [self updateButtonState];
        NSLog(@"Observation execute");
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        
        NSLog(@"%@",change);
    }
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.usernameTextField) {
        return self.username = textField.text;
    } else if (textField == self.passwordTextField) {
        return self.password = textField.text;
    } else if (textField == self.passwordConfirmationTextField) {
        return self.passwordConfirmation = textField.text;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}
@end
