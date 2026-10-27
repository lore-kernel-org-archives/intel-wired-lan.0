Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B57606A31A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=HenZcQ1q;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hhb8EasS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8568808BD;
	Tue, 27 Oct 2026 21:52:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m9WTZewDPxjO; Tue, 27 Oct 2026 21:52:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A42508091C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793137953;
	b=N9S9rLvegbFRDToszl/zGKr+GXzyqPV19gEgFtwrPkha4SBW/5njbwJTOZHW8v1IJE9c
	 bsQyXMWoK5nMqA7yws5gyobK/ahJ8D6Blo3eflUEOounSJ9bbUfNUkmo1x1kbPdi+HsVF
	 OHNEJudKxF2enzVBNVdUKptuDJnikz+/5RNiAPiC0/yhhWQsnyJApblCB+LzTY7Ai6sqm
	 TNMuzjpo/POpnT0wAtfiAAnKSoxMUdXqUpHYk4Ve8DpxC4hDvyvMTbXeRQSM+9nnJcqQ/
	 XddCq/MS/UQYULdIJyjfLforCJ2V53H8I+bWmYHL1eVB9F7KepxagkJ6FFH+rZ1EnRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793137953;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=299dKGQMbBHWFsOgi+Z3P00I0CRYvaAD0FEZLZ1G2y8=;
	b=Jg+EDl5upNFMaXvZEyXGKxujKB+3z/L+RcWxEu8Ab7sQUoc4IHiAmLjas6w0Hi8Nm5Xy
	 VI6pU6nTkMej/hKUXeO8W3pyVEbNAp9pJz8fe2GqVDhjxTHyblEOFJNqBP5VMGUdDEl+l
	 RpKeWxGMAxhpXPGMaFyhE8VQx4uA84BCF1BRUVdnsY1VSCZB88ot6Y0WYR9Xs/kGNpi5o
	 hlz2XI8c9e8SxyKbj+zk/ZDhiQi/EBDw3AbfARlpHq8HtAPYF/+mDKUjNxbKtDOzEebgq
	 PbcAwbQ8NUjhjR4NCRhCCiSBc26U00Wpl7mrCTjTAdBBZ4BuoE2nyyeq+tznWUYfg8w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hhb8EasS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793137953;
	bh=299dKGQMbBHWFsOgi+Z3P00I0CRYvaAD0FEZLZ1G2y8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HenZcQ1q+5hTed7mmPxD0NHUiEBZjrdxzeEnEdE6tFJpaC7STN4XM+vftaGrneByq
	 J2ubEFdgU1T4Uh3F8qq6LecMw1QAbtUTdgEDzLsJPFlbnskh5S8zlEwoGHw46W7Jy1
	 RgeR7z6QGBwI+fAwAB3qBt2CIeC9ryKrGF63xUEEkNAoqkia/gIEvknaS6WrSTUdhw
	 eWvCAUcym+732QnZjDmKPMTxeKOeEarA1755uyq/WrJpVMxqZGCjKWDhk3rFNCvwsP
	 fnUu2O05nhVBl0oaXFcSeDOWebTcXZJkdjrkoLkXqbPfhXNlkeP95AZ47LXOJrLsmu
	 eUQkmvTLlhptQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A42508091C;
	Tue, 27 Oct 2026 21:52:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BFCAD4BC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 21:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B16EC8091C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 21:52:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jKKLSD6_v6KZ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 21:52:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2DEF1808BD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793137950;
 b=aU5BPaDYGJhSFo1D2GjDgknDMoVrtdvKmN3Mj5OncuSWNEIpPG44rkMf8dDVnozA9Ww/
 S/sOVpoOFOerVQ4GRuDMUZlZIAn9N2VSSxqaS0ve2kgo7k1FLLUmhweSyHEstMGL8ilnS
 Djrk505Ec8bKQqL+27WxfoiVWYI/w0CCmkd6tx51F7SsjApC/+w9N2qvOOxN/o13O0YVi
 6rpt1mg20OsgaItSJDfYjcYekXEOP8ny2RZ9N+ZfuiRK28ZlLzA06fhEwN8iTw2s1OSZm
 iGzT2SUkcWzHEB83g8D0XnkcOqEalM6/2IlgwegzunnlBrwQP/Wl5rVNgC00vdMNF3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793137950;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=299dKGQMbBHWFsOgi+Z3P00I0CRYvaAD0FEZLZ1G2y8=;
 b=n2VbejgPG0N4dC5firu8t/tkHU3tFKrqQHLvLGut7lChsTnHtTQelWBNm4ADnJVTZsBG
 0UNL+LeCMyDQFBeMqyQV0XaWnKvUCrjLDKooEb3AbpH1ll5u0URoG89LaMAMOi8BRzlSH
 JWYzRmqKU7dKps0FTY5rSDhyrC84FfHrR1LhPwWKwmliP47i2XhGEFQQyKxXmErSHFW2i
 OGeXGeLgCirU21Uq8MHVDAm3wjn8nU4E+Spb9tEqZPJLvZBqnYEUmmags5W3QDDdNCDGM
 1+e07VLXrdy4pkxQIZvbdtQWIlpZAO6xTrVxeDefNeHe9uPq265oVa6B4WgMyTyxCmQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Hhb8EasS; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Hhb8EasS
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2DEF1808BD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 21:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793137950; x=1824673950; h=date:from:to:subject:message-id;
 bh=UAyx+Guh/fF+hstpOPMUTa2wQExCpxVvGh35OrDKXcc=;
 b=Hhb8EasSEJ8Q45yAyvDczYWUlLt60GWuZ/bAp/hBQvwY3rPd7AVmQE6t
 +IfKAi54Z+hZZct8iTn8l9UsOdWN9Bw8Vfuctkv2SqUgIVmxToikR6DGx
 doZcKfpoq+wYviWlRq+Mlwqbn7wvrWpBGgCQa9RhNCfTZ1n9KSdG+s4z/
 DTmDGht7s6jiFkswWFzq6g7DOyJGQhDRtbbPLDghlSTuZj04K3Kq1ePfW
 b+45PunQdPfu7ZLPR/ArVKU/ajM4cTEj3T7X1dPk8uOwVk7xyjJh+2e0T
 3nMioQKe1Qtjf3vGbq/d/CHeXFPw9JYakVqIVoHKHUdEigD+4Ap8nyiZU g==;
