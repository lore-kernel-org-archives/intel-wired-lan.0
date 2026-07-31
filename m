Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE188C5516D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 14:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 651EC60AE5;
	Fri, 31 Jul 2026 14:24:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1zx42dYoQMsY; Fri, 31 Jul 2026 14:24:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9EEAB60AAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785507853;
	bh=5tZ+N2GaDAav3JweJlIA3jNfD+KHp9SH3TpeCZjAljI=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XuXvVH12zqjGfnXBIGNvPFLJj75bdH2BJtvVAeWb3HhSozAus6YTrryWSJfP7LxdL
	 SscinR82hy/OQfoYaaJeChdSWqkY4+ebQCR8CIylVc7a7lsLf/gLU244FOiCX++pty
	 rEtwsnLCtrEbUcoxYKidqOKvQYwDzPfAw/AU9baflM6Sjoq7CLhV6gf2UqXowmtYM9
	 iAzqLMxXrpgcjAnPTCVsL2pXGj5DHacFL6xAu3NB+/Xzty/GzY6CL3bJTgnVffueA9
	 X43cdSz4RjEFMYGrrLMcrHjazATu6J7U/LqN40xEADVxNp5p2y4XDBd79Sy6gblXdG
	 +xjEaGsv5eNsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EEAB60AAC;
	Fri, 31 Jul 2026 14:24:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 438A537F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 14:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29726400A4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 14:24:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6vkNUHUFXCpr for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 14:24:11 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3D66A4004C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D66A4004C
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D66A4004C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 14:24:11 +0000 (UTC)
X-CSE-ConnectionGUID: rvKEAE+NSF+QMiuWDd8RBQ==
X-CSE-MsgGUID: ecanU7PeSliAhCKraLuEuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="89945563"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="89945563"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 07:24:11 -0700
X-CSE-ConnectionGUID: kzWLkHuhRnO40wyyqBpzrg==
X-CSE-MsgGUID: hY+o8J9dT+qDwz7JX8CXKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="254284819"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa009.fm.intel.com with ESMTP; 31 Jul 2026 07:24:10 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wpo9f-000000001DY-2ZFn;
 Fri, 31 Jul 2026 14:24:07 +0000
Date: Fri, 31 Jul 2026 22:23:21 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607312208.Wg2TWgq0-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785507851; x=1817043851;
 h=date:from:to:subject:message-id;
 bh=K/p++qOIOVanGncvqWQWXF3ldxzVJHPfr3NeKK57eRg=;
 b=RctfstNkHUSqXpToEylSjj7NNXWPj8sMr/mUv3b4wrhWq+u1R4KEvIwJ
 +2ssxxojAUlqQKKlunjUl02hDLeLCBQXF0EFgjNx7jVcYhnpG8MTjwakY
 /ryLn45yCiTbgLexqCeKj3aa95TSNlQ5yoaQ9dMyEz7VyXU0bmVGVa8e5
 vy6YQee10136VgLcRyfxBgc1diZItMaXAgSU4NfvaRvoS2j6d2zf7jK+r
 lQEPKlTACuIE6064332VMtrjPvtsE+vqR7liit3jy3r4Odu/+wC+d1OMI
 8swQG2JK0vjGcj6Q5l2YtIn4Jr9ZDZ7K0l8tRtRXOCNeMzRxdXZFE6ECa
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RctfstNk
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 84d9cbb535f956cd408c9fea1d1fff3e41fcdd35
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 84d9cbb535f956cd408c9fea1d1fff3e41fcdd35  i40e: xsk: fix multi-buffer XDP_PASS skb construction

elapsed time: 803m

configs tested: 97
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260731    clang-17
arc                  randconfig-002-20260731    clang-17
arm                           mmp2_defconfig    gcc-16.1.0
arm                  randconfig-001-20260731    clang-17
arm                  randconfig-002-20260731    clang-17
arm                  randconfig-003-20260731    clang-17
arm                  randconfig-004-20260731    clang-17
arm64                randconfig-001-20260731    gcc-8.5.0
arm64                randconfig-002-20260731    gcc-8.5.0
arm64                randconfig-003-20260731    gcc-8.5.0
arm64                randconfig-004-20260731    gcc-8.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260731    gcc-8.5.0
csky                 randconfig-002-20260731    gcc-8.5.0
hexagon              randconfig-001-20260731    clang-24
hexagon              randconfig-002-20260731    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260731    clang-22
i386       buildonly-randconfig-002-20260731    clang-22
i386       buildonly-randconfig-003-20260731    clang-22
i386       buildonly-randconfig-004-20260731    clang-22
i386       buildonly-randconfig-005-20260731    clang-22
i386       buildonly-randconfig-006-20260731    clang-22
i386                 randconfig-001-20260731    gcc-14
i386                 randconfig-002-20260731    gcc-14
i386                 randconfig-003-20260731    gcc-14
i386                 randconfig-004-20260731    gcc-14
i386                 randconfig-005-20260731    gcc-14
i386                 randconfig-006-20260731    gcc-14
i386                 randconfig-007-20260731    gcc-14
i386                 randconfig-011-20260731    clang-22
i386                 randconfig-012-20260731    clang-22
i386                 randconfig-013-20260731    clang-22
i386                 randconfig-014-20260731    clang-22
i386                 randconfig-015-20260731    clang-22
i386                 randconfig-016-20260731    clang-22
i386                 randconfig-017-20260731    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260731    clang-24
loongarch            randconfig-002-20260731    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260731    clang-24
nios2                randconfig-002-20260731    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260731    gcc-8.5.0
parisc               randconfig-002-20260731    gcc-8.5.0
powerpc              randconfig-001-20260731    gcc-8.5.0
powerpc              randconfig-002-20260731    gcc-8.5.0
powerpc64            randconfig-001-20260731    gcc-8.5.0
powerpc64            randconfig-002-20260731    gcc-8.5.0
riscv                         randconfig-001    clang-19
riscv                randconfig-001-20260731    clang-19
riscv                randconfig-002-20260731    clang-19
s390                 randconfig-001-20260731    clang-19
s390                 randconfig-002-20260731    clang-19
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260731    clang-19
sh                   randconfig-002-20260731    clang-19
sparc                         randconfig-001    gcc-14
sparc                randconfig-001-20260731    gcc-14
sparc                randconfig-002-20260731    gcc-14
sparc64              randconfig-001-20260731    gcc-14
sparc64              randconfig-002-20260731    gcc-14
um                   randconfig-001-20260731    gcc-14
um                   randconfig-002-20260731    gcc-14
x86_64     buildonly-randconfig-001-20260731    gcc-14
x86_64     buildonly-randconfig-002-20260731    gcc-14
x86_64     buildonly-randconfig-003-20260731    gcc-14
x86_64     buildonly-randconfig-004-20260731    gcc-14
x86_64     buildonly-randconfig-005-20260731    gcc-14
x86_64     buildonly-randconfig-006-20260731    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260731    gcc-14
x86_64               randconfig-002-20260731    gcc-14
x86_64               randconfig-003-20260731    gcc-14
x86_64               randconfig-004-20260731    gcc-14
x86_64               randconfig-005-20260731    gcc-14
x86_64               randconfig-006-20260731    gcc-14
x86_64               randconfig-071-20260731    clang-22
x86_64               randconfig-072-20260731    clang-22
x86_64               randconfig-073-20260731    clang-22
x86_64               randconfig-074-20260731    clang-22
x86_64               randconfig-075-20260731    clang-22
x86_64               randconfig-076-20260731    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260731    gcc-14
xtensa               randconfig-002-20260731    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
