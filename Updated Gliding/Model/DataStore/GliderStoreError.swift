//
//  GliderStoreError.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import Foundation

enum GliderStoreError: Error {
    case gliderURLRetrievalError
    case gliderSaveError
    case gliderRemoveError
    
    case parsingGliderDataError
}
