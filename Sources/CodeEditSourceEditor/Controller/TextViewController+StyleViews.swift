//
//  TextViewController+StyleViews.swift
//  CodeEditSourceEditor
//
//  Created by Khan Winter on 7/3/24.
//

import AppKit
import CodeEditTextView

extension TextViewController {
    package func generateParagraphStyle() -> NSMutableParagraphStyle {
        // swiftlint:disable:next force_cast
        let paragraph = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraph.tabStops.removeAll()
        paragraph.defaultTabInterval = CGFloat(tabWidth) * fontCharWidth
        return paragraph
    }

    /// Style the text view.
    package func styleTextView() {
        textView.selectionManager.selectionBackgroundColor = theme.selection
        textView.selectionManager.selectedLineBackgroundColor = getThemeBackground()
        textView.selectionManager.highlightSelectedLine = isEditable
        textView.selectionManager.insertionPointColor = theme.insertionPoint
        paragraphStyle = generateParagraphStyle()
        textView.typingAttributes = attributesFor(nil)
    }

    /// Finds the preferred use theme background.
    /// - Returns: The background color to use.
    private func getThemeBackground() -> NSColor {
        if useThemeBackground {
            return theme.lineHighlight
        }

        if systemAppearance == .darkAqua {
            return NSColor.quaternaryLabelColor
        }

        return NSColor.selectedTextBackgroundColor.withSystemEffect(.disabled)
    }

    /// Style the gutter view.
    package func styleGutterView() {
        gutterView.frame.origin.y = -scrollView.contentInsets.top
        gutterView.selectedLineColor = useThemeBackground ? theme.lineHighlight : systemAppearance == .darkAqua
        ? NSColor.quaternaryLabelColor
        : NSColor.selectedTextBackgroundColor.withSystemEffect(.disabled)
        gutterView.highlightSelectedLines = isEditable
        gutterView.font = font.rulerFont
        gutterView.backgroundColor = useThemeBackground ? theme.background : .textBackgroundColor
        if self.isEditable == false {
            gutterView.selectedLineTextColor = nil
            gutterView.selectedLineColor = .clear
        }
    }

    /// Style the scroll view.
    package func styleScrollView() {
        guard let scrollView = view as? NSScrollView else { return }
        
        scrollView.isFindBarVisible = false
        
        scrollView.drawsBackground = useThemeBackground
        scrollView.backgroundColor = useThemeBackground ? theme.background : .clear
        if let contentInsets {
            scrollView.automaticallyAdjustsContentInsets = false
            scrollView.contentInsets = contentInsets
        } else {
            
           // scrollView.automaticallyAdjustsContentInsets = false //true to avoid top (toolbar?) space for use as text field or area in forms
            scrollView.automaticallyAdjustsContentInsets = false //true
        }
        scrollView.contentInsets.bottom = (contentInsets?.bottom ?? 0) + bottomContentInsets
        
        
        scrollView.contentInsets.top = -50
        
        
//        print("//debug 2503030700 scrollView.superview?.superview?.frame: \(scrollView.superview?.superview?.frame ?? CGRect.zero)")
//        print("//debug 2503030700 scrollView.superview?.frame: \(scrollView.superview?.frame ?? CGRect.zero)")
//        print("//debug 2503030700 scrollView.frame: \(scrollView.frame)")
//        print("//debug 2503030700 scrollView.contentView.frame: \(scrollView.contentView.frame)")
//        print("//debug 2503030700 scrollView.contentView.subviews.first?.frame: \(scrollView.contentView.subviews.first?.frame ?? CGRect.zero)")
//        print("//debug 2503030700 scrollView.contentView.subviews.first?.subviews.first?.frame: \(scrollView.contentView.subviews.first?.subviews.first?.frame ?? CGRect.zero)")
    }
}
