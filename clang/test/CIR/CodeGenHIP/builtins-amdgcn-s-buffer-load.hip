// REQUIRES: amdgpu-registered-target
// RUN: %clang_cc1 -triple amdgpu6.01-amd-amdhsa -x hip -std=c++11 -fclangir \
// RUN:            -fcuda-is-device -emit-cir %s -o %t.cir
// RUN: FileCheck --check-prefix=CIR --input-file=%t.cir %s

// RUN: %clang_cc1 -triple amdgpu6.01-amd-amdhsa -x hip -std=c++11 -fclangir \
// RUN:            -fcuda-is-device -emit-llvm %s -o %t.ll
// RUN: FileCheck --check-prefix=LLVM --input-file=%t.ll %s

// RUN: %clang_cc1 -triple amdgpu6.01-amd-amdhsa -x hip -std=c++11 \
// RUN:            -fcuda-is-device -emit-llvm %s -o %t.ll
// RUN: FileCheck --check-prefix=LLVM --input-file=%t.ll %s

// FIXME: CIR doesn't propagate the 'contract' fast-math flag to LLVM IR
// calls yet, so LLVM check lines use {{.*}} to tolerate the difference
// between CIR (no flags) and classic codegen ('contract').

#define __device__ __attribute__((device))

typedef int v2i32 __attribute__((ext_vector_type(2)));
typedef int v3i32 __attribute__((ext_vector_type(3)));
typedef int v4i32 __attribute__((ext_vector_type(4)));
typedef int v8i32 __attribute__((ext_vector_type(8)));
typedef int v16i32 __attribute__((ext_vector_type(16)));
typedef float v2f32 __attribute__((ext_vector_type(2)));
typedef float v3f32 __attribute__((ext_vector_type(3)));
typedef float v4f32 __attribute__((ext_vector_type(4)));
typedef float v8f32 __attribute__((ext_vector_type(8)));
typedef float v16f32 __attribute__((ext_vector_type(16)));
typedef char v2i8 __attribute__((ext_vector_type(2)));
typedef char v3i8 __attribute__((ext_vector_type(3)));
typedef char v4i8 __attribute__((ext_vector_type(4)));
typedef _Float16 v2f16 __attribute__((ext_vector_type(2)));
typedef _Float16 v3f16 __attribute__((ext_vector_type(3)));
typedef _Float16 v4f16 __attribute__((ext_vector_type(4)));

