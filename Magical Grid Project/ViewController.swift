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
    
    var lastSelectedBox: UIView?
    
    var boxes = [[UIView?]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genereateBoxes()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    
    private func genereateBoxes(){
        let boxWidth = view.frame.width / CGFloat(boxesPerRow)
        let numberOfRows = (Int)((view.frame.height / CGFloat(boxWidth)).rounded())
        
        
        for y in 0...numberOfRows{
            
            var row = [UIView]()
            
            for x in 0...boxesPerRow {
                let box = UIView()
                box.backgroundColor = randomColor()
                box.frame = CGRect(x: CGFloat(x) * boxWidth, y: CGFloat(y) * boxWidth, width: boxWidth, height: boxWidth)
                box.layer.borderWidth  = 0.5
                box.layer.borderColor = UIColor.black.cgColor
                view.addSubview(box)
                
                row.append(box)
            }
            
            boxes.append(row)
        }
    }
    
    
    func handlePan(gesture: UIPanGestureRecognizer){
        let position = calculateArrayPosition(gesture: gesture)
        
        
        guard let selectedBox = boxes[position.y][position.x] else {
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
    
    private func calculateArrayPosition(gesture: UIPanGestureRecognizer) -> Position {
        var position = Position()
        
        let location = gesture.location(in: view)
        print(location)
        
        let width = view.frame.width / CGFloat(boxesPerRow)
        
        position.x = Int(location.x / width)
        position.y = Int(location.y / width)
    
        print(position)
        
        return position
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

