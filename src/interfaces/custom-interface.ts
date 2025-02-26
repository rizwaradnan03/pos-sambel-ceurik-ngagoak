import { ICommon, ISPackage, ISProduct } from "./schema-interface";

export interface ICCategory {
    label: string;
    value: string;
}

export interface ICCartItem extends ICommon {
    name: string;
    image?: string;
    price: number;
    type: "product" | "package"
}
export interface ICCategoryItem extends ICommon {
    name: string;
    productId?: string;
    packageId?: string;
    Product?: ISProduct;
    Package?: ISPackage;
    image?: string;
    price: number;
    type: "product" | "package"
}

