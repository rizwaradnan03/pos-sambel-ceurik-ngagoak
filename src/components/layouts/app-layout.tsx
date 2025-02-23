import { TReactNode } from '@/types/html-type'
import { RoleEnum } from '@prisma/client'
import SidebarLayout from "@/components/layouts/components/sidebar";
import React from 'react'

const AppLayout = ({ children, isUsingSidebar, role }: { children: TReactNode, isUsingSidebar: "true" | "false", role: RoleEnum }) => {
  return (
    <>
      {isUsingSidebar === "true" ? (
        <SidebarLayout role={role}>
          <main className='flex p-4 min-h-screen bg-gray-100'>

            {children}
          </main>
        </SidebarLayout>
      ) : (
        <main className='flex p-4 min-h-screen bg-gray-100'>

          {children}
        </main>
      )}
    </>
  )
}

export default AppLayout