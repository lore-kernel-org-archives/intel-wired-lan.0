Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419C7C982D8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 16:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02E42812DF;
	Fri, 18 Sep 2026 16:01:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1U0ZeIpQgEPy; Fri, 18 Sep 2026 16:01:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D7784812EF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789747259;
	b=QI6FVe4adnWfgKFKVjPmkHNcl+ztlcn1T4awJE/2LBxG0RfUaIBurIW+Jm6WRYRBet2w
	 5CQMR+QUPbjMjJ4szGJuea3tBEydFcpVKwvXT3wahCUDx6xxavTaaciKjY94l15TrBzj3
	 4vBWDZ7Smc0D6+vWyT3KlO17CciLgO2hQPUPuDvMvYwI9zXGpNhrVj1sUtYkdvQzDDmyj
	 KpTxZ080LKQOsKy59zfWjZAZmXDq9wpqqJpyzVmlJASEAMSQ/eu4uqmOUlP5z0PLYkcK3
	 JAkHo2KBZ8wlXAl5/nE6eRr+afEsTrSjaS3DqF19qEHqUjrgqRkZud2NTwem4pSilZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789747259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=HO2OmsqoxgtzZuYdzpPDxLqv4RALV9noURjULw7paGY=;
	b=KeIqq1Fb2KSOwAlWVnypIoXJMa3o2AcUC+2ETz6w2PaG/+ZkSfotuFzGAoKVEYRPWG3i
	 n4w1HC7BDp8K6i6kEk2jN+1sNBtYoiU5slOEhDTWJFhOv9R1JRU9qy7g98jZ52qdwYVRL
	 i5UaShh7v+IjICZHicfnR4SKnwEkzMhdkDiA2wD3Fsd+y/VdauQf9aXdF78JKMPKa/RGl
	 D+uyryBJYAeBtP/vrHSoDIVRY5AP0AGjlhsCBpEM9kc9Gn45elPC19nraPvqxTQrXyngI
	 CYNJt8tE0CkuJBZxg3gKZZ9mMv5L5fkoOW9zMEojcV0/UMwOv+7dFs0wkMbh0NO2XUQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789747259;
	bh=HO2OmsqoxgtzZuYdzpPDxLqv4RALV9noURjULw7paGY=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DURAiJzta7NqINVM4EaQLnp8gPxmhnlkWOeDWotOI/GPvHS+74LfQYO9EmzY1eviV
	 jQd7kk3brW+tDWgEGGPfIlL3yr8zFhmMPgcR8lsIpIcN/cS2JB2UXWUqskSv1Z0FIs
	 8QwB6fYiVEh1Nei+U1f3hoaaVb8e1VOaYcGiyLiLe61W3WODdmj1lq9AQCw3WECQYx
	 3G6dsOYswvqde2zXHbbAObULjcyWajaY8bAoUH3QZmCQcDvplmmrMjqxRF2DAALvzP
	 dFbhPJG/UgcGjLASSrFweUMXQLcpr9SXaTYdjxf3hvwD800zKIuQiSVpsdOnzN5VxF
	 xKvxikPbbitug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7784812EF;
	Fri, 18 Sep 2026 16:00:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C27425B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 16:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7DE5F60B9B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 16:00:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vvBYZziC9LAc for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 16:00:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 171F760D6C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789747257;
 b=DDdoc4VwVufNBTXwIZsxbmgFQ19caOlDPWC5nFrsLNA2fjZ0oFcvohKY75dq4QmDz50F
 MuiF3MD0md9Ahcq+trRhKPL2kymbdKl1NEVtGfA8k177gYcuZj+9LeiahMWjS2u//mXrD
 7O6vj79c74hdDb4zTXgBNaEmoJ9YzQM64tmlOlPR+mz2KWHpDcJc9A/DV311rrc1iudn8
 KQlc3oNGqcXlmZ2olMNn+dphc3Z1GLebseY4t/RaLACtYPSK0cLSsaBwbYhRxP7pu0zpm
 fCTzZ2am7UA036uzcqsse4ixbT2Rfl5Q0hdEF6dp7G424I07WJ5gIqE0nJfLm+CHDXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789747257;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=HO2OmsqoxgtzZuYdzpPDxLqv4RALV9noURjULw7paGY=;
 b=oU9fFw1hacfhDS6x8LWMrkR0MoDVuT2zYm8hFLeIeE+TcaJ9WA3pHgh+w5GsxeL2H0mE
 BYAbfhG4ySVi8ohBkdBDx5v/B1FTDfnNYDsFBZICeUYCoqHgDstffZ6sFpLz8UmmUqXNa
 WjIfOwdCQOmh/E5RFCWHU4GyqGemOa9Gssoz5QH1f/QN5ntM8tQVIq2d+jJ+S2VsEwoJk
 TIt0sqNZBcuBcHXpp0U2DiGydJEvW1/Oahi61L9fEIzJ8Fk9Ao2klGwI/G6Tq0IGjXz6G
 G3qSNVM164lzxkb8uLeeDFk0eKXRkyIkKMspXhCrB3mOkZ/vtFpUbwDtGB7QbFHhkOg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=D4mbvr90; 
 arc=none smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=D4mbvr90
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 171F760D6C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 16:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789747257; x=1821283257; h=date:from:to:subject:message-id;
 bh=6L5BoTKpuvjCa6QvomgNwucgX3NidgG7I3yYhw0nuag=;
 b=D4mbvr90ES1ksnUKccDPaoXcGaXdjiDvYt0CxHBTrU6afHUPkJSr5FDe
 HQb76wy3JC/b+Y9p8p1KoHeKTsVUE9roR3NEC4HNQWybwGSuapWfs8FM3
 RPjtSUOrgxpe83X4clIDbgSOPUl1DA/HQ719FpPtpPCkabfO+Gf3bFR4L
 qptDlvqwRDXv3ZFJLKIKjPMebRu3a86A5JyS7Mrno2p/15ofK/BaHLY5T
 WIaTb3nFPXQpCEPxRasui4/ZCpFDCfoFcTo1cj3rHuJfKiaN1ei79Dc08
 ZLkAgurh4/ZgxNvCXaOmiClZYB9qymkbFMM9QkJxxti4PBlmw1Q/oOHfo A==;
