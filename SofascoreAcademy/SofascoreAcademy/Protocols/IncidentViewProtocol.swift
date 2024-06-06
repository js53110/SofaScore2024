import Foundation
import UIKit

protocol IncidentViewProtocol: AnyObject {
    func update(data: FootballIncident, matchData: Event)
}
