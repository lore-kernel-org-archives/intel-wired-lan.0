Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C62C55ABA
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 12:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B86B80B42;
	Wed,  5 Aug 2026 12:04:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zs4sVPDgmcvi; Wed,  5 Aug 2026 12:04:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F02F80981
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785931449;
	bh=KUsh2fMSDFAwP8MZ8IiqcMr5lflsUiW9nCssgVt6n0M=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uK71nfu9WPQL/nUVV64FiyJBMf7YO50vzK8GjGbVCl2WG7xeuJeTw+/j97P2RfLUt
	 3HleXlm8ClXS6xSCKhUkbKHNbSF3Oc+yejGL0x3jMklmzwO4di9sEzyguJgAU9sE/7
	 IzOKmAn8UYcqfw+8TcSYLc8wLC1kbYh6hQ+qZh2R9Q9A9s4Fd9xcL8X0WqNZ24lzzb
	 m5lfem0SUStQe0/siHls+HhAQNcjMpVxbK1BO9Tgc2WL22q3O/8lGS3OB2RSw6YN4D
	 uACVmjLYeLX9R60o6zN1CrfvwqOql/ksiPZCvgYdl55LuHHJBh/ZRGq3PbMi7yCt4p
	 7FwOhUhxC/ipA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F02F80981;
	Wed,  5 Aug 2026 12:04:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 759552DE
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 12:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6770D40067
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 12:04:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pNNsH-IL92xw for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 12:04:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 557A840061
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 557A840061
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 557A840061
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 12:04:06 +0000 (UTC)
X-CSE-ConnectionGUID: eebXZ4jgT7CHYi9d+0Pnew==
X-CSE-MsgGUID: 9UEATXhoTzObBExvpn+vcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86441936"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86441936"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 05:04:07 -0700
X-CSE-ConnectionGUID: GtmvAkBpTMmTUphh5zD63A==
X-CSE-MsgGUID: KmLI2hyRR86SA2oWTU43gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="266028063"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa005.jf.intel.com with ESMTP; 05 Aug 2026 05:04:06 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wraLr-00000000CNH-1MEH;
 Wed, 05 Aug 2026 12:04:03 +0000
Date: Wed, 05 Aug 2026 20:03:57 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608052043.W3SJfu7O-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785931448; x=1817467448;
 h=date:from:to:subject:message-id;
 bh=Wa42Tb8Bn7tMhy3BxXxTbqjKoJwBl7seJiUHJeRmxSs=;
 b=l6TUjkudsTWJ0/kb8Jbq/z7Hntl3+1ljt5Qsnc8yu77ZWzKvj34jeqZ6
 wcUWh4dBvDTCLEToSpnYSg8TjF3KJCe8tuZ140rCAAA5+tVsmwJPTf1N7
 X9EN96byVgix4s/NVEpSjE4qcyANMNKgo25XjEd9oRu44KnQV5b+cX6dj
 8pj58YJlfQBqEDLYN5qr5fNV6QLKRvg7RnQhne/4d7oIkvApuYh3vrfGt
 0u9+5KTL/dymOJregAkgeTrM7MlwsU9kJQLSc5w9fXmUqEYyuE/H6u9UG
 N9x9RjcQhwJlHJZ6dBYG/gbZdHI9TvNUzNliyaZV1ddq1xY3NZcnqssfd
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=l6TUjkud
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 ac509502705004df43a919e8532048743b3badec
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
branch HEAD: ac509502705004df43a919e8532048743b3badec  i40e: trigger PF reset when re-enabling ATR via ethtool

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 1533m

