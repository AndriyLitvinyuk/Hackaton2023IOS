//
//  User.swift
//  Hackaton2023IOS
//
//  Created by Oleksandr Bondar3 on 13.05.2023.
//

import Foundation

struct User: Decodable {
    struct PersonalInfo: Decodable {
        let id: String
        let firstName: String
        let lastName: String
    }

    struct OrganizationalAttributes: Decodable {
        let trackAndLevel: String
        let title: String
        let productionCategory: String
        let organizationalCategory: String
        let primarySkill: String
        let employmentStatus: String
        let unit: String
        let startDate: String
        let worksiteLocation: String
    }

    struct WorkExperience: Decodable {
        let profileSummary: String
        let experience: [Experience]

        // swiftlint: disable nesting
        struct Experience: Decodable {
            let company: String
            let customer: String
            let startDate: String
            let endDate: String
            let project: String
            let title: String
            let projectRole: String
            let teamSize: String
            let database: String
            let tools: String
            let technologies: String
        }
    }

    struct Skill: Decodable {
        let category: String
        let skill: String
        let level: String
    }

    struct EducationAndTraining: Decodable {
        let education: String
        let trainingCourses: String
    }

    struct Certification: Decodable {
        let certificateName: String
        let certificateType: String
        let issuer: String
        let competencies: String
        let status: String
    }

    struct Contribution: Decodable {
        let category: String
        let level: String
        let description: String
    }

    struct Recognition: Decodable {
        let category: String
        let level: String
        let description: String
    }

    let personalInfo: PersonalInfo
    let organizationalAttributes: OrganizationalAttributes
    let keySkills: [String]
    let workExperience: WorkExperience
    let skills: [Skill]
    let educationAndTraining: EducationAndTraining
    let certifications: [Certification]
    let contributions: [Contribution]
    let recognitions: [Recognition]
}
