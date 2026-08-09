Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322B8C5AC80
	for <intel-wired-lan@archiver.kernel.org>; Sun,  9 Aug 2026 03:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D071B80BA4;
	Sun,  9 Aug 2026 03:39:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fDO5NjqjSOB8; Sun,  9 Aug 2026 03:39:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E985D80B0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786246748;
	bh=esw15ef/KjMtzZ1+PI5daBaq/rBpEyYTeoFrMQQZJJM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ST52sSIRek2y8Tytz5Q90EZxfFQn6Rcc2O2TTApYfOt6Jq8i6Gh0asR3I5xaxzaTR
	 A8YRSUHQJkb9B5Q/weLxOounBnpkIcX78+ooLfHeSJtz0Un4puEaY8rw2qBxpTbfW5
	 5HOKz/hTiIrK+/ybzzdhm9tKUok3ouTVGkVIYokwHKnQrNlS1f6asHSCKKM01X2y6d
	 3tddrPG0+kXqa8btugmyuKob/nnmBqxc7wgTZaQ+sTsHF9Gta26dkrwEDgcjNrLAv5
	 8VZL3Z84kRXQGm5HX4LTKBD8fEQIH3/Y4I4evD5uYYRNgfl9h+R/mvcmcey+M8xlqs
	 TzSGnSB+icwVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E985D80B0F;
	Sun,  9 Aug 2026 03:39:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AE748282
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Aug 2026 03:39:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A08B9400C2
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Aug 2026 03:39:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SSDdUy9Ivmjm for <intel-wired-lan@lists.osuosl.org>;
 Sun,  9 Aug 2026 03:39:05 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 681D640051
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 681D640051
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 681D640051
 for <intel-wired-lan@lists.osuosl.org>; Sun,  9 Aug 2026 03:39:05 +0000 (UTC)
X-CSE-ConnectionGUID: Z9g86motQ6G6WCJ0PVCrtQ==
X-CSE-MsgGUID: BprtruweSESnRGiltS8u4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="109592421"
X-IronPort-AV: E=Sophos;i="6.25,213,1779174000"; d="scan'208";a="109592421"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2026 20:39:04 -0700
X-CSE-ConnectionGUID: h93/MtXSTs6oHz5ibD88Sw==
X-CSE-MsgGUID: LPQITVLlTn64cDZrBp5tsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,213,1779174000"; d="scan'208";a="258865919"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2026 20:39:03 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wsuNI-00000000LQ1-48gH;
 Sun, 09 Aug 2026 03:39:00 +0000
Date: Sun, 09 Aug 2026 11:38:22 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608091105.VazxegNE-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786246745; x=1817782745;
 h=date:from:to:subject:message-id;
 bh=51KvJ94CAK5gxgOQfVxqfGexp1hcaWJd1+1jj+7+Cuo=;
 b=I7f+/TEjg3TzUAZMm18ZwriGwsfM0eR693LsofS9ucrGiaFPxsTQQbMB
 jrgyYxJY1Vf1Qea/KuzXUEQpKoM2PlRnoTm9J2coLJDBIr1KWGAc/aLoZ
 Z1kfo/e5ufUzrF8znK1Shgll69VjN/GUcCetTX9c7qS6aIzNDYxGk52v3
 a8b5xvhvIRJ+Y1FvxUw1ijaObjNdkhZ1cq86t2BjDLve8blCuNJ5UgJ3W
 7H8UkRLXBPbEnFmrZb8UMxIQlUzfLoRHdDDd//KhAySTJ4H+hlZxg6WaA
 GwTZd0mql1ns+59wqazV15QT/Lrbxk7LzeCD/ek+0/sB5eGk34NBV2Wp2
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=I7f+/TEj
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 e4c6048cab22be157c089f5e618c80d8415d3373
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
branch HEAD: e4c6048cab22be157c089f5e618c80d8415d3373  ice: acquire NVM lock around each flash read

elapsed time: 1827m

