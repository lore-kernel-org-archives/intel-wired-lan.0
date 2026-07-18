Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDE8C4450A
	for <intel-wired-lan@archiver.kernel.org>; Sat, 18 Jul 2026 06:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5B5C405D3;
	Sat, 18 Jul 2026 06:29:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BAKZc25QHe89; Sat, 18 Jul 2026 06:29:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DBF7B40887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784356164;
	bh=h07tKpgE4dR6C5BBTyOCaAbWe20m9KnS4n72MzcPpoQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=t5JPP/J/M79I3313pp302rh7VfVhxTmYHgl2g9Q2THm2w+4Y5LAT+n57lajOlBs56
	 iCyHcGClp07omo7XAeNqdTlqB7XEjmDNJEjTx5FDF+g5nk1G7Fs7ec8Q/MmeWFCVMT
	 NGuKJ0Iveqkg+7Pb3x1j9KE2iuhzblNpSg0TygNJIAPRWoTMxrwIiajC6euCJGzRKn
	 hzOCCJoTL+gUIVGF+kCuvn1OcLBry6wySzXf+oL1PpWmxTBi0qkr6+Iw3+zt/Sfc5n
	 XjuK4r1AESFbQST4TWUo8P7tvLUYtj2aCNHiEbxS7qTufEBCuYYywcuhqZG0bTcBuY
	 oEqEWYkzDvvLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBF7B40887;
	Sat, 18 Jul 2026 06:29:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 576BA320
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jul 2026 06:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F936405D3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jul 2026 06:29:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nsW782xz1xkh for <intel-wired-lan@lists.osuosl.org>;
 Sat, 18 Jul 2026 06:29:21 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C6C8D4059F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6C8D4059F
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6C8D4059F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jul 2026 06:29:20 +0000 (UTC)
X-CSE-ConnectionGUID: 9Ck4psaVR5yfk4C+6mC5yA==
X-CSE-MsgGUID: 0uJFEf1wTnWzgWFGkSYesA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="88916697"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; d="scan'208";a="88916697"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 23:29:20 -0700
X-CSE-ConnectionGUID: 8hYcabI5RACdbenOpEWBRA==
X-CSE-MsgGUID: XxlNMOyFSCOXWKbeGtStfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; d="scan'208";a="287030711"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by orviesa002.jf.intel.com with ESMTP; 17 Jul 2026 23:29:19 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wkyY0-00000000TVn-21LP;
 Sat, 18 Jul 2026 06:29:16 +0000
Date: Sat, 18 Jul 2026 14:28:59 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607181449.m6ZUE37T-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784356161; x=1815892161;
 h=date:from:to:subject:message-id;
 bh=eX+p5FD4NAMzOguLjYjlb6jxQGU+wp2Zq5sHYPllCAE=;
 b=R7ndj98Lx3BL4xf0NEAmIq73ESvZBI+OMpwIWfsBMgevAWt/Xx0Vc9R+
 FeSncz1vabLQiSQ4NeruxHPJExazc6D8+mkYQgTINNTbhEFjqqJXSWC40
 WSOAia+ym4/LGWJt/8waysP1OLWZeVHDOjH8y2Gf0DbBZnuQhV9UJNFb8
 tdnHLi0kLNkTw+svnpbUNAo/v5Pjq9x3hwaPCQ+qVANAe/O0BbHejITbh
 UjXnySvmLq48Rtuq6zjPg1XnQzIdupUmV9411tyV3FSKIi5QZpTcjDZMp
 kJaCFcFDCQ2OVuEts/fq6ZCI5cyMquyOw1yb79dtFGu1rVZhHJ44C7JUw
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R7ndj98L
Subject: [Intel-wired-lan] [tnguy-next-queue:main] BUILD SUCCESS
 ce6b4d3216b63f902bb8e9695ee6c10c83415f65
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git main
branch HEAD: ce6b4d3216b63f902bb8e9695ee6c10c83415f65  net: mana: Add handler for sriov configure

