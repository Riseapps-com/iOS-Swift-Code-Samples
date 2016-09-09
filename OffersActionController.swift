//
//  OffersActionViewController.swift
//  AppXBussiness
//
//  Created by Dima Nikolayenko on 9/2/16.
//  Copyright © 2016 Dima Nikolayenko. All rights reserved.
//

import UIKit

enum OfferAction {
    case Complete, Discard, Cancel
}

enum Mode {
    case Full, Discard
}

class OffersActionController: DialogueBaseViewController {
    
    var completeActionClosure: ((action: OfferAction) -> ())?
    var discardActionClosure: ((action: OfferAction) -> ())?
    var cancelActionClosure: ((action: OfferAction) -> ())?
    
    @IBOutlet private weak var completeButton: UIButton?
    @IBOutlet private weak var discardButton: UIButton?
    @IBOutlet private weak var cancelButton: UIButton?
    
    var completeButtonTitle: String = "Complete".localized {
        didSet {
            completeButton?.setTitle(completeButtonTitle.uppercaseString, forState: .Normal)
        }
    }
    
    var discardButtonTitle: String = "Discard".localized {
        didSet {
            discardButton?.setTitle(discardButtonTitle.uppercaseString, forState: .Normal)
        }
    }
    
    var mode: Mode = .Full {
        didSet {
            switch mode {
            case .Full:
                completeButton?.hidden = false
            case .Discard:
                completeButton?.hidden = true
            }
        }
    }
    
    class func actionController() -> OffersActionController {
        return UIStoryboard.dialoguesStoryboard().instantiateViewControllerWithIdentifier(String(OffersActionController)) as! OffersActionController
    }
    
    func showFromViewController(viewController: UIViewController?) {
        modalPresentationStyle = .Custom
        var _ = view // load ouutlets
        
        shadowView.alpha = 0
        actionView.transform = CGAffineTransformMakeTranslation(0, actionView.frame.size.height)
        
        let parentVC = viewController ?? UIApplication.sharedApplication().keyWindow?.rootViewController!
        
        parentVC!.presentViewController(self, animated: false, completion: {
            UIView.animateWithDuration(DialogueBaseViewController.animationDuration(),
                delay: 0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0,
                options:.AllowUserInteraction,
                animations:
                {
                    self.shadowView.alpha = 1
                    self.actionView.transform = CGAffineTransformMakeTranslation(0, 0)
                }, completion: nil)
        })
    }
    
    @IBAction func onCompleteButtonTapped(sender: UIButton) {
        dismissWithSelectedAction {
            if self.completeActionClosure != nil {
                self.completeActionClosure!(action: .Complete)
            }
        }
    }
    
    @IBAction func onDiscardButtonTapped(sender: UIButton) {
        dismissWithSelectedAction {
            if self.discardActionClosure != nil {
                self.discardActionClosure!(action: .Discard)
            }
        }
    }
    
    @IBAction func onCancelButtonTapped(sender: UIButton) {
        dismissWithSelectedAction {
            if self.cancelActionClosure != nil {
                self.cancelActionClosure!(action: .Cancel)
            }
        }
    }
    
    func dismissWithSelectedAction(completionClosure: (() -> Void)?){
        UIView.animateWithDuration(DialogueBaseViewController.animationDuration(),
                                   delay: 0,
                                   usingSpringWithDamping: 0.7,
                                   initialSpringVelocity: 0,
                                   options:.AllowUserInteraction,
                                   animations:
            {
                self.shadowView.alpha = 0.0
                self.actionView.transform = CGAffineTransformMakeTranslation(0, self.actionView.frame.size.height)
        }) { (finished) in
            if finished {
                self.dismissViewControllerAnimated(true, completion: nil)
                if completionClosure != nil {
                    completionClosure!()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeButton?.setTitle(completeButtonTitle.uppercaseString, forState: .Normal)
        discardButton?.setTitle(discardButtonTitle.uppercaseString, forState: .Normal)
        cancelButton?.setTitle("Cancel".localized.uppercaseString, forState: .Normal)
        
        completeButton?.layer.cornerRadius = cornerRadius
        discardButton?.layer.cornerRadius = cornerRadius
        cancelButton?.layer.cornerRadius = cornerRadius
        
        switch mode {
        case .Full:
            completeButton?.hidden = false
        case .Discard:
            completeButton?.hidden = true
        }
    }
}
