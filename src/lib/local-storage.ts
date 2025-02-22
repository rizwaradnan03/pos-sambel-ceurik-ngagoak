export const UseLocalStorageSetItem = ({key, value}: {key: string, value: any}) => {
    localStorage.setItem(key, value)
}

export const UseLocalStorageGetItem = ({key}: {key: string}) => {
    return localStorage.getItem(key)
}

export const UseLocalStorageClearItem = () => {
    localStorage.clear()
}

export const UseLocalStorageRemoveItem = ({ key }: {key: string}) => {
    return localStorage.removeItem(key)
}