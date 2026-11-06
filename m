Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9641A606A326
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=MqoJdYRb;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mBSmz5oV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72D474096A;
	Fri,  6 Nov 2026 12:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id arLANP82ObRP; Fri,  6 Nov 2026 12:26:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2FB7F4096E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793967995;
	b=Y+gcr4sSbBVJQzU3byC9Lnn4AhNfhVv/2+YLMq1mTUDSJuDlmaHdaZisuuBZptd2cbmS
	 Jdh4monQujGPAo4ZbmD99pT+p2HkH9l+TiMTsTE4yJ/bVacbh9vH4Yl4iXzP5PKq9m41o
	 rgBNx/NKjAeiMajEmCL5mM3Vej0bpIJETv19m7AhyzySLqR4a0xIPBbdpaHrt15AQv3cy
	 Oi+nvm9hTmmhUtY7+TJ+YUv9QlayFRZyd320liuO2MgWyBpCkQkLB7RhIElNlF34UMFa9
	 Dj2Zu/7sQcO1Kc+iwTrMrAuPES71YTpHkPnD0ZjDJfPeathQ7tg/n70PwReUOPmIuGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793967995;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fpGRItHVQGPyNxC0HGjHy2FqoMkRrCLW2Me/SSVZte8=;
	b=BhGaS1zQJviI6yRJlMmkXATpsaeRu1aSgleXTJqmML2ZmKN+0mOK2f6WWg+R67lCcq2T
	 /IoYdUXcX2JHdeEbFec4aAy8dqU8XWnWHrT7CP8clWQ+m/TqbLJmE5QyARTEn71L6lE/U
	 0MF1P/2UpypO/Nyofxd24oZc9CDWtBRc67mhd4VWMyVRC9eCYyYo5QEWLy1wP1xr2yMPK
	 FMKfLAP22AExIvYP2T0yk28h0vO0miAn0TgZtVTB4AHRYy2MFIzb627kGIAHUA24YibTS
	 1icZHR7zOUcIFFemJhBrqlIkaJr01AZuzAfwIkKHiqjHZQ1J8ryk+kvZZbrVSLw0Sng==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793967995;
	bh=fpGRItHVQGPyNxC0HGjHy2FqoMkRrCLW2Me/SSVZte8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MqoJdYRbeRaeK9+jKdmramf3KV+hqmu1/UBSMnWws48120M0a0G+xW1G9ScpZPvZf
	 AGkgR4NJMEZmDn3vdg9bDx18Rp7JesLEz38F4dPLjKoMFZ6PY/7Nd9MkwaQ7X/+VsG
	 trGockPQKLmJC0SIVAGJaUVLeMIfq9vyxdTEs+OwHVnqOgyXAqU3VFVRXOLcf9P8TG
	 Aj8NPrirWG4SMM2P7rjjLu9awZxw6yDKJ/xO/qvBFNhWPnBuCtW2ut5mXiOBYoYiyN
	 GiO0K9iTE5DjXQYOzRYjKcdvCp0MOpQTuJ/5BVtovedrUJKX0LGXwj6weaqG/WUuH5
	 x5v4ROaDfZZyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FB7F4096E;
	Fri,  6 Nov 2026 12:26:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 798DF362
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B072403CB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:26:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TVgoxGd7Ze5M for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 12:26:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 052B5403BE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mBSmz5oV
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 052B5403BE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793967992; x=1825503992; h=date:from:to:subject:message-id;
 bh=uV57U/wPU683sRLs6uJzLa+SqI9p9aERGWmMYhCWmPE=;
 b=mBSmz5oVBDdXj6Fqe8X0SWW3FeXmSnN3K36zkhszRR4ZshjEfnffIpHT
 o6Qwy7esTjv/5HzgtYgcG/PAhKl/Y5hRgDd3AhAVXs44gXiALLFZEvbeU
 tLfJZMtGxmueiGCCFGqJGgOjUWYXVgS1mxLgvKAYIkXHvqsq8ZNdnVqFy
 zvBntUKmE07/KauiMT0I9U5UXxZKJgjRIKxAk5uAKTmpulOq1vha6L1LA
 pzDsrtDD8q+WIjTSCUtvl+aqlUC27tEckpkxjuc8Kui3HI0/bfSmOnUS7
 00IWQNuHJI2VeU/eMsXn3e5Bzve42O99iZZ3Zo9IM7GfOftyt7ku4BN+K w==;
