Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE10C982FA
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Sep 2026 03:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E682840563;
	Wed, 23 Sep 2026 03:13:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nN5saSlTIS6p; Wed, 23 Sep 2026 03:13:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E8D1D40587
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790133180;
	b=swAji2EgmwBaARgFhp8W2LBJYeoMEeTow4YJAnMU6bTMMzIF/JTf4HqkO5fU1W/x2SbA
	 RAPFeY7VazP8x8CbxEsW+GLmHUcQf+pwbNiNWjNhqZrSFz21pfPG0wLvpobEXrRgyRded
	 dCVIAWAgCfblUM1xlmzBv3gtc4uR5E1cxbK4cbEFcBf+VBsg1zxVs+U8k9ucoC/uZxCJ3
	 81W0oYNP2gpGOoQZBkCigchE5IR0kmQWLX9zBGDJhAJh5H3H4xyySUjHUO89ASl7Ct4CJ
	 X/VR6udOUj4QpQyuJ8zG+wLDE/CEl5c8aRJh7RtF5fgoiSJuNsiyemhb8NOMeD3XKYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790133180;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GPXKMtLTU6HODA1uCJAmdlMYRC2oC2DU4E17zPcal8E=;
	b=jQTuMU39mGWYTc518+kbYlMQvkOdJ+B4Xk3a60+70IYD2dvN5J8vSyIyMkkU9upETZpW
	 QGKtrOr/vgotbKQghDVZlo9M9ntg+aqXxQpZuf9/LW6F+DAWaBS/X1DbU9K3islPfsrUw
	 cN+YzNo4kNRqD76fkgcjnYweACY9/ks3JnpZhnrTrV0kbs2hVipPudngc9n+1OL+5Iu7B
	 3rkHorZ49ejh8FWN1jmRSJNprpNrlVc/S3/j+4oXN6if0z5Qb/qWN1dp5XdTvc8RNxLAl
	 K6PYfcapJpovSuU29aHyJV4KadaaEisbJaSxNIL23Mzgqx/uXhUSXAaHp7J4qrDc53g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790133180;
	bh=GPXKMtLTU6HODA1uCJAmdlMYRC2oC2DU4E17zPcal8E=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1mm+fIBdlANmG6S1Q09ZL83zw59V61Eapnj7xChineQaRpin8bwhNPUzHipKKzYWx
	 H79hE7IVBU4O0DaS1hwYPEIAHtPUP+DQvYZnAh0PHbIVNu4cShGGHJX7VV5vn/hKBG
	 /G9tsBb6nye3YwCaFfWCvgiIvBwxYjv+csWIGBVoeBETsVn9BoEiR/dfQaIxGqzoPi
	 +ze6u1LxmT75Q0QIQsUg+oT6HpmrjNfohK9V01DtbvgJirEL7pEiN09q/fjwnq0lDQ
	 bgFxzY2zAUfIN+8oAlFjWQpFY2IfBTBEOCCkZWmDlURS+0jb6FTtoZSot2TtNa80JP
	 lXi04DF0CgFLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8D1D40587;
	Wed, 23 Sep 2026 03:12:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 00943D1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 03:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E69928087C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 03:12:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mVbjQai9_OoA for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Sep 2026 03:12:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 91F938085F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790133176;
 b=rFu//NnkgU21uu3jSdcrWw84u+9p6zJ3pbNOQsn9EDWDEzyrk7pN+qgl21KQShZ/rv8Z
 diHwu/UxMbmcsjCh2yeH3IgD+8y/F6sVf9abzdg+vhOJIAaEVM5OyqBHfgDBJKBp6eYzK
 ch+wXtUCKLzH4dP+NiwbMjaLELrPdmaDUzAPDU0EW5EVJD8jgvonZNnFTuCe3+LaLMwft
 4g56JfNSJ0mlaAofl+OqNS80x0DncWZfh5twKJV1CpsL/ylJbETpmqPtioDCdAgsFcyua
 lWDnKDSYLm727ToXK8J6ps7iz4JwuG0rSOsIT3y0g19T/3MUNG5rLHBa2Y4JIOrYftQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790133176;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=GPXKMtLTU6HODA1uCJAmdlMYRC2oC2DU4E17zPcal8E=;
 b=XO+2oJpBrM/QVEPHLdSOPlOIh+FZ3WwTadqeTdjNIx21aDzCtJHU2Lw/t/xShzmrYnQ4
 WiWDWtZ1JBnibo4HWsB/n/kfYBbVzxpnyfMhEgfgJ9KKDJF9lSK9en70+2W5jzuP8ICA3
 Ze1TjyQnOdbXVGmDdELicTKlAoqO4jkhI5gW1bwROjHZDFOaG9218MwgrYEM+38zNiow1
 x3apNHxM+OsJ5yrEuf7cOijHgtXKwWPzHgWTGCPRwjxNnT+i32Gyb4B8vNhFc7HauC1pv
 wmiDMpuUCe0K1baRYKyiJsmT0PoCpFwAr03y/XMs/ol8JpwSTZ3z64RBbwTePqWL0vw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YYtnPt3X; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YYtnPt3X
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91F938085F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 03:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790133177; x=1821669177; h=date:from:to:subject:message-id;
 bh=v/2dBbljTVdNdWSK4TlVL7HNNgLolx+9ihR83S9CM8g=;
 b=YYtnPt3XbYTXvH6EZO7dSnqXFzW7p3SJg1t9dWSpJSKK0YUZM5ExpjBm
 /noN+ed8JIO8zwPaqN2JD9gfdgN5K78i0u740MbRw7fiOHkg8H+I5EsMj
 N5qhtZJRVf7sfw87uTsl89tptk7L3mpTwL1vJpBlSyT5M7gnvLj38Za4O
 QNyDB2xVkDfMcgL1fG5OF+eAT6xLqxdS4zV6MzzNek6jEpb2qNZ8R6sP7
 U9bDv7tMPKW1NGg/2r4v4545q/sodiEsrcmhaYdGyZqI832BF3DuufM4f
 bT1BLZZ2IYv8MRy35+MtnFoJqbW6JoacugI5UcB/cgKXM3Y8I2OUMMDTD Q==;
