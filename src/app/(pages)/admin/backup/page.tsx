"use client"

import { Button } from '@/components/ui/button'
import { UseExportDatabase } from '@/hooks/api/backup/exportDatabase'
import React from 'react'
import toast from 'react-hot-toast'

const page = () => {

    const handleBackupDatabase = async () => {
        try {
            const backup = await UseExportDatabase()

            toast.success("Berhasil melakukan export database!")
        } catch (error: any) {
            toast.error(error.message)
        }
    }

  return (
    <div>
        <Button onClick={() => handleBackupDatabase()}>Backup Database</Button>
    </div>
  )
}

export default page