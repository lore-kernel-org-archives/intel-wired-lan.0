Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2864060A2603
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=2/iJzwYX;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cedgbX7i
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 030B360657;
	Wed, 11 Nov 2026 08:59:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xAEwzGOGjW5u; Wed, 11 Nov 2026 08:59:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BD6BD6067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794387589;
	b=hM4/laabhcLWdDqxGwO8EkUJvz1ZKU/LQTGzm6fzDi+wV5L91alzXgtIvfCkIOKXVByM
	 yBNktvYLFrn4v0W9S/H15ZfSy5giRS9uLq6sDd6WABZIthzT8vCJgxRFYp8jm7qH3KDK7
	 +A+LzMw7cODqLbpMVGPYD81RqTAa9/Ft07pR2VaQ8k/vb7yiddQx289gvXNdtjUi5/Btt
	 no771QSeWw/SHCxJsbxbevu8IxyU0qOqvuzS+cz8cn2NY3WXlySHvPFruDl6StDMDuprJ
	 w1gw5OTc2Bw9wEEU2giT3H7ssy93H8AD02uz9GyExQ4hISY1byXPgAZSdTTQAXjJHtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794387589;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ssOWQ2grqPmr3BRISE4V4NAIXzNMIIlqBJZXpUPGoaI=;
	b=lIzJqdFEMApOVxfiKxIDosJBpY0huHaFVY1FpQwZb/STyGKRfb13s8q1j+Kcszn3x5qS
	 NcQx+Dv6n7zmwJen0bvx9WqvKUcZwqUVXUeGYNOjmSC1vLGkzZr1LHqxBjl8Pg2sl3th7
	 uNIXu6D/k0jrQjgk1rZBYmDnJNvIH5ZpExC6M8W7H2IrKc9xY/tZDpP2LJNaO9Bs8/gNK
	 +/wou6evaoot4ar3xkSpw7DOH9E6aCnT0kssl9olqdbreqR+YjEm30PLCWB84MKwHpxpk
	 rC2pBvQZ7gi/za6iRyPxg0Bgy/0PFzfHZHeCOd1GlhRHxd2Gy8JjcWDpBjfEVVyUD8A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794387589;
	bh=ssOWQ2grqPmr3BRISE4V4NAIXzNMIIlqBJZXpUPGoaI=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2/iJzwYXAHmvr7g1QqQKn74EjpszqxReV8e7py+dmqb67/CFm0qmy2VpPGacokEBy
	 x+pLgvNq8gbD4GDDvHm+qdMrxmdBltt2XkL/vSrVL0Jhwb9aPo0VQz2GtuIOxVNbBM
	 dwlbmTAt2/0LIX67qgTlqgMYf+JO1/JunE5MVXHEp/oEibnwIFxEeRvuFNmyg44Iq+
	 Z/IIQFilSAS/08OXUQgvFIhzT/Zwe3UOA9etLaIvgLJW8zWwhxXUuSWnqteCxkso/i
	 25PLxnzD5W/rqb9p7q2jKecixvR1R/L8Oj6tbEa5aV7QC152h82dL+ZF+D4QL7Kk9v
	 u8P1rZcHEi4YA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD6BD6067D;
	Wed, 11 Nov 2026 08:59:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 439BA28C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 08:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 294B640318
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 08:59:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3XZKA4lcNpfT for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 08:59:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D137B40070
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cedgbX7i
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D137B40070
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 08:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794387587; x=1825923587; h=date:from:to:subject:message-id;
 bh=4yoYgVdfJP1uC3/VvZS//e2Zz4cTUrl4qNJVZxFgK2w=;
 b=cedgbX7isZOAFJlyTyks27ClSE59ACGfJNVEVkM5FjK+gY5uIBZCB/3a
 Pbgwc6zVkjT9+Qbu9sKImOfzgmTRZxbFGjPqbQ4+qfMNLvN40sWi4BFDL
 PbfnnBW8FbRo8d7vbhqn8FOR5nZ3RDyK/i2gWXfRm5R5RjNIGhOryVqyZ
 r7c/+d7K9DQjrG4BiUJa3d/GVU2FeonvGq7o5KaLUGV4SVJO4YWbC4E8v
 Rhk1bbY/N/SQELu8VJf7wfCb9zJeWex2lMzUQQ4qiODTCNxOVUfm2j4om
 jGmQjIeLZFqscOME0cmRYXDlZFp5uE+D7BQwn+wF24lPjNa+Ydc61f88O Q==;
