//
//  IntroPageViewController.swift
//  SeSacTMBProject
//
//  Created by yongseok lee on 2022/08/16.
//

import UIKit

class IntroPageViewController: UIPageViewController {

    
    var pageViewControllerList: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPageViewController()
        configurePageViewController()
     
    }
    
    func createPageViewController() {
        let sb = UIStoryboard(name: "Intro", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: firstPageViewController.reuseIdentifier) as! firstPageViewController
        let vc2 = sb.instantiateViewController(withIdentifier: secondPageViewController.reuseIdentifier) as! secondPageViewController
        let vc3 = sb.instantiateViewController(withIdentifier: thirdPageViewController.reuseIdentifier) as! thirdPageViewController
        pageViewControllerList = [vc1, vc2, vc3]
    }

    func configurePageViewController() {
        delegate = self
        dataSource = self
        
        //diplay
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
        
        
    }
    

 
}

extension IntroPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pageViewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first,
              let index = pageViewControllerList.firstIndex(of: first) else { return 0 }
        
        return index
    }
    
}
