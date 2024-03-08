//
//  GlidingMapViewController+Delegate.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/20/24.
//

import MapKit

extension GlidingMapViewController: MKMapViewDelegate {
//    @MainActor
//    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
//        guard let thermal = fetchThermalFromAnnotation(annotation: annotation) else { return }
//        self.present(ThermalModalController(thermal), animated: true)
//        self.mapView.deselectAnnotation(annotation, animated: false)
//    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = GlidingMapViewConfig.polylineStrokeColor
            renderer.lineWidth = GlidingMapViewConfig.polylineLineWidth
            return renderer
        }
        return MKOverlayRenderer()
    }
    
//    func fetchThermalFromAnnotation(annotation: MKAnnotation) -> Thermal? {
//        guard let thermalAnnotation = annotation as? ThermalAnnotation else { return nil }
//        let thermalFilter = self.thermalStore.thermals.filter({ $0.id == thermalAnnotation.id })
//        if thermalFilter.count > 0 {
//            return thermalFilter[0]
//        }
//        return nil
//    }
    
    func fetchThermalFromAnnotationView(annotationView: MKAnnotationView) -> Thermal? {
        guard let thermalAnnotationView = annotationView as? ThermalAnnotationView else { return nil }
        guard let thermalAnnotation = thermalAnnotationView.annotation as? ThermalAnnotation else { return nil }
        
        let thermalFilter = self.thermalStore.thermals.filter({ $0.id == thermalAnnotation.id })
        if thermalFilter.count > 0 {
            return thermalFilter[0]
        }
        
        return nil
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        return ThermalAnnotationView(annotation: annotation, reuseIdentifier: nil)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let thermal = fetchThermalFromAnnotationView(annotationView: view) else { return }
        self.present(ThermalModalController(thermal, thermalStore, self, view), animated: true)
        self.mapView.deselectAnnotation(view.annotation, animated: false)
        
        guard let view = view as? ThermalAnnotationView else { return }
        
    }
}

