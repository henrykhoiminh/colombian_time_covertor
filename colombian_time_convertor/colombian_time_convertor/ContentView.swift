//
//  ContentView.swift
//  colombian_time_convertor
//
//  Created by Henry Tran on 7/6/25.
//

import SwiftUI

enum EventType: String, CaseIterable {
    case dinner = "Dinner"
    case movies = "Movies"
    case date = "Date"
    case beachVacation = "Beach Vacation"
    case wedding = "Wedding"
    case elegantNight = "Special Occasion"
    case court = "Court"
    
    var isInformal: Bool {
        switch self {
        case .dinner, .movies, .date, .beachVacation:
            return true
        case .wedding, .elegantNight, .court:
            return false
        }
    }
    
    var emoji: String {
        switch self {
        case .dinner: return "🍽️"
        case .movies: return "🎬"
        case .date: return "💕"
        case .beachVacation: return "🏖️"
        case .wedding: return "💒"
        case .elegantNight: return "🌃"
        case .court: return "⚖️"
        }
    }
}

struct ContentView: View {
    @State private var currentStep = 1
    @State private var targetTime = Date()
    @State private var totalParticipants = 1
    @State private var colombianParticipants = 0
    @State private var selectedEventType: EventType = .dinner
    @State private var hasSpicyColombianWomen = false
    @State private var calculatedTime = Date()
    @State private var showResult = false
    
    // Updated Colombian inspired colors for yellow background
    let colombianYellow = Color(hex: "#FFD700")
    let darkColombianYellow = Color(hex: "#FFC107")
    let colombianRed = Color(hex: "#DA291C")
    let andeanBlue = Color(hex: "#0033A0")
    let emeraldGreen = Color(hex: "#00A86B")
    let caribbeanCoral = Color(hex: "#FF6F61")
    let coffeeBrown = Color(hex: "#4B2E2E")
    let lightYellow = Color(hex: "#FFF8DC")
    let warmOrange = Color(hex: "#FF8C00")
    
