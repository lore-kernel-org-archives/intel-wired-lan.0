Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4EF606A33C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=dqadouap;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gv1F6Qst
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE5C84079A;
	Wed, 25 Nov 2026 16:30:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ykgdluHEtLWN; Wed, 25 Nov 2026 16:30:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B3207407D1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795624211;
	b=XqdTjISmrb0/tQ/jUbuKTR8JkmtlSupzHIANSJL9xm7uOE5us/Z0J9e2ejOhmMkNeNLD
	 rVOYX7KRmFBCAZnkGByJOilbkIC3S7S3yv0WCJ0BX6VKPVLgJ9WmBs4JxWHtOQgBQz07m
	 Hnx1lMagW1N1WOv6uDYhTTW19qT3IGupmntDF419wH9IuJKTvqT5BOcC/pwPqUt7qfWNQ
	 pc2cO5a338Iyn8se1nRiR1IB7IU0V3AKsjIBr0fckDUiCI+28S+UpomPiJ/jyJeeVvX1W
	 ghEmx3weV0pI/Qo8x5ZJ/maZ99m3X8ZaUTE3bsMWNxbEzMqy845RbzkAuqVLQbmj/DQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795624211;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vOUZ35UJ2uepoIeri1RFND7KpsaV1FIDbnjIYEgtHWM=;
	b=f67QuZYaJds306+D1AnFyTmJ5f6K59XMENd7GC7y1twYwChm5sG8KZDUj5t+78I1pmBt
	 otuqj4UAkvA5G58bk2cVtXfu/KkHYXVOrHb0rrqoZ1DDzgPLN2yi+fc8rdhJiOl7LP7Cf
	 4UNH8GwBko1yXv1FgxkI3J5SnLX/0EZ/9AL4Yl87Ztb03y+mRWjlPNAM0e4RoNMRp/iEl
	 CgXcpO5Yd/c6LGYyoTsV2Lyf+ozxL5fMrXL1XV6ta5GV3zZW31qd0Pedfwc38erTqoeDw
	 rKkOzIcopWvjZe+9nbYTaXqsRt29Rh+Mn0JBDDS2NdCsJwaZSQK7j7EOtYTwaZ2CUpA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795624211;
	bh=vOUZ35UJ2uepoIeri1RFND7KpsaV1FIDbnjIYEgtHWM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dqadouappLX1GJzcqQuDqRspAe/kqZRV5dy8eXxX3uImw/QnEFqxEPvM+567e+u6Q
	 nqz/6ewZPuczupsp4jpiFFDr8WarkcyFQbeQBjw/F3lWPQ24fsaMy0XGTISno5FXL3
	 MBHQpUag0yw8RuxCae178qbkBSn8yvHldDMn8iD34+tSBFctFQNHL6CZlRpTbscsl2
	 K1Ylj3jltwRsYqdr4l61Y+0JBUxruK0mMr5R+1LIRTiz5UrHm7HhPgbaR/HBqHBcpy
	 k0W2KuWMhmuCIlTyA32m8MSKkYHa3tXoj6gJNA5j0cn+/zo02Kewka/BfaG4VEzFaV
	 a1y/OGih83Xsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3207407D1;
	Wed, 25 Nov 2026 16:30:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6412126D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 562E680E31
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:30:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xAA9LgSYDVqm for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 16:30:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6174780C9A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gv1F6Qst
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6174780C9A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795624209; x=1827160209; h=date:from:to:subject:message-id;
 bh=mgSC9I4pbItDe+bfYH3SzxvHBeydWcjggZu9jTzVB2Y=;
 b=gv1F6QstwrVFdavqoCEier5ZdpeQWedVEvZAIGd/UanZvPZms+ic0iui
 ZRsw0oUdZWdQE4wTyZE+80GRhTcrcC6h09aae4ThnZG7anICOqTkWG+de
 U9sZvQx3CeMpz0Wcjf2PYAd2QyITW0Y5tE8fDbnYctuD43mY4KjFwEwps
 fs75K3OeJuEoNfkiz1z6Ll6kOOA6LepWBKJoo9F7ormjrPG1rgn03xDGX
 99LIvJ6X5oLQjSwTRvRiAFIJLNSiEGJTG5/if2MeDwgCJN6GF5C24d1Bi
 HcxMrkjYvLRWK0vJs21NQUdM2tkfISSA4S1u3E1QJmg+zLkWlVuy1nONB g==;
