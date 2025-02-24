"use client"

import { Button } from '@/components/ui/button'
import { Card, CardContent, CardFooter, CardHeader } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import React, { useEffect, useState } from 'react'
import toast from 'react-hot-toast'
import { signIn } from "next-auth/react";
import { useRouter, useSearchParams } from 'next/navigation'

const Page = () => {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [callbackUrl, setCallbackUrl] = useState("/cashier");
    
    const searchParams = useSearchParams();
    const router = useRouter();

    useEffect(() => {
        const urlCallback = searchParams.get("callbackUrl");
        if (urlCallback) {
            setCallbackUrl(urlCallback);
        }
    }, [searchParams]);

    const handleLogin = async () => {
        if (!email || !password) {
            toast.error("Email / Password Dibutuhkan!");
            return;
        }

        try {
            const login = await signIn("credentials", {
                redirect: false,
                email,
                password,
                callbackUrl,
            });

            if (login?.error) {
                toast.error("Gagal Login! Periksa email dan password.");
                return;
            }
            toast.success("Berhasil Login!");

            router.push(callbackUrl);
        } catch (error) {
            toast.error("Terjadi kesalahan saat login!");
        }
    };

    return (
        <div className='flex justify-center items-center min-h-screen'>
            <Card className='w-[350px]'>
                <CardHeader className='text-xl text-center'>Halaman Login</CardHeader>
                <CardContent>
                    <div className="grid w-full items-center gap-4">
                        <div className="flex flex-col space-y-1.5">
                            <Label htmlFor="email">Email</Label>
                            <Input type='email' id="email" placeholder="john@gmail.com" value={email} onChange={(e) => setEmail(e.target.value)} />
                        </div>
                        <div className="flex flex-col space-y-1.5">
                            <Label htmlFor="password">Password</Label>
                            <Input type='password' id="password" placeholder="password" value={password} onChange={(e) => setPassword(e.target.value)} />
                        </div>
                    </div>
                </CardContent>
                <CardFooter>
                    <Button className='w-full' onClick={handleLogin}>Submit</Button>
                </CardFooter>
            </Card>
        </div>
    );
};

export default Page;
