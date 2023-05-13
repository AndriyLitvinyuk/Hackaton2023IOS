//
//  ProfileTableView.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 13.05.2023.
//

import UIKit

struct SectionInfo {
    struct Cell {
        let title: String
        let value: String
    }
    let title: String
    let cells: [Cell]
}

final class ProfileTableView: UITableView {
    var user: User? {
        didSet {
            reloadData()
        }
    }

    var sectionInfo: [SectionInfo] = []

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func reloadData() {
        if let user {
            sectionInfo = Self.mapUser(user: user)
        }

        super.reloadData()
    }

    private static func mapPersonalInfo(user: User) -> SectionInfo {
        .init(
            title: "Personal Info",
            cells: [
                .init(title: "First Name", value: user.personalInfo.firstName),
                .init(title: "Last Name", value: user.personalInfo.lastName)
            ]
        )
    }

    private static func mapUser(user: User) -> [SectionInfo] {
        [
            Self.mapPersonalInfo(user: user),
            Self.mapOrganizationalAttributes(user: user),
            Self.mapKeySkills(user: user),
            Self.mapWorkExperience(user: user),
            Self.mapSkills(user: user),
            Self.mapEducationAndTraining(user: user),
            Self.mapCertifications(user: user),
            Self.mapContributions(user: user),
            Self.mapRecognitions(user: user)
        ]
    }

    private static func mapOrganizationalAttributes(user: User) -> SectionInfo {
        .init(
            title: "Organizational Attributes",
            cells: [
                .init(title: "Track and Level", value: user.organizationalAttributes.trackAndLevel),
                .init(title: "Title", value: user.organizationalAttributes.title),
                .init(title: "Production Category", value: user.organizationalAttributes.productionCategory),
                .init(
                    title: "Organizational Category", value: user.organizationalAttributes.organizationalCategory
                ),
                .init(title: "Primary Skill", value: user.organizationalAttributes.primarySkill),
                .init(title: "Employment Status", value: user.organizationalAttributes.employmentStatus),
                .init(title: "Unit", value: user.organizationalAttributes.unit),
                .init(title: "Start Date", value: user.organizationalAttributes.startDate),
                .init(title: "Worksite Location", value: user.organizationalAttributes.worksiteLocation)
            ]
        )
    }

    private static func mapKeySkills(user: User) -> SectionInfo {
        .init(
            title: "Key Skills",
            cells: user.keySkills.map { .init(title: "", value: $0) }
        )
    }

    private static func mapWorkExperience(user: User) -> SectionInfo {
        .init(
            title: "Work Experience",
            cells: [
                [.init(title: "Profile Summary", value: user.workExperience.profileSummary)],
                user.workExperience.experience.map(Self.mapExperience(experience:))
            ].flatMap { $0 }
        )
    }

    private static func mapExperience(experience: User.WorkExperience.Experience) -> SectionInfo.Cell {
        .init(
            title: "Customer: \(experience.customer)\n" +
            "Start Date: \(experience.startDate)\n" +
            "End Date: \(experience.endDate)\n" +
            "Project: \(experience.project)\n" +
            "Title: \(experience.title)\n" +
            "Project Role: \(experience.projectRole)\n" +
            "Team Size: \(experience.teamSize)\n" +
            "Database: \(experience.database)\n" +
            "Tools: \(experience.tools)\n" +
            "Technologies: \(experience.technologies)\n",
            value: experience.company
        )
    }

    private static func mapSkills(user: User) -> SectionInfo {
        .init(
            title: "Skills",
            cells: user.skills.map {
                .init(
                    title: $0.category,
                    value: "\($0.skill) (\($0.level))"
                )
            }
        )
    }

    private static func mapEducationAndTraining(user: User) -> SectionInfo {
        .init(
            title: "Education and Training",
            cells: [
                .init(title: "Education", value: user.educationAndTraining.education),
                .init(title: "Training Courses", value: user.educationAndTraining.trainingCourses)
            ]
        )
    }

    private static func mapCertifications(user: User) -> SectionInfo {
        .init(
            title: "Certifications",
            cells: user.certifications.map {
                .init(
                    title: $0.certificateName,
                    value: """
\($0.certificateType), Issuer: \($0.issuer), Competencies: \($0.competencies), Status: \($0.status)
"""
                )
            }
        )
    }

    private static func mapContributions(user: User) -> SectionInfo {
        .init(title: "Contributions", cells: user.contributions.map { contribution in
            SectionInfo.Cell(
                title: contribution.category,
                value: "\(contribution.level) - \(contribution.description)"
            )
        })
    }

    private static func mapRecognitions(user: User) -> SectionInfo {
        .init(title: "Recognitions", cells: user.recognitions.map { recognition in
            SectionInfo.Cell(
                title: recognition.category,
                value: "\(recognition.level) - \(recognition.description)"
            )
        })
    }
}