X-CSE-ConnectionGUID: NbVuZaFdTOq9oyL1A2xI5Q==
X-CSE-MsgGUID: MIXFudMPRien5SUgc35vMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3160365"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3160365"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 00:59:45 -0800
X-CSE-ConnectionGUID: DdV/jEy8QFOhAoQvzro3+Q==
X-CSE-MsgGUID: pyPxa21OSce/xHYT7BOv4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8372034"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa002.jf.intel.com with ESMTP; 11 Nov 2026 00:59:44 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xR4BB-00000000yUr-29AU;
 Wed, 11 Nov 2026 08:59:41 +0000
Date: Wed, 11 Nov 2026 16:59:18 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:main] BUILD SUCCESS
 8373c4e8863ac5f5120d200527aca9880330f343
Message-ID: <20261111165918.aDQOPSU2-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git main
branch HEAD: 8373c4e8863ac5f5120d200527aca9880330f343  MAINTAINERS: Add Hidayath as net/iucv maintainer

elapsed time: 1006m

configs tested: 293
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2200-20261110    gcc-9.5.0  smatch
alpha                randconfig-r2109-20261110    clang-24   cocci
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                         nsimosci_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261111    gcc-15.3.0
arc                   randconfig-1001-20261111    gcc-15.3.0
arc                   randconfig-2000-20261110    gcc-8.5.0
arc                   randconfig-2001-20261110    gcc-8.5.0
arc                   randconfig-2002-20261110    gcc-8.5.0
arc                   randconfig-2003-20261110    gcc-8.5.0
arc                   randconfig-2004-20261110    gcc-8.5.0
arc                   randconfig-2005-20261110    gcc-8.5.0
arc                   randconfig-2200-20261110    gcc-8.5.0  smatch
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          bcm2835_defconfig    gcc-16.2.0
arm                      davinci_all_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                       footbridge_defconfig    gcc-16.2.0
arm                         mvebu_v7_defconfig    clang-24
arm                         mvebu_v7_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261111    gcc-15.3.0
arm                   randconfig-1001-20261111    gcc-15.3.0
arm                   randconfig-1002-20261111    gcc-15.3.0
arm                   randconfig-1003-20261111    gcc-15.3.0
arm                   randconfig-2200-20261110    gcc-11.5.0 smatch
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261111    gcc-13.5.0
arm64                 randconfig-1001-20261111    gcc-13.5.0
arm64                 randconfig-1002-20261111    gcc-13.5.0
arm64                 randconfig-1003-20261111    gcc-13.5.0
arm64                 randconfig-2200-20261110    clang-24   smatch
arm64                randconfig-r2106-20261110    clang-24   cocci
arm64                randconfig-r2108-20261110    clang-24   cocci
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261111    gcc-13.5.0
csky                  randconfig-1001-20261111    gcc-13.5.0
csky                  randconfig-2000-20261110    gcc-11.5.0
csky                  randconfig-2001-20261110    gcc-11.5.0
csky                  randconfig-2200-20261110    gcc-16.2.0 smatch
csky                 randconfig-r2110-20261110    clang-24   cocci
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261111    clang-17
hexagon               randconfig-1001-20261111    clang-17
hexagon               randconfig-2000-20261110    gcc-11.5.0
hexagon               randconfig-2001-20261110    gcc-11.5.0
hexagon               randconfig-2200-20261110    clang-24   smatch
hexagon              randconfig-r2111-20261110    clang-24   cocci
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261111    clang-22
i386        buildonly-randconfig-1001-20261111    clang-22
i386        buildonly-randconfig-1002-20261111    clang-22
i386        buildonly-randconfig-1003-20261111    clang-22
i386        buildonly-randconfig-1004-20261111    clang-22
i386        buildonly-randconfig-1005-20261111    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261111    gcc-13
i386                  randconfig-1001-20261111    gcc-13
i386                  randconfig-1002-20261111    gcc-13
i386                  randconfig-1003-20261111    gcc-13
i386                  randconfig-1004-20261111    gcc-13
i386                  randconfig-1005-20261111    gcc-13
i386                  randconfig-1006-20261111    gcc-13
i386                  randconfig-1007-20261111    clang-22
i386                  randconfig-1008-20261111    clang-22
i386                  randconfig-1009-20261111    clang-22
i386                  randconfig-1010-20261111    clang-22
i386                  randconfig-1011-20261111    clang-22
i386                  randconfig-1012-20261111    clang-22
i386                  randconfig-1013-20261111    clang-22
i386                  randconfig-2200-20261110    gcc-13     smatch
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261111    clang-17
loongarch             randconfig-1001-20261111    clang-17
loongarch             randconfig-2000-20261110    gcc-11.5.0
loongarch             randconfig-2001-20261110    gcc-11.5.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    gcc-16.2.0
m68k                           atari_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                  randconfig-2200-20261110    gcc-16.2.0 smatch
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2200-20261110    gcc-8.5.0  smatch
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                      decstation_defconfig    gcc-16.2.0
mips                           eyeq6_defconfig    clang-24
mips                             gpr_defconfig    clang-24
mips                        lemote2f_defconfig    clang-24
mips                            mtx1_defconfig    clang-24
mips                  randconfig-2000-20261110    gcc-16.2.0
mips                  randconfig-2001-20261110    gcc-16.2.0
mips                  randconfig-2002-20261110    gcc-16.2.0
mips                  randconfig-2200-20261110    clang-17   smatch
mips                 randconfig-r2309-20261110    clang-24   sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261111    clang-17
nios2                 randconfig-1001-20261111    clang-17
nios2                 randconfig-2000-20261110    gcc-11.5.0
nios2                 randconfig-2001-20261110    gcc-11.5.0
nios2                 randconfig-2200-20261110    gcc-11.5.0 smatch
openrisc                          alldefconfig    gcc-16.2.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261110    gcc-16.2.0
openrisc              randconfig-2001-20261110    gcc-16.2.0
openrisc              randconfig-2002-20261110    gcc-16.2.0
openrisc              randconfig-2200-20261110    gcc-9.5.0  smatch
openrisc             randconfig-r2109-20261110    clang-24   cocci
parisc                            alldefconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261111    gcc-15.3.0
parisc                randconfig-1001-20261111    gcc-15.3.0
parisc                randconfig-2000-20261110    gcc-11.5.0
parisc                randconfig-2001-20261110    gcc-11.5.0
parisc                randconfig-2200-20261110    gcc-15.3.0 smatch
parisc64                          alldefconfig    clang-24
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                        eiger_defconfig    gcc-16.2.0
powerpc                    microwatt_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261111    gcc-15.3.0
powerpc               randconfig-1001-20261111    gcc-15.3.0
powerpc               randconfig-2000-20261110    gcc-10.5.0
powerpc               randconfig-2001-20261110    gcc-10.5.0
powerpc               randconfig-2002-20261110    gcc-10.5.0
powerpc               randconfig-2200-20261110    clang-24   smatch
powerpc              randconfig-r2108-20261110    clang-24   cocci
powerpc              randconfig-r2111-20261110    clang-24   cocci
powerpc                      tqm8555_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261111    gcc-15.3.0
powerpc64             randconfig-1001-20261111    gcc-15.3.0
powerpc64             randconfig-2000-20261110    gcc-10.5.0
powerpc64             randconfig-2001-20261110    gcc-10.5.0
powerpc64             randconfig-2002-20261110    gcc-10.5.0
powerpc64             randconfig-2200-20261110    clang-24   smatch
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261111    clang-17
riscv                 randconfig-1001-20261111    clang-17
riscv                 randconfig-2000-20261110    gcc-12.5.0
riscv                 randconfig-2001-20261110    gcc-12.5.0
riscv                 randconfig-2002-20261110    gcc-12.5.0
riscv                 randconfig-2003-20261110    gcc-12.5.0
riscv                 randconfig-2004-20261110    gcc-12.5.0
riscv                 randconfig-2005-20261110    gcc-12.5.0
riscv                 randconfig-2200-20261110    gcc-8.5.0  smatch
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261111    clang-17
s390                  randconfig-1001-20261111    clang-17
s390                  randconfig-2000-20261110    clang-20
s390                  randconfig-2001-20261110    clang-20
s390                  randconfig-2002-20261110    clang-20
s390                  randconfig-2003-20261110    clang-20
s390                  randconfig-2004-20261110    clang-20
s390                  randconfig-2005-20261110    clang-20
s390                  randconfig-2200-20261110    clang-18   smatch
s390                 randconfig-r2107-20261110    clang-24   cocci
s390                 randconfig-r2308-20261110    clang-24   sparse
s390                 randconfig-r2311-20261110    clang-24   sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                 ecovec24-romimage_defconfig    gcc-16.2.0
sh                  kfr2r09-romimage_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261111    clang-17
sh                    randconfig-1001-20261111    clang-17
sh                    randconfig-2000-20261110    gcc-9.5.0
sh                    randconfig-2001-20261110    gcc-9.5.0
sh                    randconfig-2002-20261110    gcc-9.5.0
sh                    randconfig-2003-20261110    gcc-9.5.0
sh                    randconfig-2004-20261110    gcc-9.5.0
sh                    randconfig-2005-20261110    gcc-9.5.0
sh                    randconfig-2200-20261110    gcc-16.2.0 smatch
sh                    secureedge5410_defconfig    gcc-16.2.0
sh                               ul2_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261111    gcc-16.2.0
sparc                 randconfig-1001-20261111    gcc-16.2.0
sparc                 randconfig-2000-20261110    gcc-14
sparc                 randconfig-2001-20261110    gcc-14
sparc                 randconfig-2200-20261110    gcc-13.5.0 smatch
sparc                randconfig-r2107-20261110    clang-24   cocci
sparc                randconfig-r2307-20261110    clang-24   sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261111    gcc-16.2.0
sparc64               randconfig-1001-20261111    gcc-16.2.0
sparc64               randconfig-2000-20261110    gcc-14
sparc64               randconfig-2001-20261110    gcc-14
sparc64               randconfig-2200-20261110    clang-24   smatch
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261111    gcc-16.2.0
um                    randconfig-1001-20261111    gcc-16.2.0
um                    randconfig-2000-20261110    gcc-14
um                    randconfig-2001-20261110    gcc-14
um                    randconfig-2200-20261110    gcc-14     smatch
um                   randconfig-r2306-20261110    clang-24   sparse
um                   randconfig-r2310-20261110    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261111    gcc-14
x86_64      buildonly-randconfig-1001-20261111    gcc-14
x86_64      buildonly-randconfig-1002-20261111    gcc-14
x86_64      buildonly-randconfig-1003-20261111    gcc-14
x86_64      buildonly-randconfig-1004-20261111    gcc-14
x86_64      buildonly-randconfig-1005-20261111    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261111    clang-22
x86_64                randconfig-1001-20261111    clang-22
x86_64                randconfig-1002-20261111    clang-22
x86_64                randconfig-1003-20261111    clang-22
x86_64                randconfig-1004-20261111    clang-22
x86_64                randconfig-1005-20261111    clang-22
x86_64                randconfig-1006-20261111    clang-22
x86_64                randconfig-1007-20261111    clang-22
x86_64                randconfig-1008-20261111    clang-22
x86_64                randconfig-1009-20261111    clang-22
x86_64                randconfig-1010-20261111    clang-22
x86_64                randconfig-1011-20261111    clang-22
x86_64                randconfig-1012-20261111    gcc-14
x86_64                randconfig-1013-20261111    gcc-14
x86_64                randconfig-1014-20261111    gcc-14
x86_64                randconfig-1015-20261111    gcc-14
x86_64                randconfig-1016-20261111    gcc-14
x86_64                randconfig-1017-20261111    gcc-14
x86_64                randconfig-2000-20261110    clang-22
x86_64                randconfig-2001-20261110    clang-22
x86_64                randconfig-2002-20261110    clang-22
x86_64                randconfig-2003-20261110    clang-22
x86_64                randconfig-2004-20261110    clang-22
x86_64                randconfig-2005-20261110    clang-22
x86_64                randconfig-2200-20261110    gcc-14     smatch
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261111    gcc-16.2.0
xtensa                randconfig-1001-20261111    gcc-16.2.0
xtensa                randconfig-2000-20261110    gcc-11.5.0
xtensa                randconfig-2001-20261110    gcc-11.5.0
xtensa               randconfig-r2110-20261110    clang-24   cocci

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
