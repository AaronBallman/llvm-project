//===- ArmSVEVectorTransformOps.td - Arm SVE transform ops--*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
#ifndef ARMSVE_VECTOR_TRANSFORM_OPS
#define ARMSVE_VECTOR_TRANSFORM_OPS

include "mlir/Dialect/Transform/IR/TransformAttrs.td"
include "mlir/Dialect/Transform/IR/TransformDialect.td"
include "mlir/Dialect/Transform/Interfaces/TransformInterfaces.td"

def ApplyArmSVELowerContractionToI8MMPatternsOp
    : Op<Transform_Dialect, "apply_patterns.arm_sve.vector_contract_to_i8mm",
         [DeclareOpInterfaceMethods<PatternDescriptorOpInterface>]> {
  let description = [{
    Indicates that vector contract operations should be lowered to
    to ArmSVE dialect operations mapping to instructions from FEAT_I8MM.
  }];

  let assemblyFormat = "attr-dict";
}

def ApplyArmSVELowerContractionToBFMMLAPatternsOp
    : Op<Transform_Dialect, "apply_patterns.arm_sve.vector_contract_to_bfmmla",
         [DeclareOpInterfaceMethods<PatternDescriptorOpInterface>]> {
  let description = [{
    Indicates that vector contract operations should be lowered to
    ArmSVE dialect operations mapping to instructions from FEAT_BF16.
  }];

  let assemblyFormat = "attr-dict";
}
#endif // ARMSVE_VECTOR_TRANSFORM_OPS
