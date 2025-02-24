export interface UseFetchResponse<T> {
    data: T | undefined;
    error: string | undefined;
    isLoading: boolean;
  }
  
  export interface IHRefetchDependencies {
    stateValue: any;
    stateSetter: (stateValue: any) => void;
  }
  
  export interface IHUseFetchInterface {
    key: string;
    dependencies?: any[];
    refetchDependencies?: IHRefetchDependencies[];
    apiFunction: () => Promise<any>;
  }