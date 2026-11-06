Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C4606A32C
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=iilNK9CK;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eTGLxESy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F29CF409CB;
	Fri,  6 Nov 2026 23:25:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xWUrQlq58x6U; Fri,  6 Nov 2026 23:25:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD591409C3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794007536;
	b=lnjXiJNN4rOM0bbSK6LAj3cUaKY9SZaZZZaq/amNa+GoiSZLNOXnjc/kSXswIjaIcP/0
	 tOLeQDuCvwmvGSGMWuZq2Lynidm1xeXEIVe+mmp+Si5rDr9DmBJatwKE3FoOu3BpXuoeg
	 48WIaDxHnN+F9p4Hn6Ow8GO3IuUPLA4gbqgvn02l+RnoR6m1cnUmIsM8rW5mHP/M6eyz7
	 bVxLjqjkCecvC7hModtB+kLIWUS+yCZl04rYSx7L/mTmcL/k54JFox6EnJzufLBO7T0Km
	 yiroi8BwFaBjKQ2xik0UgFMAmZlNAlieMw+PbXmmGIOnfg8a0vijuvRlCYlG47wIBbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794007536;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=72/xmO/kpguArnpYNPjhp8vLN59a6P91hJozQPo1xdY=;
	b=XFtYo/OIXSOlWxuaKCj08KL2ZQZXJf20gVYa1IcZIuADPEXQ24g/t1M77E1vNzEAxZZx
	 +pgsi65SlYgi1pAbxaIoW74+yDe4D5Y6po1aPAG1c71J64iIqgUnLegvkPFjNcFBlE4oh
	 F+rwaB9cEWxVI+uU7kgyTa6ciBpHNBupbTT6fHe6Aa/chcScJeSWwh9z2uGC6MMfephIU
	 fe6ilBl+RkAVDfoRRqAVRBfdd6Jyg99Z16s4BdatLu6vQnCGAm22QUNdVLzUdCuytgvxQ
	 bq1zVwBNJwJVOQoD5jVNIlFlaD/fglvbvwtQbTSyzaW9rhNKPEs1KrUA2E97yt4a/wQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794007536;
	bh=72/xmO/kpguArnpYNPjhp8vLN59a6P91hJozQPo1xdY=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iilNK9CKLCZ0w2WGaFFXY9D0Ke+h1hQN+9h0IVP0dIrNwbkeEf9CPiRK+GpGpf+RF
	 BkO88fROjBE/L/EslOK3tT8/lM30+BfwDrUZ4PM8GeW/c78Y3RK2/p2stTBRhZIeWA
	 Aa7Hqx3XnjKYGWctU1oEqFX13hqhSSAwG6lfbcohuC7QJwzMKxiLxs/VdJ7bApcqUg
	 mxMs8XEY1OrDxJEojgk6dPvbY195TeHPxXejGiZPQN9yFv/PyRuuixORwGUgO+mgtb
	 9nRwsMZoNf/7FW/xxLMWzv0p/4aYxcL4mGqFhvqf0opEIqhVugruFfjsqzk5LMio5x
	 yBOp5jQkU8yCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD591409C3;
	Fri,  6 Nov 2026 23:25:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AE33362
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 23:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C173403FE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 23:25:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oSU3N2Cr9rWK for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 23:25:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8E53840403
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eTGLxESy
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E53840403
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 23:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794007534; x=1825543534; h=date:from:to:subject:message-id;
 bh=T1nBQAz5cJpEaL6b6NxkTlZWPv2flcWjqiOW4uu0h6I=;
 b=eTGLxESyZJzZMbQzPtdis3UrtkyDhjb60NXtux3k2IsMlHsKxUy+c2fx
 qDZktfTU2J2iF0WOWlX5fGYA+hTPUpkaOK+Qd2Dtb9X9Hx/Jmc19naAC9
 49FslPU6b0PBTcGUmJeTTTEShyFlU6rA+NbQPozVC916D62I5bvLcABIM
 hdp7ADSSV4XFlzNTNZU3Xgg+z8gN3dkwn3TUfNtrj438Hcq+qKOMeQmMS
 FIlTvdS9zVfc+DI17SFw9Zkt1OhaqgGf5Ws/MKWinTisbSiIZq0GorNps
 VNEAuyG3zGiQQ6EjG/Vd5btwKev2exvv+sLwcgEz/f5qGzo/xDgWLq5xH w==;
