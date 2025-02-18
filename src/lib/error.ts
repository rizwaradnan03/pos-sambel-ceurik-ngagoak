import { IErrorApiFunction } from "@/interfaces/error-interface";

export const UseErrorApiFunction = ({error}: IErrorApiFunction) => {
    throw new Error(error.response.data.message)
}