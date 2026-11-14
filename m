Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADECD606A32E
	for <intel-wired-lan@archiver.kernel.org>; Sat, 14 Nov 2026 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=R3ERf0Ue;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nama0sal
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E4C960628;
	Sat, 14 Nov 2026 21:30:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mHxH9uBaLPP0; Sat, 14 Nov 2026 21:30:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 355446063E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794691819;
	b=MEofgh3Jz30e8bFZUCZyYW2kr+iTiD5Bsq8nz8hjBdsLTwYBfzsqj+uBP1yqhT4nZxU+
	 miKO9EqE8j0fFSIqa2Tson0nifYcQeLiVKF9GHaWtUBQ9saovyjJMWTpQkdlx9LLEis1e
	 wTApegk1YKdiDtWV67198jxzWvm2Qge2DHqFbX+6sa2Vat/ZJCwbAum1qWhOVK9BY4Z/6
	 obIEl0OE89QoLXt+ge3I29/bJkGUcJLrv0QMqxUx9WE1uyHKqp8R5UjJ2zeczIgNm6gcC
	 Hdh74jntFO/Hp++GehYN/LL6JMPC/xv/Ke8RMkBf2SL2OdC6TMQuRhrgDBh+7nw3SQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794691819;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=G6VuGITV467BooIF0ZsYm1E4YTq1PduA3ktdKelCJvk=;
	b=gJm4/0GzPwFkyNTqnlQtAxtSmi1dFYzWP96UAQnFa/gmhrqdGi1lO70WjTKxKOQZNM2b
	 SOJaub0EBadcYlWxSTRxcrGhpoZ3AIMEht49iB2Xu/FCOcm0tN6s5f8vI1oMd8cmORhsv
	 4fi0q5NTage1Aa0VWzkYzC0Ko2Ls+gliy7sbGT/QPu/a+nv6KVi+AQ3B1+5od7ap684X0
	 uhNlowvPRJXk/GnCxgBsNQfnuQQ0wCKtMWdwbxF7HMMdBUfY9fss6engaVOXOx/ch1Wdx
	 0ynCANU04F+vqEtcEG6iisSV9l3JnuA8AHHSJQWP37F/IAWWH+koFqsd4bz8xz8sGQQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794691819;
	bh=G6VuGITV467BooIF0ZsYm1E4YTq1PduA3ktdKelCJvk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R3ERf0UeuhvF/iwK2qmbN7UfgW+Hvyzm5BqxGIHvZUmLh5THvWT00GyTM6+8+IXM4
	 j815LGZtL2cSMIOKpUbaIEvn1RbLhuW7+zkEg5xdOTUWGmOSmeASvZdyehKn66XjY/
	 IJ9hdPtdDQH0+VPf+BTYxXzZasMFtcQnKChFkr46jYxXe+1X6qST4a5ZPcQot76nfg
	 h8LjQfEYbMdFuS2bkV79HAeeLz1FY+CfmAsR1sWrcC8nYT76rAReMNGjyGK5IIyYuV
	 fomFcdjIoPbTsE5AAxafbTj436Io2ZplYenviTubEUJUmvvFYGeWrKrFqDcwb1jV+S
	 WBD70t4Pcg6Zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 355446063E;
	Sat, 14 Nov 2026 21:30:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D38991A6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 21:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF32E40753
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 21:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id izAD7qNwfErj for <intel-wired-lan@lists.osuosl.org>;
 Sat, 14 Nov 2026 21:30:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A4CF40709
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Nama0sal
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A4CF40709
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 21:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794691816; x=1826227816; h=date:from:to:subject:message-id;
 bh=7LlLSshEc/sq9GEGfz1crL6NrHy+nf94vqV2JjoJZbg=;
 b=Nama0sal6nopapiAVwb5QWc5o6g/9exbVNmWEfy3/OmmPbCr3vmUZIm+
 vE7e3+I5GOQEG6SinzPtSnsneAMUOa664+Si7n4EMvEdqMJ5Dhcvy+t4G
 pBNJrJUyBwSiNTwLNlkWOAcUNSs6W2CjFswIRmOakU2sMXtMwunxWCzHA
 QyuPu+sSO0Or7sW3Qo5MSq+oNsfoQh6GCrV7L/hS6K6K3yKDRYRU28vx7
 z4SuAM4uiWQ63rzJFra9DW6126qCdieelPKgeTRGiPddNQOro3rClNciX
 +DDt/7CnrgtgPrrg0vK2JtdRVbp4999CJsw+6x3v3oxGPejQseTFpV7PB g==;
X-CSE-ConnectionGUID: pnbSRRcHS0aaI/lowJoWXA==
X-CSE-MsgGUID: a+tUz8v4RkaMoyEgt8+BwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3334524"
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="3334524"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2026 13:30:15 -0800
X-CSE-ConnectionGUID: Y/L1m/+zTMmn/D7+eBGsvA==
X-CSE-MsgGUID: BhELPiPlQaSmeul9+dU9sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="9220478"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa002.jf.intel.com with ESMTP; 14 Nov 2026 13:30:14 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xSLK7-00000001624-1iMh;
 Sat, 14 Nov 2026 21:30:11 +0000
Date: Sun, 15 Nov 2026 05:29:32 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 4cd5d9c333fb45a4e70ad6a77c44f13bd7312afb
Message-ID: <20261115052932.lxtBXqU1-lkp@intel.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 4cd5d9c333fb45a4e70ad6a77c44f13bd7312afb  ixgbe: document raw ip4 flow match

elapsed time: 799m

configs tested: 402
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261114    gcc-12.5.0
alpha                 randconfig-2001-20261114    gcc-12.5.0
alpha                 randconfig-2200-20261114    gcc-9.5.0  smatch
alpha                randconfig-r2100-20261114    gcc-15.3.0 cocci
alpha                randconfig-r2305-20261114    gcc-8.5.0  sparse
alpha                randconfig-r2308-20261114    gcc-8.5.0  sparse
alpha                randconfig-r2309-20261114    clang-19   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261114    clang-24
arc                   randconfig-1000-20261115    gcc-11.5.0
arc                   randconfig-1001-20261114    clang-24
arc                   randconfig-1001-20261115    gcc-11.5.0
arc                   randconfig-2000-20261114    gcc-11.5.0
arc                   randconfig-2001-20261114    gcc-11.5.0
arc                   randconfig-2002-20261114    gcc-11.5.0
arc                   randconfig-2003-20261114    gcc-11.5.0
arc                   randconfig-2004-20261114    gcc-11.5.0
arc                   randconfig-2005-20261114    gcc-11.5.0
arc                   randconfig-2200-20261114    gcc-8.5.0  smatch
arc                  randconfig-r2100-20261114    gcc-12.5.0 cocci
arc                  randconfig-r2101-20261114    gcc-10.5.0 cocci
arc                  randconfig-r2108-20261114    clang-24   cocci
arc                  randconfig-r2305-20261114    gcc-12.5.0 sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                            omap1_defconfig    clang-24
arm                   randconfig-1000-20261114    clang-24
arm                   randconfig-1000-20261115    gcc-11.5.0
arm                   randconfig-1001-20261114    clang-24
arm                   randconfig-1001-20261115    gcc-11.5.0
arm                   randconfig-1002-20261114    clang-24
arm                   randconfig-1002-20261115    gcc-11.5.0
arm                   randconfig-1003-20261114    clang-24
arm                   randconfig-1003-20261115    gcc-11.5.0
arm                   randconfig-2000-20261114    gcc-10.5.0
arm                   randconfig-2001-20261114    gcc-10.5.0
arm                   randconfig-2002-20261114    gcc-10.5.0
arm                   randconfig-2200-20261114    clang-17   smatch
arm                  randconfig-r2101-20261114    gcc-15.3.0 cocci
arm                  randconfig-r2106-20261114    clang-24   cocci
arm                  randconfig-r2111-20261114    clang-24   cocci
arm                  randconfig-r2309-20261114    clang-24   sparse
arm                  randconfig-r2311-20261114    gcc-8.5.0  sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261114    gcc-16.2.0
arm64                 randconfig-1001-20261114    gcc-16.2.0
arm64                 randconfig-1002-20261114    gcc-16.2.0
arm64                 randconfig-1003-20261114    gcc-16.2.0
arm64                 randconfig-2000-20261114    gcc-10.5.0
arm64                 randconfig-2001-20261114    gcc-10.5.0
arm64                 randconfig-2002-20261114    gcc-10.5.0
arm64                 randconfig-2200-20261114    clang-17   smatch
arm64                randconfig-r2102-20261114    gcc-15.3.0 cocci
arm64                randconfig-r2310-20261114    clang-19   sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261114    gcc-16.2.0
csky                  randconfig-1001-20261114    gcc-16.2.0
csky                  randconfig-2000-20261114    gcc-16.2.0
csky                  randconfig-2001-20261114    gcc-16.2.0
csky                  randconfig-2200-20261114    gcc-16.2.0 smatch
csky                 randconfig-r2302-20261114    gcc-16.2.0 sparse
csky                 randconfig-r2306-20261114    clang-22   sparse
csky                 randconfig-r2307-20261114    clang-24   sparse
csky                 randconfig-r2310-20261114    clang-22   sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261114    clang-24
hexagon               randconfig-1000-20261115    clang-24
hexagon               randconfig-1001-20261114    clang-24
hexagon               randconfig-1001-20261115    clang-24
hexagon               randconfig-2000-20261114    gcc-16.2.0
hexagon               randconfig-2001-20261114    gcc-16.2.0
hexagon               randconfig-2200-20261114    clang-24   smatch
hexagon              randconfig-r2104-20261114    gcc-15.3.0 cocci
hexagon              randconfig-r2111-20261114    clang-17   cocci
hexagon              randconfig-r2311-20261114    clang-19   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261114    gcc-14
i386        buildonly-randconfig-1001-20261114    gcc-14
i386        buildonly-randconfig-1002-20261114    gcc-14
i386        buildonly-randconfig-1003-20261114    gcc-14
i386        buildonly-randconfig-1004-20261114    gcc-14
i386        buildonly-randconfig-1005-20261114    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261114    gcc-12
i386                  randconfig-1000-20261115    clang-22
i386                  randconfig-1001-20261114    gcc-12
i386                  randconfig-1001-20261115    clang-22
i386                  randconfig-1002-20261114    gcc-12
i386                  randconfig-1002-20261115    clang-22
i386                  randconfig-1003-20261114    gcc-12
i386                  randconfig-1003-20261115    clang-22
i386                  randconfig-1004-20261114    gcc-12
i386                  randconfig-1004-20261115    clang-22
i386                  randconfig-1005-20261114    gcc-12
i386                  randconfig-1005-20261115    clang-22
i386                  randconfig-1006-20261114    gcc-12
i386                  randconfig-1006-20261115    clang-22
i386                  randconfig-1007-20261114    clang-22
i386                  randconfig-1008-20261114    clang-22
i386                  randconfig-1009-20261114    clang-22
i386                  randconfig-1010-20261114    clang-22
i386                  randconfig-1011-20261114    clang-22
i386                  randconfig-1012-20261114    clang-22
i386                  randconfig-1013-20261114    clang-22
i386                  randconfig-2000-20261114    clang-22
i386                  randconfig-2001-20261114    clang-22
i386                  randconfig-2002-20261114    clang-22
i386                  randconfig-2003-20261114    clang-22
i386                  randconfig-2004-20261114    clang-22
i386                  randconfig-2005-20261114    clang-22
i386                  randconfig-2100-20261114    gcc-14     cocci
i386                  randconfig-2101-20261114    gcc-14     cocci
i386                  randconfig-2102-20261114    gcc-14     cocci
i386                  randconfig-2103-20261114    gcc-14     cocci
i386                  randconfig-2104-20261114    gcc-14     cocci
i386                  randconfig-2105-20261114    gcc-14     cocci
i386                  randconfig-2200-20261114    gcc-14     smatch
i386                  randconfig-2300-20261114    clang-22   sparse
i386                  randconfig-2301-20261114    clang-22   sparse
i386                  randconfig-2302-20261114    clang-22   sparse
i386                 randconfig-r2101-20261114    gcc-12.5.0 cocci
i386                 randconfig-r2108-20261114    gcc-8.5.0  cocci
i386                 randconfig-r2309-20261114    clang-22   sparse
i386                 randconfig-r2311-20261114    clang-22   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261114    clang-24
loongarch             randconfig-1000-20261115    clang-24
loongarch             randconfig-1001-20261114    clang-24
loongarch             randconfig-1001-20261115    clang-24
loongarch             randconfig-2000-20261114    gcc-11.5.0
loongarch             randconfig-2001-20261114    gcc-11.5.0
loongarch             randconfig-2200-20261114    clang-18   smatch
loongarch            randconfig-r2109-20261114    clang-17   cocci
loongarch            randconfig-r2300-20261114    gcc-16.2.0 sparse
loongarch            randconfig-r2303-20261114    gcc-8.5.0  sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                  randconfig-2000-20261114    gcc-12.5.0
m68k                  randconfig-2001-20261114    gcc-12.5.0
m68k                  randconfig-2200-20261114    gcc-16.2.0 smatch
m68k                 randconfig-r2104-20261114    gcc-11.5.0 cocci
m68k                 randconfig-r2107-20261114    clang-17   cocci
m68k                 randconfig-r2110-20261114    clang-17   cocci
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261114    gcc-12.5.0
microblaze            randconfig-2001-20261114    gcc-12.5.0
microblaze            randconfig-2200-20261114    gcc-9.5.0  smatch
microblaze           randconfig-r2109-20261114    gcc-8.5.0  cocci
microblaze           randconfig-r2302-20261114    gcc-8.5.0  sparse
microblaze           randconfig-r2304-20261114    gcc-8.5.0  sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                            jazz_defconfig    clang-24
mips                         omega2p_defconfig    clang-24
mips                  randconfig-2000-20261114    gcc-16.2.0
mips                  randconfig-2001-20261114    gcc-16.2.0
mips                  randconfig-2002-20261114    gcc-16.2.0
mips                  randconfig-2200-20261114    gcc-15.3.0 smatch
mips                 randconfig-r2105-20261114    gcc-11.5.0 cocci
mips                 randconfig-r2106-20261114    clang-17   cocci
mips                 randconfig-r2108-20261114    clang-17   cocci
mips                 randconfig-r2301-20261114    gcc-16.2.0 sparse
mips                 randconfig-r2303-20261114    gcc-12.5.0 sparse
mips                 randconfig-r2308-20261114    clang-19   sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261114    clang-24
nios2                 randconfig-1000-20261115    clang-24
nios2                 randconfig-1001-20261114    clang-24
nios2                 randconfig-1001-20261115    clang-24
nios2                 randconfig-2000-20261114    gcc-11.5.0
nios2                 randconfig-2001-20261114    gcc-11.5.0
nios2                 randconfig-2200-20261114    gcc-11.5.0 smatch
nios2                randconfig-r2304-20261114    gcc-12.5.0 sparse
nios2                randconfig-r2306-20261114    clang-24   sparse
nios2                randconfig-r2307-20261114    clang-22   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc              randconfig-2000-20261114    gcc-16.2.0
openrisc              randconfig-2001-20261114    gcc-16.2.0
openrisc              randconfig-2002-20261114    gcc-16.2.0
openrisc              randconfig-2200-20261114    gcc-16.2.0 smatch
openrisc             randconfig-r2104-20261114    gcc-10.5.0 cocci
openrisc             randconfig-r2110-20261114    clang-24   cocci
openrisc             randconfig-r2307-20261114    clang-19   sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                randconfig-2000-20261114    gcc-11.5.0
parisc                randconfig-2001-20261114    gcc-11.5.0
parisc                randconfig-2200-20261114    gcc-8.5.0  smatch
parisc               randconfig-r2100-20261114    gcc-10.5.0 cocci
parisc               randconfig-r2103-20261114    gcc-15.3.0 cocci
parisc               randconfig-r2310-20261114    clang-24   sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                    motionpro_defconfig    clang-24
powerpc                      mpc5200_defconfig    clang-24
powerpc                  mpc837x_rdb_defconfig    clang-24
powerpc               randconfig-2000-20261114    gcc-8.5.0
powerpc               randconfig-2001-20261114    gcc-8.5.0
powerpc               randconfig-2002-20261114    gcc-8.5.0
powerpc               randconfig-2200-20261114    clang-24   smatch
powerpc              randconfig-r2101-20261114    gcc-11.5.0 cocci
powerpc              randconfig-r2105-20261114    gcc-10.5.0 cocci
powerpc              randconfig-r2301-20261114    gcc-8.5.0  sparse
powerpc64             randconfig-2000-20261114    gcc-8.5.0
powerpc64             randconfig-2001-20261114    gcc-8.5.0
powerpc64             randconfig-2002-20261114    gcc-8.5.0
powerpc64             randconfig-2200-20261114    clang-17   smatch
powerpc64            randconfig-r2102-20261114    gcc-12.5.0 cocci
powerpc64            randconfig-r2103-20261114    gcc-10.5.0 cocci
powerpc64            randconfig-r2103-20261114    gcc-11.5.0 cocci
powerpc64            randconfig-r2104-20261114    gcc-12.5.0 cocci
powerpc64            randconfig-r2109-20261114    clang-24   cocci
powerpc64            randconfig-r2300-20261114    gcc-12.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                 randconfig-1000-20261114    gcc-15.3.0
riscv                 randconfig-1001-20261114    gcc-15.3.0
riscv                 randconfig-2000-20261114    gcc-12.5.0
riscv                 randconfig-2001-20261114    gcc-12.5.0
riscv                 randconfig-2002-20261114    gcc-12.5.0
riscv                 randconfig-2003-20261114    gcc-12.5.0
riscv                 randconfig-2004-20261114    gcc-12.5.0
riscv                 randconfig-2005-20261114    gcc-12.5.0
riscv                 randconfig-2200-20261114    clang-24   smatch
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                  randconfig-1000-20261114    gcc-15.3.0
s390                  randconfig-1001-20261114    gcc-15.3.0
s390                  randconfig-2000-20261114    clang-24
s390                  randconfig-2001-20261114    clang-24
s390                  randconfig-2002-20261114    clang-24
s390                  randconfig-2003-20261114    clang-24
s390                  randconfig-2004-20261114    clang-24
s390                  randconfig-2005-20261114    clang-24
s390                  randconfig-2200-20261114    clang-24   smatch
s390                 randconfig-r2103-20261114    gcc-12.5.0 cocci
s390                 randconfig-r2107-20261114    gcc-8.5.0  cocci
s390                 randconfig-r2306-20261114    clang-19   sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                          ecovec24_defconfig    clang-24
sh                    randconfig-1000-20261114    gcc-15.3.0
sh                    randconfig-1001-20261114    gcc-15.3.0
sh                    randconfig-2000-20261114    gcc-13.5.0
sh                    randconfig-2001-20261114    gcc-13.5.0
sh                    randconfig-2002-20261114    gcc-13.5.0
sh                    randconfig-2003-20261114    gcc-13.5.0
sh                    randconfig-2004-20261114    gcc-13.5.0
sh                    randconfig-2005-20261114    gcc-13.5.0
sh                    randconfig-2200-20261114    gcc-9.5.0  smatch
sh                   randconfig-r2102-20261114    gcc-11.5.0 cocci
sh                   randconfig-r2105-20261114    gcc-12.5.0 cocci
sh                   randconfig-r2302-20261114    gcc-12.5.0 sparse
sh                   randconfig-r2303-20261114    gcc-16.2.0 sparse
sh                   randconfig-r2307-20261114    gcc-8.5.0  sparse
sh                            se7751_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                 randconfig-1000-20261114    gcc-12.5.0
sparc                 randconfig-1001-20261114    gcc-12.5.0
sparc                 randconfig-2000-20261114    clang-21
sparc                 randconfig-2001-20261114    clang-21
sparc                 randconfig-2200-20261114    gcc-8.5.0  smatch
sparc                randconfig-r2100-20261114    gcc-11.5.0 cocci
sparc                randconfig-r2304-20261114    gcc-16.2.0 sparse
sparc                randconfig-r2309-20261114    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261114    gcc-12.5.0
sparc64               randconfig-1001-20261114    gcc-12.5.0
sparc64               randconfig-2000-20261114    clang-21
sparc64               randconfig-2001-20261114    clang-21
sparc64               randconfig-2200-20261114    gcc-16.2.0 smatch
sparc64              randconfig-r2102-20261114    gcc-10.5.0 cocci
sparc64              randconfig-r2308-20261114    clang-22   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261114    gcc-12.5.0
um                    randconfig-1001-20261114    gcc-12.5.0
um                    randconfig-2000-20261114    clang-21
um                    randconfig-2001-20261114    clang-21
um                    randconfig-2200-20261114    gcc-14     smatch
um                   randconfig-r2110-20261114    gcc-8.5.0  cocci
um                   randconfig-r2111-20261114    gcc-8.5.0  cocci
um                   randconfig-r2308-20261114    clang-24   sparse
um                   randconfig-r2311-20261114    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261114    gcc-14
x86_64      buildonly-randconfig-1001-20261114    gcc-14
x86_64      buildonly-randconfig-1002-20261114    gcc-14
x86_64      buildonly-randconfig-1003-20261114    gcc-14
x86_64      buildonly-randconfig-1004-20261114    gcc-14
x86_64      buildonly-randconfig-1005-20261114    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261114    gcc-14
x86_64                randconfig-1000-20261115    gcc-14
x86_64                randconfig-1001-20261114    gcc-14
x86_64                randconfig-1001-20261115    gcc-14
x86_64                randconfig-1002-20261114    gcc-14
x86_64                randconfig-1002-20261115    gcc-14
x86_64                randconfig-1003-20261114    gcc-14
x86_64                randconfig-1003-20261115    gcc-14
x86_64                randconfig-1004-20261114    gcc-14
x86_64                randconfig-1004-20261115    gcc-14
x86_64                randconfig-1005-20261114    gcc-14
x86_64                randconfig-1005-20261115    gcc-14
x86_64                randconfig-1006-20261114    gcc-14
x86_64                randconfig-1007-20261114    gcc-14
x86_64                randconfig-1008-20261114    gcc-14
x86_64                randconfig-1009-20261114    gcc-14
x86_64                randconfig-1010-20261114    gcc-14
x86_64                randconfig-1011-20261114    gcc-14
x86_64                randconfig-1012-20261114    clang-22
x86_64                randconfig-1012-20261115    gcc-14
x86_64                randconfig-1013-20261114    clang-22
x86_64                randconfig-1013-20261115    gcc-14
x86_64                randconfig-1014-20261114    clang-22
x86_64                randconfig-1014-20261115    gcc-14
x86_64                randconfig-1015-20261114    clang-22
x86_64                randconfig-1015-20261115    gcc-14
x86_64                randconfig-1016-20261114    clang-22
x86_64                randconfig-1016-20261115    gcc-14
x86_64                randconfig-1017-20261114    clang-22
x86_64                randconfig-1017-20261115    gcc-14
x86_64                randconfig-2000-20261114    gcc-14
x86_64                randconfig-2001-20261114    gcc-14
x86_64                randconfig-2002-20261114    gcc-14
x86_64                randconfig-2003-20261114    gcc-14
x86_64                randconfig-2004-20261114    gcc-14
x86_64                randconfig-2005-20261114    gcc-14
x86_64                randconfig-2100-20261114    gcc-14     cocci
x86_64                randconfig-2101-20261114    gcc-14     cocci
x86_64                randconfig-2102-20261114    gcc-14     cocci
x86_64                randconfig-2103-20261114    gcc-14     cocci
x86_64                randconfig-2104-20261114    gcc-14     cocci
x86_64                randconfig-2105-20261114    gcc-14     cocci
x86_64                randconfig-2200-20261114    gcc-14     smatch
x86_64                randconfig-2300-20261114    clang-22   sparse
x86_64                randconfig-2301-20261114    clang-22   sparse
x86_64                randconfig-2302-20261114    clang-22   sparse
x86_64               randconfig-r2105-20261114    gcc-15.3.0 cocci
x86_64               randconfig-r2300-20261114    gcc-8.5.0  sparse
x86_64               randconfig-r2306-20261114    gcc-8.5.0  sparse
x86_64               randconfig-r2310-20261114    gcc-8.5.0  sparse
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
xtensa                randconfig-1000-20261114    gcc-12.5.0
xtensa                randconfig-1001-20261114    gcc-12.5.0
xtensa                randconfig-2000-20261114    gcc-16.2.0
xtensa                randconfig-2001-20261114    gcc-16.2.0
xtensa               randconfig-r2106-20261114    gcc-8.5.0  cocci
xtensa               randconfig-r2107-20261114    clang-24   cocci
xtensa               randconfig-r2301-20261114    gcc-12.5.0 sparse
xtensa               randconfig-r2305-20261114    gcc-16.2.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
