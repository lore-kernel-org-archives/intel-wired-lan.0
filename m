Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09D5C5AC67
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 23:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B216408E8;
	Thu,  6 Aug 2026 23:09:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KlaU4BPBwYXn; Thu,  6 Aug 2026 23:09:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12F5540892
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786057741;
	bh=UrHCmXZJ20wGd3ReMggN2ES6jctbtgKTrM8o7gEX3EU=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RZuG6AihY7zEWSN3QbmHcxeyMkGIIxnuVPNpa6k9aC34f7uX0Vdt3JEnTowShfSfd
	 sbVGyx/nz9fYKcp1CLKpw1qFbgCMgv+giQUWG2jaeAqLqecq6CIL3oRGKY/hHEUy4r
	 z1Vv5YJUjEq5TseblikiouaXMd898Ztif7FVPbVLGn1kiCaEdi7EXhlAyMPwiZc7M6
	 zwifBkPpShJU0dEvQaKo6TZg5xOKBxo1XNHQdYIhYWDuRlWa6WoNnwEX0QcJDWvkQk
	 vaDJokZe+ewmWEHOrKW7sgk8EZ7MJE91S1Pt5aU5W8YpCcnpHV0G0iMCIuQGWeMfi9
	 Ofjsuq6BYQBXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12F5540892;
	Thu,  6 Aug 2026 23:09:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 14D202B6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:09:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 066A540892
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:09:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6bLZg7sTjBaj for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 23:08:59 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org ED1EA40812
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED1EA40812
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED1EA40812
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:08:58 +0000 (UTC)
X-CSE-ConnectionGUID: WFWpamQXT6KHxyZ4RRBV5w==
X-CSE-MsgGUID: tA3vvSvTQg+XT758HtLysg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86539946"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86539946"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 16:08:58 -0700
X-CSE-ConnectionGUID: uBgD9EQAT2CnNU+Xpat0iw==
X-CSE-MsgGUID: HsaVGnUnSISA5wM4FnsDJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="264231831"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa004.fm.intel.com with ESMTP; 06 Aug 2026 16:08:57 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1ws7Co-00000000GWE-3GM3;
 Thu, 06 Aug 2026 23:08:54 +0000
Date: Fri, 07 Aug 2026 07:08:04 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608070744.7Azpvjpl-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786057739; x=1817593739;
 h=date:from:to:subject:message-id;
 bh=ZQUOJnPQtFYvWT6CMZdQntWJpklJA0u9b9EvgwhA62s=;
 b=PeHH2DvFLpT2b86oBJrgAg+vGjN7CoGpltEzLw7PVOZQVsr/PRnV744/
 7GLWthOVZpgNYSfBD6rTYod2qX6p9FYBPhn6nnMW/51qsNPXmW5wOpC0D
 pS0feoAXkfq1slOVNVlL8c6FMxHgZKWqQCjoRhjCVvqYX1W6XRFLkynwP
 PUrZ9EVAmmf4VINy/CPuxAFvxvvKqIlwmsvUF0cGR5Y6ayyC5LbVnA+j5
 btiWyRe7u7ICmNns5BTcLX/XzgmSktqfMYqolraWhFc9BHc1F6wjj4dbZ
 mIAqdC11oEHmT1AXRtw+b1Uc/uDHpc/a4wk7OoNPWH8u7fWkC2xsaBNNi
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PeHH2DvF
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 edfea15f16cd8df92873c9bfbda1d80be07b0248
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: edfea15f16cd8df92873c9bfbda1d80be07b0248  e1000e: Avoid DMA re-mapping on RX copybreak

elapsed time: 1495m

configs tested: 171
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260806    gcc-11.5.0
arc                  randconfig-001-20260807    gcc-14.3.0
arc                  randconfig-002-20260806    gcc-11.5.0
arc                  randconfig-002-20260807    gcc-14.3.0
arm                  randconfig-001-20260806    gcc-11.5.0
arm                  randconfig-001-20260807    gcc-14.3.0
arm                  randconfig-002-20260806    gcc-11.5.0
arm                  randconfig-002-20260807    gcc-14.3.0
arm                  randconfig-003-20260806    gcc-11.5.0
arm                  randconfig-003-20260807    gcc-14.3.0
arm                  randconfig-004-20260806    gcc-11.5.0
arm                  randconfig-004-20260807    gcc-14.3.0
arm64                randconfig-001-20260806    gcc-13.4.0
arm64                randconfig-001-20260807    gcc-16.1.0
arm64                randconfig-002-20260806    gcc-13.4.0
arm64                randconfig-002-20260807    gcc-16.1.0
arm64                randconfig-003-20260806    gcc-13.4.0
arm64                randconfig-003-20260807    gcc-16.1.0
arm64                randconfig-004-20260806    gcc-13.4.0
arm64                randconfig-004-20260807    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260806    gcc-13.4.0
csky                 randconfig-001-20260807    gcc-16.1.0
csky                 randconfig-002-20260806    gcc-13.4.0
csky                 randconfig-002-20260807    gcc-16.1.0
hexagon              randconfig-001-20260806    clang-24
hexagon              randconfig-001-20260807    clang-18
hexagon              randconfig-002-20260806    clang-24
hexagon              randconfig-002-20260807    clang-18
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260806    gcc-14
i386       buildonly-randconfig-002-20260806    gcc-14
i386       buildonly-randconfig-003-20260806    gcc-14
i386       buildonly-randconfig-004-20260806    gcc-14
i386       buildonly-randconfig-005-20260806    gcc-14
i386       buildonly-randconfig-006-20260806    gcc-14
i386                 randconfig-001-20260806    clang-22
i386                 randconfig-002-20260806    clang-22
i386                 randconfig-003-20260806    clang-22
i386                 randconfig-004-20260806    clang-22
i386                 randconfig-005-20260806    clang-22
i386                 randconfig-006-20260806    clang-22
i386                 randconfig-007-20260806    clang-22
i386                 randconfig-011-20260806    clang-22
i386                 randconfig-011-20260807    clang-22
i386                 randconfig-012-20260806    clang-22
i386                 randconfig-012-20260807    clang-22
i386                 randconfig-013-20260806    clang-22
i386                 randconfig-013-20260807    clang-22
i386                 randconfig-014-20260806    clang-22
i386                 randconfig-014-20260807    clang-22
i386                 randconfig-015-20260806    clang-22
i386                 randconfig-015-20260807    clang-22
i386                 randconfig-016-20260806    clang-22
i386                 randconfig-016-20260807    clang-22
i386                 randconfig-017-20260806    clang-22
i386                 randconfig-017-20260807    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260806    clang-24
loongarch            randconfig-001-20260807    clang-18
loongarch            randconfig-002-20260806    clang-24
loongarch            randconfig-002-20260807    clang-18
m68k                      m5208evb_defconfig    gcc-16.1.0
m68k                         sun3x_defconfig    gcc-16.1.0
mips                          ip22_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260806    clang-24
nios2                randconfig-001-20260807    clang-18
nios2                randconfig-002-20260806    clang-24
nios2                randconfig-002-20260807    clang-18
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260806    gcc-8.5.0
parisc               randconfig-001-20260807    gcc-8.5.0
parisc               randconfig-002-20260806    gcc-8.5.0
parisc               randconfig-002-20260807    gcc-8.5.0
powerpc              randconfig-001-20260806    gcc-8.5.0
powerpc              randconfig-001-20260807    gcc-8.5.0
powerpc              randconfig-002-20260806    gcc-8.5.0
powerpc              randconfig-002-20260807    gcc-8.5.0
powerpc64            randconfig-001-20260806    gcc-8.5.0
powerpc64            randconfig-001-20260807    gcc-8.5.0
powerpc64            randconfig-002-20260806    gcc-8.5.0
powerpc64            randconfig-002-20260807    gcc-8.5.0
riscv                randconfig-001-20260806    gcc-13.4.0
riscv                randconfig-001-20260807    gcc-12.5.0
riscv                randconfig-002-20260806    gcc-13.4.0
riscv                randconfig-002-20260807    gcc-12.5.0
s390                 randconfig-001-20260806    gcc-13.4.0
s390                 randconfig-001-20260807    gcc-12.5.0
s390                 randconfig-002-20260806    gcc-13.4.0
s390                 randconfig-002-20260807    gcc-12.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260806    gcc-13.4.0
sh                   randconfig-001-20260807    gcc-12.5.0
sh                   randconfig-002-20260806    gcc-13.4.0
sh                   randconfig-002-20260807    gcc-12.5.0
sparc                         randconfig-001    gcc-8.5.0
sparc                randconfig-001-20260806    gcc-8.5.0
sparc                randconfig-001-20260807    gcc-16.1.0
sparc                randconfig-002-20260806    gcc-8.5.0
sparc                randconfig-002-20260807    gcc-16.1.0
sparc64              randconfig-001-20260806    gcc-8.5.0
sparc64              randconfig-001-20260807    gcc-16.1.0
sparc64              randconfig-002-20260806    gcc-8.5.0
sparc64              randconfig-002-20260807    gcc-16.1.0
um                   randconfig-001-20260806    gcc-8.5.0
um                   randconfig-001-20260807    gcc-16.1.0
um                   randconfig-002-20260806    gcc-8.5.0
um                   randconfig-002-20260807    gcc-16.1.0
x86_64     buildonly-randconfig-001-20260806    clang-22
x86_64     buildonly-randconfig-001-20260807    clang-22
x86_64     buildonly-randconfig-002-20260806    clang-22
x86_64     buildonly-randconfig-002-20260807    clang-22
x86_64     buildonly-randconfig-003-20260806    clang-22
x86_64     buildonly-randconfig-003-20260807    clang-22
x86_64     buildonly-randconfig-004-20260806    clang-22
x86_64     buildonly-randconfig-004-20260807    clang-22
x86_64     buildonly-randconfig-005-20260806    clang-22
x86_64     buildonly-randconfig-005-20260807    clang-22
x86_64     buildonly-randconfig-006-20260806    clang-22
x86_64     buildonly-randconfig-006-20260807    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260806    clang-22
x86_64               randconfig-001-20260807    clang-22
x86_64               randconfig-002-20260806    clang-22
x86_64               randconfig-002-20260807    clang-22
x86_64               randconfig-003-20260806    clang-22
x86_64               randconfig-003-20260807    clang-22
x86_64               randconfig-004-20260806    clang-22
x86_64               randconfig-004-20260807    clang-22
x86_64               randconfig-005-20260806    clang-22
x86_64               randconfig-005-20260807    clang-22
x86_64               randconfig-006-20260806    clang-22
x86_64               randconfig-006-20260807    clang-22
x86_64               randconfig-011-20260806    clang-22
x86_64               randconfig-011-20260807    clang-22
x86_64               randconfig-012-20260806    clang-22
x86_64               randconfig-012-20260807    clang-22
x86_64               randconfig-013-20260806    clang-22
x86_64               randconfig-013-20260807    clang-22
x86_64               randconfig-014-20260806    clang-22
x86_64               randconfig-014-20260807    clang-22
x86_64               randconfig-015-20260806    clang-22
x86_64               randconfig-015-20260807    clang-22
x86_64               randconfig-016-20260806    clang-22
x86_64               randconfig-016-20260807    clang-22
x86_64               randconfig-071-20260806    gcc-14
x86_64               randconfig-071-20260807    clang-22
x86_64               randconfig-072-20260806    gcc-14
x86_64               randconfig-072-20260807    clang-22
x86_64               randconfig-073-20260806    gcc-14
x86_64               randconfig-073-20260807    clang-22
x86_64               randconfig-074-20260806    gcc-14
x86_64               randconfig-074-20260807    clang-22
x86_64               randconfig-075-20260806    gcc-14
x86_64               randconfig-075-20260807    clang-22
x86_64               randconfig-076-20260806    gcc-14
x86_64               randconfig-076-20260807    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260806    gcc-8.5.0
xtensa               randconfig-001-20260807    gcc-16.1.0
xtensa               randconfig-002-20260806    gcc-8.5.0
xtensa               randconfig-002-20260807    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
