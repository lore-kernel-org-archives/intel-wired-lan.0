Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DACC5B572
	for <intel-wired-lan@archiver.kernel.org>; Fri, 14 Aug 2026 22:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0843606BF;
	Fri, 14 Aug 2026 22:23:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-bFipYt0JaR; Fri, 14 Aug 2026 22:23:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC93B6067D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786746223;
	bh=UFlapNT35aRObiSpdEtrVs5KG4wHHjyX1jQP9dZwQ7A=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Uzx/8+kUF2ENZFWk2Btbov3F6v5rCZ2iuN2axXVkdrk8FZjX5Z7YcrSsO8qZOmdG/
	 R5cWQfeERzIKGAvqzKspx48gtGIx/P2K+JPtDTOxA5M1/ES75C7UJQ/1ds2SpYcNaO
	 QS30AAS4jt+s7Amf/34UHzW+FSQO1TwgAZVkYyfp34y55ZpA6TedZEbF7kEbTJsoKO
	 DYqiHClzmztUnkeW8LcZL51cH13j8VjbYc3ZE8CvB6bJwxkzXDXPPX5UM8+buebLM6
	 gwgQKEXh+0bPlGPrWsbYNnz2OAJulzNTVFOxrPpC4ssfYtUg2hgE38VbkMUohyblks
	 MIHRPIrOcYI3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC93B6067D;
	Fri, 14 Aug 2026 22:23:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CABB139A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 22:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34DC640C3D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 22:23:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kDzHXU8SNC4b for <intel-wired-lan@lists.osuosl.org>;
 Fri, 14 Aug 2026 22:23:41 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 083E540C39
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 083E540C39
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DNdGQUhQ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 083E540C39
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 22:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786746221; x=1818282221; h=date:from:to:subject:message-id;
 bh=lsLp9yQ0cO0id27/bIWGcN7McEdC2Js57/EM+547aKA=;
 b=DNdGQUhQPumKPTasua8fUFB2RjDulLjMoFE1NmRFIxjtNfkln9Qxwi+O
 Kpg2eQqnK+yH/N5cfPXGH7MHtpdrUhpXtstCETBqD1AFhCsP5v0ZaxnG1
 jwAoKFsw/S5DhC8d+qeoCWkaHZ8cipTuAAb54lHUomYqFqwz9KAAMGcke
 /l9v5rtFoeRY6OzK54t5GhzVbKhx58CVfBdqG5SxBXjTk0xaIY2kh1FG1
 skhZe0kMNE90uTA3Y1gXFpnToylbrDJ4poLTm7iRTMFgWtNl/KftceY69
 RhoIMp4BxJfG7oRAmJjBDNQcwvSpIDQTG/mYt2LSTnOAE5w7pqbO0y7NR g==;
X-CSE-ConnectionGUID: r3LnuRejR8WQ2EHSvgFjiA==
X-CSE-MsgGUID: EbIIeLLLQlmFCs0/q+FrQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87396462"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; d="scan'208";a="87396462"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 15:23:40 -0700
X-CSE-ConnectionGUID: gFA0W+K5Sh2ghfkqjaCk6g==
X-CSE-MsgGUID: bPfjMWaqToS0B+/Hz9GNtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; d="scan'208";a="267828493"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa003.jf.intel.com with ESMTP; 14 Aug 2026 15:23:39 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wv0JM-00000000aOU-3iRO;
 Fri, 14 Aug 2026 22:23:36 +0000
Date: Sat, 15 Aug 2026 06:22:50 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608150636.hwsKoPGg-lkp@intel.com>
User-Agent: s-nail v14.9.25
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 ac155a26750a595703e7dadff84735456d75a479
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
branch HEAD: ac155a26750a595703e7dadff84735456d75a479  Merge branch 'mptcp-out-of-order-queue-pruning'

elapsed time: 3539m

