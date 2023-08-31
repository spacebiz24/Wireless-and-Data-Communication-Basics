#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <conio.h>

void main()
{
    // Setup
    char Message[50];
    short int Shift;
    printf("Enter a string of letters: ");
    strupr(gets(Message));

    // Encryption
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

    // Decryption
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
    printf("Original Message: %s\n", Message);
    printf("Press a key to exit");
    getch();
}
