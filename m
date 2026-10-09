Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F192CA6019
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 12:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A35A60680;
	Fri,  9 Oct 2026 12:52:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s5tK4EPnEsBK; Fri,  9 Oct 2026 12:52:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DA35460685
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791550350;
	b=ft81ieBXD5w9zHngBEsoNMW7qCxKUQ88L7ARMyF/yfYqR5fJlUExYC4aA160FjdYuLA0
	 sCjUfyXUiULTTNbrNZsXyf6XeainxuHu1NE1GLrFdj0CHJsa/O3ko1ZNCarppssap93t0
	 /vQogxgu/bUxlKP7dptCMa/I8CnJ8+BGmo+8TfMhEFVsecuD1xeB0Z03lAerA1NRLhx/V
	 Ho2HcBsEb/I2CSwfFRXlOTSyf03jYhxusNDw3+7Eqn/kljteIx/Bxnh1pB/cD+f7kzCZ8
	 20j8bxgl+Hng79tOmpwOYp9U51JtC1rwyEAxc/2FtftuvgIZDdHecGLlIE0XulcLGpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791550350;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5rd9ekWtsLE+/DY1OHM5Q4k4D1KquthD4XmUGtGTqTE=;
	b=NP7uOOEbllsHKMCl4VpGxBsgd+Nnw2ZMQ73tuK731j+nWnfojuHATCFDBRanzYNjwjle
	 w7ICZSC3+lmY99qVTdnfpvNuMJVQQ/Bz7Ui1zYs6Tf53FBbKnJ/103baYD558naV8qwaV
	 VxCxd2OQxxwyAR7OhpIj1OpU7pJcYNLYUQzbixuauwbGn2pc9TA/jgtbsT4Bp34vTe8P9
	 OK2FcUJd1+Y62t2haNsANaFVhPGYNecs3QDpft5f3CZyac03O8KUOKdERMT6wC5ODhyJA
	 gj9Zl5N8czMY16ek/Kt/xfV8bj/e2PgYIKqLClCo+LEHdOFafEL2kkxjEHQxfHUa7Ig==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791550350;
	bh=5rd9ekWtsLE+/DY1OHM5Q4k4D1KquthD4XmUGtGTqTE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fa2lWAh+xjgS5A61h9FsX5yrVZN4sCM8mJuRK+uWhbEtyGrOlpcEKlUHwuhRoGVId
	 RpBp8lzN4E0SYBYbaAV7czmFqRfyxHWaYeVtzGIfBg+AFZgUi0DaCBApZosRTaoKAX
	 dTGRZQGdjuB7cHq3sxhVd2CvuWEC7nB71EWeBhS4yyrZju2MlSbtFbk69takBu4lUn
	 tquX7T5gUHvh6MP/OO55Bw2DDorac5r7Xqv4KTKYeeyUKBaOX75dZuK2nBHvZBfbA8
	 pUD95ujlxWNDiR0asawzb/ST54Z+CciUxw1A97ZKz+uPAZBCZp1z3iTzsaWvw5EbjG
	 1WsHb0XnHGEnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA35460685;
	Fri,  9 Oct 2026 12:52:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E0B2422
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F711400AB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:52:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GN7pLUohQ8qX for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 12:52:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3033040061
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791550348;
 b=dusxuolMbFujEo1nR23hlBhaBnIKJM45+y8Ax7+DhA+ytzH1k6DxO36j6ZyzLhomEt/M
 XjU1iriMIug4iHmpWeYW1euEDg5eWIdonw/dA+YhG3inJEpaLjtpwuhsOsDlCm8Q8jENt
 UJpmjJl3UcCskBFehBzrarB3AmTZ6uM0CVat4/ousnWAeCiV0lWYzzwBRT4FEaTfP/u5M
 o5pHNlO3ViOPOmfUwcYHv85jNNi/tQlmHcRlKw9JkoOedroosKNDgE8cCxbYQ94O/ZNm5
 Vl2qTbdshN9XHY5aQjzP9+wYlfgCpQOx0iTixqfO5k+o9+3qBZWeYTuJnDf3haDcf2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791550348;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=5rd9ekWtsLE+/DY1OHM5Q4k4D1KquthD4XmUGtGTqTE=;
 b=rsyOK9lpRjcagbDaARI8I8PwaL5R7qdtl9uPt9qUJxDHkyxLWVzWXI0MFnNdOqeST7rb
 79n+r5SiarRkrmQQRhcH0i3U6JSlykGlfJoQrVk/Rfehu7rVHtQO/IQ2Sz3YumRXgEu27
 ESKnAvfVT/DqizOCpurPnmnzebRY9BMHsk6Rb5OnrZ5q9CDgLvQ7xqGP6/HmmlSzNSz+S
 s7/B/qeiQYDNowfSdXjF8p3nkMcD4X1Z03U8qfWdJwqMFKZ1yT6EvPs2adOMd7wYoqaul
 e0y3OXXpkbzYMBbgZru0r8ZpEjkFxLtgRm7sd9CmTJ/hVwFQelEwA2K1eenU6plEnjw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=byzXQFqb; 
 arc=none smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=byzXQFqb
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3033040061
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791550349; x=1823086349; h=date:from:to:subject:message-id;
 bh=Et7wrm7//8NbKz9kMuZ+OajdXj/JbaOfLyDTm6j2z9I=;
 b=byzXQFqblbqOVzEfD2WoJTM6szjFgjHFglrF1PD3hy+aSy50N+P2fTGa
 HLMSka47OmDdDSJy4+FAhg5d4OgqlgJnYouJegxhAC7Bpw/VRZn/gqalh
 +AW7IugjHykW/PbcaDA3xBacjCd1ziiz6NBhseUb9nlmZjhvgfw7QoNFS
 NdO6MuGPxlYvNBtARlfkle22eAGBOvhyMeXz6EeZGm67FL8NAaB4pKiF4
 TPRgL39Z/9TcD/m9Px1ZtVVFG1ib0LTk4Flglgb/O+njh85BjGxkDhOlO
 f077cQMcSt0eUZ5W9iEjp1H7sEEBY7byQGWqy2fg3XV4khory633mNhm3 A==;
