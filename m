Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B59C7618E
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Apr 2023 06:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9795740106;
	Sat, 22 Apr 2023 06:47:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9795740106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1682146065;
	bh=LXbmHUzfLFy2taKR3zHd3MU/rbxqS9ktP6kKWH6IAP4=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gZJrNPAXbXPDrDBFsjQTfcnBxe/KyUbdTqa8p2ky6RQreDodnueMFYc8mTiwVwIHP
	 X356wUqoX9E9kbdbEaHDEpXSTTF+3uo9hzU1Ng+Fv1ZgK74k2tvLAyzeCcTtJPDyK5
	 UoL9UKn25wnMigQ8CCctd7p9pcfVmvNwPv8RcDjFYIybfJz8YGawud2MxMNEWPvxGO
	 FBLv32d5sk5Fxxy73PCyaAiXrVyG1oZTGArNeH6k870xA7GFh1aP5kkWwBoTrj12+n
	 5hLx3w3uTNoO7xyoGgm80gpSYEJIhn8j4Lf5oNhJL4LRB4TAwKmhLOjRMYMhycdbHv
	 Q0F0FDFXtbXHw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Vju_63nI89e; Sat, 22 Apr 2023 06:47:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F26840298;
	Sat, 22 Apr 2023 06:47:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F26840298
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 577A21C2B8C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Apr 2023 06:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CE35404F4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Apr 2023 06:47:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CE35404F4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A6Zx5lgM8F56 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Apr 2023 06:47:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CBD840273
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CBD840273
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Apr 2023 06:47:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="325729315"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; d="scan'208";a="325729315"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2023 23:47:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="669931100"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; d="scan'208";a="669931100"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 21 Apr 2023 23:47:37 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pq721-000h8I-0I;
 Sat, 22 Apr 2023 06:47:37 +0000
Date: Sat, 22 Apr 2023 14:47:24 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <644382fc.eupbl/N9iBbefK31%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1682146060; x=1713682060;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=JVrqfpkOBZDjEhOvJTxVblsJpsjtdvT2aTxk0p78Tk4=;
 b=Oxetk/SCyXrNvdPquHFH43BNggmNdfrH2b9EAnVTA8LG93a/tvfIWWpS
 ztiA4hI75OHKuV9UAlLQbe+3BS49HU6Xgmmc1jHG1O2JgTnZEOdgRCWKr
 pAPu3CZQUQMY62a4q0Z1peKCv9XtTo7EEtiWgrWHakAVQ+AhF1LiAYfjJ
 JGH4GFEvrKksLx/5zltTFnyGjg9InXVOBF6Qr8z61Kz/4b5lWB8C9hucE
 GQ617CUcipbS3/mn/5JpYF7XCcSTYfjXGmMRT/0qJK0yXR2L6davRe5eM
 vrp3sT7hQpASBAKz8ODUEml7oqpS3Lem2OB3p+TTJuBk4smVr5yNT3emX
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Oxetk/SC
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 a99ebbc0676bf876eb6c19cbd552c6ed697e403f
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: a99ebbc0676bf876eb6c19cbd552c6ed697e403f  igc: Avoid transmit queue timeout for XDP

elapsed time: 728m

configs tested: 99
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230421   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230421   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230421   gcc  
arc                  randconfig-r033-20230421   gcc  
arc                  randconfig-r043-20230421   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230421   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230421   gcc  
hexagon              randconfig-r036-20230421   clang
hexagon              randconfig-r041-20230421   clang
hexagon              randconfig-r045-20230421   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230421   gcc  
ia64                 randconfig-r012-20230421   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230421   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r023-20230421   gcc  
m68k                 randconfig-r031-20230421   gcc  
microblaze   buildonly-randconfig-r003-20230421   gcc  
microblaze   buildonly-randconfig-r004-20230421   gcc  
microblaze           randconfig-r013-20230421   gcc  
microblaze           randconfig-r021-20230421   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r002-20230421   clang
mips                 randconfig-r006-20230421   clang
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230421   gcc  
nios2                randconfig-r016-20230421   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r035-20230421   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230421   clang
powerpc              randconfig-r026-20230421   clang
powerpc              randconfig-r032-20230421   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230421   gcc  
riscv                randconfig-r042-20230421   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r034-20230421   gcc  
s390                 randconfig-r044-20230421   clang
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230421   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
