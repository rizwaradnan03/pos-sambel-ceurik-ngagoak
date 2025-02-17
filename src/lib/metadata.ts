export const UseMetaData = ({title, description}: {title: string, description: string}) => {
    const newTitle = title + process.env.NEXT_PUBLIC_APP_NAME
    
    return {title: newTitle, description}
}