configs tested: 193
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260813    gcc-13.4.0
arc                  randconfig-001-20260814    gcc-10.5.0
arc                  randconfig-002-20260813    gcc-13.4.0
arc                  randconfig-002-20260814    gcc-12.5.0
arm                         exynos_defconfig    clang-17
arm                       keystone_defconfig    gcc-16.1.0
arm                  randconfig-001-20260813    gcc-13.4.0
arm                  randconfig-001-20260814    gcc-16.1.0
arm                  randconfig-002-20260813    gcc-13.4.0
arm                  randconfig-002-20260814    gcc-10.5.0
arm                  randconfig-003-20260813    gcc-13.4.0
arm                  randconfig-003-20260814    gcc-16.1.0
arm                  randconfig-004-20260813    gcc-13.4.0
arm                  randconfig-004-20260814    clang-17
arm                         sp7021_defconfig    gcc-16.1.0
arm64                randconfig-001-20260813    gcc-16.1.0
arm64                randconfig-001-20260814    gcc-10.5.0
arm64                randconfig-002-20260813    gcc-16.1.0
arm64                randconfig-002-20260814    clang-24
arm64                randconfig-003-20260813    gcc-16.1.0
arm64                randconfig-003-20260814    clang-19
arm64                randconfig-004-20260813    gcc-16.1.0
arm64                randconfig-004-20260814    clang-17
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260813    gcc-16.1.0
csky                 randconfig-001-20260814    gcc-16.1.0
csky                 randconfig-002-20260813    gcc-16.1.0
csky                 randconfig-002-20260814    gcc-10.5.0
hexagon                       randconfig-001    clang-17
hexagon              randconfig-001-20260813    gcc-11.5.0
hexagon              randconfig-001-20260814    clang-17
hexagon              randconfig-002-20260813    gcc-11.5.0
hexagon              randconfig-002-20260814    clang-19
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260813    gcc-14
i386       buildonly-randconfig-001-20260814    clang-22
i386       buildonly-randconfig-002-20260813    gcc-14
i386       buildonly-randconfig-002-20260814    gcc-13
i386       buildonly-randconfig-003-20260813    gcc-14
i386       buildonly-randconfig-003-20260814    clang-22
i386       buildonly-randconfig-004-20260813    gcc-14
i386       buildonly-randconfig-004-20260814    clang-22
i386       buildonly-randconfig-005-20260813    gcc-14
i386       buildonly-randconfig-005-20260814    gcc-13
i386       buildonly-randconfig-006-20260813    gcc-14
i386       buildonly-randconfig-006-20260814    gcc-14
i386                 randconfig-001-20260813    clang-22
i386                 randconfig-001-20260814    clang-22
i386                 randconfig-002-20260813    clang-22
i386                 randconfig-002-20260814    gcc-14
i386                 randconfig-003-20260813    clang-22
i386                 randconfig-003-20260814    gcc-14
i386                 randconfig-004-20260813    clang-22
i386                 randconfig-004-20260814    clang-22
i386                 randconfig-005-20260813    clang-22
i386                 randconfig-005-20260814    clang-22
i386                 randconfig-006-20260813    clang-22
i386                 randconfig-006-20260814    clang-22
i386                 randconfig-007-20260813    clang-22
i386                 randconfig-007-20260814    clang-22
i386                          randconfig-011    clang-22
i386                 randconfig-011-20260813    clang-22
i386                 randconfig-011-20260814    gcc-14
i386                 randconfig-012-20260813    clang-22
i386                 randconfig-012-20260814    gcc-12
i386                 randconfig-013-20260813    clang-22
i386                 randconfig-013-20260814    gcc-12
i386                 randconfig-014-20260813    clang-22
i386                 randconfig-014-20260814    gcc-14
i386                 randconfig-015-20260813    clang-22
i386                 randconfig-015-20260814    gcc-12
i386                 randconfig-016-20260813    clang-22
i386                 randconfig-016-20260814    gcc-14
i386                 randconfig-017-20260813    clang-22
i386                 randconfig-017-20260814    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260813    gcc-11.5.0
loongarch            randconfig-001-20260814    gcc-16.1.0
loongarch            randconfig-002-20260813    gcc-11.5.0
loongarch            randconfig-002-20260814    clang-24
mips                        cobalt_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260813    gcc-11.5.0
nios2                randconfig-001-20260814    gcc-11.5.0
nios2                randconfig-002-20260813    gcc-11.5.0
nios2                randconfig-002-20260814    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260813    gcc-10.5.0
parisc               randconfig-001-20260814    gcc-15.2.0
parisc               randconfig-002-20260813    gcc-10.5.0
parisc               randconfig-002-20260814    gcc-9.5.0
powerpc                      eiger_defconfig    clang-24
powerpc              randconfig-001-20260813    gcc-10.5.0
powerpc              randconfig-001-20260814    gcc-8.5.0
powerpc              randconfig-002-20260813    gcc-10.5.0
powerpc              randconfig-002-20260814    clang-18
powerpc                 storcenter_defconfig    gcc-16.1.0
powerpc64            randconfig-001-20260813    gcc-10.5.0
powerpc64            randconfig-001-20260814    gcc-14.3.0
powerpc64            randconfig-002-20260813    gcc-10.5.0
powerpc64            randconfig-002-20260814    gcc-8.5.0
riscv                randconfig-001-20260813    gcc-10.5.0
riscv                randconfig-001-20260814    gcc-14.3.0
riscv                randconfig-002-20260813    gcc-10.5.0
riscv                randconfig-002-20260814    clang-24
s390                 randconfig-001-20260813    gcc-10.5.0
s390                 randconfig-001-20260814    gcc-11.5.0
s390                 randconfig-002-20260813    gcc-10.5.0
s390                 randconfig-002-20260814    gcc-13.4.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260813    gcc-10.5.0
sh                   randconfig-001-20260814    gcc-16.1.0
sh                   randconfig-002-20260813    gcc-10.5.0
sh                   randconfig-002-20260814    gcc-16.1.0
sparc                randconfig-001-20260813    clang-20
sparc                randconfig-001-20260814    gcc-16.1.0
sparc                randconfig-002-20260813    clang-20
sparc                randconfig-002-20260814    gcc-15.2.0
sparc64              randconfig-001-20260813    clang-20
sparc64              randconfig-001-20260814    gcc-8.5.0
sparc64              randconfig-002-20260813    clang-20
sparc64              randconfig-002-20260814    clang-24
um                   randconfig-001-20260813    clang-20
um                   randconfig-001-20260814    gcc-14
um                   randconfig-002-20260813    clang-20
um                   randconfig-002-20260814    clang-22
x86_64              buildonly-randconfig-001    gcc-12
x86_64     buildonly-randconfig-001-20260813    gcc-14
x86_64     buildonly-randconfig-001-20260814    clang-22
x86_64     buildonly-randconfig-002-20260813    gcc-14
x86_64     buildonly-randconfig-002-20260814    clang-22
x86_64     buildonly-randconfig-003-20260813    gcc-14
x86_64     buildonly-randconfig-003-20260814    clang-22
x86_64     buildonly-randconfig-004-20260813    gcc-14
x86_64     buildonly-randconfig-004-20260814    clang-22
x86_64     buildonly-randconfig-005-20260813    gcc-14
x86_64     buildonly-randconfig-005-20260814    clang-22
x86_64     buildonly-randconfig-006-20260813    gcc-14
x86_64     buildonly-randconfig-006-20260814    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260813    gcc-13
x86_64               randconfig-001-20260814    gcc-14
x86_64               randconfig-002-20260813    gcc-13
x86_64               randconfig-002-20260814    clang-22
x86_64               randconfig-003-20260813    gcc-13
x86_64               randconfig-003-20260814    clang-22
x86_64               randconfig-004-20260813    gcc-13
x86_64               randconfig-004-20260814    clang-22
x86_64               randconfig-005-20260813    gcc-13
x86_64               randconfig-005-20260814    gcc-14
x86_64               randconfig-006-20260813    gcc-13
x86_64               randconfig-006-20260814    gcc-14
x86_64               randconfig-011-20260813    gcc-14
x86_64               randconfig-011-20260814    clang-22
x86_64               randconfig-012-20260813    gcc-14
x86_64               randconfig-012-20260814    gcc-13
x86_64               randconfig-013-20260813    gcc-14
x86_64               randconfig-013-20260814    clang-22
x86_64               randconfig-014-20260813    gcc-14
x86_64               randconfig-014-20260814    gcc-14
x86_64               randconfig-015-20260813    gcc-14
x86_64               randconfig-015-20260814    gcc-14
x86_64               randconfig-016-20260813    gcc-14
x86_64               randconfig-016-20260814    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260813    gcc-14
x86_64               randconfig-071-20260814    gcc-14
x86_64               randconfig-072-20260813    gcc-14
x86_64               randconfig-072-20260814    clang-22
x86_64               randconfig-073-20260813    gcc-14
x86_64               randconfig-073-20260814    clang-22
x86_64               randconfig-074-20260813    gcc-14
x86_64               randconfig-074-20260814    gcc-13
x86_64               randconfig-075-20260813    gcc-14
x86_64               randconfig-075-20260814    gcc-14
x86_64               randconfig-076-20260813    gcc-14
x86_64               randconfig-076-20260814    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260813    clang-20
xtensa               randconfig-001-20260814    gcc-9.5.0
xtensa               randconfig-002-20260813    clang-20
xtensa               randconfig-002-20260814    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
