# FLiiTS Catalunya World

Juego y presentación de FLiiTS Catalunya. Se publica con GitHub Pages en https://raulfliits.github.io/fliits-world/ y se puede instalar en el móvil como app (Compartir > Añadir a pantalla de inicio en iPhone; Instalar app en Chrome/Android).

## Versiones

- `index.html`: presentación + juego (con la cuenta atrás).
- `juego/`: solo el juego, sin los paneles de datos. Es a donde lleva el QR.

Ambas se generan con `sh build.sh ruta/a/FLiiTS_Catalunya_World.html`.
- `consola/`: solo el juego para consolas portátiles con Android y botones físicos (sin la consola dibujada).
- `rom/fliits-world.gb`: ROM de Game Boy para consolas sin navegador (Anbernic con Linux, etc.). Copiar a la carpeta de ROMs de Game Boy (GB).
