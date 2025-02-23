export const formatPrice = ({value}: {value: string}) => {
    const numericValue = value.replace(/\D/g, "");

    return new Intl.NumberFormat('id-ID').format(Number(numericValue))
}