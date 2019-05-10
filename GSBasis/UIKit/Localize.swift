//
//  Localize.swift
//  GSBasis
//
//  Created by Zhendeaini 孟 on 2019/5/10.
//

import Foundation

public struct Localize {
    
    /// Default language. English. If English is unavailable defaults to base localization.
    public static var DefaultLanguage = "en"
    private static var storeCurrentKey = GSDefaultsKey<String>("GSBasis")
    
    /// Get all available localization type from app
    ///
    /// - Parameter excludeBase: exclude base or not, default is yes
    public static func availableLanguages(_ excludeBase: Bool = true) -> [String] {
        var availableLanguages = Bundle.main.localizations
        if let indexOfBase = availableLanguages.firstIndex(of: "Base") , excludeBase { availableLanguages.remove(at: indexOfBase) }
        return availableLanguages
    }
    
    /**
     Current language
     - Returns: The current language. String.
     */
    public static func currentLanguage() -> String {
        if let current = GSDefaults.shared.get(for: storeCurrentKey) { return current }
        else { return defaultLanguage() }
//        if let currentLanguage = UserDefaults.standard.object(forKey: LCLCurrentLanguageKey) as? String {
//            return currentLanguage
//        }
//        return defaultLanguage()
    }
    
    /**
     Change the current language
     - Parameter language: Desired language.
     */
    public static func setCurrentLanguage(_ language: String) {
//        let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
//        if (selectedLanguage != currentLanguage()){
//            UserDefaults.standard.set(selectedLanguage, forKey: LCLCurrentLanguageKey)
//            UserDefaults.standard.synchronize()
//            NotificationCenter.default.post(name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
//        }
    }
    
    /**
     Default language
     - Returns: The app's default language. String.
     */
    public static func defaultLanguage() -> String {
        var defaultLanguage: String = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else { return DefaultLanguage }
        
        let availableLanguages: [String] = self.availableLanguages()
        if (availableLanguages.contains(preferredLanguage)) { defaultLanguage = preferredLanguage }
        else { defaultLanguage = DefaultLanguage }
        
        return defaultLanguage
    }
}
