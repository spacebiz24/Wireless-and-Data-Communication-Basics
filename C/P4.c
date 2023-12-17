// Encryption and decryption of a text using Caesar Cipher

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <conio.h>

char Message[50];
int Shift;

void encrypt()
{
    printf("Enter Encryption Key: ");
    scanf("%d", &Shift);
    Shift %= 26;
    for (int i = 0; i < strlen(Message); i++)
        if (isalpha(Message[i]))
            for (int j = 0; j < Shift; j++)
            {
                if (Message[i] == 'Z')
                    Message[i] = 'A';
                else
                    Message[i]++;
            }
    printf("Scrambled text: %s\n", Message);
}

void decrypt()
{
    printf("Enter Decryption Key: ");
    scanf("%d", &Shift);
    Shift %= 26;
    for (int i = 0; i < strlen(Message); i++)
        if (isalpha(Message[i]))
            for (int j = 0; j < Shift; j++)
            {
                if (Message[i] == 'A') 
                    Message[i] = 'Z';
                else
                    Message[i]--;
            }
    printf("Decrypted Message: %s\n", Message);
}

void main()
{
    printf("Enter the Message: ");
    strupr(gets(Message));
    encrypt();
    decrypt();
    printf("Press a key to exit");
    getch();
}
