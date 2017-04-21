//
//  ViewController.swift
//  Magical Grid Project
//
//  Created by Hans Fredrik Fuglerud Brastad on 4/17/17.
//  Copyright © 2017 Hans Fredrik Fuglerud Brastad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let boxesPerRow = 15
    
    var boxes = [String : UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.width / CGFloat(boxesPerRow)
        
        for y in 0...30{
            for x in 0...boxesPerRow {
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
    
    
    var selectedBox: UIView?
    
    func handlePan(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: view)
        
        let width = view.frame.width / CGFloat(boxesPerRow)
        let x = Int(location.x / width)
        let y = Int(location.y / width)
        
        
        let key = "\(x)|\(y)"
        guard let box = boxes[key] else {
            return
        }
        
        if selectedBox != box{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.selectedBox?.layer.transform = CATransform3DIdentity
                
            }, completion: nil)
        }
        
        
        selectedBox = box
        view.bringSubview(toFront: box)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            box.layer.transform = CATransform3DMakeScale(3, 3, 3)
        
            
        }, completion: nil)
        
        
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.selectedBox?.layer.transform = CATransform3DIdentity
                
            }, completion: nil)
        }
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

