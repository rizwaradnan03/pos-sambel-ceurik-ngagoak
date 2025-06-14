import { ISidebarItems } from "@/interfaces/sidebar-interface";
import { Home, House } from "lucide-react";

const baseRole = "/analytics/";

export const analyticsUrlItems: ISidebarItems[] = [
  {
    title: "Dashboard",
    url: baseRole,
    icon: Home,
  },
  {
    title: "Laporan",
    url: baseRole + "report",
    icon: House
  },
  {
    title: "Logout",
    type: "logout",
  },
];
