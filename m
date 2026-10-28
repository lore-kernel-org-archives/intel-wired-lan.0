Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0EC606A320
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 04:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ueG3ifIX;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bp/8Z0ag
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BB5140581;
	Wed, 28 Oct 2026 04:33:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LVvELpNvhEjz; Wed, 28 Oct 2026 04:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E91A24057D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793162003;
	b=Hu+Waix4+QeSujxGVRoeskGgEcJFhs/qEOnoL8jxl4S3v/lE3FtNtzrb9zNTzJFuCu8C
	 C0lQkWLcXV1McMXFA9sUFAUhfxAR3Bh2Obq7TgPYXfv3kdgb9mNttGUVtd6JDpB4V63Ce
	 6JWvnw1LDxEcdadiu9SZf0YMdqUyZx6jK2LxZPLoO31e7KaouFkzJItg/I1t7RmNMyshV
	 TSjy3ZEjNWyQ7VwfX9U+yhNhz+3mFrEQcjtFDFPxStvubM1oFSBlc9qDTdsmj8u3UHU9p
	 EQIsAq2lp+G4+HC0GFJuLuA5RnAQrNcElaF8zeC6/35QcoeDC0R9rABWmFeUktkx1xQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793162003;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ko/wbm/U/fHcb5X/kGBd8tYwKiumwduD9MYGVzljOms=;
	b=EAuMGlOFdOAPpndiKhB/D/ajl8h/rCWstIsNbGFOAI0E1HvKyBIvBCU11fqOxyPAmG2J
	 UaFa2c2bDFgbpa1D0Y52A62d1q61Ic7tNefS1G8PGd7cx4BLRNeTGcdPzUCnZj17SPwHC
	 AgmHCnxyTATgFDX+9MuL0Bp840Q5yiudlzwCdVZVsgVveKzjmkmOVgkFF21VAZXtFeMzB
	 RX2E9yxamW/7xkpTBRS71xWMhbpUOhnDUkKofYUhpqgUgX1FCIj65QOTy1yXhv3kJctLU
	 4SNxeJqpIF0if0OYyy9Nmfe6EXi+IYQdtGcQew2A0WHQ+lfA6APwaNbAF7w/eBc49xA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793162003;
	bh=ko/wbm/U/fHcb5X/kGBd8tYwKiumwduD9MYGVzljOms=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ueG3ifIXpEgQBcUOmvDl4QvuGkG+EPuQe/5iFfaGO+drFSzev2RQMVRmIMzEQZ+0X
	 xFQOXW/jtRrWC2rfLwaLdKZCh4Je2W6oz7U228v1t0GZWsoOyuIp/irCpdHCFHh164
	 UyYG8YyxDiyaLIQFLZ6LgDeZq7VBn+BtexgKG6seTS2NPFtEBM9rhH3bX2CWI9i/X9
	 nwHVMP7XIGJ57FiQy92NYS5Ms9F0IpwApNKGqraUp2HVPZRBOEy0UZpFoqz6p66Mgy
	 ojRMelun8x4U79bcVFHPg0kFTIiqnUsjYl7X+5mT2QDDdT0GOZ2GF9K5FA5sEH6jLC
	 PknayYq6T+qjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E91A24057D;
	Wed, 28 Oct 2026 04:33:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DB27473
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 04:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F39740111
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 04:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SyKc48aDjaAG for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 04:33:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D8283400F5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793162000;
 b=aXn3EIj2UK/00bW0t4VKppAv7pGH85Y5I+ay7N1wnziZrfc4ZH9FrTfodiAPjfHpVEDr
 PaRFaV/VqSSveb8cwVklsgALSeJUip7aBCOnJ5pMJPmPkwks7rZaef8mdw9QwG1iVSniN
 nedbz0JMAb8DhpXyEuUS+DPXC1O8kit0rAuipQVUTuqnEL4czOTmYhtWfZdYxUrt+PFLo
 d6JHSVP3WDp1X1de9t7c0/ASo6zdk7v76vdjh1MEPdqzqEYpuDlK1koPb/n7B9977NLDM
 ZhIr2sxlCzSh4hjqjWB1opnpB9YoVtumFEUJz6d+T7Si7tegjtEKqYJBfHTgHvodNNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793162000;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=ko/wbm/U/fHcb5X/kGBd8tYwKiumwduD9MYGVzljOms=;
 b=UwJlFxKl9ASfXvNVXqMOsdQsSxpFzrhsz7AOUIfGbKNKsTPYWnW0j+YBiOVKez+NiCYO
 v9fGx4Tw41oof+gUl9Zubl0WKf9KnxF2S8jEr+XHKw/P3B6GnKKZ2Ec47zc7BQTtMm7dO
 cVBjIWrUAR0lDxVV58FwIIVn/xvK+diXy6JleVTCuaHSkwft6YHkBYC9iIQSeasBKOxGB
 73t/mfYOlkmUb1BbEb/LfAMx+o5Dq/20xV6xpyowWNNi3JsmRWF0AAWCrfqRq1Yk0rJAw
 TaC2nAjQSMKjcQfjWIzJu9WdoORQd45VgfVRDHnc+qKnMkzgY7C5JUFeun8ZHAhxS4g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="Bp/8Z0ag"; 
 arc=none smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Bp/8Z0ag
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8283400F5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 04:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793162000; x=1824698000; h=date:from:to:subject:message-id;
 bh=UFTZZ+zUYJhH2djPJtHSOfOjAxTk6Ix2xsX2ovq3+fs=;
 b=Bp/8Z0agd78z6vhH5JSpFtms2wGRghsr10gvfrwAx0pJC/bT6oG0kuOi
 FshogwiKHugWENdf85kdSO3SJCVsStyxWwN6WsNBmEebn49G4cHumk5Sz
 FdF10dnOS8DwkvtZf6J+pGfv12XQtibj3Sn1jN2baoDCcyhNCzTVz05bj
 FV7bBdULOEUyMAkqtxKws0cHzr8XnPEmmHDRKnnH9mgHtCn1vABOY758q
 aup52tA51k0I4GchxHMBT7CcV2YWdAE0n74pkBd+Md6p5JuzmGgcRXs5X
 8Au7GkjfXZVecaBIi0WBNFvgQRoS8xyDTkg5sWmFXWkkPfqVBE5Mlwa5u w==;
