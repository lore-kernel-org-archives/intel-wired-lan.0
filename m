Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49305C55165
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 12:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF12160895;
	Thu, 30 Jul 2026 12:45:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8LL40xgvzHX5; Thu, 30 Jul 2026 12:45:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 677DD608A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785415531;
	bh=w4ycCWBKIQwH9G6T0gI0OZnKkuc9KQIuj+1zlh8/Ccw=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MK6KTZVku83YAT8E2Vqo7utq1tXfqL8TgPLIogYnvlEQ7xFSXDO3fQPN0scDtXV1r
	 SO7Wf1l9v4PUGZVwrXg9S7X9ko4UbFAMEueLt6jySID1b343TKbq/d6qK1x2vSnOoh
	 81vD50fNmKVzCznbYey/zAYqPHme2hrRMOzXLsBA3G2cfLV6AMzJn/FLZ3YY+d+kwh
	 6kcrFfydHphVhVbEpl4/vQ1qBC+Cn6C6o/l9DyadKrC2RlAEUkgJItVN40RRJjLePC
	 XFsmincftt9xPauZ81l94oU9MJ6z9q/FMK7dR6ed/HGPD1Wq696K+SfjGd/QTMBEvO
	 dW4Nd6peC+TXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 677DD608A4;
	Thu, 30 Jul 2026 12:45:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 72E4D197
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 12:45:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6486C80DBC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 12:45:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ooacrFFdoBZc for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 12:45:29 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5B09C80C95
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B09C80C95
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B09C80C95
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 12:45:29 +0000 (UTC)
X-CSE-ConnectionGUID: OB9+QBCCSe629kDVCULYMw==
X-CSE-MsgGUID: vlPS+7+ITxyZ7cn+2mbAvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85888772"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="85888772"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 05:45:30 -0700
X-CSE-ConnectionGUID: I1AUjaAUTmKTj8KweMsGzg==
X-CSE-MsgGUID: J+KtfarySla0Di9LMuEu2Q==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by fmviesa003.fm.intel.com with ESMTP; 30 Jul 2026 05:45:27 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wpQ8V-00000000gYq-0IT7;
 Thu, 30 Jul 2026 12:45:20 +0000
Date: Thu, 30 Jul 2026 20:44:43 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607302025.vH4mFKK1-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785415530; x=1816951530;
 h=date:from:to:subject:message-id;
 bh=QfTYjlOFmHLm5VTTmePiJA8VLv+SDBlyTSFAjo620SQ=;
 b=GBuC07X9q5IBWKdo2l5d65CBJCJEEhiJ3t2y69k9SCcY/+tDGgPEPzxW
 WwOPSdXJrY8jjGJ9aS0pI6cTZXjjq1wtiJE5InA6BBKHH1cwz4CmCeTJp
 C6JJTR4uKueaakO2JQ0W8sE6XPBsQ75nqKiVw7H9vprwcV4NdzQjVSjPp
 m1spnFkBWHj8oT7VXtE7ZiVzOZAN7STgMsHH0PXNw1XBM6PGIBsSi7Uhz
 RxD2P6AlMQwH0SCoNen8NPEg5vp8njCKyROMpH31Ojs49DYI2DvqGaeFz
 JAcjfc4eqySaygsujpYfkQOIzilnbMvYPGpYUYKyP2rwdO1ufAgI0W1ce
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GBuC07X9
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 caab60c281bfeb8907a0883e2ddfb55d64603569
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: caab60c281bfeb8907a0883e2ddfb55d64603569  i40e: trigger PF reset when re-enabling ATR via ethtool

Unverified Error/Warning (likely false positive, kindly check if interested):

    drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1206:1: internal compiler error: in final_scan_insn_1, at final.cc:2823

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 885m

