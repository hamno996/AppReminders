//
//  CustomeOperators.swift
//  ReminderApp
//
//  Created by Hamno Muhsin on 3/10/26.
//

import Foundation
import SwiftUI

public func ??<T>(lhs: Binding<Optional<T>>, rhs:T) -> Binding<T> {
    Binding(
        get: {lhs.wrappedValue ?? rhs},
        set: {lhs.wrappedValue = $0}
    )
}
