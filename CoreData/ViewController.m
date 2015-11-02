//
//  ViewController.m
//  CoreData
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Student+CoreDataProperties.h"
#import "DIEColor.h"
#import "Book+CoreDataProperties.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)lookClicked:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //获取管理上下文，可以理解为“数据库”
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
  //使用实体名创建数据请求对象
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Student"];
    //结果类型可以获取记录数
    request.resultType = NSManagedObjectResultType;
    //筛选条件
    request.predicate = [NSPredicate predicateWithFormat:@"age > 0 && age < 50"];
    //排序条件，可以有多个排序条件
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    request.sortDescriptors = @[sort];
    NSLog(@"xxxxx:%@",request.sortDescriptors);
    //执行数据请求
    NSArray *stuArray = [context executeFetchRequest:request error:nil];
#if 0
    NSManagedObject *student = [stuArray lastObject];
    NSLog(@"result:%@ |%@ |%@",[student valueForKey:@"name"],[student valueForKey: @"age"],[student valueForKey: @"address"]);
#else
    for (Student *student in stuArray) {
        NSLog(@"result:%@ | %d | %@",student.name,student.age,student.address);
    }
#endif
}

- (IBAction)saveClicked:(id)sender {
    NSString *name = _nameTextField.text;
    int age = _ageTextField.text.intValue;
    NSString *address = _addressTextField.text;
    //拿到appdelegate
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //获取管理上下文，可以理解为“数据库”
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    //使用实体名称创建一个实体（描述对象）
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
#if 0
    //创建一条记录对象
    NSManagedObject *student = [[NSManagedObject alloc]initWithEntity:entity insertIntoManagedObjectContext:context];
    [student setValue:name forKey:@"name"];
    [student setValue:@(age) forKey:@"age"];
    [student setValue:address forKey:@"address"];
#else
    Student *student  = [[Student alloc]initWithEntity:entity insertIntoManagedObjectContext:context];
    student.name = name;
    student.age = age;
    student.address = address;
    
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    student.head = UIImageJPEGRepresentation(image, 0.6);
    
        NSEntityDescription *Bookentity = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:context];
    Book *book = [[Book alloc]initWithEntity:Bookentity insertIntoManagedObjectContext:context];
    book.price = 12;
    book.title = @"笔记";
    student.books = [NSSet setWithObject:book];

#endif
    NSError *error;
    //保存记录
    if ([context save:&error])
    {
        NSLog(@"保存成功");
    }else
    {
    [context deleteObject:error.userInfo[@"NSValidationErrorObject"]];
        if (error.code == NSValidationNumberTooLargeError||
            error.code == NSValidationNumberTooSmallError)
        {
            UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"age超出范围" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            }];
            [alertCtrl addAction:action];
            //弹出警告
            [self presentViewController:alertCtrl animated:YES completion:nil];
        }
        
    }
    
}
- (IBAction)searchClicked:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end












