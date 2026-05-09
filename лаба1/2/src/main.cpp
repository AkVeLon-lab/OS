#include <iostream>
#include <unistd.h>
#include <sys/wait.h> 
#include "fibonacci.h"

int main() {
    int fd[2];

    // Создаю pipe (канал для связи между процессами)
    if (pipe(fd) == -1) {
        std::cerr << "Pipe failed!" << std::endl;
        return 1;
    }

    pid_t pid = fork(); // Создаю дочерний процесс

    if (pid < 0) {
        std::cerr << "Fork failed!" << std::endl;
        return 1;
    }

    if (pid == 0) {
        // Дочерний процесс
        close(fd[0]); // Закрываю чтение (буду только писать)
        
        int number = 10;
        unsigned long long result = fibonacci(number);
        
        write(fd[1], &result, sizeof(result)); // Пишу результат в канал
        close(fd[1]); // Закрываю запись
        std::cout << "[Child] Calculated fibonacci and sent it to Parent." << std::endl;
        exit(0);
    } 
    else {
        // Родительский процесс
        close(fd[1]); // Закрываю запись (буду только читать)
        
        unsigned long long received_result = 0;
        
        wait(NULL); // Жду завершения дочернего процесса
        read(fd[0], &received_result, sizeof(received_result)); // Читаю результат
        close(fd[0]); // Закрываю чтение
        
        std::cout << "[Parent] Received result from child: " << received_result << std::endl;
    }

    return 0;
}