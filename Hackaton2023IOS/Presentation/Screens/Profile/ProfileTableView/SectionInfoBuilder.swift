//
//  SectionInfoBuilder.swift
//  Hackaton2023IOS
//
//  Created by Oleksandr Bondar3 on 13.05.2023.
//

import Foundation

struct SectionInfoBuilder {

    private let user: User

    init(user: User) {
        self.user = user
    }

    func build() -> [SectionInfo] {
        mapUser(user: user)
    }
}

private extension SectionInfoBuilder {

    func mapUser(user: User) -> [SectionInfo] {
        [
            mapPersonalInfo(user: user),
            mapOrganizationalAttributes(user: user),
            mapKeySkills(user: user),
            mapWorkExperience(user: user),
            mapSkills(user: user),
            mapEducationAndTraining(user: user),
            mapCertifications(user: user),
            mapContributions(user: user),
            mapRecognitions(user: user)
        ]
    }

    func mapPersonalInfo(user: User) -> SectionInfo {
        .init(
            title: "Personal Info",
            cells: [
                .init(title: "First Name", value: user.personalInfo.firstName),
                .init(title: "Last Name", value: user.personalInfo.lastName)
            ]
        )
    }

    private func mapOrganizationalAttributes(user: User) -> SectionInfo {
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

    private func mapKeySkills(user: User) -> SectionInfo {
        .init(
            title: "Key Skills",
            cells: user.keySkills.map { .init(title: "", value: $0) }
        )
    }

    private func mapWorkExperience(user: User) -> SectionInfo {
        .init(
            title: "Work Experience",
            cells: [
                [.init(title: "Profile Summary", value: user.workExperience.profileSummary)],
                user.workExperience.experience.map(mapExperience(experience:))
            ].flatMap { $0 }
        )
    }

    private func mapExperience(experience: User.WorkExperience.Experience) -> SectionInfo.Cell {
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

    private func mapSkills(user: User) -> SectionInfo {
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

    private func mapEducationAndTraining(user: User) -> SectionInfo {
        .init(
            title: "Education and Training",
            cells: [
                .init(title: "Education", value: user.educationAndTraining.education),
                .init(title: "Training Courses", value: user.educationAndTraining.trainingCourses)
            ]
        )
    }

    private func mapCertifications(user: User) -> SectionInfo {
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

    private func mapContributions(user: User) -> SectionInfo {
        .init(title: "Contributions", cells: user.contributions.map { contribution in
            SectionInfo.Cell(
                title: contribution.category,
                value: "\(contribution.level) - \(contribution.description)"
            )
        })
    }

    private func mapRecognitions(user: User) -> SectionInfo {
        .init(title: "Recognitions", cells: user.recognitions.map { recognition in
            SectionInfo.Cell(
                title: recognition.category,
                value: "\(recognition.level) - \(recognition.description)"
            )
        })
    }
}
