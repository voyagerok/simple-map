//
//  AVLTree.swift
//  Dictionary
//
//  Created by Николай on 22.01.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import Foundation

internal class AVLTreeNode<KeyType: Comparable, ValueType> {
    var key : KeyType
    var value : ValueType!
    var left : AVLTreeNode<KeyType, ValueType>!
    var right : AVLTreeNode<KeyType, ValueType>!
    var height : Int
    
    init(withKey key: KeyType,
         andValue value: ValueType? = nil,
         andLeft left: AVLTreeNode<KeyType, ValueType>? = nil,
         andRight right: AVLTreeNode<KeyType, ValueType>? = nil,
         andHeight height: Int = 1)
    {
        self.key = key
        self.value = value
        self.left = left
        self.right = right
        self.height = height
    }
}

internal class AVLTree<KeyType: Comparable, ValueType>: NSObject {
    
    // MARK: fields
    var root : AVLTreeNode<KeyType, ValueType>! = nil
    
    // MARK: - public methods
    func add(value: ValueType?, forKey key: KeyType) {
        root = insert(node: root, key: key, value: value);
    }
    
    func remove(key: KeyType) {
        root = remove(node: root, key: key);
    }
    
    func findObject(forKey key: KeyType) -> ValueType? {
        return find(node: root, key: key);
    }
    
    func clear() {
        root = nil
    }
    
    func printall()
    {
        printall(currentNode: root, height:0)
    }
    
    func next() -> (KeyType, ValueType)? {
        return nil
    }
    
    func getIterator() -> AVLTreeIterator<KeyType, ValueType> {
        return AVLTreeIterator(withNode: root)
    }
    
    // MARK: - private methods
    
    // MARK: search
    private func find(node: AVLTreeNode<KeyType, ValueType>!, key: KeyType) -> ValueType? {
        if (node == nil) { return nil; }
        if (key < node.key)
        {
            return find(node: node.left, key: key)
        }
        else if (key > node.key)
        {
            return find(node: node.right, key: key);
        }
        else
        {
            return node.value;
        }
    }
    
    // MARK: helper methods
    private func height(_ currentNode: AVLTreeNode<KeyType, ValueType>?) -> Int
    {
        if let node = currentNode
        {
            return node.height;
        }
        else
        {
            return 0;
        }
    }
    
    private func getIndentation(height: Int) -> String
    {
        var indentString = String()
        for _ in 0..<height
        {
            indentString += "\t";
        }
        return indentString;
    }
    
    private func printall(currentNode : AVLTreeNode<KeyType, ValueType>!, height: Int)
    {
        if (currentNode != nil)
        {
            printall(currentNode: currentNode?.right, height: height + 1);
            print("\(getIndentation(height: height))Node value: \(currentNode.key)");
            printall(currentNode: currentNode?.left, height: height + 1);
        }
    }
    
    
    // MARK: balancing
    private func rotateRight(_ node: AVLTreeNode<KeyType, ValueType>) -> AVLTreeNode<KeyType, ValueType>
    {
        let left = node.left;
        node.left = left?.right;
        left?.right = node;
        fixheight(node);
        fixheight(left!);
        return left!;
    }
    
    private func rotateLeft(_ node: AVLTreeNode<KeyType, ValueType>) -> AVLTreeNode<KeyType, ValueType>
    {
        let right = node.right;
        node.right = right?.left;
        right?.left = node;
        fixheight(node);
        fixheight(right!);
        return right!;
    }
    
    private func balance(_ node: AVLTreeNode<KeyType, ValueType>) -> AVLTreeNode<KeyType, ValueType>
    {
        fixheight(node);
        if (bfactor(node) == 2)
        {
            if (bfactor(node.right) < 0)
            {
                node.right = rotateRight(node.right);
            }
            return rotateLeft(node);
        }
        if (bfactor(node) == -2)
        {
            if (bfactor(node.left) > 0)
            {
                node.left = rotateLeft(node.left);
            }
            return rotateRight(node);
        }
        return node;
    }
    
    private func bfactor(_ currentNode : AVLTreeNode<KeyType, ValueType>) -> Int
    {
        return height(currentNode.right) - height(currentNode.left);
    }
    
    private func fixheight(_ currentNode: AVLTreeNode<KeyType, ValueType>)
    {
        let height_right = height(currentNode.right);
        let height_left = height(currentNode.left);
        currentNode.height = (height_left > height_right ? height_left : height_right) + 1;
    }
    
    // MARK: insertion
    private func insert(node:AVLTreeNode<KeyType, ValueType>!, key: KeyType, value:ValueType?) -> AVLTreeNode<KeyType, ValueType>
    {
        if (node == nil)
        {
            return AVLTreeNode(withKey: key, andValue: value);
        }
        else if (key == node.key)
        {
            node.value = value;
            return node;
        }
        else if (key < node.key)
        {
            node.left = insert(node: node.left, key: key, value: value);
        }
        else
        {
            node.right = insert(node: node.right, key: key, value: value);
        }
        return balance(node);
    }
    
    // MARK: deletion
    private func findMin(_ node:AVLTreeNode<KeyType, ValueType>) -> AVLTreeNode<KeyType, ValueType>
    {
        return node.left != nil ? findMin(node.left) : node;
    }
    
    private func removeMin(_ node:AVLTreeNode<KeyType, ValueType>) -> AVLTreeNode<KeyType, ValueType>?
    {
        if (node.left == nil)
        {
            return node.right;
        }
        node.left = removeMin(node.left);
        return balance(node);
    }
    
    private func remove(node:AVLTreeNode<KeyType, ValueType>?, key: KeyType) -> AVLTreeNode<KeyType, ValueType>?
    {
        if node == nil { return nil; }
        if (key < (node?.key)!)
        {
            node?.left = remove(node:node?.left, key: key);
        }
        else if (key > (node?.key)!)
        {
            node?.right = remove(node: node?.right, key: key);
        }
        else
        {
            let leftChild = node?.left;
            let rightChild = node?.right;
            if (rightChild == nil) { return leftChild; }
            let min = findMin(rightChild!);
            min.right = removeMin(rightChild!);
            min.left = leftChild;
            return balance(min);
        }
        
        return balance(node!);
    }
}
