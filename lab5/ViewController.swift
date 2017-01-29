//
//  ViewController.swift
//  lab5
//
//  Created by Семен Никулин on 29.01.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataReader = DataReader(filename: "data.txt")
        let data = dataReader.read()
        let ray = data.0
        let segments = data.1
        var min: CGFloat? = nil
        var minSegment: Segment? = nil
        
        segments.forEach({
            if GeometryHelper.rayIntersection(ray: ray, segment: $0) {
                if let m = min {
                    if GeometryHelper.distanceFromPoint(p: ray.begin, segment: $0) < m {
                        min = GeometryHelper.distanceFromPoint(p: ray.begin, segment: $0)
                        minSegment = $0
                    }
                } else {
                    min = GeometryHelper.distanceFromPoint(p: ray.begin, segment: $0)
                    minSegment = $0
                }
            }
            
        })
        
        if let m = min, let seg = minSegment {
            print("Min distance = \(m)")
            print("Segment = (\(seg.a.x),\(seg.a.y)) (\(seg.b.x),\(seg.b.y))")
        } else {
            print("Not found")
        }
    }
}

