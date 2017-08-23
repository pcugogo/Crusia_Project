//
//  WalkthroughPageViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 19..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var pageHeadings = ["Search", "Reserve", "Host"]
    var pageImages = ["walk1", "walk2", "walk3"]
    var pageContent = ["숙박하길 원하는 하우스를 찾아서 위시리스트에 저장할 수 있습니다.",
                       "하우스 정보를 살펴보고 원하는 날짜에 예약할 수 있습니다.",
                       "집에 대한 여러가지 정보를 입력한 후 집을 빌려줄 수 있습니다."]

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        // 첫번째 화면
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }

    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
            
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.content = pageContent[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
    }
    
    func forward(index: Int) {
        
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
//    // 페이지 수 만큼 인디케이터에 표시
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        
//        return pageHeadings.count
//    }
//    
//    // 페이지 인덱스를 리턴
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        
//        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
//            
//            return pageContentViewController.index
//        }
//        
//        return 0
//    }
}
