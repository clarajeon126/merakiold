//
//  Extensions.swift
//  Meraki
//
//  Created by Clara Jeon on 1/28/21.
//

import Foundation
import UIKit

extension String {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    }
}
