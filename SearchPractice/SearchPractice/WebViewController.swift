//
//  WebViewController.swift
//  SearchPractice
//
//  Created by CdxN on 2017/8/3.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UITextFieldDelegate, UIWebViewDelegate {

    var myTextField: UITextField!
    var myWebView: UIWebView!
    var myActivityIndicator: UIActivityIndicatorView!

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

        // -------------------------------------------------------------

        // 取得螢幕的尺寸
        let fullScreenSize = UIScreen.main.bounds.size

        // 預設尺寸
        let goWidth = 100.0
        let actionWidth =
            ( Double(fullScreenSize.width) - goWidth ) / 13

        // -------------------------------------------------------------
        // 建立五個 UIButton
        var myButton = UIButton(frame: CGRect(
            x: 0, y: 20,
            width: actionWidth, height: actionWidth))
        myButton.setImage(
            UIImage(named: "back")!, for: .normal)
        myButton.addTarget(
            self,
            action:
            #selector(WebViewController.back),
            for: .touchUpInside)
        self.view.addSubview(myButton)

        myButton = UIButton(frame: CGRect(
            x: actionWidth * 3, y: 20,
            width: actionWidth, height: actionWidth))
        myButton.setImage(
            UIImage(named: "forward")!, for: .normal)
        myButton.addTarget(
            self,
            action:
            #selector(WebViewController.forward),
            for: .touchUpInside)
        self.view.addSubview(myButton)

        myButton = UIButton(frame: CGRect(
            x: actionWidth * 6, y: 20,
            width: actionWidth, height: actionWidth))
        myButton.setImage(
            UIImage(named: "refresh")!, for: .normal)
        myButton.addTarget(
            self,
            action:
            #selector(WebViewController.reload),
            for: .touchUpInside)
        self.view.addSubview(myButton)

        myButton = UIButton(frame: CGRect(
            x: actionWidth * 9, y: 20,
            width: actionWidth, height: actionWidth))
        myButton.setImage(
            UIImage(named: "stop")!, for: .normal)
        myButton.addTarget(
            self,
            action:
            #selector(WebViewController.stop),
            for: .touchUpInside)
        self.view.addSubview(myButton)

        myButton = UIButton(frame: CGRect(
            x: Double(fullScreenSize.width) - goWidth, y: 20,
            width: goWidth, height: actionWidth))
        myButton.setTitle("前往", for: .normal)
        myButton.setTitleColor(
            UIColor.black, for: .normal)
        myButton.addTarget(
            self,
            action:
            #selector(WebViewController.go),
            for: .touchUpInside)
        self.view.addSubview(myButton)

        // 建立一個 UITextField 用來輸入網址
        myTextField = UITextField(frame: CGRect(
            x: 0, y: 20.0 + CGFloat(actionWidth),
            width: fullScreenSize.width, height: 40))
        myTextField.text = "https://jameske.webflow.io"
        myTextField.backgroundColor = UIColor.init(
            red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        myTextField.clearButtonMode = .whileEditing
        myTextField.returnKeyType = .go
        myTextField.delegate = self as? UITextFieldDelegate
        self.view.addSubview(myTextField)

        // -------------------------------------------------------------

        // 建立 UIWebView
        myWebView = UIWebView(frame: CGRect(
            x: 0, y: 60.0 + CGFloat(actionWidth),
            width: fullScreenSize.width,
            height:
            fullScreenSize.height - 60
                - CGFloat(actionWidth)))

        // 設置委任對象
        myWebView.delegate = self as? UIWebViewDelegate

        // 加入到畫面中
        self.view.addSubview(myWebView)

        // 建立環狀進度條
        myActivityIndicator = UIActivityIndicatorView(
            activityIndicatorStyle: .gray)
        myActivityIndicator.center = CGPoint(
            x: fullScreenSize.width * 0.5,
            y: fullScreenSize.height * 0.5)
        self.view.addSubview(myActivityIndicator);

        // 先讀取一次網址
        self.go()

    }

    func edit() {
        print("edit action")
    }

    func back() {
        // 上一頁
        myWebView.goBack()
    }

    func forward() {
        // 下一頁
        myWebView.goForward()
    }

    func reload() {
        // 重新讀取
        myWebView.reload()
    }

    func stop() {
        // 取消讀取
        myWebView.stopLoading()

        // 隱藏環狀進度條
        myActivityIndicator.stopAnimating()
    }

    func go() {
        // 隱藏鍵盤
        self.view.endEditing(true)

        // 前往網址
        let url = URL(string: "\(myTextField.text!)")
        let urlRequest = URLRequest(url: url!)
        myWebView.loadRequest(urlRequest)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.go()

        return true
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        // 顯示進度條
        myActivityIndicator.startAnimating()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        // 隱藏進度條
        myActivityIndicator.stopAnimating()

        // 更新網址列的內容
        if let currentURL = myWebView.request?.url?.absoluteString {
            myTextField.text = currentURL
        }
    }

}
