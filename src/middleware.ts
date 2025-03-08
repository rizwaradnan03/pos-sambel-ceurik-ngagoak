import { getToken } from "next-auth/jwt";
import { NextRequest, NextResponse } from "next/server";

export async function middleware(req: NextRequest) {
  const pathName = req.nextUrl.pathname;
  const token = await getToken({ req, secret: process.env.NEXT_AUTH_SECRET });

  // Jika pengguna belum login, redirect ke halaman login
  if (!token) {
    let url = new URL("/auth/login/", req.url);
    url.searchParams.set("callbackUrl", encodeURI(req.url));
    return NextResponse.redirect(url);
  }

  // Ambil role dari token dan ubah ke huruf besar (untuk memastikan konsistensi)
  const userRole = typeof token.role === 'string' ? token.role.toUpperCase() : '';

  // Daftar akses berdasarkan role (menggunakan huruf besar)
  const roleBasedAccess: Record<string, string[]> = {
    "/admin": ["ADMIN"],
    "/cashier": ["CASHIER", "ADMIN"], // Admin juga bisa mengakses cashier
    "/inventory": ["ADMIN", "INVENTORY"],
    "/analytics": ["ADMIN", "ANALYTICS"],
  };

  // Cek apakah path memerlukan akses khusus
  for (const route in roleBasedAccess) {
    if (pathName.startsWith(route)) {
      if (!roleBasedAccess[route].includes(userRole)) {
        return NextResponse.redirect(new URL("/", req.url)); // Redirect ke halaman utama jika tidak memiliki izin
      }
    }
  }

  return NextResponse.next();
}

export const config = {
  matcher: ["/api/authenticated/:path*", "/cashier/:path*", "/admin/:path*", "/inventory/:path*", "/analytics/:path*"],
};
