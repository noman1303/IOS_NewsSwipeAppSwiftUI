////
////  Helper.swift
////  NewsSwipeApp
////
////  Created by Noman belim on 07/01/26.
////
//
//import Foundation
//import SwiftUI
//
//struct NewsCardView: View {
//
//    let news: News
//
//    var body: some View {
//        ZStack(alignment: .bottom) {
//
//            // Background Image
//            Image(news.image)
//                .resizable()
//                .scaledToFill()
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .clipped()
//
//            // Dark Gradient Overlay
//            LinearGradient(
//                colors: [
//                    Color.black.opacity(0.0),
//                    Color.black.opacity(0.9)
//                ],
//                startPoint: .top,
//                endPoint: .bottom
//            )
//
//            // Content
//            VStack(alignment: .leading, spacing: 12) {
//
//                Text(news.title)
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//
//                Text(news.description)
//                    .font(.body)
//                    .foregroundColor(.white.opacity(0.9))
//                    .lineLimit(6)
//
//                Spacer(minLength: 16)
//
//                // CTA
//                HStack {
//                    Text("Tap to know more")
//                        .font(.subheadline)
//                        .foregroundColor(.white.opacity(0.8))
//                    Spacer()
//                }
//            }
//            .padding()
//        }
//        .clipShape(RoundedRectangle(cornerRadius: 24))
//    }
//}
//import SwiftUI
//
//struct VerticalNewsPager: View {
//
//    let newsList: [News]
//    @State private var currentIndex = 0
//    @State private var dragOffset: CGFloat = 0
//
//    var body: some View {
//        GeometryReader { geo in
//            ZStack {
//
//                Color.black.ignoresSafeArea()
//
//                VStack(spacing: 24) {
//                    ForEach(newsList.indices, id: \.self) { index in
//                        NewsCardView(news: newsList[index])
//                            .frame(
//                                width: geo.size.width - 32,
//                                height: geo.size.height * 0.82
//                            )
//                    }
//                }
//                .offset(y: offsetY(height: geo.size.height))
//                .gesture(
//                    DragGesture()
//                        .onChanged { value in
//                            dragOffset = value.translation.height
//                        }
//                        .onEnded { value in
//                            let threshold = geo.size.height * 0.15
//
//                            if value.translation.height < -threshold {
//                                currentIndex = min(currentIndex + 1, newsList.count - 1)
//                            } else if value.translation.height > threshold {
//                                currentIndex = max(currentIndex - 1, 0)
//                            }
//
//                            dragOffset = 0
//                        }
//                )
//                .animation(.spring(response: 0.4, dampingFraction: 0.85), value: currentIndex)
//            }
//        }
//    }
//
//    private func offsetY(height: CGFloat) -> CGFloat {
//        -CGFloat(currentIndex) * (height * 0.82 + 24) + dragOffset
//    }
//}
//struct News: Identifiable {
//    let id = UUID()
//    let image: String
//    let title: String
//    let description: String
//    let source: String
//}
