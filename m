Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2D6C9830E
	for <intel-wired-lan@archiver.kernel.org>; Sun, 27 Sep 2026 13:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F5784085E;
	Sun, 27 Sep 2026 13:41:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hg_7IhG3uyYI; Sun, 27 Sep 2026 13:41:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E19FF406BC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790516489;
	b=Fb3l3f10y34g1HfHCSeoyLAo0KajiAkZK0QN3KRIXX9bsNbWCauozAzesiCdn0evVDHH
	 nhW68h00AZKLCmmxtY6U7U7Bstv5yXb3YGFF9OZlsllMoyLRwN6IW8uSj0D+qf8IAy15e
	 +FZtNhaB+o3XHMEqcaPrIrqXzBSc+T/vyEiVXhsGv0wO3W5gdxO8YsdtyXy8k0DwFu/kF
	 IihHZ2H35IroHwlsd312fX7KRSCXr3xVl7SUEuUZlQvbIcSmn0UMh09Ok/jC3KpN00mOA
	 /DAloG1JD0gd6OzhG2hHd9PVCv5aa8WpZ8GOrtZP9fGvlBhHhlQkosnr4cj1/FL9LQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790516489;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SLN4MhOUyVQWbRd8uHakKJ9BFhkRKUpm1E12fjkb7hw=;
	b=F9120ZQuJrndOcN9oXpn1QY3Q5gPPcVje/G8MFvu2qhE2Uacb5u8cS9v2HbsxeJIcikn
	 gSslbs/woMIDo8RW/d/ByV87B29S8N0MpFGb8Rs7DXQnfystRTF5KJS5Uhb7VJucrnbu8
	 6kfEFxsomwu5zEBiAdRH30GENv72a5S6MyPqKukLe5PVKBYxDmF4GwPVQdFen4ZDcXHZh
	 Cyxhgo3A67ozCrQ1HKQqB/FWSW3+IsPaaiaUDEw098cmZzg9ByoYVmQB0AUEACPBjGxYV
	 g5MINTA4u+HQp7DksE1NeQJE8cRe0wkWGXp2kXFVd6uM7ttDNtc7+0e9+v/7KjTmbDQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790516488;
	bh=SLN4MhOUyVQWbRd8uHakKJ9BFhkRKUpm1E12fjkb7hw=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dmCaOA8abPzq4FsYQHPixgSK0yM1FmMtfIS40BGzx3n/GCsxPuS6xf7KFW67gR03p
	 2o7I7KRBZDaQNiXZDthuoHX/zQ2Pi6gaRbTXz8jOQJUtNrm2sZdJrXGTDWQeyTw+2j
	 DP+/bRNLHpNn+WQMKVmuSru3xraY2WEw36G940bs4TM+6Un0147Z5xbFp39ZKsURKE
	 n0+DUyslQ10hbP8KqUtPYrroWDJUD1vRGlyNr3G9Mjz53itC+qhjZvBVQKNR20ENW8
	 UBSjjRxKe+X6eMUnJssN0hZbBy5QK5SlfV0TgKsoyBpGtWq+scJTsyx/HnQeRIJV1+
	 NVQVOFWcqf4Pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E19FF406BC;
	Sun, 27 Sep 2026 13:41:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62186422
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 13:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 53EA480F9E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 13:41:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JfoRekNKVJyY for <intel-wired-lan@lists.osuosl.org>;
 Sun, 27 Sep 2026 13:41:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BD62B80F97
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790516486;
 b=GvVo760XdQFb0CG7GlM1A/NN8DBcdtAIsQVaGjCmttmmB+A/MnGoyjeq17I4l6prafnq
 ZLIbtCXX3Y1VGev2gjDGV7XnCqEYIhkzZG9hthcKSdoWGqzXEP/ByRqzTvPbXcK6iM7O0
 YhIJB64Ip/Kjp2opAj02QJvgjPzdb4FREHCjkYZSYUz2jAc7OLsYoRL7t2jukNd+sGr0g
 vudZLW/7Zb/50lJebpWAwhoFIUTgtIf+1Z8BWpjj5mu+T1F5mVY6ssw68wrstGCaLU13q
 eVigigX0eWNnvyo55MIH/fXxktQFmgfDgvq2FfUaesVmDc/KQPsOaXPApOcIf3EDTzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790516486;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=SLN4MhOUyVQWbRd8uHakKJ9BFhkRKUpm1E12fjkb7hw=;
 b=YNvQXL+3CvDebpHzIbDdZGaj9WnLHHiFPxsKklZrhHL2qJ9aB0SSA8AJ02Gz7/dP1VY0
 jyq76CFwnrVKWM170Axp7zIZBwjlfPsQRyNlTG2/KZOHomYo5NmRbK/zmNrl5U0fQ3zdg
 aJYkJfiX0h1CSOHoEmLiuxxD1CTy3TuNhZFs4ANi4HA9u6RCh/oXCltxrWBh8wyJBI6os
 NHcNWFx2t8U4a4ROGGEzGKseDHmzsHaQBrMsWbXFLLdV/p6vX3GUzPYiWGQYHcMcJamVa
 UWslbfBUcuoP2Ve2NhGz/Kezyqoil31tI01Rotd1nlE9gc5vBMy/melyUFG+Gi8C9VQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FLT8KK3a; 
 arc=none smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FLT8KK3a
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD62B80F97
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 13:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790516486; x=1822052486; h=date:from:to:subject:message-id;
 bh=uz++FN8IsHMAu4lLhHOhPxwmsrfFn4Ux+yhd5wYOHaI=;
 b=FLT8KK3aR5JDHNwzKYC8bNBfK0G2m2TySUgAw8YysNT3LBp4BfX9Q1nz
 xiw2AaoHlQOadBthSRdqQXWADdS1qLMgxmsZcOQbKX+z7Quf/5wEMjVkl
 uS8C36lnTC7BrOctjs9yN9CW0oqxUY4yi9bNGN0O2ywvp0AvK7adnW0yf
 7LQKj9zF0CpPZ/fqt5HgbSVu0RQJ1l1WSVkJ3FqK74ybR6OQkHdimq8by
 qICsIykyjwyHcfceOKo7jV8qS/rAfiENJL2Yjtgg9oNigynDvmFPSg2Qq
 kcHM7kYUnha7XyxAP5jbNR+etz+y1Dc5mf1zCvXwyO7I9bZDjv24PQfUC w==;
