//
//  Math.swift
//  Tang
//
//  Created by Tiny on 2018/2/8.
//  Copyright © 2018年 tiny. All rights reserved.
//

import Foundation

func acos(_ v: CGFloat) -> CGFloat {
    return CGFloat(acos(Double(v)))
}

func asin(_ v : CGFloat) -> CGFloat {
    return CGFloat(asin(Double(v)))
}

func atan(_ v : CGFloat) -> CGFloat {
    return CGFloat(atan(Double(v)))
}

func atan2(_ v1 : CGFloat, _ v2 : CGFloat) -> CGFloat {
    return CGFloat(atan2(Double(v1),Double(v2)))
}

func cos(_ v : CGFloat) -> CGFloat {
    return CGFloat(cos(Double(v)))
}

func sin(_ v : CGFloat) -> CGFloat {
    return CGFloat(sin(Double(v)))
}

func tan(_ v : CGFloat) -> CGFloat {
    return CGFloat(tan(Double(v)))
}

func acosh(_ v : CGFloat) -> CGFloat {
    return CGFloat(acosh(Double(v)))
}

func asinh(_ v : CGFloat) -> CGFloat {
    return CGFloat(asinh(Double(v)))
}

func atanh(_ v : CGFloat) -> CGFloat {
    return CGFloat(atanh(Double(v)))
}

func cosh(_ v : CGFloat) -> CGFloat {
    return CGFloat(cosh(Double(v)))
}

func sinh(_ v : CGFloat) -> CGFloat {
    return CGFloat(sinh(Double(v)))
}

func tanh(_ v : CGFloat) -> CGFloat {
    return CGFloat(tanh(Double(v)))
}

func exp(_ v : CGFloat) -> CGFloat {
    return CGFloat(exp(Double(v)))
}

func exp2(_ v : CGFloat) -> CGFloat {
    return CGFloat(exp2(Double(v)))
}

func expm1(_ v : CGFloat) -> CGFloat {
    return CGFloat(expm1(Double(v)))
}

func log(_ v : CGFloat) -> CGFloat {
    return CGFloat(log(Double(v)))
}

func log10(_ v : CGFloat) -> CGFloat {
    return CGFloat(log10(Double(v)))
}

func log2(_ v : CGFloat) -> CGFloat {
    return CGFloat(log2(Double(v)))
}

func log1p(_ v : CGFloat) -> CGFloat {
    return CGFloat(log1p(Double(v)))
}

func logb(_ v : CGFloat) -> CGFloat {
    return CGFloat(logb(Double(v)))
}

func modf(_ v : CGFloat, _ p : UnsafeMutablePointer<Double>!) -> CGFloat {
    return CGFloat(modf(Double(v),p ))
}

func ldexp(_ v : CGFloat, _ v2 : Int32) -> CGFloat {
    return CGFloat(ldexp(Double(v),v2))
}

func frexp(_ v : CGFloat, _ p : UnsafeMutablePointer<Int32>!) -> CGFloat {
    return CGFloat(frexp(Double(v),p))
}

func ilogb(_ v : CGFloat) -> Int32 {
    return ilogb(Double(v))
}

func scalbn(_ v : CGFloat, _ v2 : Int32) -> CGFloat {
    return CGFloat(scalbn(Double(v),v2))
}

func scalbln(_ v : CGFloat, _ v2 : Int) -> CGFloat {
    return CGFloat(scalbln(Double(v),v2))
}

func fabs(_ v : CGFloat) -> CGFloat {
    return CGFloat(fabs(Double(v)))
}

func cbrt(_ v : CGFloat) -> CGFloat {
    return CGFloat(cbrt(Double(v)))
}

func hypot(_ v : CGFloat, _ v2 : CGFloat) -> CGFloat {
    return CGFloat(hypot(Double(v),Double(v2)))
}

func pow(_ v : CGFloat, _ v2 : CGFloat) -> CGFloat {
    return CGFloat(pow(Double(v),Double(v2)))
}

func sqrt(_ v : CGFloat) -> CGFloat {
    return CGFloat(sqrt(Double(v)))
}

func erf(_ v : CGFloat) -> CGFloat {
    return CGFloat(erf(Double(v)))
}

func erfc(_ v : CGFloat) -> CGFloat {
    return CGFloat(erfc(Double(v)))
}

func lgamma(_ v : CGFloat) -> CGFloat {
    return CGFloat(lgamma(Double(v)))
}

func tgamma(_ v : CGFloat) -> CGFloat {
    return CGFloat(tgamma(Double(v)))
}

func ceil(_ v : CGFloat) -> CGFloat {
    return CGFloat(ceil(Double(v)))
}

func floor(_ v : CGFloat) -> CGFloat {
    return CGFloat(floor(Double(v)))
}

func nearbyint(_ v : CGFloat) -> CGFloat {
    return CGFloat(nearbyint(Double(v)))
}

func rint(_ v : CGFloat) -> CGFloat {
    return CGFloat(rint(Double(v)))
}

func lrint(_ v : CGFloat) -> CGFloat {
    return CGFloat(lrint(Double(v)))
}

func round(_ v : CGFloat) -> CGFloat {
    return CGFloat(round(Double(v)))
}

func lround(_ v : CGFloat) -> CGFloat {
    return CGFloat(lround(Double(v)))
}