configs tested: 150
configs skipped: 1

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260730    gcc-11.5.0
arc                  randconfig-001-20260730    gcc-8.5.0
arc                  randconfig-002-20260730    gcc-8.5.0
arm                  randconfig-001-20260730    gcc-8.5.0
arm                  randconfig-002-20260730    gcc-15.2.0
arm                  randconfig-002-20260730    gcc-8.5.0
arm                  randconfig-003-20260730    gcc-13.4.0
arm                  randconfig-003-20260730    gcc-8.5.0
arm                  randconfig-004-20260730    clang-24
arm                  randconfig-004-20260730    gcc-8.5.0
arm                          stm32_defconfig    gcc-16.1.0
arm64                randconfig-001-20260730    gcc-15.2.0
arm64                randconfig-002-20260730    clang-21
arm64                randconfig-002-20260730    gcc-15.2.0
arm64                randconfig-003-20260730    gcc-15.2.0
arm64                randconfig-003-20260730    gcc-8.5.0
arm64                randconfig-004-20260730    gcc-13.4.0
arm64                randconfig-004-20260730    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260730    gcc-13.4.0
csky                 randconfig-001-20260730    gcc-15.2.0
csky                 randconfig-002-20260730    gcc-15.2.0
csky                 randconfig-002-20260730    gcc-16.1.0
hexagon              randconfig-001-20260730    clang-24
hexagon              randconfig-002-20260730    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260730    gcc-14
i386       buildonly-randconfig-002-20260730    gcc-14
i386       buildonly-randconfig-003-20260730    gcc-14
i386       buildonly-randconfig-004-20260730    gcc-14
i386       buildonly-randconfig-005-20260730    gcc-14
i386       buildonly-randconfig-006-20260730    gcc-14
i386                 randconfig-001-20260730    gcc-14
i386                 randconfig-002-20260730    clang-22
i386                 randconfig-002-20260730    gcc-14
i386                 randconfig-003-20260730    gcc-14
i386                 randconfig-004-20260730    clang-22
i386                 randconfig-004-20260730    gcc-14
i386                 randconfig-005-20260730    clang-22
i386                 randconfig-005-20260730    gcc-14
i386                 randconfig-006-20260730    gcc-14
i386                 randconfig-007-20260730    gcc-14
i386                 randconfig-011-20260730    clang-22
i386                 randconfig-012-20260730    clang-22
i386                 randconfig-013-20260730    clang-22
i386                 randconfig-014-20260730    clang-22
i386                 randconfig-014-20260730    gcc-14
i386                 randconfig-015-20260730    clang-22
i386                 randconfig-016-20260730    clang-22
i386                 randconfig-016-20260730    gcc-13
i386                 randconfig-017-20260730    clang-22
i386                 randconfig-017-20260730    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260730    clang-24
loongarch            randconfig-001-20260730    gcc-16.1.0
loongarch            randconfig-002-20260730    clang-24
loongarch            randconfig-002-20260730    gcc-13.4.0
mips                         ath25_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260730    clang-24
nios2                randconfig-001-20260730    gcc-11.5.0
nios2                randconfig-002-20260730    clang-24
nios2                randconfig-002-20260730    gcc-9.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260730    gcc-14.3.0
parisc               randconfig-002-20260730    gcc-14.3.0
parisc               randconfig-002-20260730    gcc-16.1.0
powerpc              randconfig-001-20260730    clang-24
powerpc              randconfig-001-20260730    gcc-14.3.0
powerpc              randconfig-002-20260730    gcc-11.5.0
powerpc              randconfig-002-20260730    gcc-14.3.0
powerpc64            randconfig-001-20260730    clang-24
powerpc64            randconfig-001-20260730    gcc-14.3.0
powerpc64            randconfig-002-20260730    gcc-14.3.0
powerpc64            randconfig-002-20260730    gcc-8.5.0
riscv                         randconfig-001    gcc-15.2.0
riscv                randconfig-001-20260730    gcc-15.2.0
riscv                randconfig-002-20260730    gcc-15.2.0
riscv                randconfig-002-20260730    gcc-9.5.0
s390                 randconfig-001-20260730    clang-17
s390                 randconfig-001-20260730    gcc-15.2.0
s390                 randconfig-002-20260730    gcc-15.2.0
s390                 randconfig-002-20260730    gcc-8.5.0
sh                        apsh4a3a_defconfig    gcc-16.1.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260730    gcc-13.4.0
sh                   randconfig-001-20260730    gcc-15.2.0
sh                   randconfig-002-20260730    gcc-15.2.0
sparc                randconfig-001-20260730    clang-24
sparc                randconfig-001-20260730    gcc-16.1.0
sparc                randconfig-002-20260730    clang-24
sparc                randconfig-002-20260730    gcc-16.1.0
sparc64              randconfig-001-20260730    clang-20
sparc64              randconfig-001-20260730    clang-24
sparc64              randconfig-002-20260730    clang-24
sparc64              randconfig-002-20260730    gcc-14.3.0
um                   randconfig-001-20260730    clang-17
um                   randconfig-001-20260730    clang-24
um                   randconfig-002-20260730    clang-24
x86_64              buildonly-randconfig-001    gcc-14
x86_64     buildonly-randconfig-001-20260730    gcc-14
x86_64     buildonly-randconfig-002-20260730    gcc-14
x86_64     buildonly-randconfig-003-20260730    gcc-14
x86_64     buildonly-randconfig-004-20260730    gcc-14
x86_64     buildonly-randconfig-005-20260730    gcc-14
x86_64     buildonly-randconfig-006-20260730    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
x86_64               randconfig-001-20260730    clang-22
x86_64               randconfig-002-20260730    clang-22
x86_64               randconfig-002-20260730    gcc-14
x86_64               randconfig-003-20260730    clang-22
x86_64               randconfig-004-20260730    clang-22
x86_64               randconfig-004-20260730    gcc-14
x86_64               randconfig-005-20260730    clang-22
x86_64               randconfig-006-20260730    clang-22
x86_64               randconfig-011-20260730    clang-22
x86_64               randconfig-011-20260730    gcc-12
x86_64               randconfig-012-20260730    clang-22
x86_64               randconfig-012-20260730    gcc-14
x86_64               randconfig-013-20260730    clang-22
x86_64               randconfig-013-20260730    gcc-14
x86_64               randconfig-014-20260730    clang-22
x86_64               randconfig-015-20260730    clang-22
x86_64               randconfig-016-20260730    clang-22
x86_64               randconfig-016-20260730    gcc-12
x86_64               randconfig-071-20260730    gcc-12
x86_64               randconfig-071-20260730    gcc-14
x86_64               randconfig-072-20260730    gcc-12
x86_64               randconfig-073-20260730    clang-22
x86_64               randconfig-073-20260730    gcc-12
x86_64               randconfig-074-20260730    gcc-12
x86_64               randconfig-075-20260730    clang-22
x86_64               randconfig-075-20260730    gcc-12
x86_64               randconfig-076-20260730    clang-22
x86_64               randconfig-076-20260730    gcc-12
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260730    clang-24
xtensa               randconfig-001-20260730    gcc-16.1.0
xtensa               randconfig-002-20260730    clang-24
xtensa               randconfig-002-20260730    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
