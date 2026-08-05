Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78689C55174
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 12:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 234A580AD3;
	Wed,  5 Aug 2026 12:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9nUG0wG9Mv0n; Wed,  5 Aug 2026 12:00:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C0F180B33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785931215;
	bh=rz8GnXiZCG/MnpsY0jLWYhTTNroqwzNNVSOT0R8DyKs=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=9T+RiyJVMbpTpNjgbfZYFfLXzI9f0tA4iCCFQrj4pyDOzmTsIeLfZOJWd3dr+iSAF
	 CQdIEJf5GXYdJBO3iLN1+GrZYkKxJ0HDL7XhXEZQ2TNfpXIs+uTX0shJAJ+e35otqB
	 xaP/AuRlidwcbJyvUf/R7fEWY+JWfnrYsE2Y3NXeoJMK68KymSzv29SeWKxmCubi6i
	 QWFZwuSDLw/EZBohrc/OkBIBh04GPqUFVXKdeXtgVe3ySJHH9kJejJ5fd33VbVSAn+
	 XQExFZMUFJQ9mnr52cZNq+/hZdXdP0g97VFog2f1a0/ZetE4yMRXAu8sQ27SKqP0it
	 JcuzJSWfDp5bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C0F180B33;
	Wed,  5 Aug 2026 12:00:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F80C2DE
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 12:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 814E080AD3
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 12:00:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v4JB9W0iUhrU for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 12:00:12 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5EE0780B97
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EE0780B97
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EE0780B97
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 12:00:12 +0000 (UTC)
X-CSE-ConnectionGUID: rZmYdmYmRdG9ERZx9VZ3ZQ==
X-CSE-MsgGUID: kCR6L9uMQbezYOLI5H/2Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86703913"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86703913"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 05:00:08 -0700
X-CSE-ConnectionGUID: PiThMxChQnOSvukEf+mo5w==
X-CSE-MsgGUID: Iespdej0RfCoRIJu0lgFHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="259162177"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 05 Aug 2026 05:00:03 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wraHw-00000000CLf-24Gg;
 Wed, 05 Aug 2026 12:00:00 +0000
Date: Wed, 05 Aug 2026 19:59:32 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608051921.Fm3ZJUqK-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785931212; x=1817467212;
 h=date:from:to:subject:message-id;
 bh=6bIgAhO6aJSMAc83AimGtZ/qCMM7l/AxbCMzuXweI4M=;
 b=TRpwq5l0aieDlpw7zc/6hRg/NjRqWyMAaOnl9PjoVhRI3UAQUTkt6aYT
 G0FjIeUDsz1yPeHWLoDV93RWaKuFbYeCuWjCas54a3PsrfO3OFq2CL9GG
 kJEQzea77jkTZeM1y0BK5U1mfZh/17yD6suRHZuBsLZbiw0usd7J+w8Rd
 x3EguGOV3HCCPTnml94/P+ltBXPWb7s4RvSuqPRi2n8oZUyggX7ZLNnI6
 gxXHftA/c1XTdSpNGfLl0Dwijy1/OejOv8vMkso5JsQM9e4yaswrcqrew
 kcdVWTlDWLrYJdoCGIPhlfScVXAr7d4cx4NL1y7vytf8exgJzIG5Ag29L
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TRpwq5l0
Subject: [Intel-wired-lan] [tnguy-next-queue:10GbE] BUILD SUCCESS
 d661abdc30c254649c32ef6e0aa1e621e04ff0a7
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
branch HEAD: d661abdc30c254649c32ef6e0aa1e621e04ff0a7  net: ngbe: correct misleading interrupt comment

elapsed time: 1530m

