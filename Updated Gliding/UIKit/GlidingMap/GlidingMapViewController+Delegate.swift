//
//  GlidingMapViewController+Delegate.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/20/24.
//

import MapKit

extension GlidingMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        guard let thermal = fetchThermalFromAnnotation(annotation: annotation) else { return }
        self.present(ThermalModalController(thermal), animated: true)
        self.mapView.deselectAnnotation(annotation, animated: false)
    }
    
    
    func fetchThermalFromAnnotation(annotation: MKAnnotation) -> Thermal? {
        guard let thermalAnnotation = annotation as? ThermalAnnotation else { return nil }
        let thermalFilter = self.thermals.filter({ $0.id == thermalAnnotation.id })
        if thermalFilter.count > 0 {
            return thermalFilter[0]
        }
        return nil
    }
}

