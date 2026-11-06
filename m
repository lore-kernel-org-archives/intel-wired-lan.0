Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4FA606A329
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=EerURozN;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KPKbRjpR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A39D4099B;
	Fri,  6 Nov 2026 12:10:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vBlx5HtZ3Vdx; Fri,  6 Nov 2026 12:10:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 85D704099C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793967032;
	b=Z5/ifMOO6vM7KXVRSDELvUPHR+YDU/pPwpddGVyZzVdUJ1oRbb7+qzuGx3cvBtnbepcR
	 izeDYVpJnL3+wt+qyDxZQG5Zx5kagvjiJ9xhAfxy1I2KmEM41nFnlkbPSkklOLyoutNf5
	 xpLuYgRWcuZ9JxLv450wWKpGqgDBwzQYjhDMI0NV36pp34VUKnr2X0YSfKs4asyoQC2+u
	 /3c/Y7EB/ZkpmQp9kRvgafdPIjqslf0y3SW1M6HC7TBVsak5sfWjUoAncMUZdXl8iupQF
	 NhznSZYPCPapX4A/skLfRk9aaFMYOfdh/HKEGoc/MkGep/6ulRoEuwK/RfenWjFeCKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793967032;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3j3c3pcnobXT5UTKfPsfm3pDI3GgmWjiQbI0W7wMjJA=;
	b=Gq+ze9391AQSR5EhhyYfGMmDmUI52UK3ycroJC2SoHQ6xxQ8uU7YKucwYOCOcb3kA3VC
	 BWY/Sh8n5B6qdcPFi/+dyS7LwvV8fqeoGPbhjw3+wPc4+Ihm2M0pcTfosuQXTvxp0boKa
	 h7gX6wqajSlDyNC0dANmSuOIjVX0JDsqk3fvO8mP0kCLLaahpJ0SOlC2RZqp9q0vp62Tf
	 weXthwuXfB/D9lGjPqWcSQb/IGWZyc9rdC+jH9ze5pSYDLNTHrDWRhv3vowISRiSc7U9X
	 eVH4iC/we3/UquHk7RsprZyGmtECXUo2VGYEWG04siAipi7hlVzXtJp56GnumFSpt6A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KPKbRjpR;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793967032;
	bh=3j3c3pcnobXT5UTKfPsfm3pDI3GgmWjiQbI0W7wMjJA=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EerURozNVNSpbG5VVO0aLLXIEpBB4WUag/k9Wo0q+v1ZJ9Y6thPS+AWFU1llDZ7Sn
	 pQOsxGDnN+kqG5+Kq9tw1JA53pAKRiRUaevr4WsCa4jD9exN2c65JTsGu0/BGOnsmK
	 Pp0xR0JqSgu7h0U+zstOtTTNBDLraHm1bTFpbhdg8eaWu6rlKeJRpBS9kWhJKVDy6g
	 NJBDQps5LNJIPvtMK/Rp1kMcKbDTGNOZ12nWXwsyhCe7oAPsxmW9U216oeNVCJYqBu
	 lOdSWg9+9CHRI4ZDfk8C6l9xx7dSqtBG/Py3feqkvzqTYspB4YcybS7W74/vZcSx9p
	 w4NpxcZwJWbkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85D704099C;
	Fri,  6 Nov 2026 12:10:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ED7FB362
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF77A40993
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDo_-zr-IHjT for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 12:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 84E8940994
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KPKbRjpR
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84E8940994
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793967030; x=1825503030; h=date:from:to:subject:message-id;
 bh=4nC5EJa33zXs6XXzpjRApTQ8wuVuLonBGV0S9ROLnHA=;
 b=KPKbRjpRP90GmqbJSxp4pU41TF/QiXZ4O+a0JiEuhIe0qspKG1YQ8owp
 SUf4Btec9citRTH1qlBUkV3TfshU3hq7VhlMSxRbD0wBd4R1t1CwFwQeD
 SrsJt9W+/mbtHcWUG+1ZaPp8FkLaFE9r3/PFzcCpF0DFcmos3rDIYl9E3
 Rm3wut13hE0NEOPQjGK1MstPQz8GUFv7hJw8dNsGBM6UGU056cR9CK7bT
 niiZQ+TRhqN2TYNBqCt7oBRfPafP1Ea0KLEYVqgdGA1/PaZ6rRY0dzRak
 n/8bvNyS6jP26EOHzu/e4LtVw4hLRuMqQjT9HZlYc8CTn9XKfZlpI2mC5 Q==;
X-CSE-ConnectionGUID: g1yrw7S3Q1ix9FxRWDjSvQ==
X-CSE-MsgGUID: uITeAdpiRheIPmGNE2qAGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2772182"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2772182"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 04:10:26 -0800
X-CSE-ConnectionGUID: u8edCqa+S8azfe3U9FCSRQ==
X-CSE-MsgGUID: 25yvb3F4QJKJIsTSVKhoXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7828577"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa010.fm.intel.com with ESMTP; 06 Nov 2026 04:10:25 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xPIly-00000000pCj-0e6P;
 Fri, 06 Nov 2026 12:10:22 +0000
Date: Fri, 06 Nov 2026 20:09:27 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:main] BUILD SUCCESS
 fafbc4051123d5459ea6950899cec08ed946e278
Message-ID: <20261106200927.1cNxhnaP-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git main
branch HEAD: fafbc4051123d5459ea6950899cec08ed946e278  tcp: ipv6: free ireq->ipv6_opt after an RCU grace period

elapsed time: 1273m

configs tested: 199
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261106    gcc-8.5.0
arc                   randconfig-1001-20261106    gcc-8.5.0
arc                         vdk_hs38_defconfig    clang-17
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                         clps711x_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                          lpc32xx_defconfig    clang-17
arm                             mps2_defconfig    clang-24
arm                   randconfig-1000-20261106    gcc-8.5.0
arm                   randconfig-1001-20261106    gcc-8.5.0
arm                   randconfig-1002-20261106    gcc-8.5.0
arm                   randconfig-1003-20261106    gcc-8.5.0
arm                            sunxi_defconfig    clang-17
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261106    clang-17
arm64                 randconfig-1001-20261106    clang-17
arm64                 randconfig-1002-20261106    clang-17
arm64                 randconfig-1003-20261106    clang-17
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261106    clang-17
csky                  randconfig-1001-20261106    clang-17
hexagon                           alldefconfig    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261106    gcc-14.4.0
hexagon               randconfig-1001-20261106    gcc-14.4.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261106    clang-22
i386        buildonly-randconfig-1001-20261106    clang-22
i386        buildonly-randconfig-1002-20261106    clang-22
i386        buildonly-randconfig-1003-20261106    clang-22
i386        buildonly-randconfig-1004-20261106    clang-22
i386        buildonly-randconfig-1005-20261106    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261106    gcc-14
i386                  randconfig-1001-20261106    gcc-14
i386                  randconfig-1002-20261106    gcc-14
i386                  randconfig-1003-20261106    gcc-14
i386                  randconfig-1004-20261106    gcc-14
i386                  randconfig-1005-20261106    gcc-14
i386                  randconfig-1006-20261106    gcc-14
i386                  randconfig-1007-20261106    gcc-14
i386                  randconfig-1008-20261106    gcc-14
i386                  randconfig-1009-20261106    gcc-14
i386                  randconfig-1010-20261106    gcc-14
i386                  randconfig-1011-20261106    gcc-14
i386                  randconfig-1012-20261106    gcc-14
i386                  randconfig-1013-20261106    gcc-14
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261106    gcc-14.4.0
loongarch             randconfig-1001-20261106    gcc-14.4.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                           atari_defconfig    clang-17
m68k                                 defconfig    clang-24
m68k                        m5329evb_defconfig    clang-24
m68k                          nettel_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                   cavium_octeon_defconfig    gcc-16.2.0
mips                           eyeq5_defconfig    clang-17
mips                       loongson3_defconfig    gcc-16.2.0
mips                 malta_qemu_32r6_defconfig    clang-17
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261106    gcc-14.4.0
nios2                 randconfig-1001-20261106    gcc-14.4.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc                   or1klitex_defconfig    clang-24
openrisc                  simple_smp_defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261106    clang-19
parisc                randconfig-1001-20261106    clang-19
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      ep8248e_defconfig    clang-17
powerpc                      ep8248e_defconfig    clang-24
powerpc                       ep88xc_defconfig    clang-17
powerpc                       mgcoge_defconfig    clang-17
powerpc                      mpc512x_defconfig    gcc-16.2.0
powerpc                   mpc866_ads_defconfig    clang-17
powerpc                       pcm030_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261106    clang-19
powerpc               randconfig-1001-20261106    clang-19
powerpc                  xes_mpc85xx_defconfig    clang-17
powerpc64             randconfig-1000-20261106    clang-19
powerpc64             randconfig-1001-20261106    clang-19
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261106    gcc-14.4.0
riscv                 randconfig-1001-20261106    gcc-14.4.0
s390                              alldefconfig    clang-17
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261106    gcc-14.4.0
s390                  randconfig-1001-20261106    gcc-14.4.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-17
sh                             migor_defconfig    clang-24
sh                    randconfig-1000-20261106    gcc-14.4.0
sh                    randconfig-1001-20261106    gcc-14.4.0
sh                           rsk7201_defconfig    clang-17
sh                         sh7757lcr_defconfig    gcc-16.2.0
sh                              shx3_defconfig    clang-17
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261106    gcc-15.3.0
sparc                 randconfig-1001-20261106    gcc-15.3.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261106    gcc-15.3.0
sparc64               randconfig-1001-20261106    gcc-15.3.0
um                                alldefconfig    gcc-16.2.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261106    gcc-15.3.0
um                    randconfig-1001-20261106    gcc-15.3.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261106    gcc-13
x86_64      buildonly-randconfig-1001-20261106    gcc-13
x86_64      buildonly-randconfig-1002-20261106    gcc-13
x86_64      buildonly-randconfig-1003-20261106    gcc-13
x86_64      buildonly-randconfig-1004-20261106    gcc-13
x86_64      buildonly-randconfig-1005-20261106    gcc-13
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261106    clang-22
x86_64                randconfig-1001-20261106    clang-22
x86_64                randconfig-1002-20261106    clang-22
x86_64                randconfig-1003-20261106    clang-22
x86_64                randconfig-1004-20261106    clang-22
x86_64                randconfig-1005-20261106    clang-22
x86_64                randconfig-1006-20261106    clang-22
x86_64                randconfig-1007-20261106    clang-22
x86_64                randconfig-1008-20261106    clang-22
x86_64                randconfig-1009-20261106    clang-22
x86_64                randconfig-1010-20261106    clang-22
x86_64                randconfig-1011-20261106    clang-22
x86_64                randconfig-1012-20261106    gcc-14
x86_64                randconfig-1013-20261106    gcc-14
x86_64                randconfig-1014-20261106    gcc-14
x86_64                randconfig-1015-20261106    gcc-14
x86_64                randconfig-1016-20261106    gcc-14
x86_64                randconfig-1017-20261106    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   nommu_kc705_defconfig    clang-24
xtensa                randconfig-1000-20261106    gcc-15.3.0
xtensa                randconfig-1001-20261106    gcc-15.3.0
xtensa                     xip_kc705_defconfig    clang-17

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
