Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159B4C9830E
	for <intel-wired-lan@archiver.kernel.org>; Sun, 27 Sep 2026 11:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B508A40757;
	Sun, 27 Sep 2026 11:54:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6uXz6SFqRIyH; Sun, 27 Sep 2026 11:54:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7C8D740763
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790510062;
	b=QcA26TnueBu3912nlbZqWEa8ssbz+QHB8O2pIVSyb1N5GWo+t8J3eMIgw1JkY68Gpnwv
	 sDj30sMV7K4JOHdnAt4oVTC7UuBUZKW3dgA31rSvqcKYFa2unpdcuQjQawHLui01Btq3e
	 s3geILa/LdUBV2yaEGlGxN8Kan3lamg5jInX+ybf4o58VKD0FtPCdjYqs/oQquIdF2znM
	 FJJ8R9v5rWzman66wS3DRvFvElStFd1PfwEQRWGL1ThZiH0Mpjnfl9ydk93/Ay54hoVcG
	 lZWxSBDMMWXDl73+ii3ZbVD4gs9DigorCxbGsNEDnhCoVqgM2Pn2tYYiOlZnc1eU+0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790510062;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mAyL3q1+3ohahedGhD/sQ7iK5mIRzH0f6ioKnpzR3mQ=;
	b=igqSNu8ABcYNKWIVRXsKAA6I7ASBbp0O6mzVJy1hAni8Bd0zR2bmlAVRZpcSQLQC0Eye
	 f9DKWoi/XiDL8BkbgzAfjNb1y+OuN2mbQCDoPs3eqNBQN7uCKfCE8HMGG3YIUve/oMYCF
	 J5S9ZPATApPov9EwZ5BsA2h+vKEZ0m4qhb0qYemChUUhgYSaTcZQET+kIq3D1A3GBBbXx
	 wXIKjTGRyJf6AgQ+I6/y6dJccMrsuQhlD6sUGPa35C5CyHVuDCwY2ruXsotIBagDhromu
	 eEz8IePthA9C2+MDyxO7M2iTXWgA/ZvVC5iBxKsLeZ2BWatsOxsBQ5OVkZP2mvy4t+Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790510062;
	bh=mAyL3q1+3ohahedGhD/sQ7iK5mIRzH0f6ioKnpzR3mQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2lbllJuiWCTcR1GB5ChwSiWTCemmm75fg01ccf6uYNjpQoM9U11fK8rBIDrdNrmLU
	 sZ0Cr9Z34f0NMqCQ/lyW3SdtRGrBd7oBGuWzqiZ4G/pYwoIKocCYN7Br9NhLv+Po0H
	 PcOu5BN7pRoqy95GbBh13OnxgM2RUCbK+LkY7fN6SUYbkS9XUBwDcTGsRB4JQPYuBt
	 E3XZ7bvkdbm7YxEJtU+tLb34nae+lnVxmSskLO9DNE6aPqPDbNtl+d0LtOgku+dZBL
	 ZPEhzFCh/To0AZfRPfRqQ8klh1x/7fsNYk5RIZy6GDY62IZdrDW4QvW/P0ycFL6dW0
	 GaHrDMXRlgFIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C8D740763;
	Sun, 27 Sep 2026 11:54:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C3FC0D1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 11:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B56E48109C
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 11:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UJEWfSO7s7wW for <intel-wired-lan@lists.osuosl.org>;
 Sun, 27 Sep 2026 11:54:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6A2E481099
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790510059;
 b=C4QB8yO3JrpIuzkAk9f9OqaacoEzzHnxan9FpSWBUU54smAayP0xzpzf2W/ZAsJcbX4B
 DYwlkClTY26X7Jce/L2eTa/pqzVuWAbTH1q76eUvcvB/De12ImVjgxX5LET3g8Nhp9tew
 Ubw7sBbzY+eyUwdetpfttNtGWNPwiVK656G4N3ThewgWHvZMZR/6DSUtkx2aZJ2DDGFue
 G9ZaNJ+Z8/2Nt4gYLRTTZSdEMUkrKfw7FcWDDTMJk7N81VpNOtvAyyBt6/o4QNLsdVvQs
 fS6G/xn5cFm7yoYtbdOefMMxXie5hzVO6sTVShTnmvEnsN0pw2xNv25/ElcrCJXN2qQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790510059;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=mAyL3q1+3ohahedGhD/sQ7iK5mIRzH0f6ioKnpzR3mQ=;
 b=KsERj1JrhnjMJSrr3KVazgmozxJCStk5QZ1SkBgJfDR819nNSC3FBkuelCR9ujWWJh9e
 Y/QJjQAkQJXiAiexCl1Ghn5BC8O2vtLqlichinzaLh7HdjC56SA66tq/GdT+Rc2pCUBCk
 PZ8tZ1YXvso+xVrbaJDMMeSiyy4ZncBYCssNTqD1UQVU0YDtUUKMDlSIS0jQ2i5toeduH
 PvXoxX4gkop/Mfketiozb6hrVJcTUG0whUmDydzY6LI8tmdNTH9P5HJtNa3wfgshhleVF
 P5J6OUAJJIOMz9qGcBn1F/m13ZljSkEudGHHi2j0qi7Gu5dRZlUGO6Xx7XIhEdzGkyw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DfVQ2q64; 
 arc=none smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DfVQ2q64
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A2E481099
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 11:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790510059; x=1822046059; h=date:from:to:subject:message-id;
 bh=EcW6JXH6IBYkhFNAgb1m3ZPn4b3WOZ4Nu+he7H6/vXY=;
 b=DfVQ2q64/SOV04ewb0cOGnAtwhpX0VWpeGFabOzyoFRjvhKtwzTTEPL2
 FuVYCFLbs3FElsBf91UuDLZ7WgLV2kvvPaPh7ohx5vebUkyxXAtZwQvmS
 kZyNnKapm3WlEAZkyBYQiGI9/GE3P0kigrQeo9s1FsR2Y0rxdOl0OkCEx
 u7P57Mdbre9waxHAQqyL26dxNJB6GfoLJs+KL6G7IaxnkHSffzSuns6ig
 SUIfzHi05fSFL9O4JwKCeenQY8IE9sqerEH+80cUlTVy3yVhpfwLNCWHW
 0pfLom6/txkQN7me+Zcv0ZCmctYuYGFlKKHhDEJ3/UpBrsnRZ573/hKD4 g==;
