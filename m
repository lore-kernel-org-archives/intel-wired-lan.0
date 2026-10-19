Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAD8CCF2D6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 11:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E29980F19;
	Mon, 19 Oct 2026 11:25:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KZlPxNEbErCq; Mon, 19 Oct 2026 11:25:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EE7F480F24
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792409148;
	b=h1VMNHpS6bS44AZBA2ZpZFq9fObJ3xnmkVlocd974vtvy6e1xkDIbiVyOhbj9o+taEjZ
	 AzrtUr16vAU9Ps8/oOYaKr+KJKq+B/5nnvwfBNSuWQFttNY8RTcLTlSq1qejGpy5owr4u
	 TWqc7lpi4WDzoh2wSnqlx4DC+bh3zYySHOljRYD3d7e2ECSNkH6JNNfCb8Br966KcdGqw
	 dkEZit5UWq9OdNJalnjKBqKCmdiq3nleCjp4aKFBchYLFFHi6beR6G5lrHhrbvbBjqnLo
	 IYZDMngi/i+O85fG0rmuV/+BW8uM30tOGYDMPJrsYaM10qMuov145H6M3mYPiq3YGYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792409148;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qa7n3m2ecRwk+tDfJIfIq+CMZKXrYnNFIUESBaWIaqo=;
	b=M0w3OzMpxRatLgv5PjSuhdKLBnE2NG5RwMpkcEuulOp/MYScTXEd7Y+Rl85WUc6nNihx
	 jKZS3Sg93VRXiJ7tFUIOrY9Eze8XP7815SzMuQHuEagf95hLvceTKJQK3ayuLNopKNoFD
	 c4mfhbkWSrMxwi2faxaVkbFzQNamerWf2th5TP9okqeFtUCEqMTCjfH7xOuXMmuYGQm6P
	 jKnD+rSn7WEB/qikogmrElb1bKcmGJfnlBDpuiyWh8ApqogDeFxnC1bZQhM9U/NHmFqwc
	 NQh9HE3gm+NUXo11AB0Fy/Sj/bMQaAkSPdFbbuU+nCPSu1xkmLbC2ybULSkW6+I4ltQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m3CpdNNz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792409148;
	bh=qa7n3m2ecRwk+tDfJIfIq+CMZKXrYnNFIUESBaWIaqo=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HhzdBCSDyQJbI1EHKOEbskxIGY6rZqjOcVPWc2pL9ce7581xR5Rb+yiTx6IKbcJnU
	 2niKUpNO0+KeTiV69vmrwxdRJ+spXvl/ljf3alKPNwrPiTAl5Rp3j7jxKWyR7ksKG1
	 AtgCtfL3N04l6AsUhV7oReH/afwzIbFNmN7yK7R3+L4KL5A4yqeI3/1frCiwk0I3WH
	 YDyQgEIfynWWm3YdZLekRmh6o3aSVQMMULaDP8UPec+LuAu47ApTAnj2lJKaYqNC8o
	 NRGpNtuAAZdp0UmQPS43ZiCCqOc6IGBIcmKDiMh+EWaGyYhDPO4la/4xohkIRrHl3B
	 TpY7PP30jMKNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE7F480F24;
	Mon, 19 Oct 2026 11:25:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 70CCE263
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 11:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 629CF80F19
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 11:25:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9iESWeCo2GDO for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 11:25:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3895E80F21
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792409145;
 b=WKxcx7s0NqLzzPdLdhG2/VMDbcDnqEvqBB6lIzrU0+iibnBwgQDuF5uOepMSzq/n+uAa
 79J6Zca4hHOIWd4eMUGd7BBm9UGTJAAzJ/VvEKSXD6qkqcLHKQa/wXBkD4t/drCVwAmDz
 e2l0+73jPBMreqJGejLo5yPLbSeM2OuCNxkbmLUrg6sUfCnlAFLAXX1aXa7E8geEQe9m3
 aT3gGW0tQtDmIr5m5hQs2zVKGLGtipKJ5wkklR3nTO19UMpP0up2BPkHB5D4EAqi8TxOo
 J5n5LwEPYaSNTzdjUVn1PhGMOilH2T822C+KTwexfqDOfwARJVPvJdSpAxnuTU+Bz2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792409145;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=qa7n3m2ecRwk+tDfJIfIq+CMZKXrYnNFIUESBaWIaqo=;
 b=pYDq6/ZK5I9RArsDJewYP/BMsf/ZI+2K1RLbEQwq7SSPs8CfVwqxAvf+w5ngxjKbICZc
 DvayuQlNcsOGv8KsW53xKK4t00K9qNO8XRpEH4xOLMQkfamg7DzjKXYTrk4crGUjW5BnK
 lWY544xMh4sB3L/ycJaT/aVTVh4jTCipDqXl+ZCLrzzOy25c4lkFMdop1aZjb80IKUhiE
 IhmjiiiurY7XW8LuV00Xf5YXdknbuapVhTNuaoWkd/WDRu3ZeXzvFba6/c95Ta4kA62hP
 LxjLJGgviSGKI2L11miI57mP18LcJG2wxQ4VCikVXjqjffD0gdvy3GWjiOYxVHfLURg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=m3CpdNNz; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=m3CpdNNz
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3895E80F21
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 11:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792409146; x=1823945146; h=date:from:to:subject:message-id;
 bh=0BytzB9YyT2lU53e9AcqFbtuxuqyRQ0/MqoSgC8MFow=;
 b=m3CpdNNzNvpV68oUQdbQFrObohkDQooHSlBk1G3Wh1HJUupRvx1GI7Xv
 PpFeQnhZ4rkwIMbexkfJJ+48qNiArefSNIArOOxDDo5ES6OA1wbAnR7Pj
 kHGC+/lzuW+JdpD4gNYJC2m1fcet9YMa61sGHUNGhpWyO72+VeUNpRRJ2
 yOVJZyvLih8V5FPoLo1/riP5vy9oJobXAUhIS1O21sxKLfsw6PJSTtyX9
 W9upRECH+YSUKtGKBAwqfERHzHCATNRagUf5yn2FO8lL9RvZCC2sh0u/O
 Axg6rGZ8KX7tb005UcmTOMo6CqE5JH69kez7Pf+oflLogC8Li3vgbQMfA A==;
