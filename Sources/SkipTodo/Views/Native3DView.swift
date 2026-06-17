import SwiftUI

struct Native3DView: View {
    let inProgressCount: Int
    let doneCount: Int

    private var total: Int { inProgressCount + doneCount }

    var body: some View {
        if total > 0 {
            BarChartView(inProgressCount: inProgressCount, doneCount: doneCount)
        }
    }
}

struct BarChartView: View {
    let inProgressCount: Int
    let doneCount: Int

    let maxBarHeight: CGFloat = 120.0
    let minBarHeight: CGFloat = 16.0

    var body: some View {
        let maxVal = max(max(inProgressCount, doneCount), 1)
        let ipHeight = max(CGFloat(inProgressCount) / CGFloat(maxVal) * maxBarHeight, minBarHeight)
        let doneHeight = max(CGFloat(doneCount) / CGFloat(maxVal) * maxBarHeight, minBarHeight)

        HStack(spacing: 32) {
            BarColumn(count: inProgressCount, barHeight: ipHeight, color: Color(red: 0.1, green: 0.55, blue: 1.0), label: "Todo")
            BarColumn(count: doneCount, barHeight: doneHeight, color: Color(red: 0.2, green: 0.85, blue: 0.45), label: "Done")
        }
        .frame(maxWidth: .infinity)
        .frame(height: maxBarHeight + 64)
        .padding(.horizontal, 48)
        .background(Color(red: 0.08, green: 0.08, blue: 0.18))
        .cornerRadius(12)
        .padding(.horizontal, 16)
    }
}

struct BarColumn: View {
    let count: Int
    let barHeight: CGFloat
    let color: Color
    let label: String

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text("\(count)")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(Color.white)
                .padding(.bottom, 4)
            Rectangle()
                .fill(color)
                .frame(width: 56, height: barHeight)
                .cornerRadius(4)
            Text(label)
                .font(.system(size: 12))
                .foregroundStyle(Color(red: 0.7, green: 0.7, blue: 0.85))
                .padding(.top, 6)
        }
        .frame(maxWidth: .infinity)
    }
}
