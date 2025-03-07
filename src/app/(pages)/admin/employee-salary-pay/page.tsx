"use client"

import UpdateEmployeeSalaryPayIsPayed from '@/components/dialog/employee-salary-pay/update-employee-salary-pay-is-payed'
import CreateEmployee from '@/components/dialog/employee/create-employee'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { UseFetchFindManyEmployeeSalarySummary } from '@/hooks/api/employee-salary-summary/findMany'
import { UseFetch } from '@/hooks/use-fetch'
import { ISEmployeeSalarySummary, } from '@/interfaces/schema-interface'
import { formatPrice } from '@/lib/number'
import React, { useState } from 'react'

const page = () => {
  const [isDoneUpdatingEmployeeSalaryPay, setIsDoneUpdatingEmployeeSalaryPay] = useState<boolean>(false)

  const { data: dataEmployeeSalaryPay } = UseFetch<ISEmployeeSalarySummary[]>({
    key: "adminEmployeeSalaryPay", dependencies: [], refetchDependencies: [{ stateValue: isDoneUpdatingEmployeeSalaryPay, stateSetter: setIsDoneUpdatingEmployeeSalaryPay }], apiFunction: async () => {
      return await UseFetchFindManyEmployeeSalarySummary()
    }
  })

  return (
    <div className="w-full bg-white rounded-sm p-4 flex flex-col gap-4">
      {/* Header */}
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center">
        <h1 className="font-bold text-xl tracking-wide">Gaji Karyawan Yang Belum Dibayar</h1>
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
              <TableHead>Aksi</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {dataEmployeeSalaryPay?.map((employeeSalaryPay, index) => (
              <TableRow key={employeeSalaryPay.id}>
                <TableCell>{index + 1}</TableCell>
                <TableCell>{employeeSalaryPay.Employee?.name}</TableCell>
                <TableCell>{employeeSalaryPay.Employee?.role}</TableCell>
                <TableCell>{employeeSalaryPay.Employee?.phoneNumber}</TableCell>
                <TableCell>
                  Rp
                  {employeeSalaryPay.totalSalary && employeeSalaryPay.totalTransport && employeeSalaryPay.totalCut
                    ? formatPrice({
                      value: ((Number(employeeSalaryPay.totalSalary) + Number(employeeSalaryPay.totalTransport)) - Number(employeeSalaryPay.totalCut)).toString()
                    })
                    : "0"}
                </TableCell>
                <TableCell><UpdateEmployeeSalaryPayIsPayed employeeSalaryPayId={employeeSalaryPay.id as string} setIsDoneUpdatingEmployeeSalaryPay={setIsDoneUpdatingEmployeeSalaryPay} /></TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>
    </div>
  )
}

export default page