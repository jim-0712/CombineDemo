//
//  Observable.swift
//  CombineDemo
//
//  Created by Fu Jim on 2021/3/2.
//

import Foundation

class Observable<T> {
    
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChange?(self.value)
            }
        }
    }
    
    private var valueChange: ((T) -> Void)?
    
    init(value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping(T) -> Void) {
        self.valueChange = closure
    }
    
    func removeBind() {
        self.valueChange = nil
    }
}

