//
//  CommonShaders.swift
//  MetalShaders
//
//  Created by macm4 on 21/04/26.
//

import SwiftUI

protocol CommonShaders: Identifiable, CaseIterable, RawRepresentable where RawValue == String {}

extension CommonShaders {
    var id: String { rawValue }
    
    func shader(_ arguments: Shader.Argument...) -> Shader {
        Shader(
            function: .init(library: .default, name: rawValue),
            arguments: arguments
        )
    }
    var label: String {
        rawValue.separatingCapitals().capitalized
    }
}
