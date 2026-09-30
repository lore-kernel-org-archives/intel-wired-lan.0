Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95711CA5FC5
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 15:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AC0B40A55;
	Wed, 30 Sep 2026 15:08:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qi_BqiLHJr4q; Wed, 30 Sep 2026 15:08:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0D5A940A44
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790780935;
	b=fIa3IXgU9b6h1t3YdTzLUpbaHqedmZ1aFekDiGO1JdwvBmXmbFC/1rWqQ4QYXkUwbNfw
	 tuUE0u7svdOKzHgw65ez0BUrXf/a+BQk/7BsTqtI4lT6Fe6Ky9FCXqIHnrTJYlgv/W4Kt
	 UyAjLYpULIvLlD07A68VJwiJVVkU32spsHX68oMQrf5G2ngaG36jo4xSypNenifq6vFt7
	 dMR7sfENVxIk2cDI6+kS1pbw40jr70puSeUrX72YeGahKgFeadvnssk2Yu+XJwP19LAIN
	 C/seOa4zOfg64bL8brEo7sdFryijrJJbq255OWs7sWlDOzkRoo4UmluUxmOQUO1OxEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790780935;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=kxiUf6CIvm/tXBaYNBad0/x4RR6U3tYLDh5Hct8/cDo=;
	b=jE0sThNswY2RUgPjZZRcVSLuBOVWv/9xVCkdVmLlIBNLiBZO5lEO+QC+T6TL+rSPBW8K
	 d+YQdU83C5Aa8WaQA2jZkgFXWa966qut9E3Dvl3L5/UApk8KYxlTs2CaVAD/aATVSuh5X
	 70j6EBWIzjqtmz/Qtfkk/yYihkELMbY578wusZsgRMTv0HENRBYXNtOGxfXYqrUWUg6qK
	 A8iqeJM00ZAmVzS8Ujj6o+8cP5I4+AXYbLQQLb7yGoS3Y75nN32yRGMdziRwXv6wJalLX
	 37ZiL3GNjicQNDrEt1+0cmxRWqzg9rSsTclqSpYnG9ed2SlaCSm5g1jTH761IrbsA+A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790780935;
	bh=kxiUf6CIvm/tXBaYNBad0/x4RR6U3tYLDh5Hct8/cDo=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6U9GHb1w1lrTkftCxu/UkIWE20QypCOK4yORpS+4WTpFlquQw9WVWu+akZKIBc/J+
	 7XBUBIYPgjGNL5rf162wAopUqTJhI64Gn86GoeH6ytTGqvJv6HM6gXul4oWIy2KWgQ
	 iCsphmyuI9qshbMDTZDlvX7+cPnNi0ckw/tBwCbuow40ksjZutKRfO+5rrNUC+Mv8Z
	 v/bCtiHp9Del2BUImz0G05hk4VtTglp3aLikdnu/2O9GKFQN69QLnZvPXDB1Kaoq6n
	 GlCGvKa7RMIF/H8c/vDS5SX4+Z0Lcx/wkzBnvXih5pS6daMNZ0M2F8vWa/VmC0UtFs
	 ahpZ1z+wojn4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D5A940A44;
	Wed, 30 Sep 2026 15:08:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 63FAB32A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 15:08:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 611EB400AE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 15:08:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D_oDZV_SMB5H for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 15:08:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 034D440042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790780932;
 b=LtLJdsZ4GMzhJe66O9J0tXeIhFOJDpvxpgMKQB6PjXmypjJlnXDDHr30q/J+5BS/DbHd
 2wZJLG+xiK4SjIf/P8ZZlOMxoLDHo0LAodI3BXlLdoli+grgZwt3UIQdeeLw5JFt/mq6h
 HGbJKdlhwZeqOMhtghQ+n7WsJHF5UYxeHNiOQnzT9/zTME7ajjQpROR+TR7+HwE9b02nZ
 s7G9+tPT4s2J5FwUE6fDabHEaGo5GBUvvlc0tSNrTUjotyraSkqPvjoniyFq2uMzSl2UU
 IqREaPVRHYgRfF/EemCcYD/OSRLgdOkLGRV1+VovpdtHUgd8pSEhqcVLqI1LfljSLFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790780932;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=kxiUf6CIvm/tXBaYNBad0/x4RR6U3tYLDh5Hct8/cDo=;
 b=d/7+YbUyYlal70192d0WtbhfLaKUmCpOvwCfUraa/zs2ZRpPmxVUrU7wNpEHStGlPnAM
 /0q/6/FmrrgSyH8PHaL3/KT80jQn2vuuwYKUNUdWuWAQaDPn0Y5kjmxv6cj7zRRaGkvH3
 oWhM8jYK1bUlagBy9neuGLxYjcbnCd8wpt0ySQDKLTk1WZXXPdK2Ck48NBAb8+Wf+1Qgv
 toneB1YXJ39WU80Ri4ODgKDqelfQkP6S7VR4kN2jnXEhsy3MZu77pE5MaB7KuQBgdMTHU
 LVAtIZ08VjhDg/1QqJc2lTOMNVctI3krQpA5rdQPd/Sy3Cxo3TnscZWm7+e2AZb2Jhw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=c+QDGH+I; 
 arc=none smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=c+QDGH+I
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 034D440042
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 15:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790780932; x=1822316932; h=date:from:to:subject:message-id;
 bh=YET3gkKHh1lXVa30TOLWurfhx6inDgAXedKSiYaoRbk=;
 b=c+QDGH+Id+4Teildm9q9fFKJExjO8NrTPq8t7/0v3TcXBs9yonhWSpGE
 rKH3YfpSiFqFsSlDw29mMItsRMtA7FGrugUdfSddGpkwAGyG0g1ONRr4w
 xt4GVRvc3v7qdnVlVp6skVARV03SaGhZpy9mMO02E5kB0qLwf5TsLS7Yq
 092m1F5hGfTICzKpY7XS2NmyrqEvgOALhCAAnnAHgy64c0bSV7g/uzyQW
 DvlJhKMlWgOrfkrs/JQzbbtIMN0RCp6RCLBcsjkK+F6vMvKqpsg68TnG1
 e/6I8jSwPCtTQW/xSq8IGa+77MYpLyYkfH53z/K/dyagQvMCXLh0SC0Jc w==;
