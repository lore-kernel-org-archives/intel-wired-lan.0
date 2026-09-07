Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4D0C79FA0
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 19:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26FD680982;
	Mon,  7 Sep 2026 19:00:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SkEkQEC4SUOL; Mon,  7 Sep 2026 19:00:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0E1C68097B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788807627;
	b=ZTO2j5IetLe4kuTeq4oGnaAfBWeYv0CI4JQb55xOwCfdOYUnEycyjl+2xEmxBWFI0aLl
	 hBemsO+LmjWts3xUmYb3WsMI5+s7loe7FgwvXLu8WAUWvpyogBJmt9NBSDnd7SLhw1KAz
	 6QNFJqvf43X/uaQ+IOe4RvO7DnIGKXpngKCPl680ZieEOUoj89VBnRixDGJS9+U0vCfi4
	 cOApc7zQNAAGBoq4rfck9CtBrGe+VNz5qlElpRU2Qy+fgmRWwpirjHe6hR7XNSSBZ7Ejx
	 peXhQ/hlgkxMcifkERRX6i9q3kUpaIMGt6L/sbZ84076GaFeYPmcvMynw7JKxYB6EMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788807627;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+tqNsoXmM4MNdumgVg7tZ1g3oG9WkeUSswFT+v5E6rM=;
	b=o6GHxvhyKnD6GcSqdXoTsy33nHbFF/uLoQeT/l5nDtuNSP//RXrmaLsfBBghaP6+ZYHm
	 UIngi1+rdzWn77UKq4+khyVuo4jhxKrAjLsl442Va68DnQ5j3ybFnNyM6sYBjIVT51emR
	 1hME78KO2JBXA6Z+vgwVLM6zAtqImdapj2zoGS7SGNymmjCjVbzmEEkTchClEd2ek6OR9
	 GkVAtfbGsFZVnXIlJTzY5EVU6UxrbnK+P9eB9y5LuvsUYKlP/h5IltPP57EwsaLuFvvnp
	 UhUUj/wi9fQ0JQJP9gbXgNeXPGmNZ3e0DbKbtK23WDoDy++FSNBl7ma+eVF6VUrkEdw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788807627;
	bh=+tqNsoXmM4MNdumgVg7tZ1g3oG9WkeUSswFT+v5E6rM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hauGRvB0MKsD73fDmamizN2371Wr5F4wuuY2R2w0GpF8+MahEv2FR2+c3mYFEt9ET
	 IMUwed+lUPS1I2Tpb8eQxlYuDXL5/BfWUy9r2ewKaP8FqbAsjMgOG0RFzk22c4cLBK
	 l/7BD1KF/Fo8bde9y0CsTaCYu1BpK9LYzUTUJd11ya8sCHYagb0GYfpyS+cjpIY20j
	 8xKw6Pj6j1Kj4RNLLhpKqS7OKYqb9GewiEMYocpCeQ0bhxD5l63MR4hjhB4hXYaPYU
	 4ZcpWr11uEd5DF383yEuUux2zegy24yMteS5u6FSyNmfCKQrMqeCMntkPY1P9AHHWF
	 JqZgpKs43pPSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E1C68097B;
	Mon,  7 Sep 2026 19:00:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 966C3388
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 19:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C673605F5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 19:00:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J2VQ40vA6BKo for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 19:00:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D9361605CE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788807624;
 b=pGDP6Flkpf9fZ1WN80CJOJBUlKxF4+GCmKGFCVChD4Tc4PwUZ3cRsvvdgAE3gISOC39L
 GCMcF4V9JJhyzJsVXJQlob1PCy1lkLCMiiGeIIx8J67QqNQo0P5sc5oaq1HUXqv1DOuN4
 yJeX4an7u33Gyz9iE4S1oH32chOGVs2pPSetQPYvjHXapA5xfASEOxqxaOQHQNbMBlvwl
 03MNK0KldanqMvcfYtq2M13Q2ebCtvVvyZGB/R3aWaXiVmEObaVosLEppb+tCEauFKlAD
 fzAVmWuALyNEKML4tfzxPdB9v2yYD77DFUYBGLbDMGgWIUbT/KA1yeE/JLkMZ9Dv6nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788807624;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=+tqNsoXmM4MNdumgVg7tZ1g3oG9WkeUSswFT+v5E6rM=;
 b=FIaFO4k2NHP68qzV/e+LKNi9KMyiZfTMtgoIm1q2CncQBno5XLLB7rMGGEISKfOHEyRP
 2oYFfyoyK51zwjCWSye7FMX/sbjw8oax8C1dOnxetlbH/r0+iNRqnbGbqOd9OutejZUJl
 X6+bz6bOmcey5A5D9nLN8+yU79PoiTNinwc6Zslvg8hleWkTUSS5KFLocJgMIgjXDCcE9
 OtEo1XHeaMsCk0giY0GKwl0+fqu/U2LUJ50yZimIxdjsQeT3b+6Ysj3dOmT/+wrg3eWkH
 e9p8snuvr3PFncc0tfXYhieP1YCYmpJNg3ixBAF0K6bB6AH61zPcWD9ZklMTEGVZ/eA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aK7O+pne; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aK7O+pne
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9361605CE
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788807624; x=1820343624; h=date:from:to:subject:message-id;
 bh=RA4K//1+1gk2rQnt1K3xAEl0E2Q68c/xPh7tCQHodls=;
 b=aK7O+pnea9Hn2VD/83CywybOveEXqQUKguZq2YV2UXutynUvXZehECoT
 NEupf/zm+/bkG6VbaFNk273OPdSMNuIT4sM5DQhmdPFP/Ui3o6F1v/pmd
 4nxst+vfxToGNj9ESM8A5LIf1Z9v21x9u5UkjjjNWBEuZvXB8nUIYZfv2
 odBbxcATJwTW231KAoi8HG2GuMHj9ydjclGPmEZN0/asfJN/KJ+83nCV1
 YGFqYp3im6TSGoeiVqyNB2Uejv+gvhSUetjqhaWuIdeXhf5obnScG3Nt1
 4vDhvNXSuh1HZafAuWUBcod0R/edP6xWbncjtPCY9coZLH2Woh3EWj5Pr A==;
X-CSE-ConnectionGUID: OACAmOHNTH+BTCyp6TKeSg==
X-CSE-MsgGUID: ukX+IdRzT+KCWkuqTPiqtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99805008"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="99805008"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 12:00:23 -0700
X-CSE-ConnectionGUID: YnauxN23Q8GOdgfE+PMwPg==
X-CSE-MsgGUID: u4VKY8m8QFu9oBrz0t0x8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="270263849"
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
 by orviesa008.jf.intel.com with ESMTP; 07 Sep 2026 12:00:22 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x3eZn-000000001GJ-2sRR;
 Mon, 07 Sep 2026 19:00:19 +0000
Date: Tue, 08 Sep 2026 02:59:38 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 ed020eb043e16ad646bcf78e1e3903a65771f6d2
Message-ID: <202609080235.2Aopu01a-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: ed020eb043e16ad646bcf78e1e3903a65771f6d2  e100: prevent shift-out-of-bounds in EEPROM access

elapsed time: 4473m

configs tested: 65
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    clang-24
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    clang-17
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
sparc         allnoconfig    clang-24
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
