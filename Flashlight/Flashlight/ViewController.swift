//
//  ViewController.swift
//  Flashlight
//
//  Created by 정수경 on 2023/08/31.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var switchButton: UIButton! //스위치 버튼
    @IBOutlet weak var flashImageView: UIImageView! //배경화면
    var isOn = false //손전등의 켜져있는지 꺼져있는지의 상태값을 저장
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //스위치 버튼이 눌렸을 때
    @IBAction func switchTapped(_ sender: Any) {
        //버튼의 배경화면과 스위치 버튼의 모양이 바뀐다.
        isOn = !isOn
        
        if isOn == true{
            switchButton.setImage(UIImage(named: "onSwitch"), for: .normal)
            flashImageView.image = UIImage(named: "onBG")
        }else{
            switchButton.setImage(UIImage(named: "offSwitch"), for: .normal)
            flashImageView.image = UIImage(named: "offBG")
        }
        
    }
    
}