elapsed time: 736m

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
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260718    gcc-8.5.0
arc                  randconfig-002-20260718    gcc-8.5.0
arm                  randconfig-001-20260718    gcc-8.5.0
arm                  randconfig-002-20260718    gcc-8.5.0
arm                  randconfig-003-20260718    gcc-8.5.0
arm                  randconfig-004-20260718    gcc-8.5.0
arm                          u8500_defconfig    gcc-16.1.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260718    gcc-14.3.0
arm64                randconfig-002-20260718    gcc-14.3.0
arm64                randconfig-003-20260718    gcc-14.3.0
arm64                randconfig-004-20260718    gcc-14.3.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260718    gcc-14.3.0
csky                 randconfig-002-20260718    gcc-14.3.0
hexagon              randconfig-001-20260718    clang-18
hexagon              randconfig-002-20260718    clang-18
i386                            allmodconfig    gcc-14
i386                 randconfig-001-20260718    gcc-14
i386                 randconfig-002-20260718    gcc-14
i386                 randconfig-003-20260718    gcc-14
i386                 randconfig-004-20260718    gcc-14
i386                 randconfig-005-20260718    gcc-14
i386                 randconfig-006-20260718    gcc-14
i386                 randconfig-007-20260718    gcc-14
i386                 randconfig-011-20260718    clang-22
i386                 randconfig-012-20260718    clang-22
i386                 randconfig-013-20260718    clang-22
i386                 randconfig-014-20260718    clang-22
i386                 randconfig-015-20260718    clang-22
i386                 randconfig-016-20260718    clang-22
i386                 randconfig-017-20260718    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260718    clang-18
loongarch            randconfig-002-20260718    clang-18
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260718    clang-18
nios2                randconfig-002-20260718    clang-18
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-16.1.0
parisc               randconfig-001-20260718    gcc-16.1.0
parisc               randconfig-002-20260718    gcc-16.1.0
powerpc              randconfig-001-20260718    gcc-16.1.0
powerpc              randconfig-002-20260718    gcc-16.1.0
powerpc64            randconfig-001-20260718    gcc-16.1.0
powerpc64            randconfig-002-20260718    gcc-16.1.0
riscv                randconfig-001-20260718    clang-24
riscv                randconfig-002-20260718    clang-24
s390                 randconfig-001-20260718    clang-24
s390                 randconfig-002-20260718    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260718    clang-24
sh                   randconfig-002-20260718    clang-24
sparc                randconfig-001-20260718    gcc-11.5.0
sparc                randconfig-002-20260718    gcc-11.5.0
sparc64              randconfig-001-20260718    gcc-11.5.0
sparc64              randconfig-002-20260718    gcc-11.5.0
um                   randconfig-001-20260718    gcc-11.5.0
um                   randconfig-002-20260718    gcc-11.5.0
x86_64     buildonly-randconfig-001-20260718    clang-22
x86_64     buildonly-randconfig-002-20260718    clang-22
x86_64     buildonly-randconfig-003-20260718    clang-22
x86_64     buildonly-randconfig-004-20260718    clang-22
x86_64     buildonly-randconfig-005-20260718    clang-22
x86_64     buildonly-randconfig-006-20260718    clang-22
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260718    gcc-14
x86_64               randconfig-002-20260718    gcc-14
x86_64               randconfig-003-20260718    gcc-14
x86_64               randconfig-004-20260718    gcc-14
x86_64               randconfig-005-20260718    gcc-14
x86_64               randconfig-006-20260718    gcc-14
x86_64               randconfig-011-20260718    gcc-14
x86_64               randconfig-012-20260718    gcc-14
x86_64               randconfig-013-20260718    gcc-14
x86_64               randconfig-014-20260718    gcc-14
x86_64               randconfig-015-20260718    gcc-14
x86_64               randconfig-016-20260718    gcc-14
x86_64               randconfig-071-20260718    clang-22
x86_64               randconfig-072-20260718    clang-22
x86_64               randconfig-073-20260718    clang-22
x86_64               randconfig-074-20260718    clang-22
x86_64               randconfig-075-20260718    clang-22
x86_64               randconfig-076-20260718    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260718    gcc-11.5.0
xtensa               randconfig-002-20260718    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