// CIR-LABEL: @_Z29test_amdgcn_s_buffer_load_i32u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !s32i
// LLVM-LABEL: @_Z29test_amdgcn_s_buffer_load_i32u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} i32 @llvm.amdgcn.ptr.s.buffer.load.i32({{.*}}), !invariant.load
__device__ int test_amdgcn_s_buffer_load_i32(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_i32(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z31test_amdgcn_s_buffer_load_v2i32u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<2 x !s32i>
// LLVM-LABEL: @_Z31test_amdgcn_s_buffer_load_v2i32u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <2 x i32> @llvm.amdgcn.ptr.s.buffer.load.v2i32({{.*}}), !invariant.load
__device__ v2i32 test_amdgcn_s_buffer_load_v2i32(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v2i32(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z31test_amdgcn_s_buffer_load_v3i32u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<3 x !s32i>
// LLVM-LABEL: @_Z31test_amdgcn_s_buffer_load_v3i32u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <3 x i32> @llvm.amdgcn.ptr.s.buffer.load.v3i32({{.*}}), !invariant.load
__device__ v3i32 test_amdgcn_s_buffer_load_v3i32(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v3i32(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z31test_amdgcn_s_buffer_load_v4i32u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<4 x !s32i>
// LLVM-LABEL: @_Z31test_amdgcn_s_buffer_load_v4i32u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <4 x i32> @llvm.amdgcn.ptr.s.buffer.load.v4i32({{.*}}), !invariant.load
__device__ v4i32 test_amdgcn_s_buffer_load_v4i32(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v4i32(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z31test_amdgcn_s_buffer_load_v8i32u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<8 x !s32i>
// LLVM-LABEL: @_Z31test_amdgcn_s_buffer_load_v8i32u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <8 x i32> @llvm.amdgcn.ptr.s.buffer.load.v8i32({{.*}}), !invariant.load
__device__ v8i32 test_amdgcn_s_buffer_load_v8i32(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v8i32(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z32test_amdgcn_s_buffer_load_v16i32u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<16 x !s32i>
// LLVM-LABEL: @_Z32test_amdgcn_s_buffer_load_v16i32u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <16 x i32> @llvm.amdgcn.ptr.s.buffer.load.v16i32({{.*}}), !invariant.load
__device__ v16i32 test_amdgcn_s_buffer_load_v16i32(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v16i32(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z29test_amdgcn_s_buffer_load_f32u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.float
// LLVM-LABEL: @_Z29test_amdgcn_s_buffer_load_f32u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} float @llvm.amdgcn.ptr.s.buffer.load.f32({{.*}}), !invariant.load
__device__ float test_amdgcn_s_buffer_load_f32(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_f32(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z31test_amdgcn_s_buffer_load_v2f32u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<2 x !cir.float>
// LLVM-LABEL: @_Z31test_amdgcn_s_buffer_load_v2f32u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <2 x float> @llvm.amdgcn.ptr.s.buffer.load.v2f32({{.*}}), !invariant.load
__device__ v2f32 test_amdgcn_s_buffer_load_v2f32(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v2f32(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z31test_amdgcn_s_buffer_load_v3f32u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<3 x !cir.float>
// LLVM-LABEL: @_Z31test_amdgcn_s_buffer_load_v3f32u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <3 x float> @llvm.amdgcn.ptr.s.buffer.load.v3f32({{.*}}), !invariant.load
__device__ v3f32 test_amdgcn_s_buffer_load_v3f32(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v3f32(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z31test_amdgcn_s_buffer_load_v4f32u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<4 x !cir.float>
// LLVM-LABEL: @_Z31test_amdgcn_s_buffer_load_v4f32u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <4 x float> @llvm.amdgcn.ptr.s.buffer.load.v4f32({{.*}}), !invariant.load
__device__ v4f32 test_amdgcn_s_buffer_load_v4f32(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v4f32(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z31test_amdgcn_s_buffer_load_v8f32u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<8 x !cir.float>
// LLVM-LABEL: @_Z31test_amdgcn_s_buffer_load_v8f32u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <8 x float> @llvm.amdgcn.ptr.s.buffer.load.v8f32({{.*}}), !invariant.load
__device__ v8f32 test_amdgcn_s_buffer_load_v8f32(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v8f32(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z32test_amdgcn_s_buffer_load_v16f32u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<16 x !cir.float>
// LLVM-LABEL: @_Z32test_amdgcn_s_buffer_load_v16f32u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <16 x float> @llvm.amdgcn.ptr.s.buffer.load.v16f32({{.*}}), !invariant.load
__device__ v16f32 test_amdgcn_s_buffer_load_v16f32(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v16f32(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z28test_amdgcn_s_buffer_load_i8u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !s8i
// LLVM-LABEL: @_Z28test_amdgcn_s_buffer_load_i8u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} i8 @llvm.amdgcn.ptr.s.buffer.load.i8({{.*}}), !invariant.load
__device__ char test_amdgcn_s_buffer_load_i8(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_i8(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z28test_amdgcn_s_buffer_load_u8u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !u8i
// LLVM-LABEL: @_Z28test_amdgcn_s_buffer_load_u8u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} i8 @llvm.amdgcn.ptr.s.buffer.load.i8({{.*}}), !invariant.load
__device__ unsigned char test_amdgcn_s_buffer_load_u8(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_u8(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z29test_amdgcn_s_buffer_load_i16u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !s16i
// LLVM-LABEL: @_Z29test_amdgcn_s_buffer_load_i16u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} i16 @llvm.amdgcn.ptr.s.buffer.load.i16({{.*}}), !invariant.load
__device__ short test_amdgcn_s_buffer_load_i16(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_i16(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z29test_amdgcn_s_buffer_load_u16u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !u16i
// LLVM-LABEL: @_Z29test_amdgcn_s_buffer_load_u16u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} i16 @llvm.amdgcn.ptr.s.buffer.load.i16({{.*}}), !invariant.load
__device__ unsigned short test_amdgcn_s_buffer_load_u16(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_u16(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z30test_amdgcn_s_buffer_load_v2i8u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<2 x !s8i>
// LLVM-LABEL: @_Z30test_amdgcn_s_buffer_load_v2i8u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <2 x i8> @llvm.amdgcn.ptr.s.buffer.load.v2i8({{.*}}), !invariant.load
__device__ v2i8 test_amdgcn_s_buffer_load_v2i8(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v2i8(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z30test_amdgcn_s_buffer_load_v3i8u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<3 x !s8i>
// LLVM-LABEL: @_Z30test_amdgcn_s_buffer_load_v3i8u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <3 x i8> @llvm.amdgcn.ptr.s.buffer.load.v3i8({{.*}}), !invariant.load
__device__ v3i8 test_amdgcn_s_buffer_load_v3i8(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v3i8(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z30test_amdgcn_s_buffer_load_v4i8u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<4 x !s8i>
// LLVM-LABEL: @_Z30test_amdgcn_s_buffer_load_v4i8u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <4 x i8> @llvm.amdgcn.ptr.s.buffer.load.v4i8({{.*}}), !invariant.load
__device__ v4i8 test_amdgcn_s_buffer_load_v4i8(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v4i8(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z29test_amdgcn_s_buffer_load_f16u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.f16
// LLVM-LABEL: @_Z29test_amdgcn_s_buffer_load_f16u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} half @llvm.amdgcn.ptr.s.buffer.load.f16({{.*}}), !invariant.load
__device__ _Float16 test_amdgcn_s_buffer_load_f16(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_f16(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z31test_amdgcn_s_buffer_load_v2f16u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<2 x !cir.f16>
// LLVM-LABEL: @_Z31test_amdgcn_s_buffer_load_v2f16u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <2 x half> @llvm.amdgcn.ptr.s.buffer.load.v2f16({{.*}}), !invariant.load
__device__ v2f16 test_amdgcn_s_buffer_load_v2f16(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v2f16(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z31test_amdgcn_s_buffer_load_v3f16u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<3 x !cir.f16>
// LLVM-LABEL: @_Z31test_amdgcn_s_buffer_load_v3f16u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <3 x half> @llvm.amdgcn.ptr.s.buffer.load.v3f16({{.*}}), !invariant.load
__device__ v3f16 test_amdgcn_s_buffer_load_v3f16(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v3f16(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z31test_amdgcn_s_buffer_load_v4f16u22__amdgpu_buffer_rsrc_t
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !cir.vector<4 x !cir.f16>
// LLVM-LABEL: @_Z31test_amdgcn_s_buffer_load_v4f16u22__amdgpu_buffer_rsrc_t(
// LLVM: call{{.*}} <4 x half> @llvm.amdgcn.ptr.s.buffer.load.v4f16({{.*}}), !invariant.load
__device__ v4f16 test_amdgcn_s_buffer_load_v4f16(__amdgpu_buffer_rsrc_t rsrc) {
  return __builtin_amdgcn_s_buffer_load_v4f16(rsrc, 0, /*aux=*/0);
}

// CIR-LABEL: @_Z46test_amdgcn_s_buffer_load_i32_non_const_offsetu22__amdgpu_buffer_rsrc_ti
// CIR: cir.call_llvm_intrinsic "amdgcn.ptr.s.buffer.load" invariant {{.*}} -> !s32i
// LLVM-LABEL: @_Z46test_amdgcn_s_buffer_load_i32_non_const_offsetu22__amdgpu_buffer_rsrc_ti(
// LLVM: call{{.*}} i32 @llvm.amdgcn.ptr.s.buffer.load.i32({{.*}}), !invariant.load
__device__ int test_amdgcn_s_buffer_load_i32_non_const_offset(__amdgpu_buffer_rsrc_t rsrc, int offset) {
  return __builtin_amdgcn_s_buffer_load_i32(rsrc, offset, /*aux=*/0);
}

