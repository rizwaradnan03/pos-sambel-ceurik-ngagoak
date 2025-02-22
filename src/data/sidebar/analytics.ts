import { ISidebarItems } from "@/interfaces/sidebar-interface";
import { Home, House } from "lucide-react";

const baseRole = "/analytics/";

export const analyticsUrlItems: ISidebarItems[] = [
  {
    title: "Dashboard",
    url: baseRole + "dashboard",
    icon: Home,
  },
  {
    title: "Analytics",
    url: baseRole + "analytics",
    icon: House
  },
  {
    title: "Logout",
    type: "logout",
  },
];
