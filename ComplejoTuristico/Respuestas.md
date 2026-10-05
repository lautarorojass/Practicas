
# Sistema de Gestión de un Complejo Turístico

## 1. Introducción

El objetivo de este trabajo es diseñar una solución de base de datos para un complejo turístico que administra diferentes tipos de alojamientos, reservas, huéspedes, inspecciones y servicios utilizados durante las estadías.

Debido a que la información del sistema tiene diferentes características, se propone utilizar un **modelo de base de datos híbrido**, combinando una base de datos **relacional** con una base de datos **documental**.

La base relacional se utilizará para la información estructurada y las relaciones principales del sistema, mientras que la base documental se utilizará para información que puede variar considerablemente en estructura y cantidad.

---

# 2. Información que necesita almacenar el sistema

El sistema necesita almacenar información relacionada con:

* Huéspedes.
* Alojamientos.
* Reservas.
* Servicios ofrecidos por el complejo.
* Servicios utilizados durante cada estadía.
* Inspecciones realizadas al finalizar una estadía.
* Características particulares de cada tipo de alojamiento.

---

# 3. Modelo de base de datos utilizado

Se propone utilizar dos modelos de base de datos.

### Base de datos relacional

Se utilizará para:

* Huéspedes.
* Alojamientos.
* Reservas.
* Servicios.

Esta información tiene una estructura definida y relaciones claras.

Por ejemplo, una reserva pertenece a un huésped y a un alojamiento determinado. Los servicios ofrecidos por el complejo también tienen una estructura definida y forman parte de un catálogo.

El modelo relacional permite representar estas relaciones mediante **claves primarias y claves foráneas**, manteniendo la integridad y evitando duplicaciones innecesarias.

### Base de datos documental

Se utilizará para:

* Características específicas de los alojamientos.
* Inspecciones.
* Consumos de servicios.

Estas informaciones pueden tener estructuras diferentes dependiendo de cada caso.

Por ejemplo, una habitación puede tener cantidad de camas, tipo de baño y balcón, mientras que una cabaña puede tener parrilla, cocina, cantidad de habitaciones y tipo de calefacción.

Una base documental permite representar esta información mediante documentos JSON de manera flexible.

---

# 4. Diseño de la base relacional

## Tabla: `huespedes`

Almacena la información personal de las personas que realizan reservas.

| Atributo   | Tipo    | Clave  |
| ---------- | ------- | ------ |
| id_huesped | INT     | PK     |
| nombre     | VARCHAR |        |
| apellido   | VARCHAR |        |
| dni        | VARCHAR | UNIQUE |
| telefono   | VARCHAR |        |
| email      | VARCHAR |        |

El DNI se almacena como `VARCHAR` porque funciona como un identificador y no se realizan operaciones matemáticas con él. Además, permite conservar exactamente el valor ingresado.

---

## Tabla: `alojamientos`

Almacena la información general de los alojamientos disponibles.

| Atributo       | Tipo    | Clave |
| -------------- | ------- | ----- |
| id_alojamiento | INT     | PK    |
| nombre         | VARCHAR |       |
| tipo           | VARCHAR |       |
| capacidad      | INT     |       |
| precio_base    | DECIMAL |       |
| disponible     | BOOLEAN |       |

El campo `tipo` permite identificar si se trata de una habitación, cabaña, departamento u otro tipo de alojamiento.

Las características específicas de cada alojamiento se almacenan en la parte documental, debido a que pueden variar según el tipo.

---

## Tabla: `reservas`

Almacena las reservas realizadas por los huéspedes.

| Atributo       | Tipo    | Clave |
| -------------- | ------- | ----- |
| id_reserva     | INT     | PK    |
| id_huesped     | INT     | FK    |
| id_alojamiento | INT     | FK    |
| fecha_ingreso  | DATE    |       |
| fecha_salida   | DATE    |       |
| precio_total   | DECIMAL |       |

Las claves foráneas `id_huesped` e `id_alojamiento` permiten relacionar cada reserva con el huésped que la realizó y con el alojamiento seleccionado.

### Relaciones

**Huésped 1:N Reservas**

Un huésped puede realizar varias reservas, pero cada reserva pertenece a un único huésped.

