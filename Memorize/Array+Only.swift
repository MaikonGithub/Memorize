//
//  Array+Only.swift
//  Memorize
//
//  Created by Maikon Ferreira on 03/12/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first: nil
    }
}
