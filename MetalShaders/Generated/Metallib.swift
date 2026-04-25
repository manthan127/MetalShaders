// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// TODO: - SwiftGen
// if the function is [[ stitchable ]] make a function that takes the appropriate typed parameters to use in SwiftUI Views
// this is only tested in iOS for now need to test in all different platforms
// there is no swift4 template will create later if needed

import Metal
#if canImport(SwiftUI)
import SwiftUI
#endif

// `enum Default` is created from the .metal files in the project
// any other enum inside MetalLibs is created if the project contains any precompiled .metalib files
 enum MetalLibs {
      static let library = LibConvertible()

      enum visible {
          static let stripes = FunctionConvertible(name: "stripes", library: library)
          static let square2 = FunctionConvertible(name: "square2", library: library)
          static let radialGradient = FunctionConvertible(name: "radialGradient", library: library)
          static let solidColor = FunctionConvertible(name: "solidColor", library: library)
          static let ring = FunctionConvertible(name: "ring", library: library)
          static let diagonalGradient = FunctionConvertible(name: "diagonalGradient", library: library)
          static let square = FunctionConvertible(name: "square", library: library)
          static let radialPattern = FunctionConvertible(name: "radialPattern", library: library)
          static let gridPattern = FunctionConvertible(name: "gridPattern", library: library)
          static let pulsingColor = FunctionConvertible(name: "pulsingColor", library: library)
          static let saturate = FunctionConvertible(name: "saturate", library: library)
          static let spotlight = FunctionConvertible(name: "spotlight", library: library)
          static let flagsColor = FunctionConvertible(name: "flagsColor", library: library)
          static let rotatingPattern = FunctionConvertible(name: "rotatingPattern", library: library)
          static let solidRed = FunctionConvertible(name: "solidRed", library: library)
          static let OG = FunctionConvertible(name: "OG", library: library)
          static let concentricCircles = FunctionConvertible(name: "concentricCircles", library: library)
          static let checkerboard = FunctionConvertible(name: "checkerboard", library: library)
          static let greenChannel = FunctionConvertible(name: "greenChannel", library: library)
          static let brighten = FunctionConvertible(name: "brighten", library: library)
          static let smoothCircle = FunctionConvertible(name: "smoothCircle", library: library)
          static let circle = FunctionConvertible(name: "circle", library: library)
          static let adjustableBrightness = FunctionConvertible(name: "adjustableBrightness", library: library)
          static let solidBlue = FunctionConvertible(name: "solidBlue", library: library)
          static let redChannel = FunctionConvertible(name: "redChannel", library: library)
          static let horizontalGradient = FunctionConvertible(name: "horizontalGradient", library: library)
          static let solidGreen = FunctionConvertible(name: "solidGreen", library: library)
          static let blueChannel = FunctionConvertible(name: "blueChannel", library: library)
          static let verticalGradient = FunctionConvertible(name: "verticalGradient", library: library)
      }
   enum DefaultMacOS {
      static let library = LibConvertible(path: "default-macOS")

      enum vertex {
          static let vertexShader = FunctionConvertible(name: "vertexShader", library: library)
      }
      enum fragment {
          static let fragmentShader = FunctionConvertible(name: "fragmentShader", library: library)
      }
  }
}

// MARK: - Implementation Details

fileprivate let device = MTLCreateSystemDefaultDevice()
 struct LibConvertible {
    let library: MTLLibrary
    let url: URL? // use nil for default library
    
    init?(path: String) {
        if let url = BundleToken.bundle.url(forResource: path, withExtension: "metallib"), let library = try? device?.makeLibrary(URL: url) {
            self.url = url
            self.library = library
        } else {
            return nil
        }
    }
    
    init?() {
        if let library = device?.makeDefaultLibrary() {
            self.url = nil
            self.library = library
        } else {
            return nil
        }
    }
    
    func makeFunction(name: String) -> MTLFunction? {
        library.makeFunction(name: name)
    }
    
    func makeShaderLibrary() -> ShaderLibrary {
        if let url = url {
            return ShaderLibrary(url: url)
        } else {
            return .default
        }
    }
}

 struct FunctionConvertible {
     let name: String
     let library: LibConvertible? // need to do some this about optionality of this property
    
     func makeMTLFunction() -> MTLFunction? {
        return library?.makeFunction(name: name)!
    }
#if canImport(SwiftUI)
     func callAsFunction(_ arguments: Shader.Argument...) -> Shader {
        return Shader(function: ShaderFunction(library: library?.makeShaderLibrary() ?? .default, name: name), arguments: arguments)
    }
#endif
}


// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
