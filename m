Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CF8C369CB
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Apr 2025 18:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 367A7412B0;
	Wed, 23 Apr 2025 18:56:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HlAMH_w7h8Yp; Wed, 23 Apr 2025 18:56:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BC69412AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1745434602;
	bh=w37fZFP7xD3xuAvd0RFgelKB19AIrWV5QC7Js/7W5UY=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TGVZKDhKfYcvUW77uP+OwAYnwYSEps5mYQ+h1liim+aczVzU+n+LKvrLwhKMlA6hE
	 ifm1KWLU85PAjevu8Ecjq/w1wtzObJWEa/NgsUblxshGMzVuoI4X5Go2ZuuhG/P50I
	 XxP2+MG/hynj4KQ+StDPSIyVks+g44BRGLuo25wxTJWdYxwk4iDtRavt3RrnNWVn51
	 QzpdQyqgSsePnxkPrmiC5+rH2DqrN4rWRVPdAkD5l3RPvHBZwNEhOz9cdZ2P3lSjZh
	 V6/mdz/GWbZjaSUOqZ4sb7/6j2nhnjshiwQYt+O/3s02M8RFHNtECC0ZqhAuuSxtGq
	 bb9269GUl0o+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BC69412AE;
	Wed, 23 Apr 2025 18:56:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B20EA1BC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Apr 2025 18:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A375D809EA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Apr 2025 18:56:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ekcSuitZ0IBU for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Apr 2025 18:56:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9F45B80883
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F45B80883
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F45B80883
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Apr 2025 18:56:39 +0000 (UTC)
X-CSE-ConnectionGUID: TdTikDtDTkSImRXkHJKOxA==
X-CSE-MsgGUID: jK8gP7wiRiOi72Qvj5FEFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="72427210"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="72427210"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 11:56:38 -0700
X-CSE-ConnectionGUID: 3DCN+zDvRYapi4ZCvoU3gw==
X-CSE-MsgGUID: uscHqkyhQYmBi3maETMVlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="132303881"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 23 Apr 2025 11:56:38 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1u7fGs-0003YT-37
 for intel-wired-lan@lists.osuosl.org; Wed, 23 Apr 2025 18:56:34 +0000
Date: Thu, 24 Apr 2025 02:56:19 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202504240210.M99r0Qbs-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745434599; x=1776970599;
 h=date:from:to:subject:message-id;
 bh=l9b340+LNhdwyJ9UPtszu3Ic6+a/32un+8GPZTnlbe8=;
 b=ek3iqZGkR2N54dP5oCzvffybGJPnEK6u8o0ACCO1xvo8yuq6+nsAjRrZ
 BJvxZcLYj1aJwOJjl2/U8dcmCQw2b/6kBWlJ5zDaC/CgRTZ25XnT+HfKe
 1twLxr+N3faFGBBN+fTqLuuuuuJr5feNIOX3qDWw4YxYSrdRej9uk15t4
 9XkIO2M6LgO6atsbh1mT5qIdVE9AzRjvlibbLr/aNE8HKxEpdRbM1dV4r
 BUowW4F7baOORtqw4UAViZt/7dCkualVoEkBPv8rZBmrGz3xyZkJI5qCG
 xdVHfz97LWZPtdRlaPd+glHYTPY91DJuRJC/z2n8NnfCANXU8lfPkvvoj
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ek3iqZGk
Subject: [Intel-wired-lan] [tnguy-net-queue:100GbE] BUILD SUCCESS
 1a9a4af9b14a6e84f5bf78cc17e9e8e447c8a73b
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 1a9a4af9b14a6e84f5bf78cc17e9e8e447c8a73b  idpf: fix offloads support for encapsulated packets

elapsed time: 1455m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250423    gcc-14.2.0
arc                   randconfig-002-20250423    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                   randconfig-002-20250423    gcc-10.5.0
arm                   randconfig-003-20250423    gcc-7.5.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250423    gcc-5.5.0
arm64                 randconfig-002-20250423    gcc-7.5.0
arm64                 randconfig-003-20250423    clang-17
arm64                 randconfig-004-20250423    gcc-7.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250423    gcc-13.3.0
csky                  randconfig-002-20250423    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250423    clang-21
hexagon               randconfig-002-20250423    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250423    gcc-12
i386        buildonly-randconfig-002-20250423    clang-20
i386        buildonly-randconfig-003-20250423    clang-20
i386        buildonly-randconfig-004-20250423    clang-20
i386        buildonly-randconfig-005-20250423    gcc-12
i386        buildonly-randconfig-006-20250423    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250423    gcc-14.2.0
loongarch             randconfig-002-20250423    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250423    gcc-11.5.0
nios2                 randconfig-002-20250423    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250423    gcc-12.4.0
parisc                randconfig-002-20250423    gcc-12.4.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250423    gcc-9.3.0
powerpc               randconfig-002-20250423    clang-21
powerpc               randconfig-003-20250423    gcc-9.3.0
powerpc64             randconfig-001-20250423    gcc-5.5.0
powerpc64             randconfig-002-20250423    gcc-7.5.0
powerpc64             randconfig-003-20250423    clang-18
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250423    gcc-9.3.0
riscv                 randconfig-002-20250423    gcc-7.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250423    clang-21
s390                  randconfig-002-20250423    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250423    gcc-7.5.0
sh                    randconfig-002-20250423    gcc-13.3.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250423    gcc-6.5.0
sparc                 randconfig-002-20250423    gcc-6.5.0
sparc64               randconfig-001-20250423    gcc-12.4.0
sparc64               randconfig-002-20250423    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250423    clang-21
um                    randconfig-002-20250423    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250423    gcc-12
x86_64      buildonly-randconfig-002-20250423    gcc-12
x86_64      buildonly-randconfig-003-20250423    gcc-12
x86_64      buildonly-randconfig-004-20250423    clang-20
x86_64      buildonly-randconfig-005-20250423    gcc-12
x86_64      buildonly-randconfig-006-20250423    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250423    gcc-8.5.0
xtensa                randconfig-002-20250423    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
