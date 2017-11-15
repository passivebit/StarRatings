//
//  StarRatingView.swift
//  ExpandableLabel
//
//  Created by Ritu Raj on 22/02/17.
//  Copyright © 2017 Acknown Technologies. All rights reserved.
//

import UIKit


class StarRatingView: UIView {

    public var delegate : StarRatingDelegate?
    public var starPadding : CGFloat = 5.0
    
    public var isStarTappable = true {
        
        didSet {
            
            guard let tapRecognizer = tapGestureRecognizer else {
                return
            }
            
            if isStarTappable {
                addGestureRecognizer(tapRecognizer)
            } else {
                removeGestureRecognizer(tapRecognizer)
            }
        }
    }
    
    private var maxStars : Int = 5
    private var ratingValue : Float?
    private var viewRect : CGRect?
    
    private var r1, r2 : CGRect?
    private var tapGestureRecognizer : UITapGestureRecognizer?
    public var utilityTag : Any?
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOnView))
        
        if isStarTappable {
            addGestureRecognizer(tapGestureRecognizer!)
        } else {
            removeGestureRecognizer(tapGestureRecognizer!)
        }
        
        viewRect = bounds
        
        clipsToBounds = true
        
        
        let bezPath = createStarViewPath(rect: viewRect! , noOfStars : maxStars)
        
        layer.addSublayer(createStarViewLayerWithPath(bezPath))
    }
   
    private func createStarViewLayerWithPath(_ path: UIBezierPath) -> CALayer {
        
        let fillLayer = CAShapeLayer()
        
        path.usesEvenOddFillRule = true
        fillLayer.path = path.cgPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        fillLayer.fillColor = UIColor.gray.cgColor
        
        return fillLayer
    }
    
    public func setupRating(_ rating:Float) ->Void {
        
        splitViewAtStarNumber(rating)
        setNeedsDisplay()
    }
    
    private func splitViewAtStarNumber(_ starNumber : Float) -> Void {
        ratingValue = starNumber
        let colorRatio = CGFloat(ratingValue!)/CGFloat(maxStars)
        let tpp = bounds.divided(atDistance: colorRatio*bounds.size.width, from: .minXEdge)
        r1 = tpp.slice
        r2 = tpp.remainder
    }
    
    override func draw(_ rect: CGRect) {
        
        UIColor.yellow.setFill()
        guard let r1 = r1 else {return}
        UIRectFill(r1)
        UIColor.white.setFill()
        guard let r2 = r2 else {return}
        UIRectFill(r2)
    }
 
    
    func createStarViewPath(rect : CGRect , noOfStars starCount: Int) -> UIBezierPath
    {
        
        let singleStarWidth = (rect.size.width - starPadding*CGFloat(starCount-1))/CGFloat(starCount)
        
        let singleStarHeight = rect.size.height
        
        let bzPath = UIBezierPath()
        
        for i in 0..<starCount {
            
            let rectStar  = CGRect(x : rect.origin.x + (CGFloat(i)*(singleStarWidth+starPadding)), y : rect.origin.y, width:singleStarWidth, height:singleStarHeight)
            
            let bezierPath = createStar(rectStar : rectStar)
            
            var rectPath : CGRect
            
            if i == (starCount-1) {
                
                rectPath = CGRect(x : rect.origin.x + (CGFloat(i)*(singleStarWidth+starPadding)), y : rect.origin.y, width:singleStarWidth, height:singleStarHeight)
            
            } else {
                
                rectPath = CGRect(x : rect.origin.x + (CGFloat(i)*(singleStarWidth+starPadding)), y : rect.origin.y, width:(singleStarWidth+starPadding), height:singleStarHeight)
            }
            
            bzPath.append(UIBezierPath(rect: rectPath))
            bzPath.append(bezierPath)
        }
        
        return bzPath
    }
//    //MARK: Create star 1
//    func createStar(rectStar : CGRect) -> UIBezierPath {
//        
//        let xx = rectStar.origin.x
//        let yy = rectStar.origin.y
//        let width = rectStar.size.width
//        let height = rectStar.size.height
//        
//        let starPath = UIBezierPath()
//        
//        starPath.move(to: CGPoint(x: xx + width/2 , y: yy))
//        starPath.addLine(to: CGPoint(x: xx + width/2 + width/4 , y: yy + height/3))
//        starPath.addLine(to: CGPoint(x: xx + width , y: yy + height/3))
//        starPath.addLine(to: CGPoint(x: xx + width - width/8, y: yy + 2*height/3))
//        starPath.addLine(to: CGPoint(x: xx + width , y: yy + height))
//        starPath.addLine(to: CGPoint(x: xx + width/2 , y: yy + height - height/8))
//        starPath.addLine(to: CGPoint(x: xx , y: yy + height))
//        starPath.addLine(to: CGPoint(x: xx + width/8, y: yy + 2*height/3))
//        starPath.addLine(to: CGPoint(x: xx , y: yy + height/3))
//        starPath.addLine(to: CGPoint(x: xx + width/4 , y: yy + height/3))
//        starPath.close()
//        
//        return starPath
//    }
    
    
    @objc func handleTapOnView(tapGesture : UITapGestureRecognizer) {
        
        print("hi there... i am tapping \(tapGesture.location(in: self))")
        
        let touchPoint = tapGesture.location(in: self)
        
        let starNumber = ceil(touchPoint.x/((viewRect?.size.width)!/CGFloat(maxStars)))
        
        setupRating(Float(starNumber))
        
        delegate?.didTapStarNumber(starNumber: (Int(starNumber) , utilityTag as Any))
    }
   
}

protocol StarRatingDelegate {
    
    func didTapStarNumber(starNumber : (Int , Any)) -> Void
}

extension StarRatingView {
    
    //MARK: create star. Instead of star any other shape can also be created
    func createStar(rectStar : CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        
        let starExtrusion:CGFloat = rectStar.width / 2.0 //30.0
        
        let center = CGPoint(x: rectStar.origin.x + rectStar.width / 2.0, y: rectStar.origin.y + rectStar.height / 2.0)
        
        // change this to increase decrease number of points on star
        
        let pointsOnStar = 5 /*+ arc4random() % 10*/
        
        var angle:CGFloat = CGFloat(M_PI / 2.0)
        let angleIncrement = CGFloat(M_PI * 2.0 / Double(pointsOnStar))
        let radius = rectStar.width / 4.0
        
        var firstPoint = true
        
        for _ in 1...pointsOnStar {
            
            let point = pointFrom(angle, radius: radius, offset: center)
            let nextPoint = pointFrom(angle + angleIncrement, radius: radius, offset: center)
            let midPoint = pointFrom(angle + angleIncrement / 2.0, radius: starExtrusion, offset: center)
            
            if firstPoint {
                firstPoint = false
                path.move(to: point)
            }
            
            path.addLine(to: midPoint)
            path.addLine(to: nextPoint)
            
            angle += angleIncrement
        }
        
        path.close()
        
        return path
    }

    
    func pointFrom(_ angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
        return CGPoint(x: radius * cos(angle) + offset.x, y: radius * sin(angle) + offset.y)
    }
}


