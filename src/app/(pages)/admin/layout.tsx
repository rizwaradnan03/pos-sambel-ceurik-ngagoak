import AppLayout from '@/components/layouts/app-layout'
import { TReactNode } from '@/types/html-type'
import React from 'react'

const layout = ({children}: {children: TReactNode}) => {
  return (
    <>
    <AppLayout role='ADMIN' isUsingSidebar='true'>
            {children}
        </AppLayout>
        {/* {children} */}
    </>
  )
}

export default layout