#include <unistd.h>
#include <fcntl.h>
#include <iostream>

int main()
{   close(1);
    int fd = open("build/file.txt",O_CREAT | O_WRONLY | O_EXCL,0664);
    std::cout << "something" << std::endl;
    close(fd);
    return 0;
}