configs tested: 192
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260804    gcc-8.5.0
arc                  randconfig-001-20260805    gcc-12.5.0
arc                  randconfig-002-20260804    gcc-8.5.0
arc                  randconfig-002-20260805    gcc-12.5.0
arm                  randconfig-001-20260804    gcc-8.5.0
arm                  randconfig-001-20260805    gcc-12.5.0
arm                  randconfig-002-20260804    gcc-8.5.0
arm                  randconfig-002-20260805    gcc-12.5.0
arm                  randconfig-003-20260804    gcc-8.5.0
arm                  randconfig-003-20260805    gcc-12.5.0
arm                  randconfig-004-20260804    gcc-8.5.0
arm                  randconfig-004-20260805    gcc-12.5.0
arm64                         randconfig-001    gcc-11.5.0
arm64                randconfig-001-20260804    gcc-11.5.0
arm64                randconfig-001-20260805    gcc-10.5.0
arm64                randconfig-002-20260804    gcc-11.5.0
arm64                randconfig-002-20260805    gcc-10.5.0
arm64                randconfig-003-20260804    gcc-11.5.0
arm64                randconfig-003-20260805    gcc-10.5.0
arm64                randconfig-004-20260804    gcc-11.5.0
arm64                randconfig-004-20260805    gcc-10.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260804    gcc-11.5.0
csky                 randconfig-001-20260805    gcc-10.5.0
csky                 randconfig-002-20260804    gcc-11.5.0
csky                 randconfig-002-20260805    gcc-10.5.0
hexagon              randconfig-001-20260804    gcc-16.1.0
hexagon              randconfig-001-20260805    clang-18
hexagon              randconfig-002-20260804    gcc-16.1.0
hexagon              randconfig-002-20260805    clang-18
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260804    gcc-14
i386       buildonly-randconfig-001-20260805    clang-22
i386       buildonly-randconfig-002-20260804    gcc-14
i386       buildonly-randconfig-002-20260805    clang-22
i386       buildonly-randconfig-003-20260804    gcc-14
i386       buildonly-randconfig-003-20260805    clang-22
i386       buildonly-randconfig-004-20260804    gcc-14
i386       buildonly-randconfig-004-20260805    clang-22
i386       buildonly-randconfig-005-20260804    gcc-14
i386       buildonly-randconfig-005-20260805    clang-22
i386       buildonly-randconfig-006-20260804    gcc-14
i386       buildonly-randconfig-006-20260805    clang-22
i386                 randconfig-001-20260804    clang-22
i386                 randconfig-001-20260805    gcc-13
i386                 randconfig-002-20260804    clang-22
i386                 randconfig-002-20260805    gcc-13
i386                 randconfig-003-20260804    clang-22
i386                 randconfig-003-20260805    gcc-13
i386                 randconfig-004-20260804    clang-22
i386                 randconfig-004-20260805    gcc-13
i386                 randconfig-005-20260804    clang-22
i386                 randconfig-005-20260805    gcc-13
i386                 randconfig-006-20260804    clang-22
i386                 randconfig-006-20260805    gcc-13
i386                 randconfig-007-20260804    clang-22
i386                 randconfig-007-20260805    gcc-13
i386                          randconfig-011    gcc-13
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260804    gcc-13
i386                 randconfig-011-20260805    gcc-14
i386                 randconfig-012-20260804    gcc-13
i386                 randconfig-012-20260805    gcc-14
i386                 randconfig-013-20260804    gcc-13
i386                 randconfig-013-20260805    gcc-14
i386                 randconfig-014-20260804    gcc-13
i386                 randconfig-014-20260805    gcc-14
i386                 randconfig-015-20260804    gcc-13
i386                 randconfig-015-20260805    gcc-14
i386                 randconfig-016-20260804    gcc-13
i386                 randconfig-016-20260805    gcc-14
i386                 randconfig-017-20260804    gcc-13
i386                 randconfig-017-20260805    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260804    gcc-16.1.0
loongarch            randconfig-001-20260805    clang-18
loongarch            randconfig-002-20260804    gcc-16.1.0
loongarch            randconfig-002-20260805    clang-18
mips                         ath79_defconfig    gcc-16.1.0
mips                          jazz_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260804    gcc-16.1.0
nios2                randconfig-001-20260805    clang-18
nios2                randconfig-002-20260804    gcc-16.1.0
nios2                randconfig-002-20260805    clang-18
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260804    gcc-8.5.0
parisc               randconfig-001-20260805    gcc-9.5.0
parisc               randconfig-002-20260804    gcc-8.5.0
parisc               randconfig-002-20260805    gcc-9.5.0
powerpc                     bamboo_defconfig    clang-21
powerpc                    ppa8548_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260804    gcc-8.5.0
powerpc              randconfig-001-20260805    gcc-9.5.0
powerpc              randconfig-002-20260804    gcc-8.5.0
powerpc              randconfig-002-20260805    gcc-9.5.0
powerpc64            randconfig-001-20260804    gcc-8.5.0
powerpc64            randconfig-001-20260805    gcc-9.5.0
powerpc64            randconfig-002-20260804    gcc-8.5.0
powerpc64            randconfig-002-20260805    gcc-9.5.0
riscv                         randconfig-001    gcc-8.5.0
riscv                randconfig-001-20260805    gcc-8.5.0
riscv                randconfig-002-20260804    clang-21
riscv                randconfig-002-20260805    gcc-8.5.0
s390                 randconfig-001-20260804    clang-21
s390                 randconfig-001-20260805    gcc-8.5.0
s390                 randconfig-002-20260804    clang-21
s390                 randconfig-002-20260805    gcc-8.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260804    clang-21
sh                   randconfig-001-20260805    gcc-8.5.0
sh                   randconfig-002-20260804    clang-21
sh                   randconfig-002-20260805    gcc-8.5.0
sh                            shx3_defconfig    gcc-16.1.0
sparc                randconfig-001-20260804    gcc-16.1.0
sparc                randconfig-001-20260805    gcc-11.5.0
sparc                randconfig-002-20260804    gcc-16.1.0
sparc                randconfig-002-20260805    gcc-11.5.0
sparc64              randconfig-001-20260804    gcc-16.1.0
sparc64              randconfig-001-20260805    gcc-11.5.0
sparc64              randconfig-002-20260804    gcc-16.1.0
sparc64              randconfig-002-20260805    gcc-11.5.0
um                   randconfig-001-20260804    gcc-16.1.0
um                   randconfig-001-20260805    gcc-11.5.0
um                   randconfig-002-20260804    gcc-16.1.0
um                   randconfig-002-20260805    gcc-11.5.0
x86_64              buildonly-randconfig-001    gcc-14
x86_64     buildonly-randconfig-001-20260804    gcc-14
x86_64     buildonly-randconfig-001-20260805    gcc-14
x86_64     buildonly-randconfig-002-20260804    gcc-14
x86_64     buildonly-randconfig-002-20260805    gcc-14
x86_64     buildonly-randconfig-003-20260804    gcc-14
x86_64     buildonly-randconfig-003-20260805    gcc-14
x86_64     buildonly-randconfig-004-20260804    gcc-14
x86_64     buildonly-randconfig-004-20260805    gcc-14
x86_64     buildonly-randconfig-005-20260804    gcc-14
x86_64     buildonly-randconfig-005-20260805    gcc-14
x86_64     buildonly-randconfig-006-20260804    gcc-14
x86_64     buildonly-randconfig-006-20260805    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260804    gcc-14
x86_64               randconfig-001-20260805    gcc-14
x86_64               randconfig-002-20260804    gcc-14
x86_64               randconfig-002-20260805    gcc-14
x86_64               randconfig-003-20260804    gcc-14
x86_64               randconfig-003-20260805    gcc-14
x86_64               randconfig-004-20260804    gcc-14
x86_64               randconfig-004-20260805    gcc-14
x86_64               randconfig-005-20260804    gcc-14
x86_64               randconfig-005-20260805    gcc-14
x86_64               randconfig-006-20260804    gcc-14
x86_64               randconfig-006-20260805    gcc-14
x86_64               randconfig-011-20260804    clang-22
x86_64               randconfig-011-20260805    gcc-14
x86_64               randconfig-012-20260804    clang-22
x86_64               randconfig-012-20260805    gcc-14
x86_64               randconfig-013-20260804    clang-22
x86_64               randconfig-013-20260805    gcc-14
x86_64               randconfig-014-20260804    clang-22
x86_64               randconfig-014-20260805    gcc-14
x86_64               randconfig-015-20260804    clang-22
x86_64               randconfig-015-20260805    gcc-14
x86_64               randconfig-016-20260804    clang-22
x86_64               randconfig-016-20260805    gcc-14
x86_64                        randconfig-071    clang-22
x86_64               randconfig-071-20260804    clang-22
x86_64               randconfig-071-20260805    clang-22
x86_64               randconfig-072-20260804    clang-22
x86_64               randconfig-072-20260805    clang-22
x86_64               randconfig-073-20260804    clang-22
x86_64               randconfig-073-20260805    clang-22
x86_64               randconfig-074-20260804    clang-22
x86_64               randconfig-074-20260805    clang-22
x86_64               randconfig-075-20260804    clang-22
x86_64               randconfig-075-20260805    clang-22
x86_64               randconfig-076-20260804    clang-22
x86_64               randconfig-076-20260805    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260804    gcc-16.1.0
xtensa               randconfig-001-20260805    gcc-11.5.0
xtensa               randconfig-002-20260804    gcc-16.1.0
xtensa               randconfig-002-20260805    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
