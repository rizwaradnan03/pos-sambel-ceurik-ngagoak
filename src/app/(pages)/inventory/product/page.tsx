"use client"

import CreateProduct from '@/components/dialog/product/create-product'
import ProductIngredient from '@/components/dialog/product/product-ingredient'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { UseFetchFindManyProduct } from '@/hooks/api/product/findMany'
import { UseFetch } from '@/hooks/use-fetch'
import { ISProduct } from '@/interfaces/schema-interface'
import React, { useEffect, useState } from 'react'
import toast from 'react-hot-toast'

const page = () => {
    const [products, setProducts] = useState<ISProduct[] | undefined>(undefined)

    const [isDoneCreatingProduct, setIsDoneCreatingProduct] = useState<boolean>(false)

  const {data: dataProduct} = UseFetch<ISProduct[]>({key: 'inventoryProduct', dependencies: [], refetchDependencies: [{stateValue: isDoneCreatingProduct, stateSetter: setIsDoneCreatingProduct}], apiFunction: async() => {
    return await UseFetchFindManyProduct()
  }})

    return (
        <div className="w-full bg-white rounded-sm p-4 flex flex-col gap-4">
          {/* Header */}
          <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center">
            <h1 className="font-bold text-xl tracking-wide">Produk</h1>
            <div className="flex flex-wrap gap-3 mt-3 sm:mt-0">
              <CreateProduct setIsDoneCreatingProduct={setIsDoneCreatingProduct} />
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
                  <TableHead>Aksi</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {dataProduct?.map((product, index) => (
                  <TableRow key={product.id}>
                    <TableCell>{index + 1}</TableCell>
                    <TableCell>{product.name}</TableCell>
                    <TableCell>{product.price}</TableCell>
                    <TableCell>
                      <ProductIngredient productId={product.id as string} />
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