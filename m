Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DF8CD4F26
	for <intel-wired-lan@archiver.kernel.org>; Fri, 26 Jun 2026 07:06:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9819080DEB;
	Fri, 26 Jun 2026 07:06:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8WR8X-N4u2I4; Fri, 26 Jun 2026 07:06:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9BD7B8212C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782457577;
	bh=W1ZkjhCe3oZ5+IsdOA1YTH5Yj3DpE7lfzuBX7wHB61o=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wP5e8laHX5AIOTrwtbuwqFggH3wNteD69KdeooQ0WOmSU40Iumo67bvL0BQyuf8Za
	 iZ81PwMFsd8OIsXib3nn8I5GpSkwU41kHjLfhcwqBq3gtTl7KRwzdg276S7xFy6NMD
	 RDY0/SvCZjyGqrJIlYs+ce5fQtUbR2QUINHz89MdkCfC5hgbTZdohm8V6eBl9BQofG
	 r9usT6BmInsRgAOiUp2wf0NnrdSBt3X/zkZ+/842hGXxaEdth5Ir4rFamng/tlQBB4
	 SJuJOvY0iat6/K+XVPg+AQhjAWbF3ORYJRMrSnnV4st+EV8P0curxd/Hnnm5yGEdzf
	 lF3ao6ISwlXZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BD7B8212C;
	Fri, 26 Jun 2026 07:06:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E671E231
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jun 2026 07:06:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D812140A20
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jun 2026 07:06:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SD8YFIel08lA for <intel-wired-lan@lists.osuosl.org>;
 Fri, 26 Jun 2026 07:06:16 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9184B40A38
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9184B40A38
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9184B40A38
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jun 2026 07:06:14 +0000 (UTC)
X-CSE-ConnectionGUID: kHUnStPPQL2dY9pjbIHghA==
X-CSE-MsgGUID: DMCCHvQwS+m+esugHPQIDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="86930026"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="86930026"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 00:06:15 -0700
X-CSE-ConnectionGUID: XIiZjw1RSfi32/m6ZbG7Lg==
X-CSE-MsgGUID: Qn0YI53HTim479pxbcClQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="256160123"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by fmviesa005.fm.intel.com with ESMTP; 26 Jun 2026 00:05:00 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wd0cU-000000004ql-21Ek;
 Fri, 26 Jun 2026 07:04:58 +0000
Date: Fri, 26 Jun 2026 15:04:18 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202606261507.wVyXAnvJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782457576; x=1813993576;
 h=date:from:to:subject:message-id;
 bh=YgDPACvJDPbiG6dKNOkP/r8jDgZ42RxITuid/SbzXEg=;
 b=lIN8+AFwSLOumi8C6YaquWXbmrUfI9njF15biW9YLhggQi90xrKDWfsf
 zP1ppm0zHtDZ1Q4a9HDgApVaOH4h3G1P3NDpw2VvRQQUnkgy8l2SmO6Xu
 AjEFbGP+ZLojtI4ORFQSeIvTYbcXHKme8Es1DONdxPHBjcTBHDF8ibZcX
 PrkUgJe1NWxRbDS8jtMdhvBaheUiwbwpkn1k0TsRpRVlm9LC6fa0mRooi
 ho5FdNhJrAdOKRfDjC9AvgUoQr2/UOt+CYDKOLspTz79xMITVLSLOvxc/
 9ZvYJuqYkvc9xGtadIPA907ITa+RNHs1CGBW7X+kjXmyDTv98UaH/HpJO
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lIN8+AFw
Subject: [Intel-wired-lan] [tnguy-net-queue:200GbE] BUILD SUCCESS
 b78f348d4c4d862b1ad232f30c818f3ec8b97efb
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 200GbE
branch HEAD: b78f348d4c4d862b1ad232f30c818f3ec8b97efb  Merge branch 'net-hns3-fix-configuration-deadlocks-and-refactor-link-setup'

elapsed time: 723m