configs tested: 142
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260808    gcc-9.5.0
arc                  randconfig-001-20260809    gcc-12.5.0
arc                  randconfig-002-20260808    gcc-9.5.0
arc                  randconfig-002-20260809    gcc-12.5.0
arm                  randconfig-001-20260808    gcc-9.5.0
arm                  randconfig-001-20260809    gcc-12.5.0
arm                  randconfig-002-20260808    gcc-9.5.0
arm                  randconfig-002-20260809    gcc-12.5.0
arm                  randconfig-003-20260808    gcc-9.5.0
arm                  randconfig-003-20260809    gcc-12.5.0
arm                  randconfig-004-20260808    gcc-9.5.0
arm                  randconfig-004-20260809    gcc-12.5.0
arm64                         randconfig-001    gcc-11.5.0
arm64                randconfig-001-20260808    gcc-11.5.0
arm64                randconfig-002-20260808    gcc-11.5.0
arm64                randconfig-003-20260808    gcc-11.5.0
arm64                randconfig-004-20260808    gcc-11.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260808    gcc-11.5.0
csky                 randconfig-002-20260808    gcc-11.5.0
hexagon              randconfig-001-20260808    gcc-16.1.0
hexagon              randconfig-001-20260809    gcc-12.5.0
hexagon              randconfig-002-20260808    gcc-16.1.0
hexagon              randconfig-002-20260809    gcc-12.5.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386       buildonly-randconfig-001-20260808    clang-22
i386       buildonly-randconfig-002-20260808    clang-22
i386       buildonly-randconfig-003-20260808    clang-22
i386       buildonly-randconfig-004-20260808    clang-22
i386       buildonly-randconfig-005-20260808    clang-22
i386       buildonly-randconfig-006-20260808    clang-22
i386                 randconfig-001-20260808    clang-22
i386                 randconfig-002-20260808    clang-22
i386                 randconfig-003-20260808    clang-22
i386                 randconfig-004-20260808    clang-22
i386                 randconfig-005-20260808    clang-22
i386                 randconfig-006-20260808    clang-22
i386                 randconfig-007-20260808    clang-22
i386                 randconfig-011-20260808    clang-22
i386                 randconfig-012-20260808    clang-22
i386                 randconfig-013-20260808    clang-22
i386                 randconfig-014-20260808    clang-22
i386                 randconfig-015-20260808    clang-22
i386                 randconfig-016-20260808    clang-22
i386                 randconfig-017-20260808    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260808    gcc-16.1.0
loongarch            randconfig-001-20260809    gcc-12.5.0
loongarch            randconfig-002-20260808    gcc-16.1.0
loongarch            randconfig-002-20260809    gcc-12.5.0
mips                          ip30_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260808    gcc-16.1.0
nios2                randconfig-001-20260809    gcc-12.5.0
nios2                randconfig-002-20260808    gcc-16.1.0
nios2                randconfig-002-20260809    gcc-12.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260808    gcc-8.5.0
parisc               randconfig-001-20260809    gcc-8.5.0
parisc               randconfig-002-20260808    gcc-8.5.0
parisc               randconfig-002-20260809    gcc-8.5.0
powerpc              randconfig-001-20260808    gcc-8.5.0
powerpc              randconfig-001-20260809    gcc-8.5.0
powerpc              randconfig-002-20260808    gcc-8.5.0
powerpc              randconfig-002-20260809    gcc-8.5.0
powerpc64            randconfig-001-20260808    gcc-8.5.0
powerpc64            randconfig-001-20260809    gcc-8.5.0
powerpc64            randconfig-002-20260808    gcc-8.5.0
powerpc64            randconfig-002-20260809    gcc-8.5.0
riscv                randconfig-001-20260808    clang-24
riscv                randconfig-002-20260808    clang-24
s390                 randconfig-001-20260808    clang-24
s390                 randconfig-002-20260808    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260808    clang-24
sh                   randconfig-002-20260808    clang-24
sparc                randconfig-001-20260808    gcc-8.5.0
sparc                randconfig-001-20260809    gcc-11.5.0
sparc                randconfig-002-20260808    gcc-8.5.0
sparc                randconfig-002-20260809    gcc-11.5.0
sparc64              randconfig-001-20260808    gcc-8.5.0
sparc64              randconfig-001-20260809    gcc-11.5.0
sparc64              randconfig-002-20260808    gcc-8.5.0
sparc64              randconfig-002-20260809    gcc-11.5.0
um                   randconfig-001-20260808    gcc-8.5.0
um                   randconfig-001-20260809    gcc-11.5.0
um                   randconfig-002-20260808    gcc-8.5.0
um                   randconfig-002-20260809    gcc-11.5.0
x86_64     buildonly-randconfig-001-20260808    gcc-14
x86_64     buildonly-randconfig-001-20260809    clang-22
x86_64     buildonly-randconfig-002-20260808    gcc-14
x86_64     buildonly-randconfig-002-20260809    clang-22
x86_64     buildonly-randconfig-003-20260808    gcc-14
x86_64     buildonly-randconfig-003-20260809    clang-22
x86_64     buildonly-randconfig-004-20260808    gcc-14
x86_64     buildonly-randconfig-004-20260809    clang-22
x86_64     buildonly-randconfig-005-20260808    gcc-14
x86_64     buildonly-randconfig-005-20260809    clang-22
x86_64     buildonly-randconfig-006-20260808    gcc-14
x86_64     buildonly-randconfig-006-20260809    clang-22
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
x86_64               randconfig-001-20260808    clang-22
x86_64               randconfig-002-20260808    clang-22
x86_64               randconfig-003-20260808    clang-22
x86_64               randconfig-004-20260808    clang-22
x86_64               randconfig-005-20260808    clang-22
x86_64               randconfig-006-20260808    clang-22
x86_64               randconfig-011-20260808    clang-22
x86_64               randconfig-011-20260809    gcc-14
x86_64               randconfig-012-20260808    clang-22
x86_64               randconfig-012-20260809    gcc-14
x86_64               randconfig-013-20260808    clang-22
x86_64               randconfig-013-20260809    gcc-14
x86_64               randconfig-014-20260808    clang-22
x86_64               randconfig-014-20260809    gcc-14
x86_64               randconfig-015-20260808    clang-22
x86_64               randconfig-015-20260809    gcc-14
x86_64               randconfig-016-20260808    clang-22
x86_64               randconfig-016-20260809    gcc-14
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260808    gcc-14
x86_64               randconfig-072-20260808    gcc-14
x86_64               randconfig-073-20260808    gcc-14
x86_64               randconfig-074-20260808    gcc-14
x86_64               randconfig-075-20260808    gcc-14
x86_64               randconfig-076-20260808    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa                 nommu_kc705_defconfig    gcc-16.1.0
xtensa               randconfig-001-20260808    gcc-8.5.0
xtensa               randconfig-001-20260809    gcc-11.5.0
xtensa               randconfig-002-20260808    gcc-8.5.0
xtensa               randconfig-002-20260809    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
