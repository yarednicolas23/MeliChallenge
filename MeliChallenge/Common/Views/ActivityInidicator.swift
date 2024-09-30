//
//  ActivityInidicator.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import SwiftUI

struct ActivityIndicator: View {
    
    // MARK: - Private properties -
    
    @State private var degress = 0.0
    @State private var timer: Timer?
    
    // MARK: - Public properties -
    
    let size: CGFloat
    let color: Color
    var velocity: Double = 5.0

    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray, lineWidth: 1.0)
                .frame(width: size, height: size)
            Circle()
                .trim(from: 0.0, to: 0.6)
                .stroke(color, lineWidth: size < 50 ? 1 : 2.0)
                .frame(width: size, height: size)
                .rotationEffect(Angle(degrees: degress))
                .padding(5)
        }
        .onAppear { self.start() }
        .onDisappear { self.stop() }
    }

    // MARK: - Private methods -
    
    private func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            withAnimation {
                self.degress += self.velocity
            }
            if self.degress == 360.0 {
                self.degress = .zero
            }
        }
    }

    private func stop() {
        if timer != nil {
            timer!.invalidate()
        }
    }
}
