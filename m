Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A298FC44512
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 20:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A6C580F29;
	Thu, 16 Jul 2026 20:40:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-b-bX_vfVue; Thu, 16 Jul 2026 20:40:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B39F810A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784234422;
	bh=i/kLr0G5SYf2Z+Dfemkn0h9r9ifjKyqB2fMxt0bw1jI=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sBVASK/FNs8gTV1vq3CPviXEpn6WEz/CfCO0g/nCIhK520UT0uIvNJfT0iTZVjBc0
	 BH9pRS1JKslwDWmJhTCwn1iEjh4Fatp2TSnpfi3m2lLSwAGxXZ73xzwiXV+XlvARYK
	 0DlSBMpQJUF6l1P11ib5ATtQXn8WpcxFu4LL/q/SNPouNkJfWVWpMFxAKUt/ZE0wDk
	 KHJte8soMle66plJM1jO/4DleZ6hS1COP57QruGf6o7Kwhzpo4kEk48PxDe+2mV0PT
	 bDVwsjlvCy1B37PCEnx0zgBmvEHo0kXRcj45EjqgVK7NGlg/Q2JlmML8iDWzy5ujSd
	 Brt9NwgfyxvQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B39F810A5;
	Thu, 16 Jul 2026 20:40:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AC7EE1F6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 20:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9252340A20
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 20:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jTA3cktKN0P6 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 20:40:19 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 67DB040A21
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 67DB040A21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67DB040A21
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 20:40:19 +0000 (UTC)
X-CSE-ConnectionGUID: F848C2sARE27zDbcaf6K/w==
X-CSE-MsgGUID: Q2zJJqlYRSuR4rVp70JpmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="88810207"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="88810207"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 13:40:18 -0700
X-CSE-ConnectionGUID: eYTyl+P5SNab78U+dx1tlQ==
X-CSE-MsgGUID: SAE2/s6KR76BJDkj5lmpiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="253202031"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by fmviesa007.fm.intel.com with ESMTP; 16 Jul 2026 13:40:17 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wkSsR-00000000Q3p-1ID9;
 Thu, 16 Jul 2026 20:40:15 +0000
Date: Fri, 17 Jul 2026 04:34:49 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607170428.sYKHRWsz-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784234420; x=1815770420;
 h=date:from:to:subject:message-id;
 bh=Qr+fXGmBU5NaPY4QFIiS5IsZ8A79iexoD8DINDhcO1Q=;
 b=Qkg1eCOdUkQpHYAsNT4vD7YO7g0USOYh7Js+6yrFLOBkamw11ESyWc5Q
 ijpi4QdUBiqOW3d5KeK2qfpT0uk52Nn65CmLseFK5kXaj8Le5LF2NMmN2
 3A+nTz8z8rnA0t6w+4o/K14VF9J5KwS/oXFevfTv3v+G+YfGqxQFYvfc1
 9JzPyfexvjuEE92ereSDIpJ/d7kzsW5+ezccAtoqm9iH19qKxPJDdEv0i
 7mm9mrrdBoZm5XsWSxXNK/L+IPUqZ4p0xb/G3WxgfWxuMXfSE2EnPYvZY
 ytGW3Il/s7MvkcUC0iBd9VFWURtbYaWVFLoikervz+ALpFQWih/mBQ/3l
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Qkg1eCOd
Subject: [Intel-wired-lan] [tnguy-next-queue:40GbE] BUILD SUCCESS
 145defbb9be0462f517383600621c1a4ff3f6cef
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 40GbE
branch HEAD: 145defbb9be0462f517383600621c1a4ff3f6cef  idpf: implement pci error handlers

elapsed time: 1542m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    gcc-16.1.0
arm           allnoconfig    clang-17
arm          allyesconfig    gcc-16.1.0
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon       allnoconfig    clang-24
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-20
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    gcc-16.1.0
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-16.1.0
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
