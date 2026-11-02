export function formatDate(date, format = "DD/MM/YYYY") {
  const value = date instanceof Date ? date : new Date(date);

  if (Number.isNaN(value.getTime())) {
    return "";
  }

  const parts = {
    YYYY: String(value.getFullYear()),
    MM: String(value.getMonth() + 1).padStart(2, "0"),
    DD: String(value.getDate()).padStart(2, "0"),
  };

  return format.replace(/YYYY|MM|DD/g, (token) => parts[token]);
}
