//
//  Result+Extensions.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import Foundation

extension Result where Success == Void {
    static var success: Result {
        return .success(())
    }
}
