# dev-utils-lauta-2026

Libreria de utilidades de JavaScript con funciones reutilizables de strings, validaciones, numeros y fechas.

- Paquete en NPM: https://www.npmjs.com/package/dev-utils-lauta-2026
- Repositorio: https://github.com/lautaro/dev-utils-lauta-2026
- Licencia: MIT
- Requiere Node.js 18 o superior.

## Descripcion

`dev-utils-lauta-2026` es una libreria escrita con ES Modules (ESM) que agrupa funciones de uso frecuente para no tener que reescribirlas en cada proyecto. No tiene dependencias externas y funciona tanto en Node.js como en el navegador.

## Instalacion

```bash
npm install dev-utils-lauta-2026
```

## Uso

La libreria se distribuye como modulo ESM, por lo que el proyecto que la consume debe tener `"type": "module"` en su `package.json` (o usar la extension `.mjs`).

```javascript
import { capitalize, isValidEmail } from "dev-utils-lauta-2026";

console.log(capitalize("federico"));
console.log(isValidEmail("usuario@email.com"));
```

Tambien se pueden importar todas las funciones de una sola vez:

```javascript
import * as utils from "dev-utils-lauta-2026";

console.log(utils.truncate("JavaScript es genial", 10));
```

## Funciones disponibles

### Strings

#### `capitalize(text)`

Convierte la primera letra de un texto a mayuscula.

- Parametros: `text` (string).
- Devuelve: string. Si el valor no es un string o es vacio, devuelve `""`.

```javascript
capitalize("federico"); // "Federico"
```

#### `capitalizeWords(text)`

Convierte la primera letra de cada palabra a mayuscula.

- Parametros: `text` (string).
- Devuelve: string. Si el valor no es un string o es vacio, devuelve `""`.

```javascript
capitalizeWords("hola mundo"); // "Hola Mundo"
```

#### `truncate(text, length, suffix = "...")`

Limita un texto a `length` caracteres y agrega el sufijo indicado (por defecto `...`) cuando se supera el limite.

- Parametros: `text` (string), `length` (number), `suffix` (string, opcional).
- Devuelve: string. Si el valor no es un string o `length` no es valido, devuelve `""`.

```javascript
truncate("JavaScript es genial", 10); // "JavaScript..."
truncate("JavaScript es genial", 10, "…"); // "JavaScript…"
truncate("corto", 10); // "corto"
```

#### `slugify(text)`

Convierte un texto en un slug apto para URLs (minusculas, sin acentos y separado por guiones).

- Parametros: `text` (string).
- Devuelve: string.

```javascript
slugify("Noticias de Programacion"); // "noticias-de-programacion"
```

### Validadores

#### `isValidEmail(email)`

Valida si un email tiene un formato correcto (`usuario@dominio.com`).

- Parametros: `email` (string).
- Devuelve: boolean.

```javascript
isValidEmail("usuario@email.com"); // true
isValidEmail("usuario@email"); // false
```

#### `isEmpty(value)`

Verifica si un valor esta vacio. Considera vacios: `""`, textos con solo espacios, `null`, `undefined`, arrays sin elementos, objetos sin propiedades, `Map` y `Set` vacios.

- Parametros: `value` (cualquier tipo).
- Devuelve: boolean.

```javascript
isEmpty("   "); // true
isEmpty({}); // true
isEmpty([1, 2]); // false
```

### Numeros

#### `formatCurrency(amount, currency = "ARS", locale = "es-AR")`

Convierte un numero a formato moneda usando `Intl.NumberFormat`.

- Parametros: `amount` (number), `currency` (string, opcional), `locale` (string, opcional).
- Devuelve: string. Si `amount` no es un numero valido, devuelve `""`.

```javascript
formatCurrency(1234.5); // "$ 1.234,50"
formatCurrency(1000, "USD", "en-US"); // "$1,000.00"
```

#### `randomNumber(min, max)`

Genera un numero entero aleatorio dentro de un rango inclusivo.

- Parametros: `min` (number), `max` (number).
- Devuelve: number. Lanza `RangeError` si el rango no es valido.

```javascript
randomNumber(1, 10); // por ejemplo 7
```

#### `generateRandomId(length = 10)`

Genera un identificador aleatorio con letras y numeros.

- Parametros: `length` (number, opcional, por defecto 10).
- Devuelve: string. Lanza `RangeError` si `length` no es un entero mayor que cero.

```javascript
generateRandomId(); // "a1B2c3D4e5"
generateRandomId(6); // "Xy9Z0w"
```

### Fechas

#### `formatDate(date, format = "DD/MM/YYYY")`

Devuelve una fecha con el formato indicado. Los tokens disponibles son `YYYY`, `MM` y `DD`.

- Parametros: `date` (Date o string), `format` (string, opcional).
- Devuelve: string. Si la fecha no es valida, devuelve `""`.

```javascript
formatDate(new Date(2024, 4, 20)); // "20/05/2024"
formatDate(new Date(2024, 4, 20), "YYYY-MM-DD"); // "2024-05-20"
```

## Tests

El proyecto incluye tests unitarios escritos con el modulo `node:test` de Node.js.

```bash
npm test
```

## Estructura del proyecto

```
dev-utils/
├── src/
│   ├── strings.js
│   ├── validators.js
│   ├── numbers.js
│   ├── dates.js
│   └── index.js
├── test/
│   └── utils.test.js
├── README.md
├── LICENSE
├── package.json
└── .gitignore
```

## Desarrollo local

Para probar la libreria desde otro proyecto sin publicarla se puede instalar por ruta local:

```bash
mkdir prueba-libreria
cd prueba-libreria
npm init -y
npm install ../dev-utils
```

Luego se importa con el nombre del paquete:

```javascript
import { capitalize } from "dev-utils-lauta-2026";

console.log(capitalize("federico"));
```

## Publicacion en NPM

```bash
# 1. Crear una cuenta en https://www.npmjs.com
# 2. Iniciar sesion desde la terminal
npm login

# 3. Verificar el usuario conectado
npm whoami

# 4. Revisar el contenido que se va a publicar
npm publish --dry-run

# 5. Publicar
npm publish
```

Para publicar una nueva version:

```bash
npm version patch   # 1.0.0 -> 1.0.1
npm publish
```

## Historial de versiones

### 1.0.1

- Se agrego la funcion `capitalizeWords`.
- `truncate` ahora acepta un sufijo personalizado como tercer parametro.
- Se mejoro la validacion de `isValidEmail` (longitud maxima, puntos consecutivos y dominio con extension de dos o mas caracteres).
- Se actualizaron los tests y la documentacion.

### 1.0.0

- Version inicial con las funciones `capitalize`, `truncate`, `slugify`, `isValidEmail`, `isEmpty`, `formatCurrency`, `randomNumber`, `generateRandomId` y `formatDate`.

## Licencia

MIT
