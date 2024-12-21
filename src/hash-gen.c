#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <openssl/evp.h>
#include <openssl/sha.h>
#include <openssl/md5.h>

void compute_hash(const char *input, const char *hash_type) {
    unsigned char hash[EVP_MAX_MD_SIZE];  
    unsigned int length = 0;
    const EVP_MD *md;  

    if (strcmp(hash_type, "SHA256") == 0) {
        md = EVP_sha256();
        length = SHA256_DIGEST_LENGTH;  
    } else if (strcmp(hash_type, "MD5") == 0) {
        md = EVP_md5();
        length = MD5_DIGEST_LENGTH;  
    } else {
        fprintf(stderr, "Unsupported hash type: %s\n", hash_type);
        return;
    }

    EVP_MD_CTX *ctx = EVP_MD_CTX_new();
    if (ctx == NULL) {
        fprintf(stderr, "Error initializing the digest context\n");
        return;
    }

    if (!EVP_DigestInit_ex(ctx, md, NULL)) {
        fprintf(stderr, "Error initializing the hash function\n");
        EVP_MD_CTX_free(ctx);
        return;
    }

    if (!EVP_DigestUpdate(ctx, input, strlen(input))) {
        fprintf(stderr, "Error updating the hash with input data\n");
        EVP_MD_CTX_free(ctx);
        return;
    }

    if (!EVP_DigestFinal_ex(ctx, hash, &length)) {
        fprintf(stderr, "Error finalizing the hash\n");
        EVP_MD_CTX_free(ctx);
        return;
    }

    EVP_MD_CTX_free(ctx);

    printf("%s hash of '%s':\n", hash_type, input);
    for (unsigned int i = 0; i < length; i++) {
        printf("%02x", hash[i]);
    }
    printf("\n");
}

int main() {
    char input[256];     
    char hash_type[10];  

    printf("Enter the string to hash: ");
    fgets(input, sizeof(input), stdin);
    input[strcspn(input, "\n")] = 0;  

    printf("Enter hash type (SHA256/MD5): ");
    scanf("%9s", hash_type);

    compute_hash(input, hash_type);

    return 0;
}

