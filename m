Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A75CC61DBD
	for <intel-wired-lan@archiver.kernel.org>; Fri, 28 Aug 2026 12:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1124380DD4;
	Fri, 28 Aug 2026 12:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IWhZTPp4KIkU; Fri, 28 Aug 2026 12:43:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787921010;
	bh=jkrbtwxUQPw8R+fhb6Pc+GpByPjZcP6GInwZtd6vb7E=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FqSCfO5fWWIEcYWASXE3cgp9Nc9uQ5tNWpuDJy8V9hKeXNq9Rw/1xNgRj85zi9pTa
	 2ak7+F8z0Cgxm1H3SMHOYoWYspVNDDX2WxqEkUuY1Et68rCUXJ3pcYBbyY589jhagq
	 +CqiIwudpPCxxjRmTwjqgGXL7xSJpvEWWyjZJ+fDYNF7jrnhF5m+PFf9Ok7bpsEpcA
	 y7D9M0kjNLyvEIrIgYNFS9+Bk+NwtOQUYREeFfEKYfXSgUIK8VD+y+yB8ibcMkSbja
	 JH+PXLOWXi+o3mQ7eV+AoQRuYp3CCtcJwA8Ewd/tRhuVuxDviRe/5zt4u2Uc6WZZgJ
	 sAi9e/uzTjMDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF13280E6B;
	Fri, 28 Aug 2026 12:43:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E3E023E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 12:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 846E480E6B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 12:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d_ppD_G28KR3 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 28 Aug 2026 12:43:28 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=m8aFDgYt
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2981680DD4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 12:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787921008; x=1819457008; h=date:from:to:subject:message-id;
 bh=UJzzUzwPJEO0B5pP21Gu2PujW3Kgvk4fOXNpj0z6spA=;
 b=m8aFDgYtUXxqkkf8Vzie3nHRNyw80iJq2+oC4plEVGOrL0fKzlHB1G40
 SutmgsGbuY9oBg1XdDTD/UAfcFad2dwtgx/G/FmixKphVuNHvcaUF5sre
 EiTNAi6CxIySXVqhBuhxrAYUbdpPRBJaA1xub08h4Mz+5E03ELllWrR4n
 qLTcf+9XMRqo8wJm3mQhqlVx7bL8fkjCyS5FmMk/dwyOdq/QXU2Hmq1ik
 I3H7y0khnsXi2slSzcMWAX05/hIN5sljsf3iQ5txvQbjmlW5a0MLQYDdf
 M2miUoEfOuQ3gtIe2QI9+dVY1I6AhCb2T6jm/Gf4c3G9iGXva/R/GSJM8 Q==;
X-CSE-ConnectionGUID: oHZ4ZDU/SDuxq+DJz4kdxg==
X-CSE-MsgGUID: WikPnaa8T36BwAKfhl+Sbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99942729"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="99942729"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 05:43:27 -0700
X-CSE-ConnectionGUID: TKpjT+oCTgO1VaUBLbwmxg==
X-CSE-MsgGUID: ZLxX+dewRhq6C5OSZx7QgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="266339957"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 28 Aug 2026 05:43:26 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wzvvX-00000000B8J-3aso;
 Fri, 28 Aug 2026 12:43:23 +0000
Date: Fri, 28 Aug 2026 20:42:33 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 fca3646947cc1a6b4488af5a0682ca82a9ad97b0
Message-ID: <202608282022.f60RXnJ1-lkp@intel.com>
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
branch HEAD: fca3646947cc1a6b4488af5a0682ca82a9ad97b0  i40e: avoid resetting BQL state when freeing temporary Tx rings in set_ringparam

elapsed time: 2965m