X-CSE-ConnectionGUID: aJBf3F3RRzC4pEfSM9Cc0A==
X-CSE-MsgGUID: paVIsdBjRaOSZbLeUiAfmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2678138"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2678138"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 04:26:30 -0800
X-CSE-ConnectionGUID: PKwiquXERtqghhe0VRfKrg==
X-CSE-MsgGUID: Gg2ryfW8RceujhBW7LgATg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7380366"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa009.jf.intel.com with ESMTP; 06 Nov 2026 04:26:28 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xPJ1W-00000000pF0-25xM;
 Fri, 06 Nov 2026 12:26:26 +0000
Date: Fri, 06 Nov 2026 20:25:30 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:100GbE] BUILD SUCCESS
 0822d2fe38262e8b55c5ea55c970022bca8dd2a9
Message-ID: <20261106202530.QX1mrA8Z-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: 0822d2fe38262e8b55c5ea55c970022bca8dd2a9  dpaa2-switch: fix port cleanup on probe errors

elapsed time: 1329m

configs tested: 337
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2200-20261105    gcc-9.5.0  smatch
alpha                randconfig-r2101-20261105    gcc-8.5.0  cocci
alpha                randconfig-r2104-20261105    gcc-8.5.0  cocci
alpha                randconfig-r2308-20261105    gcc-10.5.0 sparse
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-19
arc                               allyesconfig    clang-24
arc                           axs103_defconfig    clang-19
arc                                  defconfig    gcc-16.2.0
arc                         nsim_700_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261106    gcc-8.5.0
arc                   randconfig-1001-20261106    gcc-8.5.0
arc                   randconfig-2000-20261105    gcc-8.5.0
arc                   randconfig-2001-20261105    gcc-8.5.0
arc                   randconfig-2002-20261105    gcc-8.5.0
arc                   randconfig-2003-20261105    gcc-8.5.0
arc                   randconfig-2004-20261105    gcc-8.5.0
arc                   randconfig-2005-20261105    gcc-8.5.0
arc                   randconfig-2200-20261105    gcc-8.5.0  smatch
arc                  randconfig-r2107-20261105    gcc-11.5.0 cocci
arc                         vdk_hs38_defconfig    clang-17
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                         clps711x_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                       integrator_defconfig    gcc-16.2.0
arm                          lpc32xx_defconfig    clang-17
arm                             mps2_defconfig    clang-24
arm                   randconfig-1000-20261106    gcc-8.5.0
arm                   randconfig-1001-20261106    gcc-8.5.0
arm                   randconfig-1002-20261106    gcc-8.5.0
arm                   randconfig-1003-20261106    gcc-8.5.0
arm                   randconfig-2200-20261105    gcc-15.3.0 smatch
arm                  randconfig-r2309-20261105    gcc-10.5.0 sparse
arm                              rpc_defconfig    gcc-16.2.0
arm                          s3c6400_defconfig    gcc-16.2.0
arm                            sunxi_defconfig    clang-17
arm                            sunxi_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261106    clang-17
arm64                 randconfig-1001-20261106    clang-17
arm64                 randconfig-1002-20261106    clang-17
arm64                 randconfig-1003-20261106    clang-17
arm64                 randconfig-2200-20261105    clang-20   smatch
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261106    clang-17
csky                  randconfig-1001-20261106    clang-17
csky                  randconfig-2000-20261105    clang-24
csky                  randconfig-2001-20261105    clang-24
csky                  randconfig-2200-20261105    gcc-9.5.0  smatch
csky                 randconfig-r2308-20261105    clang-24   sparse
csky                 randconfig-r2311-20261105    gcc-10.5.0 sparse
hexagon                           alldefconfig    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261106    gcc-14.4.0
hexagon               randconfig-1001-20261106    gcc-14.4.0
hexagon               randconfig-2000-20261105    clang-24
hexagon               randconfig-2001-20261105    clang-24
hexagon               randconfig-2200-20261105    clang-17   smatch
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
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
i386                  randconfig-1009-20261106    gcc-14
i386                  randconfig-1010-20261106    gcc-14
i386                  randconfig-1011-20261106    gcc-14
i386                  randconfig-1012-20261106    gcc-14
i386                  randconfig-1013-20261106    gcc-14
i386                  randconfig-2100-20261105    gcc-14     cocci
i386                  randconfig-2101-20261105    gcc-14     cocci
i386                  randconfig-2102-20261105    gcc-14     cocci
i386                  randconfig-2103-20261105    gcc-14     cocci
i386                  randconfig-2104-20261105    gcc-14     cocci
i386                  randconfig-2105-20261105    gcc-14     cocci
i386                  randconfig-2200-20261105    clang-22   smatch
loongarch                         allmodconfig    clang-19
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261106    gcc-14.4.0
loongarch             randconfig-1001-20261106    gcc-14.4.0
loongarch             randconfig-2000-20261105    gcc-16.2.0
loongarch             randconfig-2001-20261105    gcc-16.2.0
loongarch             randconfig-2200-20261105    gcc-16.2.0 smatch
loongarch            randconfig-r2109-20261105    gcc-11.5.0 cocci
loongarch            randconfig-r2306-20261105    clang-24   sparse
loongarch            randconfig-r2307-20261105    gcc-10.5.0 sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                           atari_defconfig    clang-17
m68k                                 defconfig    clang-24
m68k                        m5329evb_defconfig    clang-24
m68k                       m54418evb_defconfig    clang-19
m68k                          nettel_defconfig    gcc-16.2.0
m68k                  randconfig-2200-20261105    gcc-8.5.0  smatch
m68k                 randconfig-r2310-20261105    gcc-10.5.0 sparse
m68k                 randconfig-r2311-20261105    clang-24   sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2200-20261105    gcc-9.5.0  smatch
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                   cavium_octeon_defconfig    gcc-16.2.0
mips                          db1xxx_defconfig    gcc-16.2.0
mips                           eyeq5_defconfig    clang-17
mips                            ip28_defconfig    gcc-16.2.0
mips                       loongson3_defconfig    gcc-16.2.0
mips                 malta_qemu_32r6_defconfig    clang-17
mips                     maltaup_xpa_defconfig    clang-19
mips                  randconfig-2000-20261105    gcc-9.5.0
mips                  randconfig-2001-20261105    gcc-9.5.0
mips                  randconfig-2002-20261105    gcc-9.5.0
mips                  randconfig-2200-20261105    gcc-11.5.0 smatch
mips                 randconfig-r2111-20261105    gcc-11.5.0 cocci
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261106    gcc-14.4.0
nios2                 randconfig-1001-20261106    gcc-14.4.0
nios2                 randconfig-2000-20261105    gcc-16.2.0
nios2                 randconfig-2001-20261105    gcc-16.2.0
nios2                 randconfig-2200-20261105    gcc-9.5.0  smatch
nios2                randconfig-r2102-20261105    gcc-8.5.0  cocci
nios2                randconfig-r2108-20261105    gcc-11.5.0 cocci
nios2                randconfig-r2110-20261105    gcc-11.5.0 cocci
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                    de0_nano_defconfig    clang-19
openrisc                             defconfig    gcc-16.2.0
openrisc                   or1klitex_defconfig    clang-24
openrisc                   or1klitex_defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261105    gcc-9.5.0
openrisc              randconfig-2001-20261105    gcc-9.5.0
openrisc              randconfig-2002-20261105    gcc-9.5.0
openrisc              randconfig-2200-20261105    gcc-16.2.0 smatch
openrisc                  simple_smp_defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261106    clang-19
parisc                randconfig-1001-20261106    clang-19
parisc                randconfig-2000-20261105    gcc-16.2.0
parisc                randconfig-2001-20261105    gcc-16.2.0
parisc                randconfig-2200-20261105    gcc-15.3.0 smatch
parisc               randconfig-r2105-20261105    gcc-8.5.0  cocci
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      ep8248e_defconfig    clang-17
powerpc                      ep8248e_defconfig    clang-24
powerpc                       ep88xc_defconfig    clang-17
powerpc                     gamecube_defconfig    clang-19
powerpc                      kmeter1_defconfig    gcc-16.2.0
powerpc                       mgcoge_defconfig    clang-17
powerpc                      mpc512x_defconfig    gcc-16.2.0
powerpc                   mpc866_ads_defconfig    clang-17
powerpc                   mpc885_ads_defconfig    clang-19
powerpc                       pcm030_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261106    clang-19
powerpc               randconfig-1001-20261106    clang-19
powerpc               randconfig-2000-20261105    clang-18
powerpc               randconfig-2001-20261105    clang-18
powerpc               randconfig-2002-20261105    clang-18
powerpc               randconfig-2200-20261105    clang-17   smatch
powerpc                      redwood_defconfig    gcc-16.2.0
powerpc                     sam440ep_defconfig    gcc-16.2.0
powerpc                      tqm8555_defconfig    clang-19
powerpc                  xes_mpc85xx_defconfig    clang-17
powerpc64             randconfig-1000-20261106    clang-19
powerpc64             randconfig-1001-20261106    clang-19
powerpc64             randconfig-2000-20261105    clang-18
powerpc64             randconfig-2001-20261105    clang-18
powerpc64             randconfig-2002-20261105    clang-18
powerpc64             randconfig-2200-20261105    clang-24   smatch
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv              nommu_k210_sdcard_defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261106    gcc-14.4.0
riscv                 randconfig-1001-20261106    gcc-14.4.0
riscv                 randconfig-2200-20261105    clang-24   smatch
riscv                randconfig-r2103-20261105    gcc-8.5.0  cocci
s390                              alldefconfig    clang-17
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261106    gcc-14.4.0
s390                  randconfig-1001-20261106    gcc-14.4.0
s390                  randconfig-2000-20261105    clang-24
s390                  randconfig-2001-20261105    clang-24
s390                  randconfig-2002-20261105    clang-24
s390                  randconfig-2003-20261105    clang-24
s390                  randconfig-2004-20261105    clang-24
s390                  randconfig-2005-20261105    clang-24
s390                  randconfig-2200-20261105    clang-24   smatch
s390                 randconfig-r2306-20261105    gcc-10.5.0 sparse
s390                 randconfig-r2307-20261105    clang-24   sparse
s390                 randconfig-r2309-20261105    clang-24   sparse
s390                 randconfig-r2310-20261105    clang-24   sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                              espt_defconfig    gcc-16.2.0
sh                  kfr2r09-romimage_defconfig    clang-17
sh                             migor_defconfig    clang-24
sh                           polaris_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261106    gcc-14.4.0
sh                    randconfig-1001-20261106    gcc-14.4.0
sh                    randconfig-2200-20261105    gcc-13.5.0 smatch
sh                           rsk7201_defconfig    clang-17
sh                         sh7757lcr_defconfig    gcc-16.2.0
sh                              shx3_defconfig    clang-17
sh                              shx3_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261106    gcc-15.3.0
sparc                 randconfig-1001-20261106    gcc-15.3.0
sparc                 randconfig-2000-20261105    clang-24
sparc                 randconfig-2001-20261105    clang-24
sparc                 randconfig-2200-20261105    gcc-16.2.0 smatch
sparc                randconfig-r2106-20261105    gcc-11.5.0 cocci
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261106    gcc-15.3.0
sparc64               randconfig-1001-20261106    gcc-15.3.0
sparc64               randconfig-2000-20261105    clang-24
sparc64               randconfig-2001-20261105    clang-24
sparc64               randconfig-2200-20261105    gcc-8.5.0  smatch
sparc64              randconfig-r2100-20261105    gcc-8.5.0  cocci
um                                alldefconfig    gcc-16.2.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261106    gcc-15.3.0
um                    randconfig-1001-20261106    gcc-15.3.0
um                    randconfig-2000-20261105    clang-24
um                    randconfig-2001-20261105    clang-24
um                    randconfig-2200-20261105    clang-19   smatch
um                            x86_64_defconfig    gcc-14
x86_64                            alldefconfig    clang-19
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
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
x86_64                randconfig-1006-20261106    clang-22
x86_64                randconfig-1007-20261106    clang-22
x86_64                randconfig-1008-20261106    clang-22
x86_64                randconfig-1009-20261106    clang-22
x86_64                randconfig-1010-20261106    clang-22
x86_64                randconfig-1011-20261106    clang-22
x86_64                randconfig-1012-20261106    gcc-14
x86_64                randconfig-1013-20261106    gcc-14
x86_64                randconfig-1014-20261106    gcc-14
x86_64                randconfig-1015-20261106    gcc-14
x86_64                randconfig-1016-20261106    gcc-14
x86_64                randconfig-1017-20261106    gcc-14
x86_64                randconfig-2000-20261105    gcc-14
x86_64                randconfig-2001-20261105    gcc-14
x86_64                randconfig-2002-20261105    gcc-14
x86_64                randconfig-2003-20261105    gcc-14
x86_64                randconfig-2004-20261105    gcc-14
x86_64                randconfig-2005-20261105    gcc-14
x86_64                randconfig-2100-20261105    gcc-14     cocci
x86_64                randconfig-2101-20261105    gcc-14     cocci
x86_64                randconfig-2102-20261105    gcc-14     cocci
x86_64                randconfig-2103-20261105    gcc-14     cocci
x86_64                randconfig-2104-20261105    gcc-14     cocci
x86_64                randconfig-2105-20261105    gcc-14     cocci
x86_64                randconfig-2200-20261105    clang-22   smatch
x86_64                                rhel-9.4    clang-22
x86_64                                rhel-9.4    gcc-14
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                           rhel-9.4-func    gcc-14
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                     rhel-9.4-kselftests    gcc-14
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   nommu_kc705_defconfig    clang-24
xtensa                randconfig-1000-20261106    gcc-15.3.0
xtensa                randconfig-1001-20261106    gcc-15.3.0
xtensa                randconfig-2000-20261105    clang-24
xtensa                randconfig-2001-20261105    clang-24
xtensa                randconfig-2200-20261105    gcc-8.5.0  smatch
xtensa                     xip_kc705_defconfig    clang-17

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
