import {
  capitalize,
  truncate,
  slugify,
  isValidEmail,
  isEmpty,
  formatCurrency,
  formatDate,
} from "dev-utils-lauta-2026";

console.log("Prueba de la libreria instalada desde la ruta local");
console.log("capitalize:", capitalize("federico"));
console.log("truncate:", truncate("JavaScript es genial", 10));
console.log("slugify:", slugify("Libreria local de utilidades"));
console.log("isValidEmail:", isValidEmail("usuario@email.com"));
console.log("isEmpty:", isEmpty("   "));
console.log("formatCurrency:", formatCurrency(1234.5));
console.log("formatDate:", formatDate(new Date(2024, 4, 20)));
