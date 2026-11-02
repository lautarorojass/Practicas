import {
  capitalize,
  capitalizeWords,
  truncate,
  isValidEmail,
  generateRandomId,
  formatCurrency,
} from "dev-utils-lauta-2026";

console.log("Prueba del paquete instalado desde NPM (version 1.0.1)");
console.log("capitalize:", capitalize("hola mundo"));
console.log("capitalizeWords:", capitalizeWords("hola mundo desde npm"));
console.log("truncate:", truncate("Paquete publicado en el registro de NPM", 20));
console.log("truncate con sufijo:", truncate("Paquete publicado en el registro de NPM", 20, "…"));
console.log("isValidEmail:", isValidEmail("usuario@email.com"));
console.log("generateRandomId:", generateRandomId(8));
console.log("formatCurrency:", formatCurrency(50000));
