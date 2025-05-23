//
//  InfiniteScrollView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 03.05.2025.
//

import SwiftUI

struct InfiniteScrollView<Content: View>: View {
    var spacing: CGFloat = 20
    @ViewBuilder var content: Content
    
    @State private var contentSize: CGSize = .zero
    var body: some View {
        GeometryReader{
            let size = $0.size
            ScrollView(.horizontal){
                HStack(spacing: spacing){
                    if #available(iOS 18.0, *) {
                        Group(subviews: content){ collection in
                            // Original content
                            HStack(spacing: spacing){
                                ForEach(collection){ view in
                                    view
                                }
                            }
                            .onGeometryChange(for: CGSize.self) {
                                $0.size
                            } action: { newValue in
                                contentSize = .init(width: newValue.width + spacing, height: newValue.height)
                            }
                            
                            let averageWidth = contentSize.width / CGFloat(collection.count)
                            let repeatingCount = contentSize.width > 0 ? Int((size.width / averageWidth).rounded()) + 1 : 1
                            
                            HStack(spacing: spacing) {
                                ForEach(0..<repeatingCount, id: \.self){ index in
                                    let view = Array(collection)[index % collection.count]
                                    
                                    view
                                }
                            }
                            
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                }
                .background(InfiniteScrollHelper(declarationRate: .constant(.fast), contentSize: $contentSize))
            }
        }
    }
}

//#Preview {
//    InfiniteScrollView()
//}

fileprivate struct InfiniteScrollHelper: UIViewRepresentable {
    @Binding var declarationRate: UIScrollView.DecelerationRate
    @Binding var contentSize: CGSize
    func makeCoordinator() -> Coordinator {
        Coordinator(declarationRate: declarationRate, contentSize: contentSize)
    }
    
    func makeUIView(context: Context) -> UIView{
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        DispatchQueue.main.async {
            if let scrollView = view.scrollView {
                context.coordinator.defaultDelegate = scrollView.delegate
                scrollView.decelerationRate = declarationRate
                scrollView.delegate = context.coordinator
            }
        }
        
        return view
    }
    
    
    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.declarationRate = declarationRate
        context.coordinator.contentSize = contentSize
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate{
        var declarationRate: UIScrollView.DecelerationRate
        var contentSize: CGSize
        init(declarationRate: UIScrollView.DecelerationRate, contentSize: CGSize) {
            self.declarationRate = declarationRate
            self.contentSize = contentSize
        }
        
        //Storing Default SwiftUI delegate
        weak var defaultDelegate: UIScrollViewDelegate?
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            //Updating Declaration Rate
            scrollView.decelerationRate = declarationRate
            let minX = scrollView.contentOffset.x
            
            if minX > contentSize.width {
                scrollView.contentOffset.x -= contentSize.width
            }
            
            if minX < 0 {
                scrollView.contentOffset.x -= contentSize.width
            }
            //Calling default Delegate once our Cust finished
            
            defaultDelegate?.scrollViewDidScroll?(scrollView)
        }
        //Calling other defalt Callbacks
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            defaultDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            defaultDelegate?.scrollViewDidEndDecelerating?(scrollView)
        }
        
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            defaultDelegate?.scrollViewWillBeginDragging?(scrollView)
        }
        
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            defaultDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
        
    }
}


extension UIView{
    var scrollView: UIScrollView?{
        if let superview, superview is UIScrollView {
            return superview as? UIScrollView
        }
        return superview?.scrollView
    }
}
