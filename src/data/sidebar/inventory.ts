import { ISidebarItems } from "@/interfaces/sidebar-interface";
import { Home, House } from "lucide-react";

const baseRole = "/inventory/";

export const inventoryUrlItems: ISidebarItems[] = [
  {
    title: "Dashboard",
    url: baseRole + "dashboard",
    icon: Home,
  },
  {
    title: "Inventory",
    url: baseRole + "inventory",
    icon: House
  },
  {
    title: "Logout",
    type: "logout",
  },
];
