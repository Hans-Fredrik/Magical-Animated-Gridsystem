//
//  ViewController.swift
//  Magical Grid Project
//
//  Created by Hans Fredrik Fuglerud Brastad on 4/17/17.
//  Copyright © 2017 Hans Fredrik Fuglerud Brastad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let numBoxesPerRow = 15
    
    var boxes = [String : UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.width / CGFloat(numBoxesPerRow)
        
        for y in 0...30{
            for x in 0...numBoxesPerRow {
                let box = UIView()
                box.backgroundColor = randomColor()
                box.frame = CGRect(x: CGFloat(x) * width, y: CGFloat(y) * width, width: width, height: width)
                box.layer.borderWidth  = 0.5
                box.layer.borderColor = UIColor.black.cgColor
                view.addSubview(box)
                
                let key = "\(x)|\(y)"
                boxes[key] = box
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    func handlePan(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: view)
        print(location)
        
        
        let width = view.frame.width / CGFloat(numBoxesPerRow)
        let x = Int(location.x / width)
        let y = Int(location.y / width)
        
        print("X is: \(x)")
        print("Y is: \(y)")
        
        let key = "\(x)|\(y)"
        let selectedBox = boxes[key]
        selectedBox?.backgroundColor = UIColor.white
        
        /*
        var loopcount = 0
        for subview in view.subviews{
            if subview.frame.contains(location){
                subview.backgroundColor = UIColor.black
                print("Loopcount: \(loopcount)")
            }
            
            loopcount += 1
        }*/
    }
    
    
    private func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

