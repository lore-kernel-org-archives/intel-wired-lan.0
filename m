Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FD5CC6B12
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 20:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65EB240448;
	Tue, 13 Oct 2026 20:59:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R4NWF9uhZRWj; Tue, 13 Oct 2026 20:59:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 405E8405B4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791925192;
	b=UQBluOSCiV5dgzPyHPD21gEQY+xHDX9CWYki35vBoN2CaggvCgIlXaykQPSZZ80RzHwX
	 v1+0YSUUGCk7UPIoKdyyILbUuAyffAuVUBmgYEOJ2rPrOUOK9ZA58tB4k134kWNIO0f8B
	 7/3u12mJR8AuNpCaQ2gceATNVz6kbrgdPwTTmIGpJWDwdazPcY1o8higydEjKQiLKa57k
	 LcBoeWkins7fmpaRa8C/PFbJzQqWFE/qGytnv+wgAO9p8P/kaTLmVSZEwXJV4gtffUnRU
	 DW2KljmjvQQQh++yn2lOpxYBylObpgHCelFtnCfpA/X20Ld1SrcVeU33U8dX49rpOzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791925192;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NAvbxtw52Z+uVQMzfmo9VTSJNTnMD9sJqzUxXmShzvA=;
	b=fUbm29gvGyZ/cYRxBz+5Q6dj0HHBu+2xk2MTXbMJFCShCIwPGp0OgCrtpA1brvrCzsbC
	 9s32n2dOWnrNL4I3DJzt/3EzUwJrCZHaJE6LiMA1UQoHCvzL2xvCQelSJOJ9osiXSBnvy
	 iycdPVxkJbp5A0Q1NBhAT6j/VILjz7+UqVfBIvwtlag5ERqPA0VauBuyYglkn7OYQyy7C
	 rHWIYg9if+Kmin6m2DSotY/QVyIyMWvbNTjaWKYnKRno/hn4/EhnJoIE9dNorfikfbsxl
	 DRTIat9Oyh6oTMzPq30JGqLDtfXfuCk+FJ9o/rgdl5IFaCNrhZVodpcHFNe3KgP//zQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791925192;
	bh=NAvbxtw52Z+uVQMzfmo9VTSJNTnMD9sJqzUxXmShzvA=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rDuNcG68hBaSvgxw3eyBpbHzwnojTVtUYM9Dv3W8S2obgU1Lnj18xGJEVaRfBkGfX
	 UtQSEXJ9R2J0EmeHGCJNkVEQHcwZ5CTyCSjiH3q5k0IOL+nfvVG3yWyhgNQPV3hpTi
	 tVgYFnVBasLaw9DCeqJwP747+TkhWDH/mAaeBZoOLl549/Y9f/8BkU7XAYsfGSP8cB
	 qFnEZTFvvgXxTX9TQxGwEVVyjC/RoUxYG0D+orEwcvdBA3RJAJv1QO8uiYNcD1++js
	 A0vkXxyE1ELjRszJN5/xMMmOWhNU0ZhJCzf+q+3/YH8GIZrgcUryc20qC855z7ten0
	 aRIkDteeyCeug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 405E8405B4;
	Tue, 13 Oct 2026 20:59:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5893D2AC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 20:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A21860818
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 20:59:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LANflFr-a0ta for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 20:59:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D780160816
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791925190;
 b=AkHHBjt7hG63XqlLGxtxWRF86TF4XwpB68GComBCPqotp4YW049t4Fg1yBSpSgzfAxBT
 Doe5bil4Il4D9I0qbzDyJQzGsavBntsGWCg7lVCVvn2z5Zdv5CWA7vwuxI5ENjPE+jCch
 D8s1gCy65In0EVvwB2gUJgv7ogOm2TEt1+KrNfYyRyQwJh3wJcYMORSlye1zC5dF8OkUl
 GhSOZrcbcrr8g7zPq1Jo0ZDfbHLQlVYQhpYzF7DI4YnDLvwXGex6qMj/VCIHeYXazMz6/
 3WboI/qtUjWn0GlLNvEQNVjPScn7vII9TQjr9Ro7wao8gJm6ZLhHRzLV+odiWTiySMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791925190;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=NAvbxtw52Z+uVQMzfmo9VTSJNTnMD9sJqzUxXmShzvA=;
 b=pZijB6105OY1mESNj2woJfnzDEwS21hOCy26RvDTgq5a+/utdPdKhkzYqwjvwneCeQdD
 uaKL+vwkp/WoNkLeTHIauVTWU4S0cN3/kzfNhq2dJC/hCYnUApnX9Djs39XWssoD5AIfz
 EA04pas5rpzWF3Re+1M02rpgvT43Uh35Or6tn2wY7yy4Q2ypNXGXAlaTBSxdoqZ3pp4pT
 VUV3SSGL3q2loSFBB2WRVcKCvrzgjj9gaP+VmsdfmPExp1jPdsMbalAnsJE4BSWOZIt0o
 9t7sct+EXHJ4zfdjLcioZN+9tBTZSEGKu9M2030Pn1Qw2T6glD+kqOIsuswQxlGKYtw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=G6XqT3Xz; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=G6XqT3Xz
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D780160816
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 20:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791925190; x=1823461190; h=date:from:to:subject:message-id;
 bh=SAgaj11qiUa0xJY9kBG75QNur0PtkXd4VI8sRWk+CS4=;
 b=G6XqT3Xz6rBkiZwZqkDv2qMwWX9u9SNPc6zjIQ0dSIEL0lKiPvZqSGBP
 /8JRaFQSCoC4vabcMuXdyyU3O/CbM5ow/zNrCJHkMjBWZUSdO700l45pD
 7kBjK8/DysXYgY9/56rMM5yyZPtaZUtH/EjXXL1qPNyk1FjStnA0TPJRN
 s3gpQXRzNWfnp/eDQDQldyeTTBVU7abBS0CqdCjupWOh8JWbTcF/Ho0b6
 3IWez37DBX5+W1RonDaudJ5BfuW7o5B0vTm7RITw23Pr5XDKTKt+/qzbP
 wdZDqsgvrediontlnNhwQp1g4i8fGBtJTMyFy5bw+NPOz0J1rHSLICX1r A==;
