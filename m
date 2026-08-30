Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D7EC61DD9
	for <intel-wired-lan@archiver.kernel.org>; Sun, 30 Aug 2026 06:11:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1B9D40633;
	Sun, 30 Aug 2026 06:11:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YY77x79uK2n1; Sun, 30 Aug 2026 06:11:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788070266;
	bh=5qKWQdjYlf/mwu1SSHT1RT3/rC20vLxJ8NptMwZJnio=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i0eroOJ27e3xXN4PUi2e/uXlFGZy6Ywb3+vUTWsN5ev/SDMKCbIHh0MEKehkl0vdm
	 71buXxalnX80x2zj1Qq/aPjGKhQ5hd2Gyc2o11U7JDnGLVbaFkz+1DQjP5YGo8fwj9
	 EEHCXZUkPBtqhtWfstuRd0EzbYEVOrG14aWsQtNTkZxwye5x/mSmvOmMJce2M1WkeS
	 OxLKtN0TC7yjyfIaSaTkkCl+vgPwJKpTF7hLBkcQ4f6wz7QIUVXeisSxrhHcwHjzOH
	 w5UCI/I1CoOeU8t8+55Wy/8DuJULqSJKseb7IIJK551RBUePp3tH31I5n3GD9dVL8H
	 YyIyXCbc6YKQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 073EF40634;
	Sun, 30 Aug 2026 06:11:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF7DF34E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 06:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B10E540082
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 06:11:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHOVg68qUIhx for <intel-wired-lan@lists.osuosl.org>;
 Sun, 30 Aug 2026 06:11:03 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=a5+TPH9d
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7A4D40050
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 06:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788070263; x=1819606263; h=date:from:to:subject:message-id;
 bh=8Fs/IHGE+a1CjGGla+80rMnEYZoAZ8GitrcTQyr2fOM=;
 b=a5+TPH9dmFi7NBF3I2BaH0QpgCQcdLkRmmxTDsN57/f3V7pqU5v3Rxqw
 MgUCwOm0BXmMyuhlZWhnodwvW/p8LWL85cyYhuOJlnIhojTI0t9QlHB6o
 ZXjPhKPJ9dYuBwXWnvZhD4dXebbRiqCoi3cSNTOJIXNMY6+4wkDmsHs+N
 8eInqyU6B4OoOoyjd+qK1+mEjODeufUuJoNutzq+8dyTzu9nkx1g/Fj1/
 uq5xE4ZB0r6tdx3eOVs07qh8T6WcVM4RQwmFeWu+CE52tmlIXeDqny3YT
 sk5Hykaq+GYU7noZH0cL2aTYRpoONPzTNkTUw1xFcBHVGMJxjpLVb1G4L w==;
X-CSE-ConnectionGUID: sCEf6CtGSgWbfpVtW0PZig==
X-CSE-MsgGUID: O7VUjw8dSX247rVuGDCmEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="76058101"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="76058101"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2026 23:11:01 -0700
X-CSE-ConnectionGUID: d9y+BaMvTVOh+gaJu2rOBw==
X-CSE-MsgGUID: 3aYACnE1S5WbG4DU7yReAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="264768024"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
 by fmviesa010.fm.intel.com with ESMTP; 29 Aug 2026 23:11:00 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x0Yks-00000000DdM-0NKW;
 Sun, 30 Aug 2026 06:10:58 +0000
Date: Sun, 30 Aug 2026 14:10:52 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 10b5e0324c4b3669bec7ec99e8dead440fa89281
Message-ID: <202608301439.LwCWd8YU-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 10b5e0324c4b3669bec7ec99e8dead440fa89281  igc: only strip RX timestamp header from first buffer

elapsed time: 766m

