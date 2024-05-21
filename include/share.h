#ifndef SHARE_H
#define SHARE_H

#define SHARE_DIR PREFIX "/share/RNAVIEW/BASEPARS/"

FILE* check_open(char *filename, char* err);
char* get_data_file(char *filename);
FILE* open_data_file(char *filename, char* err);

#endif
