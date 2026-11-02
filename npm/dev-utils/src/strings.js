export function capitalize(text) {
  if (typeof text !== "string" || text.length === 0) {
    return "";
  }

  return text.charAt(0).toUpperCase() + text.slice(1);
}

export function truncate(text, length, suffix = "...") {
  if (typeof text !== "string") {
    return "";
  }

  const maxLength = Number(length);

  if (!Number.isFinite(maxLength) || maxLength < 0) {
    return "";
  }

  if (text.length <= maxLength) {
    return text;
  }

  return text.slice(0, maxLength) + suffix;
}

export function capitalizeWords(text) {
  if (typeof text !== "string" || text.length === 0) {
    return "";
  }

  return text
    .split(" ")
    .map((word) => capitalize(word))
    .join(" ");
}

export function slugify(text) {
  if (typeof text !== "string") {
    return "";
  }

  return text
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}
