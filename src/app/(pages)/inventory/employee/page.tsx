"use client"

import CreateEmployee from '@/components/dialog/employee/create-employee'
import CreateExpense from '@/components/dialog/expense/create-expense'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { UseFetchFindManyEmployee } from '@/hooks/api/employee/findMany'
import { UseFetchFindManyExpenses } from '@/hooks/api/expense/findMany'
import { UseFetch } from '@/hooks/use-fetch'
import { ISEmployee, ISExpense } from '@/interfaces/schema-interface'
import { UseFormattedDate } from '@/lib/date'
import { formatPrice } from '@/lib/number'
import React, { useState } from 'react'

const page = () => {
    // const [expenses, setExpenses] = useState<ISExpense | undefined>()

    const [isDoneCreatingEmployee, setIsDoneCreatingEmployee] = useState<boolean>(false)

    const { data: dataEmployee } = UseFetch<ISEmployee[]>({ key: "inventoryExpense", dependencies: [], refetchDependencies: [{stateValue: isDoneCreatingEmployee, stateSetter: setIsDoneCreatingEmployee}],apiFunction: async () => {
        return await UseFetchFindManyEmployee()
    }})
    
    return (
        <div className="w-full bg-white rounded-sm p-4 flex flex-col gap-4">
            {/* Header */}
            <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center">
                <h1 className="font-bold text-xl tracking-wide">Karyawan</h1>
                <div className="flex flex-wrap gap-3 mt-3 sm:mt-0">
                    <CreateEmployee setIsDoneCreatingEmployee={setIsDoneCreatingEmployee} />
                </div>
            </div>

            <div className="overflow-x-auto">
            <Table className="min-w-[600px]">
              <TableHeader>
                <TableRow>
                  <TableHead>No</TableHead>
                  <TableHead>Nama</TableHead>
                  <TableHead>Jabatan</TableHead>
                  <TableHead>Nomor Telefon</TableHead>
                  <TableHead>Gaji</TableHead>
                  {/* <TableHead>Status Aktif</TableHead> */}
                  {/* <TableHead>Aksi</TableHead> */}
                </TableRow>
              </TableHeader>
              <TableBody>
                {dataEmployee?.map((employee, index) => (
                  <TableRow key={employee.id}>
                    <TableCell>{index + 1}</TableCell>
                    <TableCell>{employee.name}</TableCell>
                    <TableCell>{employee.role}</TableCell>
                    <TableCell>{employee.phoneNumber}</TableCell>
                    <TableCell>{formatPrice({value: employee.salary.toString()})}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        </div>
    )
}

export default page