import { TElementType } from "@/types/html-type";

export interface ISidebarItems {
  title: string;
  url?: string;
  icon?: TElementType;
  type?: "logout" | "title";
  child?: ISidebarItems[];
}