configs tested: 186
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-24
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260830    gcc-15.2.0
arc                   randconfig-002-20260830    gcc-15.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    clang-24
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                           omap1_defconfig    clang-24
arm                   randconfig-001-20260830    gcc-15.2.0
arm                   randconfig-002-20260830    gcc-15.2.0
arm                   randconfig-003-20260830    gcc-15.2.0
arm                   randconfig-004-20260830    gcc-15.2.0
arm                          sp7021_defconfig    clang-24
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260830    gcc-16.1.0
arm64                 randconfig-002-20260830    gcc-16.1.0
arm64                 randconfig-003-20260830    gcc-16.1.0
arm64                 randconfig-004-20260830    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260830    gcc-16.1.0
csky                  randconfig-002-20260830    gcc-16.1.0
hexagon                          allmodconfig    clang-24
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-24
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260830    clang-24
hexagon               randconfig-002-20260830    clang-24
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260830    clang-22
i386        buildonly-randconfig-002-20260830    clang-22
i386        buildonly-randconfig-003-20260830    clang-22
i386        buildonly-randconfig-004-20260830    clang-22
i386        buildonly-randconfig-005-20260830    clang-22
i386        buildonly-randconfig-006-20260830    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260830    clang-22
i386                  randconfig-002-20260830    clang-22
i386                  randconfig-003-20260830    clang-22
i386                  randconfig-004-20260830    clang-22
i386                  randconfig-005-20260830    clang-22
i386                  randconfig-006-20260830    clang-22
i386                  randconfig-007-20260830    clang-22
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260830    gcc-13.4.0
loongarch             randconfig-002-20260830    clang-19
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                             allyesconfig    gcc-16.1.0
m68k                         apollo_defconfig    gcc-16.1.0
m68k                                defconfig    clang-24
m68k                          sun3x_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-24
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                     cu1830-neo_defconfig    gcc-16.1.0
mips                    maltaup_xpa_defconfig    gcc-16.1.0
mips                           xway_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-24
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-24
nios2                 randconfig-001-20260830    gcc-9.5.0
nios2                 randconfig-002-20260830    gcc-11.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-24
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260830    gcc-13.4.0
parisc                randconfig-002-20260830    gcc-13.4.0
parisc64                            defconfig    clang-24
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                           allnoconfig    gcc-16.1.0
powerpc                    gamecube_defconfig    gcc-16.1.0
powerpc                     kmeter1_defconfig    clang-24
powerpc                 linkstation_defconfig    gcc-16.1.0
powerpc                     mpc5200_defconfig    clang-24
powerpc                     mpc83xx_defconfig    clang-24
powerpc               randconfig-001-20260830    gcc-13.4.0
powerpc               randconfig-002-20260830    gcc-13.4.0
powerpc64             randconfig-001-20260830    gcc-13.4.0
powerpc64             randconfig-002-20260830    gcc-13.4.0
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260830    gcc-16.1.0
riscv                 randconfig-002-20260830    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-24
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260830    gcc-16.1.0
s390                  randconfig-002-20260830    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    gcc-16.1.0
sh                    randconfig-001-20260830    gcc-16.1.0
sh                    randconfig-002-20260830    gcc-16.1.0
sh                           se7705_defconfig    clang-24
sh                           se7722_defconfig    clang-24
sh                           sh2007_defconfig    clang-24
sparc                             allnoconfig    clang-24
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-24
x86_64                           allyesconfig    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260830    gcc-14
x86_64                randconfig-002-20260830    gcc-14
x86_64                randconfig-003-20260830    gcc-14
x86_64                randconfig-004-20260830    gcc-14
x86_64                randconfig-005-20260830    gcc-14
x86_64                randconfig-006-20260830    gcc-14
x86_64                randconfig-011-20260830    clang-22
x86_64                randconfig-012-20260830    clang-22
x86_64                randconfig-013-20260830    clang-22
x86_64                randconfig-014-20260830    clang-22
x86_64                randconfig-015-20260830    clang-22
x86_64                randconfig-016-20260830    clang-22
x86_64                randconfig-071-20260830    gcc-14
x86_64                randconfig-072-20260830    gcc-14
x86_64                randconfig-073-20260830    gcc-14
x86_64                randconfig-074-20260830    gcc-14
x86_64                randconfig-075-20260830    gcc-14
x86_64                randconfig-076-20260830    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-24
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
