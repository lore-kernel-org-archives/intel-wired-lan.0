Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291D3C53200
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Jul 2026 10:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFF1880B0F;
	Wed, 29 Jul 2026 10:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x81Z9E-K6Vj9; Wed, 29 Jul 2026 10:44:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BEFC880AC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785321859;
	bh=UwUmWja0VP0PAEHK4Vpq8223cib7trTVHfBTpDRU9Qs=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OwKQw52loy9rnpj3ujHDUvfKm1XFPp8z+1XbubOBMjoT0GCpuCJ9xGWJef9hAbyRH
	 iNu9QflS/pBWbis9EufuGzdjspJaFMRLeVqRI0/+GiWT341aJ1cvzzQO0N1HgQiyJr
	 iWZYiVFR9IyS18K4tARM/WMCpmWqixhQQPVutEbhDpGm7delF+MR1r35u7DbgfdRhE
	 5J+Vpsmhvg+HIkBToDLVYcjQch8vHmDekUryGnOlaE/XUEWRW9T4/8UU8In/cWC8Ok
	 00f5v6wPNXQQQA9UGK9GH74/58HfeD9RjLBrqe3DbpmjaFz+wbXxX07sXzj19XSPTs
	 yAvNjLAzV6HRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEFC880AC6;
	Wed, 29 Jul 2026 10:44:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 74E7E45B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 10:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66B0540B03
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 10:44:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7AD_uPq1SDIL for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Jul 2026 10:44:17 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 77ADD40AFE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77ADD40AFE
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77ADD40AFE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 10:44:17 +0000 (UTC)
X-CSE-ConnectionGUID: m0HQ37vDTvCatHOU3FvXAw==
X-CSE-MsgGUID: RAm4LNtvS0GNUpnmfGhFWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85796153"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="85796153"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 03:44:17 -0700
X-CSE-ConnectionGUID: VF1YdJaCRw6OJlJm8Oab/w==
X-CSE-MsgGUID: uc48wzmORAKzanheJB65QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="264260435"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by orviesa005.jf.intel.com with ESMTP; 29 Jul 2026 03:44:16 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wp1ll-00000000fHP-3rea;
 Wed, 29 Jul 2026 10:44:13 +0000
Date: Wed, 29 Jul 2026 18:44:11 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607291853.SrkbpJxU-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785321858; x=1816857858;
 h=date:from:to:subject:message-id;
 bh=HBdY6F+DAce93/R44BwwHxm0BqvDK5rNDjKin7G7qRI=;
 b=AduW/RcVJe+ot37jxAF02sul3XnTAm1W50z9Z0mjhB+6c6R9vsDlKfOd
 a0Hg+WyenG46nx6JrNcP2bvhfZ8eQvVBzOwXk/NDGdD4FL9UWc9HjGAqs
 p2nz6mr1F4/1AxJp8YMqkh3g++59hajIZ+jdBQQfNVzD/d4Dxep6KbXGS
 7z1GBIA6G/KBrxfUydhuhT+2MaNKGI0DvF2a1V3UZsLkG3HJdchMCtGO2
 eWcFxu9lZ2jnIpsQUkRScunITG7IQnABMYCgZ9moeEL9nKUd4rorQfmD+
 DXOHitcQb/DNDU9AP6ddjqGa7TiOhJAe7JFk34qWBez8Dpj/Yl/gktVMY
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AduW/RcV
Subject: [Intel-wired-lan] [tnguy-net-queue:200GbE] BUILD SUCCESS
 816419dfea5c88126f35eb7a1b429a1bf546665e
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 200GbE
branch HEAD: 816419dfea5c88126f35eb7a1b429a1bf546665e  e1000: fix memory leak in e1000_probe()

elapsed time: 812m

configs tested: 140
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260729    gcc-8.5.0
arc                  randconfig-002-20260729    gcc-13.4.0
arc                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-001-20260729    gcc-10.5.0
arm                  randconfig-001-20260729    gcc-8.5.0
arm                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-003-20260729    clang-24
arm                  randconfig-003-20260729    gcc-8.5.0
arm                  randconfig-004-20260729    clang-18
arm                  randconfig-004-20260729    gcc-8.5.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260729    clang-17
arm64                randconfig-001-20260729    gcc-14.3.0
arm64                randconfig-002-20260729    clang-17
arm64                randconfig-002-20260729    gcc-14.3.0
arm64                randconfig-003-20260729    clang-17
arm64                randconfig-003-20260729    gcc-14.3.0
arm64                randconfig-004-20260729    clang-17
arm64                randconfig-004-20260729    gcc-14.3.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260729    clang-17
csky                 randconfig-001-20260729    gcc-14.3.0
csky                 randconfig-002-20260729    clang-17
csky                 randconfig-002-20260729    gcc-14.3.0
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
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260729    clang-22
i386                 randconfig-001-20260729    gcc-14
i386                 randconfig-002-20260729    clang-22
i386                 randconfig-003-20260729    clang-22
i386                 randconfig-004-20260729    clang-22
i386                 randconfig-005-20260729    clang-22
i386                 randconfig-006-20260729    clang-22
i386                 randconfig-006-20260729    gcc-14
i386                 randconfig-007-20260729    clang-22
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260729    clang-22
i386                 randconfig-011-20260729    gcc-14
i386                 randconfig-012-20260729    clang-22
i386                 randconfig-012-20260729    gcc-14
i386                 randconfig-013-20260729    clang-22
i386                 randconfig-013-20260729    gcc-14
i386                 randconfig-014-20260729    gcc-14
i386                 randconfig-015-20260729    clang-22
i386                 randconfig-015-20260729    gcc-14
i386                 randconfig-016-20260729    gcc-14
i386                 randconfig-017-20260729    clang-22
i386                 randconfig-017-20260729    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260729    gcc-9.5.0
loongarch            randconfig-002-20260729    gcc-9.5.0
m68k                       m5272c3_defconfig    gcc-16.1.0
mips                     maltaaprp_defconfig    clang-17
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260729    gcc-9.5.0
nios2                randconfig-002-20260729    gcc-9.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260729    clang-24
parisc               randconfig-001-20260729    gcc-10.5.0
parisc               randconfig-002-20260729    clang-24
parisc               randconfig-002-20260729    gcc-16.1.0
powerpc              randconfig-001-20260729    clang-21
powerpc              randconfig-001-20260729    clang-24
powerpc              randconfig-002-20260729    clang-24
powerpc              randconfig-002-20260729    gcc-8.5.0
powerpc64            randconfig-001-20260729    clang-24
powerpc64            randconfig-002-20260729    clang-24
powerpc64            randconfig-002-20260729    gcc-10.5.0
riscv                         randconfig-001    gcc-15.2.0
riscv                randconfig-001-20260729    gcc-15.2.0
riscv                randconfig-001-20260729    gcc-8.5.0
riscv                randconfig-002-20260729    gcc-15.2.0
riscv                randconfig-002-20260729    gcc-9.5.0
s390                 randconfig-001-20260729    clang-17
s390                 randconfig-001-20260729    gcc-15.2.0
s390                 randconfig-002-20260729    clang-24
s390                 randconfig-002-20260729    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                           hp6xx_defconfig    gcc-16.1.0
sh                   randconfig-001-20260729    gcc-13.4.0
sh                   randconfig-001-20260729    gcc-15.2.0
sh                   randconfig-002-20260729    gcc-15.2.0
sparc                randconfig-001-20260729    gcc-10.5.0
sparc                randconfig-002-20260729    gcc-10.5.0
sparc64              randconfig-001-20260729    gcc-10.5.0
sparc64              randconfig-002-20260729    gcc-10.5.0
um                   randconfig-001-20260729    gcc-10.5.0
um                   randconfig-002-20260729    gcc-10.5.0
x86_64              buildonly-randconfig-001    gcc-12
x86_64     buildonly-randconfig-001-20260729    clang-22
x86_64     buildonly-randconfig-001-20260729    gcc-14
x86_64     buildonly-randconfig-002-20260729    clang-22
x86_64     buildonly-randconfig-002-20260729    gcc-14
x86_64     buildonly-randconfig-003-20260729    clang-22
x86_64     buildonly-randconfig-004-20260729    clang-22
x86_64     buildonly-randconfig-004-20260729    gcc-14
x86_64     buildonly-randconfig-005-20260729    clang-22
x86_64     buildonly-randconfig-006-20260729    clang-22
x86_64     buildonly-randconfig-006-20260729    gcc-12
x86_64                                 kexec    clang-22
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
