/*

The idea is that you can call view.topConstraint or view.heightConstraint on any view and you'll be given the editable constraint that deals with that attribute.
Optionally you can use the base function constraintForAttribute() and pass in the toItem and itemAttribute. It is less convienient but more accurate.

*/
import Foundation
import UIKit

public extension UIView {
    /// This computed property result may be unexpected when inspecting views with multiple constraints on an attribute.
    var ip_widthConstraint: NSLayoutConstraint? {
        return self.ip_constraintForAttribute(NSLayoutAttribute.Width)
    }
    /// This computed property result may be unexpected when inspecting views with multiple constraints on an attribute.
    var ip_heightConstraint: NSLayoutConstraint? {
        return self.ip_constraintForAttribute(NSLayoutAttribute.Height)
    }
    /// This computed property result may be unexpected when inspecting views with multiple constraints on an attribute.
    var ip_topConstraint: NSLayoutConstraint? {
        return self.ip_constraintForAttribute(NSLayoutAttribute.Top)
    }
    /// This computed property result may be unexpected when inspecting views with multiple constraints on an attribute.
    var ip_bottomConstraint: NSLayoutConstraint? {
        return self.ip_constraintForAttribute(NSLayoutAttribute.Bottom)
    }
    /// This computed property result may be unexpected when inspecting views with multiple constraints on an attribute.
    var ip_leadingConstraint: NSLayoutConstraint? {
        return self.ip_constraintForAttribute(NSLayoutAttribute.Leading)
    }
    /// This computed property result may be unexpected when inspecting views with multiple constraints on an attribute.
    var ip_trailingConstraint: NSLayoutConstraint? {
        return self.ip_constraintForAttribute(NSLayoutAttribute.Trailing)
    }
    /// This computed property result may be unexpected when inspecting views with multiple constraints on an attribute.
    var ip_centerXConstraint: NSLayoutConstraint? {
        return self.ip_constraintForAttribute(NSLayoutAttribute.CenterX)
    }
    /// This computed property result may be unexpected when inspecting views with multiple constraints on an attribute.
    var ip_centerYConstraint: NSLayoutConstraint? {
        return self.ip_constraintForAttribute(NSLayoutAttribute.CenterY)
    }
    
    /**
    More precise way of getting constraints for a view. The constraint does not have to belong to the reciever -- this method searches the superview for the matching constraint as well.
    
    :param: attribute     Attribute to look for belonging to the receiver
    :param: toItem        Probably a UIView, that the receiver is related to.
    :param: itemAttribute Attribute that should be used with the toItem
    
    :returns: The first constraint that matches. May return unexpected constraint if receiver contains multiple constraints with this item and itemAttribute.
    */
    func ip_constraintForAttribute(attribute: NSLayoutAttribute, toItem: UIView? = nil, itemAttribute: NSLayoutAttribute? = nil) -> NSLayoutConstraint? {
        
        //when there is a toItem AND an itemConstraint
        if let toAttribute = itemAttribute, let item = toItem {
            if let constraints = self.superview?.constraints() {
                for constraint in constraints {
                    if (constraint.firstItem as? UIView == self &&
                        constraint.firstAttribute == attribute &&
                        constraint.secondItem as? UIView == item &&
                        constraint.secondAttribute == toAttribute) ||
                        (constraint.secondItem as? UIView == self &&
                            constraint.secondAttribute == attribute &&
                            constraint.firstItem as? UIView == item &&
                            constraint.firstAttribute == toAttribute) {
                        return constraint as? NSLayoutConstraint;
                    }
                }
            }
        }
        
        //when there is a toItem present.
        if let item = toItem {
            if let constraints = self.superview?.constraints() {
                for constraint in constraints {
                    if (constraint.firstItem as? UIView == self &&
                        constraint.firstAttribute == attribute &&
                        constraint.secondItem as? UIView == item) ||
                        (constraint.secondItem as? UIView == self &&
                            constraint.secondAttribute == attribute &&
                            constraint.firstItem as? UIView == item) {
                        return constraint as? NSLayoutConstraint;
                    }
                }
            }
        }
        
        //For size constraints
        if attribute == .Height || attribute == .Width {
            for constraint in self.constraints() {
                if constraint.firstItem as? UIView == self &&
                    constraint.firstAttribute == attribute {
                    return constraint as? NSLayoutConstraint;
                }
            }
        }

        //For positioning constraints without toItem and itemAttribute
        if let constraints = self.superview?.constraints() {
            for constraint in constraints {
                if (constraint.firstItem as? UIView == self &&
                    constraint.firstAttribute == attribute) ||
                    (constraint.secondItem as? UIView == self &&
                        constraint.secondAttribute == attribute) {
                    return constraint as? NSLayoutConstraint;
                }
            }
        }
        
        return nil;
    }
}