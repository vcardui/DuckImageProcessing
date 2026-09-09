# 🦆 Duck Image Processing
Determine the 4-connected and 8-connected components of a given binary matrix, make it grayscale and identify a duck image's caracteristics

## Example Output
Representación Matricial de una Imagen ---------------------

Matriz I:
     0     0     0     1     1     0     0
     0     0     1     1     1     1     0
     0     1     1     1     1     1     1
     0     1     1     1     1     1     0
     0     0     1     1     1     0     0
     0     0     0     1     0     0     0

1. Determinar el tamaño de la imagen.
Altura (height): 6px
Anchura (width): 7px

2. Indicar el valor del pixel localizado en las posiciones I(3, 4), I(5, 5) y I(7, 4).
I(3, 4) = 1
I(5, 5) = 1
I(7, 4) = 0

3. Determinar los componentes 4-conectados.


cc4 =

     3     4     2     3     4     5     1     2     3     4     5     6     1     2     3     4     5     2     3     4     3
     2     2     3     3     3     3     4     4     4     4     4     4     5     5     5     5     5     6     6     6     7

4. Determinar los componentes 8-conectados.


cc8 =

     3     4     2     3     4     5     1     2     3     4     5     6     1     2     3     4     5     2     3     4     3
     2     2     3     3     3     3     4     4     4     4     4     4     5     5     5     5     5     6     6     6     7



Escala de Grises -------------------------------------------

3. Determinar el tamaño de la imagen.
Altura (height): 9072px
Anchura (width): 4032px

4. Convertirla a escala de grises
6. Obtener los valores de intensidad de los pixeles
7. Determinar el valor mínimo de intensidad

minImg =

  uint8

   0

8. Determinar el valor máximo de intesidad

maxImg =

  uint8

   255

9. Calcular la intensidad promedio

imgSum =

   1.5146e+09

totalImgPixels: 12192768
manualMean: 1.242217e+02

intensity =

  124.2217

width="267" height="303"

<img width="267" height="303" alt="original_photo" src="https://github.com/user-attachments/assets/8b008f65-8b6a-4175-b547-dcd529a6c80b" />
<img width="367" height="303" alt="original_matrix" src="https://github.com/user-attachments/assets/3b3072ec-314e-4c4f-adac-942a803269df" />
<img width="269" height="303" alt="grayscale_image" src="https://github.com/user-attachments/assets/2c761fc7-f975-4aa6-9f4f-d973088ffc3f" />
<img width="367" height="303" alt="8_connected_components" src="https://github.com/user-attachments/assets/fc4cbddd-8af4-4540-a4f7-46719837d0ac" />
<img width="367" height="303" alt="4_connected_components" src="https://github.com/user-attachments/assets/7d86a372-42c3-4419-8dcb-22ac3cbed7ea" />