configs tested: 283
configs skipped: 21

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-14
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-14
arc                              allyesconfig    clang-24
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                        nsim_700_defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260827    gcc-15.2.0
arc                   randconfig-001-20260827    gcc-16.1.0
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260827    gcc-15.2.0
arc                   randconfig-002-20260827    gcc-16.1.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-14
arm                       aspeed_g5_defconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                            mmp2_defconfig    gcc-16.1.0
arm                        neponset_defconfig    gcc-16.1.0
arm                             pxa_defconfig    clang-19
arm                            qcom_defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260827    gcc-15.2.0
arm                   randconfig-001-20260827    gcc-16.1.0
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260827    gcc-15.2.0
arm                   randconfig-002-20260827    gcc-16.1.0
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260827    gcc-15.2.0
arm                   randconfig-003-20260827    gcc-16.1.0
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260827    gcc-15.2.0
arm                   randconfig-004-20260827    gcc-16.1.0
arm                         socfpga_defconfig    gcc-16.1.0
arm                           stm32_defconfig    gcc-16.1.0
arm64                            alldefconfig    clang-19
arm64                            allmodconfig    clang-14
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260827    clang-21
arm64                 randconfig-001-20260827    gcc-8.5.0
arm64                 randconfig-002-20260827    clang-21
arm64                 randconfig-002-20260827    gcc-8.5.0
arm64                 randconfig-003-20260827    clang-21
arm64                 randconfig-004-20260827    clang-21
arm64                 randconfig-004-20260827    gcc-8.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260827    clang-21
csky                  randconfig-001-20260827    gcc-8.5.0
csky                  randconfig-002-20260827    clang-21
csky                  randconfig-002-20260827    gcc-8.5.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260827    gcc-16.1.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260827    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260827    clang-22
i386        buildonly-randconfig-002-20260827    clang-22
i386        buildonly-randconfig-003-20260827    clang-22
i386        buildonly-randconfig-004-20260827    clang-22
i386        buildonly-randconfig-005-20260827    clang-22
i386        buildonly-randconfig-006-20260827    clang-22
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260827    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260827    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260827    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260827    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260827    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260827    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260827    gcc-14
i386                           randconfig-011    gcc-13
i386                  randconfig-011-20260827    clang-22
i386                  randconfig-011-20260827    gcc-13
i386                           randconfig-012    gcc-13
i386                  randconfig-012-20260827    gcc-13
i386                           randconfig-013    gcc-13
i386                  randconfig-013-20260827    gcc-13
i386                           randconfig-014    gcc-13
i386                  randconfig-014-20260827    gcc-13
i386                           randconfig-015    gcc-13
i386                  randconfig-015-20260827    gcc-13
i386                           randconfig-016    gcc-13
i386                  randconfig-016-20260827    gcc-13
i386                           randconfig-017    gcc-13
i386                  randconfig-017-20260827    gcc-13
loongarch                        alldefconfig    gcc-16.1.0
loongarch                        allmodconfig    clang-14
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-14
loongarch                           defconfig    clang-24
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260827    gcc-16.1.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260827    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-14
m68k                                defconfig    clang-14
m68k                                defconfig    clang-24
m68k                         nettel_defconfig    gcc-16.1.0
m68k                            q40_defconfig    clang-19
microblaze                       alldefconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-14
microblaze                          defconfig    clang-24
microblaze                      mmu_defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                       bmips_be_defconfig    gcc-16.1.0
mips                           gcw0_defconfig    clang-19
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-14
nios2                             allnoconfig    clang-24
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-14
nios2                               defconfig    clang-24
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260827    gcc-16.1.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260827    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-14
openrisc                          allnoconfig    clang-24
openrisc         de0_nano_multicore_defconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
openrisc                  or1klitex_defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-14
parisc                            allnoconfig    clang-24
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                generic-32bit_defconfig    clang-19
parisc                randconfig-001-20260827    gcc-14.3.0
parisc                randconfig-002-20260827    gcc-14.3.0
parisc64                            defconfig    clang-14
parisc64                            defconfig    clang-24
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-14
powerpc                           allnoconfig    clang-24
powerpc                    amigaone_defconfig    gcc-16.1.0
powerpc                      ep88xc_defconfig    gcc-16.1.0
powerpc                    gamecube_defconfig    clang-19
powerpc               mpc834x_itxgp_defconfig    gcc-16.1.0
powerpc               randconfig-001-20260827    gcc-14.3.0
powerpc               randconfig-002-20260827    gcc-14.3.0
powerpc                     tqm5200_defconfig    clang-19
powerpc                     tqm8540_defconfig    gcc-16.1.0
powerpc                     tqm8541_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260827    gcc-14.3.0
powerpc64             randconfig-002-20260827    gcc-14.3.0
riscv                            allmodconfig    clang-14
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-14
riscv                             allnoconfig    clang-24
riscv                            allyesconfig    clang-14
riscv                               defconfig    gcc-16.1.0
riscv             nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-14
riscv                 randconfig-001-20260827    clang-14
riscv                          randconfig-002    clang-14
riscv                 randconfig-002-20260827    clang-14
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-14
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-14
s390                  randconfig-001-20260827    clang-14
s390                           randconfig-002    clang-14
s390                  randconfig-002-20260827    clang-14
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-14
sh                                allnoconfig    clang-24
sh                               allyesconfig    clang-17
sh                        apsh4ad0a_defconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                             randconfig-001    clang-14
sh                    randconfig-001-20260827    clang-14
sh                             randconfig-002    clang-14
sh                    randconfig-002-20260827    clang-14
sh                     sh7710voipgw_defconfig    gcc-16.1.0
sh                            shmin_defconfig    clang-19
sparc                             allnoconfig    clang-14
sparc                             allnoconfig    clang-24
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260827    gcc-10.5.0
sparc                 randconfig-002-20260827    gcc-10.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260827    gcc-10.5.0
sparc64               randconfig-002-20260827    gcc-10.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-14
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260827    gcc-10.5.0
um                    randconfig-002-20260827    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-14
x86_64                            allnoconfig    clang-24
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260827    clang-22
x86_64      buildonly-randconfig-002-20260827    clang-22
x86_64      buildonly-randconfig-003-20260827    clang-22
x86_64      buildonly-randconfig-004-20260827    clang-22
x86_64      buildonly-randconfig-005-20260827    clang-22
x86_64      buildonly-randconfig-006-20260827    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260827    clang-22
x86_64                randconfig-001-20260828    gcc-14
x86_64                randconfig-002-20260827    clang-22
x86_64                randconfig-002-20260827    gcc-14
x86_64                randconfig-002-20260828    gcc-14
x86_64                randconfig-003-20260827    clang-22
x86_64                randconfig-003-20260827    gcc-14
x86_64                randconfig-003-20260828    gcc-14
x86_64                randconfig-004-20260827    clang-22
x86_64                randconfig-004-20260827    gcc-14
x86_64                randconfig-004-20260828    gcc-14
x86_64                randconfig-005-20260827    clang-22
x86_64                randconfig-005-20260828    gcc-14
x86_64                randconfig-006-20260827    clang-22
x86_64                randconfig-006-20260828    gcc-14
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260827    clang-22
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260827    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260827    clang-22
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260827    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260827    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260827    clang-22
x86_64                randconfig-071-20260827    gcc-14
x86_64                randconfig-072-20260827    gcc-14
x86_64                randconfig-073-20260827    gcc-14
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
xtensa                            allnoconfig    clang-24
xtensa                           allyesconfig    clang-20
xtensa                generic_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-001-20260827    gcc-10.5.0
xtensa                randconfig-002-20260827    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
