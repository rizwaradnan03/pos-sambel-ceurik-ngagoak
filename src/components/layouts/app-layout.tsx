import { TReactNode } from '@/types/html-type'
import { RoleEnum } from '@prisma/client'
import SidebarLayout from "@/components/layouts/components/sidebar";
import React from 'react'

const AppLayout = ({ children, isUsingSidebar, role }: { children: TReactNode, isUsingSidebar: "true" | "false", role: RoleEnum }) => {
  return (
    <>
      {isUsingSidebar === "true" ? (
        <SidebarLayout role={role}>
          {children}
        </SidebarLayout>
      ) : (
        { children }
      )}
    </>
  )
}

export default AppLayout