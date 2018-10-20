//
//  ViewController.swift
//  LPointCopy
//
//  Created by tax_k on 20/10/2018.
//  Copyright © 2018 tax_k. All rights reserved.
//

import UIKit

struct Colors {
    static let LPointBlue = UIColor(red: 1/255, green: 154/255, blue: 250/255, alpha: 1)
}

class ViewController: UIViewController, mainControllerDelegate, UIScrollViewDelegate{
    
    var brightness: Float = Float(UIScreen.main.brightness)

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var hrScrollView: UIScrollView!
    
    var testArray = [1, 2, 3, 4, 5]
    var tagValue = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Current Brightness: \(brightness)")
        hrScrollView.delegate = self
        
        pageControl.numberOfPages = testArray.count
        pageControl.currentPage = 0
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
//        view.bringSubview(toFront: pageControl)
        
//        hrScrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        let hrScrollHeight = hrScrollView.frame.height
        let hrScrollWidth = hrScrollView.frame.width
        
        for (index, value) in testArray.enumerated(){
            let imageView = UIImageView(frame: CGRect(x: hrScrollWidth*CGFloat(index), y: 0, width: hrScrollWidth, height: hrScrollHeight))
            
//            imageView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: CGFloat(0.2*Double(value)))
//            let imageStr:String = String(describing: value["url"]!)
//            imageView.setImageFromURl(stringImageUrl: imageStr)
            
            
            let layerView = UIView(frame: CGRect(x: hrScrollWidth*CGFloat(index), y: 0, width: hrScrollWidth, height: hrScrollHeight))
            layerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: CGFloat(0.2*Double(value)))
            
            
            let label = UILabel(frame: CGRect.init(origin: CGPoint.init(x: view.frame.width*CGFloat(index), y: 200), size: CGSize.init(width: 0, height: 40)))
            label.text = String(value)
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = UIColor.white
            label.tag =  index + tagValue
            label.sizeToFit()

            
//            hrScrollView.addSubview(imageView)
            hrScrollView.addSubview(layerView)
            hrScrollView.addSubview(label)
            
        }
        hrScrollView.contentSize = CGSize(width: hrScrollWidth*CGFloat(testArray.count), height: hrScrollHeight)
    }
    
    
    /// set UIResponder (Shake Gesture)
    ///
    /// - Parameter: nope
    /// - Returns: nope
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake {
            print("motion Began")
        }else {
            return
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake {
            
            popViewAction()
        }else {
            return
        }
    }
    
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        print("motion Cancelled")
    }

    func popViewAction(){
        let popView = storyboard?.instantiateViewController(withIdentifier: "PopViewController") as! PopViewController
        popView.brightness = brightness
        popView.mainDelegate = self
        
        present(popView, animated: false, completion: {
            UIScreen.main.brightness = CGFloat(1)
        })
    }
    
    func brightenssControl(){
        UIScreen.main.brightness = CGFloat(brightness)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //인디케이터
        let pageIdx = round(hrScrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIdx)
        
        if scrollView == scrollView {
            for i in 0..<testArray.count {
                let label = scrollView.viewWithTag(i+tagValue) as! UILabel
//                let view = scrollView.viewWithTag(i + viewTagVal) as! CustomView
                let scrollContentOffset = scrollView.contentOffset.x + self.hrScrollView.frame.width
                
                var viewOffset = (view.frame.width - scrollView.bounds.width / 4 ) - scrollContentOffset
                label.center.x = scrollContentOffset - ((scrollView.bounds.width / 4 - viewOffset) / 2)
            }
        }
    }
}

