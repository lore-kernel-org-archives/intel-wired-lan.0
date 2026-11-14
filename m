Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6E606A329
	for <intel-wired-lan@archiver.kernel.org>; Sat, 14 Nov 2026 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=W7AxhsaW;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VjAHTsx+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB69E407D1;
	Sat, 14 Nov 2026 21:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RbmWUES8q0Ck; Sat, 14 Nov 2026 21:14:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A983E407E0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794690856;
	b=Pp4V9Gs5WxtjmNPyHRH26QZXBUAlpRf0ED4XXbonHH5+aD4bIo8+CL/I8fBKWEBKpVVl
	 e2tPcn+KhiEO3769QMzJZP0gUCwnR+WkYbIIL/scoWn+Yu44bXzfzan9TfI6+5j+T2zyO
	 VKpF0q3tizT9j/1wPx5QqVg+8Op/0wRneJiMTI/tmPY8VPifs2fvu7Mhe3P6JMaN1YWll
	 +VyvjFBclu7LrD8b7/uy2fOD7PvjDYKrvjOp5KLHK9n+rfrZduWRb3aMuvzjv9nBMqW8j
	 mw1txsOoNZYEY3PDmOmY1S2mYSkTxrt0gD9wyeJuYt06XunBAhxcdeAspwdIkLSFfpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794690856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YelMUUQggDeSRR2/BCUz/9TtY7CSc1IIDQCo/T6Nl8M=;
	b=SsKY7qEjlmnEBjagnpYw23mmcWM0tPMi2GpgrvxcPKV5WFiI6b8kri2D5NT5aMS6PPQ6
	 EFWs0b5tEnw1/79ai4OphinXceTB8RdIHgzVna2rryB2fJYa9DyVNJSnseKAKYE8/ROjk
	 A/o+cu4vbxwUlw0tqDAtreZbYksy3Jg679yeAOaJXjEJSF5bLz2vm4UEcksrfp8nV9SUV
	 0HNC3BClFIyKNn/1W/jRkL2DGSMh3sbz76abDXt9n+yEfgitye6dPurJ88eawzU1S7Ic8
	 MaqKYD+wvhWdHNLbUle2SxZRvpXTt/5pDsaVsfTEbxka7fXSz5W2mO3XFB2AM9bplaw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VjAHTsx+;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794690856;
	bh=YelMUUQggDeSRR2/BCUz/9TtY7CSc1IIDQCo/T6Nl8M=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W7AxhsaWDwCpf0WBrjD8wzdmQwkBlAuoqGn/mmwnM/Dx7STkAEO0yS77UXLsn/UnD
	 pOXCCwonQWDzzZXGFYbX2yPNH0drs9lH0zJ1jkTkCtuej3fkAa8MtfNaxpoEgc5KON
	 u8vkIsPM+qx8lBc6gQKpRH1oCrCf+l0pmvW2Q+Dns/w/ISYOhkqzKlkEeFdyGfj13J
	 hh7tTor4sOC425unX3nSLnWAvLirChnRrVbk3HiVT4mJNogEUwSQ7bN6jAuUlXl3Di
	 cWAMCfEDrUA4tWZzpJxHfnvv6Y27XgS8/tku/paWMSDTmoIyFO4z4xIlT+mMi7rxRV
	 Rvdb7ZTAn7BAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A983E407E0;
	Sat, 14 Nov 2026 21:14:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D82CA72D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 21:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE538407D0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 21:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9xFgmFer54Ic for <intel-wired-lan@lists.osuosl.org>;
 Sat, 14 Nov 2026 21:14:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2069A407D1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VjAHTsx+
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2069A407D1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794690854; x=1826226854; h=date:from:to:subject:message-id;
 bh=MUMLn4thZcm3B47bxGGTV2e5ztzGjHaNE0YEUucbSDU=;
 b=VjAHTsx+jOqaIyEYN27+8vHSAGEWoo0Dq1eufvklFQ/RZSr2TXWpOVJT
 Txm/GDoz9CZumdeUA+IJZwTYIjrx7728Mz/BLG1Yd176scLwYmq1jpBCb
 QTF/2G/GqyPOz3c/QTdiflwO8COSXhUGeWs/hpuDQoD50WoEo4vLLe3zU
 x5g+7I/3xx9EAejRJHK5XnwyXJJeiyrmKl52P/4m56PsGyUFMVrPQWiOz
 VSDTSUaupPuApAgFUb7R9baJGx+4Q0sKrwwb317tTUxU9Z3vrVpIlDeNH
 C2DIvbkytLMvEvqU8H9l6q97DTwpuHrCGS7jazKGw9XmjZRCFJUzg3KTx Q==;
