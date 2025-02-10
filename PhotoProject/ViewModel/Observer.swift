//
//  Observer.swift
//  PhotoProject
//
//  Created by 박준우 on 2/10/25.
//

import Foundation

final class Observer<T> {
    var value: T {
        didSet {
            self.closure?(self.value)
        }
    }
    
    private var closure: ((T) -> ())?
    
    init(value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> ()){
        closure(self.value)
        self.closure = closure
    }
    
    func lazyBind(_ closure: @escaping (T) -> ()){
        self.closure = closure
    }
}
