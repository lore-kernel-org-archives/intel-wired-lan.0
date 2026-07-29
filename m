Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E50C53200
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Jul 2026 03:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0879540A77;
	Wed, 29 Jul 2026 03:33:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6BsK9suQDww1; Wed, 29 Jul 2026 03:33:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C8EC240981
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785295990;
	bh=uCfxwMg7tw+BQqrbJbHJIMyYuDuMkLZkgIiHcKLguuo=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Kx3HCVMb6pNUQ3+x57Z4ZY1w6Q+yNS5Y67Tjs+NTvE2nECQxWAUaunTUK/bJgatAZ
	 EyBfsoDq0MeexZlJe2eXuBs7a2k/3NlRae1N03d4p09vBimZd7ZzXLPutRAzNSyUFz
	 dPEMCIbCG016d1neRBmYYtkKtGM3bzTAGWminarYQcFvBF32PSY3XIvpPAqQFZCJh6
	 WFc9yQmFqN8w+bU1Ezv4c6E9e5/AWIxnDVaHk97cCwCGa3Tyv4ojSRC4Mjt1dNTzGY
	 xD8JW+0yXwxfDYtS2uRJ5DxCMfhIqZ4HyWNgY6AuElKCPKnDPgoE/Ogr22Le2hcyKn
	 1BwSS15ggAAXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8EC240981;
	Wed, 29 Jul 2026 03:33:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 001E44BF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 03:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D252780FB4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 03:33:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FWfNkctB3W3k for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Jul 2026 03:33:09 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E0A4B80FB3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0A4B80FB3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E0A4B80FB3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 03:33:08 +0000 (UTC)
X-CSE-ConnectionGUID: Yt32W5o0RD6sLkQgJFkFfA==
X-CSE-MsgGUID: ojYnqgY+T8ua4xaN0J97Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86086315"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; d="scan'208";a="86086315"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 20:33:08 -0700
X-CSE-ConnectionGUID: 1HPq5slJR8+XG4hV36XGlw==
X-CSE-MsgGUID: xSC8/sNqRBa9SsBN71IsyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; d="scan'208";a="258106321"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by orviesa006.jf.intel.com with ESMTP; 28 Jul 2026 20:33:07 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wov2R-00000000f0V-0mzA;
 Wed, 29 Jul 2026 03:32:59 +0000
Date: Wed, 29 Jul 2026 11:32:31 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607291119.gBXiN1oz-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785295989; x=1816831989;
 h=date:from:to:subject:message-id;
 bh=fSYitj8XxKP7fZnHIr1hpRxfAk38rq6mzu78BR/7PT8=;
 b=QuR/2LrjAUvaPUdPwvEaTua0KmZwhI01ErjXgDeldVMeARM8nsGOOAYQ
 J16mjNRqOhdn24JLAZc3QqSoOiTusBCoPLPSAh+nNKM2dnZE//UK+i33C
 JDjAFkDK5Zo4/BV9tAbs6WyYctMxZ7K791s4WIbATW1yYbRYpj33oRNY8
 V9s8u2LHkIHEAyjsQx+grIpRgLnUJpww3r6wdCsp3TOlC23ftSFkQ1+im
 JGCJT6RXY+0rj70Zfd/FWyFy0/azWJISh6VUTpwG4qnIECZycBC95Nqw/
 c2/Q0Vl4zVgYJWD6VPMoshsEZyVisCU38Y8ghCRaPLuigZ/mGaa/kyyPz
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QuR/2Lrj
Subject: [Intel-wired-lan] [tnguy-next-queue:main] BUILD SUCCESS
 b515dc54795ef370be3cb396e7c12ad91686b6d1
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
branch HEAD: b515dc54795ef370be3cb396e7c12ad91686b6d1  net: ip6_tunnel: use tunnel parameters for fill_forward_path route lookup

elapsed time: 805m

configs tested: 68
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arm64                randconfig-001-20260729    clang-17
arm64                randconfig-002-20260729    clang-17
arm64                randconfig-003-20260729    clang-17
arm64                randconfig-004-20260729    clang-17
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260729    clang-17
csky                 randconfig-002-20260729    clang-17
hexagon              randconfig-001-20260729    gcc-9.5.0
hexagon              randconfig-002-20260729    gcc-9.5.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260729    gcc-14
i386       buildonly-randconfig-002-20260729    gcc-14
i386       buildonly-randconfig-003-20260729    gcc-14
i386       buildonly-randconfig-004-20260729    gcc-14
i386       buildonly-randconfig-005-20260729    gcc-14
i386       buildonly-randconfig-006-20260729    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260729    gcc-9.5.0
loongarch            randconfig-002-20260729    gcc-9.5.0
mips                       bcm63xx_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260729    gcc-9.5.0
nios2                randconfig-002-20260729    gcc-9.5.0
parisc                          alldefconfig    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260729    clang-24
parisc               randconfig-002-20260729    clang-24
powerpc                mpc8313_rdb_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260729    clang-24
powerpc              randconfig-002-20260729    clang-24
powerpc64            randconfig-001-20260729    clang-24
powerpc64            randconfig-002-20260729    clang-24
riscv                randconfig-001-20260729    gcc-15.2.0
riscv                randconfig-002-20260729    gcc-15.2.0
s390                 randconfig-001-20260729    gcc-15.2.0
s390                 randconfig-002-20260729    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260729    gcc-15.2.0
sh                   randconfig-002-20260729    gcc-15.2.0
sh                  sh7724_generic_defconfig    gcc-16.1.0
x86_64     buildonly-randconfig-001-20260729    clang-22
x86_64     buildonly-randconfig-002-20260729    clang-22
x86_64     buildonly-randconfig-003-20260729    clang-22
x86_64     buildonly-randconfig-004-20260729    clang-22
x86_64     buildonly-randconfig-005-20260729    clang-22
x86_64     buildonly-randconfig-006-20260729    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260729    clang-22
x86_64               randconfig-002-20260729    clang-22
x86_64               randconfig-003-20260729    clang-22
x86_64               randconfig-004-20260729    clang-22
x86_64               randconfig-005-20260729    clang-22
x86_64               randconfig-006-20260729    clang-22
x86_64               randconfig-011-20260729    gcc-14
x86_64               randconfig-012-20260729    gcc-14
x86_64               randconfig-013-20260729    gcc-14
x86_64               randconfig-014-20260729    gcc-14
x86_64               randconfig-015-20260729    gcc-14
x86_64               randconfig-016-20260729    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