X-CSE-ConnectionGUID: zyRmofbTR+GeMIvQm6FySg==
X-CSE-MsgGUID: aHQKflH2RXS0wvR/fuApqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="94096695"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="94096695"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 09:00:56 -0700
X-CSE-ConnectionGUID: oQbyAMfzQ2O3Ib4cr6ygZA==
X-CSE-MsgGUID: zhPx4h1DR0ysHj32Lapm6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="279692157"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa005.fm.intel.com with ESMTP; 18 Sep 2026 09:00:54 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x7b19-00000000A1G-2P4z;
 Fri, 18 Sep 2026 16:00:51 +0000
Date: Sat, 19 Sep 2026 00:00:09 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 18ad49f3b39f1250ff4e67c39f3771a7b3fa6c27
Message-ID: <202609190006.tVRZ5IyZ-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 18ad49f3b39f1250ff4e67c39f3771a7b3fa6c27  ice: drop pf == NULL check in ice_pf_state_is_nominal()

elapsed time: m

configs tested: 215
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r1307-20260918    gcc-11.5.0 sparse
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260918    gcc-16.1.0
arc                   randconfig-1001-20260918    gcc-16.1.0
arc                  randconfig-r1300-20260918    gcc-16.1.0 sparse
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                               allyesconfig    gcc-16.1.0
arm                          assabet_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                           gemini_defconfig    clang-24
arm                           moxart_defconfig    gcc-16.1.0
arm                   randconfig-1000-20260918    gcc-16.1.0
arm                   randconfig-1001-20260918    gcc-16.1.0
arm                   randconfig-1002-20260918    gcc-16.1.0
arm                   randconfig-1003-20260918    gcc-16.1.0
arm                  randconfig-r1303-20260918    gcc-16.1.0 sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    clang-24
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260918    gcc-16.1.0
arm64                 randconfig-1001-20260918    gcc-16.1.0
arm64                 randconfig-1002-20260918    gcc-16.1.0
arm64                 randconfig-1003-20260918    gcc-16.1.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260918    gcc-16.1.0
csky                  randconfig-1001-20260918    gcc-16.1.0
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260918    gcc-16.1.0
hexagon               randconfig-1001-20260918    gcc-16.1.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260918    gcc-14
i386        buildonly-randconfig-1001-20260918    gcc-14
i386        buildonly-randconfig-1002-20260918    gcc-14
i386        buildonly-randconfig-1003-20260918    gcc-14
i386        buildonly-randconfig-1004-20260918    gcc-14
i386        buildonly-randconfig-1005-20260918    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260918    gcc-12
i386                  randconfig-1001-20260918    gcc-12
i386                  randconfig-1002-20260918    gcc-12
i386                  randconfig-1003-20260918    gcc-12
i386                  randconfig-1004-20260918    gcc-12
i386                  randconfig-1005-20260918    gcc-12
i386                  randconfig-1006-20260918    gcc-12
i386                  randconfig-1007-20260918    clang-22
i386                  randconfig-1008-20260918    clang-22
i386                  randconfig-1009-20260918    clang-22
i386                  randconfig-1010-20260918    clang-22
i386                  randconfig-1011-20260918    clang-22
i386                  randconfig-1012-20260918    clang-22
i386                  randconfig-1013-20260918    clang-22
i386                  randconfig-1300-20260918    clang-22   sparse
i386                  randconfig-1301-20260918    clang-22   sparse
i386                  randconfig-1302-20260918    clang-22   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260918    gcc-16.1.0
loongarch             randconfig-1001-20260918    gcc-16.1.0
loongarch            randconfig-r1309-20260918    gcc-11.5.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                        m5275evb_defconfig    clang-24
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze                       mmu_defconfig    gcc-16.1.0
microblaze           randconfig-r1302-20260918    gcc-16.1.0 sparse
microblaze           randconfig-r1304-20260918    gcc-16.1.0 sparse
microblaze           randconfig-r1308-20260918    gcc-11.5.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                            ip32_defconfig    clang-24
mips                 randconfig-r1307-20260918    gcc-11.5.0 sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260918    gcc-16.1.0
nios2                 randconfig-1001-20260918    gcc-16.1.0
nios2                randconfig-r1306-20260918    gcc-11.5.0 sparse
nios2                randconfig-r1309-20260918    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260918    gcc-8.5.0
parisc                randconfig-1001-20260918    gcc-8.5.0
parisc               randconfig-r1305-20260918    gcc-16.1.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       chrp32_defconfig    clang-24
powerpc                           g5_defconfig    clang-24
powerpc                      mpc5200_defconfig    gcc-16.1.0
powerpc                      powernv_defconfig    clang-24
powerpc                        ppc64_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260918    gcc-8.5.0
powerpc               randconfig-1001-20260918    gcc-8.5.0
powerpc64             randconfig-1000-20260918    gcc-8.5.0
powerpc64             randconfig-1001-20260918    gcc-8.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260918    clang-24
riscv                 randconfig-1001-20260918    clang-24
s390                              allmodconfig    clang-17
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260918    clang-24
s390                  randconfig-1001-20260918    clang-24
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20260918    clang-24
sh                    randconfig-1001-20260918    clang-24
sh                            se7722_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260918    gcc-14
sparc                 randconfig-1001-20260918    gcc-14
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260918    gcc-14
sparc64               randconfig-1001-20260918    gcc-14
sparc64              randconfig-r1301-20260918    gcc-16.1.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260918    gcc-14
um                    randconfig-1001-20260918    gcc-14
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260918    clang-22
x86_64      buildonly-randconfig-1001-20260918    clang-22
x86_64      buildonly-randconfig-1002-20260918    clang-22
x86_64      buildonly-randconfig-1003-20260918    clang-22
x86_64      buildonly-randconfig-1004-20260918    clang-22
x86_64      buildonly-randconfig-1005-20260918    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260918    clang-22
x86_64                randconfig-1001-20260918    clang-22
x86_64                randconfig-1002-20260918    clang-22
x86_64                randconfig-1003-20260918    clang-22
x86_64                randconfig-1004-20260918    clang-22
x86_64                randconfig-1005-20260918    clang-22
x86_64                randconfig-1006-20260918    gcc-14
x86_64                randconfig-1007-20260918    gcc-14
x86_64                randconfig-1008-20260918    gcc-14
x86_64                randconfig-1009-20260918    gcc-14
x86_64                randconfig-1010-20260918    gcc-14
x86_64                randconfig-1011-20260918    gcc-14
x86_64                randconfig-1012-20260918    clang-22
x86_64                randconfig-1013-20260918    clang-22
x86_64                randconfig-1014-20260918    clang-22
x86_64                randconfig-1015-20260918    clang-22
x86_64                randconfig-1016-20260918    clang-22
x86_64                randconfig-1017-20260918    clang-22
x86_64                randconfig-1300-20260918    clang-22   sparse
x86_64                randconfig-1301-20260918    clang-22   sparse
x86_64                randconfig-1302-20260918    clang-22   sparse
x86_64               randconfig-r1306-20260918    gcc-11.5.0 sparse
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
xtensa                 generic_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20260918    gcc-14
xtensa                randconfig-1001-20260918    gcc-14
xtensa               randconfig-r1308-20260918    gcc-11.5.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