X-CSE-ConnectionGUID: qYJb5Ij0SNSPe/xVVMBLSA==
X-CSE-MsgGUID: 0EE6wMl6SiGcWyRP+BPmIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11917"; a="90358353"
X-IronPort-AV: E=Sophos;i="6.27,126,1787036400"; d="scan'208";a="90358353"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2026 06:41:25 -0700
X-CSE-ConnectionGUID: kmKYWKf7RoyGMDbj9lRTwA==
X-CSE-MsgGUID: A2FXHbHZSJy3ZoV7YfWcRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,126,1787036400"; d="scan'208";a="271294826"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa009.fm.intel.com with ESMTP; 27 Sep 2026 06:41:23 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xAp85-00000000MtZ-1baY;
 Sun, 27 Sep 2026 13:41:21 +0000
Date: Sun, 27 Sep 2026 21:41:04 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:main] BUILD SUCCESS
 11536ee3d3e0b1bd35b6f3f8df55a6053eb0c71d
Message-ID: <202609272100.O51ktPQI-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git main
branch HEAD: 11536ee3d3e0b1bd35b6f3f8df55a6053eb0c71d  MAINTAINERS: update Eric Dumazet's email address

elapsed time: 1803m

configs tested: 262
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2201-20260925    gcc-13.4.0 smatch
alpha                randconfig-r2303-20260927    clang-22   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                  nsimosci_hs_smp_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260927    gcc-11.5.0
arc                   randconfig-1001-20260927    gcc-11.5.0
arc                  randconfig-r2100-20260925    gcc-9.5.0  cocci
arc                  randconfig-r2301-20260927    clang-22   sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          assabet_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20260927    gcc-11.5.0
arm                   randconfig-1001-20260927    gcc-11.5.0
arm                   randconfig-1002-20260927    gcc-11.5.0
arm                   randconfig-1003-20260927    gcc-11.5.0
arm                  randconfig-r2201-20260926    clang-20   smatch
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260927    clang-17
arm64                 randconfig-1001-20260927    clang-17
arm64                 randconfig-1002-20260927    clang-17
arm64                 randconfig-1003-20260927    clang-17
arm64                randconfig-r2104-20260925    gcc-15.2.0 cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260927    clang-17
csky                  randconfig-1001-20260927    clang-17
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260927    gcc-11.5.0
hexagon               randconfig-1001-20260927    gcc-11.5.0
hexagon              randconfig-r2101-20260925    gcc-9.5.0  cocci
hexagon              randconfig-r2102-20260925    gcc-9.5.0  cocci
hexagon              randconfig-r2302-20260927    clang-22   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260927    clang-22
i386        buildonly-randconfig-1001-20260927    clang-22
i386        buildonly-randconfig-1002-20260927    clang-22
i386        buildonly-randconfig-1003-20260927    clang-22
i386        buildonly-randconfig-1004-20260927    clang-22
i386        buildonly-randconfig-1005-20260927    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260927    clang-22
i386                  randconfig-1001-20260927    clang-22
i386                  randconfig-1002-20260927    clang-22
i386                  randconfig-1003-20260927    clang-22
i386                  randconfig-1004-20260927    clang-22
i386                  randconfig-1005-20260927    clang-22
i386                  randconfig-1006-20260927    clang-22
i386                  randconfig-1007-20260927    gcc-14
i386                  randconfig-1008-20260927    gcc-14
i386                  randconfig-1009-20260927    gcc-14
i386                  randconfig-1010-20260927    gcc-14
i386                  randconfig-1011-20260927    gcc-14
i386                  randconfig-1012-20260927    gcc-14
i386                  randconfig-1013-20260927    gcc-14
i386                  randconfig-2100-20260925    clang-22   cocci
i386                  randconfig-2100-20260926    gcc-14     cocci
i386                  randconfig-2101-20260925    clang-22   cocci
i386                  randconfig-2101-20260926    gcc-14     cocci
i386                  randconfig-2102-20260925    clang-22   cocci
i386                  randconfig-2102-20260926    gcc-14     cocci
i386                  randconfig-2103-20260925    clang-22   cocci
i386                  randconfig-2103-20260926    gcc-14     cocci
i386                  randconfig-2200-20260925    gcc-14     smatch
i386                 randconfig-r2202-20260925    clang-22   smatch
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260927    gcc-11.5.0
loongarch             randconfig-1001-20260927    gcc-11.5.0
loongarch            randconfig-r2308-20260926    clang-22   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                 randconfig-r2102-20260926    clang-24   cocci
m68k                            sun3_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2300-20260927    clang-22   sparse
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                          db1xxx_defconfig    gcc-16.1.0
mips                           eyeq6_defconfig    gcc-16.1.0
mips                      eyeq6lplus_defconfig    gcc-16.1.0
mips                        lemote2f_defconfig    gcc-16.1.0
mips                 randconfig-r2200-20260926    gcc-15.2.0 smatch
mips                 randconfig-r2202-20260926    clang-17   smatch
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260927    gcc-11.5.0
nios2                 randconfig-1001-20260927    gcc-11.5.0
nios2                randconfig-r2307-20260926    clang-22   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc                     or1ksim_defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260927    clang-24
parisc                randconfig-1001-20260927    clang-24
parisc               randconfig-r2104-20260926    gcc-8.5.0  cocci
parisc               randconfig-r2106-20260925    gcc-15.2.0 cocci
parisc               randconfig-r2309-20260926    clang-22   sparse
parisc64                             defconfig    clang-24
powerpc                            allnoconfig    clang-24
powerpc               randconfig-1000-20260927    clang-24
powerpc               randconfig-1001-20260927    clang-24
powerpc              randconfig-r2100-20260926    clang-24   cocci
powerpc                      tqm8541_defconfig    gcc-16.1.0
powerpc                      tqm8560_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260927    clang-24
powerpc64             randconfig-1001-20260927    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260927    gcc-16.1.0
riscv                 randconfig-1001-20260927    gcc-16.1.0
riscv                 randconfig-2000-20260925    gcc-11.5.0
riscv                 randconfig-2000-20260926    gcc-12.5.0
riscv                 randconfig-2001-20260925    gcc-11.5.0
riscv                 randconfig-2001-20260926    gcc-12.5.0
riscv                randconfig-r2103-20260926    clang-24   cocci
riscv                randconfig-r2107-20260926    gcc-8.5.0  cocci
riscv                randconfig-r2304-20260927    clang-22   sparse
riscv                randconfig-r2305-20260927    clang-22   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                           debug_defconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260927    gcc-16.1.0
s390                  randconfig-1001-20260927    gcc-16.1.0
s390                  randconfig-2000-20260925    gcc-11.5.0
s390                  randconfig-2000-20260926    gcc-12.5.0
s390                  randconfig-2001-20260925    gcc-11.5.0
s390                  randconfig-2001-20260926    gcc-12.5.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                           polaris_defconfig    gcc-16.1.0
sh                           r7780mp_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260927    gcc-16.1.0
sh                    randconfig-1001-20260927    gcc-16.1.0
sh                    randconfig-2000-20260925    gcc-11.5.0
sh                    randconfig-2000-20260926    gcc-12.5.0
sh                    randconfig-2001-20260925    gcc-11.5.0
sh                    randconfig-2001-20260926    gcc-12.5.0
sh                   randconfig-r2105-20260925    gcc-15.2.0 cocci
sh                   randconfig-r2105-20260926    gcc-8.5.0  cocci
sh                             titan_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260927    clang-24
sparc                 randconfig-1001-20260927    clang-24
sparc                 randconfig-2000-20260925    gcc-16.1.0
sparc                 randconfig-2000-20260927    gcc-16.1.0
sparc                 randconfig-2001-20260925    gcc-16.1.0
sparc                 randconfig-2001-20260927    gcc-16.1.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260927    clang-24
sparc64               randconfig-1001-20260927    clang-24
sparc64               randconfig-2000-20260925    gcc-16.1.0
sparc64               randconfig-2000-20260927    gcc-16.1.0
sparc64               randconfig-2001-20260925    gcc-16.1.0
sparc64               randconfig-2001-20260927    gcc-16.1.0
sparc64              randconfig-r2101-20260926    clang-24   cocci
sparc64              randconfig-r2103-20260925    gcc-9.5.0  cocci
sparc64              randconfig-r2106-20260926    gcc-8.5.0  cocci
sparc64              randconfig-r2200-20260925    gcc-8.5.0  smatch
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260927    clang-24
um                    randconfig-1001-20260927    clang-24
um                    randconfig-2000-20260925    gcc-16.1.0
um                    randconfig-2000-20260927    gcc-16.1.0
um                    randconfig-2001-20260925    gcc-16.1.0
um                    randconfig-2001-20260927    gcc-16.1.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260927    gcc-14
x86_64      buildonly-randconfig-1001-20260927    gcc-14
x86_64      buildonly-randconfig-1002-20260927    gcc-14
x86_64      buildonly-randconfig-1003-20260927    gcc-14
x86_64      buildonly-randconfig-1004-20260927    gcc-14
x86_64      buildonly-randconfig-1005-20260927    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260927    clang-22
x86_64                randconfig-1001-20260927    clang-22
x86_64                randconfig-1002-20260927    clang-22
x86_64                randconfig-1003-20260927    clang-22
x86_64                randconfig-1004-20260927    clang-22
x86_64                randconfig-1005-20260927    clang-22
x86_64                randconfig-1006-20260927    clang-22
x86_64                randconfig-1007-20260927    clang-22
x86_64                randconfig-1008-20260927    clang-22
x86_64                randconfig-1009-20260927    clang-22
x86_64                randconfig-1010-20260927    clang-22
x86_64                randconfig-1011-20260927    clang-22
x86_64                randconfig-1012-20260927    clang-22
x86_64                randconfig-1013-20260927    clang-22
x86_64                randconfig-1014-20260927    clang-22
x86_64                randconfig-1015-20260927    clang-22
x86_64                randconfig-1016-20260927    clang-22
x86_64                randconfig-1017-20260927    clang-22
x86_64                randconfig-2100-20260925    clang-22   cocci
x86_64                randconfig-2100-20260926    clang-22   cocci
x86_64                randconfig-2101-20260925    clang-22   cocci
x86_64                randconfig-2101-20260926    clang-22   cocci
x86_64                randconfig-2102-20260925    clang-22   cocci
x86_64                randconfig-2102-20260926    clang-22   cocci
x86_64                randconfig-2103-20260925    clang-22   cocci
x86_64                randconfig-2103-20260926    clang-22   cocci
x86_64                randconfig-2200-20260925    gcc-14     smatch
x86_64                randconfig-2200-20260926    clang-22   smatch
x86_64               randconfig-r2306-20260926    clang-22   sparse
x86_64                                rhel-9.4    clang-22
x86_64                                rhel-9.4    gcc-14
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                           rhel-9.4-func    gcc-14
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                     rhel-9.4-kselftests    gcc-14
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20260927    clang-24
xtensa                randconfig-1001-20260927    clang-24
xtensa                randconfig-2000-20260925    gcc-16.1.0
xtensa                randconfig-2000-20260927    gcc-16.1.0
xtensa                randconfig-2001-20260925    gcc-16.1.0
xtensa                randconfig-2001-20260927    gcc-16.1.0
xtensa               randconfig-r2107-20260925    gcc-15.2.0 cocci

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