**Alojamiento 1:N Reservas**

Un alojamiento puede aparecer en muchas reservas a lo largo del tiempo, pero cada reserva corresponde a un único alojamiento.

---

## Tabla: `servicios`

Almacena el catálogo de servicios ofrecidos por el complejo.

| Atributo    | Tipo    | Clave |
| ----------- | ------- | ----- |
| id_servicio | INT     | PK    |
| nombre      | VARCHAR |       |
| descripcion | VARCHAR |       |
| precio      | DECIMAL |       |

Algunos ejemplos de servicios son:

* Desayuno.
* Lavandería.
* Alquiler de bicicletas.
* Estacionamiento.
* Excursiones.

Los servicios se almacenan en una tabla relacional porque forman parte de un catálogo estructurado y pueden ser identificados mediante un `id_servicio`.

---

# 5. Relaciones del modelo relacional

El modelo relacional queda representado de la siguiente manera:

```text
┌───────────────┐
│   HUESPEDES   │
└───────┬───────┘
        │ 1
        │
        │ N
┌───────▼───────┐
│    RESERVAS   │
└───────┬───────┘
        │ N
        │
        │ 1
┌───────▼───────────┐
│   ALOJAMIENTOS    │
└───────────────────┘


┌───────────────┐
│   SERVICIOS   │
└───────────────┘
```

La información sobre qué servicios fueron utilizados por cada reserva se almacena en la parte documental mediante la colección `consumos`.

El **DER completo** se incluye como parte de la entrega.

---

# 6. Diseño de la parte documental

Se definieron tres estructuras documentales principales:

* `alojamientos`
* `inspecciones`
* `consumos`

La información se representa mediante documentos JSON.

---

# 7. Colección `alojamientos`

Esta colección contiene las características específicas de cada alojamiento.

Los alojamientos pueden tener estructuras diferentes.

Por ejemplo, una habitación puede almacenar cantidad de camas, tipo de baño y balcón, mientras que una cabaña puede almacenar parrilla, cocina, cantidad de habitaciones y tipo de calefacción.

### Ejemplo

```json
{
  "alojamientos": [
    {
      "id_alojamiento": 1,
      "nombre": "Habitación Doble 1",
      "tipo": "habitacion",
      "capacidad": 2,
      "caracteristicas": {
        "cantidad_camas": 2,
        "tipo_bano": "Privado",
        "balcon": true
      }
    },
    {
      "id_alojamiento": 2,
      "nombre": "Cabaña Los Pinos",
      "tipo": "cabana",
      "capacidad": 5,
      "caracteristicas": {
        "parrilla": true,
        "cocina": true,
        "cantidad_habitaciones": 2,
        "tipo_calefaccion": "Gas"
      }
    },
    {
      "id_alojamiento": 3,
      "nombre": "Departamento 4B",
      "tipo": "departamento",
      "capacidad": 4,
      "caracteristicas": {
        "cochera": true,
        "piso": 4,
        "ascensor": true,
        "servicios": [
          "WiFi",
          "TV",
          "Aire acondicionado"
        ]
      }
    }
  ]
}
```

La estructura permite agregar nuevos tipos de alojamientos con características diferentes sin modificar el modelo general.

El campo `id_alojamiento` permite relacionar estos documentos con los alojamientos y reservas de la base relacional.

---

# 8. Colección `inspecciones`

Las inspecciones se realizan cuando un huésped finaliza su estadía.

Una inspección puede contener información variable, como:

* Estado de limpieza.
* Observaciones.
* Fotografías.
* Elementos dañados.
* Cantidad de elementos dañados.
* Otros datos que el encargado considere necesarios.

### Ejemplo

```json
{
  "inspecciones": [
    {
      "id_inspeccion": 1,
      "id_reserva": 101,
      "id_alojamiento": 1,
      "fecha": "2026-10-03T10:30:00",
      "estado_limpieza": "Bueno",
      "observaciones": "El alojamiento fue entregado en buenas condiciones.",
      "elementos_danados": [
        {
          "elemento": "Vaso",
          "cantidad": 1,
          "observacion": "Roto"
        }
      ],
      "fotografias": [
        "foto_001.jpg",
        "foto_002.jpg"
      ]
    }
  ]
}
```

