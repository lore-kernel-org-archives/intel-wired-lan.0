Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29686C7618E
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Apr 2023 06:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC0A640298;
	Sat, 22 Apr 2023 06:47:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC0A640298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1682146069;
	bh=f7rl+fhmdLDDPmhc1KJjXvAy94z+Bbfx/d6IpWtCm90=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=medHfKmQ5rDcrCY+wVntetSUUcSQcjtkzG1/NTJN9S9uSDurLjJntWXTUORBS0ZtO
	 Dv8gEeRhG02nsLVLErrz3oXHgD4E7HCB2VlRl6P9TMcKkcbCkCJ/aZZdoRaznk/nUC
	 bW76w7X5c1ferHeKNPnfdEbl2kCcgWrORtHdyzm6UBA+EqKTbgHog98KQ3ZrGyry9b
	 hKrXTujoQsxKoTEGVs8VNSDvJvPZ6ZgtFDlFv3wSXu/3OM+nF9qPV8sq1qNttcFK8T
	 mbOUn3Qq9pNWhiYQn/wLo6TyfIMRs7RzeWHS4BHtVLwgxFVQXoHyLN/q8pV3CprHKj
	 MmRIw4KowuCeA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZsXP2XCf5EHx; Sat, 22 Apr 2023 06:47:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7DD7D404F5;
	Sat, 22 Apr 2023 06:47:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7DD7D404F5
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 67F241C2B8C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Apr 2023 06:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C9D2404F5
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Apr 2023 06:47:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C9D2404F5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YtCC_D5fn6RZ for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Apr 2023 06:47:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A79440106
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A79440106
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Apr 2023 06:47:39 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="411408849"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; d="scan'208";a="411408849"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2023 23:47:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="816662401"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; d="scan'208";a="816662401"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 21 Apr 2023 23:47:38 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pq721-000h8T-0g;
 Sat, 22 Apr 2023 06:47:37 +0000
Date: Sat, 22 Apr 2023 14:47:15 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <644382f3.uOcPz6aS7MIYxta6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1682146060; x=1713682060;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=R7zbkn+qyvqh/gyYVReU36eTy3VvEt96tIhvm0q4MwE=;
 b=ZWnAmOQeuyabGaOoCdFJqEnz/OmDJuxQPQVvq1aAG10eaL1BDf+JGrgZ
 A8ioHpGalOH8rxL4BlbsW3YKyNWq3WXulStpi63Akbm4qm3yYFLO28ebr
 G0WhxoRzV0SfFjEVm2oPmPRVdk1xnef4ixdAGjwNVDVurkfWqKsX7J6LS
 7fv+J6lmJ7j/+iBw8oaL1zHGzbO0zqLpzQQY2/Tn27z7l3rNeNQP+58UC
 nKwi6/y3tVzgdLEdWfih9xC3W+deaVXDGY46ZHK9eEM9dvqHSM+1NPBUM
 tmOS+2D3Wh9QtymvN3Q1SqvHk42V0m8mFWV+naT/lQpIT6l2qSxH14JK3
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZWnAmOQe
Subject: [Intel-wired-lan] [tnguy-next-queue:main] BUILD SUCCESS
 ca288965801572fe41386560d4e6c5cc0e5cc56d
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git main
branch HEAD: ca288965801572fe41386560d4e6c5cc0e5cc56d  Merge tag 'wireless-next-2023-04-21' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next

elapsed time: 953m

configs tested: 127
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r031-20230421   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230421   gcc  
arc                  randconfig-r006-20230421   gcc  
arc                  randconfig-r026-20230421   gcc  
arc                  randconfig-r035-20230421   gcc  
arc                  randconfig-r043-20230421   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r013-20230421   gcc  
arm                  randconfig-r046-20230421   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r015-20230421   clang
csky                                defconfig   gcc  
csky                 randconfig-r002-20230421   gcc  
csky                 randconfig-r015-20230421   gcc  
csky                 randconfig-r023-20230421   gcc  
hexagon      buildonly-randconfig-r003-20230421   clang
hexagon              randconfig-r011-20230421   clang
hexagon              randconfig-r022-20230421   clang
hexagon              randconfig-r033-20230421   clang
hexagon              randconfig-r036-20230421   clang
hexagon              randconfig-r041-20230421   clang
hexagon              randconfig-r045-20230421   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a004   clang
i386                          randconfig-a006   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a014   gcc  
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230421   gcc  
ia64                 randconfig-r005-20230421   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230421   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230421   gcc  
loongarch            randconfig-r023-20230421   gcc  
loongarch            randconfig-r025-20230421   gcc  
loongarch            randconfig-r032-20230421   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230421   gcc  
m68k         buildonly-randconfig-r002-20230421   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230421   gcc  
m68k                 randconfig-r006-20230421   gcc  
m68k                 randconfig-r011-20230421   gcc  
m68k                 randconfig-r016-20230421   gcc  
m68k                 randconfig-r034-20230421   gcc  
microblaze           randconfig-r012-20230421   gcc  
microblaze           randconfig-r016-20230421   gcc  
microblaze           randconfig-r024-20230421   gcc  
microblaze           randconfig-r034-20230421   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r021-20230421   gcc  
mips                 randconfig-r022-20230421   gcc  
nios2        buildonly-randconfig-r005-20230421   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r026-20230421   gcc  
openrisc     buildonly-randconfig-r002-20230421   gcc  
openrisc     buildonly-randconfig-r003-20230421   gcc  
openrisc     buildonly-randconfig-r006-20230421   gcc  
openrisc             randconfig-r032-20230421   gcc  
parisc       buildonly-randconfig-r001-20230421   gcc  
parisc       buildonly-randconfig-r004-20230421   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230421   gcc  
parisc               randconfig-r014-20230421   gcc  
parisc               randconfig-r036-20230421   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r002-20230421   gcc  
powerpc              randconfig-r033-20230421   gcc  
powerpc              randconfig-r034-20230421   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230421   clang
riscv                randconfig-r032-20230421   gcc  
riscv                randconfig-r042-20230421   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230421   gcc  
s390                 randconfig-r044-20230421   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230421   gcc  
sh                   randconfig-r011-20230421   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230421   gcc  
sparc                randconfig-r012-20230421   gcc  
sparc                randconfig-r021-20230421   gcc  
sparc64      buildonly-randconfig-r006-20230421   gcc  
sparc64              randconfig-r002-20230421   gcc  
sparc64              randconfig-r024-20230421   gcc  
sparc64              randconfig-r025-20230421   gcc  
sparc64              randconfig-r031-20230421   gcc  
sparc64              randconfig-r035-20230421   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230421   gcc  
xtensa               randconfig-r005-20230421   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
