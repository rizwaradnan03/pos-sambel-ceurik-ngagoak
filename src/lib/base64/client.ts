export const UseEncodeFileToBase64 = async ({file}: {file: File}) => {
    return new Promise<string>((resolve, reject) => {
        const reader = new FileReader()

        reader.onload = () => {
            resolve(reader.result as string)
        }

        reader.onerror = reject
        reader.readAsDataURL(file)
    })
}