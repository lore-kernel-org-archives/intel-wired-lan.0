Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71A4C98328
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 04:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50455605EB;
	Mon, 28 Sep 2026 04:27:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NgAoxMza-JW7; Mon, 28 Sep 2026 04:27:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2A50D605FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790569654;
	b=pVLnfQe3mqBeccheVIB0BmpZIj2UneJksGFLGjYoZ8QgHSTQvNVU6Trxy6r9VVWsJ7Hn
	 ImG8z8YSOo3IJFHu14A0dJ3xDxW9E5Ds1dV9C9oZAK9vdwBOYMnPwWxi75rr168G7AReo
	 5BnBAGHp8Nq+uqNWX1VFBSC3pN87CkXc2JVRTX/ye0QcSaE8SLPdx14Uaw7zSdd+A+AAb
	 rQXXuYb2dj2QP8YFSt/UxGkMDd4T6HzMcfoJ8IexBAYU9oWB0l5VCEh+LWje3Wr+7t/g+
	 mGAZ00WtRUM6szEeL3lPPLg8Bi1VhNfpqZFUXGYYSnC0/TfQao8W6mvijPoC6EchTIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790569654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=t5D6qlhwFVZ+fUYRzfyss7XY+k/GcP502ILSHc1A08o=;
	b=R/c1Y4yasmTKi+KWzzOHS9Qx1EES37jDRLbn/K+ddRJFh6fXqbJU+beHJQdU8LgmZwkM
	 W0KaVqvRBKjDBbqTQQ7eb/RqVWNKbr7oBbPkeMuoRHajfangLad2nQ1ofLvIAKlfy4ryb
	 +lKQuVkXQq1/+cEZgVGf1N0LwpJJZcKCA1JKGQeJRdzyLjhzqFkoK5SMH04FHdl8njqYk
	 UQKCHmc1JA6+TjBvDxGVSWPrN2G4ZxE3MJB+pvpF2S0PMctJ/VE5vNCFufWNu+9Y2wtGb
	 3DSO+NiYjFtgsjP0pwD0tPL9Qw9DGV3GN17AJqITIFCbtgMdpkESoc7pQIUxediMGlA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790569654;
	bh=t5D6qlhwFVZ+fUYRzfyss7XY+k/GcP502ILSHc1A08o=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lES2IYod6+wP8SoH/t7o7Q8e9pJ4HiFXwuTmEjV3nYLa5pXLhR5ah74zlyqbuSW0s
	 SB0JLP2Tlh8kiaw5lX62MFQgHbSpTR7iA0pGA0PJdo7sh9PFy9hX7xa6y8sXBQMtRS
	 D25iB4Q3ZQgyatRDP3f54aRP8D16oVlfudiTsLWDvBHtaaBD2hGb+g/RYjqNdEn0P7
	 AB3N2gyGro46e5MHI6GdTp2mavewJ96g7KOFLzOtcyJIQmvpINx02Mp58yHSZ/DBYY
	 DaNgbOeoT5Zyi/TVJqYBva9rGN7vYDYEOAD/ZmrIP5VDU6ywiS9F7wBxNdWA+AOC8v
	 RL31SQQ6H06OA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A50D605FC;
	Mon, 28 Sep 2026 04:27:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 06B1422B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 04:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD0C040057
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 04:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cagsRcoizVRq for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 04:27:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 50FFC40050
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790569651;
 b=HdejQ6sn1Rf08zpqbEwbpYTwi0MM0VhtofjfxYdt/FQN0sssXcAV3b1u/JE8vSOxNEFn
 YVx8ch0x4A8K9MgyuBWCQmRUSAce+a86dNlIpbHSFNV2lTz96VB9lab5/KenqmGNBmHuH
 GbB0n9sOpaippsPYJY3pMjoYfHkkucR0P7Towgt01ydrJ6lUjFIQVXnsf/uYMvSatJm4h
 3ormZqotpxd54+hn/JGuO6QUSC3ZHwn68andBzk5gSubHbAAsuAzB798lJexRUkLZrYSF
 ej6DbvRFTKyRdeOaW0+StsWtc18CqlPnEsPruCpTNgcNOTjQYnX5kAxbGFvKpQfxFXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790569651;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=t5D6qlhwFVZ+fUYRzfyss7XY+k/GcP502ILSHc1A08o=;
 b=idOCVXzxaKBebNwA62mkl+fUTaPlduunIx7F7WprzH3b4lc0OpCHewzBs7sd3y1yXkUr
 xXtilOlkpmeqLN4rA9boxNI2qiI7xWau8d/LiYG3R7bLMjOBfH7lptz6Rr78n+N7yYSDf
 +aww4M/0UoW+4gcCpELabQuEwd4IidgQNb/ZRHYMp+y0H4Ick99Mel8sO1Td7dBk/hLzm
 NsOO4mn1uS9pxrvqXRJ6aoqChnClcjfJEhNPk7u4erqS8rcapO4dMaXprQTlm/VGxkzKf
 f8EIwkyCjBlHO0/tn026GSPR917EK7fQU+G5qrAGlViLkkE4IDxFJNSXbZO+FlNmwiA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ChAM6aNn; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ChAM6aNn
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50FFC40050
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 04:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790569652; x=1822105652; h=date:from:to:subject:message-id;
 bh=pSQ5yRXWX0CuKc7T0cxYfW2pEF7vY96wWjJmabR9i5g=;
 b=ChAM6aNnJVb7brs1Ow5c6AAFUYhIlGxTul+vy8CNK15krCzUi4tJXrrc
 bWspIAgoT+y3WIXUiVP0Jrm3GWW7DZZRXRWOgAAxp+2SZqIwluxkM50tL
 glZ32sEiMDS0p3B7uCmTOy+RkTtlCUN+e2YMOO02tVZS1vOu5E/wwltvK
 AZYFl6IJD9hbHoLNWgybBGHtFgzcaEMZpvoMamLHm7XPuHzZRO/0+vqRQ
 bI25AWIFdjMqPR+pNsxaG/oCJYDb+bsOvHja5VVwL9lXb6MPYkxAcZLn9
 ZdmrlIBduMxWsEJ2mUHQoJEFYBiG5ygtddAxlkehaMLXmVg8/HVjRYZUs A==;
