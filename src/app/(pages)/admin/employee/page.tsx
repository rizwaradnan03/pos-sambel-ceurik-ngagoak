"use client"

import AttendanceEmployee from '@/components/dialog/employee/attendance-employee'
import CreateEmployee from '@/components/dialog/employee/create-employee'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { UseFetchFindManyEmployee } from '@/hooks/api/employee/findMany'
import { UseFetch } from '@/hooks/use-fetch'
import { ISEmployee, } from '@/interfaces/schema-interface'
import { formatPrice } from '@/lib/number'
import React, { useState } from 'react'

const page = () => {
    const [isDoneCreatingEmployee, setIsDoneCreatingEmployee] = useState<boolean>(false)

    const { data: dataEmployee } = UseFetch<ISEmployee[]>({ key: "adminEmployee", dependencies: [], refetchDependencies: [{stateValue: isDoneCreatingEmployee, stateSetter: setIsDoneCreatingEmployee}],apiFunction: async () => {
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
                  <TableHead>Gaji (Per Hari)</TableHead>
                  <TableHead>Transportasi (Per Hari)</TableHead>
                  <TableHead>Aksi</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {dataEmployee?.map((employee, index) => (
                  <TableRow key={employee.id}>
                    <TableCell>{index + 1}</TableCell>
                    <TableCell>{employee.name}</TableCell>
                    <TableCell>{employee.role}</TableCell>
                    <TableCell>{employee.phoneNumber}</TableCell>
                    <TableCell>Rp{formatPrice({value: employee.salaryPerDay ? employee?.salaryPerDay.toString() : "0"})}</TableCell>
                    <TableCell>Rp{formatPrice({value: employee.transportPerDay ? employee?.transportPerDay.toString() : "0"})}</TableCell>
                    <TableCell><AttendanceEmployee employeeId={employee.id!} /></TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        </div>
    )
}

export default page