//
//  CollectionLayout.swift
//  InstagramClone
//
//  Created by Stephen Brundage on 11/2/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation
import UIKit

class CollectionLayout: UICollectionViewLayout {
    
    fileprivate var numberOfColumns = 3
    fileprivate var cellPadding: CGFloat = 3
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        
        guard let collectionView = collectionView else {
            return 0
        }
        
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right) - (cellPadding * (CGFloat(numberOfColumns) - 1))
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        
        let itemsPerRow = 3
        
        // Normal Content will be displayed 'normally' within the collectionView
        let normalColumnWidth: CGFloat = contentWidth / CGFloat(itemsPerRow)
        let normalColumnHeight: CGFloat = normalColumnWidth
        
        // Featured Content will be displayed larged within the collectionView
        let featuredColumnWidth: CGFloat = (normalColumnWidth * 2) + cellPadding
        let featuredColumnHeight: CGFloat = featuredColumnWidth
        
        var xOffsets: [CGFloat] = [CGFloat]()
        
        /* The first 6 normally displayed images will be displayed equally within the collection view */
        
        // We generate their x positions
        for item in 0..<6 {
            // Create a multiplier based on how many items per row
            let multiplier = item % itemsPerRow
            
            // Create x position for each of the 6 items based on column width and cell padding
            let xPos = CGFloat(multiplier) * (normalColumnWidth + cellPadding)
            
            // Add generated x offset to array to use later
            xOffsets.append(xPos)
        }
        
        // After the first 6 images, the next one will be a featured image which will start at x position 0
        xOffsets.append(0)
        
        // Next, we handle images 8 and 9 which will have the same xPosition
        for _ in 0..<2 {
            xOffsets.append(featuredColumnWidth + cellPadding)
        }
        
        var yOffsets: [CGFloat] = [CGFloat]()
        
        // Generate their y positions
        for item in 0..<9 {
            var yPos = floor(Double(item / 3)) * (Double(normalColumnHeight) + Double(cellPadding))
            
            if item == 8 {
                yPos += (Double(normalColumnHeight) + Double(cellPadding))
            }
            
            yOffsets.append(CGFloat(yPos))
        }
        
        // Section is just when the pattern will repeat
        let numberOfItemsPerSection = 9
        let heightOfSection: CGFloat = 4 * normalColumnHeight + (4 + cellPadding)
        
        var itemInSection = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let xPos = xOffsets[itemInSection]
            let multiplier = floor(Double(item) / Double(numberOfItemsPerSection))
            let yPos = yOffsets[itemInSection] + (heightOfSection * CGFloat(multiplier))
            
            // Default cell to normal column height & width
            var cellWidth = normalColumnWidth
            var cellHeight = normalColumnHeight
            
            // Determine if we are dealing with a 'featured' cell
            if (itemInSection + 1) % 7 == 0 && itemInSection != 0 {
                // If so, set height & width to featured size
                cellWidth  = featuredColumnWidth
                cellHeight = featuredColumnHeight
            }
            
            let frame = CGRect(x: xPos, y: yPos, width: cellHeight, height: cellWidth)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            attributes.frame = frame
            
            // Save newly calculated attributes to cache array so we don't have to do all that work again
            cache.append(attributes)
            
            // Calculate content height
            contentHeight = max(contentHeight, frame.maxY)
            itemInSection = itemInSection < (numberOfItemsPerSection - 1) ? (itemInSection + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in cache {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }
        
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