X-CSE-ConnectionGUID: syUMez22TRancln7GHpxsw==
X-CSE-MsgGUID: tUvHDqOARECA7kD2nZi6mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2828576"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2828576"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 15:25:33 -0800
X-CSE-ConnectionGUID: ng1A+1EiQU67kanHlANQgw==
X-CSE-MsgGUID: OJt7G4vSQp6XtWCHfb8+cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7248198"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa004.jf.intel.com with ESMTP; 06 Nov 2026 15:25:32 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xPTJJ-00000000q4p-0TJX;
 Fri, 06 Nov 2026 23:25:29 +0000
Date: Sat, 07 Nov 2026 07:25:26 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:main] BUILD SUCCESS
 303d91a1592587fdb481dd36a9ef2c0414dacb0f
Message-ID: <20261107072526.mbWbpo8C-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git main
branch HEAD: 303d91a1592587fdb481dd36a9ef2c0414dacb0f  net: ipa: Drop unused qmi_elem_info arrays

elapsed time: 1396m

configs tested: 301
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                         nsim_700_defconfig    gcc-16.2.0
arc                      nsimosci_hs_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261106    gcc-8.5.0
arc                   randconfig-1001-20261106    gcc-8.5.0
arc                   randconfig-2200-20261106    gcc-10.5.0 smatch
arc                         vdk_hs38_defconfig    gcc-16.2.0
arc                     vdk_hs38_smp_defconfig    gcc-16.2.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                      am200epdkit_defconfig    gcc-16.2.0
arm                        aspeed_g5_defconfig    gcc-16.2.0
arm                         clps711x_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                            h3600_defconfig    gcc-16.2.0
arm                            imxrt_defconfig    gcc-16.2.0
arm                    milbeaut_m10v_defconfig    gcc-16.2.0
arm                             mps2_defconfig    clang-24
arm                         neponset_defconfig    gcc-16.2.0
arm                            omap1_defconfig    gcc-16.2.0
arm                        omap2plus_defconfig    gcc-16.2.0
arm                              pxa_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261106    gcc-8.5.0
arm                   randconfig-1001-20261106    gcc-8.5.0
arm                   randconfig-1002-20261106    gcc-8.5.0
arm                   randconfig-1003-20261106    gcc-8.5.0
arm                              rpc_defconfig    gcc-16.2.0
arm                           sp7021_defconfig    gcc-16.2.0
arm                         spear3xx_defconfig    gcc-16.2.0
arm                            spitz_defconfig    gcc-16.2.0
arm                            tegra_defconfig    gcc-16.2.0
arm                        versatile_defconfig    gcc-16.2.0
arm                         vexpress_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261106    clang-17
arm64                 randconfig-1000-20261107    gcc-11.5.0
arm64                 randconfig-1001-20261106    clang-17
arm64                 randconfig-1001-20261107    gcc-11.5.0
arm64                 randconfig-1002-20261106    clang-17
arm64                 randconfig-1002-20261107    gcc-11.5.0
arm64                 randconfig-1003-20261106    clang-17
arm64                 randconfig-1003-20261107    gcc-11.5.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261106    clang-17
csky                  randconfig-1000-20261107    gcc-11.5.0
csky                  randconfig-1001-20261106    clang-17
csky                  randconfig-1001-20261107    gcc-11.5.0
hexagon                           alldefconfig    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261106    gcc-14.4.0
hexagon               randconfig-1000-20261107    clang-18
hexagon               randconfig-1001-20261106    gcc-14.4.0
hexagon               randconfig-1001-20261107    clang-18
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261106    clang-22
i386        buildonly-randconfig-1000-20261107    gcc-14
i386        buildonly-randconfig-1001-20261106    clang-22
i386        buildonly-randconfig-1001-20261107    gcc-14
i386        buildonly-randconfig-1002-20261106    clang-22
i386        buildonly-randconfig-1002-20261107    gcc-14
i386        buildonly-randconfig-1003-20261106    clang-22
i386        buildonly-randconfig-1003-20261107    gcc-14
i386        buildonly-randconfig-1004-20261106    clang-22
i386        buildonly-randconfig-1004-20261107    gcc-14
i386        buildonly-randconfig-1005-20261106    clang-22
i386        buildonly-randconfig-1005-20261107    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261106    gcc-14
i386                  randconfig-1000-20261107    clang-22
i386                  randconfig-1001-20261106    gcc-14
i386                  randconfig-1001-20261107    clang-22
i386                  randconfig-1002-20261106    gcc-14
i386                  randconfig-1002-20261107    clang-22
i386                  randconfig-1003-20261106    gcc-14
i386                  randconfig-1003-20261107    clang-22
i386                  randconfig-1004-20261106    gcc-14
i386                  randconfig-1004-20261107    clang-22
i386                  randconfig-1005-20261106    gcc-14
i386                  randconfig-1005-20261107    clang-22
i386                  randconfig-1006-20261106    gcc-14
i386                  randconfig-1006-20261107    clang-22
i386                  randconfig-1007-20261106    gcc-14
i386                  randconfig-1007-20261107    clang-22
i386                  randconfig-1008-20261106    gcc-14
i386                  randconfig-1008-20261107    clang-22
i386                  randconfig-1009-20261106    gcc-14
i386                  randconfig-1009-20261107    clang-22
i386                  randconfig-1010-20261106    gcc-14
i386                  randconfig-1010-20261107    clang-22
i386                  randconfig-1011-20261106    gcc-14
i386                  randconfig-1011-20261107    clang-22
i386                  randconfig-1012-20261106    gcc-14
i386                  randconfig-1012-20261107    clang-22
i386                  randconfig-1013-20261106    gcc-14
i386                  randconfig-1013-20261107    clang-22
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    gcc-16.2.0
loongarch             randconfig-1000-20261106    gcc-14.4.0
loongarch             randconfig-1000-20261107    clang-18
loongarch             randconfig-1001-20261106    gcc-14.4.0
loongarch             randconfig-1001-20261107    clang-18
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                         m5272c3_defconfig    gcc-16.2.0
m68k                        m5329evb_defconfig    clang-24
m68k                           multi_defconfig    gcc-16.2.0
microblaze                        alldefconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                           ath25_defconfig    gcc-16.2.0
mips                        bmips_be_defconfig    gcc-16.2.0
mips                          db1xxx_defconfig    gcc-16.2.0
mips                           eyeq5_defconfig    gcc-16.2.0
mips                            gcw0_defconfig    gcc-16.2.0
mips                            ip28_defconfig    gcc-16.2.0
mips                           malta_defconfig    gcc-16.2.0
mips                       maltasmvp_defconfig    gcc-16.2.0
mips                   maltasmvp_eva_defconfig    clang-24
mips                   maltasmvp_eva_defconfig    gcc-16.2.0
mips                           rm200_defconfig    gcc-16.2.0
mips                            rs90_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261106    gcc-14.4.0
nios2                 randconfig-1000-20261107    clang-18
nios2                 randconfig-1001-20261106    gcc-14.4.0
nios2                 randconfig-1001-20261107    clang-18
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                    de0_nano_defconfig    gcc-16.2.0
openrisc                             defconfig    gcc-16.2.0
openrisc                   or1klitex_defconfig    clang-24
openrisc                   or1klitex_defconfig    gcc-16.2.0
openrisc                     or1ksim_defconfig    gcc-16.2.0
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
powerpc                      ep8248e_defconfig    clang-24
powerpc                        holly_defconfig    clang-24
powerpc                      kmeter1_defconfig    gcc-16.2.0
powerpc                      ksi8560_defconfig    gcc-16.2.0
powerpc                  linkstation_defconfig    clang-24
powerpc                    lite5200b_defconfig    gcc-16.2.0
powerpc                  mpc8315_rdb_defconfig    gcc-16.2.0
powerpc                       pcm030_defconfig    gcc-16.2.0
powerpc                       pmac32_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261106    clang-19
powerpc               randconfig-1001-20261106    clang-19
powerpc                      redwood_defconfig    gcc-16.2.0
powerpc                     sam440ep_defconfig    gcc-16.2.0
powerpc                     socrates_defconfig    gcc-16.2.0
powerpc                      taishan_defconfig    gcc-16.2.0
powerpc                      tqm5200_defconfig    gcc-16.2.0
powerpc                      tqm8540_defconfig    gcc-16.2.0
powerpc                      tqm8560_defconfig    gcc-16.2.0
powerpc                          wii_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261106    clang-19
powerpc64             randconfig-1001-20261106    clang-19
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261106    gcc-14.4.0
riscv                 randconfig-1000-20261107    gcc-11.5.0
riscv                 randconfig-1001-20261106    gcc-14.4.0
riscv                 randconfig-1001-20261107    gcc-11.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261106    gcc-14.4.0
s390                  randconfig-1000-20261107    gcc-11.5.0
s390                  randconfig-1001-20261106    gcc-14.4.0
s390                  randconfig-1001-20261107    gcc-11.5.0
s390                        zfcpdump_defconfig    gcc-16.2.0
sh                                alldefconfig    clang-24
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                 ecovec24-romimage_defconfig    gcc-16.2.0
sh                              espt_defconfig    clang-24
sh                              espt_defconfig    gcc-16.2.0
sh                             hp6xx_defconfig    clang-24
sh                             hp6xx_defconfig    gcc-16.2.0
sh                             migor_defconfig    clang-24
sh                           r7780mp_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261106    gcc-14.4.0
sh                    randconfig-1000-20261107    gcc-11.5.0
sh                    randconfig-1001-20261106    gcc-14.4.0
sh                    randconfig-1001-20261107    gcc-11.5.0
sh                            se7619_defconfig    gcc-16.2.0
sh                            sh2007_defconfig    gcc-16.2.0
sh                         sh7785lcr_defconfig    gcc-16.2.0
sh                               ul2_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261106    gcc-15.3.0
sparc                 randconfig-1001-20261106    gcc-15.3.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261106    gcc-15.3.0
sparc64               randconfig-1001-20261106    gcc-15.3.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261106    gcc-15.3.0
um                    randconfig-1001-20261106    gcc-15.3.0
um                            x86_64_defconfig    gcc-14
x86_64                            alldefconfig    gcc-16.2.0
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261106    gcc-13
x86_64      buildonly-randconfig-1000-20261107    gcc-14
x86_64      buildonly-randconfig-1001-20261106    gcc-13
x86_64      buildonly-randconfig-1001-20261107    gcc-14
x86_64      buildonly-randconfig-1002-20261106    gcc-13
x86_64      buildonly-randconfig-1002-20261107    gcc-14
x86_64      buildonly-randconfig-1003-20261106    gcc-13
x86_64      buildonly-randconfig-1003-20261107    gcc-14
x86_64      buildonly-randconfig-1004-20261106    gcc-13
x86_64      buildonly-randconfig-1004-20261107    gcc-14
x86_64      buildonly-randconfig-1005-20261106    gcc-13
x86_64      buildonly-randconfig-1005-20261107    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261106    clang-22
x86_64                randconfig-1000-20261107    gcc-14
x86_64                randconfig-1001-20261106    clang-22
x86_64                randconfig-1001-20261107    gcc-14
x86_64                randconfig-1002-20261106    clang-22
x86_64                randconfig-1002-20261107    gcc-14
x86_64                randconfig-1003-20261106    clang-22
x86_64                randconfig-1003-20261107    gcc-14
x86_64                randconfig-1004-20261106    clang-22
x86_64                randconfig-1004-20261107    gcc-14
x86_64                randconfig-1005-20261106    clang-22
x86_64                randconfig-1005-20261107    gcc-14
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
xtensa                   cadence_csp_defconfig    gcc-16.2.0
xtensa                        common_defconfig    clang-24
xtensa                   nommu_kc705_defconfig    clang-24
xtensa                randconfig-1000-20261106    gcc-15.3.0
xtensa                randconfig-1001-20261106    gcc-15.3.0
xtensa                          virt_defconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