    var body: some View {
        ZStack {
            // Background gradient - Colombian yellow theme
            LinearGradient(
                gradient: Gradient(colors: [colombianYellow, darkColombianYellow]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header with Progress
                headerView
                
                // Step Content
                TabView(selection: $currentStep) {
                    // Step 1: Time Selection
                    step1TimeSelection
                        .tag(1)
                    
                    // Step 2: Event Type
                    step2EventType
                        .tag(2)
                    
                    // Step 3: Total Participants
                    step3TotalParticipants
                        .tag(3)
                    
                    // Step 4: Colombian Count
                    step4ColombianCount
                        .tag(4)
                    
                    // Step 5: Spicy Colombian Women (The Ultimate Question!)
                    step5SpicyColombianWomen
                        .tag(5)
                    
                    // Step 6: Results
                    step6Results
                        .tag(6)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .gesture(DragGesture().onChanged { _ in }) // Disable swipe navigation
                .animation(.easeInOut(duration: 0.3), value: currentStep)
            }
        }
    }
    
    // MARK: - Header View
    private var headerView: some View {
        VStack(spacing: 16) {
            // Title
            VStack(spacing: 8) {
                Text("Colombian Time")
                    .font(.title.bold())
                    .foregroundColor(andeanBlue)
                
                Text("Convertor")
                    .font(.title3)
                    .foregroundColor(coffeeBrown)
            }
            
            // Progress Bar
            HStack(spacing: 8) {
                ForEach(1...6, id: \.self) { step in
                    Circle()
                        .fill(step <= currentStep ? andeanBlue : coffeeBrown.opacity(0.3))
                        .frame(width: 10, height: 10)
                        .scaleEffect(step == currentStep ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: currentStep)
                }
            }
            .padding(.bottom, 8)
            
            // Step Indicator
            Text(stepTitle)
                .font(.title2)
                .foregroundColor(coffeeBrown)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    // MARK: - Step 1: Time Selection
    private var step1TimeSelection: some View {
        VStack(spacing: 32) {
            Spacer()
            
            VStack(spacing: 24) {
                Image(systemName: "calendar.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(andeanBlue)
                
                DatePicker(
                    "",
                    selection: $targetTime,
                    in: Date()...,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.wheel)
                .tint(andeanBlue)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(lightYellow)
                        .shadow(color: coffeeBrown.opacity(0.2), radius: 8, x: 0, y: 4)
                )
            }
            
            nextButton(enabled: true) {
                withAnimation {
                    currentStep = 2
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - Step 2: Event Type
    private var step2EventType: some View {
        VStack(spacing: 32) {
            Spacer()
            
            VStack(spacing: 24) {
                Image(systemName: "list.bullet.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(emeraldGreen)
                
                Text("What type of event?")
                    .font(.title2.bold())
                    .foregroundColor(coffeeBrown)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 16) {
                    Text("Selected Event")
                        .font(.headline)
                        .foregroundColor(coffeeBrown)
                    
                    // Dropdown Menu
                    Menu {
                        ForEach(EventType.allCases, id: \.self) { eventType in
                            Button(action: {
                                selectedEventType = eventType
                            }) {
                                HStack {
                                    Text(eventType.rawValue)
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedEventType.emoji)
                                .font(.title2)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(selectedEventType.rawValue)
                                    .font(.headline)
                                    .foregroundColor(coffeeBrown)
                                
                                Text(selectedEventType.isInformal ? "Informal" : "Formal")
                                    .font(.caption)
                                    .foregroundColor(coffeeBrown.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .font(.caption)
                                .foregroundColor(coffeeBrown)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(lightYellow)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(andeanBlue, lineWidth: 2)
                                )
                        )
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(lightYellow)
                        .shadow(color: coffeeBrown.opacity(0.2), radius: 8, x: 0, y: 4)
                )
            }
            
            HStack(spacing: 16) {
                backButton {
                    withAnimation {
                        currentStep = 1
                    }
                }
                
                nextButton(enabled: true) {
                    withAnimation {
                        currentStep = 3
                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - Step 3: Total Participants
    private var step3TotalParticipants: some View {
        VStack(spacing: 32) {
            Spacer()
            
            VStack(spacing: 24) {
                Image(systemName: "person.3.fill")
                    .font(.system(size: 60))
                    .foregroundColor(caribbeanCoral)
                
                Text("How many people total?")
                    .font(.title2.bold())
                    .foregroundColor(coffeeBrown)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 20) {
                    Text(totalParticipants >= 20 ? "20+" : "\(totalParticipants)")
                        .font(.system(size: 72, weight: .bold))
                        .foregroundColor(andeanBlue)
                    
                    Text(totalParticipants == 1 ? "person" : "people")
                        .font(.title3)
                        .foregroundColor(coffeeBrown)
                    
                    HStack(spacing: 20) {
                        TextField("", value: $totalParticipants, format: .number)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 100)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .onChange(of: totalParticipants) { _, newValue in
                                if newValue < 1 {
                                    totalParticipants = 1
                                } else if newValue > 20 {
                                    totalParticipants = 20
                                }
                                
                                if colombianParticipants > totalParticipants {
                                    colombianParticipants = totalParticipants
                                }
                            }
                        
                        VStack(spacing: 8) {
                            Button(action: {
                                if totalParticipants < 20 {
                                    totalParticipants += 1
                                }
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(totalParticipants < 20 ? emeraldGreen : coffeeBrown.opacity(0.5))
                            }
                            .disabled(totalParticipants >= 20)
                            
                            Button(action: {
                                if totalParticipants > 1 {
                                    totalParticipants -= 1
                                    if colombianParticipants > totalParticipants {
                                        colombianParticipants = totalParticipants
                                    }
                                }
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(totalParticipants > 1 ? colombianRed : coffeeBrown.opacity(0.5))
                            }
                            .disabled(totalParticipants <= 1)
                        }
                    }
                    
                    if totalParticipants >= 20 {
                        Text("Maximum 20 people")
                            .font(.caption)
                            .foregroundColor(coffeeBrown)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(lightYellow)
                        .shadow(color: coffeeBrown.opacity(0.2), radius: 8, x: 0, y: 4)
                )
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                backButton {
                    withAnimation {
                        currentStep = 2
                    }
                }
                
                nextButton(enabled: true) {
                    withAnimation {
                        currentStep = 4
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - Step 4: Colombian Count
    private var step4ColombianCount: some View {
        VStack(spacing: 32) {
            Spacer()
            
            VStack(spacing: 24) {
                Text("🇨🇴")
                    .font(.system(size: 60))
                
                VStack(spacing: 8) {
                    Text("The important question...")
                        .font(.title3)
                        .foregroundColor(coffeeBrown.opacity(0.7))
                        .multilineTextAlignment(.center)
                    
                    Text("How many are Colombian?")
                        .font(.title2.bold())
                        .foregroundColor(coffeeBrown)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 20) {
                    Text("\(colombianParticipants)")
                        .font(.system(size: 72, weight: .bold))
                        .foregroundColor(andeanBlue)
                    
                    Text("out of \(totalParticipants)")
                        .font(.title3)
                        .foregroundColor(coffeeBrown)
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            if colombianParticipants > 0 {
                                colombianParticipants -= 1
                            }
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.system(size: 44))
                                .foregroundColor(colombianParticipants > 0 ? colombianRed : coffeeBrown.opacity(0.5))
                        }
                        .disabled(colombianParticipants <= 0)
                        
                        Button(action: {
                            if colombianParticipants < totalParticipants {
                                colombianParticipants += 1
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 44))
                                .foregroundColor(colombianParticipants < totalParticipants ? emeraldGreen : coffeeBrown.opacity(0.5))
                        }
                        .disabled(colombianParticipants >= totalParticipants)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(lightYellow)
                        .shadow(color: coffeeBrown.opacity(0.2), radius: 8, x: 0, y: 4)
                )
                
                if colombianParticipants > 0 {
                    Text("😅 Ah, now we're getting somewhere!")
                        .font(.subheadline)
                        .foregroundColor(caribbeanCoral)
                        .italic()
                        .transition(.opacity)
                }
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                backButton {
                    withAnimation {
                        currentStep = 3
                    }
                }
                
                nextButton(enabled: true) {
                    withAnimation {
                        currentStep = 5
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - Step 5: Spicy Colombian Women
    private var step5SpicyColombianWomen: some View {
        VStack(spacing: 32) {
            Spacer()
            
            VStack(spacing: 24) {
                Text("🌶️👩🏽‍🦱")
                    .font(.system(size: 60))
                
                VStack(spacing: 8) {
                    Text("The ULTIMATE question...")
                        .font(.title3)
                        .foregroundColor(coffeeBrown.opacity(0.7))
                        .multilineTextAlignment(.center)
                    
                    Text("Are there any spicy hot-blooded Colombian women in the group?")
                        .font(.title2.bold())
                        .foregroundColor(coffeeBrown)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        // No Button
                        Button(action: {
                            hasSpicyColombianWomen = false
                        }) {
                            VStack(spacing: 8) {
                                Text("😇")
                                    .font(.system(size: 40))
                                
                                Text("No")
                                    .font(.title2.bold())
                                    .foregroundColor(hasSpicyColombianWomen ? coffeeBrown.opacity(0.5) : andeanBlue)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(hasSpicyColombianWomen ? lightYellow.opacity(0.5) : lightYellow)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(hasSpicyColombianWomen ? coffeeBrown.opacity(0.3) : andeanBlue, lineWidth: 2)
                                    )
                            )
                        }
                        
                        // Yes Button
                        Button(action: {
                            hasSpicyColombianWomen = true
                        }) {
                            VStack(spacing: 8) {
                                Text("🌶️")
                                    .font(.system(size: 40))
                                
                                Text("¡Sí!")
                                    .font(.title2.bold())
                                    .foregroundColor(!hasSpicyColombianWomen ? coffeeBrown.opacity(0.5) : colombianRed)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(!hasSpicyColombianWomen ? lightYellow.opacity(0.5) : lightYellow)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(!hasSpicyColombianWomen ? coffeeBrown.opacity(0.3) : colombianRed, lineWidth: 2)
                                    )
                            )
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(lightYellow)
                        .shadow(color: coffeeBrown.opacity(0.2), radius: 8, x: 0, y: 4)
                )
                
                if hasSpicyColombianWomen {
                    Text("🔥 ¡Ay, Dios mío! We're in trouble now!")
                        .font(.subheadline)
                        .foregroundColor(colombianRed)
                        .italic()
                        .transition(.opacity)
                }
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                backButton {
                    withAnimation {
                        currentStep = 4
                    }
                }
                
                nextButton(enabled: true, title: "Calculate!") {
                    calculateColombianTime()
                    withAnimation {
                        currentStep = 6
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - Step 6: Results
    private var step6Results: some View {
        VStack(spacing: 32) {
            Spacer()
            
            VStack(spacing: 24) {
                Text("🎉")
                    .font(.system(size: 60))
                
                Text("¡Ya voy, ya voy...!")
                    .font(.title.bold())
                    .foregroundColor(andeanBlue)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 20) {
                    // Original Time
                    VStack(spacing: 8) {
                        Text("Original Time")
                            .font(.headline)
                            .foregroundColor(coffeeBrown)
                        
                        Text(targetTime.formatted(date: .abbreviated, time: .shortened))
                            .font(.title2)
                            .foregroundColor(coffeeBrown)
                    }
                    
                    Image(systemName: "arrow.down.circle.fill")
                        .font(.title)
                        .foregroundColor(emeraldGreen)
                    
                    // Colombian Time
                    VStack(spacing: 8) {
                        Text("Colombian Time")
                            .font(.headline)
                            .foregroundColor(coffeeBrown)
                        
                        Text(calculatedTime.formatted(date: .abbreviated, time: .shortened))
                            .font(.title.bold())
                            .foregroundColor(andeanBlue)
                    }
                }
                .padding(24)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(lightYellow)
                        .shadow(color: coffeeBrown.opacity(0.2), radius: 8, x: 0, y: 4)
                )
                
                // Calculation Breakdown
                VStack(spacing: 8) {
                    Text("Calculation Breakdown:")
                        .font(.headline)
                        .foregroundColor(coffeeBrown)
                    
                    VStack(spacing: 4) {
                        Text(getCalculationBreakdown())
                            .font(.subheadline)
                            .foregroundColor(coffeeBrown)
                            .multilineTextAlignment(.center)
                        
                        if hasSpicyColombianWomen {
                            Text("+ Spicy Colombian women bonus 🌶️")
                                .font(.subheadline.bold())
                                .foregroundColor(colombianRed)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(lightYellow.opacity(0.7))
                )
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button("Start Over") {
                    withAnimation {
                        currentStep = 1
                        showResult = false
                        // Reset values
                        totalParticipants = 1
                        colombianParticipants = 0
                        hasSpicyColombianWomen = false
                        selectedEventType = .dinner
                        targetTime = Date()
                        calculatedTime = Date()
                    }
                }
                .foregroundColor(andeanBlue)
                .font(.headline)
                
                Button("Share Result") {
                    shareResult()
                }
                .foregroundColor(coffeeBrown)
                .font(.subheadline)
            }
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - Helper Views
    private func nextButton(enabled: Bool, title: String = "Next", action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(enabled ? lightYellow : coffeeBrown.opacity(0.5))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    enabled ?
                    LinearGradient(
                        gradient: Gradient(colors: [andeanBlue, emeraldGreen]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ) :
                    LinearGradient(
                        gradient: Gradient(colors: [coffeeBrown.opacity(0.3), coffeeBrown.opacity(0.3)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(12)
                .shadow(color: enabled ? andeanBlue.opacity(0.3) : .clear, radius: 8, x: 0, y: 4)
        }
        .disabled(!enabled)
    }
    
    private func backButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .font(.headline)
            .foregroundColor(coffeeBrown)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(coffeeBrown, lineWidth: 2)
            )
        }
    }
    
    // MARK: - Computed Properties
    private var stepTitle: String {
        switch currentStep {
        case 1: return "Step 1: When is your event?"
        case 2: return "Step 2: What type of event?"
        case 3: return "Step 3: How many people total?"
        case 4: return "Step 4: The crucial question... 🇨🇴"
        case 5: return "Step 5: The ULTIMATE question... 🌶️"
        case 6: return "¡Tranquilo, que allá llego!"
        default: return ""
        }
    }
    
    // MARK: - Functions
    private func calculateColombianTime() {
        var delayMinutes = 0
        
        // Only apply Colombian time delay if there are more than 1 Colombian participants
        if colombianParticipants > 0 {
            if selectedEventType.isInformal {
                // Informal events logic
                if totalParticipants < 2 {
                    delayMinutes = 8
                } else {
                    delayMinutes = 8 + (totalParticipants - 1) * 5
                }
                
                if hasSpicyColombianWomen {
                    delayMinutes += 15
                }
            } else {
                // Formal events logic
                delayMinutes = 60 + (totalParticipants * 3)
                
                if hasSpicyColombianWomen {
                    delayMinutes += 43
                }
            }
        }
        // If colombianParticipants <= 1, delayMinutes remains 0
        
        calculatedTime = Calendar.current.date(byAdding: .minute, value: delayMinutes, to: targetTime) ?? targetTime
    }
    
    private func getCalculationBreakdown() -> String {
        // If there are 1 or fewer Colombians, no delay is applied
        if colombianParticipants < 1 {
            return "Not enough Colombians to activate the effect! 😅"
        }
        
        var breakdown = ""
        
        if selectedEventType.isInformal {
            if totalParticipants < 2 {
                breakdown = "Base: 8 minutes"
            } else {
                breakdown = "Base: 8 min + \(totalParticipants - 1) × 5 min"
            }
            
            if hasSpicyColombianWomen {
                breakdown += " + 15 min"
            }
        } else {
            breakdown = "Base: 60 min + \(totalParticipants) × 3 min"
            
            if hasSpicyColombianWomen {
                breakdown += " + 43 min"
            }
        }
        
        let totalMinutes = Calendar.current.dateComponents([.minute], from: targetTime, to: calculatedTime).minute ?? 0
        breakdown += " = \(totalMinutes) minutes"
        
        return breakdown
    }
    
    private func shareResult() {
        let totalMinutes = Calendar.current.dateComponents([.minute], from: targetTime, to: calculatedTime).minute ?? 0
        
        let shareText = """
        🇨🇴 Colombian Time Calculator Results! 🇨🇴
        
        Event: \(selectedEventType.emoji) \(selectedEventType.rawValue)
        Original time: \(targetTime.formatted(date: .abbreviated, time: .shortened))
        Colombian time: \(calculatedTime.formatted(date: .abbreviated, time: .shortened))
        
        Total delay: \(totalMinutes) minutes
        \(hasSpicyColombianWomen ? "🌶️ Spicy Colombian women factor included!" : "")
        
        ¡Ya voy, ya voy...! 😅
        """
        
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        // For iPad support
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = UIApplication.shared.windows.first
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootViewController = window.rootViewController {
            rootViewController.present(activityVC, animated: true)
        }
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    ContentView()
}
