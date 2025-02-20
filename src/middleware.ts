import { getToken } from "next-auth/jwt";
import { NextRequest, NextResponse } from "next/server";

export async function middleware(req: NextRequest) {
  const res = NextResponse.next();

  const pathName = req.nextUrl.pathname
  
  const token = await getToken({
    req,
    secret: process.env.NEXTAUTH_SECRET,
  });

  if (!token) {
    let url = new URL("/auth/login/", req.url);

    url.searchParams.set("callbackUrl", encodeURI(req.url));

    return NextResponse.redirect(url);
  }

  return res;
}

export const config = {
    matcher: [
        // '/api/authenticated/:path*',
        // '/cashier/:path*',
        // '/admin/:path*'
    ]
}
