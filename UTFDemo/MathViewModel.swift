//
//  MathViewModel.swift
//  UTFDemo
//
//  Created by Catalin Patrascu on 15.02.2023.
//

import Foundation

struct MathViewModel {
    func add(_ a: String?, and b: String?) -> Int {
        guard let a,
                let firstTerm = Int(a) else {
            return 0
        }
        
        guard let b,
                let secondTerm = Int(b) else {
            return 0
        }
        
        return firstTerm + secondTerm
    }
    
    func substract(_ a: String?, and b: String?) -> Int {
        guard let a,
                let firstTerm = Int(a) else {
            return 0
        }
        
        guard let b,
                let secondTerm = Int(b) else {
            return 0
        }
        
        return firstTerm - secondTerm
    }
}
