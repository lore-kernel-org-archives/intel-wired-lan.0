Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E3EC5DF81
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Aug 2026 23:06:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 772A580BB9;
	Wed, 19 Aug 2026 23:06:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SXaI0UA8l3xU; Wed, 19 Aug 2026 23:06:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787180785;
	bh=hL4+/Szgl+JaJp3A4zOtavegqgZxbgSt9I7ci1KbA/8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AXOBSYysNbJ2DbZVoJ2wXhO2yrOl5T4NrsFp8uiasX3PpKgTIc/e+c9WlLU30fBJK
	 eQgjDWak79KFuB3AekLknszooL5+yd92GQqeOzcJh0dB/M+8WJsyOE7/oUW71eDy4l
	 pQ4+v5m8OHYwuITdTisyp/SxqOxc22xxdcRylfMbvlvXrr0iJnFULd4OA+XCEBfD5Y
	 aqO/oavEZAAKAIVrLPfjBURtIzgCsYs8RFlG/CTAgyb9Y7VIIQXihBA8g8vrtFLJCq
	 17FvoZo7meFK1vkRXnRMsnfCkFgAtR7YASKq5tjxHKzALAsmTy84PujrAWcrMOJaB8
	 z7rPnyPDjD+rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B707780C09;
	Wed, 19 Aug 2026 23:06:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E903F1B8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 23:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF01040024
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 23:06:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MJ2B3ioSLRjf for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Aug 2026 23:06:23 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gWhn8Ocv
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C623C40055
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 23:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787180782; x=1818716782; h=date:from:to:subject:message-id;
 bh=jDUjftWUNntbhzyThSM5sYcVo8ydRtbjy+akQJMGldQ=;
 b=gWhn8OcvTKz17CwsnTnqJl1tA8sNrRnIrK6qYT8wZY5N5ddE5qUyThaf
 vjH6w5sLMkjNihK+RSaGcarqFI0mk2l7izkuCuS1frl7gFvE8FjNuUPvn
 7FdWr+AtcMsCd20nzVRNyECzViJXSR4vWwF+fJyJ9v9MBWkaYwJocUTFk
 5n6eMzAGQ3qriM9BsbQeyW8wHLeBjU6ct+g/+0unjQGHLfM5C21lhzRd6
 Jl9+xsX0Y37ZUhBSiePEO03EiPI96+nw1X8WcP3588TGwltzXjZuBZIBB
 3GckLgy1k73mgmT2VBIOdcH8U7nFM6woABrQH8DGVwIsvyAMpA6gowmIq Q==;
X-CSE-ConnectionGUID: XyoFHWx1SieczgD9Vnh/Pg==
X-CSE-MsgGUID: eAh9z04DRhyxMFBDoM5WlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98045041"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="98045041"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 16:06:21 -0700
X-CSE-ConnectionGUID: S72WaYEBTXaqTg0Zcpj0LQ==
X-CSE-MsgGUID: Y10e9IF1Rr2feqVYivnKsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="262440020"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa007.fm.intel.com with ESMTP; 19 Aug 2026 16:06:21 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wwpMQ-00000000gqa-2WXX;
 Wed, 19 Aug 2026 23:06:18 +0000
Date: Thu, 20 Aug 2026 07:05:42 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD REGRESSION
 aa8ccbf3c4083448f49d13aecfda81560efffa7d
Message-ID: <202608200728.LZGtOuio-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: aa8ccbf3c4083448f49d13aecfda81560efffa7d  ixgbe: implement Total Port Shutdown for E610

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 1473m

configs tested: 93
configs skipped: 2

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260819    gcc-11.5.0
arc                  randconfig-002-20260819    gcc-13.4.0
arm                        axm55xx_defconfig    clang-24
arm                  randconfig-001-20260819    gcc-13.4.0
arm                  randconfig-002-20260819    gcc-15.2.0
arm                  randconfig-003-20260819    gcc-10.5.0
arm                  randconfig-004-20260819    gcc-15.2.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260819    gcc-11.5.0
arm64                randconfig-002-20260819    clang-17
arm64                randconfig-003-20260819    clang-17
arm64                randconfig-004-20260819    gcc-8.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260819    gcc-9.5.0
csky                 randconfig-002-20260819    gcc-11.5.0
hexagon              randconfig-001-20260819    clang-22
hexagon              randconfig-002-20260819    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260819    clang-22
i386       buildonly-randconfig-002-20260819    gcc-14
i386       buildonly-randconfig-003-20260819    gcc-14
i386       buildonly-randconfig-004-20260819    gcc-14
i386       buildonly-randconfig-005-20260819    gcc-14
i386       buildonly-randconfig-006-20260819    gcc-12
i386                 randconfig-001-20260819    gcc-14
i386                 randconfig-002-20260819    gcc-14
i386                 randconfig-003-20260819    gcc-14
i386                 randconfig-004-20260819    gcc-14
i386                 randconfig-005-20260819    gcc-14
i386                 randconfig-006-20260819    gcc-12
i386                 randconfig-007-20260819    clang-22
i386                 randconfig-011-20260819    gcc-13
i386                 randconfig-012-20260819    gcc-14
i386                 randconfig-013-20260819    gcc-14
i386                 randconfig-014-20260819    clang-22
i386                 randconfig-015-20260819    clang-22
i386                 randconfig-016-20260819    clang-22
i386                 randconfig-017-20260819    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260819    clang-24
loongarch            randconfig-002-20260819    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260819    gcc-11.5.0
nios2                randconfig-002-20260819    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260819    gcc-8.5.0
parisc               randconfig-002-20260819    gcc-16.1.0
powerpc              randconfig-001-20260819    clang-24
powerpc              randconfig-002-20260819    gcc-8.5.0
powerpc64            randconfig-001-20260819    clang-24
powerpc64            randconfig-002-20260819    clang-21
riscv                randconfig-001-20260819    gcc-8.5.0
riscv                randconfig-002-20260819    gcc-9.5.0
s390                 randconfig-001-20260819    gcc-14.3.0
s390                 randconfig-002-20260819    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260819    gcc-16.1.0
sh                   randconfig-002-20260819    gcc-11.5.0
sparc                randconfig-001-20260819    gcc-12.5.0
sparc                randconfig-002-20260819    gcc-8.5.0
sparc64              randconfig-001-20260819    clang-20
sparc64              randconfig-002-20260819    gcc-10.5.0
um                   randconfig-001-20260819    gcc-14
um                   randconfig-002-20260819    gcc-12
x86_64     buildonly-randconfig-001-20260819    gcc-14
x86_64     buildonly-randconfig-002-20260819    gcc-14
x86_64     buildonly-randconfig-003-20260819    gcc-14
x86_64     buildonly-randconfig-004-20260819    gcc-14
x86_64     buildonly-randconfig-005-20260819    gcc-14
x86_64     buildonly-randconfig-006-20260819    gcc-14
x86_64               randconfig-011-20260819    gcc-14
x86_64               randconfig-012-20260819    gcc-14
x86_64               randconfig-013-20260819    gcc-14
x86_64               randconfig-014-20260819    gcc-14
x86_64               randconfig-015-20260819    clang-22
x86_64               randconfig-016-20260819    gcc-12
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260819    gcc-14
x86_64               randconfig-072-20260819    gcc-14
x86_64               randconfig-073-20260819    gcc-12
x86_64               randconfig-074-20260819    clang-22
x86_64               randconfig-075-20260819    gcc-14
x86_64               randconfig-076-20260819    gcc-14
xtensa               randconfig-001-20260819    gcc-16.1.0
xtensa               randconfig-002-20260819    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
