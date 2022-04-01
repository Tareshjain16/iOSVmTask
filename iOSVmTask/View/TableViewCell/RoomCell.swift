//
//  RoomCell.swift
//  iOSVmTask
//
//  Created by Taresh Jain on 01/04/22.
//

import UIKit

class RoomCell: UITableViewCell {

    /// Set data to cell item
    var roomData: RoomModel? {
        didSet {
            if let occupied = roomData?.isOccupied {
                occupLabel.text =  "Occupied: \(occupied ? "Yes" : "No")"
            }
            maxOccupLabel.text = "Maximum Occupancy: \(roomData?.maxOccupancy ?? 0)"
        }
    }
    // MARK: Variables
    /// OccupLabel label
    private let occupLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.secondryTextColor
        lbl.font = UIFont.boldSystemFont(ofSize: FONTSIZE14)
        lbl.textAlignment = .left
        return lbl
    }()

    /// MaxOccupLabel label
    private let maxOccupLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.secondryTextColor
        lbl.font = UIFont.boldSystemFont(ofSize: FONTSIZE12)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()

    /// Custom Inner view
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cellBackgroundColor
        view.clipsToBounds = true
        return view
    }()

    /// Initialize cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.cellBackgroundColor
        self.customView.addSubview(occupLabel)
        self.customView.addSubview(maxOccupLabel)
        contentView.addSubview(customView)
        selectionStyle = .none
        separatorInset = UIEdgeInsets.zero
        contentView.clipsToBounds = true
        self.customView.clipsToBounds = true
        self.setCustomViewConstraint()
        self.setOccupLabelConstraint()
        self.setMaxOccupLabelConstraint()
    }

    // MARK: Setup cell items
    /// Setup custom view, Title, Imageview and description
    func setCustomViewConstraint() {
        self.customView.translatesAutoresizingMaskIntoConstraints = false
        self.customView.heightAnchor.constraint(greaterThanOrEqualToConstant: 70).isActive = true
        self.customView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
        self.customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        self.customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        self.customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }

    func setOccupLabelConstraint() {
        self.occupLabel.translatesAutoresizingMaskIntoConstraints = false
        self.occupLabel.topAnchor.constraint(equalTo: self.customView.topAnchor, constant: 5).isActive = true
        self.occupLabel.leadingAnchor.constraint(equalTo: self.customView.leadingAnchor, constant: 5).isActive = true
        self.occupLabel.trailingAnchor.constraint(equalTo: self.customView.trailingAnchor, constant: -5).isActive = true
    }

    func setMaxOccupLabelConstraint() {
        self.maxOccupLabel.translatesAutoresizingMaskIntoConstraints = false
        self.maxOccupLabel.topAnchor.constraint(equalTo: self.occupLabel.bottomAnchor, constant: 5).isActive = true
        self.maxOccupLabel.leadingAnchor.constraint(equalTo: self.customView.leadingAnchor, constant: 5).isActive = true
        self.maxOccupLabel.trailingAnchor.constraint(equalTo: self.customView.trailingAnchor, constant: -5).isActive = true
        self.maxOccupLabel.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -5).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Cancel the current wrong url image downloading
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
