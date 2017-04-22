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
    
    var lastSelectedBox: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genereateBoxes()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    
    private func genereateBoxes(){
        let boxWidth = view.frame.width / CGFloat(boxesPerRow)
        let numberOfRows = (Int)((view.frame.height / CGFloat(boxWidth)).rounded())
        
        for y in 0...numberOfRows{
            for x in 0...boxesPerRow {
                let box = UIView()
                box.backgroundColor = randomColor()
                box.frame = CGRect(x: CGFloat(x) * boxWidth, y: CGFloat(y) * boxWidth, width: boxWidth, height: boxWidth)
                box.layer.borderWidth  = 0.5
                box.layer.borderColor = UIColor.black.cgColor
                view.addSubview(box)
                
                let key = "\(x)|\(y)"
                boxes[key] = box
            }
        }
    }
    
    
    func handlePan(gesture: UIPanGestureRecognizer){
        let key = calculatePositionAndGetKey(gesture: gesture)
        
        guard let selectedBox = boxes[key] else {
            return
        }
        
        if self.lastSelectedBox != selectedBox{
            animateBoxToNormalState()
        }
        
        self.lastSelectedBox = selectedBox
        
        view.bringSubview(toFront: selectedBox)
        
        animateBoxToHighlightedState(box: selectedBox)
        
        if gesture.state == .ended {
           animateBoxToGestureEnded()
        }
    }
    
    
    private func calculatePositionAndGetKey(gesture: UIPanGestureRecognizer) -> String{
        let location = gesture.location(in: view)
        
        let width = view.frame.width / CGFloat(boxesPerRow)
        
        let x = Int(location.x / width)
        let y = Int(location.y / width)
        
        return "\(x)|\(y)"
    }
    
    
    private func animateBoxToHighlightedState(box: UIView){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            box.layer.transform = CATransform3DMakeScale(3, 3, 3)
            
        }, completion: nil)
    }
    
    
    private func animateBoxToNormalState(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.lastSelectedBox?.layer.transform = CATransform3DIdentity
            
        }, completion: nil)
    }
    
    
    private func animateBoxToGestureEnded(){
        UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.lastSelectedBox?.layer.transform = CATransform3DIdentity
            
        }, completion: nil)
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

