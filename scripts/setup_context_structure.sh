#!/bin/bash

if [ -z "$1" ]; then
    echo "Uso: ./setup_context_structure.sh <nombre-entidad>"
    echo "Ejemplo: ./setup_context_structure.sh mi-empresa"
    exit 1
fi

ENTITY_NAME="$1"
BASE_DIR="$ENTITY_NAME"

echo "🏗️  Creando estructura de contexto para: $ENTITY_NAME"

mkdir -p "$BASE_DIR"/{identidad,estado/recursos,red/entidades,proyectos}

echo "📁 Carpetas creadas"

cat > "$BASE_DIR/CONTEXT.md" << 'EOF'
# Contexto de Navegación

*Última actualización: [fecha]*

Este archivo es el índice maestro para navegar la documentación de esta entidad.

## Estructura

- **identidad/**: Información fundamental sobre qué ES esta entidad (casi inmutable)
- **estado/**: Información operacional sobre cómo ESTÁ (muy mutable)
- **red/**: Información sobre con quién se RELACIONA
- **proyectos/**: Información sobre QUÉ hace y hacia dónde VA
- **log.txt**: Registro cronológico de eventos y cambios

## Navegación Rápida

### Para entender la esencia
→ [identidad/esencia.md](./identidad/esencia.md) - Valores y propósito
→ [identidad/diferencial.md](./identidad/diferencial.md) - Qué ofrece único

### Para conocer el estado actual
→ [estado/ahora.md](./estado/ahora.md) - Situación presente
→ [estado/metricas.md](./estado/metricas.md) - Indicadores clave

### Para entender las capacidades
→ [estado/recursos/](./estado/recursos/) - Metodologías, herramientas, protocolos

### Para ver relaciones
→ [red/interfaces.md](./red/interfaces.md) - Presencia pública
→ [red/entidades/](./red/entidades/) - Contextos de otras organizaciones/personas

### Para conocer proyectos
→ [proyectos/](./proyectos/) - Proyectos activos e históricos

## Periodicidad de Actualización

| Archivo | Frecuencia | Propósito |
|---------|------------|-----------|
| estado/ahora.md | Semanal | Estado operacional actual |
| estado/metricas.md | Mensual | Indicadores de progreso |
| red/interfaces.md | Mensual | Presencia pública y enlaces |
| red/contactos.md | Mensual | Red profesional activa |
| identidad/diferencial.md | Trimestral | Evolución de propuesta de valor |
| proyectos/[proyecto]/CONTEXT.md | Trimestral | Progreso de proyectos |
| identidad/esencia.md | Anual | Valores fundamentales |
| identidad/historia.md | Anual | Hitos significativos |
| log.txt | Según eventos | Registro de cambios |

## Para LLMs

Este sistema está diseñado para que modelos de lenguaje puedan navegar eficientemente:

1. Cada carpeta tiene un CONTEXT.md que explica su contenido
2. Este archivo maestro indexa toda la estructura
3. Los enlaces internos son relativos y navegables
4. La información está organizada por volatilidad (inmutable → muy mutable)

Ver [INSTRUCCIONES.md](./INSTRUCCIONES.md) para guía completa de mantenimiento.
EOF

cat > "$BASE_DIR/log.txt" << 'EOF'
# Log de Eventos

Formato: YYYY-MM-DD | Descripción breve del evento

EOF

cat > "$BASE_DIR/identidad/CONTEXT.md" << 'EOF'
# Identidad - Contexto de Navegación

Esta carpeta contiene información fundamental sobre **qué ES** esta entidad.

## Contenido

- **esencia.md**: Valores fundamentales, propósito, visión (actualización: anual)
- **historia.md**: Trayectoria biográfica, hitos significativos (actualización: anual)
- **diferencial.md**: Propuesta de valor única, qué ofrece distinto (actualización: trimestral)

## Características

- **Volatilidad**: Baja - Esta información cambia raramente
- **Naturaleza**: Ontológica - Define lo que la entidad ES, no lo que HACE
- **Uso**: Fundamento para todas las decisiones estratégicas

## Cuándo leer

- Al conocer por primera vez esta entidad
- Antes de tomar decisiones estratégicas importantes
- Al evaluar alineación con valores y propósito
- En revisiones anuales

## Cuándo actualizar

- **Anual**: esencia.md, historia.md (agregar hitos del año)
- **Trimestral**: diferencial.md (evolución de propuesta de valor)
- **Excepcional**: Si hay cambio fundamental en valores o propósito
EOF

cat > "$BASE_DIR/identidad/esencia.md" << 'EOF'
# Esencia

*Última actualización: [fecha]*
*Periodicidad: Anual*

## Valores Fundamentales


## Propósito

¿Por qué existe esta entidad?


## Visión

¿Qué futuro busca crear?


## Identidad

¿Qué debe permanecer verdadero para que esto siga siendo ESTO?

EOF

cat > "$BASE_DIR/identidad/historia.md" << 'EOF'
# Historia

*Última actualización: [fecha]*
*Periodicidad: Anual*

## [Período/Año]


EOF

cat > "$BASE_DIR/identidad/diferencial.md" << 'EOF'
# Diferencial y Propuesta de Valor

*Última actualización: [fecha]*
*Periodicidad: Trimestral*

## ¿Qué hace único a esta entidad?


## ¿A quién ayuda?


## ¿Cómo entrega valor?


## ¿Por qué es difícil de replicar?

EOF

cat > "$BASE_DIR/estado/CONTEXT.md" << 'EOF'
# Estado - Contexto de Navegación

Esta carpeta contiene información operacional sobre **cómo ESTÁ** esta entidad actualmente.

## Contenido

- **ahora.md**: Estado actual, prioridades, foco presente (actualización: semanal)
- **metricas.md**: Indicadores clave, KPIs, progreso (actualización: mensual)
- **recursos/**: Metodologías, protocolos, herramientas, capacidades disponibles

## Características

- **Volatilidad**: Alta - Esta información cambia frecuentemente
- **Naturaleza**: Operacional - Describe el estado presente, no la esencia
- **Uso**: Toma de decisiones tácticas, seguimiento de progreso

## Cuándo leer

- Al comenzar la semana (ahora.md)
- En revisiones mensuales (metricas.md)
- Al necesitar metodologías o herramientas (recursos/)
- Al evaluar capacidad actual

## Cuándo actualizar

- **Semanal**: ahora.md
- **Mensual**: metricas.md
- **Según necesidad**: recursos/ (al crear o actualizar metodologías)
EOF

cat > "$BASE_DIR/estado/ahora.md" << 'EOF'
# Estado Actual

*Snapshot: [fecha]*
*Periodicidad: Semanal*

## Esta Semana


## Este Mes


## Objetivos Activos


## Capacidad Disponible


## Bloqueos o Desafíos

EOF

cat > "$BASE_DIR/estado/metricas.md" << 'EOF'
# Métricas e Indicadores

*Última actualización: [fecha]*
*Periodicidad: Mensual*

## Indicadores Clave (KPIs)


## Progreso de Objetivos


## Tendencias


## Observaciones

EOF

cat > "$BASE_DIR/estado/recursos/CONTEXT.md" << 'EOF'
# Recursos - Contexto de Navegación

Esta carpeta contiene las capacidades, metodologías, protocolos y herramientas disponibles.

## Contenido

Aquí se documentan:
- Metodologías propias o adoptadas
- Protocolos de trabajo
- Frameworks y checklists
- Herramientas técnicas
- Procesos estandarizados

## Características

- **Volatilidad**: Media - Se actualiza al crear o refinar metodologías
- **Naturaleza**: Instrumental - Son los "cómo" operacionales
- **Uso**: Consulta al ejecutar trabajo, referencia para otros

## Organización

Los archivos pueden organizarse por:
- Tipo (metodologias/, protocolos/, herramientas/)
- Dominio (producto/, investigacion/, facilitacion/)
- Como prefieras según tu volumen

## Cuándo actualizar

- Al crear una nueva metodología o framework
- Al refinar procesos existentes
- Al adoptar nuevas herramientas
- En retrospectivas de proyectos (capturar aprendizajes)
EOF

cat > "$BASE_DIR/red/CONTEXT.md" << 'EOF'
# Red - Contexto de Navegación

Esta carpeta contiene información sobre **con quién se RELACIONA** esta entidad.

## Contenido

- **interfaces.md**: Presencia pública, canales, sitios web (actualización: mensual)
- **contactos.md**: Red profesional, relaciones clave (actualización: mensual)
- **entidades/**: Contextos sistémicos de otras organizaciones, personas, proyectos

## Características

- **Volatilidad**: Media - Conexiones evolucionan pero con cierta estabilidad
- **Naturaleza**: Relacional - Define el ecosistema de interacciones
- **Uso**: Gestión de relaciones, networking, colaboraciones

## Cuándo leer

- Al buscar colaboradores potenciales
- Al necesitar contexto sobre organizaciones relacionadas
- Al planificar networking
- Al evaluar presencia pública

## Cuándo actualizar

- **Mensual**: interfaces.md (verificar enlaces), contactos.md (nuevas relaciones)
- **Según necesidad**: entidades/ (al interactuar con nuevas organizaciones)
EOF

cat > "$BASE_DIR/red/interfaces.md" << 'EOF'
# Interfaces Públicas

*Última actualización: [fecha]*
*Periodicidad: Mensual*

## Sitios Web


## Redes Sociales


## Repositorios / Código


## Presencia en Plataformas


## Métricas de Alcance

EOF

cat > "$BASE_DIR/red/contactos.md" << 'EOF'
# Red Profesional

*Última actualización: [fecha]*
*Periodicidad: Mensual*

## Contactos Clave


## Organizaciones Relevantes


## Comunidades Activas

EOF

cat > "$BASE_DIR/red/entidades/CONTEXT.md" << 'EOF'
# Entidades - Contexto de Navegación

Esta carpeta contiene contextos sistémicos de organizaciones, personas o proyectos con los que esta entidad se relaciona.

## Contenido

Cada archivo documenta una entidad externa usando systems thinking:
- Organizaciones empleadoras, clientes, socios
- Personas clave en la red profesional
- Proyectos colaborativos significativos

## Cómo crear contextos

Usa el comando de Claude Code:
```
/create_context [información sobre la entidad]
```

Guarda el resultado como: `[nombre-entidad].md`

## Formato

Cada contexto sigue la plantilla de systems thinking que incluye:
- System Identity (esencia, boundaries)
- System Structure (componentes, relaciones)
- Current State (estado actual, proyectos)
- System Dynamics (patrones, leverage points)
- Strategic Context (dirección, experimentos)

## Cuándo crear

- Al comenzar relación significativa con organización
- Al iniciar colaboración importante
- Al necesitar entender profundamente una entidad
- Para documentar relaciones clave del ecosistema

## Cuándo actualizar

- Trimestral: Current State
- Anual: Revisión completa
- Según eventos significativos en la relación
EOF

cat > "$BASE_DIR/proyectos/CONTEXT.md" << 'EOF'
# Proyectos - Contexto de Navegación

Esta carpeta contiene información sobre **QUÉ hace** esta entidad y **hacia dónde VA**.

## Contenido

Proyectos organizados por iniciativa o período:
- Cada proyecto tiene su propia carpeta
- Dentro: plan/estrategia, reportes, artefactos producidos
- Proyectos activos e históricos

## Estructura de un proyecto

```
[nombre-proyecto]/
├── CONTEXT.md           # Qué contiene este proyecto
├── plan.md              # El documento estratégico (OKRs, roadmap)
├── reportes/            # Resultados, análisis, evaluaciones
└── artefactos/          # Outputs específicos del proyecto
```

## Características

- **Volatilidad**: Media-baja - Proyectos son estables, seguimiento es frecuente
- **Naturaleza**: Prospectiva y ejecutiva - Define dirección y acciones
- **Uso**: Alineación estratégica, evaluación de progreso, documentación de resultados

## Cuándo leer

- Al comenzar un nuevo proyecto o período
- En revisiones trimestrales
- Al evaluar viabilidad de nuevas iniciativas
- Al necesitar contexto histórico de decisiones

## Cuándo actualizar

- **Trimestral**: Progreso en CONTEXT.md de proyectos activos
- **Al completar**: Mover a sección "histórico" en este archivo
- **Según eventos**: Ajustes estratégicos o hitos significativos

## Proyectos Activos


## Proyectos Históricos

EOF

cat > "$BASE_DIR/INSTRUCCIONES.md" << 'EOF'
# Instrucciones de Mantenimiento

Este documento explica cómo mantener actualizado tu sistema de documentación.

## Filosofía

Este sistema está diseñado con tres principios:

1. **Organización por volatilidad**: Lo inmutable separado de lo que cambia frecuentemente
2. **Navegación para LLMs**: Cada carpeta tiene CONTEXT.md explicando su contenido
3. **Minimalismo funcional**: Solo lo necesario, nada superfluo

## Estructura

```
.
├── CONTEXT.md          # Índice maestro de navegación
├── log.txt             # Registro cronológico de eventos
├── identidad/          # Qué ES (casi inmutable)
├── estado/             # Cómo ESTÁ (muy mutable)
├── red/                # Con quién se RELACIONA (medio)
└── proyectos/          # Qué HACE y hacia dónde VA (medio-bajo)
```

## Guía de Actualización

### 📊 SEMANAL

**estado/ahora.md**
- **Qué**: Tareas semana, prioridades, foco actual
- **Cuándo**: Lunes mañana + ajustes según necesidad
- **Cómo**: Lista concreta de qué está activo ahora

**log.txt**
- **Qué**: Eventos significativos
- **Cuándo**: Al ocurrir algo notable
- **Cómo**: Formato `YYYY-MM-DD | Descripción breve`

### 📅 MENSUAL

**estado/metricas.md**
- **Qué**: KPIs, progreso objetivos
- **Cuándo**: Último día del mes
- **Cómo**: Números concretos, tendencias, observaciones

**red/interfaces.md**
- **Qué**: Enlaces públicos, verificación de sitios
- **Cuándo**: Mitad de mes
- **Cómo**: Verificar todos los enlaces funcionan

**red/contactos.md**
- **Qué**: Nuevas relaciones, cambios en red
- **Cuándo**: Fin de mes
- **Cómo**: Agregar contactos significativos del mes

### 📆 TRIMESTRAL

**identidad/diferencial.md**
- **Qué**: Evolución de propuesta de valor
- **Cuándo**: Final de trimestre
- **Cómo**: Reflexionar sobre qué ha cambiado en tu valor único

**proyectos/[proyecto]/CONTEXT.md**
- **Qué**: Progreso de proyectos activos
- **Cuándo**: Revisión trimestral
- **Cómo**: Actualizar estado, evaluar KRs, identificar bloqueos

### 📅 ANUAL

**identidad/esencia.md**
- **Qué**: Valores, propósito, visión
- **Cuándo**: Fin/inicio de año
- **Cómo**: Reflexión profunda sobre cambios fundamentales

**identidad/historia.md**
- **Qué**: Hitos significativos del año
- **Cuándo**: Fin de año
- **Cómo**: Agregar sección nueva con eventos importantes

## Ritmo de Trabajo Sugerido

### Ritual Semanal (15 min)
1. Lunes: Actualizar `estado/ahora.md`
2. Durante semana: Eventos significativos en `log.txt`

### Ritual Mensual (1 hora)
1. Actualizar `estado/metricas.md`
2. Revisar `red/interfaces.md` - verificar enlaces
3. Actualizar `red/contactos.md` con relaciones nuevas

### Ritual Trimestral (2-3 horas)
1. Revisar progreso de proyectos en `proyectos/`
2. Actualizar `identidad/diferencial.md`
3. Evaluar qué funciona y qué no

### Ritual Anual (1 día)
1. Actualizar `identidad/historia.md` con hitos
2. Revisar `identidad/esencia.md` - ¿cambió algo fundamental?
3. Planificación de proyectos para siguiente año

## Trabajo con LLMs

Este sistema está optimizado para Claude Code y otros LLMs:

### Navegación
- El LLM leerá `CONTEXT.md` primero
- Cada carpeta tiene su propio `CONTEXT.md` como guía
- Enlaces internos son relativos y navegables

### Comandos útiles
```bash
# Crear contexto de entidad externa
/create_context [información sobre organización/persona]

# Resultado va a: red/entidades/[nombre].md
```

### Estructura de un proyecto en proyectos/

Cuando crees un proyecto nuevo:

```bash
mkdir proyectos/mi-proyecto-2025
```

Luego crea dentro:
- `CONTEXT.md` - Explicando el proyecto y su contenido
- `plan.md` - El documento estratégico (OKRs, roadmap)
- `reportes/` - Para análisis y evaluaciones
- `artefactos/` - Para outputs concretos

## Principios de Mantenimiento

1. **Consistencia > Perfección**: Actualizar regularmente es más valioso que esperar perfección
2. **Enlaces, no duplicación**: Referenciar, no copiar información entre archivos
3. **Fechas visibles**: Siempre incluir última actualización
4. **Vacío es válido**: Mejor sección vacía que contenido forzado
5. **CONTEXT.md como mapa**: Cada carpeta debe explicarse a sí misma

## Evolución del Sistema

Este sistema puede evolverse según tus necesidades:
- Agregar subcarpetas en `estado/recursos/` si crece mucho
- Crear categorías en `red/entidades/` si tienes muchos contextos
- Ajustar periodicidades según tu ritmo real
- Modificar lo que no funciona

La clave: **útil y sostenible para ti**.
EOF

cat > "$BASE_DIR/README.md" << EOF
# $ENTITY_NAME - Sistema de Documentación

Sistema de documentación estructurada usando principles de systems thinking, optimizado para navegación por LLMs.

## 🚀 Inicio Rápido

1. Lee [CONTEXT.md](./CONTEXT.md) para entender la estructura completa
2. Lee [INSTRUCCIONES.md](./INSTRUCCIONES.md) para saber cómo mantenerlo actualizado

## 📁 Estructura

- **identidad/**: Qué ES esta entidad (casi inmutable)
- **estado/**: Cómo ESTÁ ahora (muy mutable)
- **red/**: Con quién se RELACIONA (medio)
- **proyectos/**: Qué HACE y hacia dónde VA (medio-bajo)
- **log.txt**: Registro cronológico de eventos

Cada carpeta tiene su propio \`CONTEXT.md\` explicando su contenido y uso.

## 🔄 Periodicidad

- **Semanal**: estado/ahora.md, log.txt
- **Mensual**: estado/metricas.md, red/interfaces.md, red/contactos.md
- **Trimestral**: identidad/diferencial.md, proyectos/[proyectos]
- **Anual**: identidad/esencia.md, identidad/historia.md

## 🤖 Diseñado para LLMs

Este sistema permite que Claude Code y otros LLMs naveguen eficientemente:
- Archivos CONTEXT.md en cada nivel
- Enlaces internos relativos
- Información organizada por volatilidad
- Índices claros de contenido

Ver [CONTEXT.md](./CONTEXT.md) para más detalles.
EOF

echo ""
echo "✅ Estructura creada en: ./$BASE_DIR/"
echo ""
echo "📖 Siguiente paso:"
echo "   cd $BASE_DIR && cat CONTEXT.md"
echo ""
echo "💡 Archivos clave:"
echo "   • CONTEXT.md - Índice maestro de navegación"
echo "   • INSTRUCCIONES.md - Guía completa de mantenimiento"
echo "   • Cada carpeta tiene su CONTEXT.md explicando su contenido"
echo ""
