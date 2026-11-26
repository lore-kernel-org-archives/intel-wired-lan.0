Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91894606A31E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=B0L/8iKO;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UCaT/Aym
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E39160A83;
	Thu, 26 Nov 2026 23:49:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ifRq3gQwtqL0; Thu, 26 Nov 2026 23:49:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 022ED6060C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795736987;
	b=pzB4pUZ0EakXBN975utAA+0EVRcmZL1SShBvCIMtuA4gSXjveg7hzyp1wYwTIip5VgGA
	 y/MRVSYWiqYX2WBKpTKzflTrVSCvO8YUNl+h+FTcU1HQOQu0NGNCmabh41pIBavEcn0Mj
	 obtdApdF9vCJnm1USQVZchoSZg4pdxvTTs0AMyDizCTSrJ86KOdC1WtNVnzkDhN/4idO4
	 Eca2Kf9H7PevoeBuoDTZflY8TnAYc+n9K9rh9a+BfLLDnGDHSqFvKYmTB1CO5rxSthi5L
	 8R/E28NOZai9IJyWf1OgQ6jRXgyqUmzpDyIi7GTGKGke4xyYE4Ua5k4KXDEUUpnldKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795736987;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qzO7HF611rQsTFS1DaW2s141HMcL+rVtiAzLujGK4G4=;
	b=f9svYsP3VXjsMngi61gMe5IklbRcYZzsHtG6ioFkchLodZg6F8NqzUNqL3uQPYWZMvyI
	 ClTRW9kTgrXG9vG/jg81Gpvx2Qawbl4i3XNlzBU0I4B9Rt/I6ES856EHaSsnabJiTEwXL
	 9KzB9CaTp1WyUy+eJXSHd9KCftg9tJbr9ZChru2+NQVLVA6zslCEIxwWs33Hd9fUmQrLj
	 Q3BrMPwd8CrGBQlwpSjGt66Mf2xpKgb0+647gCtiSrZqUFuOiWWnTgLnFiARwDHiHYAjS
	 lAQzsTaxf3GuiGfJ7Mft69tTr/hLqvxk3wkT46/Ql206FvLUX7e6H29RllcSDQq65+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795736987;
	bh=qzO7HF611rQsTFS1DaW2s141HMcL+rVtiAzLujGK4G4=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=B0L/8iKO7vTTJgZlnAJzCCcsbBal0VG0Yr32rA1y5tLteCprzxmosgwJgno09HsUn
	 Iu2xCnG06LNEXGa/bMNJgKxBDUCNG3ZA6dO9hxk7T+S+hH7+XLRA5DQm8SVYUmfsF4
	 7SBFMD9Ina6PUJ/ZoWl0jFB6LfyPT6e1PQzU12+bT40pCFJc39501/O465WOiMS5bL
	 sjGOBvz6KKM7k4iW1s7H1CsRVINun6RC1JIyNeddl/QVXm7hdYkubqJZNB6V6Qsqp9
	 S2fL8hVHgSBIVDubZjafWPbOjCqkyMHL6CdnxgTCMFtQytkqngQ17KGnFxuAfzVBE5
	 2WCF92yHtTh7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 022ED6060C;
	Thu, 26 Nov 2026 23:49:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 667C41AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 23:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 503BA400CB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 23:49:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tu69MKDk9sbI for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 23:49:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C925D400A0
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UCaT/Aym
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C925D400A0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 23:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795736984; x=1827272984; h=date:from:to:subject:message-id;
 bh=ccy16tepiCSVqFzccER9l92/V6X+yY7GmByKwS6NDAM=;
 b=UCaT/AymJr8lnlBKASgevL0idPlVkgimxVVj6OHH4Ek0dpon6qM1Zo2G
 J0kEyYrvjiYbB+6+80C7OTFC+Wts3Qhny5XtSXrnZB4uBI8oeeH3HJxty
 SB8gG+oO8IFIjVeNqsmwueavlIP6aXy1ULUSmQw1XYcW3+/KQZHD3CSi3
 gEuVkH/lhtFI2ceJ6MDoOvBtpGXMZaGey3ewJlIqUmxew0uR/jFbkHs5i
 xlsNJPkqh+ncTd8EmzOt29adXlj12JBaPFlAo7KhZ++yIsQzhnyujx3ki
 qgW3T3KJuLMriu+2QdipOATMqFyhwQq6QECrdniOgTFCR7Jiaqrjywn6z g==;
