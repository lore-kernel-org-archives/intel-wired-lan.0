Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B410C2BB3F
	for <intel-wired-lan@archiver.kernel.org>; Sun, 19 Nov 2023 02:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9DCE60B14;
	Sun, 19 Nov 2023 02:37:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9DCE60B14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700361463;
	bh=E/ftVfe8uXy+uh6SbxJ/pL893+o4zmH9pTatdt9SVAc=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UZRMuv7qF5Qf01/RjjSz3oVARTKtupvc+nGv9uB2NWsuJmYvR0WobCE6LPEiKDyS+
	 2sN6Bq5nYkH+yZQSnizRjQ7x+mRO96pK05UrlXmuw36ozcfmWEyULM/wg1TubJpRMB
	 Z6zYINaZdPe67wsIxI1kN6vicT1UcIE0SYINhRU3SQlBjXYjC23SW3f4nA94ClxXA9
	 0it21N3L0QJG8R7Vba7D1WhUQSx3f3apQ3WdHL7HZru3za8uWRZq5heawrnEhWZait
	 Sk8jQpG+qo5+1alO0V3Otysi2pBTDYLjsJUpoVyzj/l/kxZuEUvFwYEBVTZ5tjIydM
	 +FyAYldCGqYVw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iUBozE8--cIG; Sun, 19 Nov 2023 02:37:42 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87C4160B3C;
	Sun, 19 Nov 2023 02:37:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87C4160B3C
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 6A0841BF32A
 for <intel-wired-lan@lists.osuosl.org>; Sun, 19 Nov 2023 02:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F51A400CB
 for <intel-wired-lan@lists.osuosl.org>; Sun, 19 Nov 2023 02:37:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F51A400CB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uvQKc5vhLVXu for <intel-wired-lan@lists.osuosl.org>;
 Sun, 19 Nov 2023 02:37:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18D714004A
 for <intel-wired-lan@lists.osuosl.org>; Sun, 19 Nov 2023 02:37:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 18D714004A
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="391250657"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; d="scan'208";a="391250657"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2023 18:37:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; d="scan'208";a="14252906"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
 by fmviesa001.fm.intel.com with ESMTP; 18 Nov 2023 18:37:35 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1r4Xgi-0004Yh-1H
 for intel-wired-lan@lists.osuosl.org; Sun, 19 Nov 2023 02:37:32 +0000
Date: Sun, 19 Nov 2023 10:37:30 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202311191028.CUuiAYrL-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700361458; x=1731897458;
 h=date:from:to:subject:message-id;
 bh=ywcAAEn0ZuYg5ED6S8YcHtDQWEFEwLCImi2YlvM0seE=;
 b=OzdtM7lit7nZX1Y+wqUdf1s9RkZ6ZKdhq10SkIWZ145tRlkzF9jYjSgB
 //OcG96C5M2mmv73TLGRYmETV44X/3UVxpwCEa1N4JX8m5k+w7QOSEM+g
 t5HV+7nG6i2NAQqAXJ+BO9cV/FJYwU/SfHrHmhsl6VByJRyUU7Elv1ViN
 KtkH3A4AXk2Qe/Y+dQojMEftU6aZU9Nd0j5DMy5t81pw7sCQ5Fcadfhoa
 XbaI/m/bhqJj5qprdR+CxJUyWldmkyAfQJ9XjSKBDXRhW+/nxM0yucCnA
 uOdQCxMeXP0lyESSws4aCSe2oQz3ttEHxrVnsFWpguug/IgblwOlTRjAx
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OzdtM7li
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 0bc3ba7401701ec2c8a1fee22df64e2158819002
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 0bc3ba7401701ec2c8a1fee22df64e2158819002  i40e: Fix unexpected MFS warning message

elapsed time: 3413m

