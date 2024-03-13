//
//  ThermalAnnotationView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 3/7/24.
//

import MapKit

class ThermalAnnotationView: MKAnnotationView {
    var id: String? = nil
    
    enum IconColor: String {
        case green = "green"
        case red = "red"
        case blue =  "blue"
    }
    
    var iconColor: IconColor {
        didSet {
            drawIcon()
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        self.iconColor = .green
        if let thermalAnnotation = annotation as? ThermalAnnotation {
            switch thermalAnnotation.userType {
            case .ownUser:
                self.iconColor = .green
            case .otherUser:
                self.iconColor = .blue
            }
            self.id = thermalAnnotation.id
        }
        
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        drawIcon()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawIcon() {
        var icon = UIImage(systemName: "arrowshape.up.fill")
        
        var color: UIColor
        switch self.iconColor {
        case .green:
            color = .systemGreen
        case .red:
            color = .systemRed
        case .blue:
            color = .systemBlue
        }
        icon = icon?.withTintColor(color, renderingMode: .alwaysOriginal)
        
        let size = CGSize(width: 40, height: 40)
        
        // Bug with coloring not working with MKAnnotationView UIImage required
        // UIGraphicsImageRenderer to be used
        let thing = UIGraphicsImageRenderer(size: size).image { _ in
            icon?.draw(in: CGRect(origin:.zero, size:size))
        }
        
        self.image = thing
    }
    
    func activateIcon() {
        self.iconColor = .red
    }
    func deactivateIcon() {
        if let thermalAnnotation = self.annotation as? ThermalAnnotation {
            switch thermalAnnotation.userType {
            case .ownUser:
                self.iconColor = .green
            case .otherUser:
                self.iconColor = .blue
            }
        }
    }
}
