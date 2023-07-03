/// A SpacePhoto contains information about a single day's photo record
/// including its date, a title, description, etc.
struct SpacePhoto {
    /// The title of the astronomical photo.
    var title: String

    /// A description of the astronomical photo.
    var description: String

    /// The date the given entry was added to the catalog.
    var date: Date

    /// A link to the image contained within the entry.
    var url: URL
}


extension SpacePhoto: Codable { /// To ensure we can instantiate SpacePhoto instances from a server response.
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case date
        case url
    }

    init(data: Data) throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy =
            .formatted(SpacePhoto.dateFormatter)

        self = try JSONDecoder()
            .decode(SpacePhoto.self, from: data)
    }
}

extension SpacePhoto: Identifiable { /// To ensure we can iterate through instances using ForEach.
    var id: Date { date }
}

extension SpacePhoto {
    static let urlTemplate = "https://example.com/photos"
    static let dateFormat = "yyyy-MM-dd"

    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = Self.dateFormat
        return formatter
    }

    static func requestFor(date: Date) -> URL {
        let dateString = SpacePhoto.dateFormatter.string(from: date)
        return URL(string: "\(SpacePhoto.urlTemplate)&date=\(dateString)")!
    }

    private static func parseDate(
        fromContainer container: KeyedDecodingContainer<CodingKeys>
    ) throws -> Date {
        let dateString = try container.decode(String.self, forKey: .date)
        guard let result = dateFormatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(
                forKey: .date,
                in: container,
                debugDescription: "Invalid date format")
        }
        return result
    }

    private var dateString: String {
        Self.dateFormatter.string(from: date)
    }
}

extension SpacePhoto {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        date = try Self.parseDate(fromContainer: container)
        url = try container.decode(URL.self, forKey: .url)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(dateString, forKey: .date)
    }
}