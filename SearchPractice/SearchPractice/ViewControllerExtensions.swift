//
//  ViewControllerExtensions.swift
//  SearchPractice
//
//  Created by CdxN on 2017/8/3.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        if (self.searchController.isActive) {
            return self.searchArr.count
        } else {
            return self.cities.count
        }
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: "Cell", for: indexPath as IndexPath)

            if (self.searchController.isActive) {
                cell.textLabel?.text =
                    self.searchArr[indexPath.row]
                return cell
            } else {
                cell.textLabel?.text =
                    self.cities[indexPath.row]
                return cell
            }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(
            at: indexPath as IndexPath, animated: true)
        if (self.searchController.isActive) {
            print(
                "你選擇的是 \(self.searchArr[indexPath.row])")
        } else {
            print(
                "你選擇的是 \(self.cities[indexPath.row])")
        }
    }
}

extension ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        // 取得搜尋文字
        guard let searchText =
            searchController.searchBar.text else {
                return
        }

        // 使用陣列的 filter() 方法篩選資料
        self.searchArr = self.cities.filter(
            { (city) -> Bool in
                // 將文字轉成 NSString 型別
                let cityText:NSString = city as NSString

                // 比對這筆資訊有沒有包含要搜尋的文字
                return (cityText.range(
                    of: searchText, options:
                    NSString.CompareOptions.caseInsensitive).location)
                    != NSNotFound
        })
    }
}
