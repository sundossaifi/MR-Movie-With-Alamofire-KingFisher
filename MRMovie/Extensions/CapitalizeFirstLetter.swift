//
//  CapitalizeFirstLetter.swift
//  MRMovie
//
//  Created by User on 5/26/24.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
