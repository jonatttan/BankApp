//
//  View+Extensions.swift
//  BankApp
//
//  Created by Jonattan Sousa on 25/01/24.
//

import SwiftUI

extension View {
    
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
    
}

