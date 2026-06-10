Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ED5CD8CB2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 10 Jun 2026 07:02:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01C8940B58;
	Wed, 10 Jun 2026 07:02:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vHM1i3ppwbUp; Wed, 10 Jun 2026 07:02:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE07040B48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781074961;
	bh=ZrEGOFKAXi+QEeeM3/WNnKgmxS3Abs7FHvn5QcLVxWY=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KLcQ9+dSzKr4krWdE8Dsy8/lBcSfPmUD/lbYbORQ3gQFKGpq55Reby8r0D8AbVyMv
	 HSqV3T2s0vGcRllyN2SmYZxAx5G+x5vR0YmGCD0SkwscAhseInTGn3YEwBwaXLBJGO
	 TFIBhKd8jSRR0rIkc7yURUxa0EGbCcUCjy2TN0WyB6tbeEX7Mr2uk8kJ8+X9FZ/g1S
	 RxplkrMv1LFw17u2rcX63HH31JmFZmyCC/gBff3n7seCKAM6QLziB2aVZmjd39pFja
	 d968NCeAx73y7t74OUMbSTuwTyfULm6agwZMlDbaU+3kkqUS0C3NqvBBXgCozzk6t7
	 JkzSUxe8m0FRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE07040B48;
	Wed, 10 Jun 2026 07:02:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CB6C256
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Jun 2026 07:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EEBD81A5C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Jun 2026 07:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L69DdfJoCj1a for <intel-wired-lan@lists.osuosl.org>;
 Wed, 10 Jun 2026 07:02:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B50D881A5F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B50D881A5F
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B50D881A5F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Jun 2026 07:02:38 +0000 (UTC)
X-CSE-ConnectionGUID: SsDjbP8oS0yMdE8ls1aS6Q==
X-CSE-MsgGUID: HDa4+ufxSqm7ZiWI32DJKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81904251"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81904251"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 00:02:38 -0700
X-CSE-ConnectionGUID: L3G5i2rUST2+eE9LiGq8VQ==
X-CSE-MsgGUID: 1au4RtrnSWy0jzcItTs6Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="245944029"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
 by orviesa008.jf.intel.com with ESMTP; 10 Jun 2026 00:02:36 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wXCxN-00000000L2o-3AXH;
 Wed, 10 Jun 2026 07:02:33 +0000
Date: Wed, 10 Jun 2026 15:01:43 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202606101534.99TUvb1P-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781074959; x=1812610959;
 h=date:from:to:subject:message-id;
 bh=1vpcU2+faYIRcGgGVudH3R85vKLnXUVb+x0mr4qVmpQ=;
 b=KOJ6p0mCfKVMSd/7GWhjDObDH1glJsdPIwPCpTr0amc+NOP2S/c5YZcx
 qfFxMGPFI8QXb8WeM81rJQcbCOVbaSEk4lv+XJ804SXLNOFKnF2Xx9jHR
 A7IfdIO/UIaJ5IVEz7wql+aGf5c/F/wcxh9nuIxt8hNIQ6GcPPMdyXqat
 5b+ua6ra63aZ32YLXaWnSZQU1kG27chN/765Of6mrnT4seWg+yGX9bVRN
 QCX1RvnSvzn6SkxWq+/Vrq0HfJq8sIuxFzZGOS2WJ0ri8SKbU5gfhNnHX
 lw94qx+OWD0GFuCgpqLeYGi+/dyA05GUocZNYE13rH29713P7tSZg/98r
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KOJ6p0mC
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 f9701b60ad4bb29c832cf57801951ae5de0b8aa4
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
branch HEAD: f9701b60ad4bb29c832cf57801951ae5de0b8aa4  ice: fall back to SBQ when LL PHY timer interface times out

elapsed time: 815m

