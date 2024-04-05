Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00632CD11C2
	for <intel-wired-lan@archiver.kernel.org>; Fri,  5 Apr 2024 13:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84BB54181F;
	Fri,  5 Apr 2024 13:02:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MhmjyAExgxQy; Fri,  5 Apr 2024 13:02:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3CA314180B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1712322174;
	bh=zhsAGOiga2CjXGGnCI2p7oe6W9Oaxip35uHHfwAwvVQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PTs8eKJfnPEsOUWC0v0IkUx4q5f2uYoDyu3FG33UqUuzIxXyQnwpmQsZqGyfrW5OU
	 +qNxIas/cis/0Oltdl+sMrrgzABdCyHeRsGFeJlV74ZF5Qy4bOwfA9zsz+tVdunpp6
	 2vXqXFuyOVl+g+Rb6y/B84iEF4XEIwtE5GuGRHcLIrEpYr2eVdUeU6Yc6Skbp0XuLR
	 nHJdabrsTCaTbP1C+L2XTbEegh7sAryUvg0kG0XiNq8mRs9kKzoZQazpCkUqfUcij7
	 17xe9SeSYoWQkOCB9cGA3RqPfjUUamuIW9PssqSefQ+uL+0SHYF5cxtz8cfChvvY1a
	 uFJWOG60+iBjw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CA314180B;
	Fri,  5 Apr 2024 13:02:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 06A231BF310
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Apr 2024 13:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE220417EA
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Apr 2024 13:02:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id szrCKt7YUoey for <intel-wired-lan@lists.osuosl.org>;
 Fri,  5 Apr 2024 13:02:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6D729417ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D729417ED
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D729417ED
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Apr 2024 13:02:49 +0000 (UTC)
X-CSE-ConnectionGUID: gZiHp+7rQ3iZ/bMXiL85Fw==
X-CSE-MsgGUID: TGTTb7dBQxugoo9YbvO7Tw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7811766"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7811766"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2024 06:02:48 -0700
X-CSE-ConnectionGUID: Aeuc3ZEkTZCovkQ3Ls3MXA==
X-CSE-MsgGUID: Cw0yZ8KCT1OOoJG/Axx/aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; d="scan'208";a="23644914"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 05 Apr 2024 06:02:47 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1rsjDQ-0002Hl-1m
 for intel-wired-lan@lists.osuosl.org; Fri, 05 Apr 2024 13:02:44 +0000
Date: Fri, 05 Apr 2024 21:01:56 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202404052154.QlOVqmlL-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712322170; x=1743858170;
 h=date:from:to:subject:message-id;
 bh=wrFaURfnL+XFMTWmfCTZhQl62m1wSGBFAOUmmOjuKXY=;
 b=S5PwLQH1PfVxoEsbB70gWl7p+S8ZEuM9dJNbS0gDlpQTNBNmUTVVS2+5
 +N5Tt7eH3VxkigLfeKpj4wQIX4Qg0s7SzQQe1UVfDF2fwo0oegQ7OUOeh
 9TwTKbjyUNab1yxF3daF3jgbne7jDeM+3hlabRZKD2nNyPWawvyJgGvLZ
 FC1qAazZSOv1CpQIJJAyvVzBeZ+Ru6MNRFBq3JPW4xnxGGVCTUnD9M1jc
 l+0mwJMAS4kWKEXUTrkjpcPXSC66uGGb41mwMx5pHnoyF/RJparoMkt3E
 FogoqdzWrSFmdtzuJv01ikyHZMBQfpWjzt50UgNM3rZvV57K5L0HhaDzc
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=S5PwLQH1
Subject: [Intel-wired-lan] [tnguy-next-queue:10GbE] BUILD SUCCESS
 1dee310c26677460fc1cc1d98c2d90b6e968988c
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
branch HEAD: 1dee310c26677460fc1cc1d98c2d90b6e968988c  Merge branch 'bnxt_en-update-for-net-next'

elapsed time: 1232m

configs tested: 164
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240405   gcc  
arc                   randconfig-002-20240405   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                   randconfig-001-20240405   gcc  
arm                   randconfig-003-20240405   gcc  
arm                           tegra_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm                        vexpress_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240405   gcc  
arm64                 randconfig-002-20240405   gcc  
arm64                 randconfig-003-20240405   gcc  
arm64                 randconfig-004-20240405   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240405   gcc  
csky                  randconfig-002-20240405   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240405   gcc  
i386         buildonly-randconfig-002-20240405   gcc  
i386         buildonly-randconfig-003-20240405   clang
i386         buildonly-randconfig-004-20240405   gcc  
i386         buildonly-randconfig-005-20240405   clang
i386         buildonly-randconfig-006-20240405   clang
i386                                defconfig   clang
i386                  randconfig-001-20240405   clang
i386                  randconfig-002-20240405   gcc  
i386                  randconfig-003-20240405   clang
i386                  randconfig-004-20240405   clang
i386                  randconfig-005-20240405   clang
i386                  randconfig-006-20240405   gcc  
i386                  randconfig-011-20240405   clang
i386                  randconfig-012-20240405   gcc  
i386                  randconfig-013-20240405   gcc  
i386                  randconfig-014-20240405   gcc  
i386                  randconfig-015-20240405   gcc  
i386                  randconfig-016-20240405   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240405   gcc  
loongarch             randconfig-002-20240405   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240405   gcc  
nios2                 randconfig-002-20240405   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240405   gcc  
parisc                randconfig-002-20240405   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                     powernv_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240405   gcc  
powerpc64             randconfig-002-20240405   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-002-20240405   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240405   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20240405   gcc  
sh                    randconfig-002-20240405   gcc  
sh                          sdk7786_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240405   gcc  
sparc64               randconfig-002-20240405   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240405   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-003-20240405   gcc  
x86_64       buildonly-randconfig-004-20240405   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-004-20240405   gcc  
x86_64                randconfig-006-20240405   gcc  
x86_64                randconfig-012-20240405   gcc  
x86_64                randconfig-013-20240405   gcc  
x86_64                randconfig-015-20240405   gcc  
x86_64                randconfig-016-20240405   gcc  
x86_64                randconfig-071-20240405   gcc  
x86_64                randconfig-072-20240405   gcc  
x86_64                randconfig-073-20240405   gcc  
x86_64                randconfig-074-20240405   gcc  
x86_64                randconfig-075-20240405   gcc  
x86_64                randconfig-076-20240405   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240405   gcc  
xtensa                randconfig-002-20240405   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
