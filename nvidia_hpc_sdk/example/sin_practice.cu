#include <cstdio>
#include <cmath>

__global__ void fill_sin_kernel(double *data, double *x, int N) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < N) {
        data[idx] = (sin(x[idx + 1]) - sin(x[idx - 1]))/(x[idx + 1] - x[idx - 1]);
    }
}

int main() {
    const int N = 1024;
    const double xmax = 2.0 * M_PI;
    const double dx = xmax / N;

    // geometry
    double *d_x = nullptr;
    double *h_x = new double[N];

    for (int i = 0; i < N; ++i) {
        h_x[i] = i * dx;
    };
    
    // data
    double *d_data = nullptr;
    double *h_data = new double[N];

    cudaMalloc(&d_x   , N * sizeof(double));
    cudaMalloc(&d_data, N * sizeof(double));

    int threadsPerBlock = 256;
    int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;

    cudaMemcpy(d_x, h_x   , N * sizeof(double), cudaMemcpyHostToDevice);
    fill_sin_kernel<<<blocksPerGrid, threadsPerBlock>>>(d_data, d_x, N);
    cudaDeviceSynchronize();
    cudaMemcpy(h_data, d_data, N * sizeof(double), cudaMemcpyDeviceToHost);

    printf("First 10 values of sin(x):\n");
    for (int i = 0; i < 1024; i++ ) {
        printf("%d, cos: %.6f, cos:%.6f\n", i, cos(h_x[i]), h_data[i]);
    }

    cudaFree(d_data);
    delete[] h_data;

    return 0;
}   