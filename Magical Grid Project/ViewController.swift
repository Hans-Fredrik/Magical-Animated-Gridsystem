//
//  ViewController.swift
//  Magical Grid Project
//
//  Created by Hans Fredrik Fuglerud Brastad on 4/17/17.
//  Copyright © 2017 Hans Fredrik Fuglerud Brastad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rowLength = 15
        let width = view.frame.width / CGFloat(rowLength)
        
        for j in 0...30{
            for i in 0...rowLength {
                let box = UIView()
                box.backgroundColor = randomColor()
                box.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                box.layer.borderWidth  = 0.5
                box.layer.borderColor = UIColor.black.cgColor
                view.addSubview(box)
                
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    func handlePan(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: view)
        print(location)
        
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

