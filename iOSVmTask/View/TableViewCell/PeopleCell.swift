//
//  FactsCell.swift
//  iOSVmTask
//
//

import UIKit
import SDWebImage

class PeopleCell: UITableViewCell {

    /// Set data to cell item
    var factData: PeopleModel? {
        didSet {
            titleLabel.text = "\(factData?.firstName ?? "") \(factData?.lastName ?? "")"
            jobLabel.text = factData?.jobtitle
            if let imgURl = factData?.avatar {
               self.peopleImage.sd_setImage(with: URL(string: imgURl), placeholderImage: UIImage(named: "placeholder"))
            }
        }
    }
    // MARK: Variables
    /// Title label
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.primaryTextColor
        lbl.font = UIFont.boldSystemFont(ofSize: FONTSIZE14)
        lbl.textAlignment = .left
        return lbl
    }()

    /// Description label
    private let jobLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.secondryTextColor
        lbl.font = UIFont.boldSystemFont(ofSize: FONTSIZE12)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()

    /// Fact Imageview
    private let peopleImage: UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "placeholder"))
        imgView.contentMode = .scaleToFill
        imgView.clipsToBounds = true
        return imgView
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
        self.customView.addSubview(peopleImage)
        self.customView.addSubview(titleLabel)
        self.customView.addSubview(jobLabel)
        contentView.addSubview(customView)
        selectionStyle = .none
        separatorInset = UIEdgeInsets.zero
        contentView.clipsToBounds = true
        self.customView.clipsToBounds = true
        self.setCustomViewConstraint()
        self.setImageViewConstraint()
        self.setTitleLabelConstraint()
        self.setDescriptionLabelConstraint()
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

    func setImageViewConstraint() {
        self.peopleImage.translatesAutoresizingMaskIntoConstraints = false
        self.peopleImage.topAnchor.constraint(equalTo: self.customView.topAnchor, constant: 5).isActive = true
        self.peopleImage.leadingAnchor.constraint(equalTo: self.customView.leadingAnchor, constant: 10).isActive = true
        self.peopleImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.peopleImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

    func setTitleLabelConstraint() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.customView.topAnchor, constant: 5).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.peopleImage.trailingAnchor, constant: 5).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.customView.trailingAnchor, constant: -5).isActive = true
    }

    func setDescriptionLabelConstraint() {
        self.jobLabel.translatesAutoresizingMaskIntoConstraints = false
        self.jobLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
        self.jobLabel.leadingAnchor.constraint(equalTo: self.peopleImage.trailingAnchor, constant: 5).isActive = true
        self.jobLabel.trailingAnchor.constraint(equalTo: self.customView.trailingAnchor, constant: -5).isActive = true
        self.jobLabel.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -5).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Cancel the current wrong url image downloading
    override func prepareForReuse() {
        super.prepareForReuse()
        sd_cancelCurrentImageLoad()
        self.peopleImage.image = UIImage(named: "placeholder.png")
    }
}
