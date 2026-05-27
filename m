Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC88ECD4F54
	for <intel-wired-lan@archiver.kernel.org>; Wed, 27 May 2026 20:41:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92AD6844FC;
	Wed, 27 May 2026 20:41:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KQhFF5nt8t6C; Wed, 27 May 2026 20:41:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CBF7A844FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779914511;
	bh=7icoN/ddCMVVrsrbT/ZIHDOx/o00s5OYNhjcIPLxewY=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Omb7XX1Y7kjOTnISmoOccgSJQweFyz1+BuA4zU90xzwglgA38YaFpSQTDtAufP+yo
	 fP21NqZ3sE0i6+JVckBw1s1JB5XL/UiRrHs/djJbNzbvos7+EJhBvdjxo0+DlPUwxF
	 Gk1SZoRYwVXWRKtE9mRo9R0penYont463AxWuEkN6bsQXDys/9fhswRZG+yUvRe/Wj
	 uzDLh7TCIaWTTAndN5UfD0yZwk7bLI/Dyt/jOrDw6MJma787bS0G72kw8dFC+9RC9p
	 tLqvYadFdC6Bs5LIpridgbEEbccA3ruSrBdtYZ2BJ8JZE4Csf5aqrAB6EDB4Jn4dN3
	 gJQa6BLVZvMsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBF7A844FB;
	Wed, 27 May 2026 20:41:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C6450290
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 May 2026 20:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7462844F9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 May 2026 20:41:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qrxpTLcO--Zc for <intel-wired-lan@lists.osuosl.org>;
 Wed, 27 May 2026 20:41:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C24A5844FB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C24A5844FB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C24A5844FB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 May 2026 20:41:48 +0000 (UTC)
X-CSE-ConnectionGUID: RoHLIyw+Tya/rDAeH7wv/w==
X-CSE-MsgGUID: M+X3/PnJR3CjntVqKw/CWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="68287271"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; d="scan'208";a="68287271"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 13:41:48 -0700
X-CSE-ConnectionGUID: mgVWCrxmQRyKlbNDO5uehQ==
X-CSE-MsgGUID: 0/M5UEd1QrOyX3/SPMjtdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; d="scan'208";a="238167462"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
 by fmviesa010.fm.intel.com with ESMTP; 27 May 2026 13:41:47 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wSL4S-000000004RG-44pd;
 Wed, 27 May 2026 20:41:44 +0000
Date: Thu, 28 May 2026 04:41:09 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202605280401.GMoHSL1J-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779914509; x=1811450509;
 h=date:from:to:subject:message-id;
 bh=ZjNIxcU9yEA6abElXFQ1NW4NUOei4toui43bAzPHN+Q=;
 b=ZADvLkncXnEfK6zo5oqrFjRysSIGAmUBa7Q7Bz7Hfd7ADtVne4I0jw0O
 3yLfISdPYB/xs6TzHMUPt99nhXTYNZkPrxTtLJXklZAKV7ms7NN1lGlHH
 wB0Uhyf0m79AmaCyat0+DIROX2BfvRS+9NpVIxNpMkM7SlkFMOBsavMuq
 jQOx4o4WnL4QVmtLTZjUBdN0gSmhzVJukD07KuLiYPFs6Phnoyi7Y4LFX
 2LpMwKjqk0zneoDnLq5n08YJwxXb/+FxLRZDG4tanXFmHIBu2A+FdG22r
 T1eu3qHXpJ3AJmgviCjHJkPgczlU7HqqpTEmOJkGv3C77s7k9Cqw/uPkx
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZADvLknc
Subject: [Intel-wired-lan] [tnguy-next-queue:main] BUILD SUCCESS
 18b9f739d3f292925ca7f67ad63f3a4c0bbfad3d
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git main
branch HEAD: 18b9f739d3f292925ca7f67ad63f3a4c0bbfad3d  s390/ism: Drop superfluous zeros in pci_device_id array

elapsed time: 1715m

configs tested: 55
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-23
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-23
um           allmodconfig    clang-19
um            allnoconfig    clang-23
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0
xtensa       allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