X-CSE-ConnectionGUID: OQY2ySZJT5WoQy7NKvP6YQ==
X-CSE-MsgGUID: KEcswaazR5OqovNIkq2+Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="981261"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="981261"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 04:25:45 -0700
X-CSE-ConnectionGUID: NP7jUgBfTHi7KXXSVmkO/Q==
X-CSE-MsgGUID: wPbhICeLTBOWSH3LRCm4Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2511245"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa004.jf.intel.com with ESMTP; 19 Oct 2026 04:25:43 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xIlUq-00000000Lag-48Ue;
 Mon, 19 Oct 2026 11:25:40 +0000
Date: Mon, 19 Oct 2026 19:25:10 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 0344a46e40a46947f630e1bd3ea875e093dfa54f
Message-ID: <202610191907.Zr0RQUyY-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 0344a46e40a46947f630e1bd3ea875e093dfa54f  ice: Release control PF lock before RCU wait

elapsed time: 1776m

configs tested: 209
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261019    clang-21
arc                   randconfig-1001-20261019    clang-21
arc                  randconfig-r2105-20261018    gcc-13.5.0 cocci
arc                  randconfig-r2300-20261018    gcc-13.5.0 sparse
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                   randconfig-1000-20261019    clang-21
arm                   randconfig-1001-20261019    clang-21
arm                   randconfig-1002-20261019    clang-21
arm                   randconfig-1003-20261019    clang-21
arm                  randconfig-r2107-20261018    gcc-10.5.0 cocci
arm                  randconfig-r2111-20261018    clang-17   cocci
arm                  randconfig-r2306-20261018    clang-17   sparse
arm                  randconfig-r2311-20261018    clang-17   sparse
arm                        spear13xx_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261019    clang-24
arm64                 randconfig-1001-20261019    clang-24
arm64                 randconfig-1002-20261019    clang-24
arm64                 randconfig-1003-20261019    clang-24
arm64                 randconfig-2000-20261018    gcc-11.5.0
arm64                 randconfig-2001-20261018    gcc-13.4.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261019    clang-24
csky                  randconfig-1001-20261019    clang-24
csky                  randconfig-2000-20261018    gcc-12.5.0
csky                  randconfig-2001-20261018    gcc-14.3.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261019    clang-24
hexagon               randconfig-1001-20261019    clang-24
hexagon               randconfig-2000-20261018    clang-24
hexagon               randconfig-2001-20261018    clang-24
hexagon              randconfig-r2202-20261018    clang-24   smatch
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261019    clang-22
i386        buildonly-randconfig-1001-20261019    clang-22
i386        buildonly-randconfig-1002-20261019    clang-22
i386        buildonly-randconfig-1003-20261019    clang-22
i386        buildonly-randconfig-1004-20261019    clang-22
i386        buildonly-randconfig-1005-20261019    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261019    clang-22
i386                  randconfig-1001-20261019    clang-22
i386                  randconfig-1002-20261019    clang-22
i386                  randconfig-1003-20261019    clang-22
i386                  randconfig-1004-20261019    clang-22
i386                  randconfig-1005-20261019    clang-22
i386                  randconfig-1006-20261019    clang-22
i386                  randconfig-1007-20261019    gcc-14
i386                  randconfig-1008-20261019    gcc-14
i386                  randconfig-1009-20261019    gcc-14
i386                  randconfig-1010-20261019    gcc-14
i386                  randconfig-1011-20261019    gcc-14
i386                  randconfig-1012-20261019    gcc-14
i386                  randconfig-1013-20261019    gcc-14
i386                  randconfig-2200-20261018    gcc-14     smatch
i386                 randconfig-r2304-20261018    gcc-14     sparse
i386                 randconfig-r2307-20261018    clang-22   sparse
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson32_defconfig    clang-24
loongarch             randconfig-1000-20261019    clang-24
loongarch             randconfig-1001-20261019    clang-24
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                 randconfig-r2106-20261018    gcc-8.5.0  cocci
nios2                             allmodconfig    clang-20
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261019    clang-24
nios2                 randconfig-1001-20261019    clang-24
nios2                randconfig-r2302-20261018    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                          allmodconfig    gcc-16.2.0
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc             randconfig-r2110-20261018    gcc-16.2.0 cocci
openrisc             randconfig-r2201-20261018    gcc-16.2.0 smatch
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261019    gcc-8.5.0
parisc                randconfig-1001-20261019    gcc-8.5.0
parisc               randconfig-r2305-20261018    gcc-13.5.0 sparse
parisc               randconfig-r2308-20261018    gcc-11.5.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       cm5200_defconfig    clang-24
powerpc               randconfig-1000-20261019    gcc-8.5.0
powerpc               randconfig-1001-20261019    gcc-8.5.0
powerpc                      tqm8548_defconfig    clang-24
powerpc64             randconfig-1000-20261019    gcc-8.5.0
powerpc64             randconfig-1001-20261019    gcc-8.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261019    gcc-11.5.0
riscv                 randconfig-1001-20261019    gcc-11.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261019    gcc-11.5.0
s390                  randconfig-1001-20261019    gcc-11.5.0
s390                 randconfig-r2104-20261018    clang-18   cocci
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                           landisk_defconfig    clang-24
sh                           r7785rp_defconfig    clang-24
sh                    randconfig-1000-20261019    gcc-11.5.0
sh                    randconfig-1001-20261019    gcc-11.5.0
sh                   randconfig-r2301-20261018    gcc-12.5.0 sparse
sh                   randconfig-r2309-20261018    gcc-16.2.0 sparse
sh                         sh7757lcr_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261019    clang-20
sparc                 randconfig-1001-20261019    clang-20
sparc                randconfig-r2200-20261018    gcc-8.5.0  smatch
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261019    clang-20
sparc64               randconfig-1001-20261019    clang-20
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261019    clang-20
um                    randconfig-1001-20261019    clang-20
um                   randconfig-r2303-20261018    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261019    clang-22
x86_64      buildonly-randconfig-1001-20261019    clang-22
x86_64      buildonly-randconfig-1002-20261019    clang-22
x86_64      buildonly-randconfig-1003-20261019    clang-22
x86_64      buildonly-randconfig-1004-20261019    clang-22
x86_64      buildonly-randconfig-1005-20261019    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261019    clang-22
x86_64                randconfig-1001-20261019    clang-22
x86_64                randconfig-1002-20261019    clang-22
x86_64                randconfig-1003-20261019    clang-22
x86_64                randconfig-1004-20261019    clang-22
x86_64                randconfig-1005-20261019    clang-22
x86_64                randconfig-1006-20261019    clang-22
x86_64                randconfig-1007-20261019    clang-22
x86_64                randconfig-1008-20261019    clang-22
x86_64                randconfig-1009-20261019    clang-22
x86_64                randconfig-1010-20261019    clang-22
x86_64                randconfig-1011-20261019    clang-22
x86_64                randconfig-1012-20261019    gcc-14
x86_64                randconfig-1013-20261019    gcc-14
x86_64                randconfig-1014-20261019    gcc-14
x86_64                randconfig-1015-20261019    gcc-14
x86_64                randconfig-1016-20261019    gcc-14
x86_64                randconfig-1017-20261019    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                            allyesconfig    gcc-16.2.0
xtensa                randconfig-1000-20261019    clang-20
xtensa                randconfig-1001-20261019    clang-20
xtensa               randconfig-r2310-20261018    gcc-10.5.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
