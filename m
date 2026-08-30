Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F04C61DB9
	for <intel-wired-lan@archiver.kernel.org>; Sun, 30 Aug 2026 06:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93E5340633;
	Sun, 30 Aug 2026 06:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KhPiHYY5seNB; Sun, 30 Aug 2026 06:04:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788069846;
	bh=ezyJP/vgIQgljvCCHoc2tRrW/vEaVTjPL99x2dcfRbo=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tyudH1tV95/BXWOmZXPjt0761cIJfrdwZMPU0p4pM+/62NK4lYgxbIXynTm664612
	 IbOP5ACaFpk+CWl4D3M3feQ0+X6zss+YBC8JU6WvupAstUja9JJEoGFo3n8ugsBcC/
	 oMFOwzU8b+Lw8dj5rqtaewWHs+MrKU04zNfaulpjagG40U8PjdVScKKcvtY66Nf0kZ
	 YutkmHwnqLckmDcSoDlWHdlpAleztD9QVf0UDLbXoc1vEXHnjFyro79G2506eJo+4H
	 Q+vIDMi3s37a8KDnAgy7STlT1c7lH2Nqt0Napfr3V4xxoDsMAXCRLlWtY0r6+ToI+A
	 cD31an5f2Nmfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDC8740634;
	Sun, 30 Aug 2026 06:04:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 90351230
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 06:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7649440633
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 06:04:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxzaftULCVje for <intel-wired-lan@lists.osuosl.org>;
 Sun, 30 Aug 2026 06:04:04 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nsDCQh9T
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60E4640634
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 06:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788069845; x=1819605845; h=date:from:to:subject:message-id;
 bh=lIsr2c2UPkp3P0d7of8madtXMEIbYzxQ3DrCuTLohzs=;
 b=nsDCQh9TNazIdytF6iCaIG/XB0+Jfp2xePiE2p8wlIzRc4XAH/FNWSo+
 cx23yS1Bgavik6Bui0HvgerYSNDpR1BqXFqUDz1o9qWPkWTZ0kQ5Z63sL
 io98FFzA4mIH2zlkbVrU4SMf2+BswjZdepRnkLw/zTLDEtPUL9jGsB6n2
 I9h7FCe/7Rw6rrQn4TF0vaRvzAtp9sRq/Bz1l3BhmmgxtFcow3Jv7XaBC
 1PbEz+EnBGgmaI0iOjhz35hFuowjTpTwk3MxHc1m+fucVFWu5jfyhGHXo
 U1Blksd+8dB9dulRo/jCfhNlfOs4Dm9rFoM3AjN+1MZsoWiG5UZsCf5Lh w==;
X-CSE-ConnectionGUID: KCDTU8rVRSqqjLFcNf+jKA==
X-CSE-MsgGUID: J+Ul31n0SzGhsWSKxPeogQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="92198891"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="92198891"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2026 23:04:02 -0700
X-CSE-ConnectionGUID: 6CrutvTJTMK1tHm01eUatw==
X-CSE-MsgGUID: H3NAOyDTQ4uyig0j9jOYsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="293321231"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
 by fmviesa001.fm.intel.com with ESMTP; 29 Aug 2026 23:04:00 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x0Ye5-00000000Dco-3OPo;
 Sun, 30 Aug 2026 06:03:57 +0000
Date: Sun, 30 Aug 2026 14:03:47 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 879e8e9f0ae039b4427e5f275d09de0f7a65699b
Message-ID: <202608301431.RKDjJkJd-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 879e8e9f0ae039b4427e5f275d09de0f7a65699b  e100: prevent shift-out-of-bounds in EEPROM access

elapsed time: 759m

configs tested: 110
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
arc                              allmodconfig    clang-24
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                              allyesconfig    gcc-16.1.0
arc                   randconfig-001-20260830    gcc-15.2.0
arc                   randconfig-002-20260830    gcc-15.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-24
arm                              allyesconfig    gcc-16.1.0
arm                   randconfig-001-20260830    gcc-15.2.0
arm                   randconfig-002-20260830    gcc-15.2.0
arm                   randconfig-003-20260830    gcc-15.2.0
arm                   randconfig-004-20260830    gcc-15.2.0
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
hexagon                          allmodconfig    clang-24
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-24
hexagon                           allnoconfig    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260830    clang-22
i386        buildonly-randconfig-002-20260830    clang-22
i386        buildonly-randconfig-003-20260830    clang-22
i386        buildonly-randconfig-004-20260830    clang-22
i386        buildonly-randconfig-005-20260830    clang-22
i386        buildonly-randconfig-006-20260830    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                             allyesconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-24
nios2                             allnoconfig    gcc-11.5.0
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
parisc                randconfig-001-20260830    gcc-8.5.0
parisc                randconfig-002-20260830    gcc-8.5.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260830    gcc-8.5.0
powerpc               randconfig-002-20260830    gcc-13.4.0
powerpc64             randconfig-001-20260830    gcc-8.5.0
powerpc64             randconfig-002-20260830    gcc-8.5.0
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
sh                    randconfig-001-20260830    gcc-16.1.0
sh                    randconfig-002-20260830    gcc-16.1.0
sparc                             allnoconfig    clang-24
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc64                          allmodconfig    clang-20
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-24
x86_64                           allyesconfig    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-24
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
