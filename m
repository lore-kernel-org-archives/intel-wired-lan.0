Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F2D606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 22:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ARkApDkG;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PACNIAAX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACA8780BD6;
	Wed, 28 Oct 2026 22:13:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lvq3TeHf-HES; Wed, 28 Oct 2026 22:13:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A029C80BDB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793225596;
	b=qX7krgwgLEqpOkDnNYuvGZ4ss87Z3sqyP18NvyazYFL/LJrPnKBmSYNWLhreqdGPPiH0
	 J0VOgGcdOALLFTQSuHYubigztnbMFIINr52uk/M+RQlMjYDRFUudGZLH3dyNABcj5Lm4f
	 WhagGLEe/vCJAhxiMgKa+p3FWFZfa3eMHHAFUPcFV+YM09kLtX33a6ienUUyg6SWlcMkK
	 yWawORzHTSdUbSS/a/FAPQFIWiYjzTTgThAJNhpNEayzCqShLBAQ0gssRDJitM6yu5Q5L
	 cz1LRTxH1hFY3c0ib1LrAG5aHkzI9un7zAyu2YIOlIo/PtHanwO3ElyB7ENKFhDL6yw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793225596;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=R19oSnpra6nqJdc6+eAw+eY69+on8REaBIo8p8TrPws=;
	b=Ev0tZTI6fHGtwxaPJbOQ+NexfTVPu9LQgjDdXwLPEHYAc7ly0fbZbPNh05qKWBdzm2ND
	 MvSLxzad673U/B1r4gFIRnU4t1d4OoGA7aPGnVELto5GcEb1z+5f/E30tGbMhFI9EjGh0
	 ybR435dwbCda9f3wE7iT408mZBhDxdfpkUx9FnzaTIuoEzjw8zKS9H0Yyg0684zCjn2Ly
	 uCMz0rE2ts6dPESvfBerUpLYR7BGSDNvqO6PjbRoBglzahTkaDS3JfUCABFquGGhgF0Xf
	 GFH/dYR80PRBQ2oq8I9siEUvg5yp700RlRdjwIZEdqjJ1Zmn8jrWiRnEyCYNfQiln1w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793225596;
	bh=R19oSnpra6nqJdc6+eAw+eY69+on8REaBIo8p8TrPws=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ARkApDkGtOZyMP3GrA7gSOD7R1iPF2nE4LSDfmoEYc8wRBexz8cxTqhZ8rPzEW55i
	 xQEueHAadUdpcNgE2mED89X3KH5bTvkJge8Hua/VlFscbt14CcMiNW/99WDAvfdvPv
	 66s8OXZ/z07vOWTvH4saBmI3CNmEvvfpLRWEmhhYCAv987xpA8qiUOTauRr6TrRzS6
	 GWAdhFJW1zGNXlBsQp91xjwykDNr19RrFOYIBgbPWFHGipnL1WGC2e6QzW/03t7DDo
	 aV4H4upxAu3eO32xODTuX62sI6OXMnX1kUoEx+Yo5xH81pb2KaFzOSRAQq9FKtMNG7
	 +0+B7sLX4u0lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A029C80BDB;
	Wed, 28 Oct 2026 22:13:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 525253AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 22:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 440AD40434
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 22:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fzaBlNIN9gxQ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 22:13:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F40DA40433
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793225594;
 b=qIetw4eVBSGtdnT6MWX7Z3PTQlySsdJ+tI+38/bz7vGYVW4PyYwv6R+uFn9l3bM6b3Tw
 tNl8R2cY93W6EjwbFtIykXIQp8Zj23ph34+Hbr0ut+aARfX8ASQIBtH71t/S0Qiy0+ARc
 SwwSsFx7gZHLZ34ygNXG/zwsX5fZCfxlGqrS82F/8uaFSDHiqSATXVELc2HKTBQQ7LTur
 rfWGlwCsxcN4KMRYjy9jVQ7dHw+OpO/SI2RQnPEZJxSm2X2j+7GI1MeVc4D4geMH9rEQ4
 BIv8isUEuVFZ4ZF6WeqzyfBEWcIn/tSBeZM7QbwfkS91KmrdZ8e9oT/mA1KK8n6L6vQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793225594;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=R19oSnpra6nqJdc6+eAw+eY69+on8REaBIo8p8TrPws=;
 b=qy1q7x1nZpMyeuAodJTXJvUl/2U3cZJQ3p9mp7tGgFkBrFfyK3g/z8202DgCF3OZ03rp
 woxYmJOVK/Vfw4laQmKtv0taRI4+Z7lct43iGX2Up27DRNSUHDDp24d4rIk/6Oi2WZP4M
 uW/PaJ8NWoUemhLb6UUsE7UzoL7vlI89054jq/32EbY71u2/KjvQowaTL9EFjQkXql3He
 0anmg2XWFvIbZ+wC/HjkO/l/s/nDA+h7eXYjp8bNF6CRLrl8Zvq5tDSO2ITH8/B0qB3zR
 AKpixYqx61sXxi4WgdYKST1UaM3pmEAQIuPloAjSIFDqwSzP9vkyKjIJ/sI9yDCgotw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PACNIAAX; 
 arc=none smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PACNIAAX
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F40DA40433
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 22:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793225594; x=1824761594; h=date:from:to:subject:message-id;
 bh=1ock544vGhxSAhtBKw7EnScJMXHU87GK0YeWsoBOTrU=;
 b=PACNIAAXWkG515fT5zs6VrEr+LOsczQ8yOhmQPG/ER4JfyofnkqYYmN4
 UYJ3PSu0tJWdAlQAD9xHIBCNmN4u/1t0XJjpg3q8MFlVdBhRxmvKw8UAo
 hFQhTIJYNoufaE7XqWBRKWnAogbj0MzlkVzcjX3z//DDV0UZ6wAkYIbYX
 JjhWTnQnm9K+IwMOKCh82lLBz/um7zppbWSw7gPUJ2cYGTlu8p329iZ4C
 Ce2fzplvyGAg9Oq2Uh9BZpswq2HMkQHD7mSsPy3Fy/jnoIyHNqlPQd80U
 VaTgpSU3wkk6DcgLgK2kFYVmCd3/hShH7L0SK5kqC3SC+XNISwEOdg2/1 Q==;
