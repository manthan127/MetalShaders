//
//  String.swift
//  MetalShaders
//
//  Created by macm4 on 21/04/26.
//


extension String {
    func separatingCapitals() -> String {
        return self.replacingOccurrences(
            of: "(?<=[a-z])(?=[A-Z])",
            with: " ",
            options: .regularExpression
        )
        
        //guard !s.isEmpty else { return s }
        //
        //return zip(s, s.dropFirst()).reduce(String(s.first!)) { result, pair in
        //    let (current, next) = pair
        //    return result + (current.isLowercase && next.isUppercase ? " \(next)" : "\(next)")
        //}
    }
}
