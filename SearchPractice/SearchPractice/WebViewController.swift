//
//  WebViewController.swift
//  SearchPractice
//
//  Created by CdxN on 2017/8/3.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        // 導覽列標題
        self.title = "Web"

        // 導覽列底色
        self.navigationController?.navigationBar.barTintColor =
            UIColor.cyan

        // 導覽列右邊按鈕
        let rightButton = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(WebViewController.edit))

        // 加到導覽列中
        self.navigationItem.rightBarButtonItem = rightButton

        // 建立一個按鈕
        let myButton = UIButton(frame: CGRect(
            x: 100, y: 100, width: 120, height: 40))
        myButton.setTitle("回前頁", for: .normal)
        myButton.backgroundColor = UIColor.blue
        myButton.addTarget(
            self,
            action: #selector(WebViewController.back),
            for: .touchUpInside)
        self.view.addSubview(myButton)

    }

    func edit() {
        print("edit action")
    }

    func back() {
        self.navigationController?.popViewController(animated: true)
    }

}
