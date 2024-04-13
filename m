Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D89C4345F
	for <intel-wired-lan@archiver.kernel.org>; Sat, 13 Apr 2024 22:19:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B55C402D8;
	Sat, 13 Apr 2024 22:19:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zfRRJz8qWCst; Sat, 13 Apr 2024 22:19:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4F1E402E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1713046749;
	bh=2/yMIs9BAh96Rc/xd+Ohqy8sYljxxDvbu1GiaFEHHdc=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wlHdq/jlbZ1BgLj59K4NnjCuZF/JRLXl2Qmv33+m+zJJLPkf6Qj9QYJ/69WQ6BhZm
	 7xEqyQXMj1/w9hIQnX/UlKya6HgaCBV+/X6q9Fo/64Nrb5aiGtopCOkk4GNc+L+6iH
	 UYyquuL0mSHGlduNyH0LXCDjVL4kOS066/vzNRu6ncdJQk7W+N1/1CQJWb3IdRfPwG
	 uu0KR0+98n2vZ2l0OxxrBuHwDo+yuS/f8rtT0+Kbcnxr04JZdhFjKGgGQAxPtCmykz
	 dx+p8BVm0+gbHNcvD/oU9cRC9sMC2wcQlbGBftjPkEqDCAozn7/6NKYbkRuGgDJdCK
	 4kFabtdKA4mWQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4F1E402E1;
	Sat, 13 Apr 2024 22:19:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 4F7FD1BF29D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Apr 2024 22:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B32C40180
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Apr 2024 22:19:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zj98U4CH_J4W for <intel-wired-lan@lists.osuosl.org>;
 Sat, 13 Apr 2024 22:19:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2A61A400E4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A61A400E4
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A61A400E4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Apr 2024 22:19:04 +0000 (UTC)
X-CSE-ConnectionGUID: Hx7SIOwKRzC0Eo24qAGrRw==
X-CSE-MsgGUID: qJhBK+MFRHK+4X8x5FvRZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11043"; a="11426111"
X-IronPort-AV: E=Sophos;i="6.07,199,1708416000"; d="scan'208";a="11426111"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2024 15:19:03 -0700
X-CSE-ConnectionGUID: /7HXXv57RxSkGaWI8f9yPQ==
X-CSE-MsgGUID: DkbGnRpOQ2irJF/begeHwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,199,1708416000"; d="scan'208";a="21636387"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
 by fmviesa007.fm.intel.com with ESMTP; 13 Apr 2024 15:19:03 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1rvli8-00034k-21
 for intel-wired-lan@lists.osuosl.org; Sat, 13 Apr 2024 22:19:00 +0000
Date: Sun, 14 Apr 2024 06:18:32 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202404140630.QkhLkS7W-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713046745; x=1744582745;
 h=date:from:to:subject:message-id;
 bh=R0ALU8WrENtHU1Nhrb1SlfqSX7j/CjoeI2Y+2qb0/FI=;
 b=PRoJHt7cjsQYQhf9oFAIQ6Zr7Ee+STPThy5xRO0R5EHFGI6zpFsgN9h5
 eMdEMQSN4CSugzNaNoLbnhEleljVNOf1TWj7cFqbGKi8Ypf6oDadBR3Iv
 z7G4oqSxayW5spXDmSyzuSJTtY9/DSqpbKdwNQ+PMCoYUQZ6PrEBP4jhC
 sWPOmUqc7ieGtZpWACDWIEf/cO6AW47PrBKpCMESLoRqB4OQIVALwLE3x
 +W5hhZtReK5/TPR141Wwh6qjJDjtSwX+1/vcqS+f73qneT1v8q9hyHz3q
 GaXR7xrRhHUIihUBmJLQfcy/6bH81sHH0mHv/44CSEOxBJ+hrb69tjaJ2
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PRoJHt7c
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 b80d01ef9aba6c0824644bbde49b1f4e2955e5d1
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: b80d01ef9aba6c0824644bbde49b1f4e2955e5d1  ice: store VF relative MSI-X index in q_vector->vf_reg_idx

elapsed time: 1447m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240414   gcc  
arc                   randconfig-002-20240414   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240414   clang
arm                   randconfig-002-20240414   clang
arm                   randconfig-003-20240414   gcc  
arm                   randconfig-004-20240414   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240414   gcc  
arm64                 randconfig-002-20240414   clang
arm64                 randconfig-003-20240414   gcc  
arm64                 randconfig-004-20240414   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240414   gcc  
csky                  randconfig-002-20240414   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240414   clang
hexagon               randconfig-002-20240414   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240413   gcc  
i386         buildonly-randconfig-002-20240413   gcc  
i386         buildonly-randconfig-003-20240413   clang
i386         buildonly-randconfig-004-20240413   clang
i386         buildonly-randconfig-005-20240413   clang
i386         buildonly-randconfig-006-20240413   clang
i386                                defconfig   clang
i386                  randconfig-001-20240413   clang
i386                  randconfig-002-20240413   gcc  
i386                  randconfig-003-20240413   clang
i386                  randconfig-004-20240413   gcc  
i386                  randconfig-005-20240413   clang
i386                  randconfig-006-20240413   clang
i386                  randconfig-011-20240413   gcc  
i386                  randconfig-012-20240413   clang
i386                  randconfig-013-20240413   gcc  
i386                  randconfig-014-20240413   gcc  
i386                  randconfig-015-20240413   clang
i386                  randconfig-016-20240413   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240414   gcc  
loongarch             randconfig-002-20240414   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240414   gcc  
nios2                 randconfig-002-20240414   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240414   gcc  
parisc                randconfig-002-20240414   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240414   clang
powerpc               randconfig-002-20240414   clang
powerpc               randconfig-003-20240414   gcc  
powerpc64             randconfig-001-20240414   clang
powerpc64             randconfig-002-20240414   gcc  
powerpc64             randconfig-003-20240414   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
riscv                 randconfig-001-20240414   clang
riscv                 randconfig-002-20240414   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240414   clang
s390                  randconfig-002-20240414   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240414   gcc  
sh                    randconfig-002-20240414   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240414   gcc  
sparc64               randconfig-002-20240414   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240414   gcc  
um                    randconfig-002-20240414   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240414   clang
x86_64       buildonly-randconfig-002-20240414   clang
x86_64       buildonly-randconfig-003-20240414   clang
x86_64       buildonly-randconfig-004-20240414   clang
x86_64       buildonly-randconfig-005-20240414   gcc  
x86_64       buildonly-randconfig-006-20240414   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
