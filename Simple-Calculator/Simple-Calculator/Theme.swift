//
//  Theme.swift
//  Simple-Calculator
//
//  Created by Secrieru Andrei on 08.09.2022.
//
import Foundation
import UIKit

let SelectedThemeKey = "Selected Theme"

enum Theme: Int {
    case Device, Ligh, Dark
    
    func getUserInterfaceStyle () -> UIUserInterfaceStyle {
        switch self {
        case .Device:
            return .unspecified
        case .Ligh:
            return .light
        case .Dark:
            return .dark
        }
    }
}

struct ThemeManager {
    static var shared = ThemeManager()
    
    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.integer(forKey: SelectedThemeKey)) ?? .Device
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: SelectedThemeKey)
        }
    }
}