X-CSE-ConnectionGUID: opLJzfDXQJKndmxn5njFCQ==
X-CSE-MsgGUID: jx4k+Ot3SpKYTjPcINbvqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="94140217"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; d="scan'208";a="94140217"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2026 21:27:31 -0700
X-CSE-ConnectionGUID: pBX2NUX9StilVCWZWK4qcA==
X-CSE-MsgGUID: Yi7xAqB9RwuhqwPCGYZPHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; d="scan'208";a="312858748"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 27 Sep 2026 21:27:30 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xB2xW-00000000NVL-40Wo;
 Mon, 28 Sep 2026 04:27:22 +0000
Date: Mon, 28 Sep 2026 12:26:48 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 7a8db85f7ed9a2d5a2d583cfcfc02f9dd43a2125
Message-ID: <202609281245.9n4Etcel-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 7a8db85f7ed9a2d5a2d583cfcfc02f9dd43a2125  ice: skip the SW pin description on boards with generic DPLL pins

elapsed time: 2688m

configs tested: 288
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                           axs103_defconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                         nsim_700_defconfig    clang-24
arc                   randconfig-1000-20260926    clang-24
arc                   randconfig-1000-20260928    clang-24
arc                   randconfig-1001-20260926    clang-24
arc                   randconfig-1001-20260928    clang-24
arc                            tb10x_defconfig    clang-24
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          axm55xx_defconfig    gcc-16.1.0
arm                           collie_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                        imx_v6_v7_defconfig    clang-24
arm                       jornada720_defconfig    clang-24
arm                         keystone_defconfig    gcc-16.1.0
arm                           moxart_defconfig    gcc-16.1.0
arm                         multi_v5_defconfig    clang-24
arm                   randconfig-1000-20260926    clang-24
arm                   randconfig-1000-20260928    clang-24
arm                   randconfig-1001-20260926    clang-24
arm                   randconfig-1001-20260928    clang-24
arm                   randconfig-1002-20260926    clang-24
arm                   randconfig-1002-20260928    clang-24
arm                   randconfig-1003-20260926    clang-24
arm                   randconfig-1003-20260928    clang-24
arm                           sp7021_defconfig    clang-24
arm                        spear13xx_defconfig    gcc-16.1.0
arm                            tegra_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260926    gcc-8.5.0
arm64                 randconfig-1000-20260928    gcc-15.2.0
arm64                 randconfig-1001-20260926    gcc-8.5.0
arm64                 randconfig-1001-20260928    gcc-15.2.0
arm64                 randconfig-1002-20260926    gcc-8.5.0
arm64                 randconfig-1002-20260928    gcc-15.2.0
arm64                 randconfig-1003-20260926    gcc-8.5.0
arm64                 randconfig-1003-20260928    gcc-15.2.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260926    gcc-8.5.0
csky                  randconfig-1000-20260928    gcc-15.2.0
csky                  randconfig-1001-20260926    gcc-8.5.0
csky                  randconfig-1001-20260928    gcc-15.2.0
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260926    gcc-10.5.0
hexagon               randconfig-1000-20260928    gcc-8.5.0
hexagon               randconfig-1001-20260926    gcc-10.5.0
hexagon               randconfig-1001-20260928    gcc-8.5.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260926    gcc-14
i386        buildonly-randconfig-1000-20260928    clang-22
i386        buildonly-randconfig-1001-20260926    gcc-14
i386        buildonly-randconfig-1001-20260928    clang-22
i386        buildonly-randconfig-1002-20260926    gcc-14
i386        buildonly-randconfig-1002-20260928    clang-22
i386        buildonly-randconfig-1003-20260926    gcc-14
i386        buildonly-randconfig-1003-20260928    clang-22
i386        buildonly-randconfig-1004-20260926    gcc-14
i386        buildonly-randconfig-1004-20260928    clang-22
i386        buildonly-randconfig-1005-20260926    gcc-14
i386        buildonly-randconfig-1005-20260928    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260927    clang-22
i386                  randconfig-1000-20260928    gcc-14
i386                  randconfig-1001-20260927    clang-22
i386                  randconfig-1001-20260928    gcc-14
i386                  randconfig-1002-20260927    clang-22
i386                  randconfig-1002-20260928    gcc-14
i386                  randconfig-1003-20260927    clang-22
i386                  randconfig-1003-20260928    gcc-14
i386                  randconfig-1004-20260927    clang-22
i386                  randconfig-1004-20260928    gcc-14
i386                  randconfig-1005-20260927    clang-22
i386                  randconfig-1005-20260928    gcc-14
i386                  randconfig-1006-20260927    clang-22
i386                  randconfig-1006-20260928    gcc-14
i386                  randconfig-1007-20260926    gcc-14
i386                  randconfig-1007-20260928    clang-22
i386                  randconfig-1008-20260926    gcc-14
i386                  randconfig-1008-20260928    clang-22
i386                  randconfig-1009-20260926    gcc-14
i386                  randconfig-1009-20260928    clang-22
i386                  randconfig-1010-20260926    gcc-14
i386                  randconfig-1010-20260928    clang-22
i386                  randconfig-1011-20260926    gcc-14
i386                  randconfig-1011-20260928    clang-22
i386                  randconfig-1012-20260926    gcc-14
i386                  randconfig-1012-20260928    clang-22
i386                  randconfig-1013-20260926    gcc-14
i386                  randconfig-1013-20260928    clang-22
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260926    gcc-10.5.0
loongarch             randconfig-1000-20260928    gcc-8.5.0
loongarch             randconfig-1001-20260926    gcc-10.5.0
loongarch             randconfig-1001-20260928    gcc-8.5.0
m68k                              alldefconfig    gcc-16.1.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5208evb_defconfig    clang-24
m68k                         m5407c3_defconfig    clang-24
m68k                       m54418evb_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                          cobalt_defconfig    gcc-16.1.0
mips                           eyeq6_defconfig    clang-24
mips                            ip22_defconfig    clang-24
mips                 malta_qemu_32r6_defconfig    clang-24
mips                 malta_qemu_32r6_defconfig    gcc-16.1.0
mips                           rb532_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260926    gcc-10.5.0
nios2                 randconfig-1000-20260928    gcc-8.5.0
nios2                 randconfig-1001-20260926    gcc-10.5.0
nios2                 randconfig-1001-20260928    gcc-8.5.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260926    clang-24
parisc                randconfig-1000-20260928    clang-24
parisc                randconfig-1001-20260926    clang-24
parisc                randconfig-1001-20260928    clang-24
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                     ge_imp3a_defconfig    gcc-16.1.0
powerpc                   iss476-smp_defconfig    clang-24
powerpc                    lite5200b_defconfig    clang-24
powerpc                      mpc5200_defconfig    clang-24
powerpc                      powernv_defconfig    clang-24
powerpc                          ps3_defconfig    clang-24
powerpc               randconfig-1000-20260926    clang-24
powerpc               randconfig-1000-20260928    clang-24
powerpc               randconfig-1001-20260926    clang-24
powerpc               randconfig-1001-20260928    clang-24
powerpc                      taishan_defconfig    clang-24
powerpc64             randconfig-1000-20260926    clang-24
powerpc64             randconfig-1000-20260928    clang-24
powerpc64             randconfig-1001-20260926    clang-24
powerpc64             randconfig-1001-20260928    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260927    gcc-16.1.0
riscv                 randconfig-1000-20260928    clang-24
riscv                 randconfig-1001-20260927    gcc-16.1.0
riscv                 randconfig-1001-20260928    clang-24
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                           debug_defconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260927    gcc-16.1.0
s390                  randconfig-1000-20260928    clang-24
s390                  randconfig-1001-20260927    gcc-16.1.0
s390                  randconfig-1001-20260928    clang-24
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-24
sh                             migor_defconfig    clang-24
sh                    randconfig-1000-20260927    gcc-16.1.0
sh                    randconfig-1000-20260928    clang-24
sh                    randconfig-1001-20260927    gcc-16.1.0
sh                    randconfig-1001-20260928    clang-24
sh                           sdk7780_defconfig    gcc-16.1.0
sh                            se7722_defconfig    clang-24
sh                              sh03_defconfig    gcc-16.1.0
sh                    sh7770_generic_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260926    gcc-14
sparc                 randconfig-1000-20260928    clang-17
sparc                 randconfig-1001-20260926    gcc-14
sparc                 randconfig-1001-20260928    clang-17
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260926    gcc-14
sparc64               randconfig-1000-20260928    clang-17
sparc64               randconfig-1001-20260926    gcc-14
sparc64               randconfig-1001-20260928    clang-17
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260926    gcc-14
um                    randconfig-1000-20260928    clang-17
um                    randconfig-1001-20260926    gcc-14
um                    randconfig-1001-20260928    clang-17
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260927    gcc-14
x86_64      buildonly-randconfig-1000-20260928    gcc-14
x86_64      buildonly-randconfig-1001-20260927    gcc-14
x86_64      buildonly-randconfig-1001-20260928    gcc-14
x86_64      buildonly-randconfig-1002-20260927    gcc-14
x86_64      buildonly-randconfig-1002-20260928    gcc-14
x86_64      buildonly-randconfig-1003-20260927    gcc-14
x86_64      buildonly-randconfig-1003-20260928    gcc-14
x86_64      buildonly-randconfig-1004-20260927    gcc-14
x86_64      buildonly-randconfig-1004-20260928    gcc-14
x86_64      buildonly-randconfig-1005-20260927    gcc-14
x86_64      buildonly-randconfig-1005-20260928    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260926    gcc-14
x86_64                randconfig-1000-20260928    gcc-14
x86_64                randconfig-1001-20260926    gcc-14
x86_64                randconfig-1001-20260928    gcc-14
x86_64                randconfig-1002-20260926    gcc-14
x86_64                randconfig-1002-20260928    gcc-14
x86_64                randconfig-1003-20260926    gcc-14
x86_64                randconfig-1003-20260928    gcc-14
x86_64                randconfig-1004-20260926    gcc-14
x86_64                randconfig-1004-20260928    gcc-14
x86_64                randconfig-1005-20260926    gcc-14
x86_64                randconfig-1005-20260928    gcc-14
x86_64                randconfig-1006-20260926    gcc-14
x86_64                randconfig-1006-20260928    gcc-14
x86_64                randconfig-1007-20260926    gcc-14
x86_64                randconfig-1007-20260928    gcc-14
x86_64                randconfig-1008-20260926    gcc-14
x86_64                randconfig-1008-20260928    gcc-14
x86_64                randconfig-1009-20260926    gcc-14
x86_64                randconfig-1009-20260928    gcc-14
x86_64                randconfig-1010-20260926    gcc-14
x86_64                randconfig-1010-20260928    gcc-14
x86_64                randconfig-1011-20260926    gcc-14
x86_64                randconfig-1011-20260928    gcc-14
x86_64                randconfig-1012-20260927    clang-22
x86_64                randconfig-1012-20260928    clang-22
x86_64                randconfig-1013-20260927    clang-22
x86_64                randconfig-1013-20260928    clang-22
x86_64                randconfig-1014-20260927    clang-22
x86_64                randconfig-1014-20260928    clang-22
x86_64                randconfig-1015-20260927    clang-22
x86_64                randconfig-1015-20260928    clang-22
x86_64                randconfig-1016-20260927    clang-22
x86_64                randconfig-1016-20260928    clang-22
x86_64                randconfig-1017-20260927    clang-22
x86_64                randconfig-1017-20260928    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20260926    gcc-14
xtensa                randconfig-1000-20260928    clang-17
xtensa                randconfig-1001-20260926    gcc-14
xtensa                randconfig-1001-20260928    clang-17

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
