//
//  Observable.swift
//  mvvmArc
//
//  Created by Yan Dias on 06/05/21.
//

import Foundation

// MARK: @ObservableValue

@propertyWrapper struct ObservableValue<Value> {
    
    private var observable: Observable<Value>
    
    var projectedValue: Observable<Value> { observable }
    
    var wrappedValue: Value {
        get {
            observable.value
        }
        set {
            observable.value = newValue
        }
    }
    
    init(wrappedValue: Value) {
        observable = Observable<Value>(wrappedValue)
    }
}

// MARK: @ObservableValue use example

class ObservableTestClass {
    private var a = A()
    
    init() {
        a.$value.observe(on: self) { value in
            print(value)
        }
    }
    
    func test() {
        a.change()
    }
}

private class A {
    @ObservableValue var value: String = ""
    
    func change() {
        value = value + "1"
    }
}

// MARK: Observable

public final class Observable<Value> {
    
    struct Observer<Value> {
        weak var observer: AnyObject?
        let block: (Value) -> Void
    }
    
    private var observers = [Observer<Value>]()
    
    public var value: Value {
        didSet { notifyObservers() }
    }
    
    public init(_ value: Value) {
        self.value = value
    }
    
    public func observe(
        on observer: AnyObject,
        observerBlock: @escaping (Value) -> Void
    ) {
        observers.append(Observer(observer: observer, block: observerBlock))
        observerBlock(self.value)
    }
    
    public func bind<Object: AnyObject>(
        to keypath: ReferenceWritableKeyPath<Object, Value>,
        on observer: Object
    ) {
        observe(on: observer) {
            [weak observer] in observer?[keyPath: keypath] = $0
        }
    }
    
    public func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }
    
    private func notifyObservers() {
        observers.forEach { observer in
            DispatchQueue.main.async { observer.block(self.value) }
        }
    }
}