X-CSE-ConnectionGUID: s8ZUeu9VTqGeqm8v4NH4zQ==
X-CSE-MsgGUID: dI3CTgsxSwKoUoKHb2529g==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1733922"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1733922"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 14:52:29 -0700
X-CSE-ConnectionGUID: IrFjs8eMRqqZuqdUa7zqYA==
X-CSE-MsgGUID: S3Be9aqpQ8WImZXavXzExQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4604453"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa003.jf.intel.com with ESMTP; 27 Oct 2026 14:52:28 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xLp5l-00000000Xnw-3ze5;
 Tue, 27 Oct 2026 21:52:25 +0000
Date: Wed, 28 Oct 2026 05:51:50 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 14121531f5181a6648de9ac583f08e0d7f3783fd
Message-ID: <202610280546.3PZ52OHR-lkp@intel.com>
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 14121531f5181a6648de9ac583f08e0d7f3783fd  ice: use struct timecounter for E825 and E830

elapsed time: 4870m

configs tested: 316
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               alldefconfig    clang-17
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.2.0
arc                           axs101_defconfig    gcc-16.2.0
arc                       axs103_smp_defconfig    clang-17
arc                                  defconfig    gcc-16.2.0
arc                             hsdk_defconfig    clang-24
arc                   randconfig-1000-20261025    clang-24
arc                   randconfig-1000-20261026    clang-24
arc                   randconfig-1001-20261025    clang-24
arc                   randconfig-1001-20261026    clang-24
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                               allyesconfig    gcc-16.2.0
arm                        aspeed_g4_defconfig    gcc-16.2.0
arm                                  defconfig    gcc-16.2.0
arm                           exynos_defconfig    gcc-16.2.0
arm                             hisi_defconfig    gcc-16.2.0
arm                        imx_v4_v5_defconfig    gcc-16.2.0
arm                             mmp2_defconfig    gcc-16.2.0
arm                        multi_v4t_defconfig    gcc-16.2.0
arm                         multi_v7_defconfig    gcc-16.2.0
arm                         mvebu_v7_defconfig    gcc-16.2.0
arm                              mxs_defconfig    clang-17
arm                          orion5x_defconfig    clang-17
arm                           pxa910_defconfig    gcc-16.2.0
arm                              pxa_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261025    clang-24
arm                   randconfig-1000-20261026    clang-24
arm                   randconfig-1001-20261025    clang-24
arm                   randconfig-1001-20261026    clang-24
arm                   randconfig-1002-20261025    clang-24
arm                   randconfig-1002-20261026    clang-24
arm                   randconfig-1003-20261025    clang-24
arm                   randconfig-1003-20261026    clang-24
arm                            tegra_defconfig    clang-24
arm                        versatile_defconfig    clang-24
arm                     vt8500_v6_v7_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261025    clang-24
arm64                 randconfig-1000-20261026    clang-24
arm64                 randconfig-1001-20261025    clang-24
arm64                 randconfig-1001-20261026    clang-24
arm64                 randconfig-1002-20261025    clang-24
arm64                 randconfig-1002-20261026    clang-24
arm64                 randconfig-1003-20261025    clang-24
arm64                 randconfig-1003-20261026    clang-24
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261025    clang-24
csky                  randconfig-1000-20261026    clang-24
csky                  randconfig-1001-20261025    clang-24
csky                  randconfig-1001-20261026    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261025    clang-24
hexagon               randconfig-1000-20261026    clang-24
hexagon               randconfig-1001-20261025    clang-24
hexagon               randconfig-1001-20261026    clang-24
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261025    gcc-14
i386        buildonly-randconfig-1000-20261026    clang-22
i386        buildonly-randconfig-1001-20261025    gcc-14
i386        buildonly-randconfig-1001-20261026    clang-22
i386        buildonly-randconfig-1002-20261025    gcc-14
i386        buildonly-randconfig-1002-20261026    clang-22
i386        buildonly-randconfig-1003-20261025    gcc-14
i386        buildonly-randconfig-1003-20261026    clang-22
i386        buildonly-randconfig-1004-20261025    gcc-14
i386        buildonly-randconfig-1004-20261026    clang-22
i386        buildonly-randconfig-1005-20261025    gcc-14
i386        buildonly-randconfig-1005-20261026    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261025    clang-22
i386                  randconfig-1000-20261026    gcc-14
i386                  randconfig-1001-20261025    clang-22
i386                  randconfig-1001-20261026    gcc-14
i386                  randconfig-1002-20261025    clang-22
i386                  randconfig-1002-20261026    gcc-14
i386                  randconfig-1003-20261025    clang-22
i386                  randconfig-1003-20261026    gcc-14
i386                  randconfig-1004-20261025    clang-22
i386                  randconfig-1004-20261026    gcc-14
i386                  randconfig-1005-20261025    clang-22
i386                  randconfig-1005-20261026    gcc-14
i386                  randconfig-1006-20261025    clang-22
i386                  randconfig-1006-20261026    gcc-14
i386                  randconfig-1007-20261025    gcc-14
i386                  randconfig-1007-20261026    clang-22
i386                  randconfig-1008-20261025    gcc-14
i386                  randconfig-1008-20261026    clang-22
i386                  randconfig-1009-20261025    gcc-14
i386                  randconfig-1009-20261026    clang-22
i386                  randconfig-1010-20261025    gcc-14
i386                  randconfig-1010-20261026    clang-22
i386                  randconfig-1011-20261025    gcc-14
i386                  randconfig-1011-20261026    clang-22
i386                  randconfig-1012-20261025    gcc-14
i386                  randconfig-1012-20261026    clang-22
i386                  randconfig-1013-20261025    gcc-14
i386                  randconfig-1013-20261026    clang-22
loongarch                         alldefconfig    gcc-16.2.0
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261025    clang-24
loongarch             randconfig-1000-20261026    clang-24
loongarch             randconfig-1001-20261025    clang-24
loongarch             randconfig-1001-20261026    clang-24
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                          apollo_defconfig    clang-17
m68k                                 defconfig    clang-24
m68k                        m5275evb_defconfig    clang-17
m68k                        m5275evb_defconfig    gcc-16.2.0
m68k                        m5329evb_defconfig    clang-17
m68k                         mvme147_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                         bcm47xx_defconfig    clang-17
mips                            ci20_defconfig    clang-17
mips                      decstation_defconfig    gcc-16.2.0
mips                  decstation_r4k_defconfig    gcc-16.2.0
mips                 econet_en751221_defconfig    gcc-16.2.0
mips                            gcw0_defconfig    clang-17
mips                            gcw0_defconfig    clang-24
mips                       maltaaprp_defconfig    clang-17
mips                            xway_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261025    clang-24
nios2                 randconfig-1000-20261026    clang-24
nios2                 randconfig-1001-20261025    clang-24
nios2                 randconfig-1001-20261026    clang-24
openrisc                          alldefconfig    gcc-16.2.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc                     or1ksim_defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261025    clang-24
parisc                randconfig-1000-20261026    gcc-14.4.0
parisc                randconfig-1001-20261025    clang-24
parisc                randconfig-1001-20261026    gcc-14.4.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      mpc5200_defconfig    clang-17
powerpc                  mpc836x_rdk_defconfig    clang-17
powerpc                      mpc83xx_defconfig    gcc-16.2.0
powerpc                     mvme5100_defconfig    gcc-16.2.0
powerpc                      powernv_defconfig    gcc-16.2.0
powerpc                       ppc44x_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261025    clang-24
powerpc               randconfig-1000-20261026    gcc-14.4.0
powerpc               randconfig-1001-20261025    clang-24
powerpc               randconfig-1001-20261026    gcc-14.4.0
powerpc                     sam440ep_defconfig    clang-17
powerpc                      tqm8548_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261025    clang-24
powerpc64             randconfig-1000-20261026    gcc-14.4.0
powerpc64             randconfig-1001-20261025    clang-24
powerpc64             randconfig-1001-20261026    gcc-14.4.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                     nommu_virt_defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261025    gcc-10.5.0
riscv                 randconfig-1000-20261026    gcc-13.5.0
riscv                 randconfig-1001-20261025    gcc-10.5.0
riscv                 randconfig-1001-20261026    gcc-13.5.0
s390                              alldefconfig    gcc-16.2.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261025    gcc-10.5.0
s390                  randconfig-1000-20261026    gcc-13.5.0
s390                  randconfig-1001-20261025    gcc-10.5.0
s390                  randconfig-1001-20261026    gcc-13.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          ap325rxa_defconfig    clang-24
sh                          apsh4a3a_defconfig    clang-24
sh                                   defconfig    gcc-14
sh                         edosk7705_defconfig    gcc-16.2.0
sh                                j2_defconfig    gcc-16.2.0
sh                           r7780mp_defconfig    clang-17
sh                    randconfig-1000-20261025    gcc-10.5.0
sh                    randconfig-1000-20261026    gcc-13.5.0
sh                    randconfig-1001-20261025    gcc-10.5.0
sh                    randconfig-1001-20261026    gcc-13.5.0
sh                            se7343_defconfig    clang-24
sh                            se7722_defconfig    gcc-16.2.0
sh                             shmin_defconfig    gcc-16.2.0
sh                               ul2_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261025    gcc-14
sparc                 randconfig-1000-20261026    gcc-14
sparc                 randconfig-1001-20261025    gcc-14
sparc                 randconfig-1001-20261026    gcc-14
sparc                        sparc32_defconfig    gcc-16.2.0
sparc                        sparc64_defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261025    gcc-14
sparc64               randconfig-1000-20261026    gcc-14
sparc64               randconfig-1001-20261025    gcc-14
sparc64               randconfig-1001-20261026    gcc-14
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261025    gcc-14
um                    randconfig-1000-20261026    gcc-14
um                    randconfig-1001-20261025    gcc-14
um                    randconfig-1001-20261026    gcc-14
um                            x86_64_defconfig    gcc-14
x86_64                            alldefconfig    clang-24
x86_64                            alldefconfig    gcc-16.2.0
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261025    gcc-14
x86_64      buildonly-randconfig-1000-20261026    clang-22
x86_64      buildonly-randconfig-1001-20261025    gcc-14
x86_64      buildonly-randconfig-1001-20261026    clang-22
x86_64      buildonly-randconfig-1002-20261025    gcc-14
x86_64      buildonly-randconfig-1002-20261026    clang-22
x86_64      buildonly-randconfig-1003-20261025    gcc-14
x86_64      buildonly-randconfig-1003-20261026    clang-22
x86_64      buildonly-randconfig-1004-20261025    gcc-14
x86_64      buildonly-randconfig-1004-20261026    clang-22
x86_64      buildonly-randconfig-1005-20261025    gcc-14
x86_64      buildonly-randconfig-1005-20261026    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261025    clang-22
x86_64                randconfig-1000-20261026    clang-22
x86_64                randconfig-1001-20261025    clang-22
x86_64                randconfig-1001-20261026    clang-22
x86_64                randconfig-1002-20261025    clang-22
x86_64                randconfig-1002-20261026    clang-22
x86_64                randconfig-1003-20261025    clang-22
x86_64                randconfig-1003-20261026    clang-22
x86_64                randconfig-1004-20261025    clang-22
x86_64                randconfig-1004-20261026    clang-22
x86_64                randconfig-1005-20261025    clang-22
x86_64                randconfig-1005-20261026    clang-22
x86_64                randconfig-1006-20261025    clang-22
x86_64                randconfig-1006-20261026    gcc-14
x86_64                randconfig-1007-20261025    clang-22
x86_64                randconfig-1007-20261026    gcc-14
x86_64                randconfig-1008-20261025    clang-22
x86_64                randconfig-1008-20261026    gcc-14
x86_64                randconfig-1009-20261025    clang-22
x86_64                randconfig-1009-20261026    gcc-14
x86_64                randconfig-1010-20261025    clang-22
x86_64                randconfig-1010-20261026    gcc-14
x86_64                randconfig-1011-20261025    clang-22
x86_64                randconfig-1011-20261026    gcc-14
x86_64                randconfig-1012-20261025    clang-22
x86_64                randconfig-1012-20261026    gcc-14
x86_64                randconfig-1013-20261025    clang-22
x86_64                randconfig-1013-20261026    gcc-14
x86_64                randconfig-1014-20261025    clang-22
x86_64                randconfig-1014-20261026    gcc-14
x86_64                randconfig-1015-20261025    clang-22
x86_64                randconfig-1015-20261026    gcc-14
x86_64                randconfig-1016-20261025    clang-22
x86_64                randconfig-1016-20261026    gcc-14
x86_64                randconfig-1017-20261025    clang-22
x86_64                randconfig-1017-20261026    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   audio_kc705_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261025    gcc-14
xtensa                randconfig-1000-20261026    gcc-14
xtensa                randconfig-1001-20261025    gcc-14
xtensa                randconfig-1001-20261026    gcc-14
xtensa                          virt_defconfig    gcc-16.2.0
xtensa                     xip_kc705_defconfig    clang-17
xtensa                     xip_kc705_defconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
