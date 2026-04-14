Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E320EF9D0F6
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Apr 2026 20:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A11F16F516;
	Tue, 14 Apr 2026 20:01:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id atFBLG1wtH-0; Tue, 14 Apr 2026 20:01:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A73B16F51A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776196870;
	bh=Un86zJItXaQySJuIgW8g9ITnL1gligdGvbEn8NUjJlg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Fj3AtdVo9excYWpYYctCJrxpcedpVHi5No/R5It1/zm5DhUsKw4pEpu/T8x1Nhqo9
	 iyUkLuo5+mpdC5f1OLYvzgKmlqpfxGW7K7tvFuQFKBlzKgvtyl4cpe9A+/fW3uQ6tX
	 JhUjsPTz3IOFdglngpXrkhNlRT5RzlE1N0G27DcYjleJgd3x3D8eBdt+8+IWZeaog/
	 CZbQF/NVh/Jv+4e4zSAFktv01WTV5f03fQyntcW+KSIpXvzq2U75nXvy6UeV4TyjGf
	 qKwCnfQ6nR70nxGUaLvWR0PQAlT1jRjUxryanMu1116b9KSLad6dk5BHKGgk+IMLpK
	 yUV+KfTIFPVsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A73B16F51A;
	Tue, 14 Apr 2026 20:01:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 82707283
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 20:01:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 746206F51A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 20:01:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZL3oohhqfYN for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Apr 2026 20:01:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8237B6F517
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8237B6F517
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8237B6F517
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 20:01:08 +0000 (UTC)
X-CSE-ConnectionGUID: NVxRrERHS9y6C1Lr4jd31A==
X-CSE-MsgGUID: FoOtL0hNRPC+j8NvV/GDag==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="79753206"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="79753206"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2026 13:01:07 -0700
X-CSE-ConnectionGUID: yvq1/v+kQW+CYbX5uCReUA==
X-CSE-MsgGUID: J8qjCqSgTZed0Q7a58hk5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="230057089"
Received: from lkp-server01.sh.intel.com (HELO 7b0b59b3a0d4) ([10.239.97.150])
 by orviesa009.jf.intel.com with ESMTP; 14 Apr 2026 13:01:06 -0700
Received: from kbuild by 7b0b59b3a0d4 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wCjwV-000000001or-2UQX;
 Tue, 14 Apr 2026 20:01:03 +0000
Date: Wed, 15 Apr 2026 04:00:26 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202604150419.q1f6Ngd5-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776196868; x=1807732868;
 h=date:from:to:subject:message-id;
 bh=2y5Z/Mm7xhe9kflyJmqzAR+XO8GSuwBpk6ObBoivdoE=;
 b=nU9OQwgr2jR8IhhsNn3SzWoAa4B2rIW/9NmJ6fUROKsRTmWURHQl5++0
 VKuVCY0CVpY26ABLBcA120VjqEvvc5n4US9gtU9bUfBOlSgpWVPSzWQOo
 vgj09HOo2CZIm1zMTLBTA9lQcG/GjofcLqCjhDPfd+qcyjSSMqHs4HgVi
 TwNRHWSdUKrhHp54ov77GXW8GyIdXN5oqdmL65Dty3mo+E8QHJsZAIpQa
 VzzmzkO+NHBC0m1AZxWK4RUWtyZrh1qY09qCNl6TzU1QVbSFSzPfgYwok
 K76xcMV37fGICsJQDpl+wvO4tbevm4S+LWt1W579qSxtTJ5rFMW5djacP
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nU9OQwgr
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 406fd85acf6b161401b6f214e3620d3ddca5e681
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 406fd85acf6b161401b6f214e3620d3ddca5e681  e1000e: use ktime_get_real_ns() in e1000e_systim_reset()

elapsed time: 1140m

configs tested: 188
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260414    gcc-9.5.0
arc                   randconfig-002-20260414    gcc-9.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260414    gcc-9.5.0
arm                   randconfig-002-20260414    gcc-9.5.0
arm                   randconfig-003-20260414    gcc-9.5.0
arm                   randconfig-004-20260414    gcc-9.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260414    gcc-12.5.0
arm64                 randconfig-002-20260414    gcc-12.5.0
arm64                 randconfig-003-20260414    gcc-12.5.0
arm64                 randconfig-004-20260414    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260414    gcc-12.5.0
csky                  randconfig-002-20260414    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260414    clang-18
hexagon               randconfig-002-20260414    clang-18
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260414    gcc-14
i386        buildonly-randconfig-002-20260414    gcc-14
i386        buildonly-randconfig-003-20260414    gcc-14
i386        buildonly-randconfig-004-20260414    gcc-14
i386        buildonly-randconfig-005-20260414    gcc-14
i386        buildonly-randconfig-006-20260414    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260414    gcc-14
i386                  randconfig-002-20260414    gcc-14
i386                  randconfig-003-20260414    gcc-14
i386                  randconfig-004-20260414    gcc-14
i386                  randconfig-005-20260414    gcc-14
i386                  randconfig-006-20260414    gcc-14
i386                  randconfig-007-20260414    gcc-14
i386                  randconfig-011-20260414    gcc-14
i386                  randconfig-012-20260414    gcc-14
i386                  randconfig-013-20260414    gcc-14
i386                  randconfig-014-20260414    gcc-14
i386                  randconfig-015-20260414    gcc-14
i386                  randconfig-016-20260414    gcc-14
i386                  randconfig-017-20260414    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260414    clang-18
loongarch             randconfig-002-20260414    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260414    clang-18
nios2                 randconfig-002-20260414    clang-18
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260414    gcc-14.3.0
parisc                randconfig-002-20260414    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260414    gcc-14.3.0
powerpc               randconfig-002-20260414    gcc-14.3.0
powerpc64             randconfig-001-20260414    gcc-14.3.0
powerpc64             randconfig-002-20260414    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260414    gcc-8.5.0
riscv                 randconfig-002-20260414    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260414    gcc-8.5.0
s390                  randconfig-002-20260414    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260414    gcc-8.5.0
sh                    randconfig-002-20260414    gcc-8.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260414    gcc-12
sparc                 randconfig-002-20260414    gcc-12
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260414    gcc-12
sparc64               randconfig-002-20260414    gcc-12
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260414    gcc-12
um                    randconfig-002-20260414    gcc-12
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260414    gcc-14
x86_64      buildonly-randconfig-002-20260414    gcc-14
x86_64      buildonly-randconfig-003-20260414    gcc-14
x86_64      buildonly-randconfig-004-20260414    gcc-14
x86_64      buildonly-randconfig-005-20260414    gcc-14
x86_64      buildonly-randconfig-006-20260414    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260414    clang-20
x86_64                randconfig-002-20260414    clang-20
x86_64                randconfig-003-20260414    clang-20
x86_64                randconfig-004-20260414    clang-20
x86_64                randconfig-005-20260414    clang-20
x86_64                randconfig-006-20260414    clang-20
x86_64                randconfig-011-20260414    clang-20
x86_64                randconfig-012-20260414    clang-20
x86_64                randconfig-013-20260414    clang-20
x86_64                randconfig-014-20260414    clang-20
x86_64                randconfig-015-20260414    clang-20
x86_64                randconfig-016-20260414    clang-20
x86_64                randconfig-071-20260414    gcc-14
x86_64                randconfig-072-20260414    gcc-14
x86_64                randconfig-073-20260414    gcc-14
x86_64                randconfig-074-20260414    gcc-14
x86_64                randconfig-075-20260414    gcc-14
x86_64                randconfig-076-20260414    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260414    gcc-12
xtensa                randconfig-002-20260414    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
