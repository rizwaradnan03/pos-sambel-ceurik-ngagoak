export const UseFileExtension = ({stringFile}: {stringFile: string}) => {
    let str = ""

    for(let i = stringFile.length -1;i >= 0; i--){
        if(stringFile[i] == "."){
            break
        }
        str += stringFile[i]
    }

    let reversedStr = ""

    for(let i = str.length - 1;i >= 0;i--){
        reversedStr += str[i]
    }

    return reversedStr
}