Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AFC606A32C
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=CMAM5ZvE;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FWMhvB85
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B530E60A4C;
	Fri,  6 Nov 2026 21:56:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lXieICCPfePw; Fri,  6 Nov 2026 21:56:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8262560ABC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002189;
	b=ScTXu1bCg4VBiey5E4D5BoD21iolIVbkSfrd+WTtRUvKEbhSNYjLAxV5LMPYxS8pO060
	 xjn28zA++ZKLGWhmMMbMB1Jx4HluyIa+DNJ6tIiKlK+GR/YYdcIQyy/27EffJAx9L7W+t
	 ubbwco/UplBgJoYSNo1j8FnzJf0kL89UZU0nG2z0+eI3jfLk2HZ1KOpqBoWsKC1jlZQBq
	 rvIY6DYlQd0BoBMcVUohKLeAmp6JauD9TXiCdRMBoXsGcbEH0ycf7xAVPwMl84229LHRB
	 sV4InMasnumniyUYIDaSkz+qhwYh5H/GkZc6XkbF64TCKPiYAmUWOUQI/svJL7CVuqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002189;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XwVbbWtKljc4zMz5+t1RdnirY6Ntxf2Prho79ygScZQ=;
	b=Iusy03+g/o7xkVotv3CbILIrlqts6Zij4XfWUsBtPtG5MPzc0eeLSVVIzM2degJTslPR
	 NWBFy3bzDMNyRUDP+9BAkjvvM3opi4hWGrzSQAFO2sUTCniB1fpY2TbjirDA/pj2A/kh4
	 AOSqu7T8hhf17NiSRXOeYwTkiThJM631UoIpVj6tpbYltPTPvKeNSI/SqkNsi5f/ckGDb
	 WWpo2tY3JT25Z1idRV9LBxfauISNIvQj9T1o0824yAUPEzOXjemMro8jz4J//Iq4PyZxB
	 wzwc4xJOIPlT/WHNUPXw9q7gfEUv1jSlc0XjkOkXJdR9ZBXyR7CEDhR4fmNvh7+ddag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794002189;
	bh=XwVbbWtKljc4zMz5+t1RdnirY6Ntxf2Prho79ygScZQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CMAM5ZvEyHpc9aK6dIyupdPpVBk6T1wdEGdIFSoZJ5sts7HqR5maBqKTzs640kXK7
	 J/Hs9Te9JTCQP31xU8aC8uJvCuLJRhcPyhNy5xW+sl4jsxy7JOWbUWKm6gikAK5bQU
	 ydLrcC0K8UqtFQl/8IDZ12Y6QH0XcLUjC4PW2OfIRbSfWxXqFmsUNfEPVVVsYuDZqq
	 DcwQlyEE3I3C3BXEElq2UphKKbVJFZO4h2zr8DYqRrPsMEx33F5WpBXtesPrJYswZi
	 K38pX8OeCURceBoUXOZ+tqWEAUpimwCS1JkawLMyPQOr1vMK6RLa51ToEBOH40MVsK
	 YhAGX6oj8kK+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8262560ABC;
	Fri,  6 Nov 2026 21:56:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 40219235
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 21:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31D7D4087D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 21:56:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z2dL1FaYd52o for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 21:56:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B010B4087B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FWMhvB85
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B010B4087B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 21:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794002187; x=1825538187; h=date:from:to:subject:message-id;
 bh=kph7NmR8a/ZJIETylN6bMkiSgxcLD5afEcKUYtUA9sQ=;
 b=FWMhvB85KW96uHG+DB8cxRhKtVhYTIJ81+fp2gdeeOOJRNFOwfEW0ZRe
 fhnxORGXnwWch4AvChoboR4hb4iT7vES+tsO7K+hEFxkQQb8TEG1VLQDf
 603KGP1HL+l8lwLj3/JzRa3bAy7mfHAr9uq2Oj/fL194JM8Sh6YLNCint
 YgD5ewPlX8zPpGuQi8cPylJTGGq5tFDWL3ZIEzdlTSMtB7Be0+UOZzcyy
 GT8LeSe9FH9SkpGzXJ0roigDDTBTU23wrQZtpK6QWeg/jSW8na2WEVxOy
 OIC0EAGzHFnUkB+redgI7ZryilsJimgprDAbEnjO3ki+Mi1wkKJ6RnAkI A==;
