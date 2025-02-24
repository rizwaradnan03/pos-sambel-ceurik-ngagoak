"use client"

import { Geist_Mono } from "next/font/google"; 
import { Toaster } from "react-hot-toast";
import "./globals.css";
import { SessionProvider } from "next-auth/react";

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en">
      <body className={`${geistMono.variable} antialiased`}>
        <Toaster position="top-center" reverseOrder={false} />
        <SessionProvider>{children}</SessionProvider>
      </body>
    </html>
  );
}
