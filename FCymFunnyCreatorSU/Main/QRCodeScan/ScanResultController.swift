//
//  ScanResultController.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/14.
//

import UIKit

class ScanResultController: UIViewController {

    var codeResult: LBXScanResult?
    
    let closeBtn = UIButton(type: .custom)
    let contentTextView: UITextView = UITextView()
    let homeBtn = UIButton(type: .custom)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    

    func setupView() {
        
        
        closeBtn.setImage(UIImage(named: "setting_close_ic"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnClick(sender:)), for: .touchUpInside)
        self.view.addSubview(closeBtn)
        
        closeBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(12)
            $0.width.height.equalTo(44)
            $0.height.equalTo(64)
        }
        
        self.view.addSubview(contentTextView)
        contentTextView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
            $0.top.equalTo(closeBtn).offset(100)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset( -220)
        }
        contentTextView.textAlignment = .center
        contentTextView.font = UIFont(name: "Avenir-Black", size: 18)
        contentTextView.isEditable = false
        
        contentTextView.text = codeResult?.strScanned
        
//        homeBtn.setImage(UIImage(named: "setting_close_ic"), for: .normal)
//        homeBtn.addTarget(self, action: #selector(homeBtnClick(sender:)), for: .touchUpInside)
//        self.view.addSubview(homeBtn)
//
//        homeBtn.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            $0.left.equalTo(12)
//            $0.width.height.equalTo(44)
//        }
        
    }

    
    @objc func closeBtnClick(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
