import SwiftUI

// MARK: - Model
struct Chapter: Identifiable {
    let id = UUID()
    let title: String
    let examples: [ChapterExample]
}

struct ChapterExample: Identifiable {
    let id = UUID()
    let title: String
    let viewBuilder: () -> AnyView
}

// MARK: - Main ContentView
struct ContentView: View {
    // Chapters data
    let chapters: [Chapter] = [
        Chapter(title: "Chapter 1: The GPU Canvas", examples: [
            ChapterExample(title: "Colored Rectangle", viewBuilder: { AnyView(chapter1()) }),
            ChapterExample(title: "Brightness", viewBuilder: { AnyView(Brightness()) }),
            ChapterExample(title: "Color Channel Isolation", viewBuilder: { AnyView(ColorChannelIsolation()) }),
            ChapterExample(title: "Flag Creator", viewBuilder: { AnyView(FlagCreator()) }),
            ChapterExample(title: "Animated Pulse", viewBuilder: { AnyView(AnimatedPulse()) })
        ]),
        Chapter(title: "Chapter 2: The Coordinate System", examples: [
            ChapterExample(title: "Chapter 2 Shaders", viewBuilder: { AnyView(Chapter2Shaders()) }),
            ChapterExample(title: "Spotlight Effect", viewBuilder: { AnyView(SpotlightView()) }),
            ChapterExample(title: "Rotating Pattern", viewBuilder: { AnyView(RotatingPatternView()) })
        ]),
        Chapter(title: "Chapter 3: Color Mathematics", examples: [
            ChapterExample(title: "Chapter 3 Shaders", viewBuilder: { AnyView(Chapter3Shaders()) }),
        ]),
        
    ]
    
    var body: some View {
        NavigationStack {
            List(chapters) { chapter in
                NavigationLink(destination: ExampleListView(chapter: chapter)) {
                    Text(chapter.title)
                }
            }
            .navigationTitle("Chapters")
        }
    }
}

struct ExampleListView: View {
    let chapter: Chapter
    var body: some View {
        List(chapter.examples) { example in
            NavigationLink(destination: example.viewBuilder()) {
                Text(example.title)
            }
        }
        .navigationTitle(chapter.title)
    }
}

#Preview {
    ContentView()
}