X-CSE-ConnectionGUID: Ch/u0DLNRGSW84vJ+ZG+lA==
X-CSE-MsgGUID: Z8nZGqp9R9a5INwNg4n4MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4586081"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4586081"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 07:34:56 -0800
X-CSE-ConnectionGUID: pTWIeXGaT7uOTm8qkuhWvw==
X-CSE-MsgGUID: KDD1IhV/Rn2/zDz/yVGdMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="12370161"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa001.fm.intel.com with ESMTP; 25 Nov 2026 07:34:55 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xWF1I-00000001Ry6-3JNy;
 Wed, 25 Nov 2026 15:34:52 +0000
Date: Wed, 25 Nov 2026 23:34:30 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 57f1a1c94a51596ea2c5e9e18691b5787e2e3e58
Message-ID: <20261125233430.phQ7FHnM-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 57f1a1c94a51596ea2c5e9e18691b5787e2e3e58  idpf: preserve tcp-data-split setting across hard resets

elapsed time: 1206m

configs tested: 304
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261125    gcc-12.5.0
alpha                 randconfig-2001-20261125    gcc-8.5.0
alpha                 randconfig-2200-20261124    gcc-8.5.0  smatch
alpha                randconfig-r2305-20261125    gcc-12.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261125    gcc-8.5.0
arc                   randconfig-1001-20261125    gcc-8.5.0
arc                   randconfig-2000-20261124    gcc-8.5.0
arc                   randconfig-2001-20261124    gcc-15.3.0
arc                   randconfig-2002-20261124    gcc-13.5.0
arc                   randconfig-2003-20261124    gcc-8.5.0
arc                   randconfig-2004-20261124    gcc-13.5.0
arc                   randconfig-2005-20261124    gcc-11.5.0
arc                   randconfig-2200-20261125    gcc-14.4.0 smatch
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          bcm2835_defconfig    clang-17
arm                         clps711x_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                          lpc18xx_defconfig    clang-17
arm                          lpc32xx_defconfig    clang-17
arm                           moxart_defconfig    clang-17
arm                           moxart_defconfig    clang-24
arm                          mv78xx0_defconfig    clang-17
arm                           pxa168_defconfig    clang-17
arm                   randconfig-1000-20261125    gcc-8.5.0
arm                   randconfig-1001-20261125    gcc-8.5.0
arm                   randconfig-1002-20261125    gcc-8.5.0
arm                   randconfig-1003-20261125    gcc-8.5.0
arm                   randconfig-2000-20261124    gcc-8.5.0
arm                   randconfig-2001-20261124    clang-17
arm                   randconfig-2002-20261124    clang-24
arm                   randconfig-2200-20261124    clang-17   smatch
arm                  randconfig-r2101-20261124    clang-24   cocci
arm                            sama7_defconfig    clang-17
arm                          socfpga_defconfig    clang-17
arm                           sp7021_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261125    clang-24
arm64                 randconfig-1001-20261125    clang-24
arm64                 randconfig-1002-20261125    clang-24
arm64                 randconfig-1003-20261125    clang-24
arm64                 randconfig-2000-20261124    clang-24
arm64                 randconfig-2002-20261124    clang-24
arm64                 randconfig-2200-20261125    gcc-13.5.0 smatch
arm64                randconfig-r2100-20261124    gcc-14.4.0 cocci
arm64                randconfig-r2303-20261125    clang-17   sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261125    clang-24
csky                  randconfig-1001-20261125    clang-24
csky                  randconfig-2000-20261124    gcc-9.5.0
csky                  randconfig-2001-20261124    gcc-16.2.0
csky                  randconfig-2200-20261125    gcc-16.2.0 smatch
csky                 randconfig-r2302-20261125    gcc-15.3.0 sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261125    gcc-11.5.0
hexagon               randconfig-1001-20261125    gcc-11.5.0
hexagon               randconfig-2000-20261124    clang-17
hexagon               randconfig-2001-20261124    clang-17
hexagon               randconfig-2200-20261125    clang-17   smatch
hexagon              randconfig-r2108-20261124    clang-24   cocci
hexagon              randconfig-r2304-20261125    clang-24   sparse
hexagon              randconfig-r2307-20261125    clang-17   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261125    clang-22
i386        buildonly-randconfig-1001-20261125    clang-22
i386        buildonly-randconfig-1002-20261125    clang-22
i386        buildonly-randconfig-1003-20261125    clang-22
i386        buildonly-randconfig-1004-20261125    clang-22
i386        buildonly-randconfig-1005-20261125    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261125    clang-22
i386                  randconfig-1001-20261125    clang-22
i386                  randconfig-1002-20261125    clang-22
i386                  randconfig-1003-20261125    clang-22
i386                  randconfig-1004-20261125    clang-22
i386                  randconfig-1005-20261125    clang-22
i386                  randconfig-1006-20261125    clang-22
i386                  randconfig-2000-20261124    clang-22
i386                  randconfig-2001-20261124    clang-22
i386                  randconfig-2002-20261124    gcc-14
i386                  randconfig-2003-20261124    clang-22
i386                  randconfig-2004-20261124    gcc-14
i386                  randconfig-2005-20261124    gcc-14
i386                  randconfig-2100-20261124    gcc-14     cocci
i386                  randconfig-2101-20261124    gcc-14     cocci
i386                  randconfig-2102-20261124    clang-22   cocci
i386                  randconfig-2103-20261124    gcc-14     cocci
i386                  randconfig-2104-20261124    gcc-12     cocci
i386                  randconfig-2105-20261124    gcc-14     cocci
i386                  randconfig-2200-20261124    clang-22   smatch
i386                  randconfig-2300-20261125    clang-22   sparse
i386                  randconfig-2301-20261125    clang-22   sparse
i386                  randconfig-2302-20261125    clang-22   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261125    gcc-11.5.0
loongarch             randconfig-1001-20261125    gcc-11.5.0
loongarch             randconfig-2000-20261124    clang-18
loongarch             randconfig-2001-20261124    gcc-12.5.0
loongarch             randconfig-2200-20261125    clang-18   smatch
loongarch            randconfig-r2102-20261124    clang-24   cocci
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                  randconfig-2000-20261125    gcc-8.5.0
m68k                  randconfig-2001-20261125    gcc-11.5.0
m68k                  randconfig-2200-20261125    gcc-15.3.0 smatch
m68k                 randconfig-r2311-20261125    gcc-11.5.0 sparse
m68k                           sun3x_defconfig    clang-17
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261125    gcc-12.5.0
microblaze            randconfig-2001-20261125    gcc-10.5.0
microblaze            randconfig-2200-20261124    gcc-8.5.0  smatch
microblaze           randconfig-r2110-20261124    gcc-8.5.0  cocci
microblaze           randconfig-r2308-20261125    gcc-10.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                           ath79_defconfig    clang-17
mips                      decstation_defconfig    clang-17
mips                  decstation_r4k_defconfig    clang-17
mips                            gcw0_defconfig    clang-24
mips                            ip30_defconfig    clang-17
mips                       pic32mzda_defconfig    clang-24
mips                  randconfig-2000-20261125    gcc-14.4.0
mips                  randconfig-2001-20261125    clang-17
mips                  randconfig-2002-20261125    clang-24
mips                  randconfig-2200-20261124    clang-20   smatch
mips                 randconfig-r2300-20261125    clang-17   sparse
mips                 randconfig-r2309-20261125    clang-24   sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261125    gcc-11.5.0
nios2                 randconfig-1001-20261125    gcc-11.5.0
nios2                 randconfig-2000-20261124    gcc-11.5.0
nios2                 randconfig-2001-20261124    gcc-11.5.0
nios2                 randconfig-2200-20261124    gcc-11.5.0 smatch
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261125    gcc-12.5.0
openrisc              randconfig-2001-20261125    gcc-10.5.0
openrisc              randconfig-2002-20261125    gcc-16.2.0
openrisc              randconfig-2200-20261124    gcc-11.5.0 smatch
openrisc             randconfig-r2106-20261124    gcc-10.5.0 cocci
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261125    clang-24
parisc                randconfig-1001-20261125    clang-24
parisc                randconfig-2000-20261124    gcc-8.5.0
parisc                randconfig-2001-20261124    gcc-8.5.0
parisc                randconfig-2200-20261124    gcc-9.5.0  smatch
parisc               randconfig-r2105-20261124    gcc-14.4.0 cocci
parisc               randconfig-r2111-20261124    gcc-8.5.0  cocci
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      asp8347_defconfig    clang-24
powerpc               randconfig-1000-20261125    clang-24
powerpc               randconfig-1001-20261125    clang-24
powerpc               randconfig-2000-20261124    clang-17
powerpc               randconfig-2001-20261124    gcc-10.5.0
powerpc               randconfig-2002-20261124    clang-24
powerpc               randconfig-2200-20261124    clang-21   smatch
powerpc                      tqm8555_defconfig    clang-17
powerpc64             randconfig-1000-20261125    clang-24
powerpc64             randconfig-1001-20261125    clang-24
powerpc64             randconfig-2000-20261124    clang-24
powerpc64             randconfig-2001-20261124    clang-22
powerpc64             randconfig-2002-20261124    clang-24
powerpc64             randconfig-2200-20261124    gcc-12.5.0 smatch
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261125    gcc-8.5.0
riscv                 randconfig-1001-20261125    gcc-8.5.0
riscv                 randconfig-2000-20261124    gcc-16.2.0
riscv                 randconfig-2000-20261125    gcc-13.5.0
riscv                 randconfig-2001-20261125    gcc-8.5.0
riscv                 randconfig-2002-20261124    clang-24
riscv                 randconfig-2002-20261125    gcc-8.5.0
riscv                 randconfig-2003-20261124    gcc-8.5.0
riscv                 randconfig-2003-20261125    gcc-11.5.0
riscv                 randconfig-2004-20261124    clang-22
riscv                 randconfig-2004-20261125    gcc-8.5.0
riscv                 randconfig-2005-20261125    clang-24
riscv                 randconfig-2200-20261124    gcc-14.4.0 smatch
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261125    gcc-8.5.0
s390                  randconfig-1001-20261125    gcc-8.5.0
s390                  randconfig-2000-20261125    gcc-8.5.0
s390                  randconfig-2001-20261125    gcc-11.5.0
s390                  randconfig-2002-20261125    clang-24
s390                  randconfig-2003-20261125    gcc-8.5.0
s390                  randconfig-2004-20261125    clang-24
s390                  randconfig-2005-20261125    clang-20
s390                  randconfig-2200-20261125    gcc-15.3.0 smatch
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                              espt_defconfig    clang-24
sh                    randconfig-1000-20261125    gcc-8.5.0
sh                    randconfig-1001-20261125    gcc-8.5.0
sh                    randconfig-2000-20261124    gcc-9.5.0
sh                    randconfig-2001-20261124    gcc-11.5.0
sh                    randconfig-2002-20261124    gcc-16.2.0
sh                    randconfig-2003-20261124    gcc-11.5.0
sh                    randconfig-2004-20261124    gcc-16.2.0
sh                    randconfig-2005-20261124    gcc-11.5.0
sh                    randconfig-2200-20261124    gcc-16.2.0 smatch
sh                   randconfig-r2103-20261124    gcc-16.2.0 cocci
sh                   randconfig-r2109-20261124    gcc-11.5.0 cocci
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-2000-20261124    gcc-16.2.0
sparc                 randconfig-2001-20261124    gcc-15.3.0
sparc                 randconfig-2200-20261124    gcc-11.5.0 smatch
sparc64                           alldefconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-2000-20261124    clang-24
sparc64               randconfig-2001-20261124    gcc-8.5.0
sparc64               randconfig-2200-20261124    clang-24   smatch
sparc64              randconfig-r2310-20261125    gcc-8.5.0  sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-2000-20261124    gcc-14
um                    randconfig-2001-20261124    gcc-14
um                    randconfig-2200-20261124    gcc-14     smatch
um                   randconfig-r2301-20261125    gcc-14     sparse
um                   randconfig-r2306-20261125    gcc-14     sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261125    clang-22
x86_64                randconfig-1001-20261125    clang-22
x86_64                randconfig-1002-20261125    clang-22
x86_64                randconfig-1003-20261125    clang-22
x86_64                randconfig-1004-20261125    clang-22
x86_64                randconfig-1005-20261125    clang-22
x86_64                randconfig-2000-20261124    clang-22
x86_64                randconfig-2001-20261124    clang-22
x86_64                randconfig-2002-20261124    gcc-14
x86_64                randconfig-2003-20261124    clang-22
x86_64                randconfig-2004-20261124    gcc-14
x86_64                randconfig-2005-20261124    gcc-14
x86_64                randconfig-2100-20261125    gcc-13     cocci
x86_64                randconfig-2101-20261125    clang-22   cocci
x86_64                randconfig-2102-20261125    clang-22   cocci
x86_64                randconfig-2103-20261125    clang-22   cocci
x86_64                randconfig-2104-20261125    gcc-14     cocci
x86_64                randconfig-2105-20261125    gcc-14     cocci
x86_64                randconfig-2200-20261125    gcc-14     smatch
x86_64                randconfig-2300-20261125    clang-22   sparse
x86_64                randconfig-2301-20261125    clang-22   sparse
x86_64                randconfig-2302-20261125    clang-22   sparse
x86_64               randconfig-r2104-20261124    clang-22   cocci
x86_64               randconfig-r2107-20261124    gcc-14     cocci
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   audio_kc705_defconfig    clang-17
xtensa                randconfig-2000-20261124    gcc-11.5.0
xtensa                randconfig-2001-20261124    gcc-13.5.0
xtensa                randconfig-2200-20261124    gcc-9.5.0  smatch

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
