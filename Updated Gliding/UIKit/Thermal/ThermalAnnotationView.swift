//
//  ThermalAnnotationView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 3/7/24.
//

import MapKit

class ThermalAnnotationView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let icon = UIImage(systemName: "arrowshape.up.fill")
        let coloredIcon = icon?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        let size = CGSize(width: 40, height: 40)
        
        // Bug with coloring not working with MKAnnotationView UIImage required
        // UIGraphicsImageRenderer to be used
        let thing = UIGraphicsImageRenderer(size: size).image { _ in
            coloredIcon?.draw(in: CGRect(origin:.zero, size:size))
        }
        
        self.image = thing
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