configs tested: 162
configs skipped: 2

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260805    gcc-12.5.0
arc                  randconfig-001-20260805    gcc-8.5.0
arc                  randconfig-002-20260805    gcc-12.5.0
arm                  randconfig-001-20260805    clang-24
arm                  randconfig-001-20260805    gcc-12.5.0
arm                  randconfig-002-20260805    clang-24
arm                  randconfig-002-20260805    gcc-12.5.0
arm                  randconfig-003-20260805    gcc-12.5.0
arm                  randconfig-003-20260805    gcc-16.1.0
arm                  randconfig-004-20260805    clang-24
arm                  randconfig-004-20260805    gcc-12.5.0
arm64                randconfig-001-20260805    clang-24
arm64                randconfig-001-20260805    gcc-10.5.0
arm64                randconfig-002-20260805    gcc-10.5.0
arm64                randconfig-002-20260805    gcc-8.5.0
arm64                randconfig-003-20260805    clang-24
arm64                randconfig-003-20260805    gcc-10.5.0
arm64                randconfig-004-20260805    clang-24
arm64                randconfig-004-20260805    gcc-10.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260805    gcc-10.5.0
csky                 randconfig-001-20260805    gcc-16.1.0
csky                 randconfig-002-20260805    gcc-10.5.0
hexagon                       randconfig-001    clang-17
hexagon              randconfig-001-20260804    clang-24
hexagon              randconfig-001-20260805    clang-18
hexagon              randconfig-002-20260804    clang-24
hexagon              randconfig-002-20260805    clang-18
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260805    clang-22
i386       buildonly-randconfig-002-20260805    clang-22
i386       buildonly-randconfig-003-20260805    clang-22
i386       buildonly-randconfig-004-20260805    clang-22
i386       buildonly-randconfig-004-20260805    gcc-14
i386       buildonly-randconfig-005-20260805    clang-22
i386       buildonly-randconfig-006-20260805    clang-22
i386                 randconfig-001-20260805    clang-22
i386                 randconfig-001-20260805    gcc-13
i386                 randconfig-002-20260805    clang-22
i386                 randconfig-002-20260805    gcc-13
i386                 randconfig-003-20260805    gcc-13
i386                 randconfig-003-20260805    gcc-14
i386                 randconfig-004-20260805    clang-22
i386                 randconfig-004-20260805    gcc-13
i386                 randconfig-005-20260805    gcc-13
i386                 randconfig-005-20260805    gcc-14
i386                 randconfig-006-20260805    gcc-13
i386                 randconfig-007-20260805    gcc-13
i386                 randconfig-007-20260805    gcc-14
i386                 randconfig-011-20260805    gcc-14
i386                 randconfig-012-20260805    gcc-14
i386                 randconfig-013-20260805    clang-22
i386                 randconfig-013-20260805    gcc-14
i386                 randconfig-014-20260805    clang-22
i386                 randconfig-014-20260805    gcc-14
i386                 randconfig-015-20260805    gcc-14
i386                 randconfig-016-20260805    gcc-14
i386                 randconfig-017-20260805    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260804    clang-24
loongarch            randconfig-001-20260805    clang-18
loongarch            randconfig-002-20260804    gcc-16.1.0
loongarch            randconfig-002-20260805    clang-18
mips                          jazz_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260804    gcc-8.5.0
nios2                randconfig-001-20260805    clang-18
nios2                randconfig-002-20260804    gcc-11.5.0
nios2                randconfig-002-20260805    clang-18
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260804    gcc-8.5.0
parisc               randconfig-001-20260805    gcc-9.5.0
parisc               randconfig-002-20260804    gcc-8.5.0
parisc               randconfig-002-20260805    gcc-9.5.0
powerpc              randconfig-001-20260804    clang-24
powerpc              randconfig-001-20260805    gcc-9.5.0
powerpc              randconfig-002-20260804    gcc-11.5.0
powerpc              randconfig-002-20260805    gcc-9.5.0
powerpc64            randconfig-001-20260804    gcc-8.5.0
powerpc64            randconfig-001-20260805    gcc-9.5.0
powerpc64            randconfig-002-20260804    gcc-8.5.0
powerpc64            randconfig-002-20260805    gcc-9.5.0
riscv                         randconfig-001    gcc-8.5.0
riscv                randconfig-001-20260805    gcc-8.5.0
riscv                randconfig-002-20260804    gcc-13.4.0
riscv                randconfig-002-20260805    gcc-8.5.0
s390                 randconfig-001-20260804    clang-21
s390                 randconfig-001-20260805    gcc-8.5.0
s390                 randconfig-002-20260804    clang-18
s390                 randconfig-002-20260805    gcc-8.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260804    gcc-16.1.0
sh                   randconfig-001-20260805    gcc-8.5.0
sh                   randconfig-002-20260804    gcc-16.1.0
sh                   randconfig-002-20260805    gcc-8.5.0
sh                          se7206_defconfig    gcc-16.1.0
sparc                         randconfig-001    gcc-16.1.0
sparc                randconfig-001-20260804    gcc-16.1.0
sparc                randconfig-001-20260805    gcc-11.5.0
sparc                randconfig-002-20260804    gcc-16.1.0
sparc                randconfig-002-20260805    gcc-11.5.0
sparc64              randconfig-001-20260804    clang-24
sparc64              randconfig-001-20260805    gcc-11.5.0
sparc64              randconfig-002-20260804    clang-20
sparc64              randconfig-002-20260805    gcc-11.5.0
um                   randconfig-001-20260804    gcc-14
um                   randconfig-001-20260805    gcc-11.5.0
um                   randconfig-002-20260804    gcc-14
um                   randconfig-002-20260805    gcc-11.5.0
x86_64     buildonly-randconfig-001-20260805    gcc-14
x86_64     buildonly-randconfig-002-20260805    clang-22
x86_64     buildonly-randconfig-002-20260805    gcc-14
x86_64     buildonly-randconfig-003-20260805    clang-22
x86_64     buildonly-randconfig-003-20260805    gcc-14
x86_64     buildonly-randconfig-004-20260805    gcc-13
x86_64     buildonly-randconfig-004-20260805    gcc-14
x86_64     buildonly-randconfig-005-20260805    gcc-14
x86_64     buildonly-randconfig-006-20260805    clang-22
x86_64     buildonly-randconfig-006-20260805    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260805    gcc-14
x86_64               randconfig-002-20260805    gcc-14
x86_64               randconfig-003-20260805    clang-22
x86_64               randconfig-003-20260805    gcc-14
x86_64               randconfig-004-20260805    gcc-14
x86_64               randconfig-005-20260805    gcc-14
x86_64               randconfig-006-20260805    gcc-14
x86_64               randconfig-011-20260805    gcc-14
x86_64               randconfig-012-20260805    gcc-14
x86_64               randconfig-013-20260805    gcc-14
x86_64               randconfig-014-20260805    clang-22
x86_64               randconfig-014-20260805    gcc-14
x86_64               randconfig-015-20260805    clang-22
x86_64               randconfig-015-20260805    gcc-14
x86_64               randconfig-016-20260805    clang-22
x86_64               randconfig-016-20260805    gcc-14
x86_64               randconfig-071-20260804    gcc-14
x86_64               randconfig-071-20260805    clang-22
x86_64               randconfig-072-20260804    gcc-14
x86_64               randconfig-072-20260805    clang-22
x86_64               randconfig-073-20260804    gcc-14
x86_64               randconfig-073-20260805    clang-22
x86_64               randconfig-074-20260804    gcc-12
x86_64               randconfig-074-20260805    clang-22
x86_64               randconfig-075-20260804    gcc-14
x86_64               randconfig-075-20260805    clang-22
x86_64               randconfig-076-20260804    clang-22
x86_64               randconfig-076-20260805    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260804    gcc-8.5.0
xtensa               randconfig-001-20260805    gcc-11.5.0
xtensa               randconfig-002-20260804    gcc-14.3.0
xtensa               randconfig-002-20260805    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