X-CSE-ConnectionGUID: 9QEcuXdWQTq4RQNKtLFI8Q==
X-CSE-MsgGUID: xJ9iCfFMQbK+cH7upKUZOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3365087"
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="3365087"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2026 13:14:12 -0800
X-CSE-ConnectionGUID: NUURM969QRaB+cpVxfxRjg==
X-CSE-MsgGUID: zk8cRjQkQZCG/fNBTLLLsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; d="scan'208";a="10982244"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa011.fm.intel.com with ESMTP; 14 Nov 2026 13:14:11 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xSL4b-000000015zu-0YFi;
 Sat, 14 Nov 2026 21:14:09 +0000
Date: Sun, 15 Nov 2026 05:13:59 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:100GbE] BUILD SUCCESS
 ee82866c5cc57362db8387afca18b0e8945df2c3
Message-ID: <20261115051359.b0JWziwS-lkp@intel.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: ee82866c5cc57362db8387afca18b0e8945df2c3  ice: allow reading the last byte of the NVM and Shadow RAM regions

elapsed time: 789m

configs tested: 195
configs skipped: 1

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
arc                   randconfig-1000-20261114    clang-24
arc                   randconfig-1000-20261115    gcc-11.5.0
arc                   randconfig-1001-20261114    clang-24
arc                   randconfig-1001-20261115    gcc-11.5.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                            omap1_defconfig    clang-24
arm                   randconfig-1000-20261114    clang-24
arm                   randconfig-1000-20261115    gcc-11.5.0
arm                   randconfig-1001-20261114    clang-24
arm                   randconfig-1001-20261115    gcc-11.5.0
arm                   randconfig-1002-20261114    clang-24
arm                   randconfig-1002-20261115    gcc-11.5.0
arm                   randconfig-1003-20261114    clang-24
arm                   randconfig-1003-20261115    gcc-11.5.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261114    gcc-16.2.0
arm64                 randconfig-1001-20261114    gcc-16.2.0
arm64                 randconfig-1002-20261114    gcc-16.2.0
arm64                 randconfig-1003-20261114    gcc-16.2.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261114    gcc-16.2.0
csky                  randconfig-1001-20261114    gcc-16.2.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261114    clang-24
hexagon               randconfig-1000-20261115    clang-24
hexagon               randconfig-1001-20261114    clang-24
hexagon               randconfig-1001-20261115    clang-24
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261114    gcc-14
i386        buildonly-randconfig-1001-20261114    gcc-14
i386        buildonly-randconfig-1002-20261114    gcc-14
i386        buildonly-randconfig-1003-20261114    gcc-14
i386        buildonly-randconfig-1004-20261114    gcc-14
i386        buildonly-randconfig-1005-20261114    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261114    gcc-12
i386                  randconfig-1000-20261115    clang-22
i386                  randconfig-1001-20261114    gcc-12
i386                  randconfig-1001-20261115    clang-22
i386                  randconfig-1002-20261114    gcc-12
i386                  randconfig-1002-20261115    clang-22
i386                  randconfig-1003-20261114    gcc-12
i386                  randconfig-1003-20261115    clang-22
i386                  randconfig-1004-20261114    gcc-12
i386                  randconfig-1004-20261115    clang-22
i386                  randconfig-1005-20261114    gcc-12
i386                  randconfig-1005-20261115    clang-22
i386                  randconfig-1006-20261114    gcc-12
i386                  randconfig-1006-20261115    clang-22
i386                  randconfig-1007-20261114    clang-22
i386                  randconfig-1008-20261114    clang-22
i386                  randconfig-1009-20261114    clang-22
i386                  randconfig-1010-20261114    clang-22
i386                  randconfig-1011-20261114    clang-22
i386                  randconfig-1012-20261114    clang-22
i386                  randconfig-1013-20261114    clang-22
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261114    clang-24
loongarch             randconfig-1000-20261115    clang-24
loongarch             randconfig-1001-20261114    clang-24
loongarch             randconfig-1001-20261115    clang-24
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                            jazz_defconfig    clang-24
mips                         omega2p_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261114    clang-24
nios2                 randconfig-1000-20261115    clang-24
nios2                 randconfig-1001-20261114    clang-24
nios2                 randconfig-1001-20261115    clang-24
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                    motionpro_defconfig    clang-24
powerpc                      mpc5200_defconfig    clang-24
powerpc                  mpc837x_rdb_defconfig    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                 randconfig-1000-20261114    gcc-15.3.0
riscv                 randconfig-1001-20261114    gcc-15.3.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                  randconfig-1000-20261114    gcc-15.3.0
s390                  randconfig-1001-20261114    gcc-15.3.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                          ecovec24_defconfig    clang-24
sh                    randconfig-1000-20261114    gcc-15.3.0
sh                    randconfig-1001-20261114    gcc-15.3.0
sh                            se7751_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                 randconfig-1000-20261114    gcc-12.5.0
sparc                 randconfig-1001-20261114    gcc-12.5.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261114    gcc-12.5.0
sparc64               randconfig-1001-20261114    gcc-12.5.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261114    gcc-12.5.0
um                    randconfig-1001-20261114    gcc-12.5.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261114    gcc-14
x86_64      buildonly-randconfig-1001-20261114    gcc-14
x86_64      buildonly-randconfig-1002-20261114    gcc-14
x86_64      buildonly-randconfig-1003-20261114    gcc-14
x86_64      buildonly-randconfig-1004-20261114    gcc-14
x86_64      buildonly-randconfig-1005-20261114    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261114    gcc-14
x86_64                randconfig-1000-20261115    gcc-14
x86_64                randconfig-1001-20261114    gcc-14
x86_64                randconfig-1001-20261115    gcc-14
x86_64                randconfig-1002-20261114    gcc-14
x86_64                randconfig-1002-20261115    gcc-14
x86_64                randconfig-1003-20261114    gcc-14
x86_64                randconfig-1003-20261115    gcc-14
x86_64                randconfig-1004-20261114    gcc-14
x86_64                randconfig-1004-20261115    gcc-14
x86_64                randconfig-1005-20261114    gcc-14
x86_64                randconfig-1005-20261115    gcc-14
x86_64                randconfig-1006-20261114    gcc-14
x86_64                randconfig-1007-20261114    gcc-14
x86_64                randconfig-1008-20261114    gcc-14
x86_64                randconfig-1009-20261114    gcc-14
x86_64                randconfig-1010-20261114    gcc-14
x86_64                randconfig-1011-20261114    gcc-14
x86_64                randconfig-1012-20261114    clang-22
x86_64                randconfig-1012-20261115    gcc-14
x86_64                randconfig-1013-20261114    clang-22
x86_64                randconfig-1013-20261115    gcc-14
x86_64                randconfig-1014-20261114    clang-22
x86_64                randconfig-1014-20261115    gcc-14
x86_64                randconfig-1015-20261114    clang-22
x86_64                randconfig-1015-20261115    gcc-14
x86_64                randconfig-1016-20261114    clang-22
x86_64                randconfig-1016-20261115    gcc-14
x86_64                randconfig-1017-20261114    clang-22
x86_64                randconfig-1017-20261115    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261114    gcc-12.5.0
xtensa                randconfig-1001-20261114    gcc-12.5.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
