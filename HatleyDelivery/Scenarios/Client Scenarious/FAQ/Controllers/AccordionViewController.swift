//
//  AccordionViewController.swift
//  Example
//
//  Created by Victor Sigler on 8/8/18.
//  Copyright © 2018 Victor Sigler. All rights reserved.
//

import UIKit
import AccordionSwift

class AccordionViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Typealias
    
    typealias ParentCellModel = Parent<GroupCellModel, CountryCellModel>
    typealias ParentCellConfig = CellViewConfig<ParentCellModel, UITableViewCell>
    typealias ChildCellConfig = CellViewConfig<CountryCellModel, CountryTableViewCell>
    
    // MARK: - Properties
    
    /// The Data Source Provider with the type of DataSource and the different models for the Parent and Child cell.
    var dataSourceProvider: DataSourceProvider<DataSource<ParentCellModel>, ParentCellConfig, ChildCellConfig>?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDataSource()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 66
    }
}

extension AccordionViewController {
    
    // MARK: - Methods
    
    /// Configure the data source 
    private func configDataSource() {
        
        let groupB = Parent(state: .collapsed, item: GroupCellModel(name: "How to update WhatsApp ?"),
                            children: [CountryCellModel(name: "You can easily update WhatsApp from your phone's application store. Please note if you received a message that isn't supported by your version of WhatsApp, you'll need to update WhatsApp.")]
        )
        
        let groupC = Parent(state: .collapsed, item: GroupCellModel(name: "How to change the language ?"),
                            children: [CountryCellModel(name: "WhatsApp is available in over 40 languages and up to 60 on Android. As a general rule, WhatsApp follows the language of your phone. For example, if you change the language of your phone to Spanish, WhatsApp will automatically be in Spanish.")]
        )
        
        let groupD = Parent(state: .collapsed, item: GroupCellModel(name: "Lost and stolen phones ?"),
                            children: [CountryCellModel(name: "In the unfortunate case that your phone becomes lost or stolen, we can help make sure that no one can use your WhatsApp account.")]
        )
        
        let groupE = Parent(state: .collapsed, item: GroupCellModel(name: "Verifying your number ?"),
                            children: [CountryCellModel(name: "Send a test SMS message from any phone to your own phone number exactly as you entered it in WhatsApp, including the country code, to check your reception.")]
        )
        
    
        
        let section0 = Section([groupB, groupC, groupD, groupE], headerTitle: nil)
        let dataSource = DataSource(sections: section0)
        
        let parentCellConfig = CellViewConfig<ParentCellModel, UITableViewCell>(
        reuseIdentifier: "GroupCell") { (cell, model, tableView, indexPath) -> UITableViewCell in
            cell.textLabel?.text = model?.item.name
            return cell
        }
        
        let childCellConfig = CellViewConfig<CountryCellModel, CountryTableViewCell>(
        reuseIdentifier: "CountryCell") { (cell, item, tableView, indexPath) -> CountryTableViewCell in
            cell.contryLabel.text = item?.name
            cell.countryImageView.image = UIImage(named: "\(item!.name.lowercased())")
            return cell
        }
        
        let didSelectParentCell = { (tableView: UITableView, indexPath: IndexPath, item: ParentCellModel?) -> Void in
            print("Parent cell \(item!.item.name) tapped")
        }
        
        let didSelectChildCell = { (tableView: UITableView, indexPath: IndexPath, item: CountryCellModel?) -> Void in
            print("Child cell \(item!.name) tapped")
        }
        
        let heightForParentCell = { (tableView: UITableView, indexPath: IndexPath, item: ParentCellModel?) -> CGFloat in
            return 55
        }
        
        let heightForChildCell = { (tableView: UITableView, indexPath: IndexPath, item: CountryCellModel?) -> CGFloat in
            return UITableView.automaticDimension
        }
    
        
        dataSourceProvider = DataSourceProvider(
            dataSource: dataSource,
            parentCellConfig: parentCellConfig,
            childCellConfig: childCellConfig,
            didSelectParentAtIndexPath: didSelectParentCell,
            didSelectChildAtIndexPath: didSelectChildCell,
            heightForParentCellAtIndexPath: heightForParentCell,
            heightForChildCellAtIndexPath: heightForChildCell
        )
        
        tableView.dataSource = dataSourceProvider?.tableViewDataSource
        tableView.delegate = dataSourceProvider?.tableViewDelegate
        tableView.tableFooterView = UIView()
    }
}
