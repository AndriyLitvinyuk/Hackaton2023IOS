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

extension User {
    static let defaultUser: User = {
        // swiftlint: disable all
        let personalInfo = User.PersonalInfo(id: "123456", firstName: "John", lastName: "Doe")
        let orgAttributes = User.OrganizationalAttributes(trackAndLevel: "Track 1, Level 2", title: "Software Engineer", productionCategory: "Product Development", organizationalCategory: "Engineering", primarySkill: "Swift", employmentStatus: "Full-time", unit: "Mobile App Development", startDate: "2018-01-01", worksiteLocation: "San Francisco")
        let workExperience = User.WorkExperience(profileSummary: "Experienced software engineer with a passion for building great products.", experience: [
            User.WorkExperience.Experience(company: "Acme Corp", customer: "Acme Inc", startDate: "2018-01-01", endDate: "2020-12-31", project: "Project X", title: "Software Engineer", projectRole: "Lead Developer", teamSize: "5", database: "MySQL", tools: "Xcode, Git, Jenkins", technologies: "Swift, Objective-C"),
            User.WorkExperience.Experience(company: "Beta Corp", customer: "Beta Inc", startDate: "2021-01-01", endDate: "2022-01-01", project: "Project Y", title: "Senior Software Engineer", projectRole: "Technical Lead", teamSize: "10", database: "PostgreSQL", tools: "Xcode, GitLab, Fastlane", technologies: "Swift, Kotlin")
        ])
        let skills = [
            User.Skill(category: "Programming Languages", skill: "Swift", level: "Expert"),
            User.Skill(category: "Databases", skill: "MySQL", level: "Intermediate"),
            User.Skill(category: "Tools", skill: "Xcode", level: "Expert")
        ]
        let educationAndTraining = User.EducationAndTraining(education: "Bachelor of Science in Computer Science", trainingCourses: "iOS Development with Swift")
        let certifications = [
            User.Certification(certificateName: "Apple Certified iOS Developer", certificateType: "Certification", issuer: "Apple Inc", competencies: "Swift, Xcode, UIKit, Interface Builder", status: "Active")
        ]
        let contributions = [
            User.Contribution(category: "Open Source", level: "Active Contributor", description: "Contributed to several popular open-source projects on GitHub"),
            User.Contribution(category: "Community", level: "Mentor", description: "Mentored several junior developers in mobile app development")
        ]
        let recognitions = [
            User.Recognition(category: "Company Awards", level: "Outstanding Performance Award", description: "Received the Outstanding Performance Award for exceptional work on Project X")
        ]
        // swiftlint: enable all
        return User(
            personalInfo: personalInfo,
            organizationalAttributes: orgAttributes,
            keySkills: ["Swift", "iOS Development", "Software Architecture"],
            workExperience: workExperience,
            skills: skills,
            educationAndTraining: educationAndTraining,
            certifications: certifications,
            contributions: contributions,
            recognitions: recognitions
        )
    }()
}
