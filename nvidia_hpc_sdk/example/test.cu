#include <stdio.h>
#include <cuda_runtime.h>

// CUDAカーネル: 配列aとbを足し合わせて結果を配列cに格納
__global__ void add_arrays(const float *a, const float *b, float *c, int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x; // グローバルインデックス
    if (idx < n) {
        c[idx] = a[idx] + b[idx];
    }
}

int main() {
    int n = 1024; // 配列のサイズ
    size_t size = n * sizeof(float);

    // ホストメモリの確保
    float *h_a = (float *)malloc(size);
    float *h_b = (float *)malloc(size);
    float *h_c = (float *)malloc(size);

    // デバイスメモリのポインタ
    float *d_a, *d_b, *d_c;

    // デバイスメモリの確保
    cudaMalloc((void **)&d_a, size);
    cudaMalloc((void **)&d_b, size);
    cudaMalloc((void **)&d_c, size);

    // ホスト配列を初期化
    for (int i = 0; i < n; i++) {
        h_a[i] = i * 1.0f;
        h_b[i] = i * 2.0f;
    }

    // ホストメモリからデバイスメモリへコピー
    cudaMemcpy(d_a, h_a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, size, cudaMemcpyHostToDevice);

    // ブロックとグリッドのサイズを設定
    int blockSize = 256;
    int gridSize = (n + blockSize - 1) / blockSize; // nをブロックサイズで割り切る

    // カーネルの呼び出し
    add_arrays<<<gridSize, blockSize>>>(d_a, d_b, d_c, n);

    // デバイスメモリからホストメモリへ結果をコピー
    cudaMemcpy(h_c, d_c, size, cudaMemcpyDeviceToHost);

    // 結果の表示
    printf("Result:\n");
    for (int i = 0; i < 10; i++) { // 最初の10個を表示
        printf("h_c[%d] = %f\n", i, h_c[i]);
    }

    // メモリの解放
    free(h_a);
    free(h_b);
    free(h_c);
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}