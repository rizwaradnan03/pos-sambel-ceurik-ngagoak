import Credentials from "next-auth/providers/credentials";
import { prisma } from "@/lib/prisma";
import bcryptjs from "bcryptjs";
import { NextAuthOptions } from "next-auth";

export const authOptions: NextAuthOptions = {
  secret: process.env.NEXT_AUTH_SECRET, // Tambahkan secret untuk keamanan
  session: {
    strategy: "jwt",
    maxAge: 3 * 60 * 60, // 3 jam
  },
  providers: [
    Credentials({
      name: "Credentials",
      credentials: {
        email: { label: "Email", type: "email", placeholder: "@.com" },
        password: { label: "Password", type: "password", placeholder: "*" },
      },
      async authorize(credentials: any) {
        const { email, password } = credentials;

        // Cek apakah user ada di database
        const user = await prisma.user.findFirst({
          where: { email: email },
        });

        // Jika user tidak ditemukan
        if (!user) {
          throw new Error("Invalid Email / Password");
        }

        // Periksa kecocokan password
        const isPasswordValid = await bcryptjs.compare(password, user.password);

        if (!isPasswordValid) {
          throw new Error("Invalid Email / Password");
        }

        console.log("Login berhasil: ", user);

        const payload = {
          id: user.id,
          name: user.name,
          email: user.email,
          role: user.role,
        }

        console.log('payload return ', payload)

        return payload
      },
    }),
  ],
  callbacks: {
    async jwt({ token, user }: {token: any, user: any}) {
      if (user) {
        token.id = user.id;
        token.name = user.name;
        token.email = user.email;
        token.role = user.role;
      }
      console.log("Token JWT:", token);
      return token;
    },
    async session({ session, token }: {session: any, token: any}) {
      if (token) {
        session.id = token.id;
        session.name = token.name;
        session.email = token.email;
        session.role = token.role;
      }
      console.log("Session aktif:", session);
      return session;
    },
  },
};
