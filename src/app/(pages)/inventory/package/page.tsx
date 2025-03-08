"use client"

import CreatePackage from '@/components/dialog/package/create-package'
import SaveProductPackage from '@/components/dialog/package/save-product-package'
import UpdatePackage from '@/components/dialog/package/update-package'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { UseFetchFindManyPackage } from '@/hooks/api/package/findMany'
import { UseFetch } from '@/hooks/use-fetch'
import { ISPackage } from '@/interfaces/schema-interface'
import { formatPrice } from '@/lib/number'
import React, { useState } from 'react'

const page = () => {
    const [isDoneCreatingPackage, setIsDoneCreatingPackage] = useState<boolean>(false)
    const [isDoneUpdatingPackage, setIsDoneUpdatingPackage] = useState<boolean>(false)

      const {data: dataPackage} = UseFetch<ISPackage[]>({key: 'inventoryPackage', dependencies: [], refetchDependencies: [{stateValue: isDoneCreatingPackage, stateSetter: setIsDoneCreatingPackage}, {stateValue: isDoneUpdatingPackage, stateSetter: setIsDoneUpdatingPackage}], apiFunction: async() => {
          return await UseFetchFindManyPackage()
        }})

    return (
        <div className="w-full bg-white rounded-sm p-4 flex flex-col gap-4">
          {/* Header */}
          <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center">
            <h1 className="font-bold text-xl tracking-wide">Paket</h1>
            <div className="flex flex-wrap gap-3 mt-3 sm:mt-0">
              <CreatePackage setIsDoneCreatingPackage={setIsDoneCreatingPackage} />
            </div>
          </div>
    
          {/* Tabel Responsif */}
          <div className="overflow-x-auto">
            <Table className="min-w-[600px]">
              <TableHeader>
                <TableRow>
                  <TableHead>No</TableHead>
                  <TableHead>Nama</TableHead>
                  <TableHead>Harga</TableHead>
                  <TableHead>List</TableHead>
                  <TableHead>Aksi</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {dataPackage?.map((pkg, index) => (
                  <TableRow key={pkg.id}>
                    <TableCell>{index + 1}</TableCell>
                    <TableCell>{pkg.name}</TableCell>
                    <TableCell>Rp{formatPrice({value: pkg.price.toString()})}</TableCell>
                    <TableCell>
                      <SaveProductPackage packageId={pkg.id!} />
                    </TableCell>
                    <TableCell>
                      <UpdatePackage packageId={pkg.id as string} setIsDoneUpdatingPackage={setIsDoneUpdatingPackage} />
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        </div>
      );
}

export default page