export const UseFormattedDate = ({dateValue}: {dateValue: string}) => {
    const date = new Date(dateValue)

    return date.toLocaleDateString('id-ID', {
        day: 'numeric',
        month: 'long',
        year: 'numeric'
    })
}

export const UseEpochFutureTime = ({futureInMinute}: {futureInMinute: number}) => {
    const date = Date.now()

    return date + (futureInMinute * 60 * 1000)
}