import axios from "axios";

export const ApiManager = axios.create({
    baseURL: process.env.NEXT_PUBLIC_API_URL,
    responseType: 'json',
    headers: {
        'Content-Type': 'application/json'
    }
})