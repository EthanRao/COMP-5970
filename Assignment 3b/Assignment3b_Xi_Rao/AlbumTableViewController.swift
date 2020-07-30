//
//  AlbumTableViewController.swift
//  Assignment3b_Xi_Rao
//
//  Created by Xi Rao on 7/29/20.
//  Copyright © 2020 Xi Rao. All rights reserved.
//

import UIKit
import os.log

class AlbumTableViewController: UITableViewController {
    // MARK: Properties
    var albums = [Album]()
    
    //MARK: Actions
    @IBAction func unwindToAlbumList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AlbumViewController, let album = sourceViewController.album {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                albums[selectedIndexPath.row] = album
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: albums.count, section: 0)
                
                albums.append(album)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }

            saveAlbums()
        }
    }
    
    // MARK: Private Methods
    private func loadSampleAlbums() {
        let photo1 = UIImage(named: "cover1")
        let photo2 = UIImage(named: "cover2")
        let photo3 = UIImage(named: "cover3")
        let photo4 = UIImage(named: "cover4")
        let photo5 = UIImage(named: "cover5")
        let photo6 = UIImage(named: "cover6")
        let photo7 = UIImage(named: "cover7")
        let photo8 = UIImage(named: "cover8")
        let photo9 = UIImage(named: "cover9")
        let photo10 = UIImage(named: "cover10")
        
        guard let album1 = Album(title: "Revolver", cover: photo1, artist: "The Beatles", releasedYear: "1966", recordLabel: "EMI Studios") else {
            fatalError("Unable to instantiate album1")
        }
        guard let album2 = Album(title: "Love", cover: photo2, artist: "Taylor Swift", releasedYear: "2019", recordLabel: "Republic Records") else {
            fatalError("Unable to instantiate album2")
        }
        guard let album3 = Album(title: "Native", cover: photo3, artist: "OneRepublic", releasedYear: "2013", recordLabel: "Mosley Music Group & Interscope Records") else {
            fatalError("Unable to instantiate album3")
        }
        guard let album4 = Album(title: "Born to Die", cover: photo4, artist: "Lana Del Rey", releasedYear: "2012", recordLabel: "Interscope Records") else {
            fatalError("Unable to instantiate album4")
        }
        guard let album5 = Album(title: "Prism", cover: photo5, artist: "Katy Perry", releasedYear: "2013", recordLabel: "Capitol Records") else {
            fatalError("Unable to instantiate album5")
        }
        guard let album6 = Album(title: "Beautiful Trauma", cover: photo6, artist: "P!nk", releasedYear: "2017", recordLabel: "RCA Records") else {
            fatalError("Unable to instantiate album6")
        }
        guard let album7 = Album(title: "Rainbow", cover: photo7, artist: "Kesha", releasedYear: "2017", recordLabel: "Kemosabe Records & RCA Records") else {
            fatalError("Unable to instantiate album7")
        }
        guard let album8 = Album(title: "4:44", cover: photo8, artist: "Jay-Z", releasedYear: "2017", recordLabel: "Roc Nation") else {
            fatalError("Unable to instantiate album8")
        }
        guard let album9 = Album(title: "Views", cover: photo9, artist: "Drake", releasedYear: "2016", recordLabel: "Cash Money Records & Young Money Entertainment & Republic Records") else {
            fatalError("Unable to instantiate album9")
        }
        guard let album10 = Album(title: "Get Rich or Die Tryin'", cover: photo10, artist: "50 Cent", releasedYear: "2003", recordLabel: "Shady Records & Aftermath Entertainment & G-Unit Records & Interscope Records") else {
            fatalError("Unable to instantiate album10")
        }
        
        albums += [album1, album2, album3, album4, album5, album6, album7, album8, album9 ,album10]
    }
    
    private func saveAlbums() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(albums, toFile: Album.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Albums successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save albums...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadAlbums() -> [Album]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Album.ArchiveURL.path) as? [Album]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedAlbums = loadAlbums() {
            albums += savedAlbums
        }
        else {
            // Load the sample data.
            loadSampleAlbums()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier =  "AlbumTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AlbumTableViewCell /*else {
            fatalError("The dequeue cell is not an instance of AlbumTableViewCell.")
        }*/

        let album = albums[indexPath.row]
        
        cell.albumLabel.text = album.title
        cell.coverImageView.image = album.cover
        cell.artistLabel.text = album.artist
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            albums.remove(at: indexPath.row)
            saveAlbums()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let albumDetailViewController = segue.destination as? AlbumViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedAlbumCell = sender as? AlbumTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedAlbumCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedAlbum = albums[indexPath.row]
            albumDetailViewController.album = selectedAlbum
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
}
