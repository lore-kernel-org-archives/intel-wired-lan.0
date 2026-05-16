Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C125CD4F3C
	for <intel-wired-lan@archiver.kernel.org>; Sat, 16 May 2026 22:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4D4E4267C;
	Sat, 16 May 2026 22:48:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qIAprQ0n4gAq; Sat, 16 May 2026 22:48:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA636426A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778971689;
	bh=tsnu0mbWZxGjhoagDsiEgwyfo+neJAcdAayiSG7t9+s=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WSDtP11C8B9HQA+znZo0Phsd1je5GNTnnWxCkfRXy40wNL1jUBEGdeywnv8IhOsmO
	 NkK9FYzzqik4l0NbmCQsS3nvTPvODJ3KClPXKu6XR6u8V/7eey54V7uRMEurfHUCgn
	 /sWB++9mCpavWFq416Mo1LSxRj0WdGS6+Cy7ZffvWT6OvKogS3GBQRbcEiE8Ozii1h
	 piKdP58rijTdAONwEkzSEW2IV8YtIYg5VNYr3t5ix0QXDjCYTdHvUlyGN83BfgsPy9
	 fqZiZr75nW4DtQAvcqqLTum0OS/Hod3ReyLmCVhME98BprwbQUJkWmtLYSDhTbeqsQ
	 trddLamlA5GJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA636426A3;
	Sat, 16 May 2026 22:48:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E172E313
 for <intel-wired-lan@lists.osuosl.org>; Sat, 16 May 2026 22:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C70D3426A3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 16 May 2026 22:48:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N16vmSEWBjoZ for <intel-wired-lan@lists.osuosl.org>;
 Sat, 16 May 2026 22:48:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 955AA4267C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 955AA4267C
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 955AA4267C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 16 May 2026 22:48:07 +0000 (UTC)
X-CSE-ConnectionGUID: Vq7Y5V2JQ/ywxUOsd3EfqQ==
X-CSE-MsgGUID: qWyxuS1DRFyNvSFnCOIvjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="105338415"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; d="scan'208";a="105338415"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2026 15:48:06 -0700
X-CSE-ConnectionGUID: mZ6Tprl3T8C10uKtbKyIXQ==
X-CSE-MsgGUID: 3y5QlOvsQBaRK+qevEKq5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; d="scan'208";a="238167586"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
 by orviesa010.jf.intel.com with ESMTP; 16 May 2026 15:48:03 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wONnd-000000001Bi-1U7i;
 Sat, 16 May 2026 22:48:01 +0000
Date: Sun, 17 May 2026 06:47:06 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202605170656.6JSbYLOD-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778971687; x=1810507687;
 h=date:from:to:subject:message-id;
 bh=2wnqHdUGdRLoBIVcMvrADURzLlHI0iTHHRD4pGdnpjM=;
 b=fluhJ1coqoMXz3EWqiyiWnBeADez/lEROYcrp6kyb9h35gY2mFs7ap9Z
 PECraofgu6d8fMJd+cdOwnJHCvPfgzN6sC4AxINKaadqKhOVuIo2J27we
 pqL30DzqWFSdPFlfNbxtbUybqik6BvGRz7/k706Fw5GYP98w0Yzv55M49
 XYsR4cHKJKdevg2/VkFCWkAkKRXUGiSy+1esie7/Tq2fhTdiS0eze9k7Q
 Yf+5E/XbcKLLH2RQusRj7GjZNNrOiW22XtVwT4J9E9f7eDZlsQOb+5t9a
 bwajgfyYXD5dEmvAPvFyCQUe0+NrONxZDBxe4vfukbzIp/GyBMgl5COhQ
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fluhJ1co
Subject: [Intel-wired-lan] [tnguy-next-queue:200GbE] BUILD SUCCESS
 1872baadcce3825ee22e43abc1f870db27ea02a7
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 200GbE
branch HEAD: 1872baadcce3825ee22e43abc1f870db27ea02a7  ixd: add devlink support

elapsed time: 824m

