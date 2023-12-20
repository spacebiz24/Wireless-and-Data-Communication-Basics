// Character stuffing and de-stuffing of a single frame of data

#include <stdio.h>
#include <string.h>
#include <conio.h>

#define DLE 16
#define STX 2
#define ETX 3

char Preamble[] = {DLE, STX}, Postamble[] = {DLE, ETX};
char stuffedData[50], deStuffedData[50];
int length;

void displayData(char CurrChar)
{
    switch (CurrChar)
    {
    case DLE:
        printf("DLE");
        break;
    case STX:
        printf("STX");
        break;
    case ETX:
        printf("ETX");
        break;
    default:
        printf("%c", CurrChar);
    }
}

void stuffData()
{
    char inputCharacter;
    length = 2;
    strcat(stuffedData, Preamble);
    printf("\nEnter the data stream:\n");
    printf("CTRL+P -> DLE\nCTRL+B -> STX\nCTRL+C -> ETX\n");
    while ((inputCharacter = getch()) != '\r')
    {
        displayData(inputCharacter);
        if (inputCharacter == DLE)
            stuffedData[length++] = DLE;
        stuffedData[length++] = inputCharacter;
    }
    strcat(stuffedData, Postamble);
    printf("\nCharacter Stuffed Stream:\n");
    for (int i = 0; i < strlen(stuffedData); i++)
        displayData(stuffedData[i]);
}

void destuffData()
{
    length = 0;
    for (int i = 2; i < strlen(stuffedData) - 2; i++)
    {
        if (stuffedData[i] == DLE)
            i++;
        deStuffedData[length++] = stuffedData[i];
    }
    printf("\nDe-Stuffed Stream:\n");
    for (int i = 0; i < strlen(deStuffedData); i++)
        displayData(deStuffedData[i]);
}

void main()
{
    stuffData();
    destuffData();
    printf("\nPress a key to exit");
    getch();
}
