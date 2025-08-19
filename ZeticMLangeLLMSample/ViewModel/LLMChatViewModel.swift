import SwiftUI
import AVFoundation
import Vision
import ZeticMLange


@MainActor
class LLMChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var inputText: String = ""
    @Published var isAITyping = false
    @Published var isModelLoaded = false
    @Published var progress: Float = 0
    
    private var mlangeModel: ZeticMLangeLLMModel?
    private var tokenGenerationTask: Task<Void, Error>?
    
    func initModel() {
        if mlangeModel != nil { return }
        
        DispatchQueue.global().async {
            let mlangeModel = try? ZeticMLangeLLMModel(
                tokenKey: Constants.MLANGE.personalAccessKey,
                name: Constants.MLANGE.modelName,
            ) { progress in
                DispatchQueue.main.async {
                    self.progress = progress
                }
            }
            
            DispatchQueue.main.async {
                self.mlangeModel = mlangeModel
                self.isModelLoaded = true
            }
        }
    }
    
    func sendMessage() {
        guard canSendMessage, let mlangeModel = mlangeModel else { return }
        
        let text = inputText.trimmingCharacters(in: .whitespaces)
        let userMessage = Message(content: text, isFromUser: true)
        messages.append(userMessage)
        inputText = ""
        
        isAITyping = true
        let aiMessage = Message(content: "", isFromUser: false)
        messages.append(aiMessage)
        
        var response = ""
        
        tokenGenerationTask = Task {
            do {
                try mlangeModel.run(text)
                
                while !Task.isCancelled {
                    let token = mlangeModel.waitForNextToken()
                    if token.isEmpty {
                        await MainActor.run {
                            isAITyping = false
                        }
                        break
                    }
                    
                    response.append(token)
                    
                    await MainActor.run {
                        if let msgIndex = messages.firstIndex(where: { $0.id == aiMessage.id }) {
                            messages[msgIndex].content = response
                        }
                    }
                }
            } catch {
                print("Error running model: \(error)")
                await MainActor.run {
                    isAITyping = false
                }
            }
            
            await MainActor.run {
                if self.tokenGenerationTask?.isCancelled == false {
                    self.tokenGenerationTask = nil
                }
            }
        }
    }
    
    var canSendMessage: Bool {
        !inputText.isEmpty && !isAITyping && isModelLoaded
    }
    
    func cancelTokenGeneration() {
        tokenGenerationTask?.cancel()
        tokenGenerationTask = nil
        
        if isAITyping {
            isAITyping = false
        }
    }
    
    func cleanUp() {
        cancelTokenGeneration()
        mlangeModel = nil
        isModelLoaded = false
    }
    
    deinit {
        tokenGenerationTask?.cancel()
        tokenGenerationTask = nil
    }
}
