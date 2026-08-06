Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137F1C56208
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 12:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6C1B60763;
	Thu,  6 Aug 2026 12:34:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UqhhdUu7NCWJ; Thu,  6 Aug 2026 12:34:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 389AA6072E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786019690;
	bh=jjiEMy/dDajW/q//+6RH/mT9kd96Oebwf37I/tcYn3U=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XGgfe8pTDj0SyXP1sbQIkGqwC6mlmv6XiNC5U+1XzwkGDFqRwB76md2+dLPWEi/69
	 VLbezptKqNNpCcvRWBb4LSObrjdYGLUIk0kBj7s6grDgxQn0mnrCvuK9y/Hvgm+2JE
	 rQLBRUHWSe73cK60kl+vD+H9ZnyTE7k3BNy5Fd4ClhepBUT79dnM+KxRpvkkKdtpmy
	 x+8cGtavZlWlh5mr+UgO1029zJQQpf58H+goKmximqGK2NPVY0XyDJIBgBNCEEIb4D
	 zPcS3FYGOseUp9wi6/KqyaB0ynXqi22JNKFj4q3qxuv2aYkSQ+HBle0Y6JA+1jtBKr
	 cI0WvLf9+JkZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 389AA6072E;
	Thu,  6 Aug 2026 12:34:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 32826218
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 12:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 18B4080DE7
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 12:34:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ygfIyOO5vxkP for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 12:34:46 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9DF7A80DE3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9DF7A80DE3
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9DF7A80DE3
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 12:34:46 +0000 (UTC)
X-CSE-ConnectionGUID: PekxRa88TdSbkJ5wQ7bAqQ==
X-CSE-MsgGUID: le9f0i03T+C3cVGcYBgF+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="104147453"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="104147453"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 05:34:46 -0700
X-CSE-ConnectionGUID: 24IwIbW6TQuZdHUInUWNqQ==
X-CSE-MsgGUID: eUpXHzFWSkWvosXej4eFWQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 06 Aug 2026 05:34:45 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wrxJ4-00000000F8R-30T8;
 Thu, 06 Aug 2026 12:34:42 +0000
Date: Thu, 06 Aug 2026 20:34:18 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608062007.PHMRriuw-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786019686; x=1817555686;
 h=date:from:to:subject:message-id;
 bh=2f9AE+br/acQKtEGW/1X6FFev8jd7K1j+FG4mtuj490=;
 b=ZFl9F7ByaZ/txZaxPEqfMVQkpfrhKWhxCwukpr1d2weSZkHa8s1Gaq8M
 BAt5mxMG9ib18WHsgE0JAKJajsmk9MMQVL5QTuZjuJT+I7wlAyMf+Gtz7
 iN9Ep5tKDJsRjD0SWu0EVolWRJzvFwkreuB6HFUnppdNpvk5tjlx5eglE
 p67nwB5q0UwHVdW1n4f4RfYFpm3cYnBB7eZAZbXUAOv36ZdG2suHSoscY
 FMMSRFQJ+/quaKJuZo5p3fGQphk8t2jrW7l+DXaN+anuN81HWoE39mhkf
 2xUqHDSQQa9yV0+34+pLDYlmPI2LmG4XGHb+JbHXRR2elQhD+ar4z4aBJ
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZFl9F7By
Subject: [Intel-wired-lan] [tnguy-next-queue:200GbE] BUILD SUCCESS
 e0a7f1ccc39a2e988fa8a0783b103451440c927d
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
branch HEAD: e0a7f1ccc39a2e988fa8a0783b103451440c927d  ixd: add devlink support

elapsed time: 3004m

