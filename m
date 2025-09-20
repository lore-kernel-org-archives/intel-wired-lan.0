Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191B8CAC5A7
	for <intel-wired-lan@archiver.kernel.org>; Sat, 20 Sep 2025 18:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD71241694;
	Sat, 20 Sep 2025 18:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FzvCGlnIvpI0; Sat, 20 Sep 2025 18:12:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C345F41696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1758391958;
	bh=Bw1WwkufGDIS5rB7ECyD1XZFflXQO4XIHV1kvWkPl1k=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WRo9lN9Gpiqh/22pr/X2MGMEIeiXtdwO1RuY4AokVGCUIiasfGKrERmFrBX2Xukn1
	 /BYNDdfwtAxL1TF3VOutMASWwa6fJXM2AfWCU/tXMwV+gyT+C8dLJPL2Y02PFojQfe
	 bmB4DCx3uXgYyyIcxT4xZJ747/F5oXjJxWYATmlXJCWFVxV80bfsV3FulNu+Vese+c
	 jHn71TkviqV+J8fiRy6IvcQQL5/kJRUW7j6s8tObzdQIans8sOdQqRwe6J+UNHKcAl
	 BFOW+Zzbg6psRFyl2PIsQbrWLOF06Ez3foJ84eCkmXDtIuUmoGgFEoXSYbR7l5q6kx
	 JKzXCkmcWXn8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C345F41696;
	Sat, 20 Sep 2025 18:12:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AA710D7F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 20 Sep 2025 18:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 90C6B61621
 for <intel-wired-lan@lists.osuosl.org>; Sat, 20 Sep 2025 18:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W2kXdi1UVzyD for <intel-wired-lan@lists.osuosl.org>;
 Sat, 20 Sep 2025 18:12:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AFAD461622
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AFAD461622
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AFAD461622
 for <intel-wired-lan@lists.osuosl.org>; Sat, 20 Sep 2025 18:12:35 +0000 (UTC)
X-CSE-ConnectionGUID: w6Xsyc+YT464Gfe3HZrHsw==
X-CSE-MsgGUID: 9PFZztKDRr6pYLaSHmX9Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="64350287"
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="64350287"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2025 11:12:34 -0700
X-CSE-ConnectionGUID: LgSDV3jTRaeQX9FGJQeLWw==
X-CSE-MsgGUID: nLsnLJ6lRMuBD4ylSZ2Jlw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 20 Sep 2025 11:12:33 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1v024V-0005ek-04
 for intel-wired-lan@lists.osuosl.org; Sat, 20 Sep 2025 18:12:31 +0000
Date: Sun, 21 Sep 2025 02:12:15 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202509210208.EyE2B5D2-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758391955; x=1789927955;
 h=date:from:to:subject:message-id;
 bh=CNphpU8ePbL7RPmJXiG2WZclOTmDFcytGUMJEKouekw=;
 b=CwpyWJ8VBlMcbi3zA6N4KBaJADcFYwkCAh/rr+k3cl78gLnISV3n/5xr
 +DWcv1yMlkwR64gca02kVikJsAfCN+mIQn76BzGHoMTXBOEtkGHYXhgaE
 gkt61n0jMZ6Aoy6fF+3NIfwrLCxeAXY7Y1FJhdUIGRE/3XHBs7RjiRZm5
 7e3pv0+Phn5exiytBhkSCfdu03GrhLMsrz08ZTppHXysZloVGFo18FZMA
 CDiKE4XcWzqV7NC0aA52qBFw/sELdnDflDFi3XFaQc4xx0A2ZJD9n3aYN
 qd0P8LLquTnvyq9TQ9enahx8GZiTrFEdZwA+cIWDJJxWReKeHoajhlA5/
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CwpyWJ8V
Subject: [Intel-wired-lan] [tnguy-next-queue:200GbE] BUILD SUCCESS
 1f09c2e6cd552b0b888afdd2884f46a28668db64
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
branch HEAD: 1f09c2e6cd552b0b888afdd2884f46a28668db64  idpf: enable XSk features and ndo_xsk_wakeup

elapsed time: 1508m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250920    gcc-9.5.0
arc                   randconfig-002-20250920    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                         mv78xx0_defconfig    clang-19
arm                   randconfig-001-20250920    gcc-12.5.0
arm                   randconfig-002-20250920    clang-22
arm                   randconfig-003-20250920    clang-22
arm                   randconfig-004-20250920    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250920    clang-20
arm64                 randconfig-002-20250920    clang-22
arm64                 randconfig-003-20250920    clang-18
arm64                 randconfig-004-20250920    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250920    gcc-10.5.0
csky                  randconfig-002-20250920    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250920    clang-22
hexagon               randconfig-002-20250920    clang-22
i386        buildonly-randconfig-001-20250920    clang-20
i386        buildonly-randconfig-002-20250920    clang-20
i386        buildonly-randconfig-003-20250920    clang-20
i386        buildonly-randconfig-004-20250920    gcc-13
i386        buildonly-randconfig-005-20250920    clang-20
i386        buildonly-randconfig-006-20250920    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250920    clang-22
loongarch             randconfig-002-20250920    gcc-12.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                         10m50_defconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250920    gcc-9.5.0
nios2                 randconfig-002-20250920    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250920    gcc-8.5.0
parisc                randconfig-002-20250920    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                 mpc837x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250920    clang-17
powerpc               randconfig-002-20250920    clang-22
powerpc               randconfig-003-20250920    clang-22
powerpc                     stx_gp3_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250920    clang-16
powerpc64             randconfig-002-20250920    gcc-10.5.0
powerpc64             randconfig-003-20250920    gcc-10.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250920    clang-22
riscv                 randconfig-002-20250920    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250920    clang-20
s390                  randconfig-002-20250920    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250920    gcc-14.3.0
sh                    randconfig-002-20250920    gcc-12.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250920    gcc-8.5.0
sparc                 randconfig-002-20250920    gcc-14.3.0
sparc64               randconfig-001-20250920    gcc-8.5.0
sparc64               randconfig-002-20250920    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250920    clang-22
um                    randconfig-002-20250920    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250920    clang-20
x86_64      buildonly-randconfig-002-20250920    clang-20
x86_64      buildonly-randconfig-003-20250920    clang-20
x86_64      buildonly-randconfig-004-20250920    clang-20
x86_64      buildonly-randconfig-005-20250920    gcc-14
x86_64      buildonly-randconfig-006-20250920    gcc-14
x86_64                              defconfig    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250920    gcc-8.5.0
xtensa                randconfig-002-20250920    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
