import AppLayout from '@/components/layouts/app-layout'
import { TReactNode } from '@/types/html-type'
import React from 'react'

const layout = ({children}: {children: TReactNode}) => {
  return (
    <>
        <AppLayout role='ANALYTICS' isUsingSidebar='true'>
            {children}
        </AppLayout>
    </>
  )
}

export default layout