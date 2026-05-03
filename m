Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F124DFF886F
	for <intel-wired-lan@archiver.kernel.org>; Sun,  3 May 2026 07:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9588961212;
	Sun,  3 May 2026 07:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZZuFxkWPwgEf; Sun,  3 May 2026 07:08:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C1D0B611CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777792111;
	bh=fnzd1khiHLKNlYUnIKk2R/OBBXKHiJM9x11Zd+49HnE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sCKcBikO4WhTgSlrVGbYIxMs3Aye8SxXpTIgF3+2H3lqJ+5ZYErwdF25srJka7OlW
	 uknuZMOoPcYi05xTxQZLL3xL3LGaMuaEPW6IniT887Vj45v2MKnvxv1fYYQ/+CVcrA
	 V7xjIYkWeIIajgen7IQ5cBv73jawhM6ccp8kV69KimT3nZ6saNs3RFqC32uveMw83c
	 c9SwJggO2Abt33maM5tVxu/xTFvAwaqjXGCOmwdFoIZ+C+ItL/+NaW0k1JGnNesQXw
	 YG+9H6a1RdhCCD0TB3jpN8FMnG7/4DZBHAPJ5oCcaZ8xRR2orKEJyujRVHd5+ApMs/
	 7XGCSme2/J+jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1D0B611CB;
	Sun,  3 May 2026 07:08:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FF1E204
 for <intel-wired-lan@lists.osuosl.org>; Sun,  3 May 2026 07:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 812B6841C0
 for <intel-wired-lan@lists.osuosl.org>; Sun,  3 May 2026 07:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7RHXYMsED3hK for <intel-wired-lan@lists.osuosl.org>;
 Sun,  3 May 2026 07:08:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 65510841BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65510841BF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65510841BF
 for <intel-wired-lan@lists.osuosl.org>; Sun,  3 May 2026 07:08:27 +0000 (UTC)
X-CSE-ConnectionGUID: QVzAv3yoRyCMcL5Bv5dGTQ==
X-CSE-MsgGUID: CB1Q7OqbRwucdkPlESTLOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="82539752"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; d="scan'208";a="82539752"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2026 00:08:26 -0700
X-CSE-ConnectionGUID: 1yV1kxrMSZabPeTLjTx59Q==
X-CSE-MsgGUID: i8MtBknAQ/GfT4UWtrrlWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; d="scan'208";a="235488189"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
 by orviesa007.jf.intel.com with ESMTP; 03 May 2026 00:08:26 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wJQwB-000000002ID-0ROv;
 Sun, 03 May 2026 07:08:23 +0000
Date: Sun, 03 May 2026 15:07:49 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202605031541.YrCKmXXn-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777792108; x=1809328108;
 h=date:from:to:subject:message-id;
 bh=3ItGuwhBL9ojMuLG1/MkCMVZlrbuyKnBAg5ft7LXMuo=;
 b=NU/l/sRsxU2beCI70PmdEyAeLhp+yq0EFHTWCg2b0GvToJ0+kAxutjqw
 4uAgFSlAfmbbPxl3z3r7olQgO232hzaeatmcYrVHRF36P0YlnfKsV4d4y
 6EBQ5gkGMSvWzOnSSCiyBbz2/+Lymxyz2SHjf050xX9jOvPHdXjL+qoYk
 6XKhlY7LslHw2iY5OAu5d+sF2Mm30BA/PnIbBam1BLnL2vzyV3eB4Ao88
 /tulQezwzVHgR6SkMOBtMJedaoB/+WAEgkjLpmyAnA5FzrB/IXdRrIL5y
 a5KtQqlcPu8JfFsnoiITC1COIXC8+PohpMgjbedAjCaX6u36Nr7Xl1WQU
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NU/l/sRs
Subject: [Intel-wired-lan] [tnguy-next-queue:1GbE] BUILD SUCCESS
 26d3498d11d4db7795549d383c0160b1866f667b
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 1GbE
branch HEAD: 26d3498d11d4db7795549d383c0160b1866f667b  ice: dpll: Fix compilation warning

elapsed time: 6175m

configs tested: 83
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arc         randconfig-001-20260503    gcc-10.5.0
arc         randconfig-002-20260503    gcc-10.5.0
arm                     allnoconfig    clang-23
arm                     allnoconfig    gcc-15.2.0
arm                    allyesconfig    gcc-15.2.0
arm         randconfig-001-20260503    gcc-10.5.0
arm         randconfig-002-20260503    gcc-10.5.0
arm         randconfig-003-20260503    gcc-10.5.0
arm         randconfig-004-20260503    gcc-10.5.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
hexagon                 allnoconfig    gcc-15.2.0
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                    allnoconfig    gcc-15.2.0
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
loongarch               allnoconfig    gcc-15.2.0
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
m68k                multi_defconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    clang-23
nios2                   allnoconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    clang-23
openrisc                allnoconfig    gcc-15.2.0
parisc                  allnoconfig    clang-23
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
parisc      randconfig-001-20260503    gcc-15.2.0
parisc      randconfig-002-20260503    gcc-15.2.0
powerpc                 allnoconfig    clang-23
powerpc                 allnoconfig    gcc-15.2.0
powerpc     randconfig-001-20260503    gcc-15.2.0
powerpc     randconfig-002-20260503    gcc-15.2.0
powerpc64   randconfig-001-20260503    gcc-15.2.0
powerpc64   randconfig-002-20260503    gcc-15.2.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    clang-23
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sparc                   allnoconfig    clang-23
sparc                   allnoconfig    gcc-15.2.0
sparc64                allmodconfig    clang-23
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                  allnoconfig    clang-23
x86_64                 allyesconfig    clang-20
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    clang-23
xtensa                  allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
