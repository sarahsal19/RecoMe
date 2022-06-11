//
//  RecoDetaillViewController.swift
//  myFirstProject
//
//  Created by Sarah S on 06/06/2022.
// hand.thumbsup    link

import UIKit
import SafariServices

class RecoDetaillViewController: UIViewController {

    @IBOutlet weak var outSideLabel: UILabel!
    
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var recoImage: UIImageView!
    
    @IBOutlet weak var recoLabel: UILabel!
    
    @IBOutlet weak var openURL: UIImageView!
    
    var reciveData: Recommendation = Recommendation(img: "String", Place: "String", ItemName: "String", RecoText: "String", URL: "String", Author: "String", postDate: "String")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outSideLabel.layer.borderWidth = 0.5
        outSideLabel.layer.borderColor = #colorLiteral(red: 0.7617585659, green: 0.9344827533, blue: 0.8930566907, alpha: 1)
        outSideLabel.layer.cornerRadius = 16
        outSideLabel.layer.masksToBounds = true
        outSideLabel.layer.shadowOpacity = 1
        //recoImg.image. = 20
        outSideLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        recoLabel.layer.cornerRadius = 13
        recoLabel.layer.masksToBounds = true
        recoLabel.padding = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 10)
        
        recoImage.layer.cornerRadius = 13
        recoImage.layer.masksToBounds = true
        
        recoImage.loadImageUsingCacheWithUrlString(reciveData.img)
        itemName.text = reciveData.ItemName
        recoLabel.text = reciveData.RecoText
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        openURL.isUserInteractionEnabled = true
        openURL.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let url = URL(string: reciveData.URL)
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
    }
    
}


extension UILabel {
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }

    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: rect.inset(by: insets))
        } else {
            self.drawText(in: rect)
        }
    }

    override open var intrinsicContentSize: CGSize {
        guard let text = self.text else { return super.intrinsicContentSize }

        var contentSize = super.intrinsicContentSize
        var textWidth: CGFloat = frame.size.width
        var insetsHeight: CGFloat = 0.0
        var insetsWidth: CGFloat = 0.0

        if let insets = padding {
            insetsWidth += insets.left + insets.right
            insetsHeight += insets.top + insets.bottom
            textWidth -= insetsWidth
        }

        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        attributes: [NSAttributedString.Key.font: self.font], context: nil)

        contentSize.height = ceil(newSize.size.height) + insetsHeight
        contentSize.width = ceil(newSize.size.width) + insetsWidth

        return contentSize
    }
}
