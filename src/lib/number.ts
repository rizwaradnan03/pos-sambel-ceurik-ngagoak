export const formatPrice = ({ value }: { value: string }) => {
  const numericValue = value.replace(/\D/g, "");

  return new Intl.NumberFormat("id-ID").format(Number(numericValue));
};

export const pricedString = ({ value }: { value: string }) => {
  let formattedPrice = "";
  for (let i = 0; i < value.length; i++) {
    if (value[i] !== ".") {
      formattedPrice += value[i];
    }
  }

  return Number(formattedPrice)
};
