Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA3AE7719A
	for <intel-wired-lan@archiver.kernel.org>; Thu,  9 Jan 2025 23:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E154440763;
	Thu,  9 Jan 2025 23:25:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tOyVzvBT1tAJ; Thu,  9 Jan 2025 23:25:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48AD2402DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1736465109;
	bh=H/htxyjr2ZOsyD5J5hbijvhq+DZCwGAlIUXKC4emc4s=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2H3/3j+4CuBBprKOj8QncRChaU9OifRyZiK+bhpNlb2AMAyZJIJ3EuEAMKwstVFao
	 jIKj5SuU2Y4OmENFQrcerum3yY0CFqIGsmZMiuBRocnG3EXGClOyMDC9r8ULCnXBMh
	 PHl/gnOm62owW08oLW8PW8zvJW7ftR/V0y476G1K238FvHltOXAMeapfXGjZdMspoo
	 6AFOGlbviUWv9ik0hfnwLjKdI11xo2kUlGcLzOyFTn7OyY4gH4rCgqTPAHK6hvEnbD
	 p+qe4jpItAsEPGbRsLxU/RX/khCqbIKoB/lSWQdukyW7WiNghqbqvjx5Nn4CIAXGeT
	 wvBFTP6DM7ivg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48AD2402DA;
	Thu,  9 Jan 2025 23:25:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AA1A376C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Jan 2025 23:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9861160855
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Jan 2025 23:25:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1-VMOhvAtpGp for <intel-wired-lan@lists.osuosl.org>;
 Thu,  9 Jan 2025 23:25:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 30EB9607A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30EB9607A2
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 30EB9607A2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 Jan 2025 23:25:04 +0000 (UTC)
X-CSE-ConnectionGUID: dE+s61ZnR42BO8iIfa3xAQ==
X-CSE-MsgGUID: 9jWSMaf5QqGivz9v0bkw4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="40694184"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; d="scan'208";a="40694184"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2025 15:25:04 -0800
X-CSE-ConnectionGUID: VwgAH3ZbQ0Wr1MTk8fi62w==
X-CSE-MsgGUID: ABxt91CsTJaC/jNzju71Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; d="scan'208";a="108464051"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
 by fmviesa004.fm.intel.com with ESMTP; 09 Jan 2025 15:25:04 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1tW1td-000IHB-1a
 for intel-wired-lan@lists.osuosl.org; Thu, 09 Jan 2025 23:25:01 +0000
Date: Fri, 10 Jan 2025 07:24:59 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202501100753.UebUpatO-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736465105; x=1768001105;
 h=date:from:to:subject:message-id;
 bh=5b7/86J0zRiqb0yOVq8nb3tQ+vL32aFMzKvFCml55R4=;
 b=ioCE+g8Zbz5Ux5KinUQOwhuNdCnXYsF7bg0A7Ld4ehnYgmaDnkpYgdk6
 HNRfzqIIvPuNBJ6Ch7cn1o6KzaSB8cpDMF/HaDOGAGoblh7ialH/Qo6J7
 Ma1X6Bilkq2j35gjQ8UyA56V62GIoOPpmsDevaU70iRwe3eyC0HcU9FRk
 tjyGHQFCWNa12fzPFIrqpCweLX44gI16kGl3C6vd7JCHavEg/YiJvcAn7
 vJsyhKre7Bm/Y7ZNTSOCx76p5nvMz72Sa93+uuYpF+uSWousXSh6ICJCQ
 AAw8y9qn5RoU5fSZ0dmg+jUvhX1FDTMySyt1mkVNBVaWr+RGWwkFg7pFX
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ioCE+g8Z
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 935d410834ef9ffbb381682fe4d9d42380fae5f4
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: 935d410834ef9ffbb381682fe4d9d42380fae5f4  ice: Add in/out PTP pin delays

elapsed time: 1456m

configs tested: 70
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20250109    gcc-13.2.0
arc                  randconfig-002-20250109    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250109    gcc-14.2.0
arm                  randconfig-002-20250109    clang-17
arm                  randconfig-003-20250109    clang-20
arm                  randconfig-004-20250109    gcc-14.2.0
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250109    gcc-14.2.0
arm64                randconfig-002-20250109    clang-20
arm64                randconfig-003-20250109    gcc-14.2.0
arm64                randconfig-004-20250109    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250109    gcc-14.2.0
csky                 randconfig-002-20250109    gcc-14.2.0
hexagon                          allnoconfig    clang-20
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250109    clang-14
hexagon              randconfig-002-20250109    clang-20
i386       buildonly-randconfig-001-20250109    gcc-12
i386       buildonly-randconfig-002-20250109    gcc-12
i386       buildonly-randconfig-003-20250109    clang-19
i386       buildonly-randconfig-004-20250109    clang-19
i386       buildonly-randconfig-005-20250109    clang-19
i386       buildonly-randconfig-006-20250109    gcc-12
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250109    gcc-14.2.0
loongarch            randconfig-002-20250109    gcc-14.2.0
nios2                randconfig-001-20250109    gcc-14.2.0
nios2                randconfig-002-20250109    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20250109    gcc-14.2.0
parisc               randconfig-002-20250109    gcc-14.2.0
powerpc                         allmodconfig    gcc-14.2.0
powerpc                         allyesconfig    clang-16
powerpc              randconfig-001-20250109    clang-15
powerpc              randconfig-002-20250109    gcc-14.2.0
powerpc              randconfig-003-20250109    gcc-14.2.0
powerpc64            randconfig-001-20250109    gcc-14.2.0
powerpc64            randconfig-002-20250109    clang-20
powerpc64            randconfig-003-20250109    clang-17
riscv                randconfig-001-20250109    gcc-14.2.0
riscv                randconfig-002-20250109    clang-15
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250109    gcc-14.2.0
s390                 randconfig-002-20250109    clang-16
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250109    gcc-14.2.0
sh                   randconfig-002-20250109    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250109    gcc-14.2.0
sparc                randconfig-002-20250109    gcc-14.2.0
sparc64              randconfig-001-20250109    gcc-14.2.0
sparc64              randconfig-002-20250109    gcc-14.2.0
um                   randconfig-001-20250109    gcc-12
um                   randconfig-002-20250109    gcc-12
x86_64     buildonly-randconfig-001-20250109    clang-19
x86_64     buildonly-randconfig-002-20250109    gcc-12
x86_64     buildonly-randconfig-003-20250109    clang-19
x86_64     buildonly-randconfig-004-20250109    clang-19
x86_64     buildonly-randconfig-005-20250109    clang-19
x86_64     buildonly-randconfig-006-20250109    gcc-12
xtensa               randconfig-001-20250109    gcc-14.2.0
xtensa               randconfig-002-20250109    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
