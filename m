Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63570CA600C
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 11:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B7A340827;
	Thu,  8 Oct 2026 11:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TzFz3BUymuoK; Thu,  8 Oct 2026 11:53:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D078B4082E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791460388;
	b=kbrX16xiyO8B+TKsshPoQbKKDGde99TGqFpF5WdxKzK0xXabdefPuGCrK6PH8cFxt5j4
	 Cbx4Lw7rhXzQmJ7GCJ0ethaHfRf5k66dSx/mmtz6upqpaxJaFEA8/2uBW/8ddhlotdKUx
	 ZM+74neKMRPmxFny8+mwnEkmdrwSQ3c7es/X1mhfZ9l2RzcBr/FJdu/4XM03j1q/GQN8W
	 ikhj1mfPHU+GIJuqIG2c5YVeBBDMXiQYtEc1fme1BCNl5cxT2KywcjR2wxBmNCubPnT4k
	 L7H48qqCXfcXAszbYXX2wH02qWDCTZc2CNN9y35+2T0clyfbw3eX0575252lOOW6y6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791460388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2lotyshr3pwH1l9lcrHKMZDJygdYa1Os2GXUboLVVyc=;
	b=if32t6/k03zRFXGBC5EZopjrajxB6/xmDdmL7yTBwu4nFiM8d/woADbB7IpLwioMuBpW
	 nIhFUGqZGJQVkCTIXIkGtNnjECGuyRVZ6Lpu9W8QRToOz6ZVnz6epEaFJSa25WinvLAry
	 f+VrkpSZ6DKatAPbRuhLV+Xenn3/vbUl1kaWwdiLbmEy9St3/elp/3ilIJjcQ+hMSs/0b
	 xrD98Bwzg6cu+97bx1KF+b+y42aPLTW4wsi/5c7oClwqQSoZWFSh4jQP1IvqqFL18m5e/
	 CY+126qb6qHVNdZG2pu4PWDsZfReBnesmqGh6p3IAutjyFErzzS5AzEUvL58IXM+LKA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J4HD4fNR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791460388;
	bh=2lotyshr3pwH1l9lcrHKMZDJygdYa1Os2GXUboLVVyc=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j6xi/LMiG4gmqQQ6g+Zzqe8ZxAcPf1JhJPb7646VPnp+TVIzxm8PUVs+9w19PhTg4
	 3z+6KOo5M+tg5HX4vYPkfCsmhntInKf4xwYvqzpaSsRlY4ZXf/fRKNfIK2HVkAVfUf
	 znF0G0Of1FMovwAJhQ5aMnbqGYEY0slTPrYb8qaTGPfmSbtQotH6crOxTpYsUZwlel
	 6Zwt1fMbtbpGpKwSZgwnQnvXZ8k92zhqwATjFvGwRqQoqJgJGOQVS76zXOsWLCnBsb
	 zw11ZCyXzeeZsQ6H6n71ycIF0jzzAeAIdXF5BwJMd3qcCmCdExtiT9d862+N0XcJAw
	 D9vpA0jrbl+vQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D078B4082E;
	Thu,  8 Oct 2026 11:53:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 77784317
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 11:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 690AC4082E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 11:53:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VvBDAtgOJy_n for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 11:53:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0E6C840827
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791460385;
 b=n7L9PgXDGzPAKz0QOrjf32jU7CnMbaV9mwU76C41OzS28nKI9+thPzocITEfJqVQT8ct
 Nu7DspmvTV6dCfBlbrDFQ3cpwUCRcAI2KRRGmyssb0psYqrJPYHGiEEQ0BAPr77Usvfrw
 s6OpHpOy2PIbAC/JjqHiRfh+4TFEmFXwhbbAjjs1LHNHhKKpKDJJ8v394rWPNVJA5ILok
 Gp8nhT6a0vVxga4DTRhfs1NWRZJJaoHeHmlc9TTDWdy+ctYTWx1YwEGbOHXGJXiQ+MdO3
 wWLKEj044tXYPKrIsSHAqQWNfeI4em6oWYv7b1xgl3gBniZKhXQj/3of3PDrMoOYDNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791460385;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=2lotyshr3pwH1l9lcrHKMZDJygdYa1Os2GXUboLVVyc=;
 b=Q2tD0gu4nc60FscI4mvfzzCGYCkN+Qa5P9nz/gN+HQ50G5Jp1pR2YTznNAQqGKmshSYq
 +X0mJmDVNArpb2KajwhZN1P7re6ECy4KAtf2kubdaCJxdcWTf9i6EbxnN3GiXoCJD6XYg
 5Z9uh2c9mRMe8dNg9iLWlIx1hJLTkn22e1pbJBp3pQP7ykRvyx+EhYPbb3fZcU+P+i0fu
 VLhz+ThDbtJ6qi6gR1YnU57nInu6g1GGVglzU0SjaTY0Db6eStwf0RsAeSqBfiF98oiwg
 Q/HJpVcdYH3qETpM+MuTV6PXXJVbgwQwFk5/qxyr5UoSDEDV128x6fjjDzCKLHqQ80A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=J4HD4fNR; 
 arc=none smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=J4HD4fNR
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E6C840827
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 11:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791460385; x=1822996385; h=date:from:to:subject:message-id;
 bh=KeTd3BiVtYxAzA7TIE8C8N+I27pabsFMpQy/SJqASyo=;
 b=J4HD4fNR1SryiP6x1vruPqbdFb28GzDrdT6iF8XyvthncT+UOGhC6mCJ
 W4Duoy2mr9WNr0qoHPVlnlj0vSKsF3wwaVQVBBIQo3CwACXn2T8ySEWip
 nwA0oIfl2fHa82qVLwEAxEOAQSU/83v6t+S7AL8NbxwDJzn6a3sF+0V6T
 W37QHFAoL0QoTw6+x7dDi1tqyi7uvJ+Zj4yEsTUfyIBS7nZcNV/jNXa/K
 GTluu9x1/IrohK2k4x/oEz9nlLytAAX4kksMOIP/X8VZ3ZMqoAQTXe1+i
 dwG5e3RObcF+MfUaPWvvSu84CxHtM/6AXRc+FhmYxMu13zksCxNIPN3xl Q==;
