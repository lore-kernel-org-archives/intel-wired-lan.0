Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECDEC79F8B
	for <intel-wired-lan@archiver.kernel.org>; Sat,  5 Sep 2026 20:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5710E60601;
	Sat,  5 Sep 2026 20:05:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id auytJx-kpCmO; Sat,  5 Sep 2026 20:05:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EFCEE605FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788638707;
	b=FaK6z6I5OJ4cw4zuh+zvpQPoNSDbdizSk1WeJL8FJWdOUR21MSY1Z6+o3OlbwQtIjF++
	 GhvsJzh//pnyIiRnOh6V0Jd4Gqti8x4q7ni0ieFFsfcV53xkdj6DDs4fa0V8gV8lPlH7k
	 A+d6GM37UrblZ+50eLg36er6l/yRlKrvCdtCxosNWviS4wsyJQ7T4kquYMNhX9Z3++g0u
	 6LUufcIhWo/JW2p1lAv4nZncCn71WQP+8hfRw5panN//6kFaENb68Y7x5MLVaeNMc/GPe
	 opkCvmmqLTl1E6THHSdXHLfIF2vvq3JFF87As/rL2UOxQ1C/qwBZyfCktADEtFHRodQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788638707;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Date:From:To:Subject:Message-ID:User-Agent:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ym7CIfQUA3EoJ89yPahFPmctSH0GkLUbBUbKXh4CBQ8=;
	b=D6662YEc/Sa2JNlfZ5ETqWsJH/sirqDhJMqmreiegUKgwT2VPnMwOSsCqd45ykMbPMjI
	 NiN9OTdqgzEDRvLNw/HebxtrWbS8zOk3si4AEdwefIwVgd4lAknz6Fe6SNhamvUPLA9HO
	 haU6a+GNK9AmF9RianyME80/yIia8771spycsH2Uexy2gSKZZNs8wVCUh7zsoZpKhiZWl
	 H6tdGK2Bhg7KWny+g/pNZoEOrEN2PyhnsV1EajmTN+2F7+7raER3UGkcxBp6hxL17Dnma
	 4DV9yOxCgAI7NuJFJSD4SoyCGU6LdwlFa6PG54BtoH1UOtP9vfssBWu+VexX5KYAGGw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788638707;
	bh=ym7CIfQUA3EoJ89yPahFPmctSH0GkLUbBUbKXh4CBQ8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0gXZGR9s37/6dI6ELMkhbnqpWlAIEL2NajXrLZzA/nrqnOKnYvk9IG37lf0KCZ2IG
	 Rynmj1uV2FptFPJG0fp2t7+o3j4K2lXvI3BxTp15darTbMM1OsDeL05lCgsIfXf7jE
	 UKhRFtLPksG0MKWGXQ3kjJaBfLug6+GMAPN7Wl0EXrCstS7J1Ss++IDkstUW/8D2BX
	 8Pwc91nfdKxWieG+uwNEHwZ9btoheOU7j4S0wg4wQN3rLTeE4OA1yDv5I684tq+qZM
	 aBzOr+i9O4UYqJ/Xd9kQMfdxndY/GPlvuzsDiQ0WLwj9z6u0DmRCXBwxF0zSJlXnDL
	 tsYY5ls5UZxlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFCEE605FD;
	Sat,  5 Sep 2026 20:05:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D59C1105
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 20:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7F6440074
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 20:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1RK-IjY7UTmh for <intel-wired-lan@lists.osuosl.org>;
 Sat,  5 Sep 2026 20:05:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C3E8940067
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788638704;
 b=F3vQsapJ8OmhCVaHDUGMv8C5KgnaKnj00nB6WRQIvFQ77L5TFaMo9LxUzYQy0+LxGk69
 IDDR4QwxoQtmFn085PuC4x2pz8PNmMjioIFGdWqaCmfdNNKvnAmdJAfwzRptm4mcjSQQx
 8RVKUpzrnTblqGFssFpbP6fjkAEoctSviFov9YNY+3xTwjFy+729MdH84LuYcQ2Tr9jQX
 NjfRXIvutiMGxd/nI5q82zEkyjkR63AlibrhtizI9xm1b9mbN5QauSGgPh4r+iHJbkKPX
 ATTxOvh0Cb4qefhan7NDma7oDmFC6mBKKsoZRLILaI/cpGOuMTEcrqu8OTuQSpAZ3xQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788638704;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Date:From:To:Subject:
 Message-ID:User-Agent;
 bh=ym7CIfQUA3EoJ89yPahFPmctSH0GkLUbBUbKXh4CBQ8=;
 b=qRVcC2vxH8TWijXXAh+C5KR3xqv8v/QVgb7l2h5ib6rF6/vvmjdKeTpC4zfr/k+VMYxx
 LQ7W2dQvjVEk6Pd8myVgvQzde/nbqw0ZaSdHhWRQcpXaywQ88dAuQnrGPF47x6qHF13cY
 vWl6i4hoTeyuD/fGpnKG1rGT6lNVnBQrtEvK0B2d1atY7G9fcwIKLf+BsVBsx+YARQSGx
 6WVUaaGg2ysiVj2C8Ku9+Vq+BXo/0dJFI7WEUBe6tYbSzSvZQItGs9G6MUeYCixbYORRd
 xdvpROCkLYDYsA8OGQLg83ipScjpVakxneq2a5bPV317hMx0RkdvjN4Y4DAcqDz+/iw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ehtjPKl0; 
 arc=none smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ehtjPKl0
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3E8940067
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 20:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788638704; x=1820174704; h=date:from:to:subject:message-id;
 bh=n4/Ya1EK5uYIJwIVWcnRbRgygMJAaX6WGhRj7vj+1yI=;
 b=ehtjPKl04ewz6Ve1bicCkbssYtpeoFe9HRhtkEwccFk8bQaYbc9RK+UY
 fnXjPqePCXOcz8USWXeIzaqus4JanTXOfXPTSNAx2ItODsQtHM6+4jp31
 YbbMrauWyvHNRYEHJr1aM8f/IoUIo33xgFqjynD4XSbrKqwfEIrxskMdP
 Axu+L0GFeLtnQYQqRzAJ5KNUSWRtmqd49hFUoBZoy6SFiM+5tvftQgzxD
 K524Yy4pNr/459Rg4k7bPYEpZikXmSaSLJYnnKmxEv5yDoBgUAwsKp5pL
 ZRLwKHgZ/S6jAjJRQflEXhL4alQIQjO7wUY0TPaNhmxQkRF+4D55A8rby A==;
