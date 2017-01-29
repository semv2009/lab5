//
//  GeometryHelper.swift
//  lab5
//
//  Created by Семен Никулин on 29.01.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import Foundation
import UIKit

struct Ray {
    var begin: CGPoint
    var point: CGPoint
}

struct Segment {
    var a: CGPoint
    var b: CGPoint
}
class GeometryHelper {
    
    static func distanceFromPoint(p: CGPoint, segment: Segment) -> CGFloat {
        let v = segment.a
        let w = segment.b
        let pv_dx = p.x - v.x
        let pv_dy = p.y - v.y
        let wv_dx = w.x - v.x
        let wv_dy = w.y - v.y
        
        let dot = pv_dx * wv_dx + pv_dy * wv_dy
        let len_sq = wv_dx * wv_dx + wv_dy * wv_dy
        let param = dot / len_sq
        
        var int_x, int_y: CGFloat
        
        if param < 0 || (v.x == w.x && v.y == w.y) {
            int_x = v.x
            int_y = v.y
        } else if param > 1 {
            int_x = w.x
            int_y = w.y
        } else {
            int_x = v.x + param * wv_dx
            int_y = v.y + param * wv_dy
        }
        
        let dx = p.x - int_x
        let dy = p.y - int_y
        
        return sqrt(dx * dx + dy * dy)
    }
    
    static func detetminant(m: [Array<CGFloat>]) -> CGFloat {
        return m[0][0] * m[1][1] - m[0][1] * m[1][0]
    }
    
    static func matrixCeilReplace(matrix: [Array<CGFloat>],replacement: [CGFloat], ceil: Int) -> [Array<CGFloat>] {
        var newMatrix = matrix
        for i in 0...replacement.count - 1 {
            newMatrix[i][ceil] = replacement[i]
        }
        return newMatrix
    }
    
    static func rayIntersection(ray: Ray, segment: Segment) -> Bool {
        var matrix = [Array<CGFloat>()]
        let gipo = sqrt(pow(ray.point.x-ray.begin.x, 2) + pow(ray.point.y-ray.begin.y, 2))
        let cos = (ray.point.x-ray.begin.x) / gipo
        let sin = (ray.point.y-ray.begin.y) / gipo
        
        matrix[0].insert(segment.b.x-segment.a.x, at: 0)
        matrix[0].insert(cos * (-1), at: 1)
        matrix.insert([CGFloat](), at: 1)
        matrix[1].insert(segment.b.y-segment.a.y, at: 0)
        matrix[1].insert(sin * (-1), at: 1)
        
        var res = [CGFloat]()
        res.append((segment.a.x - ray.begin.x) * (-1))
        res.append((segment.a.y - ray.begin.y) * (-1))
        
        let d = detetminant(m: matrix)
        if d == 0 {
            return false
        }
        
        let d1 = detetminant(m: matrixCeilReplace(matrix: matrix, replacement: res, ceil: 0))
        matrix = matrixCeilReplace(matrix: matrix, replacement: res, ceil: 0)
        let d2 = detetminant(m: matrixCeilReplace(matrix: matrix, replacement: res, ceil: 1))
        let t1 = d1 / d
        let t2 = d2 / d
        
        let str = String(describing: t2)
        if t2 >= 0 && t1 >= 0 && t1 <= 1  && str.range(of:"-0.0") == nil {
            return true
        }
        return false
    }
}
