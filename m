Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C373BC55ABF
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 22:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E7A180DCA;
	Wed,  5 Aug 2026 22:24:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KZZsGGZwM9DP; Wed,  5 Aug 2026 22:24:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34CE080DDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785968645;
	bh=QDIN/TjY4agnRCEJZQ0z0r+Y6lFI22nsuUW2i2fSlww=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ywm3nnMEjsSxCSFTJRnzAAnIoj9Q/DQYilSaajMcWIaBQbDk2CCXvin6BBYjEN1Ny
	 le6we1+PmujYhB2w1YbNfLUmBG+4ipiAHUkxmB+53NrVHU5Iz6ykKP8aNmk3C8v8WM
	 pcnovh/OrkIBfPxOOCrGllZh3tC4w24CQWm8Jn8FpuUtyG3VWRV7H8mT4s0DFzrRmR
	 3/hQIAAejS68WV1f/0hCrROeN5aEUABiHTlZVhXAZiFK0hlXAonIls9m97k0gpkPP9
	 4WjG6fX9jqF628+xfBOu7AfdSBx4x7xFEp/+cPtDxI9CEHRvaeAYUQzA317RG2kT8O
	 NQ9lsYs/Q1wmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34CE080DDF;
	Wed,  5 Aug 2026 22:24:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 126C8218
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 22:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED0C840816
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 22:24:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tfYN0C9ZUMo5 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 22:24:03 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D078740815
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D078740815
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D078740815
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 22:24:02 +0000 (UTC)
X-CSE-ConnectionGUID: MRXfhWkLQgSAiE3EhU8nWg==
X-CSE-MsgGUID: xp65CSMtTKKfYo4/9QdqUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86671729"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="86671729"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 15:24:01 -0700
X-CSE-ConnectionGUID: n8zjYiPpSO65i2rMjxPzIw==
X-CSE-MsgGUID: /uvO5Sq8Q0aUnTDamCla6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="261385322"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa008.jf.intel.com with ESMTP; 05 Aug 2026 15:24:01 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wrk1m-00000000DZe-31Cn;
 Wed, 05 Aug 2026 22:23:58 +0000
Date: Thu, 06 Aug 2026 06:23:29 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608060615.VcFL7KDR-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785968642; x=1817504642;
 h=date:from:to:subject:message-id;
 bh=RIkyhAM090b7p37dYlaWaGvNJ5kBYKHDEgz9ShSzY+M=;
 b=Wh96zxWwy6IurdJ+wlDcfFywzosYlg1R1SbUtjgrdETuQ948iMlL4f5x
 6kv49MYpIWRATSgvXGJ9jobmz41gz9r4mNSSFo24WtCWPQKrQ1UvlZnqb
 sv/nfQzYZ06GsYypwd+SY5RsM18KWn053zFSpvDimkJtSmXrl84IdYJlb
 K0UMiQd1e/XF3gpAsNECQWyO+pDSSZLAR7V11zCRXTtCUrTwg2P5kP8AY
 zgH9KHGyRFdENUDvYb31njKvrPxQe+r6FR71NpyKM9L1KJEhc7UUau4d5
 uJo9EIbdW5eh0C7rOd9sM38t0nrWSnjzYTZ1ceEDYUC+dHLk7pz8C8+66
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Wh96zxWw
Subject: [Intel-wired-lan] [tnguy-net-queue:main] BUILD SUCCESS
 a347304b2ca1a5377d5bd2d8a72e4b4f12afe648
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git main
branch HEAD: a347304b2ca1a5377d5bd2d8a72e4b4f12afe648  net/sched: cls_api: Always acquire rtnl_lock when destroying locked classifiers

elapsed time: 1891m

configs tested: 175
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-12.5.0
arc                  randconfig-001-20260805    gcc-12.5.0
arc                  randconfig-001-20260806    gcc-11.5.0
arc                  randconfig-002-20260805    gcc-12.5.0
arc                  randconfig-002-20260806    gcc-11.5.0
arm                      omap2plus_defconfig    gcc-16.1.0
arm                  randconfig-001-20260805    gcc-12.5.0
arm                  randconfig-001-20260806    gcc-11.5.0
arm                  randconfig-002-20260805    gcc-12.5.0
arm                  randconfig-002-20260806    gcc-11.5.0
arm                  randconfig-003-20260805    gcc-12.5.0
arm                  randconfig-003-20260806    gcc-11.5.0
arm                  randconfig-004-20260805    gcc-12.5.0
arm                  randconfig-004-20260806    gcc-11.5.0
arm64                         randconfig-001    gcc-10.5.0
arm64                randconfig-001-20260805    gcc-10.5.0
arm64                randconfig-001-20260806    gcc-13.4.0
arm64                randconfig-002-20260805    gcc-10.5.0
arm64                randconfig-002-20260806    gcc-13.4.0
arm64                randconfig-003-20260805    gcc-10.5.0
arm64                randconfig-003-20260806    gcc-13.4.0
arm64                randconfig-004-20260805    gcc-10.5.0
arm64                randconfig-004-20260806    gcc-13.4.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260805    gcc-10.5.0
csky                 randconfig-001-20260806    gcc-13.4.0
csky                 randconfig-002-20260805    gcc-10.5.0
csky                 randconfig-002-20260806    gcc-13.4.0
hexagon                       randconfig-001    clang-18
hexagon              randconfig-001-20260805    clang-17
hexagon              randconfig-001-20260805    clang-18
hexagon              randconfig-001-20260806    clang-24
hexagon              randconfig-002-20260805    clang-18
hexagon              randconfig-002-20260805    clang-19
hexagon              randconfig-002-20260806    clang-24
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386       buildonly-randconfig-001-20260805    clang-22
i386       buildonly-randconfig-002-20260805    clang-22
i386       buildonly-randconfig-003-20260805    clang-22
i386       buildonly-randconfig-004-20260805    clang-22
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
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260805    gcc-14
i386                 randconfig-011-20260806    clang-22
i386                 randconfig-012-20260805    gcc-14
i386                 randconfig-012-20260806    clang-22
i386                 randconfig-013-20260805    gcc-14
i386                 randconfig-013-20260806    clang-22
i386                 randconfig-014-20260805    gcc-14
i386                 randconfig-014-20260806    clang-22
i386                 randconfig-015-20260805    gcc-14
i386                 randconfig-015-20260806    clang-22
i386                 randconfig-016-20260805    gcc-14
i386                 randconfig-016-20260806    clang-22
i386                 randconfig-017-20260805    gcc-14
i386                 randconfig-017-20260806    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260805    clang-18
loongarch            randconfig-001-20260806    clang-24
loongarch            randconfig-002-20260805    clang-18
loongarch            randconfig-002-20260806    clang-24
mips                 cavium_octeon_defconfig    gcc-16.1.0
mips                          jazz_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260805    clang-18
nios2                randconfig-001-20260805    gcc-10.5.0
nios2                randconfig-001-20260806    clang-24
nios2                randconfig-002-20260805    clang-18
nios2                randconfig-002-20260805    gcc-11.5.0
nios2                randconfig-002-20260806    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-9.5.0
parisc               randconfig-001-20260805    gcc-9.5.0
parisc               randconfig-001-20260806    gcc-8.5.0
parisc               randconfig-002-20260805    gcc-9.5.0
parisc               randconfig-002-20260806    gcc-8.5.0
powerpc                    ppa8548_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260805    gcc-9.5.0
powerpc              randconfig-001-20260806    gcc-8.5.0
powerpc              randconfig-002-20260805    gcc-9.5.0
powerpc              randconfig-002-20260806    gcc-8.5.0
powerpc64            randconfig-001-20260805    gcc-9.5.0
powerpc64            randconfig-001-20260806    gcc-8.5.0
powerpc64            randconfig-002-20260805    gcc-9.5.0
powerpc64            randconfig-002-20260806    gcc-8.5.0
riscv                         randconfig-001    gcc-8.5.0
riscv                randconfig-001-20260805    gcc-8.5.0
riscv                randconfig-001-20260806    gcc-13.4.0
riscv                randconfig-002-20260805    gcc-8.5.0
riscv                randconfig-002-20260806    gcc-13.4.0
s390                 randconfig-001-20260805    gcc-8.5.0
s390                 randconfig-001-20260806    gcc-13.4.0
s390                 randconfig-002-20260805    gcc-8.5.0
s390                 randconfig-002-20260806    gcc-13.4.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260805    gcc-8.5.0
sh                   randconfig-001-20260806    gcc-13.4.0
sh                   randconfig-002-20260805    gcc-8.5.0
sh                   randconfig-002-20260806    gcc-13.4.0
sh                          se7705_defconfig    gcc-16.1.0
sh                  secureedge5410_defconfig    gcc-16.1.0
sparc                         randconfig-001    gcc-16.1.0
sparc                randconfig-001-20260805    gcc-11.5.0
sparc                randconfig-001-20260806    gcc-8.5.0
sparc                randconfig-002-20260805    gcc-11.5.0
sparc                randconfig-002-20260806    gcc-8.5.0
sparc64              randconfig-001-20260805    gcc-11.5.0
sparc64              randconfig-001-20260806    gcc-8.5.0
sparc64              randconfig-002-20260805    gcc-11.5.0
sparc64              randconfig-002-20260806    gcc-8.5.0
um                   randconfig-001-20260805    gcc-11.5.0
um                   randconfig-001-20260806    gcc-8.5.0
um                   randconfig-002-20260805    gcc-11.5.0
um                   randconfig-002-20260806    gcc-8.5.0
x86_64                          alldefconfig    gcc-14
x86_64              buildonly-randconfig-001    gcc-14
x86_64     buildonly-randconfig-001-20260805    gcc-14
x86_64     buildonly-randconfig-002-20260805    gcc-14
x86_64     buildonly-randconfig-003-20260805    gcc-14
x86_64     buildonly-randconfig-004-20260805    gcc-14
x86_64     buildonly-randconfig-005-20260805    gcc-14
x86_64     buildonly-randconfig-006-20260805    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260805    gcc-14
x86_64               randconfig-002-20260805    gcc-14
x86_64               randconfig-003-20260805    gcc-14
x86_64               randconfig-004-20260805    gcc-14
x86_64               randconfig-005-20260805    gcc-14
x86_64               randconfig-006-20260805    gcc-14
x86_64               randconfig-011-20260805    gcc-14
x86_64               randconfig-012-20260805    gcc-14
x86_64               randconfig-013-20260805    gcc-14
x86_64               randconfig-014-20260805    gcc-14
x86_64               randconfig-015-20260805    gcc-14
x86_64               randconfig-016-20260805    gcc-14
x86_64               randconfig-071-20260805    clang-22
x86_64               randconfig-071-20260806    gcc-14
x86_64               randconfig-072-20260805    clang-22
x86_64               randconfig-072-20260806    gcc-14
x86_64               randconfig-073-20260805    clang-22
x86_64               randconfig-073-20260806    gcc-14
x86_64               randconfig-074-20260805    clang-22
x86_64               randconfig-074-20260806    gcc-14
x86_64               randconfig-075-20260805    clang-22
x86_64               randconfig-075-20260806    gcc-14
x86_64               randconfig-076-20260805    clang-22
x86_64               randconfig-076-20260806    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260805    gcc-11.5.0
xtensa               randconfig-001-20260806    gcc-8.5.0
xtensa               randconfig-002-20260805    gcc-11.5.0
xtensa               randconfig-002-20260806    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
