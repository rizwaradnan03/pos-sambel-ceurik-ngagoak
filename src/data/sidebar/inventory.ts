import { ISidebarItems } from "@/interfaces/sidebar-interface";
import { Apple, Archive, BookType, Home, House, LayoutDashboard } from "lucide-react";

const baseRole = "/inventory/";

export const inventoryUrlItems: ISidebarItems[] = [
  {
    title: "Dashboard",
    url: baseRole,
    icon: LayoutDashboard,
  },
  {
    title: "Bahan Baku",
    url: baseRole + "ingredient",
    icon: Archive
  },
  {
    title: "Produk",
    url: baseRole + "product",
    icon: Apple,
  },
  {
    title: "Paket",
    url: baseRole + "package",
    icon: Apple,
  },
  {
    title: "Kategori",
    url: baseRole + "category",
    icon: BookType,
  },
  {
    title: "Logout",
    type: "logout",
  },
];
