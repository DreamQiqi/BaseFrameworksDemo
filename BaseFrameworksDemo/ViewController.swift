//
//  ViewController.swift
//  BaseFrameworksDemo
//
//  Created by 齐翠丽 on 17/5/2.
//  Copyright © 2017年 RG. All rights reserved.
//

import UIKit
import Moya
import RxSwift
class ViewController: UIViewController {
    lazy var disposeBag:DisposeBag = {
        return DisposeBag()
    }()
    var model : GetVillageListModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Networking.newDefaultNetworking()
            .request(API.getvillageList(keyword:"",count:"10",page:"\(1)"))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapToIgnoreOutside(object: GetVillageListModel.self)
            .subscribe{[weak self] even in
                //                self?.myTableView!.endRefresh()
                switch even {
                case .next(let value):
                    self?.model = value
                    print("next---\(value)-----")
                    //self?.myTableView?.reloadData()
                    
                case .completed:
                    log.debug("")
                    //self?.hidePageLoading()
                case .error(let error):
                    log.error(error)
                    
                }
                
                
            }.addDisposableTo(disposeBag)
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

