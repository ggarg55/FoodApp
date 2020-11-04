//
//  OfferTableViewCell.swift
//  FoodApp
//
//  Created by Gourav Garg on 03/11/20.
//  Copyright © 2020 Gourav Garg. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell, UIScrollViewDelegate {
    var imagelist: [String] = []
    var scrollView: UIScrollView!
    var pageControl : UIPageControl!
    var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.scrollPages()
        })
    }
    
    func setupUI() {
        imagelist = ["offerFirst.jpg", "offerSecond.jpg", "offerThird.jpg"]
        configureScrollView()
        configurePageControllFrame()
        configurePageControl()
        scrollView.delegate = self
        addSubview(scrollView)
        addSubview(pageControl)
        NotificationCenter.default.addObserver(self, selector: #selector(shrink), name: NSNotification.Name(rawValue: "shrinkOffer"), object: nil)
    }
    
    @objc func shrink() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            let frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 0)
            self.scrollView.isHidden = true
            self.pageControl.isHidden = true
            self.frame = frame
            self.scrollView.frame = frame
            self.pageControl.frame = frame
        }, completion: nil)
    }
    
    func configureScrollView() {
        let frame = self.frame
        let height = frame.size.height * 0.6
        scrollView = UIScrollView(frame: CGRect(x: frame.origin.x, y: frame.origin.y - 50, width: frame.size.width, height: height))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    func configurePageControllFrame() {
        let yPos = self.frame.size.height * 0.5 - 40
        pageControl = UIPageControl(frame: CGRect(x: 0, y: yPos, width: self.frame.size.width, height: 50))
    }
    
    func configurePageControl() {
        self.pageControl.numberOfPages = imagelist.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = .white
        self.pageControl.pageIndicatorTintColor = .gray
        self.pageControl.currentPageIndicatorTintColor = .white
        addViewsToScrollView()
    }
    
    func addViewsToScrollView() {
        for  i in stride(from: 0, to: imagelist.count, by: 1) {
            var frame = CGRect.zero
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(i)
            frame.origin.y = 0
            frame.size = self.scrollView.frame.size
            self.scrollView.isPagingEnabled = true

            let myImage:UIImage = UIImage(named: imagelist[i])!
            let myImageView:UIImageView = UIImageView()
            myImageView.image = myImage
            myImageView.contentMode = .scaleToFill
            myImageView.frame = frame
            scrollView.addSubview(myImageView)
        }

        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(imagelist.count), height: self.scrollView.frame.size.height)

        pageControl.addTarget(self, action: #selector(changePage(sender:)), for: UIControl.Event.valueChanged)
    }
    
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        if pageNumber > CGFloat(imagelist.count) {
            pageNumber = 0
        }
        pageControl.currentPage = Int(pageNumber)
    }
    
    func scrollPages() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            let pageNumber = (round(self.scrollView.contentOffset.x / self.scrollView.frame.size.width)) + 1
        
            if Int(pageNumber) >= self.imagelist.count {
                self.pageControl.currentPage = 0
                self.scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
            } else {
                self.pageControl.currentPage += Int(pageNumber)
                let x = CGFloat(Int(pageNumber)) * self.scrollView.frame.size.width
                self.scrollView.setContentOffset(CGPoint(x: x,y: 0), animated: true)
            }
        }, completion: nil)
    }
}
