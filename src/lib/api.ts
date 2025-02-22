import axios from "axios";

export const ApiManager = axios.create({
    baseURL: process.env.NEXT_PUBLIC_APP_URL,
    responseType: 'json',
    headers: {
        'Content-Type': 'application/json'
    }
})