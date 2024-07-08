//
// Copyright (c) 2017 malkouz
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//


import UIKit

@objc public protocol ListLoadable
{
    func ld_visibleContentViews()->[UIView]
}

@objc extension UITableView : ListLoadable
{
    public func ld_visibleContentViews()->[UIView]
    {
        return (self.visibleCells as NSArray).value(forKey: "contentView") as! [UIView]
    }
}

@objc extension UIView
{
    public func showLoader(){
        var coverColor: UIColor?
        
        // cover image with current backgroundColor if its color is not clearColor
        if let backgroundColor = backgroundColor, backgroundColor != .clear {
            coverColor = backgroundColor
        }
        
        // if not, loop throw parents and find backgroundColor
        else if let color = superviewColor(view: self) {
            coverColor = color
        }
        
        // fall back to default
        if coverColor == nil {
            coverColor = defaultCoverColor
        }
            
        self.isUserInteractionEnabled = false
        if self is UITableView{
            ListLoader.addLoaderTo(self as! UITableView, coverColor: coverColor!)
        }else if self is UICollectionView{
            ListLoader.addLoaderTo(self as! UICollectionView, coverColor: coverColor!)
        }else{
            ListLoader.addLoaderToViews([self], coverColor: coverColor!)
        }
    }
    
    public func hideLoader() {
        self.isUserInteractionEnabled = true
        if self is UITableView{
            ListLoader.removeLoaderFrom(self as! UITableView)
        }else if self is UICollectionView{
            ListLoader.removeLoaderFrom(self as! UICollectionView)
        }else{
            ListLoader.removeLoaderFromViews([self])
        }
    }
    
    private var defaultCoverColor: UIColor {
        var coverColor: UIColor = .white
        if #available(iOS 13.0, *) {
            coverColor = coverColor.onDarkMode(.black)
        }
        return coverColor
    }
    
    private func superviewColor(view: UIView) -> UIColor? {
        if let superview = view.superview {
            if let color = superview.backgroundColor, color != .clear {
                return color
            }
            return superviewColor(view: superview)
        }
        return view.backgroundColor == .clear ? nil: view.backgroundColor
    }
}

@objc extension UICollectionView : ListLoadable
{
    public func ld_visibleContentViews() -> [UIView]
    {
        return (self.visibleCells as NSArray).value(forKey: "contentView") as! [UIView]
    }
}



@objc extension UIColor {
    static func backgroundFadedGrey() -> UIColor
    {
        return UIColor(red: (246.0/255.0), green: (247.0/255.0), blue: (248.0/255.0), alpha: 1)
    }
    
    static func gradientFirstStop()->UIColor
    {
        return  UIColor(red: (238.0/255.0), green: (238.0/255.0), blue: (238.0/255.0), alpha: 1.0)
    }
    
    static func gradientSecondStop()->UIColor
    {
        return UIColor(red: (221.0/255.0), green: (221.0/255.0), blue:(221.0/255.0) , alpha: 1.0);
    }
}

@objc extension UIView {
    func boundInside(_ superView: UIView){
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics:nil, views:["subview":self]))
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics:nil, views:["subview":self]))
    }
}

extension CGFloat
{
    func doubleValue()->Double
    {
        return Double(self)
    }
}



@objc open class ListLoader: NSObject
{
    static func addLoaderToViews(_ views : [UIView], coverColor: UIColor)
    {
        CATransaction.begin()
        views.forEach { $0.ld_addLoader(coverColor: coverColor) }
        CATransaction.commit()
    }
    
    static func removeLoaderFromViews(_ views: [UIView])
    {
        CATransaction.begin()
        views.forEach { $0.ld_removeLoader() }
        CATransaction.commit()
    }
    
    public static func addLoaderTo(_ list : ListLoadable, coverColor: UIColor)
    {
        self.addLoaderToViews(list.ld_visibleContentViews(), coverColor: coverColor)
    }
    
    
    public static func removeLoaderFrom(_ list : ListLoadable)
    {
        self.removeLoaderFromViews(list.ld_visibleContentViews())
    }
}

@objc class CutoutView : UIView
{
    var coverColor = UIColor.white
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(coverColor.cgColor)
        context?.fill(self.bounds)
        
