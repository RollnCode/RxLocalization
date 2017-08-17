//
//  ViewController.swift
//  RxLocalization
//
//  Created by Vitalii Yevtushenko on 8/17/17.
//  Copyright © 2017 Roll'n'Code. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxL10n

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var steper: UIStepper!

    override func viewDidLoad() {
        super.viewDidLoad()

        Observable.combineLatest(L("STR_N_LABELS"), steper.rx.value)
            .map { String(format: $0, Int($1)) }
            .asDriver(onErrorJustReturn: "Error")
            .drive(label.rx.text)
            .disposed(by: disposeBag)

        L("STR_DONE")
            .bind(to: doneButton.rx.title)
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

