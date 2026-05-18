import SwiftUI

struct TodoInput: View {
    @Binding var text: String
    let onAdd: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            #if SKIP
            TextField("Yeni todo ekle...", text: $text)
                .textFieldStyle(.plain)
                .font(.body)
                .foregroundStyle(.white)
                .tint(.white)
                .padding(.horizontal, 12)
                .frame(height: 44)
                .background(Color(red: 0.18, green: 0.18, blue: 0.28))
                .cornerRadius(12)
                .colorScheme(.dark)
            #else
            TextField("Yeni todo ekle...", text: $text)
                .textFieldStyle(.plain)
                .font(.body)
                .foregroundStyle(.white)
                .tint(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 13)
                .background(Color(red: 0.18, green: 0.18, blue: 0.28))
                .cornerRadius(12)
                .colorScheme(.dark)
            #endif

            Button(action: onAdd) {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundStyle(Color(red: 1.0, green: 0.5, blue: 0.1))
            }
        }
        .padding(.horizontal)
    }
}
