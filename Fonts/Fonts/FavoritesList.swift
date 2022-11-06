//
//
// FavoritesList.swift
// Fonts
// titanhood
// Fonts
//
// Created by Ajay Shrivastav on 2022-11-05 on 2:14 AM.


import Foundation
import UIKit

class FavoritesList {
    static let sharedFavoritesList = FavoritesList()
    private(set) var favorites:[String]
    
    init() {
        let defaults = UserDefaults.standard
        let storedFavorites = defaults.object(forKey: "favorites") as? [String]
        favorites = storedFavorites != nil ? storedFavorites! : []
        
    }
    
    func addFavorite(fontName: String) {
        if !favorites.contains(fontName) {
            favorites.append(fontName)
            saveFavorites()
        }
    }
    
    func removeFavorite(fontName: String) {
        if let index = favorites.firstIndex(of: fontName) {
            favorites.remove(at: index)
            saveFavorites()
        }
    }
    
    private func saveFavorites() {
        let defaults = UserDefaults.standard
        let favorites = FavoritesList.sharedFavoritesList.favorites // Read-access is OK
        FavoritesList.sharedFavoritesList.favorites = [] // Not allowed
        FavoritesList.sharedFavoritesList.favorites.append("Comic Sans MS") // Not allowed
        defaults.set(favorites, forKey: "favorites")
        defaults.synchronize()
    }
    func moveItem(fromIndex from: Int, toIndex to: Int) {
            let item = favorites[from]
            favorites.remove(at: from)
            favorites.insert(item, at: to)
            saveFavorites()
        }
}


