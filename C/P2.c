// Bit stuffing and de-stuffing of a single frame of data

#include <stdio.h>
#include <string.h>
#include <conio.h>

char flag[] = "01111110", stuffedData[50], deStuffedData[50]; // put vars in main later
int length, count;

void stuffData()
{
    char inputCharacter;
    length = 8;
    count = 0;
    strcat(stuffedData, flag);
    printf("\nEnter the Data:\n"); // Add data to the string after the preamble
    while ((inputCharacter = getche()) != '\r')
    {
        if (inputCharacter == '1')
            count++;
        else
            count = 0;
        stuffedData[length++] = inputCharacter;
        if (count == 5)
        {
            stuffedData[length++] = '0'; // Check if five consecutive 1's exist in the data and add a 0 after that
            count = 0;
        }
    }
    strcat(stuffedData, flag); // Add the postamble
    printf("\n\nBit Stuffed Stream:\n");
    printf("%s\n", stuffedData);
}

void destuffData()
{
    length = 0;
    count = 0;
    for (int i = 8; i < strlen(stuffedData) - 8; i++)
    {
        if (stuffedData[i] == '1')
            count++;
        else
            count = 0;
        deStuffedData[length++] = stuffedData[i];
        if (count == 5) // Remove the zero added after five 1's to get back the original data
        {
            i++;
            count = 0;
        }
    }
    printf("\nDe-Stuffed Stream:\n");
    printf("%s\n", deStuffedData);
}

void main()
{
    stuffData();
    destuffData();
    printf("\nPress a key to exit");
    getch();
}
