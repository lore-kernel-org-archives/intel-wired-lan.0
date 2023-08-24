Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E78C6FA8F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Aug 2023 11:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3510982EB5;
	Thu, 24 Aug 2023 11:58:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3510982EB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692878306;
	bh=OeRjKHQzQ8pMHvbf9TdQ7Etg0LPJc+zRvJTcl4yA+bk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DQv3Si0/tO+HjINaT5fyTcxV0EymWauzsnl5OmMv9jblHRsOnBCMjfgwEzpLBxOu8
	 K2NejLwBuimK8pzfGzj8anrPWXajvrE0tI5vCJZbQ9Dz+O8ix2gR5L4tHeNyHbm+gd
	 BPQ11+cHipG1W+1F9qjesq/izmcR1h96FDJkVAVwo4q5x9KSBTbh6uC/qbdMY7oLdD
	 cCSirqb+B4GOGSmHyOUsn8Rbe0mLju0+OGUAQt4P2B7E8N97GcUs1WD/BLqmpVfmA4
	 qdkFPcZaqMEVcrcoUCW3Ym3icOfPq18xwARw9xZRPWUIYWlwsHAzkDBY3CSNcLSZ9Y
	 08XEnBXkAjc2Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BtoDdAwbulPr; Thu, 24 Aug 2023 11:58:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1838B82D40;
	Thu, 24 Aug 2023 11:58:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1838B82D40
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 7CDA71BF39A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 11:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 50856416B4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 11:58:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50856416B4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qj6ZCr85EeIA for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Aug 2023 11:58:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07C69414D1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 11:58:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07C69414D1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="359402612"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="359402612"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 04:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="827095657"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="827095657"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
 by FMSMGA003.fm.intel.com with ESMTP; 24 Aug 2023 04:58:17 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qZ8ye-0002Gq-1D
 for intel-wired-lan@lists.osuosl.org; Thu, 24 Aug 2023 11:58:16 +0000
Date: Thu, 24 Aug 2023 19:57:33 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202308241931.Nwc0jdN4-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692878299; x=1724414299;
 h=date:from:to:subject:message-id;
 bh=SnoGK54VnMWYxET2+Dur/ISRgxOIBd4XeYMlEgHVktU=;
 b=UjUL0DyPmGA6eeCmgk0YlTyeiTlb3P6+5g2AY0ycKmjO+TpM6SB/FhyB
 fEd3It3ZsPEZmsQ98tWtOqTmR8rCiYhq7f1SUrvs0jMA3wvigWRimJrD8
 dgIrAqzgcHdMtFAAwMY/oyqhMG/KoV0pOk7Dj5pKgy5DckidlwHT8rlrH
 WkGWv2BCHE+9UAsX6b7GTXVW3kAnAkxq88XCRBifXTYF5NdOyRK30Dx62
 BRVhuZADMrFXsl2aSbOVQYgbWhdHSO5KhBhJw5Umm104hz71jBGEBtSvF
 TsR9E4fjhgK+MbLpYH5wJU9AzMeLHOWkIJoh3FpiSD12vbVQc+GyMH7P/
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UjUL0DyP
Subject: [Intel-wired-lan] [tnguy-net-queue:100GbE] BUILD SUCCESS
 67f6317dfa609846a227a706532439a22828c24b
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 67f6317dfa609846a227a706532439a22828c24b  ice: Fix NULL pointer deref during VF reset

elapsed time: 3932m

configs tested: 172
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230822   gcc  
alpha                randconfig-r023-20230822   gcc  
alpha                randconfig-r036-20230822   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230822   gcc  
arc                  randconfig-r003-20230822   gcc  
arc                  randconfig-r032-20230822   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20230822   gcc  
arm                  randconfig-r002-20230822   clang
arm                  randconfig-r016-20230822   gcc  
arm                        spear3xx_defconfig   clang
arm                       versatile_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230822   gcc  
csky                 randconfig-r022-20230822   gcc  
hexagon               randconfig-001-20230822   clang
hexagon               randconfig-002-20230822   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230822   gcc  
i386         buildonly-randconfig-002-20230822   gcc  
i386         buildonly-randconfig-003-20230822   gcc  
i386         buildonly-randconfig-004-20230822   gcc  
i386         buildonly-randconfig-005-20230822   gcc  
i386         buildonly-randconfig-006-20230822   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230822   gcc  
i386                  randconfig-002-20230822   gcc  
i386                  randconfig-003-20230822   gcc  
i386                  randconfig-004-20230822   gcc  
i386                  randconfig-005-20230822   gcc  
i386                  randconfig-006-20230822   gcc  
i386                  randconfig-011-20230822   clang
i386                  randconfig-012-20230822   clang
i386                  randconfig-013-20230822   clang
i386                  randconfig-014-20230822   clang
i386                  randconfig-015-20230822   clang
i386                  randconfig-016-20230822   clang
i386                 randconfig-r005-20230822   gcc  
i386                 randconfig-r031-20230822   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230822   gcc  
loongarch            randconfig-r012-20230822   gcc  
loongarch            randconfig-r014-20230822   gcc  
loongarch            randconfig-r024-20230822   gcc  
loongarch            randconfig-r025-20230822   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                 randconfig-r033-20230822   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r026-20230822   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                    ge_imp3a_defconfig   clang
powerpc                     kmeter1_defconfig   clang
powerpc                   microwatt_defconfig   clang
powerpc                         ps3_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   gcc  
riscv                 randconfig-001-20230822   gcc  
riscv                randconfig-r011-20230822   clang
riscv                randconfig-r015-20230822   clang
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230822   clang
s390                 randconfig-r034-20230822   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r013-20230822   gcc  
sh                           se7619_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r035-20230822   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r001-20230822   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230822   clang
x86_64                randconfig-002-20230822   clang
x86_64                randconfig-003-20230822   clang
x86_64                randconfig-004-20230822   clang
x86_64                randconfig-005-20230822   clang
x86_64                randconfig-006-20230822   clang
x86_64                randconfig-011-20230822   gcc  
x86_64                randconfig-012-20230822   gcc  
x86_64                randconfig-013-20230822   gcc  
x86_64                randconfig-014-20230822   gcc  
x86_64                randconfig-015-20230822   gcc  
x86_64                randconfig-016-20230822   gcc  
x86_64                randconfig-071-20230822   gcc  
x86_64                randconfig-072-20230822   gcc  
x86_64                randconfig-073-20230822   gcc  
x86_64                randconfig-074-20230822   gcc  
x86_64                randconfig-075-20230822   gcc  
x86_64                randconfig-076-20230822   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa               randconfig-r021-20230822   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
