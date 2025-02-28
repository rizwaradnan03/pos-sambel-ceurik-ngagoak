"use client";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { UseReportByMonth } from "@/hooks/api/report/byMonth";
import toast from "react-hot-toast";
import { useState } from "react";

export default function AnalyticsPage() {
  const [month, setMonth] = useState("");

  const handleDownloadReportByMonth = async () => {
    try {
      let formattedMonth = ""
      let formattedYear = ""

      let isHitTheStrip = false
      for (let i = 0; i < month.length; i++) {
        if (month[i] == "-") {
          isHitTheStrip = true
        }

        if (!isHitTheStrip) {
          formattedYear += month[i]
        } else {
          if(month[i] != "-"){
            formattedMonth += month[i]
          }
        }
      }
      console.log("formatted month ", formattedMonth)

      const numberedMonth = Number(formattedMonth)
      const numberedYear = Number(formattedYear)

      const response = await fetch(`/api/authenticated/report/by-month`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          month: numberedMonth,
          year: numberedYear
        })
      });

      if (!response.ok) throw new Error("Gagal mengunduh laporan");

      const blob = await response.blob();

      const url = window.URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = url;
      a.download = `Laporan_Bulanan_${numberedMonth}_${numberedYear}.xlsx`;
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      window.URL.revokeObjectURL(url);

      toast.success("Laporan berhasil diunduh!");
    } catch (error: any) {
      toast.error(error.message || "Terjadi kesalahan saat mengunduh laporan");
    }
  };

  console.log("month nya ", month)

  return (
    <div className="p-6 bg-gray-100 min-h-screen">
      <h1 className="text-2xl font-bold text-gray-800 mb-4">Laporan</h1>
      <div className="flex flex-col gap-4">
        <div className="flex flex-row gap-4">
          <Input type="month" value={month} onChange={(e) => setMonth(e.target.value)} />
        </div>
        <div>
          <Button onClick={handleDownloadReportByMonth}>
            Download Laporan Bulanan
          </Button>
        </div>
      </div>
    </div>
  );
}