X-CSE-ConnectionGUID: j7HrWRzARre+6k3KSbbpcg==
X-CSE-MsgGUID: yseTVJGTRRyjg+2JWyqm3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="245059"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="245059"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 05:52:27 -0700
X-CSE-ConnectionGUID: UyTVk/HiTIGQllK89kjUsA==
X-CSE-MsgGUID: 8Ii7PuOOTcmMxoayxjrCDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="430402"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:52:25 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xFA5H-000000005nS-283g;
 Fri, 09 Oct 2026 12:52:23 +0000
Date: Fri, 09 Oct 2026 20:52:14 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 8cf4f2cbe05ae137a544fa950ade155c2c6dde89
Message-ID: <202610092011.caGbMuIz-lkp@intel.com>
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
branch HEAD: 8cf4f2cbe05ae137a544fa950ade155c2c6dde89  e1000e: restore jumbo config after DMoff exit

elapsed time: 1425m

configs tested: 206
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261009    gcc-10.5.0
arc                   randconfig-1001-20261009    gcc-10.5.0
arc                  randconfig-r2309-20261007    gcc-9.5.0  sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          bcm2835_defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                             mps2_defconfig    clang-24
arm                   randconfig-1000-20261009    gcc-10.5.0
arm                   randconfig-1001-20261009    gcc-10.5.0
arm                   randconfig-1002-20261009    gcc-10.5.0
arm                   randconfig-1003-20261009    gcc-10.5.0
arm                  randconfig-r2305-20261007    clang-17   sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261009    gcc-15.2.0
arm64                 randconfig-1001-20261009    gcc-15.2.0
arm64                 randconfig-1002-20261009    gcc-15.2.0
arm64                 randconfig-1003-20261009    gcc-15.2.0
arm64                randconfig-r2201-20261007    clang-24   smatch
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261009    gcc-15.2.0
csky                  randconfig-1001-20261009    gcc-15.2.0
csky                 randconfig-r2307-20261007    gcc-15.2.0 sparse
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261009    clang-18
hexagon               randconfig-1001-20261009    clang-18
hexagon              randconfig-r2302-20261007    clang-17   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261009    clang-22
i386        buildonly-randconfig-1001-20261009    clang-22
i386        buildonly-randconfig-1002-20261009    clang-22
i386        buildonly-randconfig-1003-20261009    clang-22
i386        buildonly-randconfig-1004-20261009    clang-22
i386        buildonly-randconfig-1005-20261009    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261009    clang-22
i386                  randconfig-1001-20261009    clang-22
i386                  randconfig-1002-20261009    clang-22
i386                  randconfig-1003-20261009    clang-22
i386                  randconfig-1004-20261009    clang-22
i386                  randconfig-1005-20261009    clang-22
i386                  randconfig-1006-20261009    clang-22
i386                  randconfig-1007-20261009    clang-22
i386                  randconfig-1008-20261009    clang-22
i386                  randconfig-1009-20261009    clang-22
i386                  randconfig-1010-20261009    clang-22
i386                  randconfig-1011-20261009    clang-22
i386                  randconfig-1012-20261009    clang-22
i386                  randconfig-1013-20261009    clang-22
i386                  randconfig-2100-20261007    clang-22   cocci
i386                  randconfig-2101-20261007    clang-22   cocci
i386                  randconfig-2102-20261007    clang-22   cocci
i386                  randconfig-2103-20261007    gcc-13     cocci
i386                  randconfig-2200-20261007    gcc-14     smatch
i386                 randconfig-r2107-20261007    gcc-14     cocci
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261009    clang-18
loongarch             randconfig-1001-20261009    clang-18
loongarch            randconfig-r2200-20261007    clang-24   smatch
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                           hp300_defconfig    clang-24
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm63xx_defconfig    clang-24
mips                            ci20_defconfig    gcc-16.1.0
mips                 randconfig-r2304-20261007    clang-24   sparse
nios2                             alldefconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261009    clang-18
nios2                 randconfig-1001-20261009    clang-18
nios2                randconfig-r2100-20261007    gcc-8.5.0  cocci
nios2                randconfig-r2105-20261007    gcc-8.5.0  cocci
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261009    gcc-8.5.0
parisc                randconfig-1001-20261009    gcc-8.5.0
parisc               randconfig-r2101-20261007    gcc-9.5.0  cocci
parisc               randconfig-r2301-20261007    gcc-15.2.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                     amigaone_defconfig    gcc-16.1.0
powerpc                       chrp32_defconfig    clang-24
powerpc                        holly_defconfig    clang-24
powerpc               randconfig-1000-20261009    gcc-8.5.0
powerpc               randconfig-1001-20261009    gcc-8.5.0
powerpc64             randconfig-1000-20261009    gcc-8.5.0
powerpc64             randconfig-1001-20261009    gcc-8.5.0
powerpc64            randconfig-r2103-20261007    gcc-10.5.0 cocci
powerpc64            randconfig-r2202-20261007    gcc-10.5.0 smatch
powerpc64            randconfig-r2303-20261007    clang-17   sparse
riscv                             alldefconfig    gcc-16.1.0
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261009    gcc-16.1.0
riscv                 randconfig-1001-20261009    gcc-16.1.0
riscv                 randconfig-2000-20261007    gcc-8.5.0
riscv                 randconfig-2001-20261007    clang-20
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261009    gcc-16.1.0
s390                  randconfig-1001-20261009    gcc-16.1.0
s390                  randconfig-2000-20261007    gcc-8.5.0
s390                  randconfig-2001-20261007    gcc-13.4.0
s390                 randconfig-r2104-20261007    gcc-15.2.0 cocci
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-24
sh                    randconfig-1000-20261009    gcc-16.1.0
sh                    randconfig-1001-20261009    gcc-16.1.0
sh                    randconfig-2000-20261007    gcc-14.3.0
sh                    randconfig-2001-20261007    gcc-12.5.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261009    clang-18
sparc                 randconfig-1001-20261009    clang-18
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261009    clang-18
sparc64               randconfig-1001-20261009    clang-18
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261009    clang-18
um                    randconfig-1001-20261009    clang-18
um                   randconfig-r2102-20261007    gcc-14     cocci
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261009    clang-22
x86_64      buildonly-randconfig-1001-20261009    clang-22
x86_64      buildonly-randconfig-1002-20261009    clang-22
x86_64      buildonly-randconfig-1003-20261009    clang-22
x86_64      buildonly-randconfig-1004-20261009    clang-22
x86_64      buildonly-randconfig-1005-20261009    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261009    gcc-14
x86_64                randconfig-1001-20261009    gcc-14
x86_64                randconfig-1002-20261009    gcc-14
x86_64                randconfig-1003-20261009    gcc-14
x86_64                randconfig-1004-20261009    gcc-14
x86_64                randconfig-1005-20261009    gcc-14
x86_64                randconfig-1012-20261009    gcc-14
x86_64                randconfig-1013-20261009    gcc-14
x86_64                randconfig-1014-20261009    gcc-14
x86_64                randconfig-1015-20261009    gcc-14
x86_64                randconfig-1016-20261009    gcc-14
x86_64                randconfig-1017-20261009    gcc-14
x86_64                randconfig-2100-20261007    clang-22   cocci
x86_64                randconfig-2101-20261007    clang-22   cocci
x86_64                randconfig-2102-20261007    clang-22   cocci
x86_64                randconfig-2103-20261007    clang-22   cocci
x86_64                randconfig-2200-20261007    gcc-14     smatch
x86_64               randconfig-r2106-20261007    gcc-14     cocci
x86_64               randconfig-r2300-20261007    gcc-14     sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   audio_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20261009    clang-18
xtensa                randconfig-1001-20261009    clang-18
xtensa               randconfig-r2306-20261007    gcc-15.2.0 sparse
xtensa               randconfig-r2308-20261007    gcc-8.5.0  sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
