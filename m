Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00B7C5AD44
	for <intel-wired-lan@archiver.kernel.org>; Sat,  8 Aug 2026 23:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 565F580D8F;
	Sat,  8 Aug 2026 23:02:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G-AKATbITRZ5; Sat,  8 Aug 2026 23:02:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D24DF80ADE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786230121;
	bh=QIsogZwXK/CouzehUd12UY+3Gm1dgHqB6edHpo+wVgo=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rVBNEUFK3j6PhujHjKiPLJkkd5bMSfp3bp9bmZGwuek/rj8x+nKD5NkAQm8jueqR2
	 rzLwkRc2FUwKxlpkQLCR0sWqzdhlkyAReiQh9MH+kaMvPEXBf+NEMlIYXjzbABEVTt
	 nliTpJ8kzh7EJyv1eKsLZPjvdQ2GkyEwY7pPTUHN5dNBU5A01wh8y0WIH1CcvLi8sM
	 jnW8DN25Y45mcL+ZTKQXR1dC8CdRzhyguZ7GENhN+5TSW76jpKyp1AghJkHJEOgGPZ
	 CSeVaX24Em3NBqEV2+CD4RCyecm5maJpJZL1DgttuUx2PzITFZvXHTD1YTH9K+QKgX
	 2AkyO2dsPnI1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D24DF80ADE;
	Sat,  8 Aug 2026 23:02:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CA38C282
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Aug 2026 23:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B06E34009F
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Aug 2026 23:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id htjCmC8NxIy8 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  8 Aug 2026 23:02:00 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BA4A04008D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA4A04008D
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA4A04008D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Aug 2026 23:01:59 +0000 (UTC)
X-CSE-ConnectionGUID: mhDfo3+fQ2K8w+4vIKYFcQ==
X-CSE-MsgGUID: EmNjuEU+Ra2Wyf89GLdxeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="97949656"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; d="scan'208";a="97949656"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2026 16:01:59 -0700
X-CSE-ConnectionGUID: KWRaVXZwQqyp6H56MBUykw==
X-CSE-MsgGUID: D3JnF5qHSYWAcRW8vVwwpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; d="scan'208";a="262182955"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa008.jf.intel.com with ESMTP; 08 Aug 2026 16:01:53 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wsq34-00000000KyA-2WOm;
 Sat, 08 Aug 2026 23:01:50 +0000
Date: Sun, 09 Aug 2026 07:01:34 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608090721.Tr6IJOtk-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786230120; x=1817766120;
 h=date:from:to:subject:message-id;
 bh=haumUUO8djy3/URNflJ2Fyo00ZINBz9BKR3m+lqtK88=;
 b=nfi65nKz5ODtS3u1Bqynon2/CCNsrY6uGVlJ+fW/luYyVcMyJbEt5VEP
 F+VkeJSup2WdHGMTKDGBUQQvxEqzgOdV+SMuTmlwSi9E3sfscQ0KdA2v6
 Be8kgyiZtGYqDpfXCE6fpFUAt9beci8OgYY/yci4eggOICIgPsSzTx10a
 Wt/69AX0TcerWUOheu0Rsze6mhqLpDcPyDbJgnKHB5i3MpxgbHHge4zou
 tPRGexyLo8cgJYh3CnyM6zT9Ejdx6YxS48lRFCFsQh5gLkQ8xmY9+Jo3X
 zBnAQ6KXSQJXvHzooAtEWfd8MOOAC14XjNOzlD1XkfHDQH/iVhJNGQXbw
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nfi65nKz
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 f64226c81f218523712836074480fb44f07c0a99
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
branch HEAD: f64226c81f218523712836074480fb44f07c0a99  ice: use per-interface clock_id for E825 generic DPLLs

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 1550m

configs tested: 80
configs skipped: 1

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260808    gcc-8.5.0
arc                  randconfig-002-20260808    gcc-9.5.0
arm                  randconfig-001-20260808    gcc-13.4.0
arm                  randconfig-002-20260808    gcc-8.5.0
arm                  randconfig-003-20260808    gcc-10.5.0
arm                  randconfig-004-20260808    clang-24
arm64                randconfig-001-20260809    gcc-10.5.0
arm64                randconfig-002-20260809    gcc-12.5.0
arm64                randconfig-003-20260809    clang-19
arm64                randconfig-004-20260809    clang-24
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260809    gcc-16.1.0
csky                 randconfig-002-20260809    gcc-14.3.0
hexagon              randconfig-001-20260809    clang-17
hexagon              randconfig-002-20260809    clang-17
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260809    clang-22
i386       buildonly-randconfig-002-20260809    clang-22
i386       buildonly-randconfig-003-20260809    clang-22
i386       buildonly-randconfig-004-20260809    gcc-14
i386       buildonly-randconfig-005-20260809    gcc-14
i386       buildonly-randconfig-006-20260809    clang-22
i386                 randconfig-011-20260809    gcc-14
i386                 randconfig-012-20260809    clang-22
i386                 randconfig-013-20260809    gcc-14
i386                 randconfig-014-20260809    gcc-14
i386                 randconfig-015-20260809    gcc-14
i386                 randconfig-016-20260809    clang-22
i386                 randconfig-017-20260809    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260809    clang-18
loongarch            randconfig-002-20260809    gcc-12.5.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260809    gcc-8.5.0
nios2                randconfig-002-20260809    gcc-8.5.0
openrisc        de0_nano_multicore_defconfig    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260809    gcc-15.2.0
parisc               randconfig-002-20260809    gcc-8.5.0
powerpc              randconfig-001-20260809    clang-24
powerpc              randconfig-002-20260809    clang-24
powerpc64            randconfig-001-20260809    clang-17
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-002-20260809    gcc-10.5.0
sparc                randconfig-001-20260809    gcc-8.5.0
sparc                randconfig-002-20260809    gcc-11.5.0
sparc64              randconfig-001-20260809    gcc-9.5.0
sparc64              randconfig-002-20260809    clang-24
um                   randconfig-001-20260809    clang-18
um                   randconfig-002-20260809    clang-17
x86_64     buildonly-randconfig-001-20260809    clang-22
x86_64     buildonly-randconfig-002-20260809    gcc-14
x86_64     buildonly-randconfig-003-20260809    gcc-14
x86_64     buildonly-randconfig-004-20260809    clang-22
x86_64     buildonly-randconfig-005-20260809    clang-22
x86_64     buildonly-randconfig-006-20260809    gcc-14
x86_64               randconfig-001-20260808    clang-22
x86_64               randconfig-002-20260808    gcc-14
x86_64               randconfig-003-20260808    gcc-14
x86_64               randconfig-004-20260808    clang-22
x86_64               randconfig-005-20260808    clang-22
x86_64               randconfig-006-20260808    clang-22
x86_64               randconfig-071-20260809    clang-22
x86_64               randconfig-072-20260809    clang-22
x86_64               randconfig-073-20260809    clang-22
x86_64               randconfig-074-20260809    clang-22
x86_64               randconfig-075-20260809    gcc-14
x86_64               randconfig-076-20260809    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260809    gcc-13.4.0
xtensa               randconfig-002-20260809    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
