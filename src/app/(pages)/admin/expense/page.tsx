"use client"

import CreateExpense from '@/components/dialog/expense/create-expense'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { UseFetchFindManyExpenses } from '@/hooks/api/expense/findMany'
import { UseFetch } from '@/hooks/use-fetch'
import { ISExpense } from '@/interfaces/schema-interface'
import { UseFormattedDate } from '@/lib/date'
import { formatPrice } from '@/lib/number'
import React, { useState } from 'react'

const page = () => {
    // const [expenses, setExpenses] = useState<ISExpense | undefined>()

    const [isDoneCreatingExpense, setIsDoneCreatingExpense] = useState<boolean>(false)

    const { data: dataExpense } = UseFetch<ISExpense[]>({ key: "inventoryExpense", dependencies: [], refetchDependencies: [{stateValue: isDoneCreatingExpense, stateSetter: setIsDoneCreatingExpense}],apiFunction: async () => {
        return await UseFetchFindManyExpenses()
    }})
    
    return (
        <div className="w-full bg-white rounded-sm p-4 flex flex-col gap-4">
            {/* Header */}
            <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center">
                <h1 className="font-bold text-xl tracking-wide">Biaya Operasional (Bulan Ini)</h1>
                <div className="flex flex-wrap gap-3 mt-3 sm:mt-0">
                    <CreateExpense setIsDoneCreatingExpense={setIsDoneCreatingExpense} />
                </div>
            </div>

            <div className="overflow-x-auto">
            <Table className="min-w-[600px]">
              <TableHeader>
                <TableRow>
                  <TableHead>No</TableHead>
                  <TableHead>Nama</TableHead>
                  <TableHead>Harga</TableHead>
                  <TableHead>Waktu</TableHead>
                  {/* <TableHead>Aksi</TableHead> */}
                </TableRow>
              </TableHeader>
              <TableBody>
                {dataExpense?.map((expense, index) => (
                  <TableRow key={expense.id}>
                    <TableCell>{index + 1}</TableCell>
                    <TableCell>{expense.name}</TableCell>
                    <TableCell>Rp{formatPrice({value: expense.amount?.toString() ?? '0'})}</TableCell>
                    <TableCell>{expense.createdAt ? UseFormattedDate({dateValue: expense.createdAt.toString() }) : 'N/A'}</TableCell>
                    {/* <TableCell>
                      <SaveProductPackage packageId={pkg.id!} />
                    </TableCell> */}
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        </div>
    )
}

export default page