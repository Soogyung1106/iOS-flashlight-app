//
//  ViewController.swift
//  Flashlight
//
//  Created by 정수경 on 2023/08/31.
//

import UIKit
import AVFoundation //소리재생을 위한 프레임워크 추가

class ViewController: UIViewController {
    
    @IBOutlet weak var switchButton: UIButton! //스위치 버튼
    @IBOutlet weak var flashImageView: UIImageView! //배경화면
    var isOn = false //손전등의 켜져있는지 꺼져있는지의 상태값을 저장
    var soundEffect: AVAudioPlayer? //사운드
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSound() //View Controller가 로드될 때 경로에서 한번 가져와 사운드 재생을 준비해두면, 버튼을 누를때마다 경로에서 데이터를 가져오는 부하를 없앨 수 있다.
    }
    
    //소리를 재생을 준비하는 펑션
    func prepareSound(){
        
        let path = Bundle.main.path(forResource: "switch.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.prepareToPlay()
        } catch {
            // couldn't load file :(
        }
    }
    
    //플래시를 키고 끄는 펑션
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    //스위치 버튼이 눌렸을 때 동작하는 펑션
    @IBAction func switchTapped(_ sender: Any) {
        
        isOn = !isOn
        soundEffect?.play() //소리가 재생된다.
        toggleTorch(on: isOn) //손전등의 on, off 상태에 따라 플래시를 키고 끈다.
        
        //버튼의 배경화면과 스위치 버튼의 모양이 바뀐다.
        if isOn == true{
            switchButton.setImage(UIImage(named: "onSwitch"), for: .normal)
            flashImageView.image = UIImage(named: "onBG")
        }else{
            switchButton.setImage(UIImage(named: "offSwitch"), for: .normal)
            flashImageView.image = UIImage(named: "offBG")
        }
        
    }
    
}

