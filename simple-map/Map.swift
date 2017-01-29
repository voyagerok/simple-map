//
//  Map.swift
//  Dictionary
//
//  Created by Николай on 29.01.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import Foundation

public class MapIterator<KeyType: Comparable, ValueType>: IteratorProtocol {
    
    var treeIterator: AVLTreeIterator<KeyType, ValueType>
    
    init(withTree tree: AVLTree<KeyType, ValueType>) {
        treeIterator = tree.getIterator()
    }
    
    public func next() -> (KeyType, ValueType)? {
        return treeIterator.next()
    }
}

public class Map<KeyType: Comparable, ValueType>: NSObject, Sequence {
    
    var tree: AVLTree<KeyType, ValueType>
    
    public override init() {
        tree = AVLTree()
    }
    
    public func add(object:ValueType?, forKey key:KeyType) {
        tree.add(value: object, forKey: key);
    }
    
    public func removeObject(forKey key: KeyType) {
        tree.remove(key: key);
    }
    
    public func object(forKey key: KeyType) -> ValueType? {
        return tree.findObject(forKey: key)
    }
    
    public func removeAllObjects() {
        tree.clear()
    }
    
    public subscript(index: KeyType) -> ValueType?
    {
        get { return object(forKey: index) }
        set { add(object: newValue, forKey: index) }
    }
    
    public func makeIterator() -> MapIterator<KeyType, ValueType> {
        return MapIterator(withTree: tree)
    }
}
