//
//  ViewController.swift
//  SearchPractice
//
//  Created by CdxN on 2017/8/3.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView: UITableView!
    var searchController: UISearchController!

    let cities = [
        "臺北市", "新北市", "桃園市", "臺中市", "臺南市",
        "高雄市", "基隆市", "新竹市", "嘉義市", "新竹縣",
        "苗栗縣", "彰化縣", "南投縣", "雲林縣", "嘉義縣",
        "屏東縣", "宜蘭縣", "花蓮縣", "臺東縣", "澎湖縣" ]

    var searchArr: [String] = [String]() {
        didSet {
            // 重設 searchArr 後重整 tableView
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "首頁"

        // 底色
        self.view.backgroundColor = UIColor.darkGray

        // 導覽列標題
        self.title = "首頁"

        // 導覽列底色
        self.navigationController?.navigationBar.barTintColor =
            UIColor.lightGray

        // 導覽列是否半透明
        self.navigationController?.navigationBar.isTranslucent = false

        // 導覽列左邊按鈕
        let leftButton = UIBarButtonItem(
            image: UIImage(named:"check"),
            style:.plain ,
            target:self ,
            action: #selector(ViewController.check))
        // 加到導覽列中
        self.navigationItem.leftBarButtonItem = leftButton

        // 導覽列右邊按鈕
        let rightButton = UIBarButtonItem(
            title:"設定",
            style:.plain,
            target:self,
            action:#selector(ViewController.goWebView))
        // 加到導覽列中
        self.navigationItem.rightBarButtonItem = rightButton

//        // 建立一個按鈕
//        let myButton = UIButton(frame: CGRect(
//            x: 0, y: 0, width: 120, height: 40))
//        myButton.setTitle("Article", for: .normal)
//        myButton.backgroundColor = UIColor.blue
//        myButton.addTarget(
//            self,
//            action: #selector(ViewController.article),
//            for: .touchUpInside)
//        self.view.addSubview(myButton)

        // ---------------------------------------------------

        let fullScreenSize = UIScreen.main.bounds.size

        self.tableView = UITableView(frame: CGRect(
            x: 0, y: 0,
            width: fullScreenSize.width,
            height: fullScreenSize.height - 20),
                                     style: .plain)
        self.tableView.register(UITableViewCell.self,
                                     forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)

        // ---------------------------------------------------

        // 建立 UISearchController 並設置搜尋控制器為 nil
        self.searchController =
            UISearchController(searchResultsController: nil)

        // 將更新搜尋結果的對象設為 self
        self.searchController.searchResultsUpdater = self

        // 搜尋時是否隱藏 NavigationBar
        // 這個範例沒有使用 NavigationBar 所以設置什麼沒有影響
        self.searchController
            .hidesNavigationBarDuringPresentation = false

        // 搜尋時是否使用燈箱效果 (會將畫面變暗以集中搜尋焦點)
        self.searchController
            .dimsBackgroundDuringPresentation = false

        // 搜尋框的樣式
        self.searchController.searchBar.searchBarStyle =
            .prominent

        // 設置搜尋框的尺寸為自適應
        // 因為會擺在 tableView 的 header
        // 所以尺寸會與 tableView 的 header 一樣
        self.searchController.searchBar.sizeToFit()

        // 將搜尋框擺在 tableView 的 header
        self.tableView.tableHeaderView =
            self.searchController.searchBar

    }

    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
    }

    // ---------------------------------------------------

    func article() {
        self.navigationController?.pushViewController(
            WebViewController(), animated: true)
    }

    func check() {
        print("check button action")
    }

    func goWebView() {
        self.navigationController?.pushViewController(
            WebViewController(), animated: true)
    }

}
