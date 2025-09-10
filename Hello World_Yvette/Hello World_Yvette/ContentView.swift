import SwiftUI

struct ContentView: View {
    // Animation states
    @State private var isAnimating = false
    @State private var textScale: CGFloat = 0.1
    @State private var starOpacity: Double = 0
    @State private var ringRotation: Double = 0
    @State private var pulseAmount: CGFloat = 1.0
    @State private var showParticles = false
    @State private var greeting = "Hello"
    @State private var planetOffset: CGFloat = -300
    
    // Array of greetings in different languages
    let greetings = ["Hello", "Hola", "Bonjour", "こんにちは", "你好", "Ciao", "안녕하세요", "مرحبا"]
    let colors = [Color.purple, Color.pink, Color.blue, Color.cyan, Color.mint, Color.indigo]
    
    var body: some View {
        ZStack {
            // Animated gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.07, green: 0.0, blue: 0.15),
                    Color(red: 0.15, green: 0.0, blue: 0.25),
                    Color(red: 0.25, green: 0.05, blue: 0.4)
                ]),
                startPoint: isAnimating ? .topLeading : .bottomTrailing,
                endPoint: isAnimating ? .bottomTrailing : .topLeading
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 8).repeatForever(autoreverses: true), value: isAnimating)
            
            // Animated stars in background
            ForEach(0..<50, id: \.self) { index in
                Circle()
                    .fill(Color.white)
                    .frame(width: CGFloat.random(in: 1...3))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                    )
                    .opacity(starOpacity)
                    .animation(
                        .easeInOut(duration: Double.random(in: 2...4))
                        .repeatForever(autoreverses: true)
                        .delay(Double.random(in: 0...2)),
                        value: starOpacity
                    )
            }
            
            VStack(spacing: 40) {
                // Floating planet/orb
                ZStack {
                    // Outer glow
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.cyan.opacity(0.3), Color.purple.opacity(0.1), Color.clear],
                                center: .center,
                                startRadius: 50,
                                endRadius: 150
                            )
                        )
                        .frame(width: 300, height: 300)
                        .blur(radius: 20)
                        .scaleEffect(pulseAmount)
                    
                    // Rotating rings
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [Color.cyan, Color.purple, Color.pink],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 3
                        )
                        .frame(width: 180, height: 180)
                        .rotationEffect(.degrees(ringRotation))
                    
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [Color.pink, Color.orange, Color.yellow],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 2
                        )
                        .frame(width: 200, height: 200)
                        .rotationEffect(.degrees(-ringRotation * 1.5))
                    
                    // Central planet
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color(red: 0.9, green: 0.6, blue: 1.0),
                                    Color(red: 0.6, green: 0.3, blue: 0.9),
                                    Color(red: 0.3, green: 0.1, blue: 0.7)
                                ],
                                center: UnitPoint(x: 0.3, y: 0.3),
                                startRadius: 5,
                                endRadius: 80
                            )
                        )
                        .frame(width: 150, height: 150)
                        .overlay(
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color.white.opacity(0.4), Color.clear],
                                        startPoint: UnitPoint(x: 0.3, y: 0.2),
                                        endPoint: UnitPoint(x: 0.7, y: 0.8)
                                    )
                                )
                                .frame(width: 140, height: 140)
                        )
                        .shadow(color: Color.purple, radius: 30)
                }
                .offset(y: planetOffset)
                
                // Main animated text
                VStack(spacing: 10) {
                    Text(greeting)
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.cyan, Color.purple, Color.pink],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .scaleEffect(textScale)
                        .shadow(color: .cyan, radius: 10)
                        .shadow(color: .purple, radius: 20)
                    
                    Text("World")
                        .font(.system(size: 60, weight: .black, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.pink, Color.orange, Color.yellow],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .scaleEffect(textScale)
                        .rotationEffect(.degrees(isAnimating ? -2 : 2))
                        .shadow(color: .pink, radius: 15)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
                }
                
                // Subtitle with typing effect
                Text("Welcome to the Cosmos")
                    .font(.system(size: 20, weight: .medium, design: .monospaced))
                    .foregroundColor(.white.opacity(0.8))
                    .shadow(color: .white, radius: 5)
                    .opacity(starOpacity)
                
                // Interactive button
                Button(action: {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                        // Change greeting
                        greeting = greetings.randomElement() ?? "Hello"
                        // Trigger particle effect
                        showParticles.toggle()
                        // Bounce effect
                        textScale = 0.8
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.spring()) {
                                textScale = 1.0
                            }
                        }
                    }
                }) {
                    ZStack {
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [Color.purple, Color.pink, Color.orange],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 200, height: 50)
                        
                        Capsule()
                            .stroke(Color.white.opacity(0.5), lineWidth: 2)
                            .frame(width: 200, height: 50)
                        
                        Text("✨ Tap to Explore ✨")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .scaleEffect(isAnimating ? 1.05 : 1.0)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isAnimating)
                    .shadow(color: .purple, radius: 10)
                }
                .opacity(starOpacity)
            }
            
            // Particle effects when button is tapped
            if showParticles {
                ForEach(0..<20, id: \.self) { index in
                    Image(systemName: ["star.fill", "sparkle", "star", "sparkle.magnifyingglass", "star.circle.fill"].randomElement()!)
                        .foregroundColor(colors.randomElement() ?? .white)
                        .font(.system(size: CGFloat.random(in: 20...40)))
                        .position(
                            x: UIScreen.main.bounds.width / 2,
                            y: UIScreen.main.bounds.height / 2 + 100
                        )
                        .offset(
                            x: showParticles ? CGFloat.random(in: -150...150) : 0,
                            y: showParticles ? CGFloat.random(in: -300...100) : 0
                        )
                        .scaleEffect(showParticles ? CGFloat.random(in: 0.1...0.5) : 1.0)
                        .opacity(showParticles ? 0 : 1)
                        .animation(.easeOut(duration: 2.0).delay(Double(index) * 0.05), value: showParticles)
                        .rotationEffect(.degrees(showParticles ? Double.random(in: 0...360) : 0))
                }
            }
        }
        .onAppear {
            // Start all animations
            withAnimation(.easeOut(duration: 1.5)) {
                textScale = 1.0
                planetOffset = 0
            }
            
            withAnimation(.easeIn(duration: 2).delay(0.5)) {
                starOpacity = 1.0
            }
            
            withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                ringRotation = 360
            }
            
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                pulseAmount = 1.2
            }
            
            isAnimating = true
        }
    }
}

#Preview {
    ContentView()
}
