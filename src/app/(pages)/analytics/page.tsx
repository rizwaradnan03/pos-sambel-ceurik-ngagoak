"use client";
import dynamic from "next/dynamic";
import { useState } from "react";

// Load ApexCharts secara dinamis (CSR)
const Chart = dynamic(() => import("react-apexcharts"), { ssr: false });

export default function AnalyticsPage() {
  // 📊 Data Pie Chart (Penjualan berdasarkan kategori)
  const pieChartData = {
    series: [40, 25, 15, 20], // Jumlah order per kategori
    labels: ["Makanan", "Minuman", "Camilan", "Paket"], // Nama kategori
  };

  // 📈 Data Line Chart (Pertumbuhan penjualan per bulan)
  const lineChartData = {
    series: [
      {
        name: "Total Order",
        data: [10, 15, 25, 40, 35, 50, 60, 55, 70, 90, 100, 120], // Total order per bulan
      },
    ],
    categories: [
      "Jan", "Feb", "Mar", "Apr", "Mei", "Jun",
      "Jul", "Agu", "Sep", "Okt", "Nov", "Des",
    ],
  };

  return (
    <div className="p-6 bg-gray-100 min-h-screen">
      <h1 className="text-2xl font-bold text-gray-800 mb-4">Analytics</h1>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {/* Pie Chart */}
        <div className="bg-white p-6 rounded-xl shadow-lg">
          <h2 className="text-xl font-semibold mb-2">Penjualan Berdasarkan Kategori</h2>
          <Chart
            options={{
              labels: pieChartData.labels,
              chart: { type: "donut" },
              legend: { position: "bottom" },
            }}
            series={pieChartData.series}
            type="donut"
            width="100%"
          />
        </div>

        {/* Line Chart */}
        <div className="bg-white p-6 rounded-xl shadow-lg">
          <h2 className="text-xl font-semibold mb-2">Pertumbuhan Order Per Bulan</h2>
          <Chart
            options={{
              chart: { type: "line", zoom: { enabled: false } },
              xaxis: { categories: lineChartData.categories },
            }}
            series={lineChartData.series}
            type="line"
            width="100%"
          />
        </div>
      </div>
    </div>
  );
}