X-CSE-ConnectionGUID: /O1Lp4htRq2CVZEDtOENpQ==
X-CSE-MsgGUID: WPQ/FFxNSielYVcN5wrt+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="235462"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="235462"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 04:53:04 -0700
X-CSE-ConnectionGUID: +TaoyDK8Qiq6t3gaFVz9JQ==
X-CSE-MsgGUID: CcE89qn3T2Oz6mo7W+uDcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="119215"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa004.fm.intel.com with ESMTP; 08 Oct 2026 04:53:02 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xEmgG-000000004Kk-1b08;
 Thu, 08 Oct 2026 11:53:00 +0000
Date: Thu, 08 Oct 2026 19:52:15 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 5f3e3dfa30013efda82672a50a350929282a0c36
Message-ID: <202610081912.drTy7vU5-lkp@intel.com>
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
branch HEAD: 5f3e3dfa30013efda82672a50a350929282a0c36  ice: remove redundant cross-timestamp PTP command

elapsed time: 2595m

configs tested: 329
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2101-20261006    gcc-9.5.0  cocci
alpha                randconfig-r2104-20261007    gcc-10.5.0 cocci
alpha                randconfig-r2200-20261006    gcc-14.3.0 smatch
alpha                randconfig-r2201-20261006    gcc-8.5.0  smatch
alpha                randconfig-r2304-20261006    gcc-10.5.0 sparse
alpha                randconfig-r2306-20261007    clang-24   sparse
alpha                randconfig-r2308-20261006    gcc-8.5.0  sparse
alpha                randconfig-r2309-20261006    clang-24   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261008    clang-18
arc                   randconfig-1001-20261008    clang-18
arc                  randconfig-r2102-20261007    gcc-10.5.0 cocci
arc                  randconfig-r2105-20261006    gcc-14.3.0 cocci
arc                  randconfig-r2200-20261006    gcc-13.4.0 smatch
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          bcm2835_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20261008    clang-18
arm                   randconfig-1001-20261008    clang-18
arm                   randconfig-1002-20261008    clang-18
arm                   randconfig-1003-20261008    clang-18
arm                  randconfig-r2105-20261007    gcc-16.1.0 cocci
arm                  randconfig-r2305-20261006    gcc-8.5.0  sparse
arm                          vf610m4_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261008    gcc-10.5.0
arm64                 randconfig-1001-20261008    gcc-10.5.0
arm64                 randconfig-1002-20261008    gcc-10.5.0
arm64                 randconfig-1003-20261008    gcc-10.5.0
arm64                randconfig-r2100-20261007    gcc-10.5.0 cocci
arm64                randconfig-r2104-20261006    gcc-14.3.0 cocci
arm64                randconfig-r2106-20261007    gcc-16.1.0 cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261008    gcc-10.5.0
csky                  randconfig-1001-20261008    gcc-10.5.0
csky                 randconfig-r2102-20261007    gcc-8.5.0  cocci
csky                 randconfig-r2104-20261007    gcc-16.1.0 cocci
csky                 randconfig-r2201-20261007    gcc-16.1.0 smatch
csky                 randconfig-r2301-20261007    gcc-8.5.0  sparse
csky                 randconfig-r2303-20261006    gcc-10.5.0 sparse
csky                 randconfig-r2304-20261006    gcc-8.5.0  sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261008    gcc-16.1.0
hexagon               randconfig-1001-20261008    gcc-16.1.0
hexagon              randconfig-r2101-20261007    gcc-8.5.0  cocci
hexagon              randconfig-r2107-20261007    gcc-16.1.0 cocci
hexagon              randconfig-r2301-20261006    gcc-8.5.0  sparse
hexagon              randconfig-r2307-20261006    gcc-10.5.0 sparse
hexagon              randconfig-r2308-20261006    clang-24   sparse
hexagon              randconfig-r2309-20261007    clang-17   sparse
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20261008    clang-22
i386        buildonly-randconfig-1001-20261008    clang-22
i386        buildonly-randconfig-1002-20261008    clang-22
i386        buildonly-randconfig-1003-20261008    clang-22
i386        buildonly-randconfig-1004-20261008    clang-22
i386        buildonly-randconfig-1005-20261008    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261008    gcc-14
i386                  randconfig-1001-20261008    gcc-14
i386                  randconfig-1002-20261008    gcc-14
i386                  randconfig-1003-20261008    gcc-14
i386                  randconfig-1004-20261008    gcc-14
i386                  randconfig-1005-20261008    gcc-14
i386                  randconfig-1006-20261008    gcc-14
i386                  randconfig-1007-20261008    clang-22
i386                  randconfig-1008-20261008    clang-22
i386                  randconfig-1009-20261008    clang-22
i386                  randconfig-1010-20261008    clang-22
i386                  randconfig-1011-20261008    clang-22
i386                  randconfig-1012-20261008    clang-22
i386                  randconfig-1013-20261008    clang-22
i386                  randconfig-2100-20261006    clang-22   cocci
i386                  randconfig-2100-20261007    clang-22   cocci
i386                  randconfig-2101-20261006    clang-22   cocci
i386                  randconfig-2101-20261007    clang-22   cocci
i386                  randconfig-2102-20261006    clang-22   cocci
i386                  randconfig-2102-20261007    clang-22   cocci
i386                  randconfig-2103-20261006    clang-22   cocci
i386                  randconfig-2103-20261007    clang-22   cocci
i386                  randconfig-2200-20261006    gcc-13     smatch
i386                  randconfig-2200-20261007    gcc-14     smatch
i386                  randconfig-2300-20261006    gcc-14     sparse
i386                  randconfig-2300-20261007    clang-22   sparse
i386                  randconfig-2301-20261006    gcc-14     sparse
i386                  randconfig-2301-20261007    clang-22   sparse
i386                  randconfig-2302-20261006    gcc-14     sparse
i386                  randconfig-2302-20261007    clang-22   sparse
i386                 randconfig-r2201-20261006    clang-22   smatch
i386                 randconfig-r2202-20261006    gcc-14     smatch
i386                 randconfig-r2300-20261007    gcc-8.5.0  sparse
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261008    gcc-16.1.0
loongarch             randconfig-1001-20261008    gcc-16.1.0
loongarch            randconfig-r2106-20261006    gcc-8.5.0  cocci
loongarch            randconfig-r2200-20261006    clang-18   smatch
loongarch            randconfig-r2201-20261006    gcc-13.4.0 smatch
loongarch            randconfig-r2301-20261006    gcc-10.5.0 sparse
loongarch            randconfig-r2302-20261006    gcc-10.5.0 sparse
loongarch            randconfig-r2305-20261007    gcc-8.5.0  sparse
loongarch            randconfig-r2307-20261007    clang-24   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                 randconfig-r2101-20261006    gcc-10.5.0 cocci
m68k                 randconfig-r2103-20261006    gcc-9.5.0  cocci
m68k                 randconfig-r2106-20261007    gcc-10.5.0 cocci
m68k                 randconfig-r2303-20261007    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2301-20261006    gcc-10.5.0 sparse
microblaze           randconfig-r2306-20261006    clang-24   sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                          cobalt_defconfig    gcc-16.1.0
mips                     maltaup_xpa_defconfig    gcc-16.1.0
mips                 randconfig-r2303-20261006    gcc-8.5.0  sparse
mips                 randconfig-r2305-20261006    gcc-10.5.0 sparse
mips                 randconfig-r2306-20261007    clang-17   sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261008    gcc-16.1.0
nios2                 randconfig-1001-20261008    gcc-16.1.0
nios2                randconfig-r2100-20261006    gcc-10.5.0 cocci
nios2                randconfig-r2102-20261006    gcc-10.5.0 cocci
nios2                randconfig-r2105-20261007    gcc-10.5.0 cocci
nios2                randconfig-r2106-20261006    gcc-14.3.0 cocci
nios2                randconfig-r2300-20261006    gcc-10.5.0 sparse
nios2                randconfig-r2306-20261006    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2101-20261007    gcc-10.5.0 cocci
openrisc             randconfig-r2103-20261006    gcc-10.5.0 cocci
openrisc             randconfig-r2104-20261006    gcc-8.5.0  cocci
openrisc             randconfig-r2200-20261007    gcc-12.5.0 smatch
openrisc             randconfig-r2307-20261006    gcc-16.1.0 sparse
openrisc             randconfig-r2309-20261006    gcc-10.5.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261008    gcc-8.5.0
parisc                randconfig-1001-20261008    gcc-8.5.0
parisc               randconfig-r2100-20261007    gcc-8.5.0  cocci
parisc               randconfig-r2201-20261007    gcc-8.5.0  smatch
parisc               randconfig-r2309-20261007    clang-24   sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                     ge_imp3a_defconfig    gcc-16.1.0
powerpc                       katmai_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261008    gcc-8.5.0
powerpc               randconfig-1001-20261008    gcc-8.5.0
powerpc64                         alldefconfig    gcc-16.1.0
powerpc64             randconfig-1000-20261008    gcc-8.5.0
powerpc64             randconfig-1001-20261008    gcc-8.5.0
powerpc64            randconfig-r2102-20261006    gcc-9.5.0  cocci
powerpc64            randconfig-r2103-20261007    gcc-10.5.0 cocci
powerpc64            randconfig-r2202-20261007    gcc-10.5.0 smatch
powerpc64            randconfig-r2305-20261006    gcc-10.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261008    gcc-10.5.0
riscv                 randconfig-1001-20261008    gcc-10.5.0
riscv                 randconfig-2000-20261006    gcc-14.3.0
riscv                 randconfig-2000-20261006    gcc-16.1.0
riscv                 randconfig-2000-20261007    gcc-12.5.0
riscv                 randconfig-2001-20261006    gcc-16.1.0
riscv                 randconfig-2001-20261007    gcc-12.5.0
riscv                randconfig-r2105-20261006    gcc-8.5.0  cocci
riscv                randconfig-r2304-20261006    gcc-10.5.0 sparse
riscv                randconfig-r2304-20261007    gcc-8.5.0  sparse
riscv                randconfig-r2308-20261007    clang-17   sparse
s390                              allmodconfig    clang-17
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261008    gcc-10.5.0
s390                  randconfig-1001-20261008    gcc-10.5.0
s390                  randconfig-2000-20261006    gcc-14.3.0
s390                  randconfig-2000-20261006    gcc-16.1.0
s390                  randconfig-2000-20261007    gcc-12.5.0
s390                  randconfig-2001-20261006    gcc-16.1.0
s390                  randconfig-2001-20261006    gcc-8.5.0
s390                  randconfig-2001-20261007    gcc-12.5.0
s390                 randconfig-r2302-20261007    gcc-8.5.0  sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261008    gcc-10.5.0
sh                    randconfig-1001-20261008    gcc-10.5.0
sh                    randconfig-2000-20261006    gcc-16.1.0
sh                    randconfig-2000-20261007    gcc-12.5.0
sh                    randconfig-2001-20261006    gcc-16.1.0
sh                    randconfig-2001-20261007    gcc-12.5.0
sh                   randconfig-r2107-20261006    gcc-14.3.0 cocci
sh                   randconfig-r2302-20261006    gcc-8.5.0  sparse
sh                               ul2_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261008    gcc-14
sparc                 randconfig-1001-20261008    gcc-14
sparc                 randconfig-2000-20261006    clang-24
sparc                 randconfig-2000-20261007    clang-24
sparc                 randconfig-2001-20261006    clang-24
sparc                 randconfig-2001-20261007    clang-24
sparc                randconfig-r2300-20261006    gcc-8.5.0  sparse
sparc                randconfig-r2302-20261006    gcc-10.5.0 sparse
sparc                randconfig-r2303-20261006    gcc-10.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261008    gcc-14
sparc64               randconfig-1001-20261008    gcc-14
sparc64               randconfig-2000-20261006    clang-24
sparc64               randconfig-2000-20261007    clang-24
sparc64               randconfig-2001-20261006    clang-24
sparc64               randconfig-2001-20261007    clang-24
sparc64              randconfig-r2100-20261006    gcc-9.5.0  cocci
sparc64              randconfig-r2308-20261006    gcc-10.5.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261008    gcc-14
um                    randconfig-1001-20261008    gcc-14
um                    randconfig-2000-20261006    clang-24
um                    randconfig-2000-20261007    clang-24
um                    randconfig-2001-20261006    clang-24
um                    randconfig-2001-20261007    clang-24
um                   randconfig-r2107-20261006    gcc-8.5.0  cocci
um                   randconfig-r2202-20261007    clang-24   smatch
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261008    gcc-14
x86_64      buildonly-randconfig-1001-20261008    gcc-14
x86_64      buildonly-randconfig-1002-20261008    gcc-14
x86_64      buildonly-randconfig-1003-20261008    gcc-14
x86_64      buildonly-randconfig-1004-20261008    gcc-14
x86_64      buildonly-randconfig-1005-20261008    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261008    gcc-14
x86_64                randconfig-1001-20261008    gcc-14
x86_64                randconfig-1002-20261008    gcc-14
x86_64                randconfig-1003-20261008    gcc-14
x86_64                randconfig-1004-20261008    gcc-14
x86_64                randconfig-1005-20261008    gcc-14
x86_64                randconfig-1006-20261008    clang-22
x86_64                randconfig-1007-20261008    clang-22
x86_64                randconfig-1008-20261008    clang-22
x86_64                randconfig-1009-20261008    clang-22
x86_64                randconfig-1010-20261008    clang-22
x86_64                randconfig-1011-20261008    clang-22
x86_64                randconfig-1012-20261008    clang-22
x86_64                randconfig-1013-20261008    clang-22
x86_64                randconfig-1014-20261008    clang-22
x86_64                randconfig-1015-20261008    clang-22
x86_64                randconfig-1016-20261008    clang-22
x86_64                randconfig-1017-20261008    clang-22
x86_64                randconfig-2100-20261006    clang-22   cocci
x86_64                randconfig-2100-20261007    clang-22   cocci
x86_64                randconfig-2101-20261006    clang-22   cocci
x86_64                randconfig-2101-20261007    clang-22   cocci
x86_64                randconfig-2102-20261006    clang-22   cocci
x86_64                randconfig-2102-20261007    clang-22   cocci
x86_64                randconfig-2103-20261006    clang-22   cocci
x86_64                randconfig-2103-20261007    clang-22   cocci
x86_64                randconfig-2200-20261006    clang-22   smatch
x86_64                randconfig-2200-20261007    gcc-14     smatch
x86_64                randconfig-2300-20261006    gcc-14     sparse
x86_64                randconfig-2300-20261007    clang-22   sparse
x86_64                randconfig-2301-20261006    gcc-14     sparse
x86_64                randconfig-2301-20261007    clang-22   sparse
x86_64                randconfig-2302-20261006    gcc-14     sparse
x86_64                randconfig-2302-20261007    clang-22   sparse
x86_64               randconfig-r2107-20261007    gcc-10.5.0 cocci
x86_64               randconfig-r2308-20261007    clang-24   sparse
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
xtensa                randconfig-1000-20261008    gcc-14
xtensa                randconfig-1001-20261008    gcc-14
xtensa                randconfig-2000-20261006    clang-24
xtensa                randconfig-2000-20261007    clang-24
xtensa                randconfig-2001-20261006    clang-24
xtensa                randconfig-2001-20261007    clang-24
xtensa               randconfig-r2103-20261007    gcc-8.5.0  cocci
xtensa               randconfig-r2306-20261006    gcc-10.5.0 sparse
xtensa               randconfig-r2307-20261006    clang-24   sparse
xtensa               randconfig-r2307-20261007    clang-17   sparse
xtensa               randconfig-r2309-20261006    gcc-12.5.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
