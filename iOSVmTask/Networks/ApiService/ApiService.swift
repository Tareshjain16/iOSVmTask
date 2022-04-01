//
//  ApiService.swift
//  iOSVmTask
//
//

import UIKit

public enum NetworkError: Error {
    case notFound
    case unknown
}

/// Get error info
extension NetworkError: CustomNSError {
    public var errorDescription: String? {
        switch self {
        case .notFound:
            return NSLocalizedString(dataNotFound, comment: "")
        case .unknown:
            return NSLocalizedString(unknownError, comment: "")
        }
    }

    public var errorUserInfo: [String: Any] {
        switch self {
        case .notFound:
            return [ NSLocalizedDescriptionKey: dataNotFound]
        case .unknown:
            return [ NSLocalizedDescriptionKey: unknownError]
        }
    }
}

class APIService: NSObject {
    static let shareInstance = APIService()
    // MARK: - Generic API Method
    /**
     Generic api function for dynamic view model and fetching detail from server
     - Parameters
     - completion: Closure call
     -  T:  Generic object any view model
     - error: Error message
     */
    func makeApiRequest<T: Decodable>(endpoint: String, completion: @escaping (T?, Error? ) -> Void) {

        guard let url = URL(string: ServerEnvironment.prodution.value + endpoint) else {
            print("Invalid URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(nil, NetworkError.unknown)
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    if let data = data {
                        do {
                            // Convert Data into utf8
                            guard let string = String(data: data, encoding: String.Encoding.isoLatin1) else { return }
                            guard let properData = string.data(using: .utf8, allowLossyConversion: true) else { return }
                            let responseData = try JSONDecoder().decode(T.self, from: properData)
                            completion(responseData, nil)
                        } catch let err {
                            print(err.localizedDescription)
                            completion(nil, NetworkError.unknown)
                        }
                    }
                case 404:
                    completion(nil, NetworkError.notFound)
                default:
                    completion(nil, NetworkError.unknown)
                }
            }
        }
        task.resume()
    }
}
