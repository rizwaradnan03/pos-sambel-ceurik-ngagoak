"use client";

import {
  IHUseFetchInterface,
  UseFetchResponse,
} from "@/interfaces/api-interface";
import { UseEpochFutureTime } from "@/lib/date";
import { UseJsonStringify } from "@/lib/json";
import { useEffect, useState } from "react";

const cache = new Map<string, any>();

export const UseFetch = <T>({
  key,
  dependencies,
  refetchDependencies,
  apiFunction,
}: IHUseFetchInterface): UseFetchResponse<T> => {
  const [data, setData] = useState<T | undefined>(undefined);
  const [error, setError] = useState<any | undefined>(undefined);
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [stringifiedKey, setStringifiedKey] = useState<string>("");

  const fetchData = async () => {
    setIsLoading(true);
    try {
      const fetch = await apiFunction();
      setData(fetch.data);

      cache.set(stringifiedKey, fetch.data);
      cache.set(
        stringifiedKey + "_time",
        UseEpochFutureTime({ futureInMinute: 1 })
      );
    } catch (error: any) {
      setError(error.message);
    } finally {
      setIsLoading(false);
    }
  };

  const createStringifiedKey = () => {
    const stringifiedDependencies = UseJsonStringify({ data: dependencies });
    setStringifiedKey(key + stringifiedDependencies);
  };

  useEffect(() => {
    createStringifiedKey();
  }, [key, ...(dependencies || [])]);

  useEffect(() => {
    if (stringifiedKey) {
      let isHasKey = false;
      const currentTime = Date.now();
      if (cache.has(stringifiedKey + "_time")) {
        if (currentTime > cache.get(stringifiedKey + "_time")) {
          cache.delete(stringifiedKey);
          cache.delete(stringifiedKey + "_time");
        }
      }

      if (cache.has(stringifiedKey)) {
        isHasKey = true;
      }

      if (isHasKey) {
        setData(cache.get(stringifiedKey));
        setIsLoading(false);
      } else {
        if (dependencies && dependencies?.length > 0) {
          let isAbleToFetch = false;

          for (let i = 0; i < dependencies?.length; i++) {
            if (dependencies[i] || dependencies[i] == true) {
              isAbleToFetch = true;
            }
          }

          if (isAbleToFetch) {
            fetchData();
          }
        } else {
          fetchData();
        }
      }
    }
  }, [key, stringifiedKey, ...(dependencies || [])]);

  const refetch = () => {
    if (refetchDependencies) {
      let isAbleToRefetch = false;

      for (let i = 0; i < refetchDependencies?.length; i++) {
        if (refetchDependencies[i].stateValue == true) {
          isAbleToRefetch = true;
        }
        refetchDependencies[i].stateSetter(false);
      }

      if (isAbleToRefetch) {
        cache.delete(stringifiedKey);
        cache.delete(stringifiedKey + "_time");

        fetchData();
      }
    }
  };

  useEffect(() => {
    refetch();
  }, [...(refetchDependencies || [])]);

  return { data, isLoading, error };
};
