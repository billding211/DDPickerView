//
//  DDBasePikcerView.swift
//  FaceToDoctor
//
//  Created by dingding on 2017/3/15.
//  Copyright © 2017年 dingding. All rights reserved.
//

import UIKit

let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height
public typealias PickerBlock = (_ firstCol : String ,_ secondCol : String?) -> ()

public class DDPickerView: UIView ,UIPickerViewDataSource,UIPickerViewDelegate{
    var downView = UIView()
    var pickerView = UIPickerView()
    var backView = UIView()
    var selectedIndex = 0
    var toolBarView = UIView()
    var cancelBtn = UIButton.init(type: .system)
    var confirmBtn = UIButton.init(type: UIButtonType.system)
    var selectedBlock : PickerBlock!
    var dataArr : (Array<String>,Array<Array<String>>?)!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setFrame()
        setToolBar()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    使用方法,传入的元组  (数组,数组) 
     示例 [浙江,江苏]   [[杭州,宁波,舟山],[苏州,南京,扬州]]
    */
    public convenience init(dataArr : (Array<String>,Array<Array<String>>?),selectedBlock:@escaping PickerBlock) {
        self.init(frame:UIScreen.main.bounds)
        
        self.selectedBlock = selectedBlock
        self.dataArr = dataArr
    }
    
    
    func setFrame(){
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        toolBarView.backgroundColor = UIColor.white
    }
    
    func setToolBar(){
        addSubview(backView)
        addSubview(downView)
        downView.addSubview(pickerView)
        downView.addSubview(toolBarView)
        toolBarView.addSubview(cancelBtn)
        toolBarView.addSubview(confirmBtn)
        
        let btnColor = UIColor.blue.withAlphaComponent(0.7)
        
        backView.frame = self.bounds
        downView.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 250)
        pickerView.frame = CGRect(x: 0, y: 40, width: ScreenWidth, height: 210)
        toolBarView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 40)
        
        cancelBtn.frame = CGRect(x: 10, y: 5, width: 50, height: 30)
        cancelBtn.setTitle("取消", for: UIControlState.normal)
        cancelBtn.setTitleColor(btnColor, for: UIControlState.normal)
        
        confirmBtn.frame = CGRect(x: ScreenWidth - 60, y: 5, width: 50, height: 30)
        confirmBtn.setTitle("确定", for: UIControlState.normal)
        confirmBtn.setTitleColor(btnColor, for: UIControlState.normal)
        
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnClicks), for: UIControlEvents.touchUpInside)
        confirmBtn.addTarget(self, action: #selector(self.confirmBtnClicks), for: UIControlEvents.touchUpInside)
        
        
        backView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(self.backViewClicks))
        backView.addGestureRecognizer(gesture)
        
    }
    
    
    //MARK:- action
    func confirmBtnClicks(){
        
        let selectedFirst = dataArr.0[pickerView.selectedRow(inComponent: 0)]
        let selectedSecond = dataArr.1?[pickerView.selectedRow(inComponent: 0)][pickerView.selectedRow(inComponent: 1)]
        
        selectedBlock(selectedFirst,selectedSecond)
        
        dismiss()
    }
    
    func cancelBtnClicks(){
        dismiss()
    }
    
    func backViewClicks(){
        dismiss()
    }
    
    func dismiss(){
        UIView.animate(withDuration: 0.3, animations: {
            self.downView.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 250)
            
        }) { (success) in
            self.removeFromSuperview()
        }
    }
    
    public func show(){
        UIApplication.shared.keyWindow?.endEditing(true)
        UIApplication.shared.keyWindow?.addSubview(self)

        UIView.animate(withDuration: 0.3, animations: {
            self.downView.frame = CGRect(x: 0, y: ScreenHeight - 250, width: ScreenWidth, height: 250)
            
        }) { (success) in
            
        }
    }
    
    
    //MARK:- delegate
    //行数
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dataArr.0.count
        }else{
            return dataArr.1![selectedIndex].count
        }
        
    }
    //行高
    
    //行title
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return dataArr.0[row]
        }else{
            return dataArr.1?[selectedIndex][row]
        }
    }
    //列数
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if dataArr.1 != nil {
            return 2
        }
        return 1
        
    }
    //选择行
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            if dataArr.1 != nil {
                selectedIndex = row
                pickerView.reloadComponent(1)
            }
        }
        
    }
}

