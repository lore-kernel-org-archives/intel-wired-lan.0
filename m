Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB50ECA5FC4
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 08:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 666006080A;
	Fri,  2 Oct 2026 08:16:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-0rtO_0jfkS; Fri,  2 Oct 2026 08:16:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2F61060823
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790929002;
	b=UAYmmRJiaD+hGJcKFeec21JNyxmTpD480ee8Jvna63F1pfxSF5tD0kWsH5jzAaS5Ai0D
	 F3xbxXlaR6UCVmEZLxiuyVCcVrPWhyrjzF2PPoYjR/l1TBlIn8GRwkjQA9AkkRRRtN+cI
	 PmaTbSk8IMJGp3ECDH6YlX/ZuOKsPCBNxH1aRMDjpiOTNknJVv1wI4rxOb3IVFigZXIkS
	 +YhZKPNAcdQCIvT5eu5GSOsep0gRijB0OpXYInyjNB1BmIaAovGwBPZaOMO6CyLEHk0H6
	 wnMdAZhA9GlYQDMRm18LCr3RV4vKRbqYZE/czU/jfdPxT6lAZKcOgKEr5JgASIszgOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790929002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=laeEQ8KFKmC4sSRGmbEb+cIzFMrMuAUYB0SGHipniFw=;
	b=nwa2cVgrC1WsHp6qfzXFPGHp2XJD9jXChWzoSBUGtFGcXBBDchj1FuMEYElkB1zqK8gB
	 JDi49GxTGvUi/b5fg+SH936W/NKMMXY1wj5v/ygncbK6+DJmdVBn612wn+D9hhBjF2rlA
	 CAbZC+XOEfqR8GGtMhN8nPQNEqPMMvCCeL/uNJGCiUhmtJtNxjB5iGx3LZic+UUfXhD1t
	 CX8Ig2F78kuQQixGDyaN+9fHv/S2nCNCBujFr/nu/cMGzHkpyiUqU0h2txnOMOPebldLQ
	 3FGMg5IcLyjIMWS8VZYtvn31j/W4+FWjwZhr3ClaXb8SRxIrSLJQyPdNAjX1oBL8ygg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=akwOLjao;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790929002;
	bh=laeEQ8KFKmC4sSRGmbEb+cIzFMrMuAUYB0SGHipniFw=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n2QWxpotYkJXS6M2SCG6YHOIVMOfsJwo4eL7Ue9UmG9CuAlZmUthsDvMcuMrYk372
	 ePjGeC3viXLKoyFFenIPNTlDUamWDhKScw29+RTtb3HeCHkO+ZQirbzxhbMNF0NJMb
	 +2mbtaGlJWCcYr/pPfx87uT6TJDwoGbuERlPAsPv62sO1ImZtlypVe+p+Wm/JVMEJa
	 HqU5SY73lRybjV4QOWicJEVKMuOvrEEaQEZqzHFVHW74tkzEQhS2K6TF9Tow1aA+DO
	 YNc2q3iETi8UUACNmgdH9gNW5qrRdTGeeOTbgbbiRq0gpU0b+BMyxfoIZJMJpjeTnC
	 RHpW9tIc04Xgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F61060823;
	Fri,  2 Oct 2026 08:16:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A349922B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 952FA60823
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:16:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q5U5Q8W-aAej for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 08:16:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3F2516080A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790928999;
 b=ZJvsbxe5vSsjyHUtOd7iTupXlt/YMRjkSTxsBe4KiVEqSGrO+g75G4o8NbggGAseU44h
 J+iNyUtFhGOFrH0gNBmH4nfd70CHU9eGLQzad3phhrVePak8+L88Mg1iTDDpE4JFGUBLK
 gt6LWzSdeStVA9WGQY0rQrHqTjVaIh+OVvGDAP5KcQQkizxyngf8pThpgHWDjvtfAoNuu
 KDlp/3ggvtvmoG9IDG6G65uPGyiLyp4zBpzBoXX5Hx6hPmBCWC0dArKOMv4IXzG+X7p7u
 qVrRi8KfrasuocBzW3L4I+WrPtdN770NKNsJLFTTG9GxeW6fWefHrcOkIu3mlJbX/4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790928999;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=laeEQ8KFKmC4sSRGmbEb+cIzFMrMuAUYB0SGHipniFw=;
 b=kxLohb2k9rZgkyYOJXV6GYBImD9HsdROYN3FdXCNO+WUgqzWSRhuuzVOYENtFCFinJNz
 Yb81uSaw8SlQ8dC7OOpF8XijGCbEFXthT1VCapdbNbzOxIRyqH021+AB6CCNbrwdEkHSC
 Pj3MnLFk1efYqG0msQEQl0nFLXBjNaBMvsdnB5EImklp5nbhxc00LUhkLWlVNw1CXwdGB
 DdkN3LJILDUj5qfV6hCae0ySOaM7EseK67+Rb8ILad6/Gn9/pWuMMCq6W2KsL4VcllMfo
 nl+2eHu7VbDEmu8Lhwcsl9OTPa4VZ8rF+38VvnW3uzut8xK1Rfef3z0Pk2ZALogD6fQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=akwOLjao; 
 arc=none smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=akwOLjao
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F2516080A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790929000; x=1822465000; h=date:from:to:subject:message-id;
 bh=vr/ILXbCTg1RnE19rUBoj3U9tV9c4S6lcFh+tphgs50=;
 b=akwOLjaoCYTri3+1VcX8Gm97IFcOlPxGKc0+VCLGH/ofwpCdebk+yuFG
 wGTayz6/2WdcT/HxIlwH2GEgXc/gqGkO1hwJSd2X/oxzmz/5hI9C1ztso
 hgUTQ1Yiva8Ekz9ffQoftFfmQPOpsIOriQIGkFOtljv3uhGC1toOVEzEV
 PD4ca1zHmyRwddVvWS7g/NX6+Y0t49TNUXCyzwApzWitrNknzAgz2gtjs
 Lojg3Nl7bKKOlnakUFceEtXVgb/iIE0ZTx2MzQkKkChBnwDDWybYAn10X
 Jzg3NQKAKI1dn2LLIra3Q4fIF6sa/Pf1Op2MmQe5T5Mxt6nXlsBtZJGtp w==;
