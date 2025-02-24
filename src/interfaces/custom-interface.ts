import { ICommon } from "./schema-interface";

export interface ICCategory {
    label: string;
    value: string;
}

export interface ICItem extends ICommon {
    name: string;
    image?: string;
    price: number;
    type: "product" | "package"
}