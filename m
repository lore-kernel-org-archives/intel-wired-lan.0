Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9363CD8C88
	for <intel-wired-lan@archiver.kernel.org>; Sat,  6 Jun 2026 17:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B4CC427C7;
	Sat,  6 Jun 2026 17:42:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JwW5QBF-t8sx; Sat,  6 Jun 2026 17:42:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4391A427D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780767774;
	bh=1ALXgVheJaKrcyXHHBFHpvZUGhoSx/keeiTyfAR6HY4=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iRf9UhUMbN3kPf1ncz2/pr7jpTfQlI+1TIpv0GxWq7/rwLNiqsKAC3CKfxqB4gjW4
	 0fKgVOWzhWZgEcjeZTjkpYvrlY4wKGpA1oJwMKA0EQrUjVG6z2dEb96Pvdr7zu+CTM
	 E0Ylil6uAiEYS8mlCG7RDVKTa5r2eLO7ZD6ZAwNjMfI66ZkE1/1e8ey5EYFCcdt1U8
	 dmqMnfJpC67q9cIgJEuk3oM5xLTWb+fBr2D+jKq/I0ebOAG3SNgUKuhS8YWKtufkD2
	 2afm0avnEu7GACHoVKxUr05CYPXS2drp63jDd2697J1fj7Ftg82oZrcb6OAKYLvAnE
	 Ci6zoMcmVrNJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4391A427D0;
	Sat,  6 Jun 2026 17:42:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 691D12EF
 for <intel-wired-lan@lists.osuosl.org>; Sat,  6 Jun 2026 17:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F541408B4
 for <intel-wired-lan@lists.osuosl.org>; Sat,  6 Jun 2026 17:42:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SPunZY4249Qy for <intel-wired-lan@lists.osuosl.org>;
 Sat,  6 Jun 2026 17:42:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F1BE040082
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1BE040082
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1BE040082
 for <intel-wired-lan@lists.osuosl.org>; Sat,  6 Jun 2026 17:42:51 +0000 (UTC)
X-CSE-ConnectionGUID: TN8L4CgdQjCrNgXvUqA2aw==
X-CSE-MsgGUID: fO9bSqziSuOKb8OI51mGQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11809"; a="104228037"
X-IronPort-AV: E=Sophos;i="6.24,191,1774335600"; d="scan'208";a="104228037"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2026 10:42:51 -0700
X-CSE-ConnectionGUID: IybhATR5Qge6Jy2+6ZkK/A==
X-CSE-MsgGUID: whjVJAwmRNeZxQlehSnJqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,191,1774335600"; d="scan'208";a="249452368"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
 by orviesa004.jf.intel.com with ESMTP; 06 Jun 2026 10:42:50 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wVv2l-00000000HBy-2W3c;
 Sat, 06 Jun 2026 17:42:47 +0000
Date: Sun, 07 Jun 2026 01:42:14 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202606070106.x8I1m7Cv-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780767772; x=1812303772;
 h=date:from:to:subject:message-id;
 bh=VDvCeB/XEx19xT2wEbU87goDf/yIdFidRF9iXrK3a/I=;
 b=KpkoPKnGDkHfBqHA0nWw/CF3f4SdoS9ABHKjPP4swe5nuGUEh2/lTbkf
 9wBL6zZznfaCf4jJk8X1GA8/GxVmEh6VwCDN4memv0QPBXYP6ztU2f00l
 gJwEvq5Mlcu6jBDpy1CLOZ7v1oLpfBl2LdX8ftPmUQpF6G4o2Or0GhGVX
 jXn5GiluBpEuL9Xq03CNOjL+a7g4K13hCQU5Ym85vmkO+ZQFrmPJY+Hbn
 7w3j4fhWYdxUJQzrDVZBzgxBM8u1y+aF2RiiE4tGVUT09UuMZvukq9W6J
 UBS811hcET5AemWR7QNAi9PF+WHl7MvpgTy5Y3gE4h/JgffaXott28cWo
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KpkoPKnG
Subject: [Intel-wired-lan] [tnguy-next-queue:main] BUILD SUCCESS
 bfa3d89cc15c09f7d1581c834a5ed725189ec19f
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
branch HEAD: bfa3d89cc15c09f7d1581c834a5ed725189ec19f  Merge tag 'batadv-next-pullrequest-20260603' of https://git.open-mesh.org/batadv

elapsed time: 2337m

