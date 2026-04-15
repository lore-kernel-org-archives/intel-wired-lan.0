Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FAEF43830
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Apr 2026 14:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F58C82864;
	Wed, 15 Apr 2026 14:56:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j_UrFimgVSAI; Wed, 15 Apr 2026 14:56:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C244585487
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776264979;
	bh=T4+ZGHp25MgPavNP69iiMWiNgbZh1yVvIet89LNSOtw=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mEt61rDBH09rx6h4O9y2En7PmGtaobgqfGo9pPZLmF6vnq6RVhtnX6J1zKKpnoceI
	 /xFF+9o/1CoRFsX9N+n3cF1V51rJH9YFbJmDBDbkTLclhFeLjh24N51zieJhGYegMd
	 wy8wRSGry7vKHfftp0fKOTertnrzh2v/WyZ8ac7+2ap4qkUoq9hXL2xp9U0NM7Pg9u
	 OojaXEUhAephnd2mxhgBRyf2RfUu68/eG+XKgS8L3hVh9VqzpiakcuprSey2P5dtlN
	 TloaK55s88+Gurwvte0UxZ3X+dhfjv5DHnNhsq62YVH0Fnb8R/7RPcExXaGJY2r8+r
	 XMLhA874qrN1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C244585487;
	Wed, 15 Apr 2026 14:56:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A8B63375
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 976AA6F74D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:56:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9AED27kG4QjS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Apr 2026 14:56:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6D4C36F726
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D4C36F726
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D4C36F726
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:56:16 +0000 (UTC)
X-CSE-ConnectionGUID: AvsZVeQERGaREUHfF38H9g==
X-CSE-MsgGUID: cRPNljV6T2a35npkdh2sxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="76946818"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="76946818"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 07:56:16 -0700
X-CSE-ConnectionGUID: mAAVgDZ4SQO9YJhclkJLnw==
X-CSE-MsgGUID: FEs5pxSORq6zZvOZ1viM0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="232183499"
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
 by fmviesa004.fm.intel.com with ESMTP; 15 Apr 2026 07:56:13 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wD1f1-000000000bT-2Taz;
 Wed, 15 Apr 2026 14:56:11 +0000
Date: Wed, 15 Apr 2026 22:55:35 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202604152227.xj5AeoT5-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776264977; x=1807800977;
 h=date:from:to:subject:message-id;
 bh=zYKsUQQVstQLZwnVlKBkMxBsleaJuV3dHqZnRCDaiQE=;
 b=CHRtc5Qij1O6C3hzAbPP5HviJRFLueXg7QaSBmCqJFvcm8wuOcDIr23H
 cQMTl/hHTlc2Y3mfYBDgYvHymvHcOrPeqAsMQ0MMB+YMilwTGd+XFgyWM
 scIERfQGQpi8MWitp/F7Mi1VBonavYXT3M3TPMf94wSYcinAFs3k01sSO
 qe7lWv/wjxVsD6QlQ48w871NAx5/+3+seWlFcIQR2EV5todf3dNMgzE7J
 zKvS3ohpymNxsJYolo9ct1mqO2qzIe5tkQn18LZbfACPvEl5qXrAdCgsi
 ZUEPrRnm9iFgvMO4VKop2C07IoS/THT2lqLZQTdpqxez1csQ1m+lTke/u
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CHRtc5Qi
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 2e2a8b50b3c35d1597bcaccf94eb7b0ffefdac36
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
branch HEAD: 2e2a8b50b3c35d1597bcaccf94eb7b0ffefdac36  ice: add support for transmitting unreadable frags

elapsed time: 955m

configs tested: 123
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260415    gcc-13.4.0
arc                   randconfig-002-20260415    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm                            hisi_defconfig    gcc-15.2.0
arm                   randconfig-001-20260415    clang-23
arm                   randconfig-002-20260415    clang-23
arm                   randconfig-003-20260415    gcc-8.5.0
arm                   randconfig-004-20260415    clang-17
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon               randconfig-001-20260415    clang-18
hexagon               randconfig-002-20260415    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260415    clang-18
loongarch             randconfig-002-20260415    clang-18
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
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260415    clang-18
nios2                 randconfig-002-20260415    clang-18
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260415    gcc-9.5.0
parisc                randconfig-002-20260415    gcc-9.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                     akebono_defconfig    clang-23
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260415    gcc-9.5.0
powerpc               randconfig-002-20260415    gcc-9.5.0
powerpc64             randconfig-001-20260415    gcc-9.5.0
powerpc64             randconfig-002-20260415    gcc-9.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260415    clang-23
riscv                 randconfig-002-20260415    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260415    clang-23
s390                  randconfig-002-20260415    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260415    clang-23
sh                    randconfig-002-20260415    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260415    clang-20
x86_64      buildonly-randconfig-002-20260415    clang-20
x86_64      buildonly-randconfig-003-20260415    clang-20
x86_64      buildonly-randconfig-004-20260415    clang-20
x86_64      buildonly-randconfig-005-20260415    clang-20
x86_64      buildonly-randconfig-006-20260415    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
