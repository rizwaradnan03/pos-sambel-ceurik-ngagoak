import { UnitOfMeasureEnum } from "./schema-interface";

export interface IFIngredient {
    name: string;
    stock: number;
    unitOfMeasure: UnitOfMeasureEnum;
}

export interface IFIngredientPurchase {
    ingredientId: string;
    quantity: number;
    pricePerUnit: number;
    totalCost: number;
}