configs tested: 114
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260805    gcc-8.5.0
arc                  randconfig-002-20260805    gcc-12.5.0
arc                       vdk_hs38_defconfig    gcc-16.1.0
arm                  randconfig-001-20260805    clang-24
arm                  randconfig-002-20260805    clang-24
arm                  randconfig-003-20260805    gcc-16.1.0
arm                  randconfig-004-20260805    clang-24
arm64                randconfig-001-20260805    clang-24
arm64                randconfig-002-20260805    gcc-8.5.0
arm64                randconfig-003-20260805    clang-24
arm64                randconfig-004-20260805    clang-24
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260805    gcc-16.1.0
csky                 randconfig-002-20260805    gcc-10.5.0
hexagon                       randconfig-001    clang-17
hexagon              randconfig-001-20260804    clang-24
hexagon              randconfig-002-20260804    clang-24
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260804    clang-22
i386       buildonly-randconfig-002-20260804    clang-22
i386       buildonly-randconfig-003-20260804    clang-22
i386       buildonly-randconfig-004-20260804    gcc-12
i386       buildonly-randconfig-005-20260804    clang-22
i386       buildonly-randconfig-006-20260804    gcc-14
i386                 randconfig-001-20260805    clang-22
i386                 randconfig-002-20260805    clang-22
i386                 randconfig-003-20260805    gcc-14
i386                 randconfig-004-20260805    clang-22
i386                 randconfig-005-20260805    gcc-14
i386                 randconfig-006-20260805    gcc-13
i386                 randconfig-007-20260805    gcc-14
i386                 randconfig-011-20260805    gcc-14
i386                 randconfig-012-20260805    gcc-14
i386                 randconfig-013-20260805    clang-22
i386                 randconfig-014-20260805    clang-22
i386                 randconfig-015-20260805    gcc-14
i386                 randconfig-016-20260805    gcc-14
i386                 randconfig-017-20260805    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260804    clang-24
loongarch            randconfig-002-20260804    gcc-16.1.0
m68k                      m5208evb_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260804    gcc-8.5.0
nios2                randconfig-002-20260804    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260805    gcc-8.5.0
parisc               randconfig-002-20260805    gcc-9.5.0
powerpc              randconfig-001-20260805    clang-22
powerpc              randconfig-002-20260805    clang-24
powerpc64            randconfig-001-20260805    gcc-8.5.0
powerpc64            randconfig-002-20260805    gcc-16.1.0
riscv                randconfig-001-20260805    gcc-8.5.0
riscv                randconfig-001-20260806    gcc-13.4.0
riscv                randconfig-002-20260805    clang-17
riscv                randconfig-002-20260806    gcc-13.4.0
s390                 randconfig-001-20260805    gcc-8.5.0
s390                 randconfig-001-20260806    gcc-13.4.0
s390                 randconfig-002-20260805    gcc-9.5.0
s390                 randconfig-002-20260806    gcc-13.4.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260805    gcc-16.1.0
sh                   randconfig-001-20260806    gcc-13.4.0
sh                   randconfig-002-20260805    gcc-14.3.0
sh                   randconfig-002-20260806    gcc-13.4.0
sparc                randconfig-001-20260805    gcc-16.1.0
sparc                randconfig-002-20260805    gcc-11.5.0
sparc64              randconfig-001-20260805    gcc-9.5.0
sparc64              randconfig-002-20260805    gcc-8.5.0
um                   randconfig-001-20260805    gcc-14
um                   randconfig-002-20260805    gcc-14
x86_64     buildonly-randconfig-001-20260805    gcc-14
x86_64     buildonly-randconfig-001-20260806    clang-22
x86_64     buildonly-randconfig-002-20260805    clang-22
x86_64     buildonly-randconfig-002-20260806    clang-22
x86_64     buildonly-randconfig-003-20260805    clang-22
x86_64     buildonly-randconfig-003-20260806    clang-22
x86_64     buildonly-randconfig-004-20260805    gcc-13
x86_64     buildonly-randconfig-004-20260806    clang-22
x86_64     buildonly-randconfig-005-20260805    gcc-14
x86_64     buildonly-randconfig-005-20260806    clang-22
x86_64     buildonly-randconfig-006-20260805    clang-22
x86_64     buildonly-randconfig-006-20260806    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260805    gcc-14
x86_64               randconfig-002-20260805    gcc-14
x86_64               randconfig-003-20260805    clang-22
x86_64               randconfig-004-20260805    gcc-14
x86_64               randconfig-005-20260805    gcc-14
x86_64               randconfig-006-20260805    gcc-14
x86_64               randconfig-011-20260805    gcc-14
x86_64               randconfig-012-20260805    gcc-14
x86_64               randconfig-013-20260805    gcc-14
x86_64               randconfig-014-20260805    clang-22
x86_64               randconfig-015-20260805    clang-22
x86_64               randconfig-016-20260805    clang-22
x86_64               randconfig-071-20260804    gcc-14
x86_64               randconfig-072-20260804    gcc-14
x86_64               randconfig-073-20260804    gcc-14
x86_64               randconfig-074-20260804    gcc-12
x86_64               randconfig-075-20260804    gcc-14
x86_64               randconfig-076-20260804    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260805    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
