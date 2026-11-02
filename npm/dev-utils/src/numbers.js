export function formatCurrency(amount, currency = "ARS", locale = "es-AR") {
  const number = Number(amount);

  if (!Number.isFinite(number)) {
    return "";
  }

  return new Intl.NumberFormat(locale, {
    style: "currency",
    currency,
  }).format(number);
}

export function randomNumber(min, max) {
  const minValue = Math.ceil(Number(min));
  const maxValue = Math.floor(Number(max));

  if (!Number.isFinite(minValue) || !Number.isFinite(maxValue) || minValue > maxValue) {
    throw new RangeError("El rango no es valido: min debe ser menor o igual que max");
  }

  return Math.floor(Math.random() * (maxValue - minValue + 1)) + minValue;
}

export function generateRandomId(length = 10) {
  const size = Number(length);

  if (!Number.isInteger(size) || size <= 0) {
    throw new RangeError("La longitud debe ser un entero mayor que cero");
  }

  const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  let id = "";

  for (let i = 0; i < size; i += 1) {
    id += alphabet.charAt(Math.floor(Math.random() * alphabet.length));
  }

  return id;
}
