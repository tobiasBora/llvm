//===-- LeonFeatures.td - Describe the Leon Features -------*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
//
//===----------------------------------------------------------------------===//


//===----------------------------------------------------------------------===//
// UMAC and SMAC support for LEON3 and LEON4 processors.
//===----------------------------------------------------------------------===//

//support to casa instruction; for leon3 subtarget only
def UMACSMACSupport : SubtargetFeature<
  "hasumacsmac", 
  "HasUmacSmac", 
  "true", 
  "Enable UMAC and SMAC for LEON3 and LEON4 processors"
>;
