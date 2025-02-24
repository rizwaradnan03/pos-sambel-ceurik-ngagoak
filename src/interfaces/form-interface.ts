import { Option } from "@/components/ui/multiple-selector";
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

export interface IFProduct {
    name: string;
    price: number;
    image?: string;
}

export interface IFPackage {
    name: string;
    price: number;
    image?: string;
}

export interface IFCategory {
    title: string;
}

export interface IFProductCategory {
    productId: string;
    selectedCategories: Option[];
}

export interface IFProductPackage {
    packageId: string;
    selectedProducts: Option[]
}

export interface IFCartItem {
  id: string;
  name: string;
  price: number;
  quantity: number
}