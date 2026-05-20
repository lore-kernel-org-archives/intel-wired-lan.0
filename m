Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B23CD4F3D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 20 May 2026 04:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4709560E94;
	Wed, 20 May 2026 04:04:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PkoOSUoHaHXj; Wed, 20 May 2026 04:04:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C849060E91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779249892;
	bh=OJYKJqCd1d70dmO+B5tFvEkT+ld9f1qX6MAnf3biJqE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ousNTolpEVfJum/ynypPqT1q94bGkFt4DUDrSThUQlgvvHJFY3nyOKR6AEJsZcwbF
	 cnSHShaizC8Mmx+HabIZcAW+GWZSAp586Sh1gl9y1S8zPikfLKmSX824aYn1aszJxa
	 fJC636Tc15WO5AQnh1kVr2SBUJAp9Pai8oe6GhkhFfHCImpNAqSBh/n+lVtqwWwH/1
	 m2VY+3rZt9BMGhkAKmsdh7JQae1yPGmMzznSNgzm//xB9Gs/8eu44xamEZqXtZSlDA
	 Qcf4Oe6nCmohCK6y3nkxgVvtIWW0IBs+I1sHkCu3dPeGKc990Q5pzY0XadJcA0e35q
	 F7xC2fbRAKFjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C849060E91;
	Wed, 20 May 2026 04:04:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E2CA282
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 May 2026 04:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F6A740748
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 May 2026 04:04:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hy4T_2bMQfoC for <intel-wired-lan@lists.osuosl.org>;
 Wed, 20 May 2026 04:04:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5D7AB4073B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D7AB4073B
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D7AB4073B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 20 May 2026 04:04:49 +0000 (UTC)
X-CSE-ConnectionGUID: 1oJOoBpqT7iypArWsnCiwA==
X-CSE-MsgGUID: /9ZgqbL2SrySgTdERbfa/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="83996178"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="83996178"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 21:04:48 -0700
X-CSE-ConnectionGUID: ogjq3op4Qh6/FwN0FNdd9Q==
X-CSE-MsgGUID: LoyhZKgbTbS4e6jAj3egXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="244006002"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
 by orviesa003.jf.intel.com with ESMTP; 19 May 2026 21:04:46 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wPYAJ-000000002QB-1DOQ;
 Wed, 20 May 2026 04:04:23 +0000
Date: Wed, 20 May 2026 12:00:32 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202605201223.rhJRn2QW-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779249890; x=1810785890;
 h=date:from:to:subject:message-id;
 bh=ejRsCtHZYYDF95O5p/z9KihNMRxi8fPilBT5B2dvuKw=;
 b=Ng2/z8NIRwY3F/Auv0bsgvFahwoM92PsXDLPRE0SJisR7QWrXdCJ29TA
 Xt9RMxsZd2FnhnrGJF6Kq226oUoL3YOQnnn4Jo994CcfFbgAmgpgDowSw
 pVEQNTbrzLvRKxD/i3s0IJIQtw8j3QN5sSUeywUCE/q6Z8k+taH6YKki+
 xTWQwgDc4xNdFzCKR+8Q5yvNB5+sHMeVO2N0MVySW51UXmJWm1Bb37Xti
 7nq35dwQaH26RLcScCtbL583czgZ4j/XvP0N54JO3zZiV4OM9zb0QVC2C
 K+lLGoKeVazaymgWfZLKCOQm2aMFBNHHgSGDrUlrdT/ptxQhR/1AavHQ7
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Ng2/z8NI
Subject: [Intel-wired-lan] [tnguy-net-queue:main] BUILD SUCCESS
 edc502717be153674b0b3eefb8b40734c747c138
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git main
branch HEAD: edc502717be153674b0b3eefb8b40734c747c138  Merge branch 'mptcp-misc-fixes-for-v7-1-rc4'

elapsed time: 721m

configs tested: 198
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260520    gcc-8.5.0
arc                   randconfig-002-20260520    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                        keystone_defconfig    gcc-15.2.0
arm                           omap1_defconfig    gcc-15.2.0
arm                   randconfig-001-20260520    gcc-8.5.0
arm                   randconfig-002-20260520    gcc-8.5.0
arm                   randconfig-003-20260520    gcc-8.5.0
arm                   randconfig-004-20260520    gcc-8.5.0
arm                          sp7021_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260520    gcc-10.5.0
arm64                 randconfig-002-20260520    gcc-10.5.0
arm64                 randconfig-003-20260520    gcc-10.5.0
arm64                 randconfig-004-20260520    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260520    gcc-10.5.0
csky                  randconfig-002-20260520    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260520    gcc-11.5.0
hexagon               randconfig-002-20260520    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260520    clang-20
i386        buildonly-randconfig-002-20260520    clang-20
i386        buildonly-randconfig-003-20260520    clang-20
i386        buildonly-randconfig-004-20260520    clang-20
i386        buildonly-randconfig-005-20260520    clang-20
i386        buildonly-randconfig-006-20260520    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260520    clang-20
i386                  randconfig-002-20260520    clang-20
i386                  randconfig-003-20260520    clang-20
i386                  randconfig-004-20260520    clang-20
i386                  randconfig-005-20260520    clang-20
i386                  randconfig-006-20260520    clang-20
i386                  randconfig-007-20260520    clang-20
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260520    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260520    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260520    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260520    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260520    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260520    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260520    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260520    gcc-11.5.0
loongarch             randconfig-002-20260520    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         rt305x_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260520    gcc-11.5.0
nios2                 randconfig-002-20260520    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260520    clang-23
parisc                randconfig-002-20260520    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260520    clang-23
powerpc               randconfig-002-20260520    clang-23
powerpc64             randconfig-001-20260520    clang-23
powerpc64             randconfig-002-20260520    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260520    gcc-8.5.0
sparc                 randconfig-002-20260520    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260520    gcc-8.5.0
sparc64               randconfig-002-20260520    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260520    gcc-8.5.0
um                    randconfig-002-20260520    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260520    gcc-14
x86_64      buildonly-randconfig-002-20260520    gcc-14
x86_64      buildonly-randconfig-003-20260520    gcc-14
x86_64      buildonly-randconfig-004-20260520    gcc-14
x86_64      buildonly-randconfig-005-20260520    gcc-14
x86_64      buildonly-randconfig-006-20260520    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260520    gcc-14
x86_64                randconfig-002-20260520    gcc-14
x86_64                randconfig-003-20260520    gcc-14
x86_64                randconfig-004-20260520    gcc-14
x86_64                randconfig-005-20260520    gcc-14
x86_64                randconfig-006-20260520    gcc-14
x86_64                randconfig-011-20260520    gcc-14
x86_64                randconfig-012-20260520    gcc-14
x86_64                randconfig-013-20260520    gcc-14
x86_64                randconfig-014-20260520    gcc-14
x86_64                randconfig-015-20260520    gcc-14
x86_64                randconfig-016-20260520    gcc-14
x86_64                randconfig-071-20260520    gcc-14
x86_64                randconfig-072-20260520    gcc-14
x86_64                randconfig-073-20260520    gcc-14
x86_64                randconfig-074-20260520    gcc-14
x86_64                randconfig-075-20260520    gcc-14
x86_64                randconfig-076-20260520    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260520    gcc-8.5.0
xtensa                randconfig-002-20260520    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
