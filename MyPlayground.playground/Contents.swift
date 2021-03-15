import UIKit

var str = "Hello, playground"
func longRunningTaskUsingDispatchGroup() {
    let queue = DispatchQueue.global(qos: .background)
    let group = DispatchGroup()
    let locker = NSLock()
    var finalArray = [Int]()
    for index in 1...10 {
        group.enter()
        queue.async(group: group, execute: {
            print("Appending item... \(index)")
            //thread safe access to array
            locker.lock()
            finalArray.append(index)
            locker.unlock()
            group.leave()
        })
    }
    group.notify(qos: .background, queue: .main) {
        print("All Done \(finalArray.count)")
    }
}
