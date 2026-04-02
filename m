Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA10D6AB00
	for <intel-wired-lan@archiver.kernel.org>; Thu,  2 Apr 2026 19:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEBFD40F54;
	Thu,  2 Apr 2026 19:53:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gaSuwf88tfk6; Thu,  2 Apr 2026 19:53:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3A1840963
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775159630;
	bh=HQ0r90avz679rUCt+kDOr91x27MhBfkeo97ettoahhM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zqoh4skfsieu7Eg+DKsn7HKe84lKwI2C0ALZI9IfOP7oLgzolWVtH/NrsSesbtfhn
	 rpVVDazFSZzkbeGkosKXJ/0v6C+eUq5H4op80VrBYnKQWr3Ng8PumydLX8V/zkPoIW
	 YRivILIX73SYbIk2t9UipHHwv1Ef3UgqJNyEQcmberziGvVnDXwxExeK3wUXWdpEXf
	 62IIyc/ju5YL1+HxGST0mcOLjzauiDSI02hDBea8LZ4B7waWOqXGXZ90mUO/lvA0Pa
	 MhJMhL+Vk2UGx1AqA2LZZ9hfFStYsBD/9rC6wtAnLbP7XnI6D54VrCZwnORCJlHZQX
	 kslkiemebBgJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3A1840963;
	Thu,  2 Apr 2026 19:53:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DCBDA2D3
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Apr 2026 19:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D9C8B607CB
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Apr 2026 19:53:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KM_8xyOH9tZl for <intel-wired-lan@lists.osuosl.org>;
 Thu,  2 Apr 2026 19:53:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7F7E96079B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F7E96079B
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F7E96079B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Apr 2026 19:53:48 +0000 (UTC)
X-CSE-ConnectionGUID: lugbhc/wSe+dAmYfB1fCJQ==
X-CSE-MsgGUID: a3k5idTYT0KYRib7ychxAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="93812510"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; d="scan'208";a="93812510"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 12:53:47 -0700
X-CSE-ConnectionGUID: rZJAXqh8QHm/sCaEvbFE1A==
X-CSE-MsgGUID: hAywCnUsQY2BPoWIsI7Gag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; d="scan'208";a="226234858"
Received: from lkp-server01.sh.intel.com (HELO 064ad336901d) ([10.239.97.150])
 by orviesa010.jf.intel.com with ESMTP; 02 Apr 2026 12:53:46 -0700
Received: from kbuild by 064ad336901d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w8O6p-000000000OB-3xqn;
 Thu, 02 Apr 2026 19:53:43 +0000
Date: Fri, 03 Apr 2026 03:53:40 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202604030332.zWDSi7Dz-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775159628; x=1806695628;
 h=date:from:to:subject:message-id;
 bh=HcjpuBU1kp1CexENHXC/xBGDQ7y/rGKefB7RdoGwiCE=;
 b=RsPzXXV1U9aWhguUS/Uda+9RGgRs4lzGu7TpoQ8KFPMwe9NgI7N2L6Gs
 KrXssf34ImpZBzOSFIERTYwEsX1VyaYrwf4ItESr+kYkH064ujRVPgX0X
 t9fEfezesumqdipxPGWOuC+4ziPN68WcimlCVFcQ7mV1kRhcaD/GU0GBt
 CUCGP9Q/YDLe0C7Iiet2l2ff1n/aP+jg3Y07+GwNmaS8drnJPfWe2zGTG
 kCnwkN8ApwGaWAjS5A9Bnm5o4qr/N/o3Mgro06GWU6URImZqLg13hIyl7
 mYz3RhYhi8ATquosc1eAS4UohR5KvRRw8Twx2vYfaf/6K6dqbtQFPMA5e
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RsPzXXV1
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 1c25a2b1fa86e6619f13b448b38a6b1145e02c62
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
branch HEAD: 1c25a2b1fa86e6619f13b448b38a6b1145e02c62  ice: call netif_keep_dst() once when entering switchdev mode

elapsed time: 756m

