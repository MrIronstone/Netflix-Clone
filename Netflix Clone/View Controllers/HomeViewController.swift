//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by admin on 25.08.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var randomTrendingMovie: Title?
    private var headerView: HeroHeaderUIView?
    
    private let sectionTitles: [String] = ["Trending Movies", "Trending TVs", "Popular Movies", "Popular TVs", "Upcoming Movies", "Top Rated Movies", "Top Rated TVs"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        // navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        navigationController?.navigationBar.tintColor = .white
        
        configureNavBar()
        
        // This makes general header view
        headerView = HeroHeaderUIView (frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        configureHeroHeaderView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureHeroHeaderView()
    }
    
    private func configureHeroHeaderView() {
        NetworkManager.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                let selectedRandomTitle = titles.randomElement()
                self?.randomTrendingMovie = selectedRandomTitle
                DispatchQueue.main.async { [weak self] in
                    guard let selectedRandomTitle = selectedRandomTitle else { return }
                    self?.headerView?.configure(with: selectedRandomTitle)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    private func configureNavBar() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil )
        ]
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    /*
     private func getTrendingMovies() {
     NetworkManager.shared.getTrendingMovies { results in
     switch results {
     case .success(let movies):
     print("Trending Movies", movies)
     case .failure(let error):
     print(error)
     }
     }
     }
     
     private func getTrendingTvs() {
     NetworkManager.shared.getTrendingTvs { results in
     switch results {
     case .success(let movies):
     print("Trending TVs: ", movies)
     case .failure(let error):
     print(error)
     }
     }
     }
     
     private func getUpcomingMovies() {
     NetworkManager.shared.getUpcomingMovies { results in
     switch results {
     case .success(let movies):
     print("Upcoming Movies: ", movies)
     case .failure(let error):
     print(error)
     }
     }
     }
     
     private func getPopularMovies() {
     NetworkManager.shared.getPopularMovies { results in
     switch results {
     case .success(let movies):
     print("Popular Movies: ", movies)
     case .failure(let error):
     print(error)
     }
     }
     }
     
     private func getPopularTvs() {
     NetworkManager.shared.getPopularTvs { results in
     switch results {
     case .success(let movies):
     print("Popular Tvs: ", movies)
     case .failure(let error):
     print(error)
     }
     }
     }
     
     private func getTopRatedMovies() {
     NetworkManager.shared.getTopRatedMovies { results in
     switch results {
     case .success(let movies):
     print("Top Rated Movies: ", movies)
     case .failure(let error):
     print(error)
     }
     }
     }
     
     private func getTopRatedTvs() {
     NetworkManager.shared.getTopRatedTvs { results in
     switch results {
     case .success(let movies):
     print("Top Rated Tvs: ", movies)
     case .failure(let error):
     print(error)
     }
     }
     }
     */
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        //     private let sectionTitles: [String] = ["Trending Movies", "Trending TVs", "Popular Movies", "Popular TVs", "Upcoming Movies", "Top Rated Movies", "Top Rated TVs"]
        cell.delegate = self
        
        switch indexPath.section {
        case sectionTitles.firstIndex(of: "Trending Movies"):
            NetworkManager.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case sectionTitles.firstIndex(of: "Trending TVs"):
            NetworkManager.shared.getTrendingTvs { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case sectionTitles.firstIndex(of: "Popular Movies"):
            NetworkManager.shared.getPopularMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case sectionTitles.firstIndex(of: "Popular TVs"):
            NetworkManager.shared.getPopularTvs { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case sectionTitles.firstIndex(of: "Upcoming Movies"):
            NetworkManager.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case sectionTitles.firstIndex(of: "Top Rated Movies"):
            NetworkManager.shared.getTopRatedMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case sectionTitles.firstIndex(of: "Top Rated TVs"):
            NetworkManager.shared.getTopRatedTvs { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
     */
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    // set text of header of each section
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.navigationController?.navigationBar.tintColor = .white
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
