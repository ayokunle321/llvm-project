// REQUIRES: amdgpu-registered-target
// RUN: %clang_cc1 -triple amdgpu8.03-amd-amdhsa -x hip -std=c++11 -O1 -fclangir \
// RUN:            -fcuda-is-device -emit-cir %s -o %t.cir
// RUN: FileCheck --check-prefix=CIR --input-file=%t.cir %s

// RUN: %clang_cc1 -triple amdgpu8.03-amd-amdhsa -x hip -std=c++11 -O1 -fclangir \
// RUN:            -fcuda-is-device -emit-llvm %s -o %t.ll
// RUN: FileCheck --check-prefix=LLVM --input-file=%t.ll %s

// RUN: %clang_cc1 -triple amdgpu8.03-amd-amdhsa -x hip -std=c++11 -O1 \
// RUN:            -fcuda-is-device -emit-llvm %s -o %t.ll
// RUN: FileCheck --check-prefix=LLVM --input-file=%t.ll %s

#define __device__ __attribute__((device))

typedef float v4f32 __attribute__((ext_vector_type(4)));
typedef _Float16 v4f16 __attribute__((ext_vector_type(4)));

//===----------------------------------------------------------------------===//
// Test AMDGPU builtins
//===----------------------------------------------------------------------===//

// CIR-LABEL: @_Z36test_struct_buffer_load_format_v4f32u22__amdgpu_buffer_rsrc_tiii
// CIR: cir.call_llvm_intrinsic "amdgcn.struct.ptr.buffer.load.format" {{.*}} : (!cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i, !s32i) -> !cir.vector<4 x !cir.float>
// LLVM: define{{.*}} <4 x float> @_Z36test_struct_buffer_load_format_v4f32u22__amdgpu_buffer_rsrc_tiii
// LLVM: call{{.*}} <4 x float> @llvm.amdgcn.struct.ptr.buffer.load.format.v4f32(ptr addrspace(8) %{{.*}}, i32 %{{.*}}, i32 %{{.*}}, i32 %{{.*}}, i32 0)
__device__ v4f32 test_struct_buffer_load_format_v4f32(__amdgpu_buffer_rsrc_t rsrc, int vindex, int offset, int soffset) {
  return __builtin_amdgcn_struct_buffer_load_format_v4f32(rsrc, vindex, offset, soffset, 0);
}

// CIR-LABEL: @_Z36test_struct_buffer_load_format_v4f16u22__amdgpu_buffer_rsrc_tiii
// CIR: cir.call_llvm_intrinsic "amdgcn.struct.ptr.buffer.load.format" {{.*}} : (!cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i, !s32i) -> !cir.vector<4 x !cir.f16>
// LLVM: define{{.*}} <4 x half> @_Z36test_struct_buffer_load_format_v4f16u22__amdgpu_buffer_rsrc_tiii
// LLVM: call{{.*}} <4 x half> @llvm.amdgcn.struct.ptr.buffer.load.format.v4f16(ptr addrspace(8) %{{.*}}, i32 %{{.*}}, i32 %{{.*}}, i32 %{{.*}}, i32 0)
__device__ v4f16 test_struct_buffer_load_format_v4f16(__amdgpu_buffer_rsrc_t rsrc, int vindex, int offset, int soffset) {
  return __builtin_amdgcn_struct_buffer_load_format_v4f16(rsrc, vindex, offset, soffset, 0);
}

// CIR-LABEL: @_Z37test_struct_buffer_store_format_v4f32Dv4_fu22__amdgpu_buffer_rsrc_tiii
// CIR: cir.call_llvm_intrinsic "amdgcn.struct.ptr.buffer.store.format" {{.*}} : (!cir.vector<4 x !cir.float>, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z37test_struct_buffer_store_format_v4f32Dv4_fu22__amdgpu_buffer_rsrc_tiii
// LLVM: call void @llvm.amdgcn.struct.ptr.buffer.store.format.v4f32(<4 x float> %{{.*}}, ptr addrspace(8) %{{.*}}, i32 %{{.*}}, i32 %{{.*}}, i32 %{{.*}}, i32 0)
__device__ void test_struct_buffer_store_format_v4f32(v4f32 vdata, __amdgpu_buffer_rsrc_t rsrc, int vindex, int offset, int soffset) {
  __builtin_amdgcn_struct_buffer_store_format_v4f32(vdata, rsrc, vindex, offset, soffset, 0);
}

// CIR-LABEL: @_Z37test_struct_buffer_store_format_v4f16Dv4_DF16_u22__amdgpu_buffer_rsrc_tiii
// CIR: cir.call_llvm_intrinsic "amdgcn.struct.ptr.buffer.store.format" {{.*}} : (!cir.vector<4 x !cir.f16>, !cir.ptr<!void, target_address_space(8)>, !s32i, !s32i, !s32i, !s32i) -> !void
// LLVM: define{{.*}} void @_Z37test_struct_buffer_store_format_v4f16Dv4_DF16_u22__amdgpu_buffer_rsrc_tiii
// LLVM: call void @llvm.amdgcn.struct.ptr.buffer.store.format.v4f16(<4 x half> %{{.*}}, ptr addrspace(8) %{{.*}}, i32 %{{.*}}, i32 %{{.*}}, i32 %{{.*}}, i32 0)
__device__ void test_struct_buffer_store_format_v4f16(v4f16 vdata, __amdgpu_buffer_rsrc_t rsrc, int vindex, int offset, int soffset) {
  __builtin_amdgcn_struct_buffer_store_format_v4f16(vdata, rsrc, vindex, offset, soffset, 0);
}
