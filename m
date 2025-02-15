Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5444C021A0
	for <intel-wired-lan@archiver.kernel.org>; Sat, 15 Feb 2025 20:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 797288377F;
	Sat, 15 Feb 2025 20:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mmzg4M0RqPd8; Sat, 15 Feb 2025 20:16:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A1D983231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1739650594;
	bh=DJDzNvaYWrIxMVItQKn6iQsntQjYx/1hv52+3Zx79h4=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mICs9LZpRZ6xIMDlWSDwcOs/kv+Lv636iJ91xbL8opL7JYpyR1V20IXbZtvMuDNoS
	 9pgbgfUSdWPP/mbXoMhdVUWE0xwA/bJl93gVWSaSs08axuY1UyKWQ+CuwgTzrPBvcD
	 2HCk5+3zwGYiH7yMifsTnWv8iySxh9TEe4HS+1+e8CsrRHfDGii/9R4sexFPurrJFB
	 QolRQlQpV566e9mW+7oE5CsBTq9k/dv53hfPzJhMlToqT2tYLdMzWwTW6MGhEhseo5
	 6ZpGG8uZmgeiP1+MGk6QfkEHU4/zEjtQxxVc0Raon9FMOZBadubhILM6QprFhyVXn5
	 j79cp0j9GPx9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A1D983231;
	Sat, 15 Feb 2025 20:16:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B848DF
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Feb 2025 20:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA8614012B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Feb 2025 20:16:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1s6uqU3QfvQG for <intel-wired-lan@lists.osuosl.org>;
 Sat, 15 Feb 2025 20:16:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 755C54052D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 755C54052D
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 755C54052D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Feb 2025 20:16:29 +0000 (UTC)
X-CSE-ConnectionGUID: YhcM7TxpTuaIZqfjfHnjFQ==
X-CSE-MsgGUID: HOUeiHL4TtyvAtbwJPDiiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="51002232"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; d="scan'208";a="51002232"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Feb 2025 12:16:28 -0800
X-CSE-ConnectionGUID: ymAGBEuiQAGwzbQvf3audg==
X-CSE-MsgGUID: w3MCjIdaRY6V5b9Z0IxhEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="113619020"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
 by orviesa010.jf.intel.com with ESMTP; 15 Feb 2025 12:16:27 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1tjOaO-001B9F-1P
 for intel-wired-lan@lists.osuosl.org; Sat, 15 Feb 2025 20:16:24 +0000
Date: Sun, 16 Feb 2025 04:15:44 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202502160438.SJf2T9NG-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739650589; x=1771186589;
 h=date:from:to:subject:message-id;
 bh=kPs+1MoP/eUqdcCA1S++yHFxo+oBvPZwYEOI1XzlYE4=;
 b=WYgnVh7MykcCQPfkqXHHBAy2ynDRSkRgUYn1MbHHPhd7j4LM8oUyzsCQ
 K8kBKFd92M1Ut8fT8hiLjxmw3InQ0S5BMjWVbnXO8qwwHd6tfE6lzGgrz
 KRAKtmj0G+xBokq0jCGD3UtQehIPim5DLHkxDsNCGpkaiabXiC003X1WJ
 sOWWkPQ3LB0uoLi8jlXxgFXw6z2PHQi2HdGOFRD9WZmro2azYFB3ngyXm
 YRcweJBKtQ0+dOaHec9DgV1avZN+L4RMlU+esdyRPUbFwSHJldTrchv0m
 RmdmNja3tU5eejUg/L0JqFNyRKrJemSdqeuQg8VLYZWzonK1q/q6WkvVt
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WYgnVh7M
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 4e783332257eb35229a08fe8e9c6252d63101fac
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
branch HEAD: 4e783332257eb35229a08fe8e9c6252d63101fac  iavf: fix circular lock dependency with netdev_lock

