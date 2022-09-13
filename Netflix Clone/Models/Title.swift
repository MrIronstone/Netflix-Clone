//
//  Movie.swift
//  Netflix Clone
//
//  Created by admin on 28.08.2022.
//

import Foundation


struct TitlesResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let backdrop_path: String?
    let id: Int
    let media_type: String?
    let original_language: String?
    let original_title: String?
    let original_name: String?
    let popularity: Double?
    let poster_path: String?
    let overview: String?
    let release_date: String?
    let vote_average: Double?
    let vote_count: Int?
}

/*
 adult = 0;
 "backdrop_path" = "/wcKFYIiVDvRURrzglV9kGu7fpfY.jpg";
 "genre_ids" =             (
     14,
     28,
     12
 );
 id = 453395;
 "media_type" = movie;
 "original_language" = en;
 "original_title" = "Doctor Strange in the Multiverse of Madness";
 overview = "Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.";
 popularity = "1421.267";
 "poster_path" = "/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg";
 "release_date" = "2022-05-04";
 title = "Doctor Strange in the Multiverse of Madness";
 video = 0;
 "vote_average" = "7.502";
 "vote_count" = 5465;
}
 */
