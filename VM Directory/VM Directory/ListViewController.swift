//
//  ListViewController.swift
//  VM Directory
//
//  Created by Prasad on 02/04/22.
//

import UIKit

public enum SegmentState {
    case people
    case rooms
}

class ListViewController: UIViewController {
    
    var alert: UIAlertController!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var segmentState = SegmentState.people
    var listViewModel: ListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar(title: ScreenTitle.list.rawValue)
        segmentControl.backgroundColor = Theme.primaryBrandColor.rawValue.getColorForString()
        
        tableView.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: "personCell")
        tableView.register(UINib(nibName: "RoomTableViewCell", bundle: nil), forCellReuseIdentifier: "roomCell")
        
        showLoadingIndicator(message: LoaderMessages.people.rawValue)
        
        setupViewModel()
    }
    
    private func setupViewModel() {
        listViewModel = ListViewModel()
        
        listViewModel.responseReceived = { [weak self] (segmentState) in
            DispatchQueue.main.async {
                self?.hideLoadingIndicator()
                self?.reloadTableView()
            }
        }
        
        listViewModel.showError = {[weak self] (segmentState, error) in
            DispatchQueue.main.async {
                self?.hideLoadingIndicator()
            }
            if segmentState == .people {
                print("Unable to fetch people: \(error)")
            }
            else {
                print("Unable to fetch rooms: \(error)")
            }
        }
        
        listViewModel.getPeopleList()
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        segmentState = sender.selectedSegmentIndex == 0 ? .people : .rooms
        if segmentState == .people {
            showLoadingIndicator(message: LoaderMessages.people.rawValue)
            listViewModel.getPeopleList()
        }
        else {
            showLoadingIndicator(message: LoaderMessages.rooms.rawValue)
            listViewModel.getRoomsList()
        }
    }
}

extension ListViewController {
    func showLoadingIndicator(message: String) {
        alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.tintColor = .black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.alert.dismiss(animated: true, completion: nil)
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentState == .people {
            return listViewModel.getPeopleCount()
        }
        else {
            return listViewModel.getRoomsCount()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentState == .people {
            let cell = tableView.dequeueReusableCell(withIdentifier: "personCell") as! PersonTableViewCell
            cell.labelName.text = listViewModel.getPersonName(at: indexPath.row)
            cell.labelName.applyBrandColor()
            
            cell.labelJobTitle.text = listViewModel.getJobTitle(at: indexPath.row)
            
            cell.container.dropShadow()
            
            cell.selectionStyle = .none
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell") as! RoomTableViewCell
            cell.labelOccupancy.text = listViewModel.getRoomOccupancy(at: indexPath.row)
            
            cell.labelAvailability.text = listViewModel.getRoomAvailability(at: indexPath.row)
            
            let isRoomOccupied = listViewModel.isRoomOccupied(at: indexPath.row)
            cell.labelAvailability.textColor = isRoomOccupied ? .red : .green
            
            cell.container.dropShadow()
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentState == .people {
            let detailsViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
            let detailsViewModel = DetailsViewModel(person: listViewModel.getPerson(at: indexPath.row))
            detailsViewController?.detailsViewModel = detailsViewModel
            navigationController?.pushViewController(detailsViewController!, animated: true)
        }
    }
}
