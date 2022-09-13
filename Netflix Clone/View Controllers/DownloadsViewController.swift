//
//  DownloadsViewController.swift
//  Netflix Clone
//
//  Created by admin on 25.08.2022.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    private var titles: [TitleEntity] = [TitleEntity]()
    
    private let downloadsTableView: UITableView = {
       let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        title = "Downloads"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(downloadsTableView)
        
        downloadsTableView.delegate = self
        downloadsTableView.dataSource = self
        
        fetchLocalStorageForDownload()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
    }
    
    
    private func fetchLocalStorageForDownload() {
        CoreDataManager.shared.fetchingDataFromDB { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                self?.downloadsTableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadsTableView.frame = view.bounds
    }
}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: TitleViewModel(titleName:
                                                titles[indexPath.row].original_title ?? titles[indexPath.row].original_name ?? "Unknown Title",
                                            posterPath: titles[indexPath.row].poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            CoreDataManager.shared.deleteTitleWith(model: titles[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("Deleted successfully")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.titles.remove(at: indexPath.row)

                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }
}