        for view in (self.superview?.subviews)! {
            if view != self {
                if #available(iOS 9.0, *), let stackView = view as? UIStackView {
                    recursivelyDrawCutOutInStackView(stackView, fromParentView: view.superview!, context: context)
                } else {
                    drawPath(context: context, view: view)
                }
            }
        }
    }
    
    @available(iOS 9.0, *)
    private func recursivelyDrawCutOutInStackView(_ stackView: UIStackView, fromParentView parentView: UIView, context: CGContext?) {
        stackView.arrangedSubviews.forEach { arrangedSubview in
            if let arrangedSubviewStackView = arrangedSubview as? UIStackView {
                recursivelyDrawCutOutInStackView(arrangedSubviewStackView, fromParentView: parentView, context: context)
                return
            }
            let frame = stackView.convert(arrangedSubview.frame, to: parentView)
            drawPath(context: context, view: arrangedSubview, fixedFrame: frame)
        }
    }
    
    private func drawPath(context: CGContext?, view: UIView, fixedFrame: CGRect? = nil) {
        let frame = fixedFrame ?? view.frame
        context?.setBlendMode(.clear);
        let rect = frame
        let clipPath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: view.layer.cornerRadius).cgPath
        context?.addPath(clipPath)
        context?.setFillColor(UIColor.clear.cgColor)
        context?.closePath()
        context?.fillPath()
    }

    override func layoutSubviews() {
        self.setNeedsDisplay()
        self.superview?.ld_getGradient()?.frame = (self.superview?.bounds)!
    }
}

// TODO :- Allow caller to tweak these

var cutoutHandle: UInt8         = 0
var gradientHandle: UInt8       = 0
var loaderDuration              = 0.85
var gradientWidth               = 0.17
var gradientFirstStop           = 0.1



@objc extension UIView
{
    fileprivate func ld_getCutoutView() -> UIView?
    {
        return objc_getAssociatedObject(self, &cutoutHandle) as! UIView?
    }
    
    fileprivate func ld_setCutoutView(_ aView : UIView)
    {
        return objc_setAssociatedObject(self, &cutoutHandle, aView, .OBJC_ASSOCIATION_RETAIN)
    }
    
    fileprivate func ld_getGradient() -> CAGradientLayer?
    {
        return objc_getAssociatedObject(self, &gradientHandle) as! CAGradientLayer?
    }
    
    fileprivate func ld_setGradient(_ aLayer : CAGradientLayer)
    {
        return objc_setAssociatedObject(self, &gradientHandle, aLayer, .OBJC_ASSOCIATION_RETAIN)
    }
    
    fileprivate func ld_addLoader(coverColor: UIColor)
    {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width , height: self.bounds.size.height)
        self.layer.insertSublayer(gradient, at:0)
        
        self.configureAndAddAnimationToGradient(gradient)
        self.addCutoutView(coverColor: coverColor)
    }
    
    fileprivate func ld_removeLoader()
    {
        self.ld_getCutoutView()?.removeFromSuperview()
        self.ld_getGradient()?.removeAllAnimations()
        self.ld_getGradient()?.removeFromSuperlayer()
        
        for view in self.subviews {
            view.alpha = 1
        }
    }
    
    
    func configureAndAddAnimationToGradient(_ gradient : CAGradientLayer)
    {
        gradient.startPoint = CGPoint(x: -1.0 + CGFloat(gradientWidth), y: 0)
        gradient.endPoint = CGPoint(x: 1.0 + CGFloat(gradientWidth), y: 0)
        
        gradient.colors = [
            UIColor.backgroundFadedGrey().cgColor,
            UIColor.gradientFirstStop().cgColor,
            UIColor.gradientSecondStop().cgColor,
            UIColor.gradientFirstStop().cgColor,
            UIColor.backgroundFadedGrey().cgColor
        ]
        
        let startLocations = [NSNumber(value: gradient.startPoint.x.doubleValue() as Double),NSNumber(value: gradient.startPoint.x.doubleValue() as Double),NSNumber(value: 0 as Double),NSNumber(value: gradientWidth as Double),NSNumber(value: 1 + gradientWidth as Double)]
        
        
        gradient.locations = startLocations
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = startLocations
        gradientAnimation.toValue = [NSNumber(value: 0 as Double),NSNumber(value: 1 as Double),NSNumber(value: 1 as Double),NSNumber(value: 1 + (gradientWidth - gradientFirstStop) as Double),NSNumber(value: 1 + gradientWidth as Double)]
        
        gradientAnimation.repeatCount = Float.infinity
        gradientAnimation.fillMode = .forwards
        gradientAnimation.isRemovedOnCompletion = false
        gradientAnimation.duration = loaderDuration
        gradient.add(gradientAnimation ,forKey:"locations")
        
        
        self.ld_setGradient(gradient)
        
    }
    
    fileprivate func addCutoutView(coverColor: UIColor)
    {
        let cutout = CutoutView()
        cutout.frame = self.bounds
        cutout.coverColor = coverColor
        cutout.backgroundColor = UIColor.clear
        
        self.addSubview(cutout)
        cutout.setNeedsDisplay()
        cutout.boundInside(self)
        
        for view in self.subviews {
            if view != cutout {
                view.alpha = 0
            }
        }
        
        
        self.ld_setCutoutView(cutout)
    }
}

@available(iOS 13.0, *)
private extension UIColor {
    func onDarkMode(_ color: UIColor) -> UIColor {
        let lightColor = self
        return UIColor { trait in
            trait.userInterfaceStyle == .dark ? color: lightColor
        }
    }
}
