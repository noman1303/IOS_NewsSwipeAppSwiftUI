//
//  Helper.swift
//  NewsSwipeApp
//
//  Created by Noman belim on 07/01/26.
//

import Foundation
import SwiftUI

struct NewsCardView: View {
    let news: NewsItem
    
    var body: some View {
        VStack(spacing: 0) {
            // IMAGE SECTION
            ZStack {
                Rectangle()
                    .fill(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
                
                // Using system image for demo, replace with yours
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .foregroundColor(.white)
                
                Image(news.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(height: UIScreen.main.bounds.height * 0.40)
            .clipped()
            
            // CONTENT SECTION
            VStack(alignment: .leading, spacing: 15) {
                Text(news.title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.primary)
                
                Text(news.content)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineSpacing(1)
                
//                Spacer()
            }
            .padding(25)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: UIScreen.main.bounds.height * 0.50)
            .background(Color(UIColor.systemBackground))
            
            // FOOTER SECTION
            VStack {
                Spacer()
                Text(news.TapToKnow)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.gray.opacity(0.8))
            }
            .frame(height: UIScreen.main.bounds.height * 0.10)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color(UIColor.systemBackground))
        .ignoresSafeArea()
    }
}
