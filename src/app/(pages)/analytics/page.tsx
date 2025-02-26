"use client";
import { Button } from "@/components/ui/button";
import { UseReportByMonth } from "@/hooks/api/report/byMonth";
import toast from "react-hot-toast";

export default function AnalyticsPage() {
  // ✅ Fungsi untuk Download Laporan Bulanan
  // const handleDownloadReportByMonth = async () => {
  //   try {
  //     const data = await UseReportByMonth(); // Mengambil data laporan dari hook
  //     if (!data) throw new Error("Data laporan tidak ditemukan");

  //     // Konversi data menjadi Blob (file Excel)
  //     const blob = new Blob([data], {
  //       type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  //     });
  //     // Buat URL Blob
  //     const url = window.URL.createObjectURL(blob);

  //     // Buat elemen <a> untuk download file
  //     const a = document.createElement("a");
  //     a.href = url;
  //     a.download = "Laporan_Bulanan.xlsx";
  //     document.body.appendChild(a);
  //     a.click();

  //     // Bersihkan setelah download
  //     document.body.removeChild(a);
  //     window.URL.revokeObjectURL(url);

  //     toast.success("Laporan berhasil diunduh!");
  //   } catch (error: any) {
  //     toast.error(error.message || "Terjadi kesalahan saat mengunduh laporan");
  //   }
  // };

  const handleDownloadReportByMonth = async () => {
    try {
      const response = await fetch("/api/authenticated/report/by-month");
  
      if (!response.ok) throw new Error("Gagal mengunduh laporan");
  
      const blob = await response.blob();
  
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = url;
      a.download = "Laporan_Bulanan.xlsx";
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      window.URL.revokeObjectURL(url);
  
      toast.success("Laporan berhasil diunduh!");
    } catch (error: any) {
      toast.error(error.message || "Terjadi kesalahan saat mengunduh laporan");
    }
  };
  

  return (
    <div className="p-6 bg-gray-100 min-h-screen">
      <h1 className="text-2xl font-bold text-gray-800 mb-4">Analytics</h1>

      {/* Tombol Download Laporan */}
      <Button onClick={handleDownloadReportByMonth}>
        Download Laporan Bulanan
      </Button>
    </div>
  );
}
