Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCF606A33C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Oct 2026 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ogi/0fWY;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KJvjO9Ga
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD371606C2;
	Wed, 21 Oct 2026 01:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tZxQ_sSfgyrZ; Wed, 21 Oct 2026 01:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BB4B96071D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792545384;
	b=KWqw+0D+sQVlkxxKiL/vISjF6J81UOAjbOireGgX9RYWPeEkhS1JLR0dUfng1OGGZZdd
	 WxUL9mD3NL1KNV2jHVSrINWcv+47MGwZPNBYZ44Cg99D0jHUZ6VQPvItwmnFX0OEYn8Ct
	 koM+8gTaI5LgCC2eN6GTz3q3SJZIM/DVE6F/TPPigvq9csqltbrTnsOvvr16NWPxjNp8e
	 qOyjMpw/5LAtIGbDS8bE2eVqma36HXMfWp6Zo+TyJXQh8l4OE85bcXZsHwP8UekfN4mVE
	 hPAAZeEr2h63fEAcSWtOy9qB7ZWjlGgY3u8ctA10nN/rJ4cjUD4mVghZA1XpchH0feA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792545384;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Reg1s0sD0DasjyOm2T2zuw1aWnM8V02bCFSbBMdiPew=;
	b=Pjp25jpAyjik1r578Mfrhh4vlTJEP3tMIQa36/PLs5IXn2dJcfbAWiIkEwUBgTrkz4h4
	 FefLdj+NDb4PJ+kYOtEF5RsxLiub/mD2F97RwNFyPn4jP2fl6A4cHsdpkt7ehIypqWNhh
	 e1OpPVGDy8rUrJDVRo7zdjdA4AZ/bn4D2GMGnHGNfHdLRLo9j9GRLIt8mHUzxfebfhnxF
	 By8byTldBsQI51vHPvBRQhzHuEP2eFS8F5XUAOwNIbngHy4AhAsO7kBv72yRTSmSMwwwX
	 B8EQfp+QrVB9niHvPIWoQL91WkrFj57JKQ2NNxs6ZvKD10c15SmktueKAfoM5AleIVw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KJvjO9Ga;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792545384;
	bh=Reg1s0sD0DasjyOm2T2zuw1aWnM8V02bCFSbBMdiPew=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ogi/0fWYzioN7oqU7RsOoXGGDXTBuFZnOq5q2qFRQckOOSfq3v9ooi1MHHJNljs/4
	 ElD3EefNYb39ILyaXviJLt9Xozi5xYsYKy8jYAxEetp1W/OuqRGmxQaTE8YVT2JT0I
	 XbpqUF0H5JV/2mGo4W2TcL6d49aYE9veh6TX2+Jsp1Qf1esrYMk/grnIc3R7a9maJK
	 OyqwxV7ATL2cZQbpf7bkLBnF2lUd45+5uhOZ3unhup0jCGRIumtJz8Mc/i5m5pqoyM
	 DF1CybCswOSMtnawnE0o+Y+ymksQVJ1tlPsyb9G1b+HJUx4VdnoG25S2ZTDfLUXesU
	 MdqF92UWY53dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB4B96071D;
	Wed, 21 Oct 2026 01:16:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A72C22A8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 01:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CD446071D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 01:16:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mm-0_Wm4KgOV for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Oct 2026 01:16:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 405C6606C2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792545382;
 b=RZCGS+07+9dnTDmsHZVDq9z4Cee13pZ0ok3fuvXeZM1arz0+YD34A1gwHXkpUrYS1fJu
 cTwzstFXJQZtJiv4kB14o9yOWjFScRLOz6kdg7RuR0O2nknrVAktV/bAPM+h2eFCSGZ6q
 7RqEwQE7Kd8j9JnXzgFZGsYq5Su0sYOh/AVi4GqE7X6LuVihaerw5tP3wTp41BAfVE3ky
 3n3WbXouQhf3H0b3qAMLC91BPBsk0TEnn75MBIU6Z3bS3QZhxXBZBeFqx+QGekHok97E1
 4VurNQr5K+h2aTqBw7ZRMHPP0wX4tFlEtx3v94AGMwKnRYY7ZeDGXOBfUCUvEyPbPUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792545382;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=Reg1s0sD0DasjyOm2T2zuw1aWnM8V02bCFSbBMdiPew=;
 b=KjLqZChRl7JxHSmxdAHNKWn5jHQSAWzjNp/OW9z9UImPZr9lktBgDmTcwBpmCg7T9dxN
 u0SUhakZ3iIIe5ysCOQYak5STV5H82d3q1bxtgoQw2tLgBoF2prFs14D0efSnC6O/CsdO
 GSF6oYkWsQ4HieXm9BXdARPvpQQ+aLCk6Yj07d+8Ndyb+nuJ7exvmPudo+zcfW0RfUnu1
 ez9kMrsi7Qa+SQqQaK+JkLat8lkokBkERu/UskWetR4ZOLE1ERChy2g+ofB5IqG83khpd
 V0zKN7j6ULZSHXHmJ5y7pSkPj6jZw3dU/yiG1Pk5Wy3doxFBnu8KFxfCYkh7hgTAH1A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KJvjO9Ga; 
 arc=none smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KJvjO9Ga
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 405C6606C2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 01:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792545383; x=1824081383; h=date:from:to:subject:message-id;
 bh=w8hD7Y7oXuz91hLsKCcB8l8EPcdRgGaZ22M6Gd85JCs=;
 b=KJvjO9GaVzzJGj+c38F2PMC34mBoll1ySgt2Wmk0OhYJxWpm8OPJqrlT
 p2V8GCbw3odwqnqT74ITyukttgZlecqWT3McmLPK13A9EK6J8A9JF2/so
 56ZJ4Ta9TqmIH9YzvQatjg/Z8mxN1lcCxm00aJl0p5J9Ltz3AWiVZkVAf
 D2nBYvic+oCOsZnBRElX9sgfmJ5SizId49IWysEY7gKM5Xh4DcLKnTUeF
 y2V/s8qm0ph5ZlQUaIVggzk1XG/Fg+vp7Z8/17cr1IoJ+pO3tUmGNZaeC
 iDYBYub19dnNOGdwefN4Oj3mf0VUUBQn2mGtTf+N039UIgdFHuLiJWn25 w==;
