//
//  AVLTreeIterator.swift
//  Dictionary
//
//  Created by Николай on 29.01.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import Cocoa

internal class Stack<ValueType> : NSObject {
    var topIndex : Int
    var valuesArray : [ValueType?]
    
    override init() {
        topIndex = -1
        valuesArray = [ValueType?]()
    }
    
    func push(_ value: ValueType) {
        topIndex += 1;
        if topIndex == valuesArray.count {
            valuesArray.append(value)
        }
        else {
            valuesArray[topIndex] = value
        }
    }
    
    func pop() -> ValueType? {
        if topIndex < 0 {
            return nil
        }
        let topValue = valuesArray[topIndex]
        topIndex -= 1
        return topValue
    }
    
    func top() -> ValueType? {
        if topIndex < 0 {
            return nil
        }
        return valuesArray[topIndex]
    }
}

class AVLTreeIterator<KeyType: Comparable, ValueType>: NSObject {
    
    var stack: Stack<AVLTreeNode<KeyType, ValueType>>
    
    init(withNode rootNode:AVLTreeNode<KeyType, ValueType>?) {
        stack = Stack<AVLTreeNode<KeyType, ValueType>>()
        
        var currentNode = rootNode
        while currentNode != nil {
            stack.push(currentNode!)
            currentNode = currentNode?.left
        }
    }
    
    func next() -> (KeyType, ValueType)? {
        let topElement = stack.pop()
        if topElement != nil {
            if topElement?.right != nil {
                var child = topElement?.right
                while child != nil {
                    stack.push(child!)
                    child = child?.left
                }
            }
            return ((topElement?.key)!, (topElement?.value)!)
        }
        
        return nil
    }
}
