#include <iostream>
using namespace std;


unsigned long long fibonacci(int n) {
    if (n <= 1) {
        return n;
    } else {
        return fibonacci(n - 1) + fibonacci(n - 2);
    }
}

int main(){
    int num = 6;
    cout << num << ": " << fibonacci(num);
}