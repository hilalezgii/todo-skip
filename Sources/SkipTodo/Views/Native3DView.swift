import SwiftUI
#if TARGET_OS_ANDROID
import SkipBridge
#endif

struct Native3DView: View {
    let inProgressCount: Int
    let doneCount: Int

    var body: some View {
        #if TARGET_OS_ANDROID
        ComposeView {
            try! AnyDynamicObject(className: "skip.todo.BarChartComposer", inProgressCount, doneCount)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.08, green: 0.08, blue: 0.18))
        #else
        let maxVal = max(max(inProgressCount, doneCount), 1)
        let ipHeight = max(Double(inProgressCount) / Double(maxVal) * 64 + 16, 16)
        let doneHeight = max(Double(doneCount) / Double(maxVal) * 64 + 16, 16)
        HStack(spacing: 32) {
            VStack(spacing: 6) {
                Text("\(inProgressCount)")
                    .foregroundStyle(Color.white)
                ZStack(alignment: .bottom) {
                    Color.clear.frame(height: 80)
                    Color.blue.frame(width: 56, height: min(ipHeight, 80))
                }
                Text("Todo")
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity)
            VStack(spacing: 6) {
                Text("\(doneCount)")
                    .foregroundStyle(Color.white)
                ZStack(alignment: .bottom) {
                    Color.clear.frame(height: 80)
                    Color.green.frame(width: 56, height: min(doneHeight, 80))
                }
                Text("Done")
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.08, green: 0.08, blue: 0.18))
        #endif
    }
}