X-CSE-ConnectionGUID: oSMgW0ffSLqOEe0rgYgwnw==
X-CSE-MsgGUID: b5BYosebQMOHs3ZPqPuzwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2691280"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2691280"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 13:56:26 -0800
X-CSE-ConnectionGUID: Nv41Oq/WTzSPZuqgvnrGEw==
X-CSE-MsgGUID: sMNwYuyORLiFr134xXthHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7532848"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 06 Nov 2026 13:56:24 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xPRv4-00000000pzQ-2G9X;
 Fri, 06 Nov 2026 21:56:22 +0000
Date: Sat, 07 Nov 2026 05:55:33 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 4150d6f3a7b7b533257fbb2d1edbcea031aa9e72
Message-ID: <20261107055533.haIanQ8f-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 4150d6f3a7b7b533257fbb2d1edbcea031aa9e72  ice: register LAG event handler last in ice_init_lag()

elapsed time: 1467m

configs tested: 244
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2200-20261106    gcc-14.4.0 smatch
alpha                randconfig-r2101-20261106    gcc-14.4.0 cocci
alpha                randconfig-r2106-20261106    gcc-12.5.0 cocci
alpha                randconfig-r2302-20261106    gcc-14.4.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261106    gcc-8.5.0
arc                   randconfig-1001-20261106    gcc-8.5.0
arc                   randconfig-2200-20261106    gcc-10.5.0 smatch
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                          lpc32xx_defconfig    clang-17
arm                   randconfig-1000-20261106    gcc-8.5.0
arm                   randconfig-1001-20261106    gcc-8.5.0
arm                   randconfig-1002-20261106    gcc-8.5.0
arm                   randconfig-1003-20261106    gcc-8.5.0
arm                  randconfig-r2100-20261106    gcc-8.5.0  cocci
arm                  randconfig-r2301-20261106    gcc-15.3.0 sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261106    clang-17
arm64                 randconfig-1001-20261106    clang-17
arm64                 randconfig-1002-20261106    clang-17
arm64                 randconfig-1003-20261106    clang-17
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261106    clang-17
csky                  randconfig-1001-20261106    clang-17
csky                  randconfig-2000-20261106    gcc-16.2.0
csky                  randconfig-2001-20261106    gcc-16.2.0
csky                  randconfig-2200-20261106    gcc-10.5.0 smatch
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261106    gcc-14.4.0
hexagon               randconfig-1001-20261106    gcc-14.4.0
hexagon               randconfig-2000-20261106    clang-24
hexagon               randconfig-2001-20261106    clang-24
hexagon               randconfig-2200-20261106    clang-24   smatch
i386                               allnoconfig    gcc-16.2.0
i386        buildonly-randconfig-1000-20261106    clang-22
i386        buildonly-randconfig-1001-20261106    clang-22
i386        buildonly-randconfig-1002-20261106    clang-22
i386        buildonly-randconfig-1003-20261106    clang-22
i386        buildonly-randconfig-1004-20261106    clang-22
i386        buildonly-randconfig-1005-20261106    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261106    gcc-14
i386                  randconfig-1001-20261106    gcc-14
i386                  randconfig-1002-20261106    gcc-14
i386                  randconfig-1003-20261106    gcc-14
i386                  randconfig-1004-20261106    gcc-14
i386                  randconfig-1005-20261106    gcc-14
i386                  randconfig-1006-20261106    gcc-14
i386                  randconfig-1007-20261106    gcc-14
i386                  randconfig-1008-20261106    gcc-14
i386                  randconfig-1010-20261106    gcc-14
i386                  randconfig-1011-20261106    gcc-14
i386                  randconfig-1012-20261106    gcc-14
i386                  randconfig-1013-20261106    gcc-14
i386                  randconfig-2000-20261106    gcc-14
i386                  randconfig-2001-20261106    clang-22
i386                  randconfig-2002-20261106    gcc-14
i386                  randconfig-2003-20261106    gcc-14
i386                  randconfig-2004-20261106    gcc-14
i386                  randconfig-2005-20261106    clang-22
i386                  randconfig-2100-20261106    clang-22   cocci
i386                  randconfig-2101-20261106    gcc-14     cocci
i386                  randconfig-2102-20261106    gcc-14     cocci
i386                  randconfig-2103-20261106    gcc-14     cocci
i386                  randconfig-2104-20261106    clang-22   cocci
i386                  randconfig-2105-20261106    clang-22   cocci
i386                  randconfig-2300-20261106    clang-22   sparse
i386                  randconfig-2301-20261106    gcc-14     sparse
i386                  randconfig-2302-20261106    gcc-14     sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261106    gcc-14.4.0
loongarch             randconfig-1001-20261106    gcc-14.4.0
loongarch             randconfig-2200-20261106    clang-24   smatch
loongarch            randconfig-r2303-20261106    clang-21   sparse
loongarch            randconfig-r2307-20261106    gcc-16.2.0 sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                  randconfig-2200-20261106    gcc-11.5.0 smatch
m68k                 randconfig-r2103-20261106    gcc-10.5.0 cocci
m68k                 randconfig-r2300-20261106    gcc-14.4.0 sparse
m68k                 randconfig-r2308-20261106    gcc-14.4.0 sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2200-20261106    gcc-14.4.0 smatch
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                  randconfig-2200-20261106    clang-17   smatch
mips                 randconfig-r2104-20261106    gcc-11.5.0 cocci
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261106    gcc-14.4.0
nios2                 randconfig-1001-20261106    gcc-14.4.0
nios2                 randconfig-2200-20261106    gcc-10.5.0 smatch
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc              randconfig-2200-20261106    gcc-16.2.0 smatch
openrisc             randconfig-r2304-20261106    gcc-9.5.0  sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                randconfig-1000-20261106    clang-19
parisc                randconfig-1001-20261106    clang-19
parisc               randconfig-r2102-20261106    gcc-8.5.0  cocci
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       ep88xc_defconfig    clang-17
powerpc                       mgcoge_defconfig    clang-17
powerpc               randconfig-1000-20261106    clang-19
powerpc               randconfig-1001-20261106    clang-19
powerpc               randconfig-2000-20261106    gcc-8.5.0
powerpc               randconfig-2001-20261106    clang-24
powerpc               randconfig-2002-20261106    clang-17
powerpc               randconfig-2200-20261106    clang-24   smatch
powerpc              randconfig-r2105-20261106    gcc-9.5.0  cocci
powerpc              randconfig-r2109-20261106    gcc-9.5.0  cocci
powerpc                  xes_mpc85xx_defconfig    clang-17
powerpc64             randconfig-1000-20261106    clang-19
powerpc64             randconfig-1001-20261106    clang-19
powerpc64             randconfig-2000-20261106    clang-22
powerpc64             randconfig-2001-20261106    gcc-13.5.0
powerpc64             randconfig-2002-20261106    gcc-8.5.0
powerpc64            randconfig-r2111-20261106    clang-17   cocci
powerpc64            randconfig-r2310-20261106    gcc-8.5.0  sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                 randconfig-1000-20261106    gcc-14.4.0
riscv                 randconfig-1001-20261106    gcc-14.4.0
riscv                 randconfig-2000-20261106    gcc-9.5.0
riscv                 randconfig-2001-20261106    gcc-15.3.0
riscv                 randconfig-2003-20261106    gcc-15.3.0
riscv                 randconfig-2004-20261106    gcc-13.5.0
riscv                 randconfig-2005-20261106    gcc-15.3.0
riscv                randconfig-r2306-20261106    gcc-9.5.0  sparse
s390                              alldefconfig    clang-17
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                  randconfig-1000-20261106    gcc-14.4.0
s390                  randconfig-1001-20261106    gcc-14.4.0
s390                 randconfig-r2305-20261106    clang-17   sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-17
sh                    randconfig-1000-20261106    gcc-14.4.0
sh                    randconfig-1001-20261106    gcc-14.4.0
sh                    randconfig-2000-20261106    gcc-12.5.0
sh                    randconfig-2001-20261106    gcc-10.5.0
sh                    randconfig-2002-20261106    gcc-16.2.0
sh                    randconfig-2003-20261106    gcc-16.2.0
sh                    randconfig-2004-20261106    gcc-16.2.0
sh                    randconfig-2005-20261106    gcc-16.2.0
sh                    randconfig-2200-20261106    gcc-16.2.0 smatch
sh                              shx3_defconfig    clang-17
sparc                              allnoconfig    clang-24
sparc                 randconfig-1000-20261106    gcc-15.3.0
sparc                 randconfig-1001-20261106    gcc-15.3.0
sparc                 randconfig-2001-20261106    gcc-8.5.0
sparc                 randconfig-2200-20261106    gcc-8.5.0  smatch
sparc                randconfig-r2107-20261106    gcc-14.4.0 cocci
sparc                randconfig-r2108-20261106    gcc-12.5.0 cocci
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261106    gcc-15.3.0
sparc64               randconfig-1001-20261106    gcc-15.3.0
sparc64               randconfig-2000-20261106    gcc-8.5.0
sparc64               randconfig-2001-20261106    gcc-8.5.0
sparc64               randconfig-2200-20261106    gcc-8.5.0  smatch
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261106    gcc-15.3.0
um                    randconfig-1001-20261106    gcc-15.3.0
um                    randconfig-2000-20261106    clang-17
um                    randconfig-2200-20261106    gcc-13     smatch
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261106    gcc-13
x86_64      buildonly-randconfig-1001-20261106    gcc-13
x86_64      buildonly-randconfig-1002-20261106    gcc-13
x86_64      buildonly-randconfig-1003-20261106    gcc-13
x86_64      buildonly-randconfig-1004-20261106    gcc-13
x86_64      buildonly-randconfig-1005-20261106    gcc-13
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261106    clang-22
x86_64                randconfig-1001-20261106    clang-22
x86_64                randconfig-1002-20261106    clang-22
x86_64                randconfig-1003-20261106    clang-22
x86_64                randconfig-1004-20261106    clang-22
x86_64                randconfig-1005-20261106    clang-22
x86_64                randconfig-1012-20261106    gcc-14
x86_64                randconfig-1013-20261106    gcc-14
x86_64                randconfig-1014-20261106    gcc-14
x86_64                randconfig-1015-20261106    gcc-14
x86_64                randconfig-1016-20261106    gcc-14
x86_64                randconfig-1017-20261106    gcc-14
x86_64                randconfig-2200-20261106    gcc-14     smatch
x86_64                randconfig-2300-20261106    clang-22   sparse
x86_64                randconfig-2301-20261106    clang-22   sparse
x86_64                randconfig-2302-20261106    clang-22   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261106    gcc-15.3.0
xtensa                randconfig-1001-20261106    gcc-15.3.0
xtensa                randconfig-2000-20261106    gcc-8.5.0
xtensa                randconfig-2001-20261106    gcc-8.5.0
xtensa                randconfig-2200-20261106    gcc-8.5.0  smatch
xtensa               randconfig-r2110-20261106    gcc-16.2.0 cocci
xtensa               randconfig-r2311-20261106    gcc-12.5.0 sparse
xtensa                     xip_kc705_defconfig    clang-17

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
