#include <cstdio>

__global__ void hello_kernel() {
    printf("Hello from GPU thread %d\n", threadIdx.x);
}

int main() {
    hello_kernel<<<1, 2048>>>();
    cudaDeviceSynchronize();
    return 0;
}