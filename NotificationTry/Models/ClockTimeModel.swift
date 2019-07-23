//
//  ClockTimeModel.swift
//  NotificationTry
//
//  Created by weiyongming on 2019/7/23.
//  Copyright © 2019 jam. All rights reserved.
//

import Foundation

class ClockTimeModel: NSObject,NSCoding{
    //    为对象模型添加姓名和密码两个属性
    var userDate:DateComponents!
    var userLabel:String!
    //    添加一个协议方法，用来对模型对象进行序列化操作
    func encode(with aCoder: NSCoder) {
        //        对模型的姓名和密码属性进行编码操作，并设置对应的键名
        aCoder.encode(self.userDate, forKey: "userDate")
        aCoder.encode(self.userLabel, forKey: "userLabel")
    }
    //    添加另一个来自协议的方法，用来对模型对象进行反序列化操作
    required init?(coder aDecoder: NSCoder) {
        super.init()
        //        对模型的姓名和属性，根据键名进行解码操作
        self.userDate = aDecoder.decodeObject(forKey:"userDate") as? DateComponents
        self.userLabel = (aDecoder.decodeObject(forKey:"userLabel") as? String)
    }
    //    重载父类初始化方法
    override init() {
        
    }
}
