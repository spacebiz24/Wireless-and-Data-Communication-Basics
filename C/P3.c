// Character stuffing and de-stuffing of a single frame of data

#include <stdio.h>
#include <string.h>
#include <conio.h>

#define DLE 16
#define STX 2
#define ETX 3

char inputCharacter, stuffedData[50], deStuffedData[50];
char Preamble[] = {DLE, STX}, Postamble[] = {DLE, ETX};
int length = 2;

void stuffData()
{
    printf("\nEnter the data stream:\n");
    printf("CTRL+P -> DLE\nCTRL+B -> STX\nCTRL+C -> ETX\n");
    strcat(stuffedData, Preamble);
    while ((inputCharacter = getche()) != '\r')
    {
        if (inputCharacter == DLE)
            stuffedData[length++] = DLE;
        stuffedData[length++] = inputCharacter;
    }
    strcat(stuffedData, Postamble);
    printf("\nCharacter Stuffed Stream:\n");
    for (int i = 0; i < length + 2; i++)
        printf("%c", stuffedData[i]);
}

void destuffData()
{
    printf("\nDe-Stuffed Stream:\n");
    for (int j = 2, k = 0; j, k < length; j++, k++)
    {
        if (stuffedData[j] == DLE)
            j++;
        deStuffedData[k] = stuffedData[j];
    }
    for (int i = 0; i < length - 2; i++)
        printf("%c", deStuffedData[i]);
}

void main()
{
    stuffData();
    destuffData();
    printf("Press a key to exit");
    getch();
}