X-CSE-ConnectionGUID: uREBgvIDTQCuJi71PsdTrg==
X-CSE-MsgGUID: o4EfGVhYSxKf3dubCihWlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90421100"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90421100"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 08:08:51 -0700
X-CSE-ConnectionGUID: sHvbHUsmRpGCRwYUbB7Gqg==
X-CSE-MsgGUID: hUHAhFs0SSe8naZEjljRTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="272162427"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa009.fm.intel.com with ESMTP; 30 Sep 2026 08:08:49 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xBvvL-00000000QmW-1RNn;
 Wed, 30 Sep 2026 15:08:47 +0000
Date: Wed, 30 Sep 2026 23:08:45 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:main] BUILD SUCCESS
 6e23f90f2b8c3ea3bf904f86f3ed06bf2844b4bc
Message-ID: <202609302342.ykdOuErX-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git main
branch HEAD: 6e23f90f2b8c3ea3bf904f86f3ed06bf2844b4bc  Merge branch 'net-consolidate-devmem-net_iov-freelist-and-dma-handling'

elapsed time: 1053m

configs tested: 277
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2107-20260930    gcc-8.5.0  cocci
alpha                randconfig-r2300-20260930    gcc-8.5.0  sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                         nsim_700_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260930    gcc-11.5.0
arc                   randconfig-1001-20260930    gcc-11.5.0
arc                  randconfig-r2104-20260930    gcc-12     cocci
arc                  randconfig-r2301-20260930    clang-24   sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                             dove_defconfig    gcc-16.1.0
arm                       integrator_defconfig    clang-24
arm                             mmp2_defconfig    gcc-16.1.0
arm                         mvebu_v5_defconfig    gcc-16.1.0
arm                             qcom_defconfig    clang-24
arm                   randconfig-1000-20260930    gcc-11.5.0
arm                   randconfig-1001-20260930    gcc-11.5.0
arm                   randconfig-1002-20260930    gcc-11.5.0
arm                   randconfig-1003-20260930    gcc-11.5.0
arm                  randconfig-r2101-20260930    clang-24   cocci
arm                  randconfig-r2102-20260930    clang-24   cocci
arm                            sama5_defconfig    gcc-16.1.0
arm                         spear6xx_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260930    gcc-16.1.0
arm64                 randconfig-1001-20260930    gcc-16.1.0
arm64                 randconfig-1002-20260930    gcc-16.1.0
arm64                 randconfig-1003-20260930    gcc-16.1.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260930    gcc-16.1.0
csky                  randconfig-1001-20260930    gcc-16.1.0
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260930    clang-24
hexagon               randconfig-1001-20260930    clang-24
hexagon              randconfig-r2304-20260930    gcc-8.5.0  sparse
i386                              alldefconfig    gcc-16.1.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260930    gcc-14
i386        buildonly-randconfig-1001-20260930    gcc-14
i386        buildonly-randconfig-1002-20260930    gcc-14
i386        buildonly-randconfig-1003-20260930    gcc-14
i386        buildonly-randconfig-1004-20260930    gcc-14
i386        buildonly-randconfig-1005-20260930    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260930    gcc-14
i386                  randconfig-1001-20260930    gcc-14
i386                  randconfig-1002-20260930    gcc-14
i386                  randconfig-1003-20260930    gcc-14
i386                  randconfig-1004-20260930    gcc-14
i386                  randconfig-1005-20260930    gcc-14
i386                  randconfig-1006-20260930    gcc-14
i386                  randconfig-1007-20260930    clang-22
i386                  randconfig-1008-20260930    clang-22
i386                  randconfig-1009-20260930    clang-22
i386                  randconfig-1010-20260930    clang-22
i386                  randconfig-1011-20260930    clang-22
i386                  randconfig-1012-20260930    clang-22
i386                  randconfig-1013-20260930    clang-22
i386                  randconfig-2100-20260930    clang-22   cocci
i386                  randconfig-2101-20260930    clang-22   cocci
i386                  randconfig-2102-20260930    clang-22   cocci
i386                  randconfig-2103-20260930    clang-22   cocci
i386                  randconfig-2200-20260930    gcc-14     smatch
i386                  randconfig-2300-20260930    gcc-13     sparse
i386                  randconfig-2301-20260930    gcc-13     sparse
i386                  randconfig-2302-20260930    gcc-13     sparse
i386                 randconfig-r2105-20260930    gcc-12     cocci
i386                 randconfig-r2202-20260930    gcc-13     smatch
i386                 randconfig-r2303-20260930    clang-24   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260930    clang-24
loongarch             randconfig-1001-20260930    clang-24
loongarch            randconfig-r2102-20260930    gcc-9.5.0  cocci
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                           atari_defconfig    clang-24
m68k                           atari_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                        m5475evb_defconfig    gcc-16.1.0
m68k                 randconfig-r2106-20260930    gcc-8.5.0  cocci
m68k                 randconfig-r2202-20260930    gcc-15.2.0 smatch
m68k                 randconfig-r2307-20260930    gcc-12.5.0 sparse
m68k                            virt_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2103-20260930    gcc-9.5.0  cocci
microblaze           randconfig-r2305-20260930    gcc-8.5.0  sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm63xx_defconfig    clang-24
mips                          bigsur_defconfig    gcc-16.1.0
mips                      decstation_defconfig    gcc-16.1.0
mips                      loongson2k_defconfig    gcc-16.1.0
mips                           malta_defconfig    clang-24
mips                       maltasmvp_defconfig    gcc-16.1.0
mips                         qi_lb60_defconfig    clang-24
mips                         qi_lb60_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260930    clang-24
nios2                 randconfig-1001-20260930    clang-24
nios2                randconfig-r2106-20260930    gcc-12     cocci
nios2                randconfig-r2200-20260930    gcc-10.5.0 smatch
nios2                randconfig-r2201-20260930    gcc-11.5.0 smatch
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2302-20260930    gcc-8.5.0  sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260930    gcc-8.5.0
parisc                randconfig-1001-20260930    gcc-8.5.0
parisc               randconfig-r2107-20260930    gcc-12     cocci
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                  canyonlands_defconfig    gcc-16.1.0
powerpc                         fsp2_defconfig    gcc-16.1.0
powerpc                       mgcoge_defconfig    gcc-16.1.0
powerpc                       ppc64e_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260930    gcc-8.5.0
powerpc               randconfig-1001-20260930    gcc-8.5.0
powerpc              randconfig-r2103-20260930    clang-24   cocci
powerpc              randconfig-r2306-20260930    gcc-12.5.0 sparse
powerpc                      sequoia_defconfig    gcc-16.1.0
powerpc                      tqm8548_defconfig    gcc-16.1.0
powerpc                       tqm8xx_defconfig    gcc-16.1.0
powerpc64                         alldefconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260930    gcc-8.5.0
powerpc64             randconfig-1001-20260930    gcc-8.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                     nommu_k210_defconfig    clang-24
riscv                     nommu_k210_defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260930    gcc-16.1.0
riscv                 randconfig-1001-20260930    gcc-16.1.0
riscv                 randconfig-2000-20260930    gcc-14.3.0
riscv                 randconfig-2001-20260930    gcc-14.3.0
riscv                randconfig-r2300-20260930    clang-24   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260930    gcc-16.1.0
s390                  randconfig-1001-20260930    gcc-16.1.0
s390                  randconfig-2000-20260930    gcc-14.3.0
s390                  randconfig-2001-20260930    gcc-14.3.0
s390                 randconfig-r2104-20260930    gcc-8.5.0  cocci
s390                 randconfig-r2305-20260930    clang-24   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    gcc-16.1.0
sh                         edosk7760_defconfig    clang-24
sh                              espt_defconfig    gcc-16.1.0
sh                             hp6xx_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260930    gcc-16.1.0
sh                    randconfig-1001-20260930    gcc-16.1.0
sh                    randconfig-2000-20260930    gcc-14.3.0
sh                    randconfig-2001-20260930    gcc-14.3.0
sh                           sdk7780_defconfig    gcc-16.1.0
sh                           urquell_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260930    clang-22
sparc                 randconfig-1001-20260930    clang-22
sparc                 randconfig-2000-20260930    gcc-10.5.0
sparc                 randconfig-2001-20260930    gcc-10.5.0
sparc                randconfig-r2301-20260930    gcc-8.5.0  sparse
sparc                randconfig-r2302-20260930    clang-24   sparse
sparc                randconfig-r2308-20260930    gcc-12.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260930    clang-22
sparc64               randconfig-1001-20260930    clang-22
sparc64               randconfig-2000-20260930    gcc-10.5.0
sparc64               randconfig-2001-20260930    gcc-10.5.0
sparc64              randconfig-r2304-20260930    clang-24   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260930    clang-22
um                    randconfig-1001-20260930    clang-22
um                    randconfig-2000-20260930    gcc-10.5.0
um                    randconfig-2001-20260930    gcc-10.5.0
um                   randconfig-r2100-20260930    clang-24   cocci
um                   randconfig-r2105-20260930    gcc-8.5.0  cocci
um                   randconfig-r2200-20260930    clang-24   smatch
um                   randconfig-r2201-20260930    clang-17   smatch
um                   randconfig-r2303-20260930    gcc-8.5.0  sparse
um                   randconfig-r2309-20260930    gcc-12.5.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260930    clang-22
x86_64      buildonly-randconfig-1001-20260930    clang-22
x86_64      buildonly-randconfig-1002-20260930    clang-22
x86_64      buildonly-randconfig-1003-20260930    clang-22
x86_64      buildonly-randconfig-1004-20260930    clang-22
x86_64      buildonly-randconfig-1005-20260930    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260930    gcc-14
x86_64                randconfig-1001-20260930    gcc-14
x86_64                randconfig-1002-20260930    gcc-14
x86_64                randconfig-1003-20260930    gcc-14
x86_64                randconfig-1004-20260930    gcc-14
x86_64                randconfig-1005-20260930    gcc-14
x86_64                randconfig-1006-20260930    gcc-14
x86_64                randconfig-1007-20260930    gcc-14
x86_64                randconfig-1008-20260930    gcc-14
x86_64                randconfig-1009-20260930    gcc-14
x86_64                randconfig-1010-20260930    gcc-14
x86_64                randconfig-1011-20260930    gcc-14
x86_64                randconfig-1012-20260930    clang-22
x86_64                randconfig-1013-20260930    clang-22
x86_64                randconfig-1014-20260930    clang-22
x86_64                randconfig-1015-20260930    clang-22
x86_64                randconfig-1016-20260930    clang-22
x86_64                randconfig-1017-20260930    clang-22
x86_64                randconfig-2100-20260930    clang-22   cocci
x86_64                randconfig-2101-20260930    clang-22   cocci
x86_64                randconfig-2102-20260930    clang-22   cocci
x86_64                randconfig-2103-20260930    clang-22   cocci
x86_64                randconfig-2200-20260930    gcc-14     smatch
x86_64                randconfig-2300-20260930    gcc-13     sparse
x86_64                randconfig-2301-20260930    gcc-13     sparse
x86_64                randconfig-2302-20260930    gcc-13     sparse
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
xtensa                   audio_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20260930    clang-22
xtensa                randconfig-1001-20260930    clang-22
xtensa                randconfig-2000-20260930    gcc-10.5.0
xtensa                randconfig-2001-20260930    gcc-10.5.0
xtensa               randconfig-r2100-20260930    gcc-9.5.0  cocci
xtensa               randconfig-r2101-20260930    gcc-9.5.0  cocci

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
