//
//  Localization.swift
//  RxLocalization
//
//  Created by Vitalii Yevtushenko on 8/17/17.
//  Copyright © 2017 Roll'n'Code. All rights reserved.
//

import Foundation
import RxSwift

public func L(_ key: String) -> Observable<String> {
    return Localization
        .current
        .asObservable()
        .map { $0.localize(key) }
}

public class Localization {

    public static var current = Variable(Localization.auto())

    public let langCode: String

    var base: [String: String]
    var lang: [String: String]

    public init(langCode: String) {
        self.langCode = langCode

        let bundle = Bundle.main

        guard let baseUrl = bundle.url(forResource: "Base", withExtension: "lproj") else {
            fatalError("There is no 'Base.lproj' directory in the application bundle.")
        }

        self.base = NSDictionary(contentsOf: baseUrl.appendingPathComponent("Localizable.strings")) as? [String:String] ?? [:]

        guard let langUrl = bundle.url(forResource: langCode, withExtension: "lproj") else {
            self.lang = [:]
            return
        }

        self.lang = NSDictionary(contentsOf: langUrl.appendingPathComponent("Localizable.strings")) as? [String:String] ?? [:]
    }

    func localize(_ l: String) -> String {
        if let lang = lang[l] { return lang }
        if let base = base[l] { return base }
        return l
    }

    public static func auto() -> Localization {
        return Localization(langCode: Locale.preferredLanguages.first ?? "en")
    }
}
