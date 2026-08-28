Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F89C61DB9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 28 Aug 2026 12:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C3EF60705;
	Fri, 28 Aug 2026 12:21:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ENsFXUhcPadV; Fri, 28 Aug 2026 12:21:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787919687;
	bh=B7+kRdjwxKLl42MlYW0VpxDaxj/0RY765oKgZ+/lVXo=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lJR4KevHngxYXy4xNIUnCR1d6XUXld8rcCqifvae61lLL8Y0iyd9JSJjW3EykZXli
	 lQrJZqR7BrOiTLwNl5etkjY6of+75wm+G6SB2EHNme/lUw9SrD9oZc2T0cq4LUtN2T
	 +kGwjN1ZdZqdngSGtw6/JSGARcrW0ZvRql0ox5gRBo98aYuWNGpVofhtuvSOC2TKnj
	 6pLfDHHiDJoKF9ou2SwDEPqD+4fltBUdWYunl1eYp6N4ZKeQZtjrrZxIi2gBXMIGUs
	 uxMX0x4xCuBLn+1wZ1pqJNMoL9jTutin0L4CiOXFdAgVzByoPs9wRrdmfEvxwDjC1k
	 fnUC6Xi+2uQiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00F0460708;
	Fri, 28 Aug 2026 12:21:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B14B334
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 12:21:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 217E440842
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 12:21:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cLOC7s_V5SjE for <intel-wired-lan@lists.osuosl.org>;
 Fri, 28 Aug 2026 12:21:24 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XFqua3K4
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C20040841
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787919684; x=1819455684; h=date:from:to:subject:message-id;
 bh=Iwlg0dIJ+GKmdvUljgWLBznKpV1e4XdjrOWaYqmsF7I=;
 b=XFqua3K4Go3+s/sebFFtqsVp8R3voQ+pKy7FQ6tbUR+e10/mCjF81MHt
 sMlcMK9M+6xnp6YFXfGzaZ7ahDFdxn+sp76ib3ibSGFaauWtN18LUtbbL
 ISr4YWJTuRpYHu7Y5Y57vvJ8SRyJ3QO93Hk1OyJJScZsj49RMz56BrNpr
 7tpat7yt/vbvFIXwtxpkpLiGJ1qzljaOdoiPg1fzbq3kVsFBykVtpmJsp
 imbNRLsj0ZlPJIacNPLV9moRbN/vpXh3bS5QoLHvK0PCuqHYWpezMWFk/
 OSeKP+6DrJpP9spzWp5eC+7N1QJZqQnCufeYcUn//yjStBWQ2blLFzebl Q==;
X-CSE-ConnectionGUID: 7ZbD3DdHSUiPsrKy56Tq8w==
X-CSE-MsgGUID: 4Mgqk5jeQ7WfW/6haIr4aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88479387"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88479387"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 05:21:19 -0700
X-CSE-ConnectionGUID: h2P4HxOjRleQl9sHVxnByw==
X-CSE-MsgGUID: LPgA6vj1QhuLPUdvJC1eqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="266330303"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 28 Aug 2026 05:21:18 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wzva7-00000000B5V-34T4;
 Fri, 28 Aug 2026 12:21:15 +0000
Date: Fri, 28 Aug 2026 20:20:22 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD REGRESSION
 7def77282754edce7388dbb4e1baae6feaf39fc8
Message-ID: <202608282051.C6d5tQXY-lkp@intel.com>
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
branch HEAD: 7def77282754edce7388dbb4e1baae6feaf39fc8  e100: prevent shift-out-of-bounds in EEPROM access

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 2941m