X-CSE-ConnectionGUID: 5yYhJf9HRfCTiQ6LVqR31w==
X-CSE-MsgGUID: 0ZuqAauyTHKdvYqHh1Yv+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="541532"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="541532"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 13:59:49 -0700
X-CSE-ConnectionGUID: BRE9pbSmTHS/UIcgcMpEGg==
X-CSE-MsgGUID: fHs+YP/4QuGOC0xai4nrMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1601369"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa009.fm.intel.com with ESMTP; 13 Oct 2026 13:59:46 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xGjb6-00000000DkJ-1SSK;
 Tue, 13 Oct 2026 20:59:44 +0000
Date: Wed, 14 Oct 2026 04:59:06 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:100GbE] BUILD SUCCESS
 3bf9f7e60efe725537f9877e6cfea8f09b42522d
Message-ID: <202610140403.GFx2byrl-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 3bf9f7e60efe725537f9877e6cfea8f09b42522d  ice: Recalibrate PHY after settime64 on E825-C

elapsed time: 5296m

configs tested: 248
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                     allnoconfig    gcc-16.1.0
alpha                    allyesconfig    gcc-16.1.0
alpha                       defconfig    gcc-16.1.0
alpha       randconfig-r2100-20261009    clang-18   cocci
alpha       randconfig-r2103-20261009    gcc-10.5.0 cocci
alpha       randconfig-r2200-20261009    gcc-8.5.0  smatch
alpha       randconfig-r2300-20261009    gcc-8.5.0  sparse
alpha       randconfig-r2305-20261009    clang-17   sparse
alpha       randconfig-r2306-20261009    gcc-12.5.0 sparse
alpha       randconfig-r2308-20261009    gcc-14     sparse
alpha       randconfig-r2309-20261009    gcc-16.1.0 sparse
arc                      allmodconfig    gcc-16.1.0
arc                       allnoconfig    gcc-16.1.0
arc                      allyesconfig    gcc-16.1.0
arc                         defconfig    gcc-16.1.0
arc         randconfig-r2101-20261009    gcc-14.3.0 cocci
arc         randconfig-r2105-20261009    gcc-13.4.0 cocci
arc         randconfig-r2200-20261009    gcc-14.3.0 smatch
arc         randconfig-r2302-20261009    gcc-8.5.0  sparse
arc         randconfig-r2306-20261009    gcc-8.5.0  sparse
arc         randconfig-r2306-20261009    gcc-9.5.0  sparse
arm                       allnoconfig    clang-17
arm                      allyesconfig    gcc-16.1.0
arm                         defconfig    clang-24
arm         randconfig-r2102-20261009    gcc-13.4.0 cocci
arm         randconfig-r2104-20261008    clang-24   cocci
arm         randconfig-r2105-20261009    gcc-16.1.0 cocci
arm         randconfig-r2106-20261008    clang-24   cocci
arm         randconfig-r2201-20261009    clang-24   smatch
arm         randconfig-r2300-20261009    gcc-8.5.0  sparse
arm         randconfig-r2302-20261009    gcc-12     sparse
arm         randconfig-r2302-20261009    gcc-8.5.0  sparse
arm         randconfig-r2305-20261009    gcc-8.5.0  sparse
arm                   stm32_defconfig    gcc-16.1.0
arm64                     allnoconfig    gcc-16.1.0
arm64                       defconfig    gcc-16.1.0
arm64       randconfig-r2105-20261009    clang-24   cocci
arm64       randconfig-r2202-20261009    gcc-10.5.0 smatch
arm64       randconfig-r2303-20261009    clang-21   sparse
csky                     allmodconfig    gcc-16.1.0
csky                      allnoconfig    gcc-16.1.0
csky                        defconfig    gcc-16.1.0
csky        randconfig-r2102-20261009    clang-18   cocci
csky        randconfig-r2106-20261009    gcc-14.3.0 cocci
csky        randconfig-r2201-20261009    gcc-14.3.0 smatch
csky        randconfig-r2300-20261009    clang-24   sparse
csky        randconfig-r2301-20261009    clang-21   sparse
csky        randconfig-r2302-20261009    clang-24   sparse
csky        randconfig-r2308-20261009    clang-22   sparse
csky        randconfig-r2308-20261009    gcc-16.1.0 sparse
csky        randconfig-r2309-20261009    gcc-12.5.0 sparse
hexagon                  allmodconfig    clang-24
hexagon                   allnoconfig    clang-24
hexagon                     defconfig    clang-24
hexagon     randconfig-r2301-20261009    gcc-12     sparse
hexagon     randconfig-r2308-20261009    gcc-12.5.0 sparse
hexagon     randconfig-r2309-20261009    gcc-14     sparse
i386                      allnoconfig    gcc-14
i386                        defconfig    clang-22
i386         randconfig-2100-20261009    clang-22   cocci
i386         randconfig-2101-20261009    clang-22   cocci
i386         randconfig-2102-20261009    clang-22   cocci
i386         randconfig-2103-20261009    clang-22   cocci
i386         randconfig-2200-20261009    gcc-14     smatch
i386         randconfig-2300-20261009    clang-22   sparse
i386         randconfig-2301-20261009    clang-22   sparse
i386         randconfig-2302-20261009    clang-22   sparse
i386        randconfig-r2304-20261009    gcc-12     sparse
loongarch                 allnoconfig    clang-20
loongarch                   defconfig    clang-24
loongarch   randconfig-r2200-20261009    gcc-16.1.0 smatch
loongarch   randconfig-r2202-20261009    clang-18   smatch
loongarch   randconfig-r2303-20261009    clang-17   sparse
loongarch   randconfig-r2304-20261009    clang-21   sparse
m68k                     allmodconfig    gcc-16.1.0
m68k                      allnoconfig    gcc-16.1.0
m68k                     allyesconfig    gcc-16.1.0
m68k                  amiga_defconfig    gcc-16.1.0
m68k                        defconfig    gcc-16.1.0
m68k        randconfig-r2100-20261009    gcc-8.5.0  cocci
m68k        randconfig-r2103-20261009    gcc-14.3.0 cocci
m68k        randconfig-r2201-20261009    gcc-11.5.0 smatch
m68k        randconfig-r2301-20261009    clang-24   sparse
m68k        randconfig-r2305-20261009    clang-21   sparse
m68k        randconfig-r2307-20261009    gcc-12.5.0 sparse
microblaze                allnoconfig    gcc-16.1.0
microblaze               allyesconfig    gcc-16.1.0
microblaze                  defconfig    gcc-16.1.0
microblaze  randconfig-r2101-20261008    gcc-8.5.0  cocci
microblaze  randconfig-r2200-20261009    gcc-9.5.0  smatch
mips                      allnoconfig    gcc-16.1.0
mips                     allyesconfig    gcc-16.1.0
mips        randconfig-r2102-20261009    gcc-10.5.0 cocci
mips        randconfig-r2103-20261009    gcc-12     cocci
mips        randconfig-r2107-20261009    gcc-14.3.0 cocci
mips        randconfig-r2303-20261009    clang-24   sparse
mips        randconfig-r2304-20261009    clang-17   sparse
mips        randconfig-r2307-20261009    gcc-8.5.0  sparse
nios2                    allmodconfig    gcc-11.5.0
nios2                     allnoconfig    gcc-11.5.0
nios2                       defconfig    gcc-11.5.0
nios2       randconfig-r2101-20261009    gcc-12     cocci
nios2       randconfig-r2101-20261009    gcc-8.5.0  cocci
nios2       randconfig-r2102-20261009    gcc-8.5.0  cocci
nios2       randconfig-r2103-20261008    gcc-11.5.0 cocci
nios2       randconfig-r2107-20261008    gcc-8.5.0  cocci
nios2       randconfig-r2304-20261009    gcc-8.5.0  sparse
nios2       randconfig-r2308-20261009    gcc-8.5.0  sparse
openrisc                 allmodconfig    gcc-16.1.0
openrisc                  allnoconfig    gcc-16.1.0
openrisc                    defconfig    gcc-16.1.0
openrisc    randconfig-r2100-20261009    gcc-12     cocci
openrisc    randconfig-r2101-20261009    gcc-10.5.0 cocci
openrisc    randconfig-r2102-20261008    gcc-16.1.0 cocci
openrisc    randconfig-r2107-20261009    clang-24   cocci
openrisc    randconfig-r2301-20261009    clang-17   sparse
openrisc    randconfig-r2302-20261009    clang-21   sparse
openrisc    randconfig-r2305-20261009    clang-24   sparse
openrisc    randconfig-r2306-20261009    gcc-14     sparse
parisc                   allmodconfig    gcc-16.1.0
parisc                    allnoconfig    gcc-16.1.0
parisc                   allyesconfig    gcc-16.1.0
parisc                      defconfig    gcc-16.1.0
parisc      randconfig-r2100-20261008    gcc-16.1.0 cocci
parisc      randconfig-r2100-20261009    gcc-13.4.0 cocci
parisc      randconfig-r2103-20261009    gcc-8.5.0  cocci
parisc      randconfig-r2200-20261009    gcc-12.5.0 smatch
parisc      randconfig-r2201-20261009    gcc-10.5.0 smatch
parisc      randconfig-r2301-20261009    gcc-8.5.0  sparse
parisc      randconfig-r2302-20261009    clang-17   sparse
parisc      randconfig-r2305-20261009    gcc-8.5.0  sparse
parisc      randconfig-r2309-20261009    gcc-9.5.0  sparse
parisc64                    defconfig    gcc-16.1.0
powerpc                   allnoconfig    gcc-16.1.0
powerpc           bluestone_defconfig    clang-24
powerpc             kmeter1_defconfig    gcc-16.1.0
powerpc     randconfig-r2103-20261009    clang-18   cocci
powerpc64   randconfig-r2104-20261009    clang-17   cocci
powerpc64   randconfig-r2104-20261009    gcc-14.3.0 cocci
powerpc64   randconfig-r2104-20261009    gcc-16.1.0 cocci
powerpc64   randconfig-r2107-20261009    clang-17   cocci
powerpc64   randconfig-r2200-20261009    clang-24   smatch
powerpc64   randconfig-r2301-20261009    gcc-8.5.0  sparse
powerpc64   randconfig-r2305-20261009    gcc-12     sparse
riscv                    allmodconfig    clang-24
riscv                     allnoconfig    gcc-16.1.0
riscv                    allyesconfig    clang-24
riscv                       defconfig    clang-24
riscv        randconfig-1000-20261013    gcc-9.5.0
riscv        randconfig-1001-20261013    clang-24
riscv        randconfig-2000-20261009    gcc-16.1.0
riscv        randconfig-2001-20261009    gcc-16.1.0
riscv       randconfig-r2105-20261009    clang-17   cocci
riscv       randconfig-r2106-20261009    clang-24   cocci
riscv       randconfig-r2300-20261009    gcc-12     sparse
s390                     allmodconfig    clang-24
s390                      allnoconfig    clang-24
s390                        defconfig    clang-18
s390         randconfig-1000-20261013    gcc-8.5.0
s390         randconfig-1001-20261013    gcc-8.5.0
s390         randconfig-2000-20261009    gcc-16.1.0
s390         randconfig-2001-20261009    gcc-16.1.0
s390        randconfig-r2104-20261009    clang-24   cocci
s390        randconfig-r2105-20261008    clang-24   cocci
s390        randconfig-r2106-20261009    gcc-13.4.0 cocci
s390        randconfig-r2306-20261009    gcc-16.1.0 sparse
s390        randconfig-r2308-20261009    gcc-9.5.0  sparse
sh                       allmodconfig    gcc-16.1.0
sh                        allnoconfig    gcc-16.1.0
sh                       allyesconfig    gcc-16.1.0
sh                edosk7705_defconfig    gcc-16.1.0
sh                edosk7760_defconfig    gcc-16.1.0
sh           randconfig-1000-20261013    gcc-12.5.0
sh           randconfig-1001-20261013    gcc-10.5.0
sh           randconfig-2000-20261009    gcc-16.1.0
sh           randconfig-2001-20261009    gcc-16.1.0
sh          randconfig-r2101-20261009    gcc-13.4.0 cocci
sh          randconfig-r2105-20261009    gcc-14.3.0 cocci
sh          randconfig-r2106-20261009    clang-17   cocci
sh                  rsk7264_defconfig    gcc-16.1.0
sh                   se7780_defconfig    gcc-16.1.0
sparc                     allnoconfig    gcc-16.1.0
sparc                       defconfig    gcc-16.1.0
sparc        randconfig-2000-20261009    clang-17
sparc        randconfig-2000-20261009    gcc-8.5.0
sparc        randconfig-2001-20261009    clang-17
sparc        randconfig-2001-20261009    gcc-14.3.0
sparc       randconfig-r2100-20261009    gcc-14.3.0 cocci
sparc       randconfig-r2106-20261009    gcc-16.1.0 cocci
sparc       randconfig-r2201-20261009    gcc-11.5.0 smatch
sparc64                  allmodconfig    clang-20
sparc64      randconfig-2000-20261009    clang-17
sparc64      randconfig-2000-20261009    gcc-9.5.0
sparc64      randconfig-2001-20261009    clang-17
sparc64      randconfig-2001-20261009    clang-24
sparc64     randconfig-r2102-20261009    gcc-14.3.0 cocci
sparc64     randconfig-r2107-20261009    gcc-13.4.0 cocci
sparc64     randconfig-r2107-20261009    gcc-16.1.0 cocci
sparc64     randconfig-r2201-20261009    clang-24   smatch
sparc64     randconfig-r2303-20261009    gcc-12     sparse
sparc64     randconfig-r2309-20261009    gcc-8.5.0  sparse
um                       allmodconfig    clang-17
um                        allnoconfig    clang-17
um                       allyesconfig    gcc-14
um           randconfig-2000-20261009    clang-17
um           randconfig-2000-20261009    clang-21
um           randconfig-2001-20261009    clang-17
um          randconfig-r2100-20261009    gcc-10.5.0 cocci
um          randconfig-r2102-20261009    gcc-12     cocci
um          randconfig-r2104-20261009    gcc-13.4.0 cocci
um          randconfig-r2303-20261009    gcc-8.5.0  sparse
um          randconfig-r2304-20261009    clang-24   sparse
um          randconfig-r2304-20261009    gcc-8.5.0  sparse
um          randconfig-r2307-20261009    gcc-9.5.0  sparse
x86_64                    allnoconfig    clang-22
x86_64                          kexec    clang-22
x86_64       randconfig-2100-20261009    clang-22   cocci
x86_64       randconfig-2101-20261009    clang-22   cocci
x86_64       randconfig-2102-20261009    clang-22   cocci
x86_64       randconfig-2103-20261009    clang-22   cocci
x86_64       randconfig-2200-20261009    gcc-14     smatch
x86_64       randconfig-2300-20261009    clang-22   sparse
x86_64       randconfig-2301-20261009    clang-22   sparse
x86_64       randconfig-2302-20261009    clang-22   sparse
x86_64      randconfig-r2103-20261009    gcc-13.4.0 cocci
x86_64      randconfig-r2202-20261009    clang-22   smatch
x86_64      randconfig-r2300-20261009    clang-21   sparse
x86_64      randconfig-r2303-20261009    gcc-8.5.0  sparse
x86_64      randconfig-r2306-20261009    clang-22   sparse
x86_64      randconfig-r2307-20261009    gcc-14     sparse
x86_64      randconfig-r2307-20261009    gcc-16.1.0 sparse
x86_64      randconfig-r2309-20261009    clang-22   sparse
x86_64                       rhel-9.4    clang-22
x86_64                   rhel-9.4-bpf    clang-22
x86_64                  rhel-9.4-func    clang-22
x86_64            rhel-9.4-kselftests    clang-22
x86_64                 rhel-9.4-kunit    clang-22
x86_64                   rhel-9.4-ltp    clang-22
x86_64                  rhel-9.4-rust    clang-22
xtensa                    allnoconfig    gcc-16.1.0
xtensa                   allyesconfig    gcc-16.1.0
xtensa       randconfig-2000-20261009    clang-17
xtensa       randconfig-2000-20261009    gcc-10.5.0
xtensa       randconfig-2001-20261009    clang-17
xtensa       randconfig-2001-20261009    gcc-8.5.0
xtensa      randconfig-r2101-20261009    clang-18   cocci
xtensa      randconfig-r2300-20261009    clang-17   sparse
xtensa      randconfig-r2307-20261009    clang-22   sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
