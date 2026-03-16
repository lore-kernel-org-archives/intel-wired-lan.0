Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0287FEFCBD4
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Mar 2026 08:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C780040665;
	Mon, 16 Mar 2026 08:09:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-aYZRlZ4p57; Mon, 16 Mar 2026 08:09:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12E0B40656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773648587;
	bh=y/1CsqiN1x9aJ2BkTfrWGWjqlgLI2pqUzGm+31i5yh0=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NHIyTdAg/LgDeW4vncxF9CWRpIAIrlBfokjQVsgMzYwu8/+QCLsOdvDMlgXPajU/h
	 SaPygxsN4CV4glMwboY6DxbIbsPS0LIiOrvCBBtF+c6wtEb1hPzRMztxsyGif8BUzx
	 3gKjAu1LMWVSvSwt/XkzkwZr0wjm/Egg+XcZwPmhYm/pU1eQmQNlYBLgqHdlsfXEoH
	 ptu01UanBknrE/R8vfOiiqiqcJkWYBjk00e5Bj5Bu12gtM+xnIDtiV/MwCaXSJ8NYU
	 gRZJPQHqP2M5FJoN8JUFscEME0dGzzK6QuSN+zjDX3pLBi/OAMEF2+M4syIDCI0nfl
	 2zVIkMFzdSwBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12E0B40656;
	Mon, 16 Mar 2026 08:09:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BC613BE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 08:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19BFE40655
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 08:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V9aRlApqrFlP for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Mar 2026 08:09:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 48C724064E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48C724064E
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48C724064E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 08:09:43 +0000 (UTC)
X-CSE-ConnectionGUID: zVcVXnYFRTqUjD0ej+goew==
X-CSE-MsgGUID: cq0emnEdRqKOZyWbUwLcQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="86012941"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="86012941"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 01:09:43 -0700
X-CSE-ConnectionGUID: kUxd1fiFTDOiSjspIqhnkQ==
X-CSE-MsgGUID: kmA1HfrsSz+0/VZz5DZqLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="222043222"
Received: from lkp-server01.sh.intel.com (HELO 892944969b78) ([10.239.97.150])
 by orviesa007.jf.intel.com with ESMTP; 16 Mar 2026 01:09:41 -0700
Received: from kbuild by 892944969b78 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w2319-000000000LS-0Roq;
 Mon, 16 Mar 2026 08:09:39 +0000
Date: Mon, 16 Mar 2026 16:08:52 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202603161647.SnrUYME9-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773648585; x=1805184585;
 h=date:from:to:subject:message-id;
 bh=FCHXBMulySoR6L3gayBBTRqTnFO7oxY3/THbHMOHl7I=;
 b=U49bFR89wBD8gCo6gmrS37FkIwhNCwWgpXZV43ahfsnhXAM0bw16PyE4
 aKk4KoI74x2fLVYwYwBsthgh1lwYZD7mwzQz5N8Tt1pdBGC23rjusuwUH
 lBX2mdi+BYARIo0WLhp/NC2Pan7xn2lVY+bCdUM3/Eyx8I8bL47mz1RJT
 ruFwgvFMCUTTh6ZEEJqH/98JZtlPj9mMqOsMELqRuMI97zwTDLTGEQMiP
 K0Kl1Z1xl/vuzQMeMBC9kUbW2FxeNIpQkAGTvs5foTamH7Akg4NmbPRk7
 QyGlZ1z5viMu6ZW6FvjU1T/39IdenP5ZrVCb4L2DTlJ/QBYBnzb/Gq8OP
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U49bFR89
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 30901d3f3254e1338d10e44d46793cc922d28ecb
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 30901d3f3254e1338d10e44d46793cc922d28ecb  idpf: only assign num refillqs if allocation was successful

elapsed time: 773m

configs tested: 59
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sparc                   allnoconfig    gcc-15.2.0
sparc       randconfig-001-20260316    gcc-8.5.0
sparc       randconfig-002-20260316    gcc-12.5.0
sparc64                allmodconfig    clang-23
sparc64     randconfig-001-20260316    gcc-8.5.0
sparc64     randconfig-002-20260316    gcc-15.2.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0
xtensa                 allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