X-CSE-ConnectionGUID: yoSjJAvDR8S5AyEkaQ99yg==
X-CSE-MsgGUID: 31tbjhECRQud3PrLuqpZzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1889298"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1889298"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 21:33:18 -0700
X-CSE-ConnectionGUID: K119zbauQ9qkLhCrAlbBUw==
X-CSE-MsgGUID: U55q/QpXSamI8u6Nzmxw4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4825935"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 27 Oct 2026 21:33:16 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xLvLe-00000000YDE-22MR;
 Wed, 28 Oct 2026 04:33:14 +0000
Date: Wed, 28 Oct 2026 12:32:59 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 b7e46a73815485bc5deb94945e50594a8bf6b499
Message-ID: <202610281255.UXq8rmkr-lkp@intel.com>
User-Agent: s-nail v14.9.24
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: b7e46a73815485bc5deb94945e50594a8bf6b499  ice: use struct timecounter for E825 and E830

elapsed time: 5279m

configs tested: 338
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.2.0
arc                           axs101_defconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261026    clang-24
arc                   randconfig-1000-20261027    gcc-10.5.0
arc                   randconfig-1001-20261026    clang-24
arc                   randconfig-1001-20261027    gcc-10.5.0
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                               allyesconfig    gcc-16.2.0
arm                      am200epdkit_defconfig    gcc-16.2.0
arm                                  defconfig    gcc-16.2.0
arm                              mxs_defconfig    clang-17
arm                   randconfig-1000-20261026    clang-24
arm                   randconfig-1000-20261027    gcc-10.5.0
arm                   randconfig-1001-20261026    clang-24
arm                   randconfig-1001-20261027    gcc-10.5.0
arm                   randconfig-1002-20261026    clang-24
arm                   randconfig-1002-20261027    gcc-10.5.0
arm                   randconfig-1003-20261026    clang-24
arm                   randconfig-1003-20261027    gcc-10.5.0
arm                          s5pv210_defconfig    clang-24
arm                     vt8500_v6_v7_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261026    clang-24
arm64                 randconfig-1000-20261027    gcc-8.5.0
arm64                 randconfig-1001-20261026    clang-24
arm64                 randconfig-1001-20261027    gcc-8.5.0
arm64                 randconfig-1002-20261026    clang-24
arm64                 randconfig-1002-20261027    gcc-8.5.0
arm64                 randconfig-1003-20261026    clang-24
arm64                 randconfig-1003-20261027    gcc-8.5.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261026    clang-24
csky                  randconfig-1000-20261027    gcc-8.5.0
csky                  randconfig-1001-20261026    clang-24
csky                  randconfig-1001-20261027    gcc-8.5.0
hexagon                           alldefconfig    clang-17
hexagon                           allmodconfig    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261026    clang-24
hexagon               randconfig-1000-20261027    clang-24
hexagon               randconfig-1001-20261026    clang-24
hexagon               randconfig-1001-20261027    clang-24
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261026    clang-22
i386        buildonly-randconfig-1000-20261027    clang-22
i386        buildonly-randconfig-1001-20261026    clang-22
i386        buildonly-randconfig-1001-20261027    clang-22
i386        buildonly-randconfig-1002-20261026    clang-22
i386        buildonly-randconfig-1002-20261027    clang-22
i386        buildonly-randconfig-1003-20261026    clang-22
i386        buildonly-randconfig-1003-20261027    clang-22
i386        buildonly-randconfig-1004-20261026    clang-22
i386        buildonly-randconfig-1004-20261027    clang-22
i386        buildonly-randconfig-1005-20261026    clang-22
i386        buildonly-randconfig-1005-20261027    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261026    gcc-14
i386                  randconfig-1000-20261027    gcc-14
i386                  randconfig-1001-20261026    gcc-14
i386                  randconfig-1001-20261027    gcc-14
i386                  randconfig-1002-20261026    gcc-14
i386                  randconfig-1002-20261027    gcc-14
i386                  randconfig-1003-20261026    gcc-14
i386                  randconfig-1003-20261027    gcc-14
i386                  randconfig-1004-20261026    gcc-14
i386                  randconfig-1004-20261027    gcc-14
i386                  randconfig-1005-20261026    gcc-14
i386                  randconfig-1005-20261027    gcc-14
i386                  randconfig-1006-20261026    gcc-14
i386                  randconfig-1006-20261027    gcc-14
i386                  randconfig-1007-20261026    clang-22
i386                  randconfig-1007-20261027    gcc-14
i386                  randconfig-1008-20261026    clang-22
i386                  randconfig-1008-20261027    gcc-14
i386                  randconfig-1009-20261026    clang-22
i386                  randconfig-1009-20261027    gcc-14
i386                  randconfig-1010-20261026    clang-22
i386                  randconfig-1010-20261027    gcc-14
i386                  randconfig-1011-20261026    clang-22
i386                  randconfig-1011-20261027    gcc-14
i386                  randconfig-1012-20261026    clang-22
i386                  randconfig-1012-20261027    gcc-14
i386                  randconfig-1013-20261026    clang-22
i386                  randconfig-1013-20261027    gcc-14
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261026    clang-24
loongarch             randconfig-1000-20261027    clang-24
loongarch             randconfig-1001-20261026    clang-24
loongarch             randconfig-1001-20261027    clang-24
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                           amiga_defconfig    clang-17
m68k                          apollo_defconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5475evb_defconfig    clang-24
m68k                         mvme147_defconfig    clang-17
m68k                          nettel_defconfig    gcc-16.2.0
microblaze                        alldefconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                       loongson1_defconfig    gcc-16.2.0
mips                     maltaup_xpa_defconfig    gcc-16.2.0
mips                            mtx1_defconfig    gcc-16.2.0
mips                         qi_lb60_defconfig    clang-17
mips                           rb532_defconfig    clang-24
nios2                          3c120_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261026    clang-24
nios2                 randconfig-1000-20261027    clang-24
nios2                 randconfig-1001-20261026    clang-24
nios2                 randconfig-1001-20261027    clang-24
openrisc                          allmodconfig    clang-20
openrisc                          allmodconfig    gcc-11.5.0
openrisc                          allmodconfig    gcc-16.2.0
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.2.0
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.2.0
parisc                            allyesconfig    clang-17
parisc                            allyesconfig    gcc-16.2.0
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261026    gcc-14.4.0
parisc                randconfig-1000-20261027    clang-22
parisc                randconfig-1000-20261028    clang-19
parisc                randconfig-1001-20261026    gcc-14.4.0
parisc                randconfig-1001-20261027    clang-22
parisc                randconfig-1001-20261028    clang-19
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.2.0
powerpc                     amigaone_defconfig    gcc-16.2.0
powerpc                      asp8347_defconfig    clang-24
powerpc                       bamboo_defconfig    gcc-16.2.0
powerpc                    currituck_defconfig    clang-17
powerpc                    currituck_defconfig    gcc-16.2.0
powerpc                      ep8248e_defconfig    gcc-16.2.0
powerpc                     mvme5100_defconfig    clang-24
powerpc               randconfig-1000-20261026    gcc-14.4.0
powerpc               randconfig-1000-20261027    clang-22
powerpc               randconfig-1000-20261028    clang-19
powerpc               randconfig-1001-20261026    gcc-14.4.0
powerpc               randconfig-1001-20261027    clang-22
powerpc               randconfig-1001-20261028    clang-19
powerpc                      skiroot_defconfig    clang-24
powerpc                      stx_gp3_defconfig    clang-17
powerpc                      tqm8560_defconfig    clang-17
powerpc64             randconfig-1000-20261026    gcc-14.4.0
powerpc64             randconfig-1000-20261027    clang-22
powerpc64             randconfig-1000-20261028    clang-19
powerpc64             randconfig-1001-20261026    gcc-14.4.0
powerpc64             randconfig-1001-20261027    clang-22
powerpc64             randconfig-1001-20261028    clang-19
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.2.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261026    gcc-13.5.0
riscv                 randconfig-1000-20261027    gcc-16.2.0
riscv                 randconfig-1000-20261028    gcc-11.5.0
riscv                 randconfig-1001-20261026    gcc-13.5.0
riscv                 randconfig-1001-20261027    gcc-16.2.0
riscv                 randconfig-1001-20261028    gcc-11.5.0
s390                              allmodconfig    clang-17
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261026    gcc-13.5.0
s390                  randconfig-1000-20261027    gcc-16.2.0
s390                  randconfig-1000-20261028    gcc-11.5.0
s390                  randconfig-1001-20261026    gcc-13.5.0
s390                  randconfig-1001-20261027    gcc-16.2.0
s390                  randconfig-1001-20261028    gcc-11.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.2.0
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.2.0
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261026    gcc-13.5.0
sh                    randconfig-1000-20261027    gcc-16.2.0
sh                    randconfig-1000-20261028    gcc-11.5.0
sh                    randconfig-1001-20261026    gcc-13.5.0
sh                    randconfig-1001-20261027    gcc-16.2.0
sh                    randconfig-1001-20261028    gcc-11.5.0
sh                           rsk7201_defconfig    gcc-16.2.0
sh                            se7712_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.2.0
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261026    gcc-14
sparc                 randconfig-1000-20261027    clang-20
sparc                 randconfig-1001-20261026    gcc-14
sparc                 randconfig-1001-20261027    clang-20
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261026    gcc-14
sparc64               randconfig-1000-20261027    clang-20
sparc64               randconfig-1001-20261026    gcc-14
sparc64               randconfig-1001-20261027    clang-20
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261026    gcc-14
um                    randconfig-1000-20261027    clang-20
um                    randconfig-1001-20261026    gcc-14
um                    randconfig-1001-20261027    clang-20
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261026    clang-22
x86_64      buildonly-randconfig-1000-20261027    gcc-14
x86_64      buildonly-randconfig-1000-20261028    clang-22
x86_64      buildonly-randconfig-1001-20261026    clang-22
x86_64      buildonly-randconfig-1001-20261027    gcc-14
x86_64      buildonly-randconfig-1001-20261028    clang-22
x86_64      buildonly-randconfig-1002-20261026    clang-22
x86_64      buildonly-randconfig-1002-20261027    gcc-14
x86_64      buildonly-randconfig-1002-20261028    clang-22
x86_64      buildonly-randconfig-1003-20261026    clang-22
x86_64      buildonly-randconfig-1003-20261027    gcc-14
x86_64      buildonly-randconfig-1003-20261028    clang-22
x86_64      buildonly-randconfig-1004-20261026    clang-22
x86_64      buildonly-randconfig-1004-20261027    gcc-14
x86_64      buildonly-randconfig-1004-20261028    clang-22
x86_64      buildonly-randconfig-1005-20261026    clang-22
x86_64      buildonly-randconfig-1005-20261027    gcc-14
x86_64      buildonly-randconfig-1005-20261028    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261026    clang-22
x86_64                randconfig-1000-20261027    gcc-14
x86_64                randconfig-1001-20261026    clang-22
x86_64                randconfig-1001-20261027    gcc-14
x86_64                randconfig-1002-20261026    clang-22
x86_64                randconfig-1002-20261027    gcc-14
x86_64                randconfig-1003-20261026    clang-22
x86_64                randconfig-1003-20261027    gcc-14
x86_64                randconfig-1004-20261026    clang-22
x86_64                randconfig-1004-20261027    gcc-14
x86_64                randconfig-1005-20261026    clang-22
x86_64                randconfig-1005-20261027    gcc-14
x86_64                randconfig-1006-20261026    gcc-14
x86_64                randconfig-1006-20261027    clang-22
x86_64                randconfig-1006-20261028    gcc-14
x86_64                randconfig-1007-20261026    gcc-14
x86_64                randconfig-1007-20261027    clang-22
x86_64                randconfig-1007-20261028    gcc-14
x86_64                randconfig-1008-20261026    gcc-14
x86_64                randconfig-1008-20261027    clang-22
x86_64                randconfig-1008-20261028    gcc-14
x86_64                randconfig-1009-20261026    gcc-14
x86_64                randconfig-1009-20261027    clang-22
x86_64                randconfig-1009-20261028    gcc-14
x86_64                randconfig-1010-20261026    gcc-14
x86_64                randconfig-1010-20261027    clang-22
x86_64                randconfig-1010-20261028    gcc-14
x86_64                randconfig-1011-20261026    gcc-14
x86_64                randconfig-1011-20261027    clang-22
x86_64                randconfig-1011-20261028    gcc-14
x86_64                randconfig-1012-20261026    gcc-14
x86_64                randconfig-1012-20261027    clang-22
x86_64                randconfig-1012-20261028    gcc-12
x86_64                randconfig-1013-20261026    gcc-14
x86_64                randconfig-1013-20261027    clang-22
x86_64                randconfig-1013-20261028    gcc-12
x86_64                randconfig-1014-20261026    gcc-14
x86_64                randconfig-1014-20261027    clang-22
x86_64                randconfig-1014-20261028    gcc-12
x86_64                randconfig-1015-20261026    gcc-14
x86_64                randconfig-1015-20261027    clang-22
x86_64                randconfig-1015-20261028    gcc-12
x86_64                randconfig-1016-20261026    gcc-14
x86_64                randconfig-1016-20261027    clang-22
x86_64                randconfig-1016-20261028    gcc-12
x86_64                randconfig-1017-20261026    gcc-14
x86_64                randconfig-1017-20261027    clang-22
x86_64                randconfig-1017-20261028    gcc-12
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.2.0
xtensa                            allyesconfig    clang-20
xtensa                            allyesconfig    gcc-16.2.0
xtensa                randconfig-1000-20261026    gcc-14
xtensa                randconfig-1000-20261027    clang-20
xtensa                randconfig-1001-20261026    gcc-14
xtensa                randconfig-1001-20261027    clang-20
xtensa                     xip_kc705_defconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
