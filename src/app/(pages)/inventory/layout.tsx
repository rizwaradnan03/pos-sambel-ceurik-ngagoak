"use client"

import AppLayout from '@/components/layouts/app-layout'
import { TReactNode } from '@/types/html-type'
import { useSession } from 'next-auth/react'
import { useRouter } from 'next/navigation'
import React from 'react'
import toast from 'react-hot-toast'

const layout = ({children}: {children: TReactNode}) => {
  const {data}: {data: any} = useSession()

  const router = useRouter()

  // if(data?.role != "INVENTORY"){
  //   toast.error("Anda tidak memiliki akses!")
    
  //   router.push("/auth/login")
  // }

  return (
    <>
        <AppLayout role='INVENTORY' isUsingSidebar='true'>
            {children}
        </AppLayout>
    </>
  )
}

export default layout