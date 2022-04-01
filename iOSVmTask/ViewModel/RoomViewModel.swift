//
//  RoomViewModel.swift
//  iOSVmTask
//
//  Created by Taresh Jain on 01/04/22.
//

import Foundation

/// Custom delegate of api response for viewmodel
protocol RoomViewModelDelegate: class {
    func didReceiveApiResponse()
    func didReceiveError(errorMessage: String)
}

class RoomViewModel {
    /// Intial view controller object
    var objRooms = [RoomModel]()
    weak var delegate: RoomViewModelDelegate?

    // MARK: - Custom API Method
    /// Getting room details from api
    func getAllRoomList() {
        if Reachability.isConnectedToNetwork() {
            APIService.shareInstance.makeApiRequest(endpoint: room) {(roomData: [RoomModel]?, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        self.delegate?.didReceiveError(errorMessage: error.localizedDescription)
                    }
                } else {
                    if let dictData = roomData {
                        self.objRooms = dictData
                        self.delegate?.didReceiveApiResponse()
                    }
                }
            }
        } else {
            self.delegate?.didReceiveError(errorMessage: noInternetConnection)
        }
    }

    /** Get  cell count
        - Returns: Rows count
    */
   func getRowCount() -> Int {
        return self.getNonEmptyRows().count
   }

    /**
     Return not empty maxoccp rows data
     - Returns: Filtered array row data
     */
    func getNonEmptyRows() -> [RoomModel] {
            return  self.objRooms.filter({$0.maxOccupancy != nil })
    }

}

