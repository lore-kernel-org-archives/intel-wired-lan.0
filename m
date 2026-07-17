Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFCFC4450A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Jul 2026 02:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EC4181100;
	Fri, 17 Jul 2026 02:03:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S87Fzl2MUhuC; Fri, 17 Jul 2026 02:03:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8CD78110D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784253787;
	bh=7f5T0HiLi68rYQlXtNNVia3hPXQb4RTlPOfICRKvYjo=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=9PWi9P8IPvgHslsJFVs7g+ZQ8STlINdqsPU0/okeJPnM8YL+hv/r8yoCYnZbybagU
	 QoGaL/+lG/Vp9ejIK5vGca0QD8UVrq376mV4qaN/S/IJWJyKknRCy2JVaALXjTT6ox
	 aFhuxLHOXzPrlsgH/Dammj3TO6C1ahRXp+GaRDZAlyxhGGxhJRc6T7qZlPppfl+Mu7
	 P13NEKsI8GRmv52TzNHCkxy4VfWal90CIvgEJ7B54zQwwxUUwH6bGhCP+AJxpGU7RK
	 llVG41oj3RLcinXdvg5iDqBhyZvlNqd/uPMRAE9abWaY8zjYC3zTb2uTqZtoc2C59O
	 UVexcqIqDPUUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8CD78110D;
	Fri, 17 Jul 2026 02:03:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 966E736E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 02:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87E7840148
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 02:03:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HgvVJbGhhElZ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Jul 2026 02:03:05 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5104540025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5104540025
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5104540025
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 02:03:04 +0000 (UTC)
X-CSE-ConnectionGUID: BHV0QVPHQqqQbPwmmmfDOg==
X-CSE-MsgGUID: 2QkMn8evShGe2eY6YW0lhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="96058121"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="96058121"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 19:03:05 -0700
X-CSE-ConnectionGUID: bYBKqVgvStGxuZkaXyAWuA==
X-CSE-MsgGUID: tC1Bsy8hRe+PyF+qICypOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="261599495"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by fmviesa005.fm.intel.com with ESMTP; 16 Jul 2026 19:03:03 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wkXuk-00000000SMS-2Yvm;
 Fri, 17 Jul 2026 02:02:59 +0000
Date: Fri, 17 Jul 2026 10:01:52 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607171042.6SlHADRl-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784253786; x=1815789786;
 h=date:from:to:subject:message-id;
 bh=cnqvAQvvyAjcZgGSGbrfCq30v3kuc1rGTTm1pHTgmQI=;
 b=XGHAPFf1jNJtqZ/QqFuu9UV7D8nKY1/wzqz5pCWUQqOGQ4M++K2RkHmx
 ffEZVOQ0avWn8w6mGV7mswJ1TPczd+Jnvo6mlUhj6NKaKE8WLcW+0EDgC
 44qJkmyxoYBIW7OLYvyJ1PBCcUFy107Brv9GRPwMW22JGjMbJzAxMZH62
 BMqyxaxh1/q1rnFWb2S5w5jvajpUmRmlJ0dQXNTvSvFVDltW++8FAnlOp
 Et3fNPj4yL/0PHogyuG38pvWMzDUpQqFsEqtSp8XO9ccSGXHqn/qDdhyG
 r58Rw7vCDrPIIPOD80Z+LyeMhu2qNMxwv9FaxZi3zADkAmEkP0dq7/fFU
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XGHAPFf1
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 bf696cf19d64727a5a95126733603269ed8c42c2
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
branch HEAD: bf696cf19d64727a5a95126733603269ed8c42c2  igc: Support ACPI-based MAC passthrough

elapsed time: 1634m

configs tested: 83
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-16.1.0
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                 randconfig-001-20260717    gcc-11.5.0
arm64                 randconfig-002-20260717    gcc-8.5.0
arm64                 randconfig-003-20260717    gcc-8.5.0
arm64                 randconfig-004-20260717    gcc-9.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                  randconfig-001-20260717    gcc-13.4.0
csky                  randconfig-002-20260717    gcc-15.2.0
hexagon                           allnoconfig    clang-24
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260717    gcc-14
i386        buildonly-randconfig-002-20260717    gcc-14
i386        buildonly-randconfig-003-20260717    clang-22
i386        buildonly-randconfig-004-20260717    gcc-14
i386        buildonly-randconfig-005-20260717    gcc-14
i386        buildonly-randconfig-006-20260717    clang-22
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-24
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                          eyeq5_defconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260717    gcc-10.5.0
parisc                randconfig-002-20260717    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260717    gcc-13.4.0
powerpc               randconfig-002-20260717    gcc-11.5.0
powerpc64             randconfig-001-20260717    gcc-15.2.0
powerpc64             randconfig-002-20260717    gcc-8.5.0
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-24
riscv                 randconfig-002-20260717    clang-24
s390                             allmodconfig    clang-24
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                  randconfig-001-20260717    clang-24
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260717    gcc-9.5.0
sh                    randconfig-002-20260717    gcc-16.1.0
sparc                             allnoconfig    gcc-16.1.0
sparc                 randconfig-001-20260717    gcc-8.5.0
sparc                 randconfig-002-20260717    gcc-14.3.0
sparc64                          allmodconfig    clang-20
sparc64               randconfig-001-20260717    clang-22
sparc64               randconfig-002-20260717    clang-24
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-14
um                    randconfig-001-20260717    clang-24
um                    randconfig-002-20260717    clang-21
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260717    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
