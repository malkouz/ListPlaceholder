

import UIKit
@IBDesignable
class MFlatView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable var borderColor:UIColor = UIColor.lightGray
    @IBInspectable var cornerRadius:CGFloat = 5.0
    @IBInspectable var shadowRadius:CGFloat = 5.0
    @IBInspectable var borderWidth:CGFloat = 0.5
    @IBInspectable var shadowOffset:CGFloat = -1
    @IBInspectable var shadowColor:UIColor = UIColor.lightGray
    @IBInspectable var shadowOpacity:Float = 0.8
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if(self.shadowOffset >= 0){
            self.layer.shadowColor = self.shadowColor.cgColor
            self.layer.shadowOffset = CGSize(width: shadowOffset, height: shadowOffset)
            self.layer.shadowOpacity = shadowOpacity
            self.layer.shadowRadius = shadowRadius
            self.clipsToBounds = true
            self.layer.masksToBounds = false
        }
        
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = self.borderWidth
     //self.layer.masksToBounds = true
        
        
        
       
    }
}
