//
//  MenuItem.swift
//  XCANews
//
//  Created by Alfian Losari on 7/10/21.
//

import Foundation

enum MenuItem: CaseIterable {
    case search
#if !os(watchOS)
    case saved
#endif
    case category(Category)
    #if os(watchOS)
    case settings
    #endif
    
    var text: String {
        switch self {
        case .search:
            return "Search"
					#if !os(watchOS)
        case .saved:
            return "Saved"
					#endif
        case .category(let category):
            return category.text
        #if os(watchOS)
        case .settings:
            return "Settings"
        #endif
        
        }
    }
    
    var systemImage: String {
        switch self {
        case .search:
            return "magnifyingglass"
					#if !os(watchOS)
        case .saved:
            return "bookmark"
					#endif
        case .category(let category):
            return category.systemImage
        #if os(watchOS)
        case .settings:
            return "gear"
        #endif
        }
    }
    
    static var allCases: [MenuItem] {
#if !os(watchOS)
        return [.search, .saved] + Category.menuItems
			#else
			return [.search] + Category.menuItems
			#endif
    }
    
}

extension MenuItem: Identifiable {
    
    var id: String {
        switch self {
        case .search:
            return "search"
				#if !os(watchOS)
        case .saved:
            return "saved"
					#endif
        case .category(let category):
            return category.rawValue
        #if os(watchOS)
        case .settings:
            return "settings"
        #endif
        }
    }
    
    init?(id: MenuItem.ID?) {
        switch id {
        case MenuItem.search.id:
            self = .search
				#if !os(watchOS)
        case MenuItem.saved.id:
            self = .saved
				#endif
        #if os(watchOS)
        case MenuItem.settings.id:
            self = .settings
        #endif
        default:
            if let id = id, let category = Category(rawValue: id) {
                self = .category(category)
            } else {
                return nil
            }
        }
    }
    
}

extension Category {
    static var menuItems: [MenuItem] {
        allCases.map { .category($0) }
    }
}
