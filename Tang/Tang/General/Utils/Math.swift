//
//  Math.swift
//  Tang
//
//  Created by Jay on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import Foundation

func acosCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(acos(Double(v)))
}

func asinCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(asin(Double(v)))
}

func atanCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(atan(Double(v)))
}

func atan2CGF(_ v1 : CGFloat, _ v2 : CGFloat) -> CGFloat {
    return CGFloat(atan2(Double(v1),Double(v2)))
}

func cosCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(cos(Double(v)))
}

func sinCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(sin(Double(v)))
}

func tanCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(tan(Double(v)))
}

func acoshCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(acosh(Double(v)))
}

func asinhCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(asinh(Double(v)))
}

func atanhCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(atanh(Double(v)))
}

func coshCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(cosh(Double(v)))
}

func sinhCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(sinh(Double(v)))
}

func tanhCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(tanh(Double(v)))
}

func expCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(exp(Double(v)))
}

func exp2CGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(exp2(Double(v)))
}

func expm1CGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(expm1(Double(v)))
}

func logCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(log(Double(v)))
}

func log10CGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(log10(Double(v)))
}

func log2CGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(log2(Double(v)))
}

func log1pCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(log1p(Double(v)))
}

func logbCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(logb(Double(v)))
}

func modfCGF(_ v : CGFloat, _ p : UnsafeMutablePointer<Double>!) -> CGFloat {
    return CGFloat(modf(Double(v),p ))
}

func ldexpCGF(_ v : CGFloat, _ v2 : Int32) -> CGFloat {
    return CGFloat(ldexp(Double(v),v2))
}

func frexpCGF(_ v : CGFloat, _ p : UnsafeMutablePointer<Int32>!) -> CGFloat {
    return CGFloat(frexp(Double(v),p))
}

func ilogbCGF(_ v : CGFloat) -> Int32 {
    return ilogb(Double(v))
}

func scalbnCGF(_ v : CGFloat, _ v2 : Int32) -> CGFloat {
    return CGFloat(scalbn(Double(v),v2))
}

func scalblnCGF(_ v : CGFloat, _ v2 : Int) -> CGFloat {
    return CGFloat(scalbln(Double(v),v2))
}

func fabsCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(fabs(Double(v)))
}

func cbrtCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(cbrt(Double(v)))
}

func hypotCGF(_ v : CGFloat, _ v2 : CGFloat) -> CGFloat {
    return CGFloat(hypot(Double(v),Double(v2)))
}

func powCGF(_ v : CGFloat, _ v2 : CGFloat) -> CGFloat {
    return CGFloat(pow(Double(v),Double(v2)))
}

func sqrtCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(sqrt(Double(v)))
}

func erfCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(erf(Double(v)))
}

func erfcCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(erfc(Double(v)))
}

func lgammaCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(lgamma(Double(v)))
}

func tgammaCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(tgamma(Double(v)))
}

func ceilCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(ceil(Double(v)))
}

func floorCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(floor(Double(v)))
}

func nearbyintCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(nearbyint(Double(v)))
}

func rintCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(rint(Double(v)))
}

func lrintCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(lrint(Double(v)))
}

func roundCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(round(Double(v)))
}

func lroundCGF(_ v : CGFloat) -> CGFloat {
    return CGFloat(lround(Double(v)))
}
