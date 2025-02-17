interface ICommon {
    id: string;
    createdAt: Date;
    updatedAt: Date;
}

export interface ISUser extends ICommon {
    name: string;
    role: "ADMIN" | "CASHIER";
    email: string;
    password: string
}

export interface ISCategory extends ICommon {
    title: string;
    ProductCategory?: ISProductCategory[];
}

export interface ISProduct extends ICommon {
    name: string;
    
    ProductCategory?: ISProductCategory[];
    ProductIngredient: ISProductIngredient[];
    OrderProduct: ISOrderProduct[];
}

export interface ISProductCategory extends ICommon {
    productId: string;
    categoryId: string;

    Product?: ISProduct;
    Category?: ISCategory;
}

export interface ISIngredient extends ICommon {
    name: string;
    stock: string;
    unitOfMeasure: "G" | "ML" | "PCS";

    ProductIngredient?: ISProductIngredient[];
}

export interface ISProductIngredient extends ICommon {
    productId: string;
    ingredientId: string;
    dose: string;
    Product?: ISProduct;
    Ingredient?: ISIngredient;
}

export interface ISOrder extends ICommon {
    name: string;
    paymentType: "CASH";

    OrderProduct: ISOrderProduct[];
}

export interface ISOrderProduct extends ICommon {
    orderId: string;
    productId: string;
    pcs: number;

    Order?: ISOrder;
    Product?: ISProduct;
}