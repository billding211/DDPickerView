//
//  CiytTools.swift
//  YuanChangTang
//
//  Created by dingding on 16/12/6.
//  Copyright © 2016年 dingding. All rights reserved.
//

import UIKit
import MJExtension


class CityModel : NSObject{
    var Division : [CityDetailModel] = []
    
    class func parse(dict : NSDictionary ) -> CityModel{
        let model = CityModel.mj_object(withKeyValues: dict)
        return model!
    }
    
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["Division":CityDetailModel.self]
    }
}

class CityDetailModel : NSObject {
    var DivisionCode : String = ""
    var DivisionName = ""
    var DivisionSub : [CityDetailModel] = []
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["DivisionSub":CityDetailModel.self]
    }
}

class CityTools: NSObject {

    static let instanceManager : CityTools = CityTools()

    /** 返回省 市 对应数组 */
    func getCityArr() -> (Array<String>,Array<Array<String>>) {
        var searchBundle : String
        if let path = Bundle.main.path(forResource: "districtMGE", ofType: ".plist") {
            searchBundle = path
        }else{
            
            let str = Bundle.main.path(forResource: "DDPickerBundle", ofType: ".bundle")
            searchBundle = (Bundle.init(path: str!)?.path(forResource: "districtMGE", ofType: ".plist"))!
        }

        let dict = NSMutableDictionary.init(contentsOfFile: searchBundle)!
        var provinceArr : [String] = []
        var subCitysArr : [[String]] = []
        let citys = CityModel.parse(dict: dict)
        
        for province in citys.Division {
            provinceArr.append(province.DivisionName)
            var tmpArr : [String] = []
            if province.DivisionSub.count > 0 {
                for subcity in province.DivisionSub {
                    tmpArr.append(subcity.DivisionName)
                }
            }else{
                tmpArr.append(province.DivisionName)
            }

            subCitysArr.append(tmpArr)
        }
        
        return (provinceArr,subCitysArr)
    }
    
    
    
    
    
}
