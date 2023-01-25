//
//  GeneratedRecipe.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-23.
//

import Foundation

struct GeneratedRecipeElement: Codable {
    internal init(uuid: String, customerUUID: String, name: String, originalName: String, description: String, originalDescription: String, images: [String], newImages: [NewImage], newOriginalImages: [NewImage], ingredients: [String], originalIngredients: [String], instructions: [Instruction], originalInstructions: [Instruction], yield: String, originalYield: String, prepTime: String, cookTime: String, totalTime: String, originalTotalTime: String, url: String, created: String, createdBy: String, updated: String) {
        self.uuid = uuid
        self.customerUUID = customerUUID
        self.name = name
        self.originalName = originalName
        self.description = description
        self.originalDescription = originalDescription
        self.images = images
        self.newImages = newImages
        self.newOriginalImages = newOriginalImages
        self.ingredients = ingredients
        self.originalIngredients = originalIngredients
        self.instructions = instructions
        self.originalInstructions = originalInstructions
        self.yield = yield
        self.originalYield = originalYield
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.totalTime = totalTime
        self.originalTotalTime = originalTotalTime
        self.url = url
        self.created = created
        self.createdBy = createdBy
        self.updated = updated
    }
    
    let uuid, customerUUID, name, originalName: String
    let description, originalDescription: String
    let images: [String]
    let newImages, newOriginalImages: [NewImage]
    let ingredients, originalIngredients: [String]
    let instructions, originalInstructions: [Instruction]
    let yield, originalYield, prepTime, cookTime: String
    let totalTime, originalTotalTime: String
    let url: String
    let created, createdBy, updated: String

    enum CodingKeys: String, CodingKey {
        case uuid
        case customerUUID = "customer-uuid"
        case name
        case originalName = "original-name"
        case description
        case originalDescription = "original-description"
        case images
        case newImages = "new-images"
        case newOriginalImages = "new-original-images"
        case ingredients
        case originalIngredients = "original-ingredients"
        case instructions
        case originalInstructions = "original-instructions"
        case yield
        case originalYield = "original-yield"
        case prepTime = "prep-time"
        case cookTime = "cook-time"
        case totalTime = "total-time"
        case originalTotalTime = "original-total-time"
        case url, created
        case createdBy = "created-by"
        case updated
    }
}

// MARK: - Instruction
struct Instruction: Codable {
    let steps: [String]
}

// MARK: - NewImage
struct NewImage: Codable {
    let width, height: Int
    let type: TypeEnum
    let mime: MIME
    let wUnits, hUnits: Units
    let length: Int
    let url: String
}

enum Units: String, Codable {
    case px = "px"
}

enum MIME: String, Codable {
    case imageJPEG = "image/jpeg"
}

enum TypeEnum: String, Codable {
    case jpg = "jpg"
}

typealias GeneratedRecipe = [GeneratedRecipeElement]
