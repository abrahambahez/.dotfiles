# Principios y reglas para documentar en este repositorio

Este repositorio centraliza la documentación del proyecto usando la filosofía de [Docs As Code](https://www.writethedocs.org/guide/docs-as-code/).

[TOC]

## Estructura

```
.
├── ADR
│   └── 001_usar_docs_as_code.md
├── APP
│   ├── Backend
│   ├── Frontend
│   └── Specs
├── DD
│   └── 001_optimizar_esquema_de_datos.md
├── USM
│   ├── 001
│   ├── README.md
│   └── requirements.txt
├── Utils
│   ├── Scripts
│   │   └── download_siucam.py
│   └── Templates
│       ├── any_decision_record.md
│       ├── design_doc.md
│       └── usm.md
├── CHANGELOG.md
├── GUIDE.md
└── README.md
```

Donde:

- [ADR](https://adr.github.io/madr/) significa *Architectual Decision Records*, o bien, *Any Decision Records* y es donde se documentan las decisiones del proyecto.
- **APP** se refiere a *Applications*, y es donde se documentan las especificaciones técnicas, diagramas, reglas generales del *front-end*, de las API y la base de datos.
- [DD](https://github.com/MaterializeInc/materialize/tree/main/doc/developer/design#readme) se refiere a *Design Documents*, y es donde se documenta cualquier solución que se propone implementar
- **USM** significa *User Story Maps*, y se basan en el libro de Jeff Patton [*User Story Mapping*](https://www.oreilly.com/library/view/user-story-mapping/9781491904893/)
- **Utils** es una carpeta para archivos de referencia, o de apoyo. Se incluyen *prompts* para LLM, *scripts* generales, plantillas de los archivos.

## Convenciones usadas 

- Usa la [guía de estilo](#guia-de-estilo) para escribir el contenido.
- Usa la sintaxis [GLFM](https://docs.gitlab.com/ee/user/markdown.html) para redactar en *markdown*.
- Versiona usando Git.
    - Crea un *commit* por cada modificación de un archivo importante.
    - Ignora los archivos de sistema o de aplicaciones locales de edición de *markdown* como Obsidian.
- El archivo `README.md` es un punto de entrada para entender el proyecto, tanto técnicamente como en sus dimensiones de alto nivel.
    - Se inspira parcialmente en [Arc42](https://arc42.org/overview). Toma de ahí las siguientes secciones:
    - Introducción y objetivos
    - Restricciones
    - Contexto y alcance
    - Estrategia y soluciones
- El archivo `CHANGELOG.md` seguirá el formato [*Keep A Changelog*](https://keepachangelog.com/en/1.0.0/).
- Los archivos en la carpeta `ADR/` deben seguir los principios [MADR](https://adr.github.io/madr/). Usa la [plantilla más simple](https://github.com/adr/madr/blob/4.0.0/template/adr-template-minimal.md) primero, añade más elementos de la [plantilla completa](https://github.com/adr/madr/blob/4.0.0/template/adr-template.md) si es necesario.
- Los archivos de la carpeta `APP` contienen subcarpetas para documentar especificaciones técnicas usadas actualmente por el sistema, como:
    - Esquemas y modelado de datos
    - Diagramas de arquitectura
    - Flujos de usuario
    - Servicios web (API)
    - Frontend (mapeo de mutaciones, consultas a la base)
- Los archivos en la carpeta `DD` deben seguir las ideas claves de un [*Design Document*](https://github.com/MaterializeInc/materialize/tree/main/doc/developer/design#readme). Sigue la plantilla que se encuentra en `Utils/Templates/design_doc.md`.
- Los archivos de la carpeta `USM` se basan en el módulo de python [MarkdownUSM](https://pypi.org/project/markdownusm/) para convertir descripciones de markdown a archivos legibles por [draw.io](https://app.diagrams.net/).
    - Cada mapa se organiza en su propia carpeta numerada, en donde se guardan el archivo `.md`, el archivo `.dio` y una imagen estática de la última versión del mapa.
- La carpeta `Utils` debe contener las plantillas de todos los archivos mencionados y cualquier otro que se decida añadir, con el fin de mantener consistencia.

## Guía de estilo

Hay 2 componentes claves para escribir una página excelente

1. Lenguaje consistente
2. Formato correcto

A continuación se especifica qué significa cada uno en puntos clave.

### Lenguaje consistente

El **lenguaje consistente** facilita la consulta e [interoperabilidad](https://es.wikipedia.org/wiki/Interoperabilidad) de la información, fortalece la [memoria transactiva](https://en.wikipedia.org/wiki/Transactive_memory) y disminuye la ambigüedad.

#### **Escribir nombres propios siempre de la misma forma**

Ej. siempre escribir MongoDB, Twitter, nunca mongo o Tw. Si un nombre propio es importante y recurrente, *crea su propia nota* y refiérelo

#### **Simple es mejor que complejo, complejo es mejor que complicado**

**Preferir oraciones simples** (Sujeto + Predicado), ejemplo: «El usuario dio retroalimentación», «el cliente aprobó el nuevo diseño». Evitar voces pasivas, ejemplo: «La implementación de la funcionalidad fue llevada a cabo»; cuando es mejor «La funcionalidad se implementó».

#### **Explícito es siempre mejor que implícito** (de hecho, implícito no sirve)

No asumas que porque algo es obvio para ti, es obvio para todos los demás, el conocimiento compartido *depende de que todos entendamos lo más posible*.

Si tienes que explicar un término técnico o de lógica de negocio específica, dedica un momento a escribir un párrafo extra haciéndolo. Si puedes decir lo mismo evitando tecnicismos, ahórrate el esfuerzo.

#### **Usar sabiamente los anglicismos**

No abuses de los términos en inglés. Usa sólo aquellos que no tienen una traducción adecuada en español, o cuya traducción al español puede no ser entendida por todos los karmas, o bien, aquellos que son tecnicismos.

### Formato correcto

Usa los elementos para lo que son, en las siguientes recomendaciones se especifica cada uno de esos elementos.

#### Usa el énfasis correctamente

Este es el significado de los énfasis:

*Énfasis simple*, **énfasis destacado**, ***énfasis más destacado***

#### Usa la estructura dentro de la página correctamente

1. Trata de usar sólo los 3 niveles de encabezado principales, y *siempre en ese orden* 
2. Si usas listas ordenadas, recuerda que representan secuencias dependientes, series consecutivas o elementos donde el orden altera el sentido; si no pretendes algo de esto, usa listas no ordenadas
3. Evita usar los elementos de checkbox salvo para denotar tareas explícitas que no pueden ir en otra parte. Si quieres documentar una tarea de proyecto usa el software de proyecto existente.

#### Usa los tipos de contenido correctamente

Escribe en bloques de tipo texto: cada párrafo debe ser una idea completa, concreta ya que posiblemente puede reusarse. Cada heading debe ser un grupo de párrafos coherente ya que también pueden referenciarse. Cada página debe tener fuerte coherencia interna

Usa correctamente los elementos de `código en línea` y en bloque, para mostrar fragmentos de código o meta-referencias

```python
# Ejemplo de código en bloque
print('Fragmentos de código o meta-referencias')
```

> Para citas de otras personas o referencias, usa bloques de citas y pon la referencia al final
> 

>[!important] 💡 Ojo
> Usa muy sabiamente las alertas, ya que llaman mucho la atención y saturan visualmente el contenido si abusas de ellos
>