elapsed time: 1450m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250215    gcc-13.2.0
arc                   randconfig-002-20250215    gcc-13.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                   randconfig-001-20250215    clang-15
arm                   randconfig-002-20250215    clang-17
arm                   randconfig-003-20250215    gcc-14.2.0
arm                   randconfig-004-20250215    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250215    clang-21
arm64                 randconfig-002-20250215    gcc-14.2.0
arm64                 randconfig-003-20250215    clang-17
arm64                 randconfig-004-20250215    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250215    gcc-14.2.0
csky                  randconfig-001-20250216    clang-15
csky                  randconfig-002-20250215    gcc-14.2.0
csky                  randconfig-002-20250216    clang-15
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250215    clang-21
hexagon               randconfig-001-20250216    clang-15
hexagon               randconfig-002-20250215    clang-21
hexagon               randconfig-002-20250216    clang-15
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250215    gcc-12
i386        buildonly-randconfig-002-20250215    clang-19
i386        buildonly-randconfig-003-20250215    clang-19
i386        buildonly-randconfig-004-20250215    gcc-12
i386        buildonly-randconfig-005-20250215    clang-19
i386        buildonly-randconfig-006-20250215    clang-19
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250215    gcc-14.2.0
loongarch             randconfig-001-20250216    clang-15
loongarch             randconfig-002-20250215    gcc-14.2.0
loongarch             randconfig-002-20250216    clang-15
m68k                              allnoconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250215    gcc-14.2.0
nios2                 randconfig-001-20250216    clang-15
nios2                 randconfig-002-20250215    gcc-14.2.0
nios2                 randconfig-002-20250216    clang-15
openrisc                          allnoconfig    clang-21
parisc                            allnoconfig    clang-21
parisc                randconfig-001-20250215    gcc-14.2.0
parisc                randconfig-001-20250216    clang-15
parisc                randconfig-002-20250215    gcc-14.2.0
parisc                randconfig-002-20250216    clang-15
parisc64                            defconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-21
powerpc               randconfig-001-20250215    gcc-14.2.0
powerpc               randconfig-001-20250216    clang-15
powerpc               randconfig-002-20250215    clang-21
powerpc               randconfig-002-20250216    clang-15
powerpc               randconfig-003-20250215    clang-19
powerpc               randconfig-003-20250216    clang-15
powerpc64             randconfig-001-20250215    gcc-14.2.0
powerpc64             randconfig-001-20250216    clang-15
powerpc64             randconfig-002-20250215    clang-21
powerpc64             randconfig-002-20250216    clang-15
powerpc64             randconfig-003-20250215    gcc-14.2.0
powerpc64             randconfig-003-20250216    clang-15
riscv                             allnoconfig    clang-21
riscv                 randconfig-001-20250215    clang-17
riscv                 randconfig-002-20250215    clang-19
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250215    gcc-14.2.0
s390                  randconfig-002-20250215    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250215    gcc-14.2.0
sh                    randconfig-002-20250215    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250215    gcc-14.2.0
sparc                 randconfig-002-20250215    gcc-14.2.0
sparc64               randconfig-001-20250215    gcc-14.2.0
sparc64               randconfig-002-20250215    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250215    clang-21
um                    randconfig-002-20250215    clang-19
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250215    gcc-12
x86_64      buildonly-randconfig-001-20250216    gcc-12
x86_64      buildonly-randconfig-002-20250215    clang-19
x86_64      buildonly-randconfig-002-20250216    gcc-12
x86_64      buildonly-randconfig-003-20250215    gcc-12
x86_64      buildonly-randconfig-003-20250216    gcc-12
x86_64      buildonly-randconfig-004-20250215    clang-19
x86_64      buildonly-randconfig-004-20250216    gcc-12
x86_64      buildonly-randconfig-005-20250215    clang-19
x86_64      buildonly-randconfig-005-20250216    gcc-12
x86_64      buildonly-randconfig-006-20250215    clang-19
x86_64      buildonly-randconfig-006-20250216    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250215    gcc-14.2.0
xtensa                randconfig-002-20250215    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
