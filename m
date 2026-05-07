Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DF2CD343F
	for <intel-wired-lan@archiver.kernel.org>; Thu,  7 May 2026 13:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90E6740E65;
	Thu,  7 May 2026 13:49:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 50CMYKQnzUKV; Thu,  7 May 2026 13:49:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACDB940E2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778161798;
	bh=6o8t6gn4hTNBaYQSLOnMYLKdbRjzuhZn9nMRz3/6zo8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FoFUZMfpEzL+SVG5CiT+UV1porIYYowls7qG4aC5kPxsu2hSLic1Qw1wYmqSAJdbY
	 8IKBTCRGKJU5gEW3XbillzjAv0V6TamsGa2lrIQro14GF+bQCcyzy29dRkWlLn9vqk
	 Yywq6WyJPZuLP5VVf6D1ftuw1vlfEauFOMOokYFqXSC6xcq9RXizT6V5S1X83NyyyA
	 LO+qreqGex2x4q+yEXgfgpMtbssCp3qXPoeRndCadly/42fTL0M6kHtsRJ+fzPLOYK
	 65HYHXRuR6kVA4ZHw23U4VYpQTjsEagPV5HRD7BFuBuLxMElSDQ/zzcOW+Sn2T4tzq
	 g4nI3XBQas5yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACDB940E2C;
	Thu,  7 May 2026 13:49:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F34B911B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 May 2026 13:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D91F8407BB
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 May 2026 13:49:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MxY2gpE-8Id5 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  7 May 2026 13:49:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E6146407B6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6146407B6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6146407B6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 May 2026 13:49:55 +0000 (UTC)
X-CSE-ConnectionGUID: ONsV7ATHQ4ud3zpShnYT3A==
X-CSE-MsgGUID: /VIABmWfRx+Op6fvDoGkyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="82981026"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="82981026"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 06:49:55 -0700
X-CSE-ConnectionGUID: hedQGN0DSmaZftWcB97cNA==
X-CSE-MsgGUID: OVkS4PEVTquhadEIfG4fxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="236575320"
Received: from lkp-server01.sh.intel.com (HELO d6e19f2f5857) ([10.239.97.150])
 by orviesa009.jf.intel.com with ESMTP; 07 May 2026 06:49:54 -0700
Received: from kbuild by d6e19f2f5857 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wKz6t-0000000006v-42DK;
 Thu, 07 May 2026 13:49:51 +0000
Date: Thu, 07 May 2026 21:49:28 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202605072121.xx8uE3Q6-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778161796; x=1809697796;
 h=date:from:to:subject:message-id;
 bh=fO+SFpQzAo1f+JA7ci7Z7+nMbpjLeMX3ie7h5tG7OU0=;
 b=b5WpMP/yo/v0BSvyjEKpdCKvxyrbNHVfp4DZQIV1E2rrXzbom+1OtQzO
 7WHJ8XE1j/zehPGwa3yWKCj+aKRJS4WkGPV+catDH4dAoTBrWyhQ3wDjG
 zS6XWer+0o4hBi45H9dTqg2bdOg32qnNzdUUlXenp1GsZkl6JJ4USaEM7
 DscIqpslvVmYIuqV3u4ufwl/nTIep0PPUIQtJnzG36XUqiC0nONS8FmCt
 eVc/X4fNwCXC+WrZ30sI7paCnwC7ugZ0ss1D3Y8qNm/RXNEgG3vCVbdWb
 ffv7AtjEiO/XkGGFa23H1/s3YbQESRXWbsi7imGliQrf2BrjXWIaeokF4
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=b5WpMP/y
Subject: [Intel-wired-lan] [tnguy-next-queue:1GbE] BUILD SUCCESS
 db77f100043053dd761cfe834fc727e8f5df4d21
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
branch HEAD: db77f100043053dd761cfe834fc727e8f5df4d21  ice: add support for unmanaged DPLL on E830 NIC

elapsed time: 728m

configs tested: 91
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
arm64       randconfig-004-20260507    gcc-8.5.0
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
csky        randconfig-001-20260507    gcc-15.2.0
csky        randconfig-002-20260507    gcc-15.2.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
hexagon     randconfig-001-20260507    clang-23
hexagon     randconfig-002-20260507    clang-23
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
i386        randconfig-001-20260507    gcc-13
i386        randconfig-002-20260507    clang-20
i386        randconfig-003-20260507    gcc-14
i386        randconfig-004-20260507    gcc-14
i386        randconfig-005-20260507    gcc-14
i386        randconfig-006-20260507    gcc-14
i386        randconfig-007-20260507    clang-20
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
loongarch   randconfig-001-20260507    clang-23
loongarch   randconfig-002-20260507    clang-23
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
m68k                      defconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
microblaze                defconfig    gcc-15.2.0
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
nios2                     defconfig    gcc-11.5.0
nios2       randconfig-001-20260507    gcc-9.5.0
nios2       randconfig-002-20260507    gcc-10.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    gcc-15.2.0
openrisc                  defconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
parisc                    defconfig    gcc-15.2.0
parisc64                  defconfig    gcc-15.2.0
powerpc           akebono_defconfig    clang-23
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
riscv                     defconfig    clang-23
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
s390                      defconfig    clang-23
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sh                        defconfig    gcc-15.2.0
sparc                   allnoconfig    gcc-15.2.0
sparc                     defconfig    gcc-15.2.0
sparc64                allmodconfig    clang-23
sparc64                   defconfig    clang-20
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
um                        defconfig    clang-23
um                   i386_defconfig    gcc-14
um                 x86_64_defconfig    clang-23
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64      randconfig-001-20260507    gcc-14
x86_64      randconfig-003-20260507    gcc-14
x86_64      randconfig-004-20260507    gcc-14
x86_64      randconfig-006-20260507    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0
xtensa                 allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
