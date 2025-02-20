import { TReactNode } from '@/types/html-type'
import React from 'react'

const layout = ({children}: {children: TReactNode}) => {
  return (
    <>
        {children}
    </>
  )
}

export default layout