Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A04CCA6CB1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Jan 2026 09:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD41D80A8B;
	Tue, 27 Jan 2026 09:16:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2imEws6_OXLN; Tue, 27 Jan 2026 09:16:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3E6F816A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769505377;
	bh=Pwv3EwtsPbwN7KffiexxnA/c5npo11npXhhYnrAFTgA=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s/P1T3ZF1cyLbFO1PkeEE4hHqUcj8BXTwdhQwFSANxkdKMom6iqvl/nG5Gy3QGo/+
	 gjfzmQqi6JYifB7694S50PRax96CmwYqq++EnLXCsDKo/Q4/tpikDAenmDM2RRWbat
	 kFSUGsW7GOUPfxsNLuugW/xxwP8DmoHeY0fCpYSu1k8mAxSKnSyNaXqMvKTbgAjkuq
	 edgep6xZgBkhRPXc3M0ZskcstV4CY5WPjRGQ68D/zzAUNKLJXkm7Z9AUs2nnJsDwA1
	 P5rbAhpRBeVsLX3sBvU3YC3vz1XmmUZw1+2qiqVWAxnqnn3KpakUskQnsLK5GW6aW2
	 17RAV+Z5veodA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3E6F816A2;
	Tue, 27 Jan 2026 09:16:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 379472F4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 09:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BDF3816A2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 09:16:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZ3WaurO3WnV for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Jan 2026 09:16:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D881980A8B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D881980A8B
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D881980A8B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 09:16:14 +0000 (UTC)
X-CSE-ConnectionGUID: UdbIPMslTt2mMq02P7VPsQ==
X-CSE-MsgGUID: F87lCevnTgOLb7RqElrl9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="74319094"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="74319094"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2026 01:16:14 -0800
X-CSE-ConnectionGUID: P8JMY9R4TAOaX9GN05UucA==
X-CSE-MsgGUID: FY3cnZYwTEKN/IE/vepCCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="238615840"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
 by orviesa002.jf.intel.com with ESMTP; 27 Jan 2026 01:16:13 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1vkfBC-00000000YDb-1Lba;
 Tue, 27 Jan 2026 09:16:10 +0000
Date: Tue, 27 Jan 2026 17:15:10 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202601271705.BuFOf29a-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769505375; x=1801041375;
 h=date:from:to:subject:message-id;
 bh=ufqi7WNi9rtQs6UYviNWeDzSddgKhWr83L1G+SqJXqs=;
 b=ji0jxAtTycJJ/eigEKohtXGAQDank3lNBMl4eMrfhHQBGSuu1F2mj/6t
 tISGV8TMhj50PTH2vUNYRSeiQIoIT4RW0ShNYiAZT/7KnyIMGaZEciPoJ
 Px+75t8j0aFFhH5hHua1Sf7Q7WqvsMfl2RE2vZQFcCZM2LUr2OeUjy4T9
 bxofDTz/CQIPWBP61NKwX6Zz7PtQPSStziSayRtHzKq+XemUy83FzJgC9
 pDLC1agh/P/NM/JcDHI2lFhbuhLALIXhlizdQLbR1M5fq1akl8eE0lG+8
 uXb3wK2a2/hFXQbFsPyj1uk/mlYPKOoF/99X3S9bimv/NvJCzKhgbCiwA
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ji0jxAtT
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 103367e1157536465847ed9cf9ad1c02ddaa2d38
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 103367e1157536465847ed9cf9ad1c02ddaa2d38  ice: PTP: fix missing timestamps on E825 hardware

elapsed time: 980m

configs tested: 168
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                          axs103_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260127    gcc-8.5.0
arc                   randconfig-002-20260127    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                            dove_defconfig    gcc-15.2.0
arm                       netwinder_defconfig    gcc-15.2.0
arm                   randconfig-001-20260127    clang-22
arm                   randconfig-002-20260127    clang-18
arm                   randconfig-003-20260127    gcc-14.3.0
arm                   randconfig-004-20260127    clang-18
arm                           sama5_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260127    gcc-10.5.0
arm64                 randconfig-002-20260127    clang-22
arm64                 randconfig-003-20260127    gcc-11.5.0
arm64                 randconfig-004-20260127    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260127    gcc-15.2.0
csky                  randconfig-002-20260127    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260127    clang-22
hexagon               randconfig-002-20260127    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260127    clang-20
i386        buildonly-randconfig-002-20260127    clang-20
i386        buildonly-randconfig-003-20260127    gcc-14
i386        buildonly-randconfig-004-20260127    clang-20
i386        buildonly-randconfig-005-20260127    gcc-14
i386        buildonly-randconfig-006-20260127    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260127    gcc-14
i386                  randconfig-002-20260127    gcc-14
i386                  randconfig-003-20260127    clang-20
i386                  randconfig-004-20260127    gcc-14
i386                  randconfig-005-20260127    gcc-14
i386                  randconfig-006-20260127    clang-20
i386                  randconfig-007-20260127    clang-20
i386                  randconfig-011-20260127    gcc-14
i386                  randconfig-012-20260127    gcc-12
i386                  randconfig-013-20260127    gcc-14
i386                  randconfig-014-20260127    clang-20
i386                  randconfig-015-20260127    clang-20
i386                  randconfig-016-20260127    gcc-14
i386                  randconfig-017-20260127    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260127    gcc-15.2.0
loongarch             randconfig-002-20260127    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260127    gcc-11.5.0
nios2                 randconfig-002-20260127    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260127    gcc-11.5.0
parisc                randconfig-002-20260127    gcc-13.4.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     ppa8548_defconfig    gcc-15.2.0
powerpc                      ppc44x_defconfig    clang-22
powerpc               randconfig-001-20260127    gcc-14.3.0
powerpc               randconfig-002-20260127    clang-22
powerpc                     tqm8541_defconfig    clang-22
powerpc64             randconfig-001-20260127    gcc-11.5.0
powerpc64             randconfig-002-20260127    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260127    clang-22
riscv                 randconfig-002-20260127    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260127    gcc-13.4.0
s390                  randconfig-002-20260127    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260127    gcc-13.4.0
sh                    randconfig-002-20260127    gcc-10.5.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260127    gcc-15.2.0
sparc                 randconfig-002-20260127    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260127    clang-20
sparc64               randconfig-002-20260127    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260127    clang-20
um                    randconfig-002-20260127    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260127    clang-20
x86_64      buildonly-randconfig-002-20260127    gcc-14
x86_64      buildonly-randconfig-003-20260127    gcc-14
x86_64      buildonly-randconfig-004-20260127    gcc-14
x86_64      buildonly-randconfig-005-20260127    gcc-14
x86_64      buildonly-randconfig-006-20260127    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260127    gcc-14
x86_64                randconfig-002-20260127    gcc-14
x86_64                randconfig-003-20260127    clang-20
x86_64                randconfig-004-20260127    gcc-14
x86_64                randconfig-005-20260127    clang-20
x86_64                randconfig-006-20260127    gcc-14
x86_64                randconfig-011-20260127    clang-20
x86_64                randconfig-012-20260127    gcc-13
x86_64                randconfig-013-20260127    clang-20
x86_64                randconfig-014-20260127    clang-20
x86_64                randconfig-015-20260127    gcc-13
x86_64                randconfig-016-20260127    clang-20
x86_64                randconfig-071-20260127    gcc-14
x86_64                randconfig-072-20260127    gcc-14
x86_64                randconfig-073-20260127    gcc-14
x86_64                randconfig-074-20260127    clang-20
x86_64                randconfig-075-20260127    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-002-20260127    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
