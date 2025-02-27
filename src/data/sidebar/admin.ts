import { ISidebarItems } from "@/interfaces/sidebar-interface";
import { CircleDollarSign, Home, House, User2, Wallet } from "lucide-react";

const baseRole = "/admin/";

export const adminUrlItems: ISidebarItems[] = [
  {
    title: "Dashboard",
    url: baseRole + "dashboard",
    icon: Home,
  },
  // {
  //   title: "Analytics",
  //   url: baseRole + "analytics",
  //   icon: House
  // },
  {
    title: "Biaya Operasional",
    url: baseRole + "expense",
    icon: Wallet,
  },
  {
    title: "Karyawan",
    url: baseRole + "employee",
    icon: User2,
  },
  {
    title: "Gaji",
    url: baseRole + "employee",
    icon: CircleDollarSign,
  },
  {
    title: "Logout",
    type: "logout",
  },
];