configs tested: 243
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-14
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-14
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arm                              alldefconfig    clang-14
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-14
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-14
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-14
arm64                 randconfig-001-20260827    clang-14
arm64                 randconfig-001-20260827    gcc-8.5.0
arm64                          randconfig-002    clang-14
arm64                 randconfig-002-20260827    clang-14
arm64                 randconfig-002-20260827    gcc-9.5.0
arm64                          randconfig-003    clang-14
arm64                 randconfig-003-20260827    clang-14
arm64                 randconfig-003-20260827    clang-21
arm64                          randconfig-004    clang-14
arm64                 randconfig-004-20260827    clang-14
arm64                 randconfig-004-20260827    gcc-8.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-14
csky                  randconfig-001-20260827    clang-14
csky                  randconfig-001-20260827    gcc-9.5.0
csky                           randconfig-002    clang-14
csky                  randconfig-002-20260827    clang-14
csky                  randconfig-002-20260827    gcc-15.2.0
hexagon                          allmodconfig    clang-14
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-14
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260827    clang-14
hexagon               randconfig-001-20260827    gcc-16.1.0
hexagon               randconfig-002-20260827    clang-14
hexagon               randconfig-002-20260827    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260827    clang-22
i386        buildonly-randconfig-002-20260827    clang-22
i386        buildonly-randconfig-003-20260827    clang-22
i386        buildonly-randconfig-004-20260827    clang-22
i386        buildonly-randconfig-005-20260827    clang-22
i386        buildonly-randconfig-006-20260827    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-011-20260827    clang-22
i386                  randconfig-011-20260827    gcc-13
i386                  randconfig-012-20260827    clang-22
i386                  randconfig-012-20260827    gcc-13
i386                  randconfig-013-20260827    gcc-13
i386                  randconfig-013-20260827    gcc-14
i386                  randconfig-014-20260827    gcc-13
i386                  randconfig-015-20260827    gcc-13
i386                  randconfig-015-20260827    gcc-14
i386                  randconfig-016-20260827    clang-22
i386                  randconfig-016-20260827    gcc-13
i386                  randconfig-017-20260827    clang-22
i386                  randconfig-017-20260827    gcc-13
loongarch                        allmodconfig    clang-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-14
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260827    clang-22
loongarch             randconfig-001-20260827    gcc-16.1.0
loongarch             randconfig-002-20260827    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-14
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-14
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-14
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                          rb532_defconfig    clang-14
mips                          rm200_defconfig    clang-14
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-14
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-14
nios2                 randconfig-001-20260827    gcc-11.5.0
nios2                 randconfig-001-20260827    gcc-16.1.0
nios2                 randconfig-002-20260827    gcc-11.5.0
nios2                 randconfig-002-20260827    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-14
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-14
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-14.3.0
parisc                randconfig-001-20260827    gcc-14.3.0
parisc                         randconfig-002    gcc-14.3.0
parisc                randconfig-002-20260827    gcc-14.3.0
parisc                randconfig-002-20260827    gcc-16.1.0
parisc64                            defconfig    clang-14
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-14
powerpc                           allnoconfig    gcc-16.1.0
powerpc                     ep8248e_defconfig    clang-14
powerpc                     kmeter1_defconfig    clang-14
powerpc                        randconfig-001    gcc-14.3.0
powerpc               randconfig-001-20260827    gcc-13.4.0
powerpc               randconfig-001-20260827    gcc-14.3.0
powerpc                        randconfig-002    gcc-14.3.0
powerpc               randconfig-002-20260827    clang-17
powerpc               randconfig-002-20260827    gcc-14.3.0
powerpc                     tqm8555_defconfig    clang-14
powerpc                         wii_defconfig    clang-14
powerpc64                      randconfig-001    gcc-14.3.0
powerpc64             randconfig-001-20260827    gcc-14.3.0
powerpc64             randconfig-001-20260827    gcc-15.2.0
powerpc64                      randconfig-002    gcc-14.3.0
powerpc64             randconfig-002-20260827    gcc-13.4.0
powerpc64             randconfig-002-20260827    gcc-14.3.0
riscv                            allmodconfig    clang-14
riscv                             allnoconfig    clang-14
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-14
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260827    clang-14
riscv                 randconfig-001-20260827    gcc-8.5.0
riscv                 randconfig-002-20260827    clang-14
s390                             allmodconfig    clang-14
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-14
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260827    clang-14
s390                  randconfig-001-20260827    gcc-10.5.0
s390                  randconfig-002-20260827    clang-14
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-14
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                         ecovec24_defconfig    gcc-16.1.0
sh                    randconfig-001-20260827    clang-14
sh                    randconfig-001-20260827    gcc-13.4.0
sh                    randconfig-002-20260827    clang-14
sh                    randconfig-002-20260827    gcc-11.5.0
sh                          rsk7264_defconfig    clang-14
sparc                             allnoconfig    clang-14
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260827    gcc-10.5.0
sparc                 randconfig-001-20260827    gcc-12.5.0
sparc                 randconfig-002-20260827    gcc-10.5.0
sparc                 randconfig-002-20260827    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260827    clang-20
sparc64               randconfig-001-20260827    gcc-10.5.0
sparc64               randconfig-002-20260827    gcc-10.5.0
sparc64               randconfig-002-20260827    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-14
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260827    clang-14
um                    randconfig-001-20260827    gcc-10.5.0
um                    randconfig-002-20260827    clang-17
um                    randconfig-002-20260827    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-14
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260827    clang-22
x86_64      buildonly-randconfig-002-20260827    clang-22
x86_64      buildonly-randconfig-003-20260827    clang-22
x86_64      buildonly-randconfig-004-20260827    clang-22
x86_64      buildonly-randconfig-005-20260827    clang-22
x86_64      buildonly-randconfig-006-20260827    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260827    clang-22
x86_64                randconfig-011-20260827    gcc-14
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260827    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260827    clang-22
x86_64                randconfig-013-20260827    gcc-14
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260827    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260827    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260827    clang-22
x86_64                randconfig-016-20260827    gcc-12
x86_64                randconfig-071-20260827    gcc-14
x86_64                randconfig-072-20260827    gcc-14
x86_64                randconfig-073-20260827    clang-22
x86_64                randconfig-073-20260827    gcc-14
x86_64                randconfig-074-20260827    clang-22
x86_64                randconfig-074-20260827    gcc-14
x86_64                randconfig-075-20260827    gcc-14
x86_64                randconfig-076-20260827    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-14
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260827    gcc-10.5.0
xtensa                randconfig-001-20260827    gcc-16.1.0
xtensa                randconfig-002-20260827    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
