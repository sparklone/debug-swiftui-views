import SwiftUI
import PlaygroundSupport

private class Holder {
    var id: Int

    init(id: Int) {
        self.id = id
    }
}

private struct MyListView: View {

    @State var numberOfViews: Int = 1
    var body: some View {
        VStack(spacing: 30) {
            ForEach(0..<numberOfViews, id: \.self) { id in
                Text("\(id)").debug("Text: \(id)")
                //MyText().debug("MyText: \(id)")
                //MyTextEquatable().debug("MyTextEquatable: \(id)")
                //StupidView(id: id).debug("StupidView: \(id)")
                //StupidViewWithHolder(holder: Holder(id: id))
                    .debug("StupidViewWithHolder: \(id)")
            }
            HStack {
                Text("\(numberOfViews)")
                Button("numberOfViews") {
                    self.numberOfViews += 1
                }
            }
        }
    }
}

private struct MyText: View {
    var body: some View {
        return Text("\(Int.random(in: 0...100))")
    }
}

private struct MyTextEquatable: View, Equatable {
    private let id: Int
    init() {
        id = Int.random(in: 0...100)
    }
    var body: some View {
        return Text("\(id)")
    }
}

private struct StupidView: View, Equatable {
    private let id: Int
    init(id: Int) {
        self.id = id
    }

    var body: some View {
        return Text("\(id)")
    }

    static func == (lhs: StupidView, rhs: StupidView) -> Bool {
        return false
    }
}

private struct StupidViewWithHolder: View, Equatable {
    private let holder: Holder
    init(holder: Holder) {
        self.holder = holder
    }

    var body: some View {
        return Text("\(holder.id)")
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return false
    }
}

PlaygroundPage.current.setLiveView(MyListView().debug("MyListView"))
