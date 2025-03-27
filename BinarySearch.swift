class Node {
    var key: Int
    var right: Node?
    var left: Node?
    
    init(_ key: Int) {
        self.key = key
    }
    var min: Node {
        if left == nil {
            return self
        } else {
            return left!.min
        }
    }
}

class BT {
    var root: Node?
    
    func insert(key: Int) {
        root = insertion(root, key)
    }
    private func insertion(_ node: Node?, _ key: Int) -> Node {
        guard let node = node else {
            let node = Node(key)
            return node
        }
        
        if key < node.key {
            node.left = insertion(node.left, key)
        }
        if key > node.key {
            node.right = insertion(node.right, key)
        }
        return node
    }
    
    func find(_ key: Int) -> Int? {
        guard let root = root else { return nil}
        guard let node = findItem(root, key) else { return nil }
        return node.key
    }
    private func findMin(_ node: Node?) -> Node {
        return node!.min
    }
    private func findItem(_ node: Node?, _ key: Int) -> Node? {
        guard let node = node else { return nil }
        
        if node.key == key {
            return node
        } else if key < node.key {
            return findItem(node.left, key)
        } else if key > node.key {
            return findItem(node.right, key)
        }
        return nil
    }
    
    func delete(_ key: Int) {
        guard let _ = root else { return }
        root = deleteItem(&root, key)
    }
    private func deleteItem(_ node: inout Node?, _ key: Int) -> Node? {
        guard let node = node else { return nil }
        
        if key < node.key {
            node.left = deleteItem(&node.left, key)
        } else if key > node.key {
            node.right = deleteItem(&node.right, key)
        } else {
            ///Case 1: Node has no children
            if node.left == nil && node.right == nil {
                return nil /// Making nil is removing because we are passing the refference
            }
            ///Case 2: Node has only one child
            else if node.left == nil {
               return node.right
            } else if node.right == nil {
                return node.left
            }
            ///Case 3: Node has two children
            else {
                let minRight = findMin(node.right!)
                node.key = minRight.key
                node.right = deleteItem(&node.right, node.key)
            }
        }
        return node
    }
    
    func prettyPrint() {
        // Hard code print for tree depth = 3
        var rootLeftLeftKey = 0
        var rootLeftRightKey = 0
        
        let rootLeftKey = root?.left == nil ? 0 : root?.left?.key
        let rootRightKey = root?.right == nil ? 0 : root?.right?.key
        
        
        
        if root?.left != nil {
            rootLeftLeftKey = root?.left?.left == nil ? 0 : root?.left?.left?.key as! Int
            rootLeftRightKey = root?.left?.right == nil ? 0 : root?.left?.right?.key as! Int
        }
        
        var rootRightLeftKey = 0
        var rootRightRightKey = 0
        
        if root?.right != nil {
            rootRightLeftKey = root?.right?.left == nil ? 0 : root?.right?.left?.key as! Int
            rootRightRightKey = root?.right?.right == nil ? 0 : root?.right?.right?.key as! Int
        }
     
        let str = """
                       \(root!.key)
                    /    \\
                   \(rootLeftKey!)      \(rootRightKey!)
                  / \\    /  \\
                 \(rootLeftLeftKey)   \(rootLeftRightKey)  \(rootRightLeftKey)    \(rootRightRightKey)
        """
        
        print(str)
    }
}

let bst = BT()
bst.insert(key: 5)
bst.insert(key: 3)
bst.insert(key: 2)
bst.insert(key: 4)
bst.insert(key: 7)
bst.insert(key: 6)
bst.insert(key: 8)
bst.delete(5)
bst.prettyPrint()