X-CSE-ConnectionGUID: 9sllus1sQYGy/8isgSqgsA==
X-CSE-MsgGUID: 3m3bLnjST9mgG4Q2plT7ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11917"; a="90185104"
X-IronPort-AV: E=Sophos;i="6.27,126,1787036400"; d="scan'208";a="90185104"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2026 04:54:18 -0700
X-CSE-ConnectionGUID: SVlRT6I4QU+mGLqHzrG6Og==
X-CSE-MsgGUID: lmi+gXmSTOGKO5nMv6g91A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,126,1787036400"; d="scan'208";a="274356043"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by orviesa007.jf.intel.com with ESMTP; 27 Sep 2026 04:54:17 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xAnSQ-00000000Mnz-2zAM;
 Sun, 27 Sep 2026 11:54:14 +0000
Date: Sun, 27 Sep 2026 19:53:45 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:100GbE] BUILD SUCCESS
 6ea3bd8a8d26210928b25bbb64cdd7a8f07816cd
Message-ID: <202609271932.3slByi7L-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 6ea3bd8a8d26210928b25bbb64cdd7a8f07816cd  ice: Recalibrate PHY after settime64 on E825-C

elapsed time: 1696m

configs tested: 196
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                  nsimosci_hs_smp_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260927    gcc-11.5.0
arc                   randconfig-1001-20260927    gcc-11.5.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          assabet_defconfig    gcc-16.1.0
arm                          bcm2835_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                           exynos_defconfig    clang-24
arm                            h3600_defconfig    clang-24
arm                   randconfig-1000-20260927    gcc-11.5.0
arm                   randconfig-1001-20260927    gcc-11.5.0
arm                   randconfig-1002-20260927    gcc-11.5.0
arm                   randconfig-1003-20260927    gcc-11.5.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260927    clang-17
arm64                 randconfig-1001-20260927    clang-17
arm64                 randconfig-1002-20260927    clang-17
arm64                 randconfig-1003-20260927    clang-17
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260927    clang-17
csky                  randconfig-1001-20260927    clang-17
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260927    gcc-11.5.0
hexagon               randconfig-1001-20260927    gcc-11.5.0
i386                              alldefconfig    gcc-16.1.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260927    clang-22
i386        buildonly-randconfig-1001-20260927    clang-22
i386        buildonly-randconfig-1002-20260927    clang-22
i386        buildonly-randconfig-1003-20260927    clang-22
i386        buildonly-randconfig-1004-20260927    clang-22
i386        buildonly-randconfig-1005-20260927    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260927    clang-22
i386                  randconfig-1001-20260927    clang-22
i386                  randconfig-1002-20260927    clang-22
i386                  randconfig-1003-20260927    clang-22
i386                  randconfig-1004-20260927    clang-22
i386                  randconfig-1005-20260927    clang-22
i386                  randconfig-1006-20260927    clang-22
i386                  randconfig-1007-20260927    gcc-14
i386                  randconfig-1008-20260927    gcc-14
i386                  randconfig-1009-20260927    gcc-14
i386                  randconfig-1010-20260927    gcc-14
i386                  randconfig-1011-20260927    gcc-14
i386                  randconfig-1012-20260927    gcc-14
i386                  randconfig-1013-20260927    gcc-14
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260927    gcc-11.5.0
loongarch             randconfig-1001-20260927    gcc-11.5.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    clang-24
m68k                                 defconfig    clang-24
m68k                            sun3_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                          db1xxx_defconfig    gcc-16.1.0
mips                           eyeq6_defconfig    gcc-16.1.0
mips                      eyeq6lplus_defconfig    gcc-16.1.0
mips                        lemote2f_defconfig    gcc-16.1.0
mips                 malta_qemu_32r6_defconfig    gcc-16.1.0
mips                   maltasmvp_eva_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260927    gcc-11.5.0
nios2                 randconfig-1001-20260927    gcc-11.5.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc                   or1klitex_defconfig    gcc-16.1.0
openrisc                     or1ksim_defconfig    gcc-16.1.0
openrisc                  simple_smp_defconfig    clang-24
openrisc                  simple_smp_defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260927    clang-24
parisc                randconfig-1001-20260927    clang-24
parisc64                             defconfig    clang-24
powerpc                            allnoconfig    clang-24
powerpc                      asp8347_defconfig    clang-24
powerpc                  canyonlands_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260927    clang-24
powerpc               randconfig-1001-20260927    clang-24
powerpc                      tqm8541_defconfig    gcc-16.1.0
powerpc                      tqm8560_defconfig    gcc-16.1.0
powerpc                       tqm8xx_defconfig    clang-24
powerpc                          wii_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260927    clang-24
powerpc64             randconfig-1001-20260927    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260927    gcc-16.1.0
riscv                 randconfig-1001-20260927    gcc-16.1.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                           debug_defconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260927    gcc-16.1.0
s390                  randconfig-1001-20260927    gcc-16.1.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                           polaris_defconfig    gcc-16.1.0
sh                           r7780mp_defconfig    gcc-16.1.0
sh                           r7785rp_defconfig    clang-24
sh                    randconfig-1000-20260927    gcc-16.1.0
sh                    randconfig-1001-20260927    gcc-16.1.0
sh                           rsk7203_defconfig    clang-24
sh                             titan_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260927    clang-24
sparc                 randconfig-1001-20260927    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260927    clang-24
sparc64               randconfig-1001-20260927    clang-24
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260927    clang-24
um                    randconfig-1001-20260927    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260927    gcc-14
x86_64      buildonly-randconfig-1001-20260927    gcc-14
x86_64      buildonly-randconfig-1002-20260927    gcc-14
x86_64      buildonly-randconfig-1003-20260927    gcc-14
x86_64      buildonly-randconfig-1004-20260927    gcc-14
x86_64      buildonly-randconfig-1005-20260927    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260927    clang-22
x86_64                randconfig-1001-20260927    clang-22
x86_64                randconfig-1002-20260927    clang-22
x86_64                randconfig-1003-20260927    clang-22
x86_64                randconfig-1004-20260927    clang-22
x86_64                randconfig-1005-20260927    clang-22
x86_64                randconfig-1006-20260927    clang-22
x86_64                randconfig-1007-20260927    clang-22
x86_64                randconfig-1008-20260927    clang-22
x86_64                randconfig-1009-20260927    clang-22
x86_64                randconfig-1010-20260927    clang-22
x86_64                randconfig-1011-20260927    clang-22
x86_64                randconfig-1012-20260927    clang-22
x86_64                randconfig-1013-20260927    clang-22
x86_64                randconfig-1014-20260927    clang-22
x86_64                randconfig-1015-20260927    clang-22
x86_64                randconfig-1016-20260927    clang-22
x86_64                randconfig-1017-20260927    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20260927    clang-24
xtensa                randconfig-1001-20260927    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