X-CSE-ConnectionGUID: ZPzuTJloS4qUnTsgzxZ7nA==
X-CSE-MsgGUID: ZA7fKCrHSvSF7YqdNw3j/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1845412"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1845412"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 15:13:13 -0700
X-CSE-ConnectionGUID: 0g23oyWxQVSTH7bQlKCODQ==
X-CSE-MsgGUID: sElAoygrSZaFh0nauxFtXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5069397"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 28 Oct 2026 15:13:11 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xMBtN-00000000ZIW-0j4y;
 Wed, 28 Oct 2026 22:13:09 +0000
Date: Thu, 29 Oct 2026 06:12:34 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 8d9032484983cd030169075b4909cd5eae664e21
Message-ID: <202610290630.u7dKneet-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 8d9032484983cd030169075b4909cd5eae664e21  ice: quiesce PTP periodic work before system suspend

elapsed time: 1397m

configs tested: 231
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
arc                   randconfig-1000-20261028    gcc-8.5.0
arc                   randconfig-1001-20261028    gcc-8.5.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          axm55xx_defconfig    gcc-16.2.0
arm                                  defconfig    gcc-16.2.0
arm                       footbridge_defconfig    gcc-16.2.0
arm                        imx_v4_v5_defconfig    gcc-16.2.0
arm                            imxrt_defconfig    gcc-16.2.0
arm                        omap2plus_defconfig    gcc-14
arm                   randconfig-1000-20261028    gcc-8.5.0
arm                   randconfig-1001-20261028    gcc-8.5.0
arm                   randconfig-1002-20261028    gcc-8.5.0
arm                   randconfig-1003-20261028    gcc-8.5.0
arm                          s3c6400_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261028    clang-22
arm64                 randconfig-1000-20261029    gcc-8.5.0
arm64                 randconfig-1001-20261028    clang-22
arm64                 randconfig-1001-20261029    gcc-8.5.0
arm64                 randconfig-1002-20261028    clang-22
arm64                 randconfig-1002-20261029    gcc-8.5.0
arm64                 randconfig-1003-20261028    clang-22
arm64                 randconfig-1003-20261029    gcc-8.5.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261028    clang-22
csky                  randconfig-1000-20261029    gcc-8.5.0
csky                  randconfig-1001-20261028    clang-22
csky                  randconfig-1001-20261029    gcc-8.5.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261028    clang-17
hexagon               randconfig-1000-20261029    clang-24
hexagon               randconfig-1001-20261028    clang-17
hexagon               randconfig-1001-20261029    clang-24
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261028    clang-22
i386        buildonly-randconfig-1000-20261029    gcc-14
i386        buildonly-randconfig-1001-20261028    clang-22
i386        buildonly-randconfig-1001-20261029    gcc-14
i386        buildonly-randconfig-1002-20261028    clang-22
i386        buildonly-randconfig-1002-20261029    gcc-14
i386        buildonly-randconfig-1003-20261028    clang-22
i386        buildonly-randconfig-1003-20261029    gcc-14
i386        buildonly-randconfig-1004-20261028    clang-22
i386        buildonly-randconfig-1004-20261029    gcc-14
i386        buildonly-randconfig-1005-20261028    clang-22
i386        buildonly-randconfig-1005-20261029    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261028    gcc-14
i386                  randconfig-1001-20261028    gcc-14
i386                  randconfig-1002-20261028    gcc-14
i386                  randconfig-1003-20261028    gcc-14
i386                  randconfig-1004-20261028    gcc-14
i386                  randconfig-1005-20261028    gcc-14
i386                  randconfig-1006-20261028    gcc-14
i386                  randconfig-1007-20261028    clang-22
i386                  randconfig-1008-20261028    clang-22
i386                  randconfig-1009-20261028    clang-22
i386                  randconfig-1010-20261028    clang-22
i386                  randconfig-1011-20261028    clang-22
i386                  randconfig-1012-20261028    clang-22
i386                  randconfig-1013-20261028    clang-22
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261028    clang-17
loongarch             randconfig-1000-20261029    clang-24
loongarch             randconfig-1001-20261028    clang-17
loongarch             randconfig-1001-20261029    clang-24
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                           amiga_defconfig    clang-22
m68k                        bvme6000_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                        m5275evb_defconfig    clang-22
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                        lemote2f_defconfig    clang-22
mips                       loongson1_defconfig    gcc-14
mips                       malta_kvm_defconfig    gcc-14
mips                         maltaup_defconfig    gcc-14
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261028    clang-17
nios2                 randconfig-1000-20261029    clang-24
nios2                 randconfig-1001-20261028    clang-17
nios2                 randconfig-1001-20261029    clang-24
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc          de0_nano_multicore_defconfig    gcc-16.2.0
openrisc                             defconfig    gcc-16.2.0
parisc                            alldefconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261028    clang-19
parisc                randconfig-1001-20261028    clang-19
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       bamboo_defconfig    gcc-16.2.0
powerpc                  canyonlands_defconfig    clang-22
powerpc                      ep8248e_defconfig    clang-22
powerpc               randconfig-1000-20261028    clang-19
powerpc               randconfig-1001-20261028    clang-19
powerpc                     sam440ep_defconfig    clang-22
powerpc                      stx_gp3_defconfig    gcc-14
powerpc                      tqm8548_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261028    clang-19
powerpc64             randconfig-1001-20261028    clang-19
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261028    gcc-11.5.0
riscv                 randconfig-1001-20261028    gcc-11.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261028    gcc-11.5.0
s390                  randconfig-1001-20261028    gcc-11.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          apsh4a3a_defconfig    gcc-14
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    clang-22
sh                           polaris_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261028    gcc-11.5.0
sh                    randconfig-1001-20261028    gcc-11.5.0
sh                           rsk7201_defconfig    clang-22
sh                            se7206_defconfig    gcc-16.2.0
sh                            se7751_defconfig    gcc-16.2.0
sh                              sh03_defconfig    gcc-14
sh                         sh7785lcr_defconfig    gcc-16.2.0
sparc                             alldefconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261028    gcc-12
sparc                 randconfig-1000-20261029    clang-24
sparc                 randconfig-1001-20261028    gcc-12
sparc                 randconfig-1001-20261029    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261028    gcc-12
sparc64               randconfig-1000-20261029    clang-24
sparc64               randconfig-1001-20261028    gcc-12
sparc64               randconfig-1001-20261029    clang-24
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261028    gcc-12
um                    randconfig-1000-20261029    clang-24
um                    randconfig-1001-20261028    gcc-12
um                    randconfig-1001-20261029    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261028    clang-22
x86_64      buildonly-randconfig-1001-20261028    clang-22
x86_64      buildonly-randconfig-1002-20261028    clang-22
x86_64      buildonly-randconfig-1003-20261028    clang-22
x86_64      buildonly-randconfig-1004-20261028    clang-22
x86_64      buildonly-randconfig-1005-20261028    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261028    clang-22
x86_64                randconfig-1000-20261029    clang-22
x86_64                randconfig-1001-20261028    clang-22
x86_64                randconfig-1001-20261029    clang-22
x86_64                randconfig-1002-20261028    clang-22
x86_64                randconfig-1002-20261029    clang-22
x86_64                randconfig-1003-20261028    clang-22
x86_64                randconfig-1003-20261029    clang-22
x86_64                randconfig-1004-20261028    clang-22
x86_64                randconfig-1004-20261029    clang-22
x86_64                randconfig-1005-20261028    clang-22
x86_64                randconfig-1005-20261029    clang-22
x86_64                randconfig-1006-20261028    gcc-14
x86_64                randconfig-1007-20261028    gcc-14
x86_64                randconfig-1008-20261028    gcc-14
x86_64                randconfig-1009-20261028    gcc-14
x86_64                randconfig-1010-20261028    gcc-14
x86_64                randconfig-1011-20261028    gcc-14
x86_64                randconfig-1012-20261028    gcc-12
x86_64                randconfig-1013-20261028    gcc-12
x86_64                randconfig-1014-20261028    gcc-12
x86_64                randconfig-1015-20261028    gcc-12
x86_64                randconfig-1016-20261028    gcc-12
x86_64                randconfig-1017-20261028    gcc-12
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                        common_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261028    gcc-12
xtensa                randconfig-1000-20261029    clang-24
xtensa                randconfig-1001-20261028    gcc-12
xtensa                randconfig-1001-20261029    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
