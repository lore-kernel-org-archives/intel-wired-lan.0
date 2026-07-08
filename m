Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E18C43458
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Jul 2026 02:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A792D40CF1;
	Wed,  8 Jul 2026 02:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3KmhKSuEcBx7; Wed,  8 Jul 2026 02:38:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D076140CF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783478307;
	bh=pCAYcgAat6glD6b1dwNg4nVFZTPJtuSv8JcKxfnKS9E=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MEL63Tzr7g4RZwfG7YlW7E1YintYzcQODXyAkh/v0Ha6a5ENNvaZbIUJm8ugaXQmi
	 lKo4ecySkmygxKzErZLp6PuaIJmDi3O9VDwxLp+hrC9QK6C5y2tPZFgTSiMbQvlyOw
	 Ii7QV735Rz+jDiv0aZHtTOVTWjPJZNqYC2VZq7XR2TR7wREa8P/IeKvrEkm/aqte4x
	 IjUp7jnc6JXXjcmm0XlTX/QZLzfCBkZFmu0HC4UaYEvx+xTdoKkn3vx6z37LHQ6AMF
	 sezWDTyIL1eUwPLP6/Pv5VWK6ykPJHGhH3wCYsDMF/ifgVy6XNnh7v9BE2WfIa77f9
	 iuFNHu3WMmDMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D076140CF7;
	Wed,  8 Jul 2026 02:38:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E835315
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 02:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 63E3A81A58
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 02:38:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RkfH3s3xlFJM for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Jul 2026 02:38:25 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3199F81A5C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3199F81A5C
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3199F81A5C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 02:38:24 +0000 (UTC)
X-CSE-ConnectionGUID: bsbn5c4NQTCFJWXYHH2Neg==
X-CSE-MsgGUID: VAzrh6n7Ruumgvz8ZG7EqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84107228"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84107228"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 19:38:24 -0700
X-CSE-ConnectionGUID: 6a889k6pT7+UqL63menf5g==
X-CSE-MsgGUID: 2ZU3hmW8Sh+VFJMKssmXEg==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by fmviesa003.fm.intel.com with ESMTP; 07 Jul 2026 19:38:22 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1whIB1-00000000Fvx-3gvc;
 Wed, 08 Jul 2026 02:38:19 +0000
Date: Wed, 08 Jul 2026 10:37:20 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607081008.5sZHOoe5-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783478305; x=1815014305;
 h=date:from:to:subject:message-id;
 bh=ZFRYsoNlsqgltW1ibQFW2GWzffBRIMt/ALmhBfe0FLk=;
 b=DF3tiZILVL+qrb8J7koNEWDT4zHiTKvk1raddUZFxJDInOZVwJ0WUgR+
 XeM3py0gpKejNNFIrwMWw6ca/oq/aVpe931Qjh6sufGPxVPMD10+F/HRZ
 +yI2Es1BNq8NqankmiWesVnXced5fXToetdXot0JGd3SjPGjnUy/MCcaj
 4hsmuWEyeJbATAiLVspx/yzc0JPa8peqtUKWo0p5UWQG2Rly2++1wsC6L
 sdX9Kln2rWC8qJXqu1NIyFCgk3RtwfIMPXgB4PdycAw1PM2gLIOGT6BxB
 MbueR++H5VSWa0h9L7hUDhaHKyUaJzSB3wPaGGr6+4mqQ5Uaio6k+4Bcw
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DF3tiZIL
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 0dc30c418493b8f9416a707830b55e287acd10c2
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
branch HEAD: 0dc30c418493b8f9416a707830b55e287acd10c2  idpf: implement pci error handlers

Unverified Error/Warning (likely false positive, kindly check if interested):

    drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1206:1: internal compiler error: in final_scan_insn_1, at final.cc:2823
    drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c:438:1: internal compiler error: in final_scan_insn_1, at final.cc:2823

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 1483m

