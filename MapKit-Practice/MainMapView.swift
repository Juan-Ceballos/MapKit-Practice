//
//  MapView.swift
//  MapKit-Practice
//
//  Created by Juan Ceballos on 3/23/22.
//

import UIKit
import MapKit

class MainMapView: UIView {
    
    public var scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    public var mKMapView: MKMapView = {
        let mkmv = MKMapView()
        return mkmv
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    private func commonInit() {
       setupMKMapViewConstraints()
    }
    
    private func setupMKMapViewConstraints() {
        addSubview(mKMapView)
        mKMapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mKMapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mKMapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mKMapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mKMapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
