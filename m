Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91FBC5DF82
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Aug 2026 06:30:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C00E40292;
	Thu, 20 Aug 2026 06:30:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZjCY3JkhitPY; Thu, 20 Aug 2026 06:30:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787207415;
	bh=ZqJDYEqV30WFu+sJw3rwap1PsZuN60F4uhHyghDm3U8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HoYEUMOcoTeoBi1q8jq2qvOI5aB4N58+c5ZlRlThNViDCCMam4jA3c6YYWW62XN+l
	 u45T0ncrq8HV/VgJwVj1r1Tq9X2N5FphZhRqZcwVqLPZK0xqjn2QB2iTIyZese8yk/
	 P5aMGIx06S0+2eADO/wfIXkENaSlE7BlqVzi0ZKKxBq/vDSho8o/yQmjsaQmjU3hAv
	 3gvPVTrdHyI1FZ7+njwyWNjwRq7uPzLW+A9oOA3FXj85CucoJ/3+oypkSqTkGyP1fH
	 lowEDLPRwSiJ4s5N6Hxjm2xSExs5I03C3BFIqjDWEBvPXcCIVhCyKLb00ux98Z406Q
	 inOx6BQmQSjmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D01440208;
	Thu, 20 Aug 2026 06:30:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D07AE2FD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 06:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDFB360675
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 06:30:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IAXHXR2nQHZK for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Aug 2026 06:30:11 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PGWkZqy8
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B737760671
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 06:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787207412; x=1818743412; h=date:from:to:subject:message-id;
 bh=YbixH+B7k4I9qy0m7cUK+33SPxHkYGPptZX8IyK1GTw=;
 b=PGWkZqy8lEd3FfZwjlIsT2sfRFkdtwdtoicnOkbXoEeYiXEyplpM1s7C
 YwPwTanUxKwTh+YRSBtypz8R5BRfS5ViAR+9edeqaBtnQYRMejVgg4TvO
 7ZGqkeru4lFU6EO4dYPLUEJiM4co7FDmp05X6c6rK9hMByIpVHpqFuSgX
 r940K+aMroMD2Y8uVp9+s+SIiTg0xLjqZMbxTwO2KRfHiYOp9+BRGuFsY
 giYA7WImuKDp+vuQIKoxpwkf5QStI3WHum87hNOeZvyl5CRTb6z1+cJFe
 2jD6b7/w9kC6IRvIk6rBjX+sAhBnGWx9+rrVY5AQHO6h+JOfnDvth9pf8 w==;
X-CSE-ConnectionGUID: uQL9PMEJR8uvh+L6O3MTZw==
X-CSE-MsgGUID: hdAiQER7R3Cof6H7E5cz7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="91607395"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="91607395"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 23:30:11 -0700
X-CSE-ConnectionGUID: DC6jFxa6SiiY/EhPHLLVeQ==
X-CSE-MsgGUID: tXQvIL4pTIeHcZa3SJCwFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="290677157"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2026 23:30:09 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wwwHv-00000000i6J-0c9T;
 Thu, 20 Aug 2026 06:30:07 +0000
Date: Thu, 20 Aug 2026 14:29:53 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:10GbE] BUILD SUCCESS
 25b00c01fe1062ef1f2aaa3c4ee6638ec9beb239
Message-ID: <202608201441.u5LbCEc3-lkp@intel.com>
User-Agent: s-nail v14.9.25
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
branch HEAD: 25b00c01fe1062ef1f2aaa3c4ee6638ec9beb239  Merge branch 'net-dsa-mt7628-embedded-switch-initial-support'

elapsed time: 1921m