configs tested: 162
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                   randconfig-001-20260708    gcc-13.4.0
arc                   randconfig-002-20260708    gcc-13.4.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-16.1.0
arm                   randconfig-001-20260708    gcc-13.4.0
arm                   randconfig-002-20260708    gcc-13.4.0
arm                   randconfig-003-20260708    gcc-13.4.0
arm                   randconfig-004-20260708    gcc-13.4.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-9.5.0
arm64                 randconfig-001-20260708    gcc-9.5.0
arm64                          randconfig-002    gcc-9.5.0
arm64                 randconfig-002-20260708    gcc-9.5.0
arm64                          randconfig-003    gcc-9.5.0
arm64                 randconfig-003-20260708    gcc-9.5.0
arm64                          randconfig-004    gcc-9.5.0
arm64                 randconfig-004-20260708    gcc-9.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                           randconfig-001    gcc-9.5.0
csky                  randconfig-001-20260708    gcc-9.5.0
csky                           randconfig-002    gcc-9.5.0
csky                  randconfig-002-20260708    gcc-9.5.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260708    gcc-13.4.0
hexagon               randconfig-002-20260708    gcc-13.4.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260708    clang-22
i386        buildonly-randconfig-002-20260708    clang-22
i386        buildonly-randconfig-003-20260708    clang-22
i386        buildonly-randconfig-004-20260708    clang-22
i386        buildonly-randconfig-005-20260708    clang-22
i386        buildonly-randconfig-006-20260708    clang-22
i386                  randconfig-001-20260708    clang-22
i386                  randconfig-002-20260708    clang-22
i386                  randconfig-003-20260708    clang-22
i386                  randconfig-004-20260708    clang-22
i386                  randconfig-005-20260708    clang-22
i386                  randconfig-006-20260708    clang-22
i386                  randconfig-007-20260708    clang-22
i386                  randconfig-011-20260708    gcc-14
i386                  randconfig-012-20260708    gcc-14
i386                  randconfig-014-20260708    gcc-14
i386                  randconfig-015-20260708    gcc-14
i386                  randconfig-016-20260708    gcc-14
i386                  randconfig-017-20260708    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260708    gcc-13.4.0
loongarch             randconfig-002-20260708    gcc-13.4.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260708    gcc-13.4.0
nios2                 randconfig-002-20260708    gcc-13.4.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260708    clang-22
parisc                randconfig-002-20260708    clang-22
parisc64                            defconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260708    clang-22
powerpc               randconfig-002-20260708    clang-22
powerpc64             randconfig-001-20260708    clang-22
powerpc64             randconfig-002-20260708    clang-22
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-13.4.0
riscv                 randconfig-001-20260708    gcc-8.5.0
riscv                          randconfig-002    clang-17
riscv                 randconfig-002-20260708    gcc-8.5.0
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260708    clang-20
s390                           randconfig-002    clang-18
s390                  randconfig-002-20260708    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-14.3.0
sh                    randconfig-001-20260708    gcc-16.1.0
sh                             randconfig-002    gcc-9.5.0
sh                    randconfig-002-20260708    gcc-9.5.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260708    gcc-8.5.0
sparc                 randconfig-002-20260708    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260708    gcc-8.5.0
sparc64               randconfig-002-20260708    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260708    gcc-8.5.0
um                    randconfig-002-20260708    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260708    gcc-12
x86_64      buildonly-randconfig-002-20260708    gcc-12
x86_64      buildonly-randconfig-003-20260708    gcc-12
x86_64      buildonly-randconfig-004-20260708    gcc-12
x86_64      buildonly-randconfig-005-20260708    gcc-12
x86_64      buildonly-randconfig-006-20260708    gcc-12
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260708    gcc-14
x86_64                randconfig-002-20260708    gcc-14
x86_64                randconfig-003-20260708    gcc-14
x86_64                randconfig-004-20260708    gcc-14
x86_64                randconfig-005-20260708    gcc-14
x86_64                randconfig-006-20260708    gcc-14
x86_64                randconfig-011-20260708    gcc-14
x86_64                randconfig-012-20260708    clang-22
x86_64                randconfig-013-20260708    clang-22
x86_64                randconfig-014-20260708    gcc-14
x86_64                randconfig-015-20260708    gcc-14
x86_64                randconfig-016-20260708    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260708    gcc-8.5.0
xtensa                randconfig-002-20260708    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
