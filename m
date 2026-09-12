Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF22CC88E45
	for <intel-wired-lan@archiver.kernel.org>; Sat, 12 Sep 2026 00:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80B296060C;
	Sat, 12 Sep 2026 00:58:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jE7tm0y2U7CW; Sat, 12 Sep 2026 00:58:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 58F0260621
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789174716;
	b=HTQ2Y1Eea/bsZY3eDH8UAFejmIUqa/i+ygbQ5AmyR/yL1zgV6c9rEEAiFDdaEVaWQ2sN
	 25BB6ih2Szwev+tBJocYJCNx19Ub5RkZJb3FtphBcXIjEBBQAr/64ckRN2QEcFe/V+mYF
	 9+ZMXMkRnxWtZMjh5J7pv4eayiANIBlinNX8NPl4NwVSLodbnff3rlEAFHC+2MHzTMJvD
	 jBYFJlaimNUGewdUD2uCEvL9xU8TodTEbbmi92oW+Q6cKewT4V2EW6d3E6JGPGQcF6k9z
	 DeoHYyldY6x5iioSBUFbFk+l4JNsJz73A6rrw0XTmV69y7Z1lYfRtqnlPOIZfx3zjFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789174716;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qtcy1dnrUdOBP+xJ7nxBcecSi9MlSebLkl0dTOjryec=;
	b=mgkZ+T/DUaqOC//yQ4f2FqJYXmP1WElA7xiLcsQ/U6sMPd8gF+ahISxx5hJfXDmFfr8i
	 7ARN0Vh3q6UTQ5p3XJWYf47i58IZzcUzjywJUp/aP8C9bNVGiATidwljOAe3/vP0JW5sL
	 U0SH/DMgmUfXVNttOBgAMMvTS3Or0PjMGRD7zzVaP4612W7Z3c2whPoSv6hgMV5w1Ve8y
	 Um2sBuqiS7pwkqFdRQA4nfjk/13e3DK+5E1+cmCxRZfMr3EFhlCMwZxHDIFCn9NIu6gmv
	 0yAug6Eol91Ib7w5b4gjvo71KL8YCijUCMxphXf9EigZUBg8UqEgMQknaJ3x6gGer3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789174716;
	bh=qtcy1dnrUdOBP+xJ7nxBcecSi9MlSebLkl0dTOjryec=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iAD37gPxLt9APwvK49ybv8yFFGj3JJkVyuNI5SDMbKy/NUV/w3LiVGOmQCD1DQAAD
	 ccFa1ZeKK28MlAl5KKVzi9FRqoKH5D0JBzBKGeZN+oSXctErM3TGzHN4ee3W/FeLSC
	 jK87XjzNBCOxnSaGut5KbYasvkLx5acwsxG6sKW5sGAxx3JHgXdhpUR2b169AL8IN7
	 1WRVO4GJoj6qX382wT1gJRZfn82stNyGB//xl12wIb/s3wBAOYmNDpb4EgqMeY492O
	 JMp+VdyOk5XOzVS3e+gsZu0jj58CGvKSpAYI9aYttH9qTef4n6pV7zPzoYKpqpiz69
	 98z14Ucm/nQWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58F0260621;
	Sat, 12 Sep 2026 00:58:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 993B7255
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 00:58:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87A1540762
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 00:58:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r0zUr3XWZ4kV for <intel-wired-lan@lists.osuosl.org>;
 Sat, 12 Sep 2026 00:58:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E464740750
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789174714;
 b=RSreEv1KKVKHTTUMLHNr6Gp04AxKLgPe12dq0sXpa+V07lzyl+Xz17aCbtSOSfWa58q/
 VrJsgVpPoODd7nTmQQpcNp//Zxbw+ntZJ5YEe7PvxvqFM6GRWXQH0vbZAnhVdiBVyw/wf
 tAzPEJPlEJF1da/y1MVlgIlRbNMwYotl6qNUBeMMG8VjJRc1MpO7oyKo5dzjR6L/fQpUs
 T1yfCl/dqVLDBVvPI6G0E6uBT7ntYSVGjLKQxlcq5ytbgpgwA6EvJnEDuAyAzWqVyae1K
 i91Not+QrctQQj0LN/MkrxDQrJlbAiZJxtfEDUeNLNyOSToLvicggaKut9I9v6cREvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789174714;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=qtcy1dnrUdOBP+xJ7nxBcecSi9MlSebLkl0dTOjryec=;
 b=OnaoEdlkka2hJ7/5gAfMwU+toIt56qOEYHEn6mZRQlmJqrHtDPics0Z3qjiKYZ4JLGQC
 eoLOHmrU9hzrbG2CWR/ryPNryH/f/qLJ/2XoyvwzeTg7kTnsd6/Hg1oUvqAeW0HrrjTCi
 4nThnLJbGXvd0fNYa3k1CYhvPwOMWvSiT6N3UcTf+iZZortD9GkIRgm8NwyhVsxrft73f
 9RoJUGQS/cCZcmEU6V24QC6Dqe930WPKtDBfx7xt/kOT/Ldmx0kc5H2KJ7COa52a7IEec
 SFsODf6npEd3HLijql8Rwf8z9N/xYw1tUhd03MTXx/naNUTzdVr6inub83xY69tUORA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LlAZL7Xq; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LlAZL7Xq
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E464740750
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 00:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789174714; x=1820710714; h=date:from:to:subject:message-id;
 bh=pBcrwztbdl2VZsG4xsEZJadtvP8iPki+ZVrZqLv93mM=;
 b=LlAZL7XqKmbdIRXGCbvSSfXe5NCQf0v6hmkQcPRSxKks4Dzpy4kbBZLn
 Wl4eGoCJhMX08/Aoaq1z8Hm3OpSg+8UFw04urnsURQMdaCjZ9Z4jEB66r
 +3YU8MYzPBO4FJaChw04E+FZjmqLkiulnCvQu0jis71GDEkvpqfHu8cH1
 GPejPeVemKkeWwDQHJ478pkUIA1dgXFpyblfBdgDYWpZ8sro59BWawkjo
 /8V891BHhYzrpNf0oi7t9ja0TuxdvbxrwgvZPohSf+iF3wg6L7zpF9NNn
 Fb4QpEqz3GiqkcGzeOyJD5SgaxRRPTN2DKTclHDqaBtCdQE13KOfzb2jm g==;