X-CSE-ConnectionGUID: EBTLo137Ty+zlkUYylVdbA==
X-CSE-MsgGUID: T4COIK6tTZ+h7avjQzvXCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11897"; a="89028826"
X-IronPort-AV: E=Sophos;i="6.25,264,1779174000"; d="scan'208";a="89028826"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2026 13:05:02 -0700
X-CSE-ConnectionGUID: 2f/dTsuEQwi1diS1EAX+Zw==
X-CSE-MsgGUID: cqLqxQdTRCW7y8YHIiMeEA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 73f3364bc37e) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 05 Sep 2026 13:05:00 -0700
Received: from kbuild by 73f3364bc37e with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x2wdG-0000000013p-0pJ3;
 Sat, 05 Sep 2026 20:04:58 +0000
Date: Sun, 06 Sep 2026 04:04:02 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:main] BUILD SUCCESS
 6ebcf5074cff0402730c6981d2397139fee6322d
Message-ID: <202609060459.sjE4bOXu-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git main
branch HEAD: 6ebcf5074cff0402730c6981d2397139fee6322d  net: openvswitch: don't schedule rebalancing if there are no datapaths

elapsed time: 2322m

configs tested: 55
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
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc       allyesconfig    clang-17
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh           allyesconfig    clang-17
sparc         allnoconfig    clang-24
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
