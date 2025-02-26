"use client"

import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { UseFetchFindOnePackageItemById } from '@/hooks/api/package-item/findOneById'
import { UseUpdatePackageItemQuantity } from '@/hooks/api/package-item/updateQuantity'
import { UseFetch } from '@/hooks/use-fetch'
import { ISPackageItem } from '@/interfaces/schema-interface'
import React, { useState } from 'react'
import toast from 'react-hot-toast'

const ChangePackageQuantity = ({packageItemId}: {packageItemId: string}) => {
    const [quantity, setQuantity] = useState<string>("1")

    const [isDoneUpdatingPackageItemQuantity, setIsDoneUpdatingPackageItemQuantity] = useState<boolean>(false)

    const {} = UseFetch<ISPackageItem>({key: "inventoryPackageItem", dependencies: [packageItemId], refetchDependencies: [{stateValue: isDoneUpdatingPackageItemQuantity, stateSetter: setIsDoneUpdatingPackageItemQuantity}], apiFunction: async () => {
        const fetch = await UseFetchFindOnePackageItemById({id: packageItemId})

        setQuantity(fetch.data.quantity)
    }})

    const handleChangeQuantity = async () => {
        try {
            const update = await UseUpdatePackageItemQuantity({id: packageItemId, quantity: Number(quantity)})
            setIsDoneUpdatingPackageItemQuantity(true)
            toast.success("Berhasil mengubah kuantity!")
        } catch (error: any) {
            toast.error(error.message)
        }
    }

  return (
    <div className='flex flex-row gap-2'>
        <Input type='number' value={quantity} onChange={(e) => setQuantity(e.target.value)} />
        <Button onClick={() => handleChangeQuantity()}>Ubah</Button>
    </div>
  )
}

export default ChangePackageQuantity