configs tested: 174
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260819    gcc-11.5.0
arc                  randconfig-001-20260820    clang-24
arc                  randconfig-002-20260819    gcc-11.5.0
arc                  randconfig-002-20260819    gcc-13.4.0
arc                  randconfig-002-20260820    clang-24
arm                  randconfig-001-20260819    gcc-11.5.0
arm                  randconfig-001-20260819    gcc-13.4.0
arm                  randconfig-001-20260820    clang-24
arm                  randconfig-002-20260819    gcc-11.5.0
arm                  randconfig-002-20260819    gcc-15.2.0
arm                  randconfig-002-20260820    clang-24
arm                  randconfig-003-20260819    gcc-10.5.0
arm                  randconfig-003-20260819    gcc-11.5.0
arm                  randconfig-003-20260820    clang-24
arm                  randconfig-004-20260819    gcc-11.5.0
arm                  randconfig-004-20260819    gcc-15.2.0
arm                  randconfig-004-20260820    clang-24
arm                          sunxi_defconfig    gcc-16.1.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260819    gcc-11.5.0
arm64                randconfig-002-20260819    clang-17
arm64                randconfig-003-20260819    clang-17
arm64                randconfig-004-20260819    gcc-8.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260819    gcc-9.5.0
csky                 randconfig-002-20260819    gcc-11.5.0
hexagon                       randconfig-001    gcc-11.5.0
hexagon                       randconfig-001    gcc-14.3.0
hexagon              randconfig-001-20260819    gcc-11.5.0
hexagon              randconfig-001-20260820    gcc-14.3.0
hexagon              randconfig-002-20260819    gcc-11.5.0
hexagon              randconfig-002-20260820    gcc-14.3.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260819    clang-22
i386       buildonly-randconfig-001-20260819    gcc-14
i386       buildonly-randconfig-001-20260820    gcc-14
i386       buildonly-randconfig-002-20260819    gcc-14
i386       buildonly-randconfig-002-20260820    gcc-14
i386       buildonly-randconfig-003-20260819    gcc-14
i386       buildonly-randconfig-003-20260820    gcc-14
i386       buildonly-randconfig-004-20260819    gcc-14
i386       buildonly-randconfig-004-20260820    gcc-14
i386       buildonly-randconfig-005-20260819    gcc-14
i386       buildonly-randconfig-005-20260820    gcc-14
i386       buildonly-randconfig-006-20260819    gcc-12
i386       buildonly-randconfig-006-20260819    gcc-14
i386       buildonly-randconfig-006-20260820    gcc-14
i386                 randconfig-001-20260819    gcc-14
i386                 randconfig-002-20260819    gcc-14
i386                 randconfig-003-20260819    gcc-14
i386                 randconfig-004-20260819    gcc-14
i386                 randconfig-005-20260819    gcc-14
i386                 randconfig-006-20260819    gcc-12
i386                 randconfig-006-20260819    gcc-14
i386                 randconfig-007-20260819    clang-22
i386                 randconfig-007-20260819    gcc-14
i386                 randconfig-011-20260819    gcc-13
i386                 randconfig-011-20260819    gcc-14
i386                 randconfig-012-20260819    gcc-14
i386                 randconfig-013-20260819    gcc-14
i386                 randconfig-014-20260819    clang-22
i386                 randconfig-014-20260819    gcc-14
i386                 randconfig-015-20260819    clang-22
i386                 randconfig-015-20260819    gcc-14
i386                 randconfig-016-20260819    clang-22
i386                 randconfig-016-20260819    gcc-14
i386                 randconfig-017-20260819    clang-22
i386                 randconfig-017-20260819    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260819    gcc-11.5.0
loongarch            randconfig-001-20260820    gcc-14.3.0
loongarch            randconfig-002-20260819    gcc-11.5.0
loongarch            randconfig-002-20260820    gcc-14.3.0
m68k                         amiga_defconfig    gcc-16.1.0
mips                          jazz_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260819    gcc-11.5.0
nios2                randconfig-001-20260820    gcc-14.3.0
nios2                randconfig-002-20260819    gcc-11.5.0
nios2                randconfig-002-20260820    gcc-14.3.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260819    clang-24
parisc               randconfig-001-20260820    gcc-8.5.0
parisc               randconfig-002-20260819    clang-24
parisc               randconfig-002-20260820    gcc-8.5.0
powerpc                        ps3_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260819    clang-24
powerpc              randconfig-001-20260820    gcc-8.5.0
powerpc              randconfig-002-20260819    clang-24
powerpc              randconfig-002-20260820    gcc-8.5.0
powerpc64            randconfig-001-20260819    clang-24
powerpc64            randconfig-001-20260820    gcc-8.5.0
powerpc64            randconfig-002-20260819    clang-24
powerpc64            randconfig-002-20260820    gcc-8.5.0
riscv                         randconfig-001    gcc-13.4.0
riscv                randconfig-001-20260819    clang-24
riscv                randconfig-001-20260819    gcc-8.5.0
riscv                randconfig-002-20260819    clang-24
riscv                randconfig-002-20260819    gcc-9.5.0
s390                 randconfig-001-20260819    clang-24
s390                 randconfig-001-20260819    gcc-14.3.0
s390                 randconfig-002-20260819    clang-24
sh                                 defconfig    gcc-16.1.0
sh                kfr2r09-romimage_defconfig    gcc-16.1.0
sh                   randconfig-001-20260819    clang-24
sh                   randconfig-001-20260819    gcc-16.1.0
sh                   randconfig-002-20260819    clang-24
sh                   randconfig-002-20260819    gcc-11.5.0
sh                     rts7751r2d1_defconfig    gcc-16.1.0
sparc                randconfig-001-20260819    gcc-12.5.0
sparc                randconfig-001-20260820    gcc-13.4.0
sparc                randconfig-002-20260819    gcc-8.5.0
sparc                randconfig-002-20260820    gcc-13.4.0
sparc64              randconfig-001-20260819    clang-20
sparc64              randconfig-001-20260820    gcc-13.4.0
sparc64              randconfig-002-20260819    gcc-10.5.0
sparc64              randconfig-002-20260820    gcc-13.4.0
um                   randconfig-001-20260819    gcc-14
um                   randconfig-001-20260820    gcc-13.4.0
um                   randconfig-002-20260819    gcc-12
um                   randconfig-002-20260820    gcc-13.4.0
x86_64              buildonly-randconfig-001    gcc-12
x86_64     buildonly-randconfig-001-20260819    gcc-14
x86_64     buildonly-randconfig-001-20260820    gcc-14
x86_64     buildonly-randconfig-002-20260819    gcc-14
x86_64     buildonly-randconfig-002-20260820    gcc-14
x86_64     buildonly-randconfig-003-20260819    gcc-14
x86_64     buildonly-randconfig-003-20260820    gcc-14
x86_64     buildonly-randconfig-004-20260819    gcc-14
x86_64     buildonly-randconfig-004-20260820    gcc-14
x86_64     buildonly-randconfig-005-20260819    gcc-14
x86_64     buildonly-randconfig-005-20260820    gcc-14
x86_64     buildonly-randconfig-006-20260819    gcc-14
x86_64     buildonly-randconfig-006-20260820    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260819    gcc-14
x86_64               randconfig-002-20260819    gcc-14
x86_64               randconfig-003-20260819    gcc-14
x86_64               randconfig-004-20260819    gcc-14
x86_64               randconfig-005-20260819    gcc-14
x86_64               randconfig-006-20260819    gcc-14
x86_64                        randconfig-011    clang-22
x86_64                        randconfig-011    gcc-14
x86_64               randconfig-011-20260819    clang-22
x86_64               randconfig-011-20260819    gcc-14
x86_64               randconfig-012-20260819    clang-22
x86_64               randconfig-012-20260819    gcc-14
x86_64               randconfig-013-20260819    clang-22
x86_64               randconfig-013-20260819    gcc-14
x86_64               randconfig-014-20260819    clang-22
x86_64               randconfig-014-20260819    gcc-14
x86_64               randconfig-015-20260819    clang-22
x86_64               randconfig-016-20260819    clang-22
x86_64               randconfig-016-20260819    gcc-12
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260819    gcc-14
x86_64               randconfig-072-20260819    gcc-14
x86_64               randconfig-073-20260819    gcc-12
x86_64               randconfig-074-20260819    clang-22
x86_64               randconfig-075-20260819    gcc-14
x86_64               randconfig-076-20260819    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260819    gcc-16.1.0
xtensa               randconfig-001-20260820    gcc-13.4.0
xtensa               randconfig-002-20260819    gcc-14.3.0
xtensa               randconfig-002-20260820    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
