; RUN: llvm-as %s -o %t.bc
; RUN: llvm-spirv %t.bc -spirv-text -o - | FileCheck --check-prefix CHECK-SPIRV %s
; RUN: llvm-spirv %t.bc -o %t.spv
; RUN: spirv-val %t.spv
; RUN: llvm-spirv -r %t.spv -o %t.rev.bc
; RUN: llvm-dis %t.rev.bc -o - | FileCheck --check-prefix CHECK-LLVM %s

target triple = "spir64-unknown-unknown"

; CHECK-SPIRV: IAddCarry
; CHECK-LLVM: call { i16, i1 } @llvm.uadd.with.overflow.i16
; CHECK-LLVM: call { i32, i1 } @llvm.uadd.with.overflow.i32
; CHECK-LLVM: call { i64, i1 } @llvm.uadd.with.overflow.i64
; CHECK-LLVM: call { <4 x i32>, <4 x i1> } @llvm.uadd.with.overflow.v4i32

define spir_func void @test_uadd_with_overflow_i16(i16 %a, i16 %b) {
entry:
  %res = call {i16, i1} @llvm.uadd.with.overflow.i16(i16 %a, i16 %b)
  ret void
}

define spir_func void @test_uadd_with_overflow_i32(i32 %a, i32 %b) {
entry:
  %res = call {i32, i1} @llvm.uadd.with.overflow.i32(i32 %a, i32 %b)
  ret void
}

define spir_func void @test_uadd_with_overflow_i64(i64 %a, i64 %b) {
entry:
  %res = call {i64, i1} @llvm.uadd.with.overflow.i64(i64 %a, i64 %b)
  ret void
}

define spir_func void @test_uadd_with_overflow_v4i32(<4 x i32> %a, <4 x i32> %b) {
entry:
 %res = call {<4 x i32>, <4 x i1>} @llvm.uadd.with.overflow.v4i32(<4 x i32> %a, <4 x i32> %b) 
 ret void
}

declare {i16, i1} @llvm.uadd.with.overflow.i16(i16 %a, i16 %b)
declare {i32, i1} @llvm.uadd.with.overflow.i32(i32 %a, i32 %b)
declare {i64, i1} @llvm.uadd.with.overflow.i64(i64 %a, i64 %b)
declare {<4 x i32>, <4 x i1>} @llvm.uadd.with.overflow.v4i32(<4 x i32> %a, <4 x i32> %b)
