import SwiftUI

public struct DebugView<MainView: View>: View {
    private let view: MainView
    private let logType: LogType

    private enum LogType {
        case onlyDescription(String)
        case descriptionAndDumpView(String)
        case dumpView
    }

    private var about: String {
        switch logType {
        case let .onlyDescription(description):
            return "\(description)"
        case let .descriptionAndDumpView(description):
            return "\(description): \(view)"
        case .dumpView:
            return "\(view)"
        }
    }

    public init(view: MainView, description: String?, dumpView: Bool = true) {
        self.view = view
        if let description = description {
            if dumpView {
                logType = .descriptionAndDumpView(description)
            } else {
                logType = .onlyDescription(description)
            }
        } else {
            logType = .dumpView
        }
        print("init: \(about)")
    }

    public var body: some View {
        print("body: \(about)")
        return view
    }
}

extension View {
    public func debug() -> DebugView<Self> {
        return DebugView(view: self, description: nil)
    }

    public func debug(_ description: String, dumpView: Bool = false) -> DebugView<Self> {
        return DebugView(
            view: self,
            description: description,
            dumpView: dumpView
        )
    }
}