configs tested: 325
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231117   gcc  
arc                   randconfig-001-20231118   gcc  
arc                   randconfig-002-20231117   gcc  
arc                   randconfig-002-20231118   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20231117   gcc  
arm                   randconfig-001-20231118   gcc  
arm                   randconfig-002-20231117   gcc  
arm                   randconfig-002-20231118   gcc  
arm                   randconfig-003-20231117   gcc  
arm                   randconfig-003-20231118   gcc  
arm                   randconfig-004-20231117   gcc  
arm                   randconfig-004-20231118   gcc  
arm                           sunxi_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231117   gcc  
arm64                 randconfig-001-20231118   gcc  
arm64                 randconfig-002-20231117   gcc  
arm64                 randconfig-002-20231118   gcc  
arm64                 randconfig-003-20231117   gcc  
arm64                 randconfig-003-20231118   gcc  
arm64                 randconfig-004-20231117   gcc  
arm64                 randconfig-004-20231118   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231117   gcc  
csky                  randconfig-001-20231118   gcc  
csky                  randconfig-002-20231117   gcc  
csky                  randconfig-002-20231118   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231117   gcc  
i386         buildonly-randconfig-001-20231118   gcc  
i386         buildonly-randconfig-001-20231119   gcc  
i386         buildonly-randconfig-002-20231117   gcc  
i386         buildonly-randconfig-002-20231118   gcc  
i386         buildonly-randconfig-002-20231119   gcc  
i386         buildonly-randconfig-003-20231117   gcc  
i386         buildonly-randconfig-003-20231118   gcc  
i386         buildonly-randconfig-003-20231119   gcc  
i386         buildonly-randconfig-004-20231117   gcc  
i386         buildonly-randconfig-004-20231118   gcc  
i386         buildonly-randconfig-004-20231119   gcc  
i386         buildonly-randconfig-005-20231117   gcc  
i386         buildonly-randconfig-005-20231118   gcc  
i386         buildonly-randconfig-005-20231119   gcc  
i386         buildonly-randconfig-006-20231117   gcc  
i386         buildonly-randconfig-006-20231118   gcc  
i386         buildonly-randconfig-006-20231119   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231117   gcc  
i386                  randconfig-001-20231118   gcc  
i386                  randconfig-001-20231119   gcc  
i386                  randconfig-002-20231117   gcc  
i386                  randconfig-002-20231118   gcc  
i386                  randconfig-002-20231119   gcc  
i386                  randconfig-003-20231117   gcc  
i386                  randconfig-003-20231118   gcc  
i386                  randconfig-003-20231119   gcc  
i386                  randconfig-004-20231117   gcc  
i386                  randconfig-004-20231118   gcc  
i386                  randconfig-004-20231119   gcc  
i386                  randconfig-005-20231117   gcc  
i386                  randconfig-005-20231118   gcc  
i386                  randconfig-005-20231119   gcc  
i386                  randconfig-006-20231117   gcc  
i386                  randconfig-006-20231118   gcc  
i386                  randconfig-006-20231119   gcc  
i386                  randconfig-011-20231117   gcc  
i386                  randconfig-011-20231118   gcc  
i386                  randconfig-011-20231119   gcc  
i386                  randconfig-012-20231117   gcc  
i386                  randconfig-012-20231118   gcc  
i386                  randconfig-012-20231119   gcc  
i386                  randconfig-013-20231117   gcc  
i386                  randconfig-013-20231118   gcc  
i386                  randconfig-013-20231119   gcc  
i386                  randconfig-014-20231117   gcc  
i386                  randconfig-014-20231118   gcc  
i386                  randconfig-014-20231119   gcc  
i386                  randconfig-015-20231117   gcc  
i386                  randconfig-015-20231118   gcc  
i386                  randconfig-015-20231119   gcc  
i386                  randconfig-016-20231117   gcc  
i386                  randconfig-016-20231118   gcc  
i386                  randconfig-016-20231119   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231117   gcc  
loongarch             randconfig-001-20231118   gcc  
loongarch             randconfig-002-20231117   gcc  
loongarch             randconfig-002-20231118   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231117   gcc  
nios2                 randconfig-001-20231118   gcc  
nios2                 randconfig-002-20231117   gcc  
nios2                 randconfig-002-20231118   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231117   gcc  
parisc                randconfig-001-20231118   gcc  
parisc                randconfig-002-20231117   gcc  
parisc                randconfig-002-20231118   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc               randconfig-001-20231117   gcc  
powerpc               randconfig-001-20231118   gcc  
powerpc               randconfig-002-20231117   gcc  
powerpc               randconfig-002-20231118   gcc  
powerpc               randconfig-003-20231117   gcc  
powerpc               randconfig-003-20231118   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20231117   gcc  
powerpc64             randconfig-001-20231118   gcc  
powerpc64             randconfig-002-20231117   gcc  
powerpc64             randconfig-002-20231118   gcc  
powerpc64             randconfig-003-20231117   gcc  
powerpc64             randconfig-003-20231118   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231117   gcc  
riscv                 randconfig-001-20231118   gcc  
riscv                 randconfig-002-20231117   gcc  
riscv                 randconfig-002-20231118   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231117   gcc  
s390                  randconfig-001-20231118   gcc  
s390                  randconfig-002-20231117   gcc  
s390                  randconfig-002-20231118   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20231117   gcc  
sh                    randconfig-001-20231118   gcc  
sh                    randconfig-002-20231117   gcc  
sh                    randconfig-002-20231118   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231117   gcc  
sparc64               randconfig-001-20231118   gcc  
sparc64               randconfig-002-20231117   gcc  
sparc64               randconfig-002-20231118   gcc  
um                               allmodconfig   gcc  
um                                allnoconfig   gcc  
um                               allyesconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231117   gcc  
um                    randconfig-001-20231118   gcc  
um                    randconfig-002-20231117   gcc  
um                    randconfig-002-20231118   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231117   gcc  
x86_64       buildonly-randconfig-001-20231118   gcc  
x86_64       buildonly-randconfig-001-20231119   gcc  
x86_64       buildonly-randconfig-002-20231117   gcc  
x86_64       buildonly-randconfig-002-20231118   gcc  
x86_64       buildonly-randconfig-002-20231119   gcc  
x86_64       buildonly-randconfig-003-20231117   gcc  
x86_64       buildonly-randconfig-003-20231118   gcc  
x86_64       buildonly-randconfig-003-20231119   gcc  
x86_64       buildonly-randconfig-004-20231117   gcc  
x86_64       buildonly-randconfig-004-20231118   gcc  
x86_64       buildonly-randconfig-004-20231119   gcc  
x86_64       buildonly-randconfig-005-20231117   gcc  
x86_64       buildonly-randconfig-005-20231118   gcc  
x86_64       buildonly-randconfig-005-20231119   gcc  
x86_64       buildonly-randconfig-006-20231117   gcc  
x86_64       buildonly-randconfig-006-20231118   gcc  
x86_64       buildonly-randconfig-006-20231119   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231117   gcc  
x86_64                randconfig-001-20231118   gcc  
x86_64                randconfig-001-20231119   gcc  
x86_64                randconfig-002-20231117   gcc  
x86_64                randconfig-002-20231118   gcc  
x86_64                randconfig-002-20231119   gcc  
x86_64                randconfig-003-20231117   gcc  
x86_64                randconfig-003-20231118   gcc  
x86_64                randconfig-003-20231119   gcc  
x86_64                randconfig-004-20231117   gcc  
x86_64                randconfig-004-20231118   gcc  
x86_64                randconfig-004-20231119   gcc  
x86_64                randconfig-005-20231117   gcc  
x86_64                randconfig-005-20231118   gcc  
x86_64                randconfig-005-20231119   gcc  
x86_64                randconfig-006-20231117   gcc  
x86_64                randconfig-006-20231118   gcc  
x86_64                randconfig-006-20231119   gcc  
x86_64                randconfig-011-20231117   gcc  
x86_64                randconfig-011-20231118   gcc  
x86_64                randconfig-011-20231119   gcc  
x86_64                randconfig-012-20231117   gcc  
x86_64                randconfig-012-20231118   gcc  
x86_64                randconfig-012-20231119   gcc  
x86_64                randconfig-013-20231117   gcc  
x86_64                randconfig-013-20231118   gcc  
x86_64                randconfig-013-20231119   gcc  
x86_64                randconfig-014-20231117   gcc  
x86_64                randconfig-014-20231118   gcc  
x86_64                randconfig-014-20231119   gcc  
x86_64                randconfig-015-20231117   gcc  
x86_64                randconfig-015-20231118   gcc  
x86_64                randconfig-015-20231119   gcc  
x86_64                randconfig-016-20231117   gcc  
x86_64                randconfig-016-20231118   gcc  
x86_64                randconfig-016-20231119   gcc  
x86_64                randconfig-071-20231117   gcc  
x86_64                randconfig-071-20231118   gcc  
x86_64                randconfig-071-20231119   gcc  
x86_64                randconfig-072-20231117   gcc  
x86_64                randconfig-072-20231118   gcc  
x86_64                randconfig-072-20231119   gcc  
x86_64                randconfig-073-20231117   gcc  
x86_64                randconfig-073-20231118   gcc  
x86_64                randconfig-073-20231119   gcc  
x86_64                randconfig-074-20231117   gcc  
x86_64                randconfig-074-20231118   gcc  
x86_64                randconfig-074-20231119   gcc  
x86_64                randconfig-075-20231117   gcc  
x86_64                randconfig-075-20231118   gcc  
x86_64                randconfig-075-20231119   gcc  
x86_64                randconfig-076-20231117   gcc  
x86_64                randconfig-076-20231118   gcc  
x86_64                randconfig-076-20231119   gcc  
x86_64                           rhel-8.3-bpf   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20231117   gcc  
xtensa                randconfig-001-20231118   gcc  
xtensa                randconfig-002-20231117   gcc  
xtensa                randconfig-002-20231118   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