Se utiliza un array para `elementos_danados` porque una inspección puede no tener daños o puede registrar uno o varios elementos.

También se utiliza un array para `fotografias`, ya que una inspección puede tener diferentes cantidades de fotografías.

El campo `id_reserva` permite identificar a qué reserva corresponde la inspección.

---

# 9. Colección `consumos`

Esta colección almacena los servicios utilizados durante las estadías.

En lugar de almacenar nuevamente el nombre, descripción y precio de cada servicio, los consumos utilizan `id_servicio` para referenciar el catálogo de servicios existente en la base relacional.

De esta manera se evita duplicar información y se reduce la posibilidad de inconsistencias.

### Ejemplo

```json
{
  "consumos": [
    {
      "id_consumo": 1,
      "id_reserva": 101,
      "fecha": "2026-10-01T08:30:00",
      "servicios": [
        {
          "id_servicio": 1,
          "cantidad": 2
        },
        {
          "id_servicio": 3,
          "cantidad": 1
        }
      ],
      "total": 16000
    },
    {
      "id_consumo": 2,
      "id_reserva": 102,
      "fecha": "2026-10-02T19:00:00",
      "servicios": [
        {
          "id_servicio": 2,
          "cantidad": 1
        },
        {
          "id_servicio": 4,
          "cantidad": 2
        },
        {
          "id_servicio": 5,
          "cantidad": 1
        }
      ],
      "total": 31000
    }
  ]
}
```

Por ejemplo, si en la tabla `servicios`:

```text
1 → Desayuno
2 → Lavandería
3 → Alquiler de bicicleta
4 → Estacionamiento
5 → Excursión
```

el primer consumo corresponde a:

```text
2 × Desayuno
1 × Alquiler de bicicleta
```

El campo `id_reserva` permite relacionar el consumo con la reserva correspondiente, mientras que `id_servicio` permite relacionarlo con el catálogo de servicios de la base relacional.

---

# 10. Relación entre el modelo relacional y el documental

Los dos modelos se relacionan mediante identificadores comunes.

Por ejemplo, una reserva almacenada en la base relacional puede tener:

```text
id_reserva = 101
id_huesped = 5
id_alojamiento = 2
```

Una inspección documental puede utilizar:

```json
{
  "id_inspeccion": 15,
  "id_reserva": 101,
  "id_alojamiento": 2
}
```

Y un consumo puede utilizar:

```json
{
  "id_consumo": 20,
  "id_reserva": 101,
  "servicios": [
    {
      "id_servicio": 1,
      "cantidad": 2
    }
  ]
}
```

De esta manera:

* `id_reserva` conecta los documentos con una reserva.
* `id_alojamiento` conecta los documentos con un alojamiento.
* `id_servicio` conecta los consumos con el catálogo de servicios.

No es necesario duplicar toda la información en ambos modelos. Se utilizan identificadores para establecer las relaciones.

---

# 11. Justificación final

Se decidió utilizar un **modelo híbrido** porque no toda la información del sistema tiene las mismas características.

El **modelo relacional** es apropiado para huéspedes, reservas, alojamientos generales y servicios porque son datos estructurados y existen relaciones claras entre ellos. Las claves primarias y foráneas permiten mantener la integridad y consistencia de los datos.

El **modelo documental** es apropiado para las características específicas de los alojamientos, las inspecciones y los consumos porque estos datos pueden variar en estructura y cantidad. Los documentos JSON permiten almacenar información anidada, listas y atributos diferentes sin necesidad de modificar constantemente el esquema.

Además, los consumos no duplican la información del catálogo de servicios. En su lugar, utilizan `id_servicio` para referenciar los servicios almacenados en la base relacional. Esto evita inconsistencias y mantiene cada dato en un único lugar.

La combinación de ambos modelos permite aprovechar las ventajas de cada uno:

* **Relacional:** estructura, relaciones, integridad y consistencia.
* **Documental:** flexibilidad y facilidad para representar información variable.

Por lo tanto, la solución híbrida permite representar adecuadamente las necesidades del complejo turístico y facilita futuras ampliaciones del sistema.