X-CSE-ConnectionGUID: Al0Xzr9eQueYMgVy3JXPEQ==
X-CSE-MsgGUID: 7h+kGtM5StyhsPxmKtrEKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94406724"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="94406724"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 01:16:38 -0700
X-CSE-ConnectionGUID: lsoVs9ZaR4msW90LBNjsKw==
X-CSE-MsgGUID: I8lYM06bSDGdRJObO5OzvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="275741525"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa007.fm.intel.com with ESMTP; 02 Oct 2026 01:16:36 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xCYRV-00000000SmG-3oth;
 Fri, 02 Oct 2026 08:16:33 +0000
Date: Fri, 02 Oct 2026 16:15:58 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:10GbE] BUILD SUCCESS
 b38dd3a0cf1d136b610ff4d59214a8169286eb08
Message-ID: <202610021655.udX83Spe-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
branch HEAD: b38dd3a0cf1d136b610ff4d59214a8169286eb08  net: usb: ax88172a: improve MAC address read error handling

elapsed time: 1025m

configs tested: 330
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2105-20261001    gcc-15.2.0 cocci
alpha                randconfig-r2302-20261001    gcc-16.1.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261002    clang-17
arc                   randconfig-1001-20261002    clang-17
arc                  randconfig-r2103-20261001    gcc-9.5.0  cocci
arc                  randconfig-r2201-20261001    gcc-12.5.0 smatch
arc                  randconfig-r2305-20261001    gcc-11.5.0 sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                        aspeed_g4_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                             dove_defconfig    gcc-16.1.0
arm                       integrator_defconfig    gcc-16.1.0
arm                         mvebu_v7_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261002    clang-17
arm                   randconfig-1001-20261002    clang-17
arm                   randconfig-1002-20261002    clang-17
arm                   randconfig-1003-20261002    clang-17
arm                  randconfig-r2101-20261001    gcc-13.4.0 cocci
arm                  randconfig-r2304-20261001    gcc-10.5.0 sparse
arm                  randconfig-r2306-20261001    gcc-14     sparse
arm                          s3c6400_defconfig    gcc-16.1.0
arm                          vf610m4_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261002    gcc-12.5.0
arm64                 randconfig-1001-20261002    gcc-12.5.0
arm64                 randconfig-1002-20261002    gcc-12.5.0
arm64                 randconfig-1003-20261002    gcc-12.5.0
arm64                randconfig-r2106-20261001    clang-24   cocci
arm64                randconfig-r2201-20261001    gcc-16.1.0 smatch
arm64                randconfig-r2301-20261001    gcc-11.5.0 sparse
arm64                randconfig-r2301-20261001    gcc-16.1.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261002    gcc-12.5.0
csky                  randconfig-1001-20261002    gcc-12.5.0
csky                 randconfig-r2201-20261001    gcc-14.3.0 smatch
csky                 randconfig-r2303-20261001    gcc-16.1.0 sparse
csky                 randconfig-r2305-20261001    gcc-15.2.0 sparse
csky                 randconfig-r2309-20261001    gcc-9.5.0  sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261002    gcc-13.4.0
hexagon               randconfig-1001-20261002    gcc-13.4.0
hexagon              randconfig-r2103-20261001    clang-24   cocci
hexagon              randconfig-r2304-20261001    gcc-15.2.0 sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261002    clang-22
i386        buildonly-randconfig-1001-20261002    clang-22
i386        buildonly-randconfig-1002-20261002    clang-22
i386        buildonly-randconfig-1003-20261002    clang-22
i386        buildonly-randconfig-1004-20261002    clang-22
i386        buildonly-randconfig-1005-20261002    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261002    gcc-14
i386                  randconfig-1001-20261002    gcc-14
i386                  randconfig-1002-20261002    gcc-14
i386                  randconfig-1003-20261002    gcc-14
i386                  randconfig-1004-20261002    gcc-14
i386                  randconfig-1005-20261002    gcc-14
i386                  randconfig-1006-20261002    gcc-14
i386                  randconfig-1007-20261002    clang-22
i386                  randconfig-1008-20261002    clang-22
i386                  randconfig-1009-20261002    clang-22
i386                  randconfig-1010-20261002    clang-22
i386                  randconfig-1011-20261002    clang-22
i386                  randconfig-1012-20261002    clang-22
i386                  randconfig-1013-20261002    clang-22
i386                  randconfig-2100-20261001    gcc-14     cocci
i386                  randconfig-2101-20261001    gcc-14     cocci
i386                  randconfig-2102-20261001    clang-22   cocci
i386                  randconfig-2102-20261001    gcc-14     cocci
i386                  randconfig-2103-20261001    gcc-13     cocci
i386                  randconfig-2103-20261001    gcc-14     cocci
i386                  randconfig-2200-20261001    clang-22   smatch
i386                  randconfig-2300-20261001    clang-22   sparse
i386                  randconfig-2300-20261001    gcc-14     sparse
i386                  randconfig-2301-20261001    gcc-14     sparse
i386                  randconfig-2302-20261001    gcc-14     sparse
i386                 randconfig-r2101-20261001    gcc-14     cocci
i386                 randconfig-r2307-20261001    gcc-14     sparse
i386                 randconfig-r2308-20261001    gcc-14     sparse
i386                 randconfig-r2309-20261001    gcc-14     sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261002    gcc-13.4.0
loongarch             randconfig-1001-20261002    gcc-13.4.0
loongarch            randconfig-r2102-20261001    clang-24   cocci
loongarch            randconfig-r2103-20261001    clang-22   cocci
loongarch            randconfig-r2107-20261001    gcc-15.2.0 cocci
loongarch            randconfig-r2202-20261001    clang-21   smatch
loongarch            randconfig-r2302-20261001    gcc-15.2.0 sparse
loongarch            randconfig-r2308-20261001    gcc-14     sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                         m5272c3_defconfig    gcc-16.1.0
m68k                        m5275evb_defconfig    gcc-16.1.0
m68k                       m54418evb_defconfig    gcc-16.1.0
m68k                 randconfig-r2200-20261001    gcc-8.5.0  smatch
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2101-20261001    gcc-10.5.0 cocci
microblaze           randconfig-r2103-20261001    gcc-14     cocci
microblaze           randconfig-r2106-20261001    gcc-16.1.0 cocci
microblaze           randconfig-r2202-20261001    gcc-8.5.0  smatch
microblaze           randconfig-r2300-20261001    gcc-14.3.0 sparse
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                            ip27_defconfig    gcc-16.1.0
mips                            ip28_defconfig    gcc-16.1.0
mips                         maltaup_defconfig    gcc-16.1.0
mips                     maltaup_xpa_defconfig    gcc-16.1.0
mips                            mtx1_defconfig    gcc-16.1.0
mips                 randconfig-r2104-20261001    gcc-11.5.0 cocci
mips                 randconfig-r2107-20261001    clang-24   cocci
nios2                          3c120_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261002    gcc-13.4.0
nios2                 randconfig-1001-20261002    gcc-13.4.0
nios2                randconfig-r2105-20261001    gcc-11.5.0 cocci
openrisc                          alldefconfig    gcc-16.1.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2102-20261001    gcc-11.5.0 cocci
openrisc             randconfig-r2105-20261001    gcc-9.5.0  cocci
openrisc             randconfig-r2200-20261001    gcc-14.3.0 smatch
openrisc             randconfig-r2300-20261001    gcc-16.1.0 sparse
openrisc             randconfig-r2301-20261001    gcc-16.1.0 sparse
openrisc             randconfig-r2307-20261001    gcc-16.1.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261002    gcc-14.3.0
parisc                randconfig-1001-20261002    gcc-14.3.0
parisc               randconfig-r2102-20261001    clang-24   cocci
parisc               randconfig-r2104-20261001    gcc-15.2.0 cocci
parisc               randconfig-r2202-20261001    gcc-8.5.0  smatch
parisc               randconfig-r2303-20261001    gcc-13.4.0 sparse
parisc64                             defconfig    clang-24
powerpc                            allnoconfig    clang-24
powerpc                       arches_defconfig    gcc-16.1.0
powerpc                        eiger_defconfig    gcc-16.1.0
powerpc                       katmai_defconfig    gcc-16.1.0
powerpc                       pcm030_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261002    gcc-14.3.0
powerpc               randconfig-1001-20261002    gcc-14.3.0
powerpc              randconfig-r2100-20261001    clang-17   cocci
powerpc              randconfig-r2104-20261001    gcc-15.2.0 cocci
powerpc              randconfig-r2300-20261001    gcc-8.5.0  sparse
powerpc              randconfig-r2303-20261001    gcc-15.2.0 sparse
powerpc                      tqm8548_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20261002    gcc-14.3.0
powerpc64             randconfig-1001-20261002    gcc-14.3.0
powerpc64            randconfig-r2100-20261001    gcc-10.5.0 cocci
powerpc64            randconfig-r2304-20261001    gcc-16.1.0 sparse
powerpc64            randconfig-r2307-20261001    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv              nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261002    clang-24
riscv                 randconfig-1001-20261002    clang-24
riscv                 randconfig-2000-20261001    gcc-10.5.0
riscv                 randconfig-2000-20261001    gcc-9.5.0
riscv                 randconfig-2001-20261001    gcc-10.5.0
riscv                 randconfig-2001-20261001    gcc-8.5.0
riscv                randconfig-r2300-20261001    gcc-15.2.0 sparse
riscv                randconfig-r2304-20261001    gcc-13.4.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261002    clang-24
s390                  randconfig-1001-20261002    clang-24
s390                  randconfig-2000-20261001    gcc-10.5.0
s390                  randconfig-2000-20261001    gcc-9.5.0
s390                  randconfig-2001-20261001    clang-17
s390                  randconfig-2001-20261001    gcc-10.5.0
s390                 randconfig-r2305-20261001    gcc-9.5.0  sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          apsh4a3a_defconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                           lboxre2_defconfig    gcc-16.1.0
sh                    randconfig-1000-20261002    clang-24
sh                    randconfig-1001-20261002    clang-24
sh                    randconfig-2000-20261001    gcc-10.5.0
sh                    randconfig-2000-20261001    gcc-16.1.0
sh                    randconfig-2001-20261001    gcc-10.5.0
sh                   randconfig-r2301-20261001    gcc-15.2.0 sparse
sh                   randconfig-r2303-20261001    gcc-16.1.0 sparse
sh                   randconfig-r2305-20261001    gcc-16.1.0 sparse
sh                       rts7751r2d1_defconfig    gcc-16.1.0
sh                           sdk7780_defconfig    gcc-16.1.0
sh                            se7724_defconfig    gcc-16.1.0
sh                            se7780_defconfig    gcc-16.1.0
sh                             shmin_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261002    clang-24
sparc                 randconfig-1001-20261002    clang-24
sparc                 randconfig-2000-20261001    clang-24
sparc                 randconfig-2000-20261001    gcc-12.5.0
sparc                 randconfig-2001-20261001    clang-24
sparc                 randconfig-2001-20261001    gcc-14.3.0
sparc                randconfig-r2101-20261001    clang-24   cocci
sparc                randconfig-r2106-20261001    gcc-15.2.0 cocci
sparc                randconfig-r2200-20261001    gcc-8.5.0  smatch
sparc                randconfig-r2201-20261001    gcc-15.2.0 smatch
sparc                randconfig-r2202-20261001    gcc-13.4.0 smatch
sparc                randconfig-r2302-20261001    gcc-8.5.0  sparse
sparc                randconfig-r2306-20261001    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261002    clang-24
sparc64               randconfig-1001-20261002    clang-24
sparc64               randconfig-2000-20261001    clang-24
sparc64               randconfig-2001-20261001    clang-24
sparc64               randconfig-2001-20261001    gcc-8.5.0
sparc64              randconfig-r2103-20261001    clang-24   cocci
sparc64              randconfig-r2106-20261001    gcc-8.5.0  cocci
sparc64              randconfig-r2107-20261001    gcc-8.5.0  cocci
sparc64              randconfig-r2302-20261001    gcc-8.5.0  sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261002    clang-24
um                    randconfig-1001-20261002    clang-24
um                    randconfig-2000-20261001    clang-17
um                    randconfig-2000-20261001    clang-24
um                    randconfig-2001-20261001    clang-24
um                   randconfig-r2100-20261001    clang-24   cocci
um                   randconfig-r2100-20261001    gcc-14     cocci
um                   randconfig-r2101-20261001    clang-24   cocci
um                   randconfig-r2102-20261001    gcc-14     cocci
um                   randconfig-r2104-20261001    clang-24   cocci
um                   randconfig-r2306-20261001    gcc-14     sparse
um                   randconfig-r2308-20261001    gcc-14     sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261002    gcc-14
x86_64      buildonly-randconfig-1001-20261002    gcc-14
x86_64      buildonly-randconfig-1002-20261002    gcc-14
x86_64      buildonly-randconfig-1003-20261002    gcc-14
x86_64      buildonly-randconfig-1004-20261002    gcc-14
x86_64      buildonly-randconfig-1005-20261002    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261002    gcc-14
x86_64                randconfig-1001-20261002    gcc-14
x86_64                randconfig-1002-20261002    gcc-14
x86_64                randconfig-1003-20261002    gcc-14
x86_64                randconfig-1004-20261002    gcc-14
x86_64                randconfig-1005-20261002    gcc-14
x86_64                randconfig-1006-20261002    clang-22
x86_64                randconfig-1007-20261002    clang-22
x86_64                randconfig-1008-20261002    clang-22
x86_64                randconfig-1009-20261002    clang-22
x86_64                randconfig-1010-20261002    clang-22
x86_64                randconfig-1011-20261002    clang-22
x86_64                randconfig-1012-20261002    clang-22
x86_64                randconfig-1013-20261002    clang-22
x86_64                randconfig-1014-20261002    clang-22
x86_64                randconfig-1015-20261002    clang-22
x86_64                randconfig-1016-20261002    clang-22
x86_64                randconfig-1017-20261002    clang-22
x86_64                randconfig-2100-20261001    gcc-14     cocci
x86_64                randconfig-2101-20261001    gcc-13     cocci
x86_64                randconfig-2101-20261001    gcc-14     cocci
x86_64                randconfig-2102-20261001    clang-22   cocci
x86_64                randconfig-2102-20261001    gcc-14     cocci
x86_64                randconfig-2103-20261001    clang-22   cocci
x86_64                randconfig-2103-20261001    gcc-14     cocci
x86_64                randconfig-2200-20261001    clang-22   smatch
x86_64                randconfig-2300-20261001    clang-22   sparse
x86_64                randconfig-2300-20261001    gcc-14     sparse
x86_64                randconfig-2301-20261001    clang-22   sparse
x86_64                randconfig-2301-20261001    gcc-14     sparse
x86_64                randconfig-2302-20261001    gcc-14     sparse
x86_64               randconfig-r2100-20261001    gcc-14     cocci
x86_64               randconfig-r2309-20261001    gcc-14     sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261002    clang-24
xtensa                randconfig-1001-20261002    clang-24
xtensa                randconfig-2000-20261001    clang-24
xtensa                randconfig-2000-20261001    gcc-10.5.0
xtensa                randconfig-2001-20261001    clang-24
xtensa                randconfig-2001-20261001    gcc-8.5.0
xtensa               randconfig-r2105-20261001    clang-24   cocci
xtensa               randconfig-r2107-20261001    clang-24   cocci
xtensa               randconfig-r2201-20261001    gcc-8.5.0  smatch
xtensa                     smp_lx200_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
