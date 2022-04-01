//
//  FactsListViewController.swift
//  iOSVmTask
//
//
/// Main root view controller class for display facts data
import UIKit

class PeopleViewController: UIViewController {

    // MARK: Variables
    /// Intialize View model
    private let peopleViewModel = PeopleViewModel()
    /// tableView instance
    let tableView = UITableView()
    /// LayoutGuide instance
    var safeArea: UILayoutGuide!
    /// refreshControl instance
    let refreshControl = UIRefreshControl()
    /**
     Setup Retry view for not getting data
     View, label and Button
     */
    lazy var retryView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.isHidden = true
        view.backgroundColor = UIColor.appBackgroundColor
        return view
    }()

    lazy var noDataLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.primaryTextColor
        lbl.text = dataNotFound
        lbl.font = UIFont.systemFont(ofSize: FONTSIZE14)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()

    lazy var retryButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.layer.borderColor = UIColor.primaryTextColor.cgColor
        btn.layer.borderWidth = 2.0
        btn.titleLabel?.font = UIFont.systemFont(ofSize: FONTSIZE13)
        btn.setTitle(retry, for: .normal)
        btn.titleColor = UIColor.primaryTextColor
        return btn
    }()

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.appBackgroundColor
        self.safeArea = view.layoutMarginsGuide
        Helper.customRightNavItem(self, barItem: self.navigationItem, strTitle: "Rooms", select: #selector (doOpenRoomVC))
        self.configureTableView()
        self.conifigureRetryView()
        self.callPeopleAPI()
    }

    @objc func doOpenRoomVC() {
        let roomVC = RoomViewController()
        self.navigationController?.pushViewController(roomVC, animated: true)
    }

    // MARK: UI setup methods

    /**
     Preparing initial UI after application launch
     Initialize tableview, retryview and refresh controll
     */
    private func configureTableView() {
        tableView.dataSource = self
        tableView.register(PeopleCell.self, forCellReuseIdentifier: intitialCellId)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.safeArea.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        tableView.tableFooterView = UIView()
        refreshControl.tintColor = UIColor.navigationBarColor
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    private func conifigureRetryView() {
        self.view.clipsToBounds = true
        self.view.addSubview(retryView)
        self.retryView.addSubview(noDataLabel)
        self.retryView.addSubview(self.retryButton)
        self.retryView.clipsToBounds = true

        self.retryView.translatesAutoresizingMaskIntoConstraints = false
        self.retryView.topAnchor.constraint(equalTo: self.safeArea.topAnchor, constant: 5).isActive = true
        self.retryView.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor, constant: 0).isActive = true
        self.retryView.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor, constant: 0).isActive = true
        self.retryView.bottomAnchor.constraint(equalTo: self.safeArea.bottomAnchor, constant: -5).isActive = true
        self.retryView.clipsToBounds = true
        self.retryView.isUserInteractionEnabled = true

        self.noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        self.noDataLabel.leadingAnchor.constraint(equalTo: self.retryView.leadingAnchor, constant: 5).isActive = true
        self.noDataLabel.trailingAnchor.constraint(equalTo: self.retryView.trailingAnchor, constant: -5).isActive = true
        self.noDataLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        self.noDataLabel.centerYAnchor.constraint(equalTo: self.safeArea.centerYAnchor, constant: -20).isActive = true

        self.retryButton.translatesAutoresizingMaskIntoConstraints = false
        self.retryButton.topAnchor.constraint(equalTo: self.noDataLabel.bottomAnchor, constant: 5).isActive = true
        self.retryButton.centerXAnchor.constraint(equalTo: self.safeArea.centerXAnchor).isActive = true
        self.retryButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.retryButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        self.retryButton.addTarget(self, action: #selector(retryCallPeopleAPi), for: .touchUpInside)
        self.showLoader(isShow: Reachability.isConnectedToNetwork())
    }

    // MARK: UIRefreshControl methods
    @objc func refreshData(refreshControl: UIRefreshControl) {
        self.callPeopleAPI()
    }

    /// End refresh control
    func endRefreshing() {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
    }

    // MARK: Custom methods
    /// Fetching people data
    @objc func callPeopleAPI() {
        self.retryView.isHidden = true
        self.peopleViewModel.delegate = self
        self.peopleViewModel.getAllPeopleData()
    }

    /// Retry to get the data from server again
    @objc func retryCallPeopleAPi() {
        self.retryView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.showLoader(isShow: Reachability.isConnectedToNetwork())
            self.callPeopleAPI()
        }
    }

    /**
     Show retry view after getting error
     - Parameters
     - isHidden: Boolean for hiding retry view
     - message: Error message
     */
    func showRetryView(isHidden: Bool, message: String) {
        DispatchQueue.main.async {
            self.hideLoader()
            self.endRefreshing()
            if self.peopleViewModel.objPeople.isEmpty {
                self.peopleViewModel.objPeople = []
            }
            self.tableView.reloadData()
            self.retryView.isHidden = isHidden
            self.noDataLabel.text = message
        }
    }

    /// Displaying data on UI after getting from the API
    func renderDataOnUI() {
        DispatchQueue.main.async {
            self.endRefreshing()
            self.hideLoader()
            self.title = "People"
            if self.peopleViewModel.objPeople.isEmpty {
                self.showRetryView(isHidden: false, message: dataNotFound)
            } else {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: UITableViewDataSource methods
extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peopleViewModel.getRowCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: intitialCellId, for: indexPath) as? PeopleCell
        cell?.factData = self.peopleViewModel.getNonEmptyRows()[indexPath.row]
        return cell ?? UITableViewCell()
    }
}
// MARK: Custom Viewmodel delegate methods
/**
 Custom delegate method of viewmodel to receice response or error
 */
extension PeopleViewController: PeopleViewModelDelegate {

    func didReceiveApiResponse() {
        self.renderDataOnUI()
    }

    func didReceiveError(errorMessage: String) {
        self.showRetryView(isHidden: false, message: errorMessage)
    }
}