configs tested: 350
configs skipped: 4

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
arc                   randconfig-001-20260516    gcc-8.5.0
arc                   randconfig-001-20260517    gcc-13.4.0
arc                   randconfig-002-20260516    gcc-8.5.0
arc                   randconfig-002-20260517    gcc-13.4.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                          pxa910_defconfig    gcc-15.2.0
arm                   randconfig-001-20260516    gcc-8.5.0
arm                   randconfig-001-20260517    gcc-13.4.0
arm                   randconfig-002-20260516    gcc-8.5.0
arm                   randconfig-002-20260517    gcc-13.4.0
arm                   randconfig-003-20260516    gcc-8.5.0
arm                   randconfig-003-20260517    gcc-13.4.0
arm                   randconfig-004-20260516    gcc-8.5.0
arm                   randconfig-004-20260517    gcc-13.4.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260516    clang-23
arm64                 randconfig-001-20260516    gcc-13.4.0
arm64                 randconfig-001-20260517    clang-23
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260516    clang-23
arm64                 randconfig-002-20260517    clang-23
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260516    clang-23
arm64                 randconfig-003-20260516    gcc-9.5.0
arm64                 randconfig-003-20260517    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260516    clang-23
arm64                 randconfig-004-20260517    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260516    clang-23
csky                  randconfig-001-20260516    gcc-15.2.0
csky                  randconfig-001-20260517    clang-23
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260516    clang-23
csky                  randconfig-002-20260516    gcc-10.5.0
csky                  randconfig-002-20260517    clang-23
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260516    gcc-11.5.0
hexagon               randconfig-001-20260517    gcc-9.5.0
hexagon               randconfig-002-20260516    gcc-11.5.0
hexagon               randconfig-002-20260517    gcc-9.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260516    clang-20
i386        buildonly-randconfig-001-20260517    gcc-14
i386        buildonly-randconfig-002-20260516    clang-20
i386        buildonly-randconfig-002-20260517    gcc-14
i386        buildonly-randconfig-003-20260516    clang-20
i386        buildonly-randconfig-003-20260517    gcc-14
i386        buildonly-randconfig-004-20260516    clang-20
i386        buildonly-randconfig-004-20260516    gcc-14
i386        buildonly-randconfig-004-20260517    gcc-14
i386        buildonly-randconfig-005-20260516    clang-20
i386        buildonly-randconfig-005-20260517    gcc-14
i386        buildonly-randconfig-006-20260516    clang-20
i386        buildonly-randconfig-006-20260517    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260516    clang-20
i386                  randconfig-001-20260517    gcc-14
i386                  randconfig-002-20260516    clang-20
i386                  randconfig-002-20260517    gcc-14
i386                  randconfig-003-20260516    clang-20
i386                  randconfig-003-20260517    gcc-14
i386                  randconfig-004-20260516    clang-20
i386                  randconfig-004-20260517    gcc-14
i386                  randconfig-005-20260516    clang-20
i386                  randconfig-005-20260517    gcc-14
i386                  randconfig-006-20260516    clang-20
i386                  randconfig-006-20260517    gcc-14
i386                  randconfig-007-20260516    clang-20
i386                  randconfig-007-20260517    gcc-14
i386                  randconfig-011-20260516    gcc-14
i386                  randconfig-012-20260516    gcc-14
i386                  randconfig-013-20260516    gcc-14
i386                  randconfig-014-20260516    gcc-14
i386                  randconfig-015-20260516    gcc-14
i386                  randconfig-016-20260516    gcc-14
i386                  randconfig-017-20260516    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260516    gcc-11.5.0
loongarch             randconfig-001-20260517    gcc-9.5.0
loongarch             randconfig-002-20260516    gcc-11.5.0
loongarch             randconfig-002-20260517    gcc-9.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260516    gcc-11.5.0
nios2                 randconfig-001-20260517    gcc-9.5.0
nios2                 randconfig-002-20260516    gcc-11.5.0
nios2                 randconfig-002-20260517    gcc-9.5.0
openrisc                         allmodconfig    clang-23
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
parisc                         randconfig-001    gcc-12.5.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260516    gcc-10.5.0
parisc                randconfig-001-20260516    gcc-12.5.0
parisc                randconfig-001-20260517    gcc-10.5.0
parisc                         randconfig-002    gcc-12.5.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260516    gcc-11.5.0
parisc                randconfig-002-20260516    gcc-12.5.0
parisc                randconfig-002-20260517    gcc-10.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       ebony_defconfig    clang-23
powerpc                      ppc44x_defconfig    clang-23
powerpc                        randconfig-001    gcc-12.5.0
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260516    clang-23
powerpc               randconfig-001-20260516    gcc-12.5.0
powerpc               randconfig-001-20260517    gcc-10.5.0
powerpc                        randconfig-002    gcc-10.5.0
powerpc                        randconfig-002    gcc-12.5.0
powerpc               randconfig-002-20260516    gcc-12.5.0
powerpc               randconfig-002-20260517    gcc-10.5.0
powerpc64                      randconfig-001    clang-17
powerpc64                      randconfig-001    gcc-12.5.0
powerpc64             randconfig-001-20260516    clang-17
powerpc64             randconfig-001-20260516    gcc-12.5.0
powerpc64             randconfig-001-20260517    gcc-10.5.0
powerpc64                      randconfig-002    clang-23
powerpc64                      randconfig-002    gcc-12.5.0
powerpc64             randconfig-002-20260516    clang-23
powerpc64             randconfig-002-20260516    gcc-12.5.0
powerpc64             randconfig-002-20260517    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    clang-23
riscv                          randconfig-001    gcc-15.2.0
riscv                          randconfig-001    gcc-8.5.0
riscv                 randconfig-001-20260516    gcc-15.2.0
riscv                 randconfig-001-20260516    gcc-8.5.0
riscv                 randconfig-001-20260517    gcc-10.5.0
riscv                          randconfig-002    clang-23
riscv                          randconfig-002    gcc-15.2.0
riscv                 randconfig-002-20260516    clang-16
riscv                 randconfig-002-20260516    gcc-15.2.0
riscv                 randconfig-002-20260517    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-11.5.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260516    clang-23
s390                  randconfig-001-20260516    gcc-15.2.0
s390                  randconfig-001-20260517    gcc-10.5.0
s390                           randconfig-002    clang-23
s390                           randconfig-002    gcc-15.2.0
s390                  randconfig-002-20260516    clang-23
s390                  randconfig-002-20260516    gcc-15.2.0
s390                  randconfig-002-20260517    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-15.2.0
sh                    randconfig-001-20260516    gcc-12.5.0
sh                    randconfig-001-20260516    gcc-15.2.0
sh                    randconfig-001-20260517    gcc-10.5.0
sh                             randconfig-002    gcc-14.3.0
sh                             randconfig-002    gcc-15.2.0
sh                    randconfig-002-20260516    gcc-15.2.0
sh                    randconfig-002-20260517    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260516    gcc-8.5.0
sparc                 randconfig-001-20260517    gcc-8.5.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260516    gcc-8.5.0
sparc                 randconfig-002-20260517    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260516    gcc-8.5.0
sparc64               randconfig-001-20260517    gcc-8.5.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260516    gcc-8.5.0
sparc64               randconfig-002-20260517    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260516    gcc-8.5.0
um                    randconfig-001-20260517    gcc-8.5.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260516    gcc-8.5.0
um                    randconfig-002-20260517    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260516    gcc-14
x86_64      buildonly-randconfig-001-20260517    gcc-14
x86_64      buildonly-randconfig-002-20260516    gcc-14
x86_64      buildonly-randconfig-002-20260517    gcc-14
x86_64      buildonly-randconfig-003-20260516    gcc-14
x86_64      buildonly-randconfig-003-20260517    gcc-14
x86_64      buildonly-randconfig-004-20260516    gcc-14
x86_64      buildonly-randconfig-004-20260517    gcc-14
x86_64      buildonly-randconfig-005-20260516    gcc-14
x86_64      buildonly-randconfig-005-20260517    gcc-14
x86_64      buildonly-randconfig-006-20260516    gcc-14
x86_64      buildonly-randconfig-006-20260517    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260516    gcc-14
x86_64                randconfig-001-20260517    clang-20
x86_64                randconfig-002-20260516    gcc-14
x86_64                randconfig-002-20260517    clang-20
x86_64                randconfig-003-20260516    gcc-14
x86_64                randconfig-003-20260517    clang-20
x86_64                randconfig-004-20260516    gcc-14
x86_64                randconfig-004-20260517    clang-20
x86_64                randconfig-005-20260516    gcc-14
x86_64                randconfig-005-20260517    clang-20
x86_64                randconfig-006-20260516    gcc-14
x86_64                randconfig-006-20260517    clang-20
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260516    clang-20
x86_64                randconfig-011-20260517    gcc-14
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260516    clang-20
x86_64                randconfig-012-20260517    gcc-14
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260516    clang-20
x86_64                randconfig-013-20260517    gcc-14
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260516    clang-20
x86_64                randconfig-014-20260517    gcc-14
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260516    clang-20
x86_64                randconfig-015-20260517    gcc-14
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260516    clang-20
x86_64                randconfig-016-20260517    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260516    gcc-14
x86_64                randconfig-071-20260517    clang-20
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260516    gcc-14
x86_64                randconfig-072-20260517    clang-20
x86_64                         randconfig-073    gcc-14
x86_64                randconfig-073-20260516    clang-20
x86_64                randconfig-073-20260516    gcc-14
x86_64                randconfig-073-20260517    clang-20
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260516    clang-20
x86_64                randconfig-074-20260516    gcc-14
x86_64                randconfig-074-20260517    clang-20
x86_64                         randconfig-075    gcc-14
x86_64                randconfig-075-20260516    gcc-14
x86_64                randconfig-075-20260517    clang-20
x86_64                         randconfig-076    gcc-14
x86_64                randconfig-076-20260516    clang-20
x86_64                randconfig-076-20260516    gcc-14
x86_64                randconfig-076-20260517    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260516    gcc-8.5.0
xtensa                randconfig-001-20260517    gcc-8.5.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260516    gcc-8.5.0
xtensa                randconfig-002-20260517    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
