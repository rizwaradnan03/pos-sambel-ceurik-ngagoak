import { Option } from "@/components/ui/multiple-selector";
import { CategoryEnum, PaymentTypeEnum, UnitOfMeasureEnum } from "./schema-interface";

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

export interface IFProductIngredient {
    dose: number;
    productId: string;
    ingredientId: string;
}

export interface IFPackage {
    name: string;
    price: number;
    image?: string;
}

export interface IFCategory {
    title: string;
    category: CategoryEnum
}

export interface IFProductCategory {
    productId: string;
    selectedCategories: Option[];
}

export interface IFCategorySave {
    categoryId: string;
    selectedItems: Option[]
}

export interface IFProductPackage {
    packageId: string;
    selectedProducts: Option[]
}

export interface IFCartItem {
  id: string;
  name: string;
  price: number;
  quantity: number;
  category: "PRODUCT" | "PACKAGE"
}

export interface IFOrder {
    customer: string;
    isTaxEnable: boolean;
    totalPrice: number;
    taxAmount?: number;
    paymentType: PaymentTypeEnum;
    cart: IFCartItem[];
}

export interface IFExpense {
    name: string;
    amount: number;
    description: string;
    createdAt: string
}