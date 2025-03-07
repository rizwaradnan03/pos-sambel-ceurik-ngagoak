"use client"

import CreateProduct from '@/components/dialog/product/create-product'
import DeleteProduct from '@/components/dialog/product/delete-product'
import ProductIngredient from '@/components/dialog/product/product-ingredient'
import UpdateProduct from '@/components/dialog/product/update-product'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { UseFetchFindManyProduct } from '@/hooks/api/product/findMany'
import { UseFetch } from '@/hooks/use-fetch'
import { ISProduct } from '@/interfaces/schema-interface'
import { formatPrice } from '@/lib/number'
import React, {useState } from 'react'

const page = () => {
    const [isDoneCreatingProduct, setIsDoneCreatingProduct] = useState<boolean>(false)
    const [isDoneUpdatingProduct, setIsDoneUpdatingProduct] = useState<boolean>(false)
    const [isDoneDeletingProduct, setIsDoneDeletingProduct] = useState<boolean>(false)

  const {data: dataProduct} = UseFetch<ISProduct[]>({key: 'inventoryProduct', dependencies: [], refetchDependencies: [{stateValue: isDoneCreatingProduct, stateSetter: setIsDoneCreatingProduct}, {stateValue: isDoneDeletingProduct,stateSetter: setIsDoneDeletingProduct}, {stateValue: isDoneUpdatingProduct, stateSetter: setIsDoneUpdatingProduct}], apiFunction: async() => {
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
                  <TableHead>Dosis</TableHead>
                  <TableHead>Aksi</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {dataProduct?.map((product, index) => (
                  <TableRow key={product.id}>
                    <TableCell>{index + 1}</TableCell>
                    <TableCell>{product.name}</TableCell>
                    <TableCell>Rp{formatPrice({value: product.price.toString()})}</TableCell>
                    <TableCell>
                      <ProductIngredient productId={product.id as string} />
                    </TableCell>
                    <TableCell><UpdateProduct productId={product.id as string} setIsDoneUpdatingProduct={setIsDoneUpdatingProduct} /> <DeleteProduct productId={product.id as string} setIsDoneDeletingProduct={setIsDoneDeletingProduct} /></TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        </div>
      );
}

export default page