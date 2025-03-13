//
//  AsyncImageView.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//
import SwiftUI
import WebKit

struct SVGWebView: UIViewRepresentable {
    let svgData: Data?
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.backgroundColor = .clear
        webView.isOpaque = false
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let svgData = svgData,
              let svgString = String(data: svgData, encoding: .utf8) else {
            uiView.loadHTMLString("<html><body><p>Failed to load SVG</p></body></html>", baseURL: nil)
            return
        }
        
        let htmlString = """
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style>
                body { margin: 0; padding: 0; background-color: transparent; display: flex; justify-content: center; align-items: center; height: 100vh; }
                svg { max-width: 100%; height: auto; }
            </style>
        </head>
        <body>
            <div>\(svgString)</div>
        </body>
        </html>
        """
        
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}

struct AsyncImageView: View, Identifiable {
    @State private var svgData: Data?
    @State private var currentURL: URL?
    let id: UUID = .init()
    let url: URL
    let size: CGSize
    
    var body: some View {
        if let svgData {
            SVGWebView(svgData: svgData)
                .frame(width: size.width, height: size.height)
                .background(.clear)
        } else {
            // Show placeholder while loading
            ProgressView()
                .frame(width: size.width, height: size.height)
                .background(Color.gray.opacity(0.3))
                .onAppear {
                    if currentURL != url {
                        currentURL = url
                        downloadSVG()
                    }
                }
        }
    }
    
    func downloadSVG() {
        if let cachedData = SVGCache.shared.get(url) {
            self.svgData = cachedData
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data, currentURL == url else { return }
            runOnMainThread {
                SVGCache.shared.set(url, data: data)
                self.svgData = data
            }
        }.resume()
    }
}