X-CSE-ConnectionGUID: OiQ8MwoGSyeeSxx/hCWrUQ==
X-CSE-MsgGUID: hjZGVDUPQ2i1LXmTvBblpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="115175825"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="115175825"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 17:58:31 -0700
X-CSE-ConnectionGUID: 1roMBc1CTEO2nj/P+xeNCw==
X-CSE-MsgGUID: bJii698mT5S63TlsCemg9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="272580028"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
 by orviesa009.jf.intel.com with ESMTP; 11 Sep 2026 17:58:30 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x5C4R-000000002SE-11Jr;
 Sat, 12 Sep 2026 00:58:22 +0000
Date: Sat, 12 Sep 2026 08:55:52 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:100GbE] BUILD SUCCESS
 a4899a75cc00b18eee375459f7c06b640277b15d
Message-ID: <202609120849.zM6A4aFQ-lkp@intel.com>
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
branch HEAD: a4899a75cc00b18eee375459f7c06b640277b15d  ice: Recalibrate PHY after settime64 on E825-C

elapsed time: 1505m

configs tested: 254
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-24
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                          axs103_defconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260911    clang-24
arc                   randconfig-001-20260912    clang-17
arc                   randconfig-002-20260911    clang-24
arc                   randconfig-002-20260912    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-24
arm                       aspeed_g5_defconfig    gcc-16.1.0
arm                        clps711x_defconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                          pxa3xx_defconfig    gcc-16.1.0
arm                   randconfig-001-20260911    clang-24
arm                   randconfig-001-20260912    clang-17
arm                   randconfig-002-20260911    clang-24
arm                   randconfig-002-20260912    clang-17
arm                   randconfig-003-20260911    clang-24
arm                   randconfig-003-20260912    clang-17
arm                   randconfig-004-20260911    clang-24
arm                   randconfig-004-20260912    clang-17
arm                           sama7_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260911    gcc-16.1.0
arm64                 randconfig-002-20260911    gcc-16.1.0
arm64                 randconfig-003-20260911    gcc-16.1.0
arm64                 randconfig-004-20260911    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260911    gcc-16.1.0
csky                  randconfig-002-20260911    gcc-16.1.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260911    gcc-12.5.0
hexagon               randconfig-001-20260912    clang-24
hexagon               randconfig-002-20260911    gcc-12.5.0
hexagon               randconfig-002-20260912    clang-24
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260911    clang-22
i386        buildonly-randconfig-001-20260912    gcc-14
i386        buildonly-randconfig-002-20260911    clang-22
i386        buildonly-randconfig-002-20260912    gcc-14
i386        buildonly-randconfig-003-20260911    clang-22
i386        buildonly-randconfig-003-20260912    gcc-14
i386        buildonly-randconfig-004-20260911    clang-22
i386        buildonly-randconfig-004-20260912    gcc-14
i386        buildonly-randconfig-005-20260911    clang-22
i386        buildonly-randconfig-005-20260912    gcc-14
i386        buildonly-randconfig-006-20260911    clang-22
i386        buildonly-randconfig-006-20260912    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260911    clang-22
i386                  randconfig-002-20260911    clang-22
i386                  randconfig-003-20260911    clang-22
i386                  randconfig-004-20260911    clang-22
i386                  randconfig-005-20260911    clang-22
i386                  randconfig-006-20260911    clang-22
i386                  randconfig-007-20260911    clang-22
i386                  randconfig-011-20260911    clang-22
i386                  randconfig-011-20260912    gcc-14
i386                  randconfig-012-20260911    clang-22
i386                  randconfig-012-20260912    gcc-14
i386                  randconfig-013-20260911    clang-22
i386                  randconfig-013-20260912    gcc-14
i386                  randconfig-014-20260911    clang-22
i386                  randconfig-014-20260912    gcc-14
i386                  randconfig-015-20260911    clang-22
i386                  randconfig-015-20260912    gcc-14
i386                  randconfig-016-20260911    clang-22
i386                  randconfig-016-20260912    gcc-14
i386                  randconfig-017-20260911    clang-22
i386                  randconfig-017-20260912    gcc-14
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260911    gcc-12.5.0
loongarch             randconfig-001-20260912    clang-24
loongarch             randconfig-002-20260911    gcc-12.5.0
loongarch             randconfig-002-20260912    clang-24
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                                defconfig    clang-24
m68k                       m5235evb_defconfig    gcc-16.1.0
m68k                       m5275evb_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-24
microblaze                      mmu_defconfig    clang-24
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                     decstation_defconfig    clang-24
mips                     decstation_defconfig    gcc-16.1.0
mips                      fuloong2e_defconfig    gcc-16.1.0
mips                           gcw0_defconfig    clang-24
mips                           jazz_defconfig    clang-24
mips                      loongson1_defconfig    gcc-16.1.0
mips                      loongson3_defconfig    gcc-16.1.0
mips                       rbtx49xx_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-24
nios2                               defconfig    clang-24
nios2                 randconfig-001-20260911    gcc-12.5.0
nios2                 randconfig-001-20260912    clang-24
nios2                 randconfig-002-20260911    gcc-12.5.0
nios2                 randconfig-002-20260912    clang-24
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-24
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260911    gcc-8.5.0
parisc                randconfig-001-20260912    clang-24
parisc                randconfig-002-20260911    gcc-8.5.0
parisc                randconfig-002-20260912    clang-24
parisc64                         alldefconfig    gcc-16.1.0
parisc64                            defconfig    clang-24
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                    amigaone_defconfig    gcc-16.1.0
powerpc                        icon_defconfig    clang-24
powerpc                   lite5200b_defconfig    gcc-16.1.0
powerpc                     mpc5200_defconfig    clang-24
powerpc                     rainier_defconfig    clang-24
powerpc               randconfig-001-20260911    gcc-8.5.0
powerpc               randconfig-001-20260912    clang-24
powerpc               randconfig-002-20260911    gcc-8.5.0
powerpc               randconfig-002-20260912    clang-24
powerpc                  storcenter_defconfig    gcc-16.1.0
powerpc                      tqm8xx_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260911    gcc-8.5.0
powerpc64             randconfig-001-20260912    clang-24
powerpc64             randconfig-002-20260911    gcc-8.5.0
powerpc64             randconfig-002-20260912    clang-24
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                            allyesconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260911    gcc-16.1.0
riscv                 randconfig-001-20260912    gcc-11.5.0
riscv                 randconfig-002-20260911    gcc-16.1.0
riscv                 randconfig-002-20260912    gcc-11.5.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                          debug_defconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260911    gcc-16.1.0
s390                  randconfig-001-20260912    gcc-11.5.0
s390                  randconfig-002-20260911    gcc-16.1.0
s390                  randconfig-002-20260912    gcc-11.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260911    gcc-16.1.0
sh                    randconfig-001-20260912    gcc-11.5.0
sh                    randconfig-002-20260911    gcc-16.1.0
sh                    randconfig-002-20260912    gcc-11.5.0
sh                      rts7751r2d1_defconfig    gcc-16.1.0
sh                   rts7751r2dplus_defconfig    gcc-16.1.0
sh                           se7206_defconfig    gcc-16.1.0
sh                           se7722_defconfig    gcc-16.1.0
sh                             shx3_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-24
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260911    gcc-13.4.0
sparc                 randconfig-001-20260912    gcc-14.3.0
sparc                 randconfig-002-20260911    gcc-13.4.0
sparc                 randconfig-002-20260912    gcc-14.3.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260911    gcc-13.4.0
sparc64               randconfig-001-20260912    gcc-14.3.0
sparc64               randconfig-002-20260911    gcc-13.4.0
sparc64               randconfig-002-20260912    gcc-14.3.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260911    gcc-13.4.0
um                    randconfig-001-20260912    gcc-14.3.0
um                    randconfig-002-20260911    gcc-13.4.0
um                    randconfig-002-20260912    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-24
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260911    gcc-14
x86_64      buildonly-randconfig-001-20260912    gcc-14
x86_64      buildonly-randconfig-002-20260911    gcc-14
x86_64      buildonly-randconfig-002-20260912    gcc-14
x86_64      buildonly-randconfig-003-20260911    gcc-14
x86_64      buildonly-randconfig-003-20260912    gcc-14
x86_64      buildonly-randconfig-004-20260911    gcc-14
x86_64      buildonly-randconfig-004-20260912    gcc-14
x86_64      buildonly-randconfig-005-20260911    gcc-14
x86_64      buildonly-randconfig-005-20260912    gcc-14
x86_64      buildonly-randconfig-006-20260911    gcc-14
x86_64      buildonly-randconfig-006-20260912    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260911    clang-22
x86_64                randconfig-002-20260911    clang-22
x86_64                randconfig-003-20260911    clang-22
x86_64                randconfig-004-20260911    clang-22
x86_64                randconfig-005-20260911    clang-22
x86_64                randconfig-006-20260911    clang-22
x86_64                randconfig-011-20260911    gcc-14
x86_64                randconfig-012-20260911    gcc-14
x86_64                randconfig-013-20260911    gcc-14
x86_64                randconfig-014-20260911    gcc-14
x86_64                randconfig-015-20260911    gcc-14
x86_64                randconfig-016-20260911    gcc-14
x86_64                randconfig-071-20260911    gcc-14
x86_64                randconfig-071-20260912    gcc-14
x86_64                randconfig-072-20260911    gcc-14
x86_64                randconfig-072-20260912    gcc-14
x86_64                randconfig-073-20260911    gcc-14
x86_64                randconfig-073-20260912    gcc-14
x86_64                randconfig-074-20260911    gcc-14
x86_64                randconfig-074-20260912    gcc-14
x86_64                randconfig-075-20260911    gcc-14
x86_64                randconfig-075-20260912    gcc-14
x86_64                randconfig-076-20260911    gcc-14
x86_64                randconfig-076-20260912    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-24
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260911    gcc-13.4.0
xtensa                randconfig-001-20260912    gcc-14.3.0
xtensa                randconfig-002-20260911    gcc-13.4.0
xtensa                randconfig-002-20260912    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