configs tested: 194
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260610    gcc-8.5.0
arc                   randconfig-002-20260610    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260610    gcc-8.5.0
arm                   randconfig-002-20260610    gcc-8.5.0
arm                   randconfig-003-20260610    gcc-8.5.0
arm                   randconfig-004-20260610    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260610    gcc-11.5.0
arm64                 randconfig-002-20260610    gcc-11.5.0
arm64                 randconfig-003-20260610    gcc-11.5.0
arm64                 randconfig-004-20260610    gcc-11.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260610    gcc-11.5.0
csky                  randconfig-002-20260610    gcc-11.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260610    clang-22
hexagon               randconfig-002-20260610    clang-22
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260610    gcc-14
i386        buildonly-randconfig-002-20260610    gcc-14
i386        buildonly-randconfig-003-20260610    gcc-14
i386        buildonly-randconfig-004-20260610    gcc-14
i386        buildonly-randconfig-005-20260610    gcc-14
i386        buildonly-randconfig-006-20260610    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260610    gcc-14
i386                  randconfig-002-20260610    gcc-14
i386                  randconfig-003-20260610    gcc-14
i386                  randconfig-004-20260610    gcc-14
i386                  randconfig-005-20260610    gcc-14
i386                  randconfig-006-20260610    gcc-14
i386                  randconfig-007-20260610    gcc-14
i386                  randconfig-011-20260610    gcc-14
i386                  randconfig-012-20260610    gcc-14
i386                  randconfig-013-20260610    gcc-14
i386                  randconfig-014-20260610    gcc-14
i386                  randconfig-015-20260610    gcc-14
i386                  randconfig-016-20260610    gcc-14
i386                  randconfig-017-20260610    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260610    clang-22
loongarch             randconfig-002-20260610    clang-22
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                       lemote2f_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260610    clang-22
nios2                 randconfig-002-20260610    clang-22
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-23
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260610    gcc-8.5.0
parisc                randconfig-002-20260610    gcc-8.5.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                      pasemi_defconfig    clang-23
powerpc               randconfig-001-20260610    gcc-8.5.0
powerpc               randconfig-002-20260610    gcc-8.5.0
powerpc64             randconfig-001-20260610    gcc-8.5.0
powerpc64             randconfig-002-20260610    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260610    gcc-16.1.0
riscv                 randconfig-002-20260610    gcc-16.1.0
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260610    gcc-16.1.0
s390                  randconfig-002-20260610    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-23
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260610    gcc-16.1.0
sh                    randconfig-002-20260610    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260610    gcc-14.3.0
sparc                 randconfig-002-20260610    gcc-14.3.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260610    gcc-14.3.0
sparc64               randconfig-002-20260610    gcc-14.3.0
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260610    gcc-14.3.0
um                    randconfig-002-20260610    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260610    gcc-14
x86_64      buildonly-randconfig-002-20260610    gcc-14
x86_64      buildonly-randconfig-003-20260610    gcc-14
x86_64      buildonly-randconfig-004-20260610    gcc-14
x86_64      buildonly-randconfig-005-20260610    gcc-14
x86_64      buildonly-randconfig-006-20260610    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260610    gcc-13
x86_64                randconfig-002-20260610    gcc-13
x86_64                randconfig-003-20260610    gcc-13
x86_64                randconfig-004-20260610    gcc-13
x86_64                randconfig-005-20260610    gcc-13
x86_64                randconfig-006-20260610    gcc-13
x86_64                randconfig-011-20260610    gcc-14
x86_64                randconfig-012-20260610    gcc-14
x86_64                randconfig-013-20260610    gcc-14
x86_64                randconfig-014-20260610    gcc-14
x86_64                randconfig-015-20260610    gcc-14
x86_64                randconfig-016-20260610    gcc-14
x86_64                randconfig-071-20260610    gcc-14
x86_64                randconfig-072-20260610    gcc-14
x86_64                randconfig-073-20260610    gcc-14
x86_64                randconfig-074-20260610    gcc-14
x86_64                randconfig-075-20260610    gcc-14
x86_64                randconfig-076-20260610    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260610    gcc-14.3.0
xtensa                randconfig-002-20260610    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