X-CSE-ConnectionGUID: PvKenGa6ThmoT48cwOOfKA==
X-CSE-MsgGUID: 3YaQuRJpSo+U4v3QPbATGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101379450"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="101379450"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 20:12:55 -0700
X-CSE-ConnectionGUID: Czd+n7KpSjmm/J6jFRRFGQ==
X-CSE-MsgGUID: blU2E+o5QjmeJF+Qu8kc0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4484849"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa011.fm.intel.com with ESMTP; 22 Sep 2026 20:12:53 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x9DPd-00000000GS1-28TF;
 Wed, 23 Sep 2026 03:12:49 +0000
Date: Wed, 23 Sep 2026 11:12:46 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:100GbE] BUILD SUCCESS
 a64b0b87f696991d32749ac861e83ac2df57aa88
Message-ID: <202609231143.o7tDt5cz-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: a64b0b87f696991d32749ac861e83ac2df57aa88  ice: use ACL for ntuple rules that conflict with FDir

elapsed time: 5048m

configs tested: 196
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260920    gcc-8.5.0
arc                   randconfig-1001-20260920    gcc-8.5.0
arc                  randconfig-r1307-20260919    gcc-12.5.0 sparse
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    gcc-16.1.0
arm                      am200epdkit_defconfig    gcc-16.1.0
arm                                  defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20260920    gcc-10.5.0
arm                   randconfig-1001-20260920    gcc-12.5.0
arm                   randconfig-1002-20260920    clang-20
arm                   randconfig-1003-20260920    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260920    gcc-15.2.0
arm64                 randconfig-1001-20260920    clang-24
arm64                 randconfig-1002-20260920    gcc-8.5.0
arm64                 randconfig-1003-20260920    clang-24
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260920    gcc-12.5.0
csky                  randconfig-1001-20260920    gcc-14.3.0
csky                 randconfig-r1302-20260920    gcc-15.2.0 sparse
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    clang-24
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260920    clang-17
hexagon               randconfig-1001-20260920    clang-19
i386                              allmodconfig    gcc-14
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    gcc-14
i386        buildonly-randconfig-1000-20260920    clang-22
i386        buildonly-randconfig-1001-20260920    clang-22
i386        buildonly-randconfig-1002-20260920    clang-22
i386        buildonly-randconfig-1003-20260920    gcc-14
i386        buildonly-randconfig-1004-20260920    clang-22
i386        buildonly-randconfig-1005-20260920    clang-22
i386                                 defconfig    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260920    clang-22
i386                  randconfig-1001-20260920    gcc-14
i386                  randconfig-1002-20260920    gcc-14
i386                  randconfig-1003-20260920    clang-22
i386                  randconfig-1004-20260920    gcc-14
i386                  randconfig-1005-20260920    gcc-14
i386                  randconfig-1006-20260920    clang-22
i386                  randconfig-1007-20260920    gcc-12
i386                  randconfig-1008-20260920    gcc-14
i386                  randconfig-1009-20260920    clang-22
i386                  randconfig-1010-20260920    clang-22
i386                  randconfig-1011-20260920    gcc-14
i386                  randconfig-1012-20260920    gcc-14
i386                  randconfig-1013-20260920    clang-22
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260920    gcc-16.1.0
loongarch             randconfig-1001-20260920    gcc-16.1.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                                 defconfig    gcc-16.1.0
m68k                 randconfig-r1306-20260919    gcc-9.5.0  sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze                           defconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm63xx_defconfig    clang-24
mips                      decstation_defconfig    gcc-16.1.0
mips                       loongson3_defconfig    gcc-16.1.0
mips                 randconfig-r1309-20260919    gcc-16.1.0 sparse
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    clang-24
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260920    gcc-8.5.0
nios2                 randconfig-1001-20260920    gcc-8.5.0
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc                   or1klitex_defconfig    gcc-16.1.0
openrisc             randconfig-r1303-20260920    gcc-16.1.0 sparse
openrisc             randconfig-r1308-20260919    gcc-14.3.0 sparse
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260920    gcc-14.3.0
parisc                randconfig-1001-20260920    gcc-8.5.0
parisc               randconfig-r1301-20260920    gcc-9.5.0  sparse
parisc               randconfig-r1305-20260920    gcc-9.5.0  sparse
parisc64                             defconfig    clang-24
parisc64                             defconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.1.0
powerpc                   iss476-smp_defconfig    gcc-16.1.0
powerpc                  linkstation_defconfig    clang-24
powerpc                  mpc8313_rdb_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260920    gcc-8.5.0
powerpc               randconfig-1001-20260920    clang-24
powerpc64             randconfig-1000-20260920    clang-24
powerpc64             randconfig-1001-20260920    clang-22
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260920    gcc-13.4.0
riscv                 randconfig-1001-20260920    gcc-15.2.0
s390                               allnoconfig    clang-24
s390                                 defconfig    clang-18
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260920    gcc-8.5.0
s390                  randconfig-1001-20260920    clang-20
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                                   defconfig    gcc-16.1.0
sh                    randconfig-1000-20260920    gcc-16.1.0
sh                    randconfig-1001-20260920    gcc-10.5.0
sh                   randconfig-r1304-20260920    gcc-14.3.0 sparse
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260920    gcc-12.5.0
sparc                 randconfig-1001-20260920    gcc-14.3.0
sparc                randconfig-r1300-20260920    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260920    gcc-13.4.0
sparc64               randconfig-1001-20260920    clang-24
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260920    clang-21
um                    randconfig-1001-20260920    clang-17
um                            x86_64_defconfig    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20260920    gcc-14
x86_64      buildonly-randconfig-1001-20260920    gcc-14
x86_64      buildonly-randconfig-1002-20260920    gcc-14
x86_64      buildonly-randconfig-1003-20260920    clang-22
x86_64      buildonly-randconfig-1004-20260920    clang-22
x86_64      buildonly-randconfig-1005-20260920    gcc-14
x86_64                               defconfig    gcc-14
x86_64                randconfig-1000-20260920    clang-22
x86_64                randconfig-1001-20260920    gcc-14
x86_64                randconfig-1002-20260920    clang-22
x86_64                randconfig-1003-20260920    gcc-14
x86_64                randconfig-1004-20260920    gcc-14
x86_64                randconfig-1005-20260920    clang-22
x86_64                randconfig-1006-20260920    gcc-14
x86_64                randconfig-1007-20260920    gcc-14
x86_64                randconfig-1008-20260920    gcc-14
x86_64                randconfig-1009-20260920    gcc-14
x86_64                randconfig-1010-20260920    gcc-14
x86_64                randconfig-1011-20260920    gcc-14
x86_64                randconfig-1012-20260920    clang-22
x86_64                randconfig-1013-20260920    gcc-14
x86_64                randconfig-1014-20260920    gcc-14
x86_64                randconfig-1015-20260920    clang-22
x86_64                randconfig-1016-20260920    clang-22
x86_64                randconfig-1017-20260920    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    gcc-16.1.0
xtensa                randconfig-1000-20260920    gcc-10.5.0
xtensa                randconfig-1001-20260920    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
