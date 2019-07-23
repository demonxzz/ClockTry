//
//  ViewController.swift
//  NotificationTry
//
//  Created by weiyongming on 2019/7/23.
//  Copyright © 2019 jam. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }

    @IBAction func setClock(_ sender: UIButton) {
        
        let filePath = NSHomeDirectory() + "/Documents/contacts.data"
        //        对归档文件进行加载和恢复
        //        读取刚刚保存的二进制文件
        let fileData = NSMutableData(contentsOfFile: filePath)
        //        然后对文件恢复归档，将文件或者来自网络的数据块恢复成swift对象
        let unarchiver = NSKeyedUnarchiver(forReadingWith: fileData! as Data)
        //        根据设置的键名对数据进行恢复归档操作，并获得其最终结果
        let userClock = unarchiver.decodeObject(forKey: "userKey") as! ClockTimeModel
        //        完成对象的解码操作
        unarchiver.finishDecoding()
        
        let content = UNMutableNotificationContent()
        
        content.title = "CoderJam提醒测试"
        
        content.body = "通知提醒内容：HenSin!"
        
        
        //设置通知触发器
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60,repeats: true)
    
        let trigger = UNCalendarNotificationTrigger(dateMatching: userClock.userDate, repeats: true)
        
        let uuidString = "TestNotification"
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.add(request) {
            (error) in
            if error != nil {
                // Handle any errors.
                print("error")
            }
        }
        
        print("sendOver")
    }
    @IBAction func StoreDate(_ sender: UIButton) {
        let userClock = ClockTimeModel()
        
        let date = datePicker.date
        
     
        
      
        
        let calendar = Calendar.current
      
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        print("\(components)")  //Optional(3)
        
        
    
        
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        // 为日期格式器设置格式字符串
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        // 使用日期格式器格式化日期、时间
        let datestr = dformatter.string(from: date)
        
        //        设置属性的值
        userClock.userDate = components
        
        userClock.userLabel = "newClockTime"
        
        //        创建一个可变二进制数据对象，用来储存归档后的模型对象
        let data = NSMutableData()
        //        使数据对象，初始化一个键值归档对象
        let archive = NSKeyedArchiver(forWritingWith: data)
        //        对模型对象进行归档操作，（归档操作是指将swift对象，存储为一个文件或者网络上的一个数据块）
        archive.encode(userClock, forKey: "userKey")
        //        完成编码，即序列化工作
        archive.finishEncoding()
        
        //        初始化一个字符串对象，作为归档文件的存储路径
        let filePath = NSHomeDirectory() + "/Documents/contacts.data"
        //        将归档文件存储在程序包的指定位置
        data.write(toFile: filePath, atomically: true)
        
        print("store over")
    }
    
    @IBAction func ShowDate(_ sender: UIButton) {
        
        let filePath = NSHomeDirectory() + "/Documents/contacts.data"
        //        对归档文件进行加载和恢复
        //        读取刚刚保存的二进制文件
        let fileData = NSMutableData(contentsOfFile: filePath)
        //        然后对文件恢复归档，将文件或者来自网络的数据块恢复成swift对象
        let unarchiver = NSKeyedUnarchiver(forReadingWith: fileData! as Data)
        //        根据设置的键名对数据进行恢复归档操作，并获得其最终结果
        let saveUser = unarchiver.decodeObject(forKey: "userKey") as! ClockTimeModel
        //        完成对象的解码操作
        unarchiver.finishDecoding()
        
        let message =  "选中的时间为：\(saveUser.userDate),Label为:\(saveUser.userLabel)"
        
        let alertController = UIAlertController(title: "选定的日期和时间",
                                                message: message,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func sendNotification(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "hangge.com"
        content.body = "做最好的开发者知识平台"
        
        //设置通知触发器
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60,repeats: true)
        
       
        
        
        var date = DateComponents()
        date.hour = 8
        date.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let uuidString = "TestNotification"
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.add(request) {
            (error) in
            if error != nil {
                // Handle any errors.
                print("error")
            }
        }
        
        print("sendOver")
    }
    
    @IBAction func cancelNotification(_ sender: UIButton) {
        
        //取消未发送的通知
        var uuidString:[String] = ["TestNotification"]
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: uuidString)
        
        print("cancelSuccess")
    }
}

