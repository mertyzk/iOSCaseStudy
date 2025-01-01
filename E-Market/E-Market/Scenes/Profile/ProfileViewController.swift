//
//  ProfileVC.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit
import WebKit

final class ProfileViewController: BaseViewController {
    
    // MARK: - Properties
    var webView: WKWebView!
    var viewModel: ProfileViewModel!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadURL()
    }
    
    
    // MARK: - Setup WebView
    private func setupWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    // MARK: - Load URL
    private func loadURL() {
        NotificationCenter.default.post(name: .showLoading, object: nil)
        viewModel = ProfileViewModel(urlString: Texts.eterationURL)
        guard viewModel.isValidURL(), let url = viewModel.getURL() else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}


// MARK: - WKNavigationDelegate
extension ProfileViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NotificationCenter.default.post(name: .hideLoading, object: nil)
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        NotificationCenter.default.post(name: .hideLoading, object: nil)
    }
}
