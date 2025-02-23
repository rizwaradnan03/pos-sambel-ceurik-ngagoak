interface ICommon {
    id: string;
    createdAt: Date;
    updatedAt: Date;
}

// ENUMS
export type RoleEnum = "ADMIN" | "CASHIER" | "INVENTORY" | "ANALYTICS";
export type UnitOfMeasureEnum = "G" | "ML" | "PCS";
export type PaymentTypeEnum = "CASH" | "CARD" | "TRANSFER";

// USERS
export interface ISUser extends ICommon {
    name: string;
    email: string;
    password: string;
    role: RoleEnum;
}

// CATEGORIES
export interface ISCategory extends ICommon {
    title: string;
    ProductCategory?: ISProductCategory[];
}

// PRODUCTS
export interface ISProduct extends ICommon {
    name: string;
    image?: string;
    price: number;
    
    ProductCategory?: ISProductCategory[];
    ProductIngredient?: ISProductIngredient[];
    OrderProduct?: ISOrderProduct[];
}

export interface ISProductCategory extends ICommon {
    productId: string;
    categoryId: string;
    Product?: ISProduct;
    Category?: ISCategory;
}

// INGREDIENTS
export interface ISIngredient extends ICommon {
    name: string;
    stock: number;
    unitOfMeasure: UnitOfMeasureEnum;
    avgCostPerUnit: number;
    
    ProductIngredient?: ISProductIngredient[];
    LogIngredient?: ISLogIngredient[];
    IngredientPurchase?: ISIngredientPurchase[];
}

export interface ISProductIngredient extends ICommon {
    productId: string;
    ingredientId: string;
    dose: number;
    Product?: ISProduct;
    Ingredient?: ISIngredient;
}

// INGREDIENT PURCHASES
export interface ISIngredientPurchase extends ICommon {
    ingredientId: string;
    quantity: number;
    pricePerUnit: number;
    totalCost: number;
    supplier?: string;
    Ingredient?: ISIngredient;
}

// LOGS
export interface ISLogIngredient extends ICommon {
    ingredientId: string;
    description: string;
    Ingredient?: ISIngredient;
}

// ORDERS & TRANSACTIONS
export interface ISOrder extends ICommon {
    customer?: string;
    paymentType: PaymentTypeEnum;
    totalPrice: number;
    totalCost: number;
    profit: number;

    OrderProduct?: ISOrderProduct[];
    LogOrder?: ISLogOrder[];
}

export interface ISOrderProduct extends ICommon {
    orderId: string;
    productId: string;
    quantity: number;

    Order?: ISOrder;
    Product?: ISProduct;
}

export interface ISLogOrder extends ICommon {
    orderId: string;
    description: string;
    Order?: ISOrder;
}

// EXPENSES (BIAYA OPERASIONAL)
export interface ISExpense extends ICommon {
    name: string;
    amount: number;
    category: string;
    description?: string;
}
