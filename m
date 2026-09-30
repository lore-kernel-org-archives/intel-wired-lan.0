Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8284FCA5FC4
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 18:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F3D680EDB;
	Wed, 30 Sep 2026 18:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pw_-rL8YtFX2; Wed, 30 Sep 2026 18:02:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E2A3380EE0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790791372;
	b=s5GeoH9s4Anb4BxP2a0oUQnoCAtDqwc+C9Esw3ZJoCGSLHDDxqZxzVV2R0MWXzz5Qt66
	 IN/clGG39O0vdva8rQ1BF8iKndyWT7/946YDK4bFd8KBlUarRUOzkcxzBEqPDexP6hfUU
	 yR1eVOx5LcClopOqtCkih+ojYQ/1PSJVD96Wpukw3VKCv2AcKKJzMepeFGCYU4MpDu47S
	 lj7/VksezEpaneqynVNHyQnmb00IRY+f6aMAtu8lEQnS3VWw6/X3dHsevKJZ74r+qmg9u
	 9EH8sHSqZV70qMWH8LyCxjp53toaPyY3y6Eu0arekeCptx+n60xrgnST6ebX3s98EZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790791372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Date:From:To:Subject:Message-ID:User-Agent:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zGt+zq0BosjZcazgRliP1v82TZwj8xDGB7XK6TYk2QE=;
	b=RmXLZFjOqd2hQmwGa9HGDH6PryOnT7PX4Pdc2bmeh4jKt/NyrqPol4dtPoz1EcFl6u9g
	 /uXcJWBY+38BYOHChoT3aP52gOgqsgHdGa9g4LiQwdXxizK5dhMku8uqa+QuT9KzgsgJR
	 7HTv7E2iSwE170VWg278IC/GNhLZ7Z0r970upO2dfeIr+9gjFP0ePH43H0q3CdJu1t34r
	 L/HAaJ5I+ucoPHQ/SM/jFQZB9QoQrgYIuJRYGAoP6TKjT/mIK6sxUdpXeMInWC/Xzgckr
	 o7WPm5h9mBrbCtEwHMj1KEB3K+QLNGg/9vuWnTwA5qRE21fiF8kNzN2lEzwLTWlVaLw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790791371;
	bh=zGt+zq0BosjZcazgRliP1v82TZwj8xDGB7XK6TYk2QE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q9tvO2ZMWXK7AO00Lcr5R/iylQ2vNud9rTYnOTISOF1CJlYplE3cSYrHDdT4SiVv4
	 C/L+9q9ILkpGoecQ7lUyUdfp0cBklYq05c3xTUNjws6hS4ubKQyMTCbSMK7LRL8edE
	 DSeIl93ZUEJ/CwXzBMf9p40QrQVjeteCMoLGUBEyVNb3iIPdxXLKnJc2Do6moIce6a
	 Hwc80M3iNa0nuzmJ71fScBEHx8Q5Qe01g/BdYNZN/psL6BikCsNkU3eDMdfYwnYtbP
	 jeuyy9+jDCnuwknluu/7ERT8xxRCD7kobIrPzhAq+DP25lHcngoRnCFBILExJWXqQY
	 HAwMIU61ti4Tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2A3380EE0;
	Wed, 30 Sep 2026 18:02:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C0134CD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 18:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09D786070F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 18:02:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UosfZYH-iVL1 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 18:02:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A8C9160845
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790791367;
 b=FANmdSLhTnd9XzyGr21xmQNricQaH1EZgWIvIP7OvrGf0x3Pihoh5iunwSJRbJy+2oaP
 JD3UQU8eY3akdegHoC5l6lFsPYFowoikIR6nZNtxRch30l2OTKqeJ6WZJcBnuIT+/wEQT
 j8zqQ5jfbtDmeqfONBqDY6cCVfw8jJ4qVJI5CDkM4ULxQzmw0hW5I/JTfFH0Toihe+UVh
 lnW/6q6Dia8DULC10hRDaws4VqNgruQLyHfJLNn6fn73lzICKb3yF8cJsoc0prV48EiTk
 hJsrXBbHNEH58m1GtMiMgSwSkHEwzkzLYZIDL/fud/mWI3Jp1N+g1pB8Yb0qOqloPVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790791367;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Date:From:To:Subject:
 Message-ID:User-Agent;
 bh=zGt+zq0BosjZcazgRliP1v82TZwj8xDGB7XK6TYk2QE=;
 b=QnsAxj6fa7mFVFFTLVID+ern8RLJtmK9Bsa1c0w30DLOd7IBf5BKwZ/lQqeYrfofkg5L
 JRawmru6DngMfZAghBu8LHcLlct/svOMdBTQN+pAxH8ul5FaydcHUW7YKh0HjGf/3oUjo
 DRT9fYkK+Y2zKiB1ymkFD/AwNnXec/QbuffuMwTYucgTLtN5DGz6Vz1myo6QCS3fZr1jr
 atvgrGLxGLYQcwnIYpNlFhG/OQ2ZRNY3tz4+ojwAvW7dD9G5GKSf43CW4iGcnU+3dfSrv
 OgH9Goswshr65cy2QJxTDqOgn1igSflUKhr8bF2gv2UZSHyeigMDDaStw0Nuxqjdnaw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HUKcWZsM; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HUKcWZsM
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8C9160845
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 18:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790791367; x=1822327367; h=date:from:to:subject:message-id;
 bh=5cXNhpW1lntp3CyZMPrQEUWKMeQO60UlmGJCvrfsDI8=;
 b=HUKcWZsM84s7Od1ocMt7Bq1hnSuh6bXnPhZYuansgd1MmGYGdF230g07
 U5sBrtCg67zZv23YR8rzjpz0HPmB8kIY8gmz8JJrO56P7xP7cUeAJ2dO8
 Zc0SlVB9tuEJWoOeQ0T/njDw5W5t4mAoStR5mOZ8gHTB7YBHocrRtU0iT
 lAEMybYrB1ZmtH5EXr61IMhDxzCJ8ANKrTff66d+u3ik9W+ayeWNozwbI
 0S2Bj/UTtFmy96mdUHv2hGuld0/AQdrTj6hM9Gq9g1LqSNKw6sxzW/5Sw
 AOPxPusRYutock8/tTN44N6wfNUWUtRsg+xVUNqwaDciotx2vhEZvTUmn A==;
