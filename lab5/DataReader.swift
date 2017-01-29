//
//  DataReader.swift
//  lab5
//
//  Created by Семен Никулин on 29.01.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import Foundation
import UIKit

class DataReader {
    var filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    func read() -> (Ray, [Segment]) {
        if let path = Bundle.main.path(forResource: "data", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                var lines = data.components(separatedBy: .newlines)
                let ray = createRay(line: lines[0])
                lines.remove(at: 0)
                let segments = createSegments(lines: lines)
                return (ray, segments)
            } catch(let error) { print(error) }
        }
        fatalError()
    }
    
    func getPoints(line: String) -> [CGPoint] {
        var points = [CGPoint]()
        let part = line.components(separatedBy: " ")
        let startPart = part[0].components(separatedBy: ",")
        let pointPart = part[1].components(separatedBy: ",")
        points.append(CGPoint(x: Double(startPart[0]) ?? 0, y: Double(startPart[1]) ?? 0))
        points.append(CGPoint(x: Double(pointPart[0]) ?? 0, y: Double(pointPart[1]) ?? 0))
        return points
    }
    
    func createRay(line: String) -> Ray {
        let points = getPoints(line: line)
        return Ray(begin: points[0], point: points[1])
    }
    
    func createSegment(line: String) -> Segment {
        let points = getPoints(line: line)
        return Segment(a: points[0], b: points[1])
    }
    
    func createSegments(lines: [String]) -> [Segment] {
        var segments = [Segment]()
        lines.forEach({
            if $0.characters.count > 0 {
                segments.append(createSegment(line: $0))
            }
        })
        return segments
    }
}
