import test from "node:test";
import assert from "node:assert/strict";

import {
  capitalize,
  capitalizeWords,
  truncate,
  slugify,
  isValidEmail,
  isEmpty,
  formatCurrency,
  randomNumber,
  generateRandomId,
  formatDate,
} from "../src/index.js";

test("capitalize pone en mayuscula la primera letra", () => {
  assert.equal(capitalize("federico"), "Federico");
  assert.equal(capitalize("hola mundo"), "Hola mundo");
  assert.equal(capitalize(""), "");
  assert.equal(capitalize(null), "");
  assert.equal(capitalize(42), "");
});

test("capitalizeWords pone en mayuscula la primera letra de cada palabra", () => {
  assert.equal(capitalizeWords("hola mundo"), "Hola Mundo");
  assert.equal(capitalizeWords("bienvenido a la libreria"), "Bienvenido A La Libreria");
  assert.equal(capitalizeWords(""), "");
  assert.equal(capitalizeWords(null), "");
});

test("truncate limita el texto a la cantidad indicada", () => {
  assert.equal(truncate("JavaScript es genial", 10), "JavaScript...");
  assert.equal(truncate("corto", 10), "corto");
  assert.equal(truncate("corto", 5), "corto");
  assert.equal(truncate("JavaScript es genial", 10, "…"), "JavaScript…");
  assert.equal(truncate(null, 5), "");
  assert.equal(truncate("texto", -1), "");
});

test("slugify genera un texto apto para URLs", () => {
  assert.equal(slugify("Hola Mundo"), "hola-mundo");
  assert.equal(slugify("Noticias de programacion Ñ"), "noticias-de-programacion-n");
  assert.equal(slugify("  espacios   de mas  "), "espacios-de-mas");
  assert.equal(slugify(""), "");
  assert.equal(slugify(undefined), "");
});

test("isValidEmail valida el formato de un email", () => {
  assert.equal(isValidEmail("usuario@email.com"), true);
  assert.equal(isValidEmail("nombre.apellido@empresa.com.ar"), true);
  assert.equal(isValidEmail("  usuario@email.com  "), true);
  assert.equal(isValidEmail("usuario@email"), false);
  assert.equal(isValidEmail("usuario.com"), false);
  assert.equal(isValidEmail("usuario @email.com"), false);
  assert.equal(isValidEmail("usuario..nombre@email.com"), false);
  assert.equal(isValidEmail("usuario@email.c"), false);
  assert.equal(isValidEmail(""), false);
  assert.equal(isValidEmail(null), false);
});

test("isEmpty verifica si un valor esta vacio", () => {
  assert.equal(isEmpty(""), true);
  assert.equal(isEmpty("   "), true);
  assert.equal(isEmpty("hola"), false);
  assert.equal(isEmpty([]), true);
  assert.equal(isEmpty([1]), false);
  assert.equal(isEmpty({}), true);
  assert.equal(isEmpty({ a: 1 }), false);
  assert.equal(isEmpty(new Map()), true);
  assert.equal(isEmpty(new Set(["a"])), false);
  assert.equal(isEmpty(null), true);
  assert.equal(isEmpty(undefined), true);
  assert.equal(isEmpty(0), false);
  assert.equal(isEmpty(false), false);
});

test("formatCurrency convierte un numero a formato moneda", () => {
  assert.match(formatCurrency(1234.5, "ARS", "es-AR"), /1\.234,50/);
  assert.match(formatCurrency(1000, "USD", "en-US"), /\$1,000\.00/);
  assert.equal(formatCurrency("no es un numero"), "");
  assert.equal(formatCurrency(NaN), "");
});

test("randomNumber genera un numero dentro del rango", () => {
  for (let i = 0; i < 200; i += 1) {
    const value = randomNumber(1, 10);
    assert.equal(Number.isInteger(value), true);
    assert.ok(value >= 1 && value <= 10);
  }

  assert.equal(randomNumber(7, 7), 7);
  assert.throws(() => randomNumber(10, 1), RangeError);
  assert.throws(() => randomNumber("a", "b"), RangeError);
});

test("generateRandomId genera un identificador aleatorio", () => {
  const id = generateRandomId();
  assert.equal(id.length, 10);
  assert.match(id, /^[A-Za-z0-9]{10}$/);

  const shortId = generateRandomId(5);
  assert.equal(shortId.length, 5);

  assert.notEqual(generateRandomId(20), generateRandomId(20));
  assert.throws(() => generateRandomId(0), RangeError);
  assert.throws(() => generateRandomId(-3), RangeError);
  assert.throws(() => generateRandomId(2.5), RangeError);
});

test("formatDate devuelve una fecha con el formato indicado", () => {
  const date = new Date(2024, 4, 20);
  assert.equal(formatDate(date), "20/05/2024");
  assert.equal(formatDate(date, "YYYY-MM-DD"), "2024-05-20");
  assert.equal(formatDate("fecha invalida"), "");
});
