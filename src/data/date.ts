export const dateNow = new Date();
export const dateCurrentMonth = dateNow.getMonth() + 1;
export const dateCurrentYear = dateNow.getFullYear();

export const dateStartOfMonth = new Date(dateNow.getFullYear(), dateNow.getMonth(), 1);
export const dateEndOfMonth = new Date(dateNow.getFullYear(), dateNow.getMonth() + 1, 0, 23, 59, 59);