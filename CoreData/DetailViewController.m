//
//  DetailViewController.m
//  CoreData
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "DIEColor.h"
#import "Book+CoreDataProperties.h"
#import "Book.h"
#import "Student+CoreDataProperties.h"

@interface DetailViewController ()

{
    NSArray *stuArray;
}
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"priceCell"];
    [self look];
}

- (void)look{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //获取管理上下文，可以理解为“数据库”
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    //使用实体名创建数据请求对象
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Student"];
    //执行数据请求
    stuArray = [context executeFetchRequest:request error:nil];
    for (Student *student in stuArray) {
        NSLog(@"result:%@ | %d | %@",student.name,student.age,student.address);
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return stuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UITableViewCell *priceCell;
//    priceCell = [tableView dequeueReusableCellWithIdentifier:@"priceCell" forIndexPath:indexPath];
    
    Student *stu = stuArray[indexPath.row];
    Book *book = [stu.books anyObject];
    int price = book.price;
    NSString *title = book.title;
    priceCell.textLabel.text = [NSString stringWithFormat:@"%d",price];
   cell.textLabel.text = title;
    cell.textLabel.text = stu.name;
    UIImage *image = [UIImage imageWithData:stu.head];
    cell.imageView.image= image;
    DIEColor *aColor = [[DIEColor alloc]init];
    UIColor *color = [[UIColor alloc]initWithRed:aColor.red green:0 blue:0 alpha:1];
    cell.backgroundColor = color;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    Student *stu = stuArray[indexPath.row];
    [context deleteObject:stu];
    [context save:nil];
    [self look];
}

@end











