/* eslint-disable react-hooks/exhaustive-deps */
import {
  IHUseFetchInterface,
  UseFetchResponse,
} from "@/interfaces/api-interface"
import { useEffect, useState } from "react"

export const UseFetch = <T>({
  key,
  dependencies,
  refetchDependencies,
  apiFunction,
}: IHUseFetchInterface): UseFetchResponse<T> => {
  const [data, setData] = useState<T | undefined>(undefined)
  const [error, setError] = useState<any | undefined>(undefined)
  const [isLoading, setIsLoading] = useState<boolean>(false)

  const fetchData = async () => {
    setIsLoading(true)
    try {
      const fetch = await apiFunction()
      setData(fetch.data)

    } catch (error: any) {
      setError(error.message)
    } finally {
      setIsLoading(false)
    }
  }


  useEffect(() => {
    fetchData()
  }, [...(dependencies || [])])


  useEffect(() => {
    if (refetchDependencies && refetchDependencies.length > 0) {
      let isFoundTrue = false

      for (let i = 0; i < refetchDependencies.length; i++) {
        if (refetchDependencies[i].stateValue == true) {
          isFoundTrue = true
          refetchDependencies[i].stateSetter(false)
        }
      }

      if(isFoundTrue){
        console.log("Iyaapp ada")
        window.location.reload();
      }
    }
  }, [...(refetchDependencies || [])])

  return { data, isLoading, error }
}
