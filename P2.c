#include <stdio.h>
#include <conio.h>
#include <string.h>

char stuffedData[50] = {"01111110"}, deStuffedData[50], character;
int length = 8, count = 0;

void stuffData()
{
    printf("\nEnter the Data:\n"); // Add data to the string after the preamble
    while ((character = getche()) != '\r')
    {
        if (character == '1')
            count++;
        else
            count = 0;
        stuffedData[length++] = character;
        if (count == 5)
        {
            stuffedData[length++] = '0'; // Check if five consecutive1's exist in the data and add a 0 after that
            count = 0;
        }
    }
    strcat(stuffedData, "01111110"); // Add the postamble
    printf("\nBit Stuffed Stream:\n");
    for (int i = 0; i < length + 8; i++)
        printf("%c", stuffedData[i]);
}

void destuffData()
{
    count = 0;
    printf("\nDe-Stuffed Stream:\n");
    for (int j = 8, k = 0; j < length; j++)
    {
        if (stuffedData[j] == '1')
            count++;
        else
            count = 0;
        deStuffedData[k++] = stuffedData[j];
        if (count == 5 && stuffedData[j + 1] == '0') // Remove the zero added after five 1's to get back the original data
        {
            j++;
            count = 0;
        }
    }
    for (int j = 0; j < length - 8; j++)
        printf("%c", deStuffedData[j]);
}

void main()
{
    stuffData();
    destuffData();
}
