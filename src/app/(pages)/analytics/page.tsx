"use client";

import { UseFetchReportDashboard } from '@/hooks/api/report/dashboard';
import { formatPrice } from '@/lib/number';
import React, { useEffect, useState } from 'react';
import Chart from 'react-apexcharts';

const Dashboard = () => {
  const [todaySales, setTodaySales] = useState<number>(0);
  const [thisMonthSales, setThisMonthSales] = useState<number>(0);
  const [dailySales, setDailySales] = useState({ labels: [], data: [] });

  useEffect(() => {
    const fetchData = async () => {
      try {
        const fetch = await UseFetchReportDashboard();

        setTodaySales(fetch.data.todaySales);
        setThisMonthSales(fetch.data.thisMonthSales);
        setDailySales(fetch.data.dailySales);
      } catch (error) {
        console.error('Error fetching dashboard data:', error);
      }
    };

    fetchData();
  }, []);

  const chartOptions = {
    chart: {
      id: 'daily-sales-chart',
      toolbar: {
        show: true,
      },
    },
    xaxis: {
      categories: dailySales.labels,
      labels: {
        style: {
          colors: '#ffffff',
        },
      },
    },
    yaxis: {
      labels: {
        style: {
          colors: '#ffffff',
        },
      },
    },
    tooltip: {
      theme: 'dark',
    },
    colors: ['#FF4560'],
    plotOptions: {
      bar: {
        borderRadius: 4,
        horizontal: false,
      },
    },
    dataLabels: {
      enabled: false,
    },
  };

  const chartSeries = [
    {
      name: 'Penjualan Harian',
      data: dailySales.data,
    },
  ];

  return (
    <div className="w-full min-h-screen bg-white text-gray-900 p-8">
      <h1 className="text-3xl font-bold mb-8 text-red-600">Dashboard Penjualan</h1>

      {/* Card untuk Total Penjualan Hari Ini */}
      <div className="bg-red-50 p-6 rounded-lg shadow-lg mb-8 border border-red-100">
        <h2 className="text-xl font-semibold mb-2 text-red-600">Total Penjualan Hari Ini</h2>
        <p className="text-2xl text-red-600">Rp {formatPrice({value: todaySales.toString()})}</p>
      </div>

      {/* Card untuk Total Penjualan Bulan Ini */}
      <div className="bg-red-50 p-6 rounded-lg shadow-lg mb-8 border border-red-100">
        <h2 className="text-xl font-semibold mb-2 text-red-600">Total Penjualan Bulan Ini</h2>
        <p className="text-2xl text-red-600">Rp {formatPrice({value: thisMonthSales.toString()})}</p>
      </div>

      {/* Chart Pertumbuhan Penjualan Harian */}
      <div className="bg-red-50 p-6 rounded-lg shadow-lg border border-red-100">
        <h2 className="text-xl font-semibold mb-4 text-red-600">Pertumbuhan Penjualan Harian</h2>
        <Chart
          options={chartOptions}
          series={chartSeries}
          type="bar"
          height={350}
        />
      </div>
    </div>
  );
};

export default Dashboard;