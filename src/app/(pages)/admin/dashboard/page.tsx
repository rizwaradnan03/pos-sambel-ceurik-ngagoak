"use client"

import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import {
  Sidebar,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarProvider
} from "@/components/ui/sidebar"
import { Sheet, SheetContent, SheetTrigger } from "@/components/ui/sheet"
import { Button } from "@/components/ui/button"
import { Home, ShoppingCart, BarChart2, Menu } from "lucide-react"
import {
  ResponsiveContainer,
  PieChart as RePieChart,
  Pie,
  Cell,
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  BarChart,
  Bar,
} from "recharts"

export default function ResponsiveAdminDashboard() {
  // Dummy data for charts
  const pieChartData = [
    { name: "Product A", value: 400 },
    { name: "Product B", value: 300 },
    { name: "Product C", value: 200 },
    { name: "Product D", value: 100 },
  ]

  const lineChartData = Array.from({ length: 24 }, (_, i) => ({
    hour: `${i}:00`,
    sales: Math.floor(Math.random() * 100) + 20,
  }))

  const barChartData = Array.from({ length: 7 }, (_, i) => ({
    day: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][i],
    sales: Math.floor(Math.random() * 1000) + 500,
  }))

  const COLORS = ["#FF6B6B", "#FF8E8E", "#FFA5A5", "#FFC2C2"]

  // ✅ Perbaikan: Ganti nama komponen SidebarContent agar tidak bentrok
  const SidebarMenuContent = () => (
    <div className="p-4">
      <SidebarGroup>
        <SidebarGroupLabel className="text-red-800">Menu</SidebarGroupLabel>
        <SidebarGroupContent>
          <SidebarMenu>
            <SidebarMenuItem>
              <SidebarMenuButton className="text-red-700 hover:bg-red-50">
                <Home className="mr-2 h-4 w-4" />
                <span>Dashboard</span>
              </SidebarMenuButton>
            </SidebarMenuItem>
            <SidebarMenuItem>
              <SidebarMenuButton className="text-red-700 hover:bg-red-50">
                <ShoppingCart className="mr-2 h-4 w-4" />
                <span>Orders</span>
              </SidebarMenuButton>
            </SidebarMenuItem>
            <SidebarMenuItem>
              <SidebarMenuButton className="text-red-700 hover:bg-red-50">
                <BarChart2 className="mr-2 h-4 w-4" />
                <span>Analytics</span>
              </SidebarMenuButton>
            </SidebarMenuItem>
          </SidebarMenu>
        </SidebarGroupContent>
      </SidebarGroup>
    </div>
  )

  return (
    <SidebarProvider>
      <div className="flex h-screen bg-gradient-to-br from-red-50 to-red-100">
        {/* Sidebar (Desktop) */}
        <Sidebar className="w-64 hidden lg:block bg-white border-r">
          <SidebarMenuContent />
        </Sidebar>

        {/* Main Content */}
        <div className="flex-1 flex flex-col p-4 lg:p-8 overflow-auto">
          {/* Header untuk Mobile */}
          <div className="flex justify-between items-center lg:hidden mb-4">
            <h1 className="text-2xl font-bold text-red-800">Admin Dashboard</h1>
            <Sheet>
              <SheetTrigger asChild>
                <Button variant="outline" size="icon" className="lg:hidden">
                  <Menu className="h-6 w-6" />
                </Button>
              </SheetTrigger>
              <SheetContent side="left" className="w-64 p-0">
                <SidebarMenuContent />
              </SheetContent>
            </Sheet>
          </div>

          {/* Header untuk Desktop */}
          <h1 className="text-3xl font-bold mb-6 text-red-800 hidden lg:block">Admin Dashboard</h1>

          {/* Kartu Total Pembelian */}
          <Card className="mb-6 bg-white border-red-200">
            <CardHeader>
              <CardTitle className="text-red-800">Today's Total Purchases</CardTitle>
              <CardDescription className="text-red-600">Summary of today's sales</CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-4xl font-bold text-red-700">Rp 12,345,678</p>
            </CardContent>
          </Card>

          {/* Grid untuk Chart */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {/* Pie Chart */}
            <Card className="bg-white border-red-200">
              <CardHeader>
                <CardTitle className="text-red-800">Product Purchases</CardTitle>
                <CardDescription className="text-red-600">Distribution of product sales</CardDescription>
              </CardHeader>
              <CardContent>
                <ResponsiveContainer width="100%" height={300}>
                  <RePieChart>
                    <Pie
                      data={pieChartData}
                      cx="50%"
                      cy="50%"
                      labelLine={false}
                      outerRadius={80}
                      fill="#8884d8"
                      dataKey="value"
                    >
                      {pieChartData.map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                      ))}
                    </Pie>
                    <Tooltip />
                    <Legend />
                  </RePieChart>
                </ResponsiveContainer>
              </CardContent>
            </Card>

            {/* Line Chart */}
            <Card className="bg-white border-red-200">
              <CardHeader>
                <CardTitle className="text-red-800">Hourly Sales Traffic</CardTitle>
                <CardDescription className="text-red-600">Sales trend throughout the day</CardDescription>
              </CardHeader>
              <CardContent>
                <ResponsiveContainer width="100%" height={300}>
                  <LineChart data={lineChartData}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="hour" />
                    <YAxis />
                    <Tooltip />
                    <Legend />
                    <Line type="monotone" dataKey="sales" stroke="#FF6B6B" activeDot={{ r: 8 }} />
                  </LineChart>
                </ResponsiveContainer>
              </CardContent>
            </Card>

            {/* Bar Chart */}
            <Card className="bg-white border-red-200">
              <CardHeader>
                <CardTitle className="text-red-800">Daily Sales Comparison</CardTitle>
                <CardDescription className="text-red-600">Sales for the past week</CardDescription>
              </CardHeader>
              <CardContent>
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={barChartData}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="day" />
                    <YAxis />
                    <Tooltip />
                    <Legend />
                    <Bar dataKey="sales" fill="#FF6B6B" />
                  </BarChart>
                </ResponsiveContainer>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </SidebarProvider>
  )
}
