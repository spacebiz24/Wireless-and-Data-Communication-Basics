#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <conio.h>

void XOR(char *Message, char *Polynomial)
{
    for (int Index = 1; Index < strlen(Polynomial); Index++) // Zeroth XOR always results in 0
        Message[Index] = (Message[Index] == Polynomial[Index]) ? '0' : '1';
}

void CRC(char *Message, char Polynomial[])
{
    while (strlen(Message) >= strlen(Polynomial))
    {
        if (Message[0] == '1')
            XOR(Message, Polynomial);
        strcpy(Message, Message + 1); // remove the first char from message
    }
}

int main()
{
    // Setup
    char Polynomial[] = "10110";
    char Message[16];
    printf("Enter the Message to be transmitted: ");
    gets(Message);
    printf("Generating polynomial: %s\n", Polynomial);

    // Transmitter
    char Residue[16];
    CRC(strcat(strcpy(Residue, Message), "0000"), Polynomial);
    printf("Generated check sum: %s\n", Residue);
    printf("Transmitted message: %s\n", strcat(Message, Residue));

    // Channel
    printf("Do you want to introduce random bit-flips?(Y/n) ");
    char Answer = getchar();
    if (Answer == 'Y' || Answer == 'y')
    {
        int TotalBitFlips = (rand() % 5) + 1; // to prevent 0 condition
        for (int i = 1; i <= TotalBitFlips; i++)
        {
            int BitIndex = rand() % 13; // 16 bits of data
            Message[BitIndex] = Message[BitIndex] == '1' ? '0' : '1';
        }
    }

    // Receiver
    printf("Received message: %s\n", Message);
    CRC(strcpy(Residue, Message), Polynomial);
    if (!strcmp(Residue, "0000"))
        printf("The received message is intact\n");
    else
        printf("The received message has been corrupted\n");
    getch();
    return 0;
}