configs tested: 290
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260626    gcc-13.4.0
arc                   randconfig-001-20260626    gcc-16.1.0
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260626    gcc-13.4.0
arc                   randconfig-002-20260626    gcc-16.1.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                             mxs_defconfig    clang-17
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260626    gcc-13.4.0
arm                   randconfig-001-20260626    gcc-16.1.0
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260626    gcc-13.4.0
arm                   randconfig-002-20260626    gcc-16.1.0
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260626    gcc-13.4.0
arm                   randconfig-003-20260626    gcc-16.1.0
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260626    gcc-13.4.0
arm                   randconfig-004-20260626    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260626    gcc-8.5.0
arm64                 randconfig-002-20260626    clang-17
arm64                 randconfig-002-20260626    gcc-8.5.0
arm64                 randconfig-003-20260626    gcc-15.2.0
arm64                 randconfig-003-20260626    gcc-8.5.0
arm64                 randconfig-004-20260626    gcc-13.4.0
arm64                 randconfig-004-20260626    gcc-8.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260626    gcc-16.1.0
csky                  randconfig-001-20260626    gcc-8.5.0
csky                  randconfig-002-20260626    gcc-16.1.0
csky                  randconfig-002-20260626    gcc-8.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260626    clang-23
hexagon               randconfig-001-20260626    gcc-11.5.0
hexagon               randconfig-002-20260626    clang-17
hexagon               randconfig-002-20260626    gcc-11.5.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260626    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260626    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260626    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260626    gcc-12
i386        buildonly-randconfig-004-20260626    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260626    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260626    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260626    clang-22
i386                  randconfig-001-20260626    gcc-14
i386                  randconfig-002-20260626    gcc-14
i386                  randconfig-003-20260626    clang-22
i386                  randconfig-003-20260626    gcc-14
i386                  randconfig-004-20260626    clang-22
i386                  randconfig-004-20260626    gcc-14
i386                  randconfig-005-20260626    gcc-14
i386                  randconfig-006-20260626    gcc-14
i386                  randconfig-007-20260626    gcc-14
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260626    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260626    clang-22
i386                  randconfig-012-20260626    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260626    clang-22
i386                  randconfig-013-20260626    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260626    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260626    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260626    clang-22
i386                  randconfig-016-20260626    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260626    clang-22
i386                  randconfig-017-20260626    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260626    gcc-11.5.0
loongarch             randconfig-001-20260626    gcc-16.1.0
loongarch             randconfig-002-20260626    clang-18
loongarch             randconfig-002-20260626    gcc-11.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                     loongson2k_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260626    gcc-11.5.0
nios2                 randconfig-002-20260626    gcc-11.5.0
nios2                 randconfig-002-20260626    gcc-8.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260626    gcc-8.5.0
parisc                randconfig-002-20260626    gcc-12.5.0
parisc                randconfig-002-20260626    gcc-8.5.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                      ep88xc_defconfig    gcc-16.1.0
powerpc                   motionpro_defconfig    clang-23
powerpc               randconfig-001-20260626    clang-23
powerpc               randconfig-001-20260626    gcc-8.5.0
powerpc               randconfig-002-20260626    gcc-11.5.0
powerpc               randconfig-002-20260626    gcc-8.5.0
powerpc64             randconfig-001-20260626    clang-17
powerpc64             randconfig-001-20260626    gcc-8.5.0
powerpc64             randconfig-002-20260626    gcc-13.4.0
powerpc64             randconfig-002-20260626    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv             nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-23
riscv                 randconfig-001-20260626    clang-23
riscv                 randconfig-001-20260626    gcc-11.5.0
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260626    clang-23
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-23
s390                  randconfig-001-20260626    clang-23
s390                           randconfig-002    clang-23
s390                  randconfig-002-20260626    clang-23
s390                  randconfig-002-20260626    gcc-8.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                             randconfig-001    clang-23
sh                    randconfig-001-20260626    clang-23
sh                    randconfig-001-20260626    gcc-9.5.0
sh                             randconfig-002    clang-23
sh                    randconfig-002-20260626    clang-23
sh                    randconfig-002-20260626    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260626    gcc-12.5.0
sparc                 randconfig-002-20260626    gcc-12.5.0
sparc                 randconfig-002-20260626    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260626    clang-20
sparc64               randconfig-001-20260626    gcc-12.5.0
sparc64               randconfig-002-20260626    clang-20
sparc64               randconfig-002-20260626    gcc-12.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260626    clang-18
um                    randconfig-001-20260626    gcc-12.5.0
um                    randconfig-002-20260626    clang-23
um                    randconfig-002-20260626    gcc-12.5.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260626    clang-22
x86_64      buildonly-randconfig-001-20260626    gcc-14
x86_64      buildonly-randconfig-002-20260626    gcc-14
x86_64      buildonly-randconfig-003-20260626    clang-22
x86_64      buildonly-randconfig-003-20260626    gcc-14
x86_64      buildonly-randconfig-004-20260626    gcc-14
x86_64      buildonly-randconfig-005-20260626    clang-22
x86_64      buildonly-randconfig-005-20260626    gcc-14
x86_64      buildonly-randconfig-006-20260626    clang-22
x86_64      buildonly-randconfig-006-20260626    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260626    clang-22
x86_64                randconfig-002-20260626    clang-22
x86_64                randconfig-002-20260626    gcc-14
x86_64                randconfig-003-20260626    clang-22
x86_64                randconfig-004-20260626    clang-22
x86_64                randconfig-005-20260626    clang-22
x86_64                randconfig-005-20260626    gcc-13
x86_64                randconfig-006-20260626    clang-22
x86_64                randconfig-011-20260626    gcc-14
x86_64                randconfig-012-20260626    gcc-14
x86_64                randconfig-013-20260626    clang-22
x86_64                randconfig-013-20260626    gcc-14
x86_64                randconfig-014-20260626    gcc-14
x86_64                randconfig-015-20260626    gcc-14
x86_64                randconfig-016-20260626    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260626    gcc-14
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260626    clang-22
x86_64                randconfig-072-20260626    gcc-14
x86_64                         randconfig-073    gcc-14
x86_64                randconfig-073-20260626    gcc-14
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260626    gcc-14
x86_64                         randconfig-075    gcc-14
x86_64                randconfig-075-20260626    gcc-14
x86_64                         randconfig-076    gcc-14
x86_64                randconfig-076-20260626    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260626    gcc-12.5.0
xtensa                randconfig-002-20260626    gcc-10.5.0
xtensa                randconfig-002-20260626    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
