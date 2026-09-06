// REQUIRES: amdgpu-registered-target
// RUN: %clang_cc1 -triple amdgpu11.00-amd-amdhsa -x hip -std=c++11 -fclangir \
// RUN: -fcuda-is-device -emit-cir %s -o %t.cir
// RUN: FileCheck --check-prefix=CIR --input-file=%t.cir %s

// RUN: %clang_cc1 -triple amdgpu11.00-amd-amdhsa -x hip -std=c++11 -fclangir \
// RUN: -fcuda-is-device -emit-llvm %s -o %t-cir.ll
// RUN: FileCheck --check-prefix=LLVM --input-file=%t-cir.ll %s

// RUN: %clang_cc1 -triple amdgpu11.00-amd-amdhsa -x hip -std=c++11 \
// RUN: -fcuda-is-device -emit-llvm %s -o %t.ll
// RUN: FileCheck --check-prefix=LLVM --input-file=%t.ll %s

#define __device__ __attribute__((device))

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
typedef unsigned int v2u32 __attribute__((ext_vector_type(2)));
typedef unsigned int v4u32 __attribute__((ext_vector_type(4)));

// CIR-LABEL: @_Z35test_amdgcn_raw_ptr_buffer_store_b8
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!u8i, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z35test_amdgcn_raw_ptr_buffer_store_b8hu22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.i8(i8 %{{.*}}, ptr addrspace(8) %{{.*}}, i32 0, i32 0, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b8(
    u8 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b8(vdata, rsrc, /*offset=*/0,
                                       /*soffset=*/0, /*aux=*/0);
}

// CIR-LABEL: @_Z36test_amdgcn_raw_ptr_buffer_store_b16
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!u16i, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z36test_amdgcn_raw_ptr_buffer_store_b16tu22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.i16(i16 %{{.*}}, ptr addrspace(8) %{{.*}}, i32 0, i32 0, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b16(
    u16 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b16(vdata, rsrc, /*offset=*/0,
                                        /*soffset=*/0, /*aux=*/0);
}

// CIR-LABEL: @_Z36test_amdgcn_raw_ptr_buffer_store_b32
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!u32i, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z36test_amdgcn_raw_ptr_buffer_store_b32ju22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.i32(i32 %{{.*}}, ptr addrspace(8) %{{.*}}, i32 0, i32 0, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b32(
    u32 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b32(vdata, rsrc, /*offset=*/0,
                                        /*soffset=*/0, /*aux=*/0);
}

// CIR-LABEL: @_Z36test_amdgcn_raw_ptr_buffer_store_b64
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!cir.vector<2 x !u32i>, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z36test_amdgcn_raw_ptr_buffer_store_b64Dv2_ju22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.v2i32(<2 x i32> %{{.*}}, ptr addrspace(8) %{{.*}}, i32 0, i32 0, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b64(
    v2u32 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b64(vdata, rsrc, /*offset=*/0,
                                        /*soffset=*/0, /*aux=*/0);
}

// CIR-LABEL: @_Z37test_amdgcn_raw_ptr_buffer_store_b128
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!cir.vector<4 x !u32i>, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z37test_amdgcn_raw_ptr_buffer_store_b128Dv4_ju22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.v4i32(<4 x i32> %{{.*}}, ptr addrspace(8) %{{.*}}, i32 0, i32 0, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b128(
    v4u32 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b128(vdata, rsrc, /*offset=*/0,
                                         /*soffset=*/0, /*aux=*/0);
}

// CIR-LABEL: @_Z52test_amdgcn_raw_ptr_buffer_store_b8_non_const_offset
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!u8i, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z52test_amdgcn_raw_ptr_buffer_store_b8_non_const_offsethu22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.i8(i8 %{{.*}}, ptr addrspace(8) %{{.*}}, i32 %{{.*}}, i32 0, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b8_non_const_offset(
    u8 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b8(vdata, rsrc, offset,
                                       /*soffset=*/0, /*aux=*/0);
}

// CIR-LABEL: @_Z53test_amdgcn_raw_ptr_buffer_store_b16_non_const_offset
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!u16i, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z53test_amdgcn_raw_ptr_buffer_store_b16_non_const_offsettu22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.i16(i16 %{{.*}}, ptr addrspace(8) %{{.*}}, i32 %{{.*}}, i32 0, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b16_non_const_offset(
    u16 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b16(vdata, rsrc, offset,
                                        /*soffset=*/0, /*aux=*/0);
}

// CIR-LABEL: @_Z53test_amdgcn_raw_ptr_buffer_store_b32_non_const_offset
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!u32i, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z53test_amdgcn_raw_ptr_buffer_store_b32_non_const_offsetju22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.i32(i32 %{{.*}}, ptr addrspace(8) %{{.*}}, i32 %{{.*}}, i32 0, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b32_non_const_offset(
    u32 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b32(vdata, rsrc, offset,
                                        /*soffset=*/0, /*aux=*/0);
}

// CIR-LABEL: @_Z53test_amdgcn_raw_ptr_buffer_store_b64_non_const_offset
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!cir.vector<2 x !u32i>, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z53test_amdgcn_raw_ptr_buffer_store_b64_non_const_offsetDv2_ju22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.v2i32(<2 x i32> %{{.*}}, ptr addrspace(8) %{{.*}}, i32 %{{.*}}, i32 0, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b64_non_const_offset(
    v2u32 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b64(vdata, rsrc, offset,
                                        /*soffset=*/0, /*aux=*/0);
}

// CIR-LABEL: @_Z54test_amdgcn_raw_ptr_buffer_store_b128_non_const_offset
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!cir.vector<4 x !u32i>, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z54test_amdgcn_raw_ptr_buffer_store_b128_non_const_offsetDv4_ju22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.v4i32(<4 x i32> %{{.*}}, ptr addrspace(8) %{{.*}}, i32 %{{.*}}, i32 0, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b128_non_const_offset(
    v4u32 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b128(vdata, rsrc, offset,
                                         /*soffset=*/0, /*aux=*/0);
}

// CIR-LABEL: @_Z53test_amdgcn_raw_ptr_buffer_store_b8_non_const_soffset
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!u8i, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z53test_amdgcn_raw_ptr_buffer_store_b8_non_const_soffsethu22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.i8(i8 %{{.*}}, ptr addrspace(8) %{{.*}}, i32 0, i32 %{{.*}}, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b8_non_const_soffset(
    u8 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b8(vdata, rsrc, /*offset=*/0,
                                       soffset, /*aux=*/0);
}

// CIR-LABEL: @_Z54test_amdgcn_raw_ptr_buffer_store_b16_non_const_soffset
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!u16i, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z54test_amdgcn_raw_ptr_buffer_store_b16_non_const_soffsettu22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.i16(i16 %{{.*}}, ptr addrspace(8) %{{.*}}, i32 0, i32 %{{.*}}, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b16_non_const_soffset(
    u16 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b16(vdata, rsrc, /*offset=*/0,
                                        soffset, /*aux=*/0);
}

// CIR-LABEL: @_Z54test_amdgcn_raw_ptr_buffer_store_b32_non_const_soffset
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!u32i, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z54test_amdgcn_raw_ptr_buffer_store_b32_non_const_soffsetju22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.i32(i32 %{{.*}}, ptr addrspace(8) %{{.*}}, i32 0, i32 %{{.*}}, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b32_non_const_soffset(
    u32 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b32(vdata, rsrc, /*offset=*/0,
                                        soffset, /*aux=*/0);
}

// CIR-LABEL: @_Z54test_amdgcn_raw_ptr_buffer_store_b64_non_const_soffset
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!cir.vector<2 x !u32i>, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z54test_amdgcn_raw_ptr_buffer_store_b64_non_const_soffsetDv2_ju22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.v2i32(<2 x i32> %{{.*}}, ptr addrspace(8) %{{.*}}, i32 0, i32 %{{.*}}, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b64_non_const_soffset(
    v2u32 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b64(vdata, rsrc, /*offset=*/0,
                                        soffset, /*aux=*/0);
}

// CIR-LABEL: @_Z55test_amdgcn_raw_ptr_buffer_store_b128_non_const_soffset
// CIR: cir.call_llvm_intrinsic "amdgcn.raw.ptr.buffer.store" {{.*}} : (!cir.vector<4 x !u32i>, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z55test_amdgcn_raw_ptr_buffer_store_b128_non_const_soffsetDv4_ju22__amdgpu_buffer_rsrc_tii
// LLVM: call void @llvm.amdgcn.raw.ptr.buffer.store.v4i32(<4 x i32> %{{.*}}, ptr addrspace(8) %{{.*}}, i32 0, i32 %{{.*}}, i32 0)
__device__ void test_amdgcn_raw_ptr_buffer_store_b128_non_const_soffset(
    v4u32 vdata, __amdgpu_buffer_rsrc_t rsrc, int offset, int soffset) {
  __builtin_amdgcn_raw_buffer_store_b128(vdata, rsrc, /*offset=*/0,
                                         soffset, /*aux=*/0);
}