X-CSE-ConnectionGUID: z1C1Bj+gQgu3rxbswXnFlg==
X-CSE-MsgGUID: 4sTsZudqSUuJFm7r9TRwzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1364536"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1364536"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 18:16:19 -0700
X-CSE-ConnectionGUID: LF8HAmj9RmWtddZQRQUnRw==
X-CSE-MsgGUID: egNf9dY4TySHZ0i+X4YBwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2944963"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa004.jf.intel.com with ESMTP; 20 Oct 2026 18:16:17 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xJKwA-00000000Om8-2wAR;
 Wed, 21 Oct 2026 01:16:14 +0000
Date: Wed, 21 Oct 2026 09:15:33 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:100GbE] BUILD SUCCESS
 445b80425f1e5dd0cab367dc302ff79f774f455d
Message-ID: <202610210931.Ank78Qyc-lkp@intel.com>
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 445b80425f1e5dd0cab367dc302ff79f774f455d  ice: don't clear in_use until HW clears ready bitmap

elapsed time: 1331m

configs tested: 172
configs skipped: 5

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
arc                   randconfig-1000-20261020    gcc-10.5.0
arc                   randconfig-1001-20261020    gcc-10.5.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                   randconfig-1000-20261020    gcc-10.5.0
arm                   randconfig-1001-20261020    gcc-10.5.0
arm                   randconfig-1002-20261020    gcc-10.5.0
arm                   randconfig-1003-20261020    gcc-10.5.0
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261020    gcc-8.5.0
arm64                 randconfig-1001-20261020    gcc-8.5.0
arm64                 randconfig-1002-20261020    gcc-8.5.0
arm64                 randconfig-1003-20261020    gcc-8.5.0
csky                              alldefconfig    gcc-16.2.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261020    gcc-8.5.0
csky                  randconfig-1001-20261020    gcc-8.5.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261020    clang-17
hexagon               randconfig-1001-20261020    clang-17
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261020    clang-22
i386        buildonly-randconfig-1001-20261020    clang-22
i386        buildonly-randconfig-1002-20261020    clang-22
i386        buildonly-randconfig-1003-20261020    clang-22
i386        buildonly-randconfig-1004-20261020    clang-22
i386        buildonly-randconfig-1005-20261020    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261020    gcc-14
i386                  randconfig-1001-20261020    gcc-14
i386                  randconfig-1002-20261020    gcc-14
i386                  randconfig-1003-20261020    gcc-14
i386                  randconfig-1004-20261020    gcc-14
i386                  randconfig-1005-20261020    gcc-14
i386                  randconfig-1006-20261020    gcc-14
i386                  randconfig-1007-20261020    gcc-14
i386                  randconfig-1008-20261020    gcc-14
i386                  randconfig-1009-20261020    gcc-14
i386                  randconfig-1010-20261020    gcc-14
i386                  randconfig-1011-20261020    gcc-14
i386                  randconfig-1012-20261020    gcc-14
i386                  randconfig-1013-20261020    gcc-14
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261020    clang-17
loongarch             randconfig-1001-20261020    clang-17
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
mips                 malta_qemu_32r6_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261020    clang-17
nios2                 randconfig-1001-20261020    clang-17
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261020    clang-17
parisc                randconfig-1001-20261020    clang-17
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       arches_defconfig    gcc-16.2.0
powerpc                      mpc83xx_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261020    clang-17
powerpc               randconfig-1001-20261020    clang-17
powerpc64             randconfig-1000-20261020    clang-17
powerpc64             randconfig-1001-20261020    clang-17
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261020    gcc-11.5.0
riscv                 randconfig-1001-20261020    gcc-11.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261020    gcc-11.5.0
s390                  randconfig-1001-20261020    gcc-11.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          ap325rxa_defconfig    gcc-16.2.0
sh                                   defconfig    gcc-14
sh                          ecovec24_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261020    gcc-11.5.0
sh                    randconfig-1001-20261020    gcc-11.5.0
sh                           sdk7780_defconfig    gcc-16.2.0
sh                    secureedge5410_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261020    clang-20
sparc                 randconfig-1001-20261020    clang-20
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261020    clang-20
sparc64               randconfig-1001-20261020    clang-20
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261020    clang-20
um                    randconfig-1001-20261020    clang-20
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261020    gcc-14
x86_64      buildonly-randconfig-1001-20261020    gcc-14
x86_64      buildonly-randconfig-1002-20261020    gcc-14
x86_64      buildonly-randconfig-1003-20261020    gcc-14
x86_64      buildonly-randconfig-1004-20261020    gcc-14
x86_64      buildonly-randconfig-1005-20261020    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261020    clang-22
x86_64                randconfig-1001-20261020    clang-22
x86_64                randconfig-1002-20261020    clang-22
x86_64                randconfig-1003-20261020    clang-22
x86_64                randconfig-1004-20261020    clang-22
x86_64                randconfig-1005-20261020    clang-22
x86_64                randconfig-1006-20261020    gcc-14
x86_64                randconfig-1007-20261020    gcc-14
x86_64                randconfig-1008-20261020    gcc-14
x86_64                randconfig-1009-20261020    gcc-14
x86_64                randconfig-1010-20261020    gcc-14
x86_64                randconfig-1011-20261020    gcc-14
x86_64                randconfig-1012-20261020    clang-22
x86_64                randconfig-1013-20261020    clang-22
x86_64                randconfig-1014-20261020    clang-22
x86_64                randconfig-1015-20261020    clang-22
x86_64                randconfig-1016-20261020    clang-22
x86_64                randconfig-1017-20261020    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261020    clang-20
xtensa                randconfig-1001-20261020    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
