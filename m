Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5050C5DF81
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Aug 2026 23:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DE6F80C53;
	Wed, 19 Aug 2026 23:03:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YCUIhr163qHP; Wed, 19 Aug 2026 23:03:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787180604;
	bh=eZZ2p+NQ36iRBVxSEuJJbSTsVONqa3k3PydFxmtkCR8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=9bhKMhHaNeCvUY0dpXPe7YN1rKQMg47lrWt8BrlmhuWD3jgEA9lnEBADom4fv/YOO
	 g9lS9aRy1wZhPiG+RavgDEFkm9k3IREqV191fLLIIEtLVXjd8h+OGmi5wh6BDV32BF
	 VqwOety8ULriLHqwUWw2TWXmoFhTNOUUI49DRSJnsqIONY7DHmfXblj1TPQ0KaAprH
	 /cKL6u29cM0DnfS3RiUW8O9s5kE9XtTqWBABszjJ8jC1ZBL6ug0H1J0mLT5NEURLeF
	 HLHmmh8f9O79Zj0hv3BCCaJzHvaFj7ee9iSWpQ5/iaLtTEBIduZYCQ1EpqPp9t6coI
	 kw+s8VPQyuSpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5598280C4D;
	Wed, 19 Aug 2026 23:03:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 555D31B8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 23:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E24060675
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 23:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GlEU5kGi_JQn for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Aug 2026 23:03:22 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SYJigPVJ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 048AA605FC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 23:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787180603; x=1818716603; h=date:from:to:subject:message-id;
 bh=n2T65bxiZrqv8/sYXSx27ROduPUKaKXhul8TDTfInM4=;
 b=SYJigPVJhaPFh1kRDXxPeD+m+ugelUuyITHnn84e+vCMI5CLb5EmMkL5
 ddoI43uF8EqS3mo1nVegDOlxFb/o+JluKh8vFEPmI3YCoddRLDl23oAgw
 jz4X3l+onXHVhAtS9wjDGkkh40smJobTNtOvSjc/hSKKOi4gSur5Evd2e
 0LJSz6zlRKSMGtSaIcsWfxxvdazUSeplcAQTLJ6Jd3gDD0ObppcZWD1HP
 3IYTx2fBnDylAx8nEKz7u6KQFg4JL/q9xbaF7MWaUf63nEG0D1ey0+qR8
 weAd+WBREXpQAEATBodufOWfVimv+Tq5ITSXHzbB++4O5Sn7V8UYgIFAy A==;
X-CSE-ConnectionGUID: Q2qUK8xtQ+eMse/BrP2lHg==
X-CSE-MsgGUID: 6GgmWMemSfW7B5sRXI6j0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="91389866"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="91389866"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 16:03:22 -0700
X-CSE-ConnectionGUID: p30Hq7Q9S4GvacdHX8OY8A==
X-CSE-MsgGUID: +yYlLamSTC2rhig8tYqLUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="263944411"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 19 Aug 2026 16:03:20 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wwpJV-00000000gp9-3i7F;
 Wed, 19 Aug 2026 23:03:17 +0000
Date: Thu, 20 Aug 2026 07:03:13 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:100GbE] BUILD SUCCESS
 a3dee9bb902ee4357fa02e49b415d7724ee0140a
Message-ID: <202608200702.5iYfetcu-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: a3dee9bb902ee4357fa02e49b415d7724ee0140a  Merge branch 'vsock-fix-stale-sk_err-handling-after-a-failed-connect'

elapsed time: 1472m

configs tested: 239
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-11.5.0
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
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260819    gcc-11.5.0
arm64                randconfig-001-20260819    gcc-14.3.0
arm64                randconfig-001-20260819    gcc-9.5.0
arm64                randconfig-001-20260820    clang-24
arm64                randconfig-002-20260819    clang-17
arm64                randconfig-002-20260819    gcc-14.3.0
arm64                randconfig-002-20260819    gcc-9.5.0
arm64                randconfig-002-20260820    clang-24
arm64                randconfig-003-20260819    clang-17
arm64                randconfig-003-20260819    gcc-14.3.0
arm64                randconfig-003-20260819    gcc-9.5.0
arm64                randconfig-003-20260820    clang-24
arm64                randconfig-004-20260819    gcc-14.3.0
arm64                randconfig-004-20260819    gcc-8.5.0
arm64                randconfig-004-20260819    gcc-9.5.0
arm64                randconfig-004-20260820    clang-24
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260819    gcc-14.3.0
csky                 randconfig-001-20260819    gcc-9.5.0
csky                 randconfig-001-20260820    clang-24
csky                 randconfig-002-20260819    gcc-11.5.0
csky                 randconfig-002-20260819    gcc-14.3.0
csky                 randconfig-002-20260819    gcc-9.5.0
csky                 randconfig-002-20260820    clang-24
hexagon                       randconfig-001    gcc-11.5.0
hexagon              randconfig-001-20260819    gcc-11.5.0
hexagon              randconfig-001-20260820    gcc-14.3.0
hexagon              randconfig-002-20260819    gcc-11.5.0
hexagon              randconfig-002-20260820    gcc-14.3.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
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
i386                          randconfig-001    gcc-14
i386                 randconfig-001-20260819    gcc-14
i386                 randconfig-001-20260820    clang-22
i386                 randconfig-002-20260819    gcc-14
i386                 randconfig-002-20260820    clang-22
i386                 randconfig-003-20260819    gcc-14
i386                 randconfig-003-20260820    clang-22
i386                 randconfig-004-20260819    gcc-14
i386                 randconfig-004-20260820    clang-22
i386                 randconfig-005-20260819    gcc-14
i386                 randconfig-005-20260820    clang-22
i386                 randconfig-006-20260819    gcc-14
i386                 randconfig-006-20260820    clang-22
i386                 randconfig-007-20260819    gcc-14
i386                 randconfig-007-20260820    clang-22
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260819    gcc-14
i386                 randconfig-011-20260820    gcc-14
i386                 randconfig-012-20260819    gcc-14
i386                 randconfig-012-20260820    gcc-14
i386                 randconfig-013-20260819    gcc-14
i386                 randconfig-013-20260820    gcc-14
i386                 randconfig-014-20260819    gcc-14
i386                 randconfig-014-20260820    gcc-14
i386                 randconfig-015-20260819    gcc-14
i386                 randconfig-015-20260820    gcc-14
i386                 randconfig-016-20260819    gcc-14
i386                 randconfig-016-20260820    gcc-14
i386                 randconfig-017-20260819    gcc-14
i386                 randconfig-017-20260820    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260819    gcc-11.5.0
loongarch            randconfig-001-20260820    gcc-14.3.0
loongarch            randconfig-002-20260819    gcc-11.5.0
loongarch            randconfig-002-20260820    gcc-14.3.0
m68k                         atari_defconfig    gcc-16.1.0
mips                    cu1000-neo_defconfig    gcc-16.1.0
mips                          jazz_defconfig    clang-24
mips                         rb532_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260819    gcc-11.5.0
nios2                randconfig-001-20260820    gcc-14.3.0
nios2                randconfig-002-20260819    gcc-11.5.0
nios2                randconfig-002-20260820    gcc-14.3.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    clang-24
parisc               randconfig-001-20260819    clang-24
parisc               randconfig-001-20260819    gcc-8.5.0
parisc               randconfig-001-20260820    gcc-8.5.0
parisc               randconfig-002-20260819    clang-24
parisc               randconfig-002-20260819    gcc-16.1.0
parisc               randconfig-002-20260820    gcc-8.5.0
powerpc                        ps3_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260819    clang-24
powerpc              randconfig-001-20260820    gcc-8.5.0
powerpc              randconfig-002-20260819    clang-24
powerpc              randconfig-002-20260819    gcc-8.5.0
powerpc              randconfig-002-20260820    gcc-8.5.0
powerpc                   sam440ep_defconfig    gcc-16.1.0
powerpc                    sequoia_defconfig    clang-24
powerpc64            randconfig-001-20260819    clang-24
powerpc64            randconfig-001-20260820    gcc-8.5.0
powerpc64            randconfig-002-20260819    clang-21
powerpc64            randconfig-002-20260819    clang-24
powerpc64            randconfig-002-20260820    gcc-8.5.0
riscv                         randconfig-001    clang-24
riscv                randconfig-001-20260819    clang-24
riscv                randconfig-001-20260820    clang-24
riscv                randconfig-002-20260819    clang-24
riscv                randconfig-002-20260820    clang-24
s390                 randconfig-001-20260819    clang-24
s390                 randconfig-001-20260820    clang-24
s390                 randconfig-002-20260819    clang-24
s390                 randconfig-002-20260820    clang-24
sh                                 defconfig    gcc-16.1.0
sh                kfr2r09-romimage_defconfig    gcc-16.1.0
sh                   randconfig-001-20260819    clang-24
sh                   randconfig-001-20260820    clang-24
sh                   randconfig-002-20260819    clang-24
sh                   randconfig-002-20260820    clang-24
sparc                randconfig-001-20260819    gcc-10.5.0
sparc                randconfig-001-20260819    gcc-12.5.0
sparc                randconfig-001-20260820    gcc-13.4.0
sparc                randconfig-002-20260819    gcc-10.5.0
sparc                randconfig-002-20260819    gcc-8.5.0
sparc                randconfig-002-20260820    gcc-13.4.0
sparc64              randconfig-001-20260819    clang-20
sparc64              randconfig-001-20260819    gcc-10.5.0
sparc64              randconfig-001-20260820    gcc-13.4.0
sparc64              randconfig-002-20260819    gcc-10.5.0
sparc64              randconfig-002-20260820    gcc-13.4.0
um                   randconfig-001-20260819    gcc-10.5.0
um                   randconfig-001-20260819    gcc-14
um                   randconfig-001-20260820    gcc-13.4.0
um                   randconfig-002-20260819    gcc-10.5.0
um                   randconfig-002-20260819    gcc-12
um                   randconfig-002-20260820    gcc-13.4.0
x86_64              buildonly-randconfig-001    gcc-12
x86_64              buildonly-randconfig-001    gcc-14
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
x86_64               randconfig-001-20260820    clang-22
x86_64               randconfig-002-20260819    gcc-14
x86_64               randconfig-002-20260820    clang-22
x86_64               randconfig-003-20260819    gcc-14
x86_64               randconfig-003-20260820    clang-22
x86_64               randconfig-004-20260819    gcc-14
x86_64               randconfig-004-20260820    clang-22
x86_64               randconfig-005-20260819    gcc-14
x86_64               randconfig-005-20260820    clang-22
x86_64               randconfig-006-20260819    gcc-14
x86_64               randconfig-006-20260820    clang-22
x86_64                        randconfig-011    clang-22
x86_64               randconfig-011-20260819    clang-22
x86_64               randconfig-011-20260819    gcc-14
x86_64               randconfig-011-20260820    clang-22
x86_64               randconfig-012-20260819    clang-22
x86_64               randconfig-012-20260819    gcc-14
x86_64               randconfig-012-20260820    clang-22
x86_64               randconfig-013-20260819    clang-22
x86_64               randconfig-013-20260819    gcc-14
x86_64               randconfig-013-20260820    clang-22
x86_64               randconfig-014-20260819    clang-22
x86_64               randconfig-014-20260819    gcc-14
x86_64               randconfig-014-20260820    clang-22
x86_64               randconfig-015-20260819    clang-22
x86_64               randconfig-015-20260820    clang-22
x86_64               randconfig-016-20260819    clang-22
x86_64               randconfig-016-20260819    gcc-12
x86_64               randconfig-016-20260820    clang-22
x86_64                        randconfig-071    clang-22
x86_64               randconfig-071-20260819    clang-22
x86_64               randconfig-071-20260819    gcc-14
x86_64               randconfig-071-20260820    clang-22
x86_64               randconfig-072-20260819    clang-22
x86_64               randconfig-072-20260819    gcc-14
x86_64               randconfig-072-20260820    clang-22
x86_64               randconfig-073-20260819    clang-22
x86_64               randconfig-073-20260819    gcc-12
x86_64               randconfig-073-20260820    clang-22
x86_64               randconfig-074-20260819    clang-22
x86_64               randconfig-074-20260820    clang-22
x86_64               randconfig-075-20260819    clang-22
x86_64               randconfig-075-20260819    gcc-14
x86_64               randconfig-075-20260820    clang-22
x86_64               randconfig-076-20260819    clang-22
x86_64               randconfig-076-20260819    gcc-14
x86_64               randconfig-076-20260820    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260819    gcc-10.5.0
xtensa               randconfig-001-20260819    gcc-16.1.0
xtensa               randconfig-001-20260820    gcc-13.4.0
xtensa               randconfig-002-20260819    gcc-10.5.0
xtensa               randconfig-002-20260819    gcc-14.3.0
xtensa               randconfig-002-20260820    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