X-CSE-ConnectionGUID: xrsLEEGoRk2IqD/+rNINMQ==
X-CSE-MsgGUID: 6pPmcNlyT2WyAyj/62Z0Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4531167"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4531167"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 15:49:42 -0800
X-CSE-ConnectionGUID: mqKGBpRgQDm1y+zNdt18Ug==
X-CSE-MsgGUID: p5J8WnczT7OjGN94ejhpiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12306180"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 26 Nov 2026 15:49:41 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xWjDe-00000001V2Q-33mU;
 Thu, 26 Nov 2026 23:49:38 +0000
Date: Fri, 27 Nov 2026 07:48:39 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:100GbE] BUILD SUCCESS
 5c68885ec98f098e5c665b85b5b98f5f1d942d02
Message-ID: <20261127074839.6UAuL5or-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 5c68885ec98f098e5c665b85b5b98f5f1d942d02  ice: fix computation of ETF timestamps for E830

elapsed time: 1513m

configs tested: 345
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                     allnoconfig    gcc-16.2.0
alpha                    allyesconfig    gcc-16.2.0
alpha                       defconfig    gcc-16.2.0
alpha        randconfig-2000-20261125    gcc-8.5.0
alpha        randconfig-2000-20261126    gcc-13.5.0
alpha        randconfig-2001-20261125    gcc-8.5.0
alpha        randconfig-2001-20261126    gcc-13.5.0
alpha        randconfig-2200-20261126    gcc-9.5.0  smatch
alpha       randconfig-r2110-20261126    clang-24   cocci
alpha       randconfig-r2308-20261126    gcc-8.5.0  sparse
arc                      allmodconfig    clang-24
arc                       allnoconfig    gcc-16.2.0
arc                         defconfig    gcc-16.2.0
arc          randconfig-2000-20261126    gcc-9.5.0
arc          randconfig-2001-20261126    gcc-9.5.0
arc          randconfig-2002-20261126    gcc-9.5.0
arc          randconfig-2003-20261126    gcc-9.5.0
arc          randconfig-2004-20261126    gcc-9.5.0
arc          randconfig-2005-20261126    gcc-9.5.0
arc          randconfig-2200-20261125    gcc-14.4.0 smatch
arc          randconfig-2200-20261126    gcc-8.5.0  smatch
arc         randconfig-r2103-20261125    gcc-11.5.0 cocci
arc         randconfig-r2110-20261126    gcc-14     cocci
arc         randconfig-r2111-20261126    gcc-14     cocci
arm                       allnoconfig    gcc-16.2.0
arm                      allyesconfig    clang-24
arm                         defconfig    gcc-16.2.0
arm                    mmp2_defconfig    clang-24
arm          randconfig-2000-20261125    clang-22
arm          randconfig-2000-20261126    gcc-11.5.0
arm          randconfig-2001-20261125    clang-22
arm          randconfig-2001-20261126    gcc-11.5.0
arm          randconfig-2002-20261125    clang-22
arm          randconfig-2002-20261126    gcc-11.5.0
arm          randconfig-2200-20261126    gcc-8.5.0  smatch
arm64                     allnoconfig    gcc-16.2.0
arm64                       defconfig    gcc-16.2.0
arm64        randconfig-1000-20261126    gcc-8.5.0
arm64        randconfig-1001-20261126    gcc-8.5.0
arm64        randconfig-1002-20261126    gcc-8.5.0
arm64        randconfig-1003-20261126    gcc-8.5.0
arm64        randconfig-2000-20261125    clang-22
arm64        randconfig-2000-20261126    gcc-11.5.0
arm64        randconfig-2001-20261125    clang-22
arm64        randconfig-2001-20261126    gcc-11.5.0
arm64        randconfig-2002-20261125    clang-22
arm64        randconfig-2002-20261126    gcc-11.5.0
arm64        randconfig-2200-20261126    clang-24   smatch
arm64       randconfig-r2301-20261126    clang-20   sparse
arm64       randconfig-r2308-20261126    clang-24   sparse
csky                     allmodconfig    gcc-16.2.0
csky                      allnoconfig    gcc-16.2.0
csky                        defconfig    gcc-16.2.0
csky         randconfig-1000-20261126    gcc-8.5.0
csky         randconfig-1001-20261126    gcc-8.5.0
csky         randconfig-2000-20261125    gcc-14.4.0
csky         randconfig-2000-20261126    gcc-13.5.0
csky         randconfig-2001-20261125    gcc-14.4.0
csky         randconfig-2001-20261126    gcc-13.5.0
csky         randconfig-2200-20261126    gcc-13.5.0 smatch
csky        randconfig-r2102-20261126    gcc-14.4.0 cocci
csky        randconfig-r2105-20261125    gcc-11.5.0 cocci
csky        randconfig-r2300-20261126    clang-20   sparse
csky        randconfig-r2304-20261126    gcc-12.5.0 sparse
csky        randconfig-r2305-20261125    gcc-12     sparse
hexagon                  allmodconfig    gcc-16.2.0
hexagon                   allnoconfig    gcc-16.2.0
hexagon                     defconfig    gcc-16.2.0
hexagon      randconfig-1000-20261126    gcc-11.5.0
hexagon      randconfig-1001-20261126    gcc-11.5.0
hexagon      randconfig-2000-20261125    gcc-14.4.0
hexagon      randconfig-2000-20261126    gcc-13.5.0
hexagon      randconfig-2001-20261125    gcc-14.4.0
hexagon      randconfig-2001-20261126    gcc-13.5.0
hexagon      randconfig-2200-20261126    clang-17   smatch
hexagon     randconfig-r2104-20261126    gcc-8.5.0  cocci
hexagon     randconfig-r2311-20261126    gcc-10.5.0 sparse
i386                     allmodconfig    clang-22
i386                      allnoconfig    gcc-16.2.0
i386                     allyesconfig    clang-22
i386                        defconfig    gcc-16.2.0
i386         randconfig-1000-20261126    clang-22
i386         randconfig-1001-20261126    clang-22
i386         randconfig-1002-20261126    clang-22
i386         randconfig-1003-20261126    clang-22
i386         randconfig-1004-20261126    clang-22
i386         randconfig-1005-20261126    clang-22
i386         randconfig-1006-20261126    clang-22
i386         randconfig-2000-20261125    gcc-14
i386         randconfig-2000-20261126    clang-22
i386         randconfig-2001-20261125    gcc-14
i386         randconfig-2001-20261126    clang-22
i386         randconfig-2002-20261125    gcc-14
i386         randconfig-2002-20261126    clang-22
i386         randconfig-2003-20261125    gcc-14
i386         randconfig-2003-20261126    clang-22
i386         randconfig-2004-20261125    gcc-14
i386         randconfig-2004-20261126    clang-22
i386         randconfig-2005-20261125    gcc-14
i386         randconfig-2005-20261126    clang-22
i386         randconfig-2100-20261126    clang-22   cocci
i386         randconfig-2101-20261126    clang-22   cocci
i386         randconfig-2102-20261126    clang-22   cocci
i386         randconfig-2103-20261126    clang-22   cocci
i386         randconfig-2104-20261126    clang-22   cocci
i386         randconfig-2105-20261126    clang-22   cocci
i386         randconfig-2200-20261126    gcc-14     smatch
i386         randconfig-2300-20261125    clang-22   sparse
i386         randconfig-2300-20261126    gcc-14     sparse
i386         randconfig-2301-20261125    clang-22   sparse
i386         randconfig-2301-20261126    gcc-14     sparse
i386         randconfig-2302-20261125    clang-22   sparse
i386         randconfig-2302-20261126    gcc-14     sparse
i386        randconfig-r2102-20261125    gcc-11.5.0 cocci
i386        randconfig-r2300-20261126    gcc-12.5.0 sparse
i386        randconfig-r2301-20261125    gcc-12     sparse
i386        randconfig-r2303-20261125    gcc-12     sparse
i386        randconfig-r2304-20261125    gcc-12     sparse
loongarch                 allnoconfig    gcc-16.2.0
loongarch                   defconfig    clang-24
loongarch    randconfig-1000-20261126    gcc-11.5.0
loongarch    randconfig-1001-20261126    gcc-11.5.0
loongarch    randconfig-2000-20261126    gcc-12.5.0
loongarch    randconfig-2001-20261126    gcc-12.5.0
loongarch    randconfig-2200-20261126    gcc-14.4.0 smatch
loongarch   randconfig-r2307-20261126    gcc-10.5.0 sparse
loongarch   randconfig-r2307-20261126    gcc-8.5.0  sparse
m68k                     allmodconfig    gcc-16.2.0
m68k                      allnoconfig    gcc-16.2.0
m68k                     allyesconfig    clang-24
m68k                        defconfig    clang-24
m68k                  hp300_defconfig    clang-24
m68k         randconfig-2000-20261125    gcc-8.5.0
m68k         randconfig-2000-20261126    gcc-13.5.0
m68k         randconfig-2001-20261125    gcc-8.5.0
m68k         randconfig-2001-20261126    gcc-13.5.0
m68k        randconfig-r2101-20261125    gcc-11.5.0 cocci
m68k        randconfig-r2105-20261126    gcc-14.4.0 cocci
m68k        randconfig-r2302-20261126    gcc-12.5.0 sparse
microblaze                allnoconfig    gcc-16.2.0
microblaze               allyesconfig    gcc-16.2.0
microblaze                  defconfig    clang-24
microblaze   randconfig-2000-20261125    gcc-8.5.0
microblaze   randconfig-2000-20261126    gcc-13.5.0
microblaze   randconfig-2001-20261125    gcc-8.5.0
microblaze   randconfig-2001-20261126    gcc-13.5.0
microblaze   randconfig-2200-20261126    gcc-9.5.0  smatch
microblaze  randconfig-r2105-20261126    gcc-8.5.0  cocci
microblaze  randconfig-r2301-20261126    gcc-12.5.0 sparse
mips                     allmodconfig    gcc-16.2.0
mips                      allnoconfig    gcc-16.2.0
mips                     allyesconfig    gcc-16.2.0
mips             cu1000-neo_defconfig    clang-24
mips              loongson3_defconfig    clang-24
mips                omega2p_defconfig    clang-24
mips         randconfig-2000-20261126    gcc-16.2.0
mips         randconfig-2001-20261126    gcc-16.2.0
mips         randconfig-2002-20261126    gcc-16.2.0
mips         randconfig-2200-20261126    gcc-15.3.0 smatch
mips        randconfig-r2101-20261126    gcc-8.5.0  cocci
mips        randconfig-r2106-20261126    clang-24   cocci
mips        randconfig-r2106-20261126    gcc-14     cocci
mips        randconfig-r2108-20261126    clang-24   cocci
mips        randconfig-r2109-20261126    clang-24   cocci
mips        randconfig-r2300-20261125    gcc-12     sparse
mips        randconfig-r2303-20261126    clang-20   sparse
nios2                    allmodconfig    clang-20
nios2                     allnoconfig    clang-24
nios2                       defconfig    clang-24
nios2        randconfig-1000-20261126    gcc-11.5.0
nios2        randconfig-1001-20261126    gcc-11.5.0
nios2        randconfig-2000-20261126    gcc-12.5.0
nios2        randconfig-2001-20261126    gcc-12.5.0
nios2        randconfig-2200-20261125    gcc-8.5.0  smatch
nios2        randconfig-2200-20261126    gcc-9.5.0  smatch
nios2       randconfig-r2107-20261126    gcc-14     cocci
nios2       randconfig-r2310-20261126    gcc-10.5.0 sparse
openrisc                 allmodconfig    clang-20
openrisc                  allnoconfig    clang-24
openrisc     randconfig-2000-20261126    gcc-16.2.0
openrisc     randconfig-2001-20261126    gcc-16.2.0
openrisc     randconfig-2002-20261126    gcc-16.2.0
openrisc     randconfig-2200-20261125    gcc-10.5.0 smatch
openrisc     randconfig-2200-20261126    gcc-9.5.0  smatch
openrisc    randconfig-r2100-20261126    gcc-14.4.0 cocci
openrisc    randconfig-r2310-20261126    clang-24   sparse
parisc                   allmodconfig    gcc-16.2.0
parisc                    allnoconfig    clang-24
parisc                   allyesconfig    clang-17
parisc       randconfig-2000-20261126    gcc-12.5.0
parisc       randconfig-2001-20261126    gcc-12.5.0
parisc       randconfig-2200-20261126    gcc-15.3.0 smatch
parisc64                    defconfig    clang-24
powerpc                  allmodconfig    gcc-16.2.0
powerpc                   allnoconfig    clang-24
powerpc              chrp32_defconfig    clang-24
powerpc             mpc5200_defconfig    clang-24
powerpc      randconfig-2000-20261126    clang-24
powerpc      randconfig-2001-20261126    clang-24
powerpc      randconfig-2002-20261126    clang-24
powerpc      randconfig-2200-20261126    clang-24   smatch
powerpc     randconfig-r2100-20261125    gcc-11.5.0 cocci
powerpc     randconfig-r2101-20261126    gcc-14.4.0 cocci
powerpc     randconfig-r2104-20261126    gcc-14.4.0 cocci
powerpc     randconfig-r2308-20261126    gcc-10.5.0 sparse
powerpc64    randconfig-2000-20261126    clang-24
powerpc64    randconfig-2001-20261126    clang-24
powerpc64    randconfig-2002-20261126    clang-24
powerpc64    randconfig-2200-20261126    clang-24   smatch
powerpc64   randconfig-r2307-20261126    clang-24   sparse
powerpc64   randconfig-r2309-20261126    gcc-10.5.0 sparse
riscv                     allnoconfig    clang-24
riscv                    allyesconfig    clang-24
riscv        randconfig-2000-20261126    gcc-10.5.0
riscv        randconfig-2001-20261126    gcc-10.5.0
riscv        randconfig-2002-20261126    gcc-10.5.0
riscv        randconfig-2003-20261126    gcc-10.5.0
riscv        randconfig-2004-20261126    gcc-10.5.0
riscv        randconfig-2005-20261126    gcc-10.5.0
riscv        randconfig-2200-20261126    gcc-8.5.0  smatch
riscv       randconfig-r2302-20261125    gcc-12     sparse
riscv       randconfig-r2309-20261126    clang-24   sparse
riscv       randconfig-r2309-20261126    gcc-8.5.0  sparse
s390                     allmodconfig    clang-17
s390                      allnoconfig    clang-24
s390                     allyesconfig    gcc-16.2.0
s390         randconfig-2000-20261126    clang-24
s390         randconfig-2001-20261126    clang-24
s390         randconfig-2002-20261126    clang-24
s390         randconfig-2003-20261126    clang-24
s390         randconfig-2004-20261126    clang-24
s390         randconfig-2005-20261126    clang-24
s390         randconfig-2200-20261126    gcc-16.2.0 smatch
s390        randconfig-r2102-20261126    gcc-8.5.0  cocci
s390        randconfig-r2303-20261126    gcc-12.5.0 sparse
sh                       allmodconfig    gcc-16.2.0
sh                        allnoconfig    clang-24
sh                       allyesconfig    clang-17
sh           randconfig-2000-20261125    gcc-14.4.0
sh           randconfig-2000-20261126    gcc-9.5.0
sh           randconfig-2001-20261125    gcc-14.4.0
sh           randconfig-2001-20261126    gcc-9.5.0
sh           randconfig-2002-20261125    gcc-14.4.0
sh           randconfig-2002-20261126    gcc-9.5.0
sh           randconfig-2003-20261125    gcc-14.4.0
sh           randconfig-2003-20261126    gcc-9.5.0
sh           randconfig-2004-20261125    gcc-14.4.0
sh           randconfig-2004-20261126    gcc-9.5.0
sh           randconfig-2005-20261125    gcc-14.4.0
sh           randconfig-2005-20261126    gcc-9.5.0
sh           randconfig-2200-20261126    gcc-16.2.0 smatch
sh          randconfig-r2103-20261126    gcc-8.5.0  cocci
sh          randconfig-r2104-20261125    gcc-11.5.0 cocci
sh          randconfig-r2108-20261126    gcc-14     cocci
sh          randconfig-r2304-20261126    clang-20   sparse
sh          randconfig-r2311-20261126    gcc-8.5.0  sparse
sh                   sh2007_defconfig    clang-24
sparc                     allnoconfig    clang-24
sparc        randconfig-1000-20261126    clang-17
sparc        randconfig-1001-20261126    clang-17
sparc        randconfig-2000-20261126    gcc-8.5.0
sparc        randconfig-2001-20261126    gcc-8.5.0
sparc        randconfig-2200-20261126    gcc-13.5.0 smatch
sparc       randconfig-r2305-20261126    gcc-12.5.0 sparse
sparc64                  allmodconfig    clang-20
sparc64      randconfig-1000-20261126    clang-17
sparc64      randconfig-1001-20261126    clang-17
sparc64      randconfig-2000-20261126    gcc-8.5.0
sparc64      randconfig-2001-20261126    gcc-8.5.0
sparc64      randconfig-2200-20261125    gcc-15.3.0 smatch
sparc64      randconfig-2200-20261126    gcc-12.5.0 smatch
sparc64     randconfig-r2103-20261126    gcc-14.4.0 cocci
sparc64     randconfig-r2302-20261126    clang-20   sparse
sparc64     randconfig-r2306-20261126    clang-24   sparse
sparc64     randconfig-r2310-20261126    gcc-8.5.0  sparse
sparc64     randconfig-r2311-20261126    clang-24   sparse
um                       allmodconfig    clang-17
um                        allnoconfig    clang-24
um                       allyesconfig    gcc-16.2.0
um           randconfig-1000-20261126    clang-17
um           randconfig-1001-20261126    clang-17
um           randconfig-2000-20261126    gcc-8.5.0
um           randconfig-2001-20261126    gcc-8.5.0
um           randconfig-2200-20261125    clang-17   smatch
um           randconfig-2200-20261126    gcc-12     smatch
um          randconfig-r2109-20261126    gcc-14     cocci
um          randconfig-r2305-20261126    clang-20   sparse
um          randconfig-r2306-20261126    gcc-8.5.0  sparse
x86_64                    allnoconfig    clang-24
x86_64                          kexec    clang-22
x86_64       randconfig-2000-20261125    gcc-14
x86_64       randconfig-2000-20261126    clang-22
x86_64       randconfig-2001-20261125    gcc-14
x86_64       randconfig-2001-20261126    clang-22
x86_64       randconfig-2002-20261125    gcc-14
x86_64       randconfig-2002-20261126    clang-22
x86_64       randconfig-2003-20261125    gcc-14
x86_64       randconfig-2003-20261126    clang-22
x86_64       randconfig-2004-20261125    gcc-14
x86_64       randconfig-2004-20261126    clang-22
x86_64       randconfig-2005-20261125    gcc-14
x86_64       randconfig-2005-20261126    clang-22
x86_64       randconfig-2100-20261125    clang-22   cocci
x86_64       randconfig-2100-20261126    gcc-14     cocci
x86_64       randconfig-2101-20261125    clang-22   cocci
x86_64       randconfig-2101-20261126    gcc-14     cocci
x86_64       randconfig-2102-20261125    clang-22   cocci
x86_64       randconfig-2102-20261126    gcc-14     cocci
x86_64       randconfig-2103-20261125    clang-22   cocci
x86_64       randconfig-2103-20261126    gcc-14     cocci
x86_64       randconfig-2104-20261125    clang-22   cocci
x86_64       randconfig-2104-20261126    gcc-14     cocci
x86_64       randconfig-2105-20261125    clang-22   cocci
x86_64       randconfig-2105-20261126    gcc-14     cocci
x86_64       randconfig-2200-20261126    clang-22   smatch
x86_64       randconfig-2300-20261125    clang-22   sparse
x86_64       randconfig-2300-20261126    gcc-14     sparse
x86_64       randconfig-2301-20261125    clang-22   sparse
x86_64       randconfig-2301-20261126    gcc-14     sparse
x86_64       randconfig-2302-20261125    clang-22   sparse
x86_64       randconfig-2302-20261126    gcc-14     sparse
x86_64      randconfig-r2100-20261126    gcc-8.5.0  cocci
x86_64                       rhel-9.4    clang-22
x86_64                   rhel-9.4-bpf    clang-22
x86_64                   rhel-9.4-bpf    gcc-14
x86_64                  rhel-9.4-func    clang-22
x86_64            rhel-9.4-kselftests    clang-22
x86_64                 rhel-9.4-kunit    clang-22
x86_64                 rhel-9.4-kunit    gcc-14
x86_64                   rhel-9.4-ltp    clang-22
x86_64                   rhel-9.4-ltp    gcc-14
x86_64                  rhel-9.4-rust    clang-22
x86_64                  rhel-9.4-rust    clang-22
xtensa                    allnoconfig    clang-24
xtensa                   allyesconfig    clang-20
xtensa       randconfig-1000-20261126    clang-17
xtensa       randconfig-1001-20261126    clang-17
xtensa       randconfig-2000-20261125    gcc-14.4.0
xtensa       randconfig-2000-20261126    gcc-13.5.0
xtensa       randconfig-2001-20261125    gcc-14.4.0
xtensa       randconfig-2001-20261126    gcc-13.5.0
xtensa       randconfig-2200-20261126    gcc-11.5.0 smatch
xtensa      randconfig-r2107-20261126    clang-24   cocci
xtensa      randconfig-r2111-20261126    clang-24   cocci
xtensa      randconfig-r2306-20261126    gcc-10.5.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
