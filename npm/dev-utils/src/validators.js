export function isValidEmail(email) {
  if (typeof email !== "string") {
    return false;
  }

  const value = email.trim();

  if (value.length === 0 || value.length > 254) {
    return false;
  }

  if (value.includes("..")) {
    return false;
  }

  return /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(value);
}

export function isEmpty(value) {
  if (value === null || value === undefined) {
    return true;
  }

  if (typeof value === "string") {
    return value.trim().length === 0;
  }

  if (Array.isArray(value)) {
    return value.length === 0;
  }

  if (value instanceof Map || value instanceof Set) {
    return value.size === 0;
  }

  if (typeof value === "object") {
    return Object.keys(value).length === 0;
  }

  return false;
}
