//
//  ContentView.swift
//  WeSplit
//
//  Created by Baris Ciftci on 20/12/2023.
//

import SwiftUI
import Foundation
import WebKit

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable{
    let source: Source
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
}

struct Source: Codable {
    let id: String?
    let name: String
}

import SwiftUI

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    
    func fetchNews() async {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?q=apple&from=2023-12-07&to=2023-12-07&sortBy=popularity&apiKey=e7c00742a71b450b9403d52090fc70ce") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
            DispatchQueue.main.async {
                self.articles = newsResponse.articles
            }
        } catch {
            print("Error fetching or decoding data: \(error)")
        }
    }
}

struct NewsView: View {
    
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.articles, id: \.source.id) { article in
                
                VStack(alignment: .leading) {
                    ZStack {
                        NavigationLink("", destination: NewsArticleWebView(newsUrl: article.url))
                        AsyncImage(url: URL(string: article.urlToImage)) { image in
                                            image
                                .resizable()
                                        } placeholder: {
                                            Image(systemName: "photo.artframe")
                                                .resizable()
                                                .scaledToFit()
        }
                                    .frame(height: 200)
                    }
                    Text(article.title)
                        .font(.headline)
                        .fontWeight(.black)
                    
                    Text(article.description)
                        .font(.subheadline)
                        .lineLimit(2)
                    
                    Text(article.source.name)
                        .font(.footnote)
                        .foregroundStyle(.pink)
                    
                    Text(article.author ?? "Unknown Author")
                        .font(.footnote)
                        .fontWeight(.black)
                }
            }
            .listStyle(.plain)
            .task {
                await viewModel.fetchNews()
                    
                    
            }
            .refreshable {
                await viewModel.fetchNews()
            }
            .navigationTitle("News")

        }
    }
}

struct NewsArticleWebView: View {
    var newsUrl: String
    @Environment(\.presentationMode) var mode
    var body: some View {
        
        SwiftUIWebView(urlString: newsUrl)
    }
}

struct SwiftUIWebView: UIViewRepresentable {
    
    var urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        {
            guard let url = URL(string: urlString) else {
                return WKWebView()
            }
            
            let request = URLRequest(url: url)
            let webView = WKWebView()
            webView.load(request)
            return webView
        }()
    }
    
    
    
   
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

#Preview {
    NewsView()
}