X-CSE-ConnectionGUID: eYPqTjogRQufx7qemeHB+w==
X-CSE-MsgGUID: FC687ioiSiaE8O2D76t0RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="117064980"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; d="scan'208";a="117064980"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 11:02:04 -0700
X-CSE-ConnectionGUID: 1ilmxJh/SZauw2HrN1yhuA==
X-CSE-MsgGUID: iTj3MexLTeSu7dx43vW4mA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 30 Sep 2026 11:02:03 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xBycy-00000000Qz4-3ogM;
 Wed, 30 Sep 2026 18:02:00 +0000
Date: Thu, 01 Oct 2026 02:01:48 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:100GbE] BUILD SUCCESS
 ce0e3e4b98c2f80221965ba16c583bd886828823
Message-ID: <202610010245.JaqJLVYC-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: ce0e3e4b98c2f80221965ba16c583bd886828823  ice: simplify ice_vc_dis_qs_msg() a little

elapsed time: 1101m

configs tested: 296
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2300-20260930    gcc-8.5.0  sparse
alpha                randconfig-r2307-20260930    gcc-10.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260930    gcc-11.5.0
arc                   randconfig-1001-20260930    gcc-11.5.0
arc                  randconfig-r2104-20260930    gcc-12     cocci
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
arm                  randconfig-r2201-20260930    clang-24   smatch
arm                  randconfig-r2306-20260930    gcc-8.5.0  sparse
arm                        spear13xx_defconfig    gcc-16.1.0
arm                         spear6xx_defconfig    gcc-16.1.0
arm                            spitz_defconfig    gcc-16.1.0
arm                        versatile_defconfig    gcc-16.1.0
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
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260930    gcc-16.1.0
csky                  randconfig-1001-20260930    gcc-16.1.0
csky                 randconfig-r2104-20260930    clang-24   cocci
csky                 randconfig-r2200-20260930    gcc-14.3.0 smatch
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260930    clang-24
hexagon               randconfig-1001-20260930    clang-24
hexagon              randconfig-r2106-20260930    clang-24   cocci
hexagon              randconfig-r2304-20260930    gcc-8.5.0  sparse
i386                              alldefconfig    gcc-16.1.0
i386                               allnoconfig    gcc-16.1.0
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
i386                  randconfig-2300-20260930    gcc-14     sparse
i386                  randconfig-2301-20260930    clang-22   sparse
i386                  randconfig-2301-20260930    gcc-13     sparse
i386                  randconfig-2302-20260930    gcc-13     sparse
i386                  randconfig-2302-20260930    gcc-14     sparse
i386                 randconfig-r2100-20260930    clang-17   cocci
i386                 randconfig-r2105-20260930    gcc-12     cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260930    clang-24
loongarch             randconfig-1001-20260930    clang-24
loongarch            randconfig-r2102-20260930    gcc-9.5.0  cocci
loongarch            randconfig-r2202-20260930    clang-22   smatch
loongarch            randconfig-r2303-20260930    gcc-8.5.0  sparse
loongarch            randconfig-r2308-20260930    clang-24   sparse
loongarch            randconfig-r2308-20260930    gcc-10.5.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                           atari_defconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5475evb_defconfig    gcc-16.1.0
m68k                 randconfig-r2202-20260930    gcc-15.2.0 smatch
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
mips                         qi_lb60_defconfig    clang-24
mips                         qi_lb60_defconfig    gcc-16.1.0
mips                 randconfig-r2102-20260930    clang-17   cocci
mips                 randconfig-r2103-20260930    clang-17   cocci
mips                 randconfig-r2309-20260930    gcc-10.5.0 sparse
nios2                          10m50_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260930    clang-24
nios2                 randconfig-1001-20260930    clang-24
nios2                randconfig-r2106-20260930    gcc-12     cocci
nios2                randconfig-r2201-20260930    gcc-11.5.0 smatch
nios2                randconfig-r2307-20260930    gcc-11.5.0 sparse
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
parisc               randconfig-r2300-20260930    gcc-8.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                  canyonlands_defconfig    gcc-16.1.0
powerpc                        eiger_defconfig    gcc-16.1.0
powerpc                       mgcoge_defconfig    gcc-16.1.0
powerpc                      mpc83xx_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260930    gcc-8.5.0
powerpc               randconfig-1001-20260930    gcc-8.5.0
powerpc              randconfig-r2101-20260930    clang-17   cocci
powerpc              randconfig-r2200-20260930    clang-22   smatch
powerpc              randconfig-r2305-20260930    gcc-8.5.0  sparse
powerpc              randconfig-r2306-20260930    gcc-10.5.0 sparse
powerpc                      sequoia_defconfig    gcc-16.1.0
powerpc                      tqm8548_defconfig    gcc-16.1.0
powerpc                       tqm8xx_defconfig    gcc-16.1.0
powerpc64                         alldefconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260930    gcc-8.5.0
powerpc64             randconfig-1001-20260930    gcc-8.5.0
powerpc64            randconfig-r2304-20260930    gcc-8.5.0  sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                     nommu_k210_defconfig    clang-24
riscv                     nommu_k210_defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260930    gcc-16.1.0
riscv                 randconfig-1001-20260930    gcc-16.1.0
riscv                 randconfig-2000-20260930    gcc-14.3.0
riscv                 randconfig-2000-20260930    gcc-15.2.0
riscv                 randconfig-2001-20260930    gcc-14.3.0
riscv                 randconfig-2001-20260930    gcc-8.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260930    gcc-16.1.0
s390                  randconfig-1001-20260930    gcc-16.1.0
s390                  randconfig-2000-20260930    clang-24
s390                  randconfig-2000-20260930    gcc-14.3.0
s390                  randconfig-2001-20260930    gcc-14.3.0
s390                  randconfig-2001-20260930    gcc-8.5.0
s390                 randconfig-r2105-20260930    clang-24   cocci
s390                 randconfig-r2107-20260930    clang-24   cocci
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    gcc-16.1.0
sh                         edosk7760_defconfig    clang-24
sh                              espt_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260930    gcc-16.1.0
sh                    randconfig-1001-20260930    gcc-16.1.0
sh                    randconfig-2000-20260930    gcc-14.3.0
sh                    randconfig-2001-20260930    gcc-12.5.0
sh                    randconfig-2001-20260930    gcc-14.3.0
sh                           sdk7780_defconfig    gcc-16.1.0
sh                           urquell_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260930    clang-22
sparc                 randconfig-1001-20260930    clang-22
sparc                 randconfig-2000-20260930    gcc-10.5.0
sparc                 randconfig-2000-20260930    gcc-14.3.0
sparc                 randconfig-2001-20260930    gcc-10.5.0
sparc                 randconfig-2001-20260930    gcc-8.5.0
sparc                randconfig-r2301-20260930    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260930    clang-22
sparc64               randconfig-1001-20260930    clang-22
sparc64               randconfig-2000-20260930    gcc-10.5.0
sparc64               randconfig-2000-20260930    gcc-8.5.0
sparc64               randconfig-2001-20260930    gcc-10.5.0
sparc64               randconfig-2001-20260930    gcc-9.5.0
sparc64              randconfig-r2309-20260930    clang-24   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260930    clang-22
um                    randconfig-1001-20260930    clang-22
um                    randconfig-2000-20260930    clang-24
um                    randconfig-2000-20260930    gcc-10.5.0
um                    randconfig-2001-20260930    clang-24
um                    randconfig-2001-20260930    gcc-10.5.0
um                   randconfig-r2200-20260930    clang-24   smatch
um                   randconfig-r2302-20260930    gcc-8.5.0  sparse
um                   randconfig-r2303-20260930    gcc-8.5.0  sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-24
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
x86_64                randconfig-2300-20260930    clang-22   sparse
x86_64                randconfig-2300-20260930    gcc-13     sparse
x86_64                randconfig-2301-20260930    gcc-13     sparse
x86_64                randconfig-2301-20260930    gcc-14     sparse
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
xtensa                randconfig-2000-20260930    gcc-12.5.0
xtensa                randconfig-2001-20260930    gcc-10.5.0
xtensa               randconfig-r2100-20260930    gcc-9.5.0  cocci
xtensa               randconfig-r2101-20260930    gcc-9.5.0  cocci
xtensa               randconfig-r2201-20260930    gcc-10.5.0 smatch

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
