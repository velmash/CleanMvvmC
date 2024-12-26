//
//  ViewController.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var userButton: UIButton = {
        let button = UIButton()
        button.setTitle("사용자 정보 불러오기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var userInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "메인"
        
        view.addSubview(userButton)
        view.addSubview(userInfoLabel)
        
        NSLayoutConstraint.activate([
            userButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userButton.widthAnchor.constraint(equalToConstant: 200),
            userButton.heightAnchor.constraint(equalToConstant: 50),
            
            userInfoLabel.topAnchor.constraint(equalTo: userButton.bottomAnchor, constant: 20),
            userInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupBindings() {
        let input = MainViewModel.Input(
            viewDidLoad: Observable.just(()),
            userButtonTap: userButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        // User 데이터 바인딩
        output.user
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] user in
                self?.userInfoLabel.text = "이름: \(user.name)\n나이: \(user.age)"
            })
            .disposed(by: disposeBag)
        
        // 에러 처리
        output.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.showError(error)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Helper Methods
    private func showError(_ error: Error) {
        let alert = UIAlertController(
            title: "에러",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
}

