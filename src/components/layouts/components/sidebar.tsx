import { Sidebar as SidebarComponent, SidebarContent, SidebarGroup, SidebarGroupContent, SidebarHeader, SidebarInset, SidebarMenu, SidebarMenuButton, SidebarProvider, SidebarTrigger } from '@/components/ui/sidebar'
import React, { useEffect, useState } from 'react'
import { Separator } from '@/components/ui/separator'
import { Breadcrumb, BreadcrumbItem, BreadcrumbLink, BreadcrumbList, BreadcrumbPage, BreadcrumbSeparator } from '@/components/ui/breadcrumb'
import toast from 'react-hot-toast'
import { TReactNode } from '@/types/html-type'
import { RoleEnum } from '@prisma/client'
import { ISidebarItems } from '@/interfaces/sidebar-interface'
import { inventoryUrlItems } from '@/data/sidebar/inventory'
import { analyticsUrlItems } from '@/data/sidebar/analytics'
import Link from 'next/link'

const Sidebar = ({ children, role }: { children: TReactNode, role: RoleEnum }) => {
    const [renderSidebar, setRenderSidebar] = useState<ISidebarItems[] | undefined>(undefined)


    const handleLogout = () => {

        // toast.success("Anda Berhasil Logout!")

        // if (role === "teacher") {
        //     navigate("/auth/sign-in/teacher")
        // } else if (role === "student") {
        //     navigate("/auth/sign-in/student")
        // }
    }

    useEffect(() => {
        if (role === "INVENTORY") {
            setRenderSidebar(inventoryUrlItems)
        } else if (role === "ANALYTICS") {
            setRenderSidebar(analyticsUrlItems)
        }
    }, [role])

    return (
        <SidebarProvider>
            <SidebarComponent>
                {/* <SidebarHeader>
                    <React.Fragment>
                        <CourseSwitcher />
                    </React.Fragment>
                </SidebarHeader> */}
                <SidebarContent className='gap-0'>
                    <SidebarGroup>
                        <SidebarGroupContent>
                            <SidebarMenu>
                                {renderSidebar ? (
                                    <React.Fragment>
                                        {renderSidebar.map((item, index) => (
                                            <SidebarMenuButton key={index} asChild>
                                                {item.type === "logout" ? (
                                                    <button onClick={handleLogout} className='bg-red-600 text-white text-center p-1'>Logout</button>
                                                ) : (
                                                    <Link href={item?.url ? item.url : "#"}>
                                                        {item.icon && (
                                                            <item.icon />
                                                        )}
                                                        <span>{item.title}</span>
                                                    </Link>
                                                )}
                                            </SidebarMenuButton>
                                        ))}
                                    </React.Fragment>
                                ) : null}
                            </SidebarMenu>
                        </SidebarGroupContent>
                    </SidebarGroup>
                </SidebarContent>
            </SidebarComponent>
            <SidebarInset>
                <header className="flex h-16 shrink-0 items-center gap-2 border-b px-4">
                    <SidebarTrigger className="-ml-1" />
                    <Separator orientation="vertical" className="mr-2 h-4" />
                    <Breadcrumb>
                        <BreadcrumbList>
                            <BreadcrumbItem className="hidden md:block">
                                <BreadcrumbLink href="#">
                                    Building Your Application
                                </BreadcrumbLink>
                            </BreadcrumbItem>
                            <BreadcrumbSeparator className="hidden md:block" />
                            <BreadcrumbItem>
                                <BreadcrumbPage>Fetching</BreadcrumbPage>
                            </BreadcrumbItem>
                        </BreadcrumbList>
                    </Breadcrumb>
                </header>
                {children}
            </SidebarInset>
        </SidebarProvider>
    )
}

export default Sidebar