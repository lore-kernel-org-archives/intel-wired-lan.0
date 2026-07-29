Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD80C54F51
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Jul 2026 12:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DF7F81165;
	Wed, 29 Jul 2026 12:21:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RTJuKrLnBVGu; Wed, 29 Jul 2026 12:21:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D10F81174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785327697;
	bh=SnTOilX4WjSJnn8GFLfri1a5zC8cV8CG/D39OEZ/fpg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=idJGS9mBn61yWDN+OefFVMZAXXswodaSAGa3uUeT0Jr5MMh1jaP5L7HBUQlc1lcsj
	 sfv60GBR9ZqIaW0KXbwgGkH144qCAgvRBVs1ihoON3UIx9y94FVifRMHeBClD8sWwv
	 Jk3qe/8sXAefraH9TYgdKj99jjAHd2lceg0Uqga82ZCX/DzuWmjxL02roZTCNhLnGc
	 atecZUwpqXs/5gWdczraO/xdSO1xkpN7uAeMCLR6pOc7MnHoEiJynl9Z4l1yv3RcnZ
	 tDttU8v0BNwDm6486jNRT8zpj8DiMM6aaUuMSnQ+Z9SmH/Pu6EXr4/s23/pN8BEDVZ
	 YvbFJhoyEWpWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D10F81174;
	Wed, 29 Jul 2026 12:21:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BEBD2194
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 12:21:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC08340B83
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 12:21:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MBCwPLK5uH5z for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Jul 2026 12:21:35 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org ACFC940B32
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACFC940B32
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACFC940B32
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 12:21:34 +0000 (UTC)
X-CSE-ConnectionGUID: xi/tw2xySoeZ/RewI9rj5g==
X-CSE-MsgGUID: Efq16W1pR7q3P3weNHhh/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85783740"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="85783740"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 05:21:35 -0700
X-CSE-ConnectionGUID: Wkzp/yPUROuy+gJOCVrnqg==
X-CSE-MsgGUID: f1a5D8nwTKOOfzADBZDhXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="263492444"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by orviesa003.jf.intel.com with ESMTP; 29 Jul 2026 05:21:33 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wp3Hu-00000000fLF-3dqq;
 Wed, 29 Jul 2026 12:21:30 +0000
Date: Wed, 29 Jul 2026 20:21:06 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607292042.qnzORLlf-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785327696; x=1816863696;
 h=date:from:to:subject:message-id;
 bh=OmQvbz0o17RiJSSrB28bCzsGqq4/TVGWGnPdFpqXDDg=;
 b=N2+MjsO/vFqsZFPSz3PxkkN/aSFZ1Y6QCWV0n17bffi1jU0J0V1rr+DN
 AREh/26wUYCrDxCrHOjeT0ykNxFi+pddiLkGfTaQHpDxQaIa4pd7ppa7d
 RqgaN8VQRc/m2Q0fGpeXcPlPyWcpoUvACoJn4qc/vhhAndrkeO84cfJAE
 GVg4rZ+sE+gdpIg2XwipPehlJa1Yl7b0tPcDjsIHY4SO90nn2O4FnJHpc
 GoJ0wC3MuTpqgiT9VmSw0v0/HWH29alsUHPgJCbUY0+YDFjU3fy42wPuc
 6icdbokeIAKIm1q5VutRRKCQ+ZRl40R7qyWr1mOkIp9SOsztUlwEvGiq/
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=N2+MjsO/
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 f49afff90964a0df43cffc3175380d614341be2f
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
branch HEAD: f49afff90964a0df43cffc3175380d614341be2f  ice: Fix "Unknown bps" during link events

elapsed time: 935m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260729    gcc-8.5.0
arc                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-001-20260729    gcc-8.5.0
arm                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-003-20260729    gcc-8.5.0
arm                  randconfig-004-20260729    gcc-8.5.0
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
i386       buildonly-randconfig-002-20260729    clang-22
i386       buildonly-randconfig-002-20260729    gcc-14
i386       buildonly-randconfig-003-20260729    gcc-14
i386       buildonly-randconfig-004-20260729    clang-22
i386       buildonly-randconfig-004-20260729    gcc-14
i386       buildonly-randconfig-005-20260729    clang-22
i386       buildonly-randconfig-005-20260729    gcc-14
i386       buildonly-randconfig-006-20260729    gcc-14
i386                 randconfig-001-20260729    clang-22
i386                 randconfig-001-20260729    gcc-14
i386                 randconfig-002-20260729    clang-22
i386                 randconfig-003-20260729    clang-22
i386                 randconfig-004-20260729    clang-22
i386                 randconfig-005-20260729    clang-22
i386                 randconfig-006-20260729    clang-22
i386                 randconfig-006-20260729    gcc-14
i386                 randconfig-007-20260729    clang-22
i386                 randconfig-011-20260729    gcc-14
i386                 randconfig-012-20260729    gcc-14
i386                 randconfig-013-20260729    gcc-14
i386                 randconfig-014-20260729    gcc-14
i386                 randconfig-015-20260729    gcc-14
i386                 randconfig-016-20260729    gcc-14
i386                 randconfig-017-20260729    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260729    gcc-9.5.0
loongarch            randconfig-002-20260729    gcc-9.5.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260729    gcc-9.5.0
nios2                randconfig-002-20260729    gcc-9.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260729    clang-24
parisc               randconfig-002-20260729    clang-24
powerpc              randconfig-001-20260729    clang-24
powerpc              randconfig-002-20260729    clang-24
powerpc64            randconfig-001-20260729    clang-24
powerpc64            randconfig-002-20260729    clang-24
riscv            nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                randconfig-001-20260729    gcc-15.2.0
riscv                randconfig-002-20260729    gcc-15.2.0
s390                 randconfig-001-20260729    gcc-15.2.0
s390                 randconfig-002-20260729    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260729    gcc-15.2.0
sh                   randconfig-002-20260729    gcc-15.2.0
sparc                randconfig-001-20260729    gcc-10.5.0
sparc                randconfig-002-20260729    gcc-10.5.0
sparc64              randconfig-001-20260729    gcc-10.5.0
sparc64              randconfig-002-20260729    gcc-10.5.0
um                   randconfig-001-20260729    gcc-10.5.0
um                   randconfig-002-20260729    gcc-10.5.0
x86_64     buildonly-randconfig-001-20260729    clang-22
x86_64     buildonly-randconfig-002-20260729    clang-22
x86_64     buildonly-randconfig-003-20260729    clang-22
x86_64     buildonly-randconfig-004-20260729    clang-22
x86_64     buildonly-randconfig-005-20260729    clang-22
x86_64     buildonly-randconfig-006-20260729    clang-22
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
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
x86_64               randconfig-071-20260729    gcc-12
x86_64               randconfig-072-20260729    gcc-12
x86_64               randconfig-073-20260729    gcc-12
x86_64               randconfig-074-20260729    gcc-12
x86_64               randconfig-075-20260729    gcc-12
x86_64               randconfig-076-20260729    gcc-12
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260729    gcc-10.5.0
xtensa               randconfig-002-20260729    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
