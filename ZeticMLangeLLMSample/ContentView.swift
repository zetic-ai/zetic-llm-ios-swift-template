import SwiftUI
import AVFoundation
import Vision
import ZeticMLange

struct ContentView: View {
    @StateObject var viewModel: LLMChatViewModel = LLMChatViewModel()
    @FocusState var isFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            if !viewModel.isModelLoaded {
                ProgressView("Downloading... \(viewModel.progress * 100)%", value: viewModel.progress, total: 1.0)
                    .progressViewStyle(.linear)
                    .frame(width: 250)
                
            } else {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.messages) { message in
                                ChatBubble(message: message)
                            }
                            
                            if viewModel.isAITyping {
                                HStack {
                                    Text("AI is typing...")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                            }
                        }
                    }
                    .onChange(of: viewModel.messages) { _ in
                        withAnimation {
                            if let lastMessage = viewModel.messages.last {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                isFocused = false
                            }
                    )
                }
                
                Divider()
                
                HStack(spacing: 8) {
                    TextField("Message", text: $viewModel.inputText)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .focused($isFocused)
                        .disabled(viewModel.isAITyping)
                        .onSubmit {
                            viewModel.sendMessage()
                        }
                    
                    Button(action: viewModel.sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(viewModel.canSendMessage ? .blue : .gray)
                    }
                    .disabled(!viewModel.canSendMessage)
                }
                .padding(12)
            }
        }
        .onAppear {
            viewModel.initModel()
        }
        .onDisappear {
            viewModel.cleanUp()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button {
            viewModel.cleanUp()
            dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
                Text("Back")
            }
        })
    }
}
