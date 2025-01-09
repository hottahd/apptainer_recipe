#include <cuda_runtime.h>
#include <stdio.h>

int main() {
    int deviceCount;
    cudaError_t err = cudaGetDeviceCount(&deviceCount);

    if (err != cudaSuccess) {
        printf("CUDA error: %s\n", cudaGetErrorString(err));
        return -1;
    }

    if (deviceCount == 0) {
        printf("No CUDA-capable devices found.\n");
    } else {
        printf("CUDA-capable devices found: %d\n", deviceCount);

        for (int i = 0; i < deviceCount; i++) {
            cudaDeviceProp prop;
            cudaGetDeviceProperties(&prop, i);

            printf("Device %d: %s\n", i, prop.name);
            printf("  Total Global Memory: %lu bytes\n", prop.totalGlobalMem);
            printf("  Multiprocessors: %d\n", prop.multiProcessorCount);
            printf("  CUDA Cores (estimated): %d\n", prop.multiProcessorCount * 128);
        }
    }

    cudaDeviceProp prop;
    cudaGetDeviceProperties(&prop, 0);
    printf("Max threads per block: %d\n", prop.maxThreadsPerBlock);
    printf("Warp size: %d\n", prop.warpSize);
    printf("Max threads per SM: %d\n", prop.maxThreadsPerMultiProcessor);

    return 0;
}