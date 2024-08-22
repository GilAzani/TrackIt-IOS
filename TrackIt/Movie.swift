import Foundation

class Movie: Codable {
    var id: Int
    var title: String
    var releaseDate: String // Now has a default value
    var overview: String
    var imageURL: String // Now has a default value
    var runtime: Int // Duration in minutes
    
    init(id: Int, title: String, releaseDate: String = "", overview: String, imageURL: String = "", runtime: Int) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.imageURL = imageURL
        self.runtime = runtime
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case overview
        case imageURL = "poster_path"
        case runtime
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        overview = try container.decode(String.self, forKey: .overview)
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        runtime = try container.decode(Int.self, forKey: .runtime)
    }
    
    func getPrettyTimeString() -> String {
        let hours = runtime / 60
        let minutes = runtime % 60
        var result = "\(runtime) minutes"
        
        if hours > 0 {
            result += " - \(hours)h \(minutes)m"
        }
        return result
    }
    
    func getReleaseYear() -> String {
        // Check if releaseDate is empty
        guard !releaseDate.isEmpty else {
            return ""
        }
        
        // Extract the year from releaseDate
        let year = String(releaseDate.prefix(4))
        return "year: \(year)"
    }
}
