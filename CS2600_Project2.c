#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int addition(int c1[], int c2[], int e1[], int e2[], int final[], int numTerms1, int numTerms2) {
    for (int i = 0; i < numTerms1; i++) {
        final[e1[i]] = c1[i] + 0;
    }
    for (int i = 0; i < numTerms2; i++) {
        final[e2[i]] = c2[i] + 0;
    }
    for (int i = 0; i < numTerms1; i++) {    
        for (int j = 0; j < numTerms2; j++) {
            if (e1[i] == e2[j]) {
                final[e1[i]] = c1[i] + c2[i];
            }
        }
    }
    return 0;
}

int subtraction(int c1[], int c2[], int e1[], int e2[], int final[], int numTerms1, int numTerms2) {
    for (int i = 0; i < numTerms1; i++) {
        final[e1[i]] = c1[i] + 0;
    }
    for (int i = 0; i < numTerms2; i++) {
        final[e2[i]] = c2[i] + 0;
    }
    for (int i = 0; i < numTerms1; i++) {    
        for (int j = 0; j < numTerms2; j++) {
            if (e1[i] == e2[j]) {
                final[e1[i]] = c1[i] - c2[i];
            }
        }
    }
    return 0;
}

int main() {
    int numTerms1 = 0, numTerms2 = 0, numTermsF = 0, mode = 0, count = 0, True = 0;
mainn:
	printf("How many terms would you like the first polynomial to have?: ");
	scanf("%d", &numTerms1);
    
    int c1[numTerms1];
	int e1[numTerms1];

	for (int i = 0; i < numTerms1; i++) {
	    c1[i] = 0;
	    e1[i] =0;
	    printf("Enter the coefficient for term %d: ", i+1);
	    scanf("%d", &c1[i]);
	    printf("Enter the exponent for term %d: ", i+1);
	    scanf("%d", &e1[i]);
	}
	
	printf("\nHow many terms would you like the second polynomial to have?: ");
	scanf("%d", &numTerms2);
	
	int c2[numTerms2];
	int e2[numTerms2];
	for (int i = 0; i < numTerms2; i++) {
	    c2[i] = 0;
	    e2[i] =0;
	    printf("Enter the coefficient for term %d: ", i+1);
	    scanf("%d", &c2[i]);
	    printf("Enter the exponent for term %d: ", i+1);
	    scanf("%d", &e2[i]);
	}
	
	numTermsF = numTerms1+numTerms2;
	for (int i = 0; i < numTermsF; i++) {
        for (int j = 0; j <= i; j++) {
            if (e1[i] == e2[j]) {
                numTermsF--;
            }
        }
    }
    
	int final[numTermsF];
	
    printf("\nWhat would you like to do:\n1. Addition\n2. Subtraction\n3. Re-enter polynomials\n4. exit\n");
    scanf("%d", &mode);
    switch(mode) {
        case 1:
            addition(c1, c2, e1, e2, final, numTerms1, numTerms2);
            break;
        case 2:
            subtraction(c1, c2, e1, e2, final, numTerms1, numTerms2);
            break;
        case 3:
            goto mainn;
            exit(1);
        case 4:
            exit(1);
    }
    
    printf("Here is the resulting polynomial: ");
    int i;
    for (int i = 0; i <= numTermsF; i++) {
        if (final[i] != 0) {
            if (final[i] > 0 && True > 0) {
                printf("+ ");
            }
            printf("%dx^%d ", final[i], i);
            count++;
            True++;
        }
        else {
            count--;
        }
        
    }
    if (count == (-numTermsF-1)) {
            printf("0");
    }
    return 0;
}
