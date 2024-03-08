//
//  ThermalAnnotationView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 3/7/24.
//

import MapKit

class ThermalAnnotationView: MKAnnotationView {
    enum IconColor: String {
        case green = "green"
        case red = "red"
    }
    
    var iconColor: IconColor {
        didSet {
            drawIcon()
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        self.iconColor = .green
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        drawIcon()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawIcon() {
        var icon = UIImage(systemName: "arrowshape.up.fill")
        
        switch self.iconColor {
        case .green:
            icon = icon?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        case .red:
            icon = icon?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        }
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
        self.iconColor = .green
    }
}
