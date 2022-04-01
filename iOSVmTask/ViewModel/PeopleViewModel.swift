//
//  PeopleViewModel.swift
//  iOSVmTask
//
//

import Foundation

/// Custom delegate of api response for viewmodel
protocol PeopleViewModelDelegate: class {
    func didReceiveApiResponse()
    func didReceiveError(errorMessage: String)
}

class PeopleViewModel {
    /// Intial view controller object
    var objPeople = [PeopleModel]()
    weak var delegate: PeopleViewModelDelegate?

    // MARK: - Custom API Method
    /// Getting people details from api
    func getAllPeopleData() {
        if Reachability.isConnectedToNetwork() {
            APIService.shareInstance.makeApiRequest(endpoint: people) {(peopleData: [PeopleModel]?, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        self.delegate?.didReceiveError(errorMessage: error.localizedDescription)
                    }
                } else {
                    if let dictData = peopleData {
                        self.objPeople = dictData
                        self.delegate?.didReceiveApiResponse()
                    }
                }
            }
        } else {
            self.delegate?.didReceiveError(errorMessage: noInternetConnection)
        }
    }

    /**
     Return not empty title rows data
     - Returns: Filtered array row data
     */
    func getNonEmptyRows() -> [PeopleModel] {
            return  self.objPeople.filter({$0.firstName != nil })
    }

     /** Get  cell count
         - Returns: Rows count
     */
    func getRowCount() -> Int {
        return self.getNonEmptyRows().count
    }
}
