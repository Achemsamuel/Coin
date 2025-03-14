//
//  RemoteImageLoader.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//
import SwiftUI

public struct RemoteImage: View {
    private let id: UUID = UUID()
    private var url: URL?
    private var scaleImage: Bool
    private let cornerRadius: CGFloat
    private let height: CGFloat
    private let width: CGFloat
    private let placeHolder: AnyView
    
    public init(url: URL?, scaleImage: Bool = false,
                cornerRadius: CGFloat = .zero,
                height: CGFloat,
                width: CGFloat,
                placeHolder: AnyView) {
        self.url = url
        self.scaleImage = scaleImage
        self.cornerRadius = cornerRadius
        self.height = height
        self.width = width
        self.placeHolder = placeHolder
    }
    
    public var body: some View {
        if url?.pathExtension.lowercased() == "svg", let url = url {
            AsyncImageView(url: url, size: CGSize(width: width, height: height))
        } else {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                placeHolder
            }
            .frame(width: width, height: height)
        }
    }
}
