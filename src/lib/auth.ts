import Credentials from "next-auth/providers/credentials";
import { prisma } from "@/lib/prisma";
import bcryptjs from "bcryptjs";
import { NextAuthOptions } from "next-auth";
import { ISUser } from "@/interfaces/schema-interface";

export const authOptions: NextAuthOptions = {
  session: {
    strategy: "jwt",
    maxAge: 3 * 60 * 60,
  },
  providers: [
    Credentials({
      name: "Credentials",
      credentials: {
        email: { label: "Email", type: "email", placeholder: "@.com" },
        password: { label: "Password", type: "password", placeholder: "*" },
      },
      async authorize(credentials: any, req: any) {
        const { email, password } = credentials;

        const user = await prisma.user.findFirst({
            where: {
                email: email
            }
        })

        const isPasswordValid = bcryptjs.compare(password, user?.password || "")
        if(!user|| !isPasswordValid){
            throw new Error("Invalid Email / Password")
        }

        return user
      },
    }),
  ],
  callbacks: {
    async jwt({ token, user, account, profile, isNewUser }: { token: any; user: any; account: any; profile?: any; isNewUser?: boolean }) {
      if (user) {
        token.id = user.id;
        token.name = user.name;
        token.email = user.email;
        token.role = user.role;

      }

      return token;
    },
    async session({
      session,
      token,
    }: {
      session: any;
      token: any;
    }) {
      if (token) {
        session.id = token.id;
        session.name = token.name;
        session.email = token.email;
        session.role = token.role;
      }

      return session;
    },
  },
};