configs tested: 214
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-17
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260606    clang-23
arc                   randconfig-002-20260606    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-17
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260606    clang-23
arm                   randconfig-002-20260606    clang-23
arm                   randconfig-003-20260606    clang-23
arm                   randconfig-004-20260606    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260606    clang-23
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260606    clang-23
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260606    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260606    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260606    clang-23
csky                  randconfig-001-20260606    gcc-10.5.0
csky                           randconfig-002    clang-23
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260606    clang-23
csky                  randconfig-002-20260606    gcc-9.5.0
csky                  randconfig-002-20260607    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260606    gcc-11.5.0
hexagon               randconfig-001-20260607    clang-17
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260606    gcc-11.5.0
hexagon               randconfig-002-20260607    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260606    gcc-13
i386        buildonly-randconfig-002-20260606    gcc-13
i386        buildonly-randconfig-003-20260606    gcc-13
i386        buildonly-randconfig-004-20260606    gcc-13
i386        buildonly-randconfig-005-20260606    gcc-13
i386        buildonly-randconfig-006-20260606    gcc-13
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260606    clang-20
i386                  randconfig-002-20260606    clang-20
i386                  randconfig-003-20260606    clang-20
i386                  randconfig-004-20260606    clang-20
i386                  randconfig-005-20260606    clang-20
i386                  randconfig-006-20260606    clang-20
i386                  randconfig-007-20260606    clang-20
i386                           randconfig-011    clang-20
i386                  randconfig-011-20260606    clang-20
i386                           randconfig-012    clang-20
i386                  randconfig-012-20260606    clang-20
i386                           randconfig-013    clang-20
i386                  randconfig-013-20260606    clang-20
i386                           randconfig-014    clang-20
i386                  randconfig-014-20260606    clang-20
i386                           randconfig-015    clang-20
i386                  randconfig-015-20260606    clang-20
i386                           randconfig-016    clang-20
i386                  randconfig-016-20260606    clang-20
i386                           randconfig-017    clang-20
i386                  randconfig-017-20260606    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260606    gcc-11.5.0
loongarch             randconfig-001-20260607    gcc-13.4.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260606    gcc-11.5.0
loongarch             randconfig-002-20260607    gcc-16.1.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-17
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-15.2.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      malta_kvm_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260606    gcc-11.5.0
nios2                 randconfig-001-20260607    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260606    gcc-11.5.0
nios2                 randconfig-002-20260607    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260606    gcc-8.5.0
parisc                randconfig-002-20260606    gcc-8.5.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260606    gcc-8.5.0
powerpc               randconfig-002-20260606    gcc-8.5.0
powerpc64             randconfig-001-20260606    gcc-8.5.0
powerpc64             randconfig-002-20260606    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    clang-17
riscv                               defconfig    gcc-16.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260606    gcc-11.5.0
sparc                 randconfig-002-20260606    gcc-11.5.0
sparc                 randconfig-002-20260606    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260606    gcc-11.5.0
sparc64               randconfig-001-20260606    gcc-8.5.0
sparc64               randconfig-002-20260606    gcc-11.5.0
sparc64               randconfig-002-20260606    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260606    clang-23
um                    randconfig-001-20260606    gcc-11.5.0
um                    randconfig-002-20260606    gcc-11.5.0
um                    randconfig-002-20260606    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260606    gcc-14
x86_64      buildonly-randconfig-002-20260606    gcc-14
x86_64      buildonly-randconfig-003-20260606    gcc-14
x86_64      buildonly-randconfig-004-20260606    gcc-14
x86_64      buildonly-randconfig-005-20260606    gcc-14
x86_64      buildonly-randconfig-006-20260606    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260606    gcc-14
x86_64                randconfig-002-20260606    gcc-14
x86_64                randconfig-003-20260606    gcc-14
x86_64                randconfig-004-20260606    gcc-14
x86_64                randconfig-005-20260606    gcc-14
x86_64                randconfig-006-20260606    gcc-14
x86_64                randconfig-011-20260606    gcc-14
x86_64                randconfig-012-20260606    gcc-14
x86_64                randconfig-013-20260606    gcc-14
x86_64                randconfig-014-20260606    gcc-14
x86_64                randconfig-015-20260606    gcc-14
x86_64                randconfig-016-20260606    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260606    gcc-11.5.0
xtensa                randconfig-001-20260606    gcc-15.2.0
xtensa                randconfig-002-20260606    gcc-11.5.0
xtensa                randconfig-002-20260606    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
