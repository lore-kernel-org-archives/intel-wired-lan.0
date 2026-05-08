Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F53CD3445
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 May 2026 14:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A39061654;
	Fri,  8 May 2026 14:55:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EDrR9OBVBgIX; Fri,  8 May 2026 14:55:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 517B961655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778252113;
	bh=TKe7+ttdQuNunzYiSEjR6WtOnaHEmXws3+Tbxyp9q/A=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eKZ1lo7K4oXO3piVnLiWdMM7gFbkjeu26O9JZR9g+2ZyqBBOi4OjfvlDfdEUTHUqz
	 iDuXDP9zyXUuEy5qcillG1rjxee2ppS7RP11YU2/Vih9zZwjf6EdIcqPhATT/9dk+2
	 sB/P57OE+L6QdZXGNARd2FQ/VYpKiLbLEmH3w3XQ8/PUO1Onc7N95cONdiGyUTJtYx
	 Hu4HCGEyNIzmARLhFovg3T/J6jRjgZQ5l7NyLE+Q7Ri5fxg1X+sQ89u8xMkyF69NY8
	 8GhMnKSdp+G9Rk2m7+HY4CT9VENmKCQJ7Az9QZ5+m0CT0knCK0cqC2PivPRlB6iG6H
	 2CP4BEr+aSnTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 517B961655;
	Fri,  8 May 2026 14:55:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DE298358
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 14:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C37A78432E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 14:55:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D43wXiaRJPVd for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 May 2026 14:55:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DDA28842CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDA28842CA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDA28842CA
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 14:55:10 +0000 (UTC)
X-CSE-ConnectionGUID: BOw1SXWoS7KKGL8NOraREQ==
X-CSE-MsgGUID: F7GqxpS2RP61aCkmRg1Hug==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="66749351"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="66749351"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 07:55:10 -0700
X-CSE-ConnectionGUID: J9BaidW3Ql6XDifXRJvwmA==
X-CSE-MsgGUID: FQMhQ9UvT8iHzhabBEXAAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="238570801"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
 by fmviesa004.fm.intel.com with ESMTP; 08 May 2026 07:55:08 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wLMba-000000000DV-18s4;
 Fri, 08 May 2026 14:55:06 +0000
Date: Fri, 08 May 2026 22:54:16 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202605082210.IaLKC9wL-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778252111; x=1809788111;
 h=date:from:to:subject:message-id;
 bh=iFVhUeqMak/2L3rlgbdpxtluUrU7WRPP7uIhVO/VZtc=;
 b=RT6RQRt1Ii+SEV7gnzf5M6AVtsSJ32KnY7JgGIMYRHNJdxDcSiv4xlZ1
 MyUbaL40meCa+oAska9XafQmXa1zpvGCOwNlaKr1FKiHkyBGX+6VxdG5k
 N8qKa8e/iVKUNBH/a/cekyV4gGj0Vtuk22+eh8/tv2bb+/2f1TVBvh6/E
 aPOqnoofA+TQk6D6hSwuwJ+J1YXdz/04ZiGdtt9+SbNUJJBMrUMzLRFT0
 JYeZevmLjQl4ZrvODH2yuPKkwazeiVL/j+/ZHVYeswJLRr+Tx7GZPosfr
 EPf7EjwUdqvpVWwt50kIWIDLlFFp6AfFHXq+wEU9P2G3JTphqXsRNk+7k
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RT6RQRt1
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 96ad134fe38780bc13f4e134fa00beea83ab3a10
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
branch HEAD: 96ad134fe38780bc13f4e134fa00beea83ab3a10  ice: add support for transmitting unreadable frags

elapsed time: 809m

configs tested: 131
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260508    gcc-13.4.0
arc                   randconfig-002-20260508    gcc-12.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260508    gcc-8.5.0
arm                   randconfig-002-20260508    gcc-10.5.0
arm                   randconfig-003-20260508    gcc-14.3.0
arm                   randconfig-004-20260508    gcc-13.4.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260508    clang-23
hexagon               randconfig-002-20260508    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260508    gcc-14
i386        buildonly-randconfig-002-20260508    clang-20
i386        buildonly-randconfig-003-20260508    gcc-14
i386        buildonly-randconfig-004-20260508    clang-20
i386        buildonly-randconfig-005-20260508    gcc-14
i386        buildonly-randconfig-006-20260508    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260508    clang-20
i386                  randconfig-002-20260508    gcc-14
i386                  randconfig-003-20260508    clang-20
i386                  randconfig-004-20260508    gcc-14
i386                  randconfig-005-20260508    gcc-12
i386                  randconfig-006-20260508    gcc-14
i386                  randconfig-007-20260508    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260508    clang-23
loongarch             randconfig-002-20260508    gcc-12.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260508    gcc-11.5.0
nios2                 randconfig-002-20260508    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260508    gcc-9.5.0
parisc                randconfig-002-20260508    gcc-15.2.0
parisc64                            defconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260508    gcc-15.2.0
powerpc               randconfig-002-20260508    gcc-8.5.0
powerpc                     tqm8555_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260508    clang-19
powerpc64             randconfig-002-20260508    clang-20
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260508    gcc-12.5.0
sparc                 randconfig-002-20260508    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260508    gcc-8.5.0
sparc64               randconfig-002-20260508    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260508    gcc-12
um                    randconfig-002-20260508    clang-23
um                           x86_64_defconfig    clang-23
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260508    gcc-14
x86_64      buildonly-randconfig-002-20260508    clang-20
x86_64      buildonly-randconfig-003-20260508    gcc-14
x86_64      buildonly-randconfig-004-20260508    clang-20
x86_64      buildonly-randconfig-005-20260508    gcc-14
x86_64      buildonly-randconfig-006-20260508    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260508    gcc-14
x86_64                randconfig-003-20260508    clang-20
x86_64                randconfig-004-20260508    gcc-14
x86_64                randconfig-005-20260508    clang-20
x86_64                randconfig-006-20260508    gcc-14
x86_64                randconfig-011-20260508    gcc-14
x86_64                randconfig-012-20260508    clang-20
x86_64                randconfig-013-20260508    gcc-14
x86_64                randconfig-014-20260508    gcc-14
x86_64                randconfig-015-20260508    gcc-14
x86_64                randconfig-016-20260508    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260508    gcc-14.3.0
xtensa                randconfig-002-20260508    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