configs tested: 190
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260402    gcc-11.5.0
arc                   randconfig-002-20260402    gcc-11.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                         orion5x_defconfig    clang-23
arm                   randconfig-001-20260402    gcc-11.5.0
arm                   randconfig-002-20260402    gcc-11.5.0
arm                   randconfig-003-20260402    gcc-11.5.0
arm                   randconfig-004-20260402    gcc-11.5.0
arm                       spear13xx_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260402    gcc-15.2.0
arm64                 randconfig-002-20260402    gcc-15.2.0
arm64                 randconfig-003-20260402    gcc-15.2.0
arm64                 randconfig-004-20260402    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260402    gcc-15.2.0
csky                  randconfig-002-20260402    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260402    clang-18
hexagon               randconfig-001-20260403    clang-23
hexagon               randconfig-002-20260402    clang-18
hexagon               randconfig-002-20260403    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260402    clang-20
i386        buildonly-randconfig-001-20260403    gcc-14
i386        buildonly-randconfig-002-20260402    clang-20
i386        buildonly-randconfig-002-20260403    gcc-14
i386        buildonly-randconfig-003-20260402    clang-20
i386        buildonly-randconfig-003-20260403    gcc-14
i386        buildonly-randconfig-004-20260402    clang-20
i386        buildonly-randconfig-004-20260403    gcc-14
i386        buildonly-randconfig-005-20260402    clang-20
i386        buildonly-randconfig-005-20260403    gcc-14
i386        buildonly-randconfig-006-20260402    clang-20
i386        buildonly-randconfig-006-20260403    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260402    clang-20
i386                  randconfig-002-20260402    clang-20
i386                  randconfig-003-20260402    clang-20
i386                  randconfig-004-20260402    clang-20
i386                  randconfig-005-20260402    clang-20
i386                  randconfig-006-20260402    clang-20
i386                  randconfig-007-20260402    clang-20
i386                  randconfig-011-20260402    clang-20
i386                  randconfig-012-20260402    clang-20
i386                  randconfig-013-20260402    clang-20
i386                  randconfig-014-20260402    clang-20
i386                  randconfig-015-20260402    clang-20
i386                  randconfig-016-20260402    clang-20
i386                  randconfig-017-20260402    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260402    clang-18
loongarch             randconfig-001-20260403    clang-23
loongarch             randconfig-002-20260402    clang-18
loongarch             randconfig-002-20260403    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260402    clang-18
nios2                 randconfig-001-20260403    clang-23
nios2                 randconfig-002-20260402    clang-18
nios2                 randconfig-002-20260403    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260402    clang-20
parisc                randconfig-002-20260402    clang-20
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260402    clang-20
powerpc               randconfig-002-20260402    clang-20
powerpc64             randconfig-001-20260402    clang-20
powerpc64             randconfig-002-20260402    clang-20
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260402    clang-23
riscv                 randconfig-002-20260402    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260402    clang-23
s390                  randconfig-002-20260402    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260402    clang-23
sh                    randconfig-002-20260402    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260402    gcc-14
sparc                 randconfig-002-20260402    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260402    gcc-14
sparc64               randconfig-002-20260402    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260402    gcc-14
um                    randconfig-002-20260402    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260402    clang-20
x86_64      buildonly-randconfig-002-20260402    clang-20
x86_64      buildonly-randconfig-003-20260402    clang-20
x86_64      buildonly-randconfig-004-20260402    clang-20
x86_64      buildonly-randconfig-005-20260402    clang-20
x86_64      buildonly-randconfig-006-20260402    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260402    gcc-14
x86_64                randconfig-002-20260402    gcc-14
x86_64                randconfig-003-20260402    gcc-14
x86_64                randconfig-004-20260402    gcc-14
x86_64                randconfig-005-20260402    gcc-14
x86_64                randconfig-006-20260402    gcc-14
x86_64                randconfig-011-20260402    clang-20
x86_64                randconfig-012-20260402    clang-20
x86_64                randconfig-013-20260402    clang-20
x86_64                randconfig-014-20260402    clang-20
x86_64                randconfig-015-20260402    clang-20
x86_64                randconfig-016-20260402    clang-20
x86_64                randconfig-071-20260402    clang-20
x86_64                randconfig-072-20260402    clang-20
x86_64                randconfig-073-20260402    clang-20
x86_64                randconfig-074-20260402    clang-20
x86_64                randconfig-075-20260402    clang-20
x86_64                randconfig-076-20260402    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260402    gcc-14
xtensa                randconfig-002-20260402    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
