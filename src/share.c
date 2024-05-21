#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "share.h"

FILE *check_open(char *filename, char *error) {
  FILE *fp = fopen(filename, "r");
    if (fp == NULL)
    {
      printf("Cannot open file: %s (%s)", filename, error);
      exit(1);
    }
    return fp;
}


char PATH_BUFFER[512];

/* Check if the file is in the current directory.
 */
int get_local_data_file(char *filename) {
  strcpy(PATH_BUFFER, "./");
  strcat(PATH_BUFFER, filename);
  FILE *fp = fopen(PATH_BUFFER, "r");
  return (fp != NULL);
}

void get_default_data_file(char *filename) {
  strcpy(PATH_BUFFER, SHARE_DIR);
  strcat(PATH_BUFFER, filename);
}


/* Get the path to a data file using the following order of precedence:
 *
 *  1. If the file is in the current directory, return its path.
 *  2. If the file is in the installation prefix path
 *        (default:  /usr/local/share/RNAVIEW/BASEPARS)
 */
char* get_data_file(char *filename) {
  if (get_local_data_file(filename)) {
    return PATH_BUFFER;
  }

  get_default_data_file(filename);
  return PATH_BUFFER;
}

FILE *open_data_file(char *filename, char *err) {
  return check_open(get_data_file(filename), err);
}
