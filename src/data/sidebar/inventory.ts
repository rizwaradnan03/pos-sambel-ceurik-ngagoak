import { ISidebarItems } from "@/interfaces/sidebar-interface";
import { Apple, Archive, Home, House, LayoutDashboard } from "lucide-react";

const baseRole = "/inventory/";

export const inventoryUrlItems: ISidebarItems[] = [
  {
    title: "Dashboard",
    url: baseRole,
    icon: LayoutDashboard,
  },
  {
    title: "Produk",
    url: baseRole + "product",
    icon: Apple,
  },
  {
    title: "Bahan Baku",
    url: baseRole + "ingredient",
    icon: Archive
  },
  {
    title: "Logout",
    type: "logout",
  },
];
