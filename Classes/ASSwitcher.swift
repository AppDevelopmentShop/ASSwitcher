//
//  ASSwitcher.swift
//  ASSwitcher
//
//  Created by Maksym on 7/11/18.
//

import UIKit

public protocol ASSwitcherChangeValueDelegate {
    
    func switcherDidChangeValue(switcher: ASSwitcher, value: Bool)
}

public protocol ASSwitcherDataSource {
    
    func chSwitch(backgroundView chSwith: ASSwitcher) -> UIView
    
    func chSwitch(onImageBackground chSwith: ASSwitcher) -> UIImage
    
    func chSwitch(offImageBackground chSwith: ASSwitcher) -> UIImage
    
    func chSwitch(onImage chSwith: ASSwitcher) -> UIImage
    
    func chSwitch(offImage chSwith: ASSwitcher) -> UIImage
}

public class ASSwitcher: UIView {
    
    @IBInspectable public var on: Bool = false
    
    @IBInspectable public var animationDuration: Double = 0.5 {
        didSet {
            print(animationDuration)
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            self.borderView?.borderWidth = self.borderWidth;
        }
    };
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            self.borderView?.borderColor = self.borderColor.cgColor;
        }
    };
    
    public var delegate: ASSwitcherChangeValueDelegate?
    public var dataSource: ASSwitcherDataSource?
    
    private var backVew: UIView!
    private var buttonView: UIView!
    private(set) var onImg: UIImageView!
    private(set)var offImg: UIImageView!
    private var button: UIImageView!
    private var borderView: BorderView?
    private var imageContainerView: UIView!
    private(set)var imgOn: UIImage!
    private(set)var imgOff: UIImage!
    private var background: UIView!
    
    private var offCenterPosition: CGFloat!
    private var onCenterPosition: CGFloat!
    
    private var leftConstraint: NSLayoutConstraint!
    
    
    private var fl: Bool = false;
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if (!fl) {
            fl = true;
            self.commonInit();
        }
        
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
        
        buttonView.layer.cornerRadius = self.bounds.height / 2
        buttonView.clipsToBounds = true
        
        borderView?.layer.cornerRadius = self.bounds.height / 2
        borderView?.borderColor = self.borderColor.cgColor
        borderView?.borderWidth = self.borderWidth
        borderView?.backgroundColor = .clear
        
        if (self.on) {
            onCenterPosition = self.bounds.width - self.bounds.height
            self.leftConstraint.constant = self.onCenterPosition
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func commonInit() {
        offCenterPosition = 0
        onCenterPosition = self.bounds.width - self.bounds.height
        self.backgroundColor = .clear
        
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.switcherButtonTouch(_:)))
        singleTap.numberOfTapsRequired = 1
        self.addGestureRecognizer(singleTap)
        
        initBorderView()
        initBackView()
        initButtonView()
        initBackground()
        initImageContainerView()
        initOffImage()
        initOnImage()
        initButton()
        
        self.layoutIfNeeded()
        backVew.layoutIfNeeded()
        buttonView.layoutIfNeeded()
    }
    
    private func initBorderView() {
        borderView = BorderView()
        self.addSubview(borderView!)
        borderView!.translatesAutoresizingMaskIntoConstraints = false
        borderView!.isUserInteractionEnabled = false
        
        addConstraintsStandart(item: borderView!, toItem: self, constantTrailing: 0, constantLeading: 0, constantTop: 0, constantBottom: 0)
    }
    
    private func initBackView() {
        backVew = UIView()
        self.addSubview(backVew)
        backVew.translatesAutoresizingMaskIntoConstraints = false
        backVew.isUserInteractionEnabled = true
        
        backVew.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backVew.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        backVew.widthAnchor.constraint(equalTo: backVew.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func initButtonView() {
        buttonView = UIView()
        backVew.addSubview(buttonView)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraintsStandart(item: buttonView, toItem: backVew, constantTrailing: 0, constantLeading: 0, constantTop: 0, constantBottom: 0)
    }
    
    private func initBackground() {
        background = self.dataSource?.chSwitch(backgroundView: self) ?? UIView();
        background.translatesAutoresizingMaskIntoConstraints = false;
        for v in buttonView.subviews {
            v.removeFromSuperview();
        }
        buttonView.addSubview(background)
        background.isUserInteractionEnabled = false
        
        addConstraintsStandart(item: background, toItem: buttonView, constantTrailing: 0, constantLeading: 0, constantTop: 0, constantBottom: 0)
    }
    
    private func initImageContainerView() {
        imageContainerView = UIView()
        self.insertSubview(imageContainerView, at: 0)
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraintsStandart(item: imageContainerView, toItem: self, constantTrailing: 0, constantLeading: 0, constantTop: 0, constantBottom: 0)
    }
    
    private func initOnImage() {
        onImg = UIImageView(image: self.dataSource?.chSwitch(onImageBackground: self) ?? UIImage())
        onImg.backgroundColor = .clear
        onImg.contentMode = .center
        imageContainerView.insertSubview(onImg, at: 0)
        onImg.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: onImg, attribute: .width, relatedBy: .equal, toItem: offImg, attribute: .height, multiplier: 1, constant: 0));
        self.addConstraint(NSLayoutConstraint(item: onImg, attribute: .trailing, relatedBy: .equal, toItem: imageContainerView, attribute: .trailing, multiplier: 1, constant: 0));
        self.addConstraint(NSLayoutConstraint(item: onImg, attribute: .top, relatedBy: .equal, toItem: imageContainerView, attribute: .top, multiplier: 1, constant: 0));
        self.addConstraint(NSLayoutConstraint(item: onImg, attribute: .bottom, relatedBy: .equal, toItem: imageContainerView, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    private func initOffImage() {
        offImg = UIImageView(image: self.dataSource?.chSwitch(offImageBackground: self) ?? UIImage())
        offImg.backgroundColor = .clear
        offImg.contentMode = .center
        imageContainerView.insertSubview(offImg, at: 0)
        offImg.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: offImg, attribute: .width, relatedBy: .equal, toItem: offImg, attribute: .height, multiplier: 1, constant: 0));
        self.addConstraint(NSLayoutConstraint(item: offImg, attribute: .leading, relatedBy: .equal, toItem: imageContainerView, attribute: .leading, multiplier: 1, constant: 0));
        self.addConstraint(NSLayoutConstraint(item: offImg, attribute: .top, relatedBy: .equal, toItem: imageContainerView, attribute: .top, multiplier: 1, constant: 0));
        self.addConstraint(NSLayoutConstraint(item: offImg, attribute: .bottom, relatedBy: .equal, toItem: imageContainerView, attribute: .bottom, multiplier: 1, constant: 0));
    }
    
    private func initButton() {
        button = UIImageView()
        backVew.addSubview(button)
        self.button.image = self.dataSource?.chSwitch(offImage: self) ?? UIImage()
        self.button.backgroundColor = .clear
        self.button.contentMode = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.switcherButtonTouch(_:)))
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.getSwipeAction(_:)))
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.getSwipeAction(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        singleTap.numberOfTapsRequired = 1
        
        button.addGestureRecognizer(singleTap)
        button.addGestureRecognizer(swipeRight)
        button.addGestureRecognizer(swipeLeft)
        
        leftConstraint = button.leftAnchor.constraint(equalTo: self.leftAnchor)
        leftConstraint.isActive = true
        addConstraintsStandart(item: button, toItem: backVew, constantTrailing: 0, constantLeading: 0, constantTop: 0, constantBottom: 0)
    }
    
    private func addConstraintsStandart(item: UIView, toItem: UIView, constantTrailing: CGFloat, constantLeading: CGFloat, constantTop: CGFloat, constantBottom: CGFloat) {
        toItem.addConstraint(NSLayoutConstraint(item: item, attribute: .trailing, relatedBy: .equal, toItem: toItem, attribute: .trailing, multiplier: 1, constant: constantTrailing));
        toItem.addConstraint(NSLayoutConstraint(item: item, attribute: .leading, relatedBy: .equal, toItem: toItem, attribute: .leading, multiplier: 1, constant: constantLeading));
        toItem.addConstraint(NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: .top, multiplier: 1, constant: constantTop));
        toItem.addConstraint(NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: toItem, attribute: .bottom, multiplier: 1, constant: constantBottom));
    }
    
    public func doSwipe() {
        on = !on
        animationSwitcherButton()
        delegate?.switcherDidChangeValue(switcher: self, value: on)
    }
    
    @objc private func switcherButtonTouch(_ sender: AnyObject) {
        doSwipe()
    }
    
    @objc private func getSwipeAction( _ recognizer : UISwipeGestureRecognizer) {
        if (recognizer.direction == .right && !on) {
            doSwipe()
        } else if (recognizer.direction == .left && on) {
            doSwipe()
        }
    }
    
    private func animationSwitcherButton() {
        if (on) {
            self.leftConstraint.constant = self.onCenterPosition
            self.button.image = self.dataSource?.chSwitch(onImage: self) ?? UIImage()
            UIView.animate(withDuration: animationDuration, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                self.layoutIfNeeded()
            })
        } else {
            self.button.image = self.dataSource?.chSwitch(offImage: self) ?? UIImage()
            self.leftConstraint.constant = self.offCenterPosition
            UIView.animate(withDuration: animationDuration, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                self.layoutSubviews()
            })
        }
    }
}
