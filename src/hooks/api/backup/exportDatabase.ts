import { ApiManager } from "@/lib/api"

export const UseExportDatabase = async () => {
    try {
        const exportDatabase = await ApiManager(`/export-database`)
        
        return exportDatabase.data
    } catch (error) {
        throw error
    }
}