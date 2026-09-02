Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E08C624D4
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 18:45:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90B7B40CF7;
	Wed,  2 Sep 2026 18:45:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QwuuVUDH_o-d; Wed,  2 Sep 2026 18:45:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B515440D01
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788374752;
	b=GRCqMPtQkToTTrZGV7oFCEoKcCoA+7gqAfWopEoxg6niuN7HABR7FehID0uRHI6pyd//
	 a/GBaIz8BdihpqfpFEhjRbaPJPg+12z7w7uT4F2LvcxBoUxWFshyy5IqIuRlYP64Yr+BY
	 Z03JBLKp3qFRxYnfpBoCWPFZbwZz/JGpwoDfof1jIFGOSOq/a+ZbfUJspQmgddn8gBSUe
	 tBs9XrRcN6HRPcA0HBCZ5Mof+ZSiqHgZzqlGUxS+HTCNHHkFePYC56RGS/RaqrDFH94pV
	 ol7Jt6nLHWzklzh8ZngGgkm1Omr7cHWMGrGs0zuEgPKaW5NkuR62TaeM0vLvNhvx7Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788374752;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=bxiicsu1+tIEK/oP4uZMS4rPusPafxG+h/gE4fN39bs=;
	b=LBlRh0V10r9BeD9jYfTqw/c68uYq14Zu2UNtmG6iXd/tikJp9MI+XcM+bzscId7o5dAo
	 n9gpE1c0iubME1pMWAEIHVVkz3L/jS4cc/A4+4INurn3GzWAYUcjJceLLrJopSfIEDR8X
	 Uv281hzsOMNRKwroHyCjE5pwGWIcXdHRA2UvPKBs4QSy3R74xIfntoad0mOyqFAY3zzXY
	 kzimT0R9Dqcoq9R+VlbygyMpCw1G04I9g87D8353IlHkCNLa6MbCjP8XnIRusLS2H9fBA
	 UgcwBIOSV/ZecSaDpwRO58nFdELEM/xXNZi1JyZCtl1UEG2VQ+AigB1XXxVK2XgbeBg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788374752;
	bh=bxiicsu1+tIEK/oP4uZMS4rPusPafxG+h/gE4fN39bs=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Psb2APamtNlMRP54rQa3jwt779AtQ+uhkumd8qDpEpNtJFJiHZwvSriRnAn+kUuA9
	 16R0xUPdDI6ioEuwh+jXjpUGkLcayNpbTR/i6ipejAPBNjOKRUGF4vw1V505OoHcTC
	 aePG9DS4gi4TObabyH4enaqoc8ovKFXb91TWPUh+wedzIMwIuldjaZnjrchwNMlqjC
	 g/ZjkicpW0B95PJ+Va+drX2DTReTiMImfpXseQ5BXyKVKk9IolsrmDBbLoTVSs+asn
	 s5rD4OISMfR38/V2u3oWkIOajetKJDQrKd+aTEXJZ+LLPMyMFmKUrzSgrqA4/9odFj
	 c3Em2/VKCkN8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B515440D01;
	Wed,  2 Sep 2026 18:45:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B31E02B2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 18:45:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A53B140177
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 18:45:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZdwE0mF4RA0 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 18:45:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B2C8B40158
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788374749;
 b=iklW/5JoFitBg0Jhz1mLF5LgacQLOHAWik3wceWfZxGqKnWt1MJEBxw9D/JW9+cKYxzq
 95lVfbelNywOa2FMYf0ES8O9/jFu6BvUAS9sQDwzUOBCzQcvzsdUfGWbOFZHMRmGMBb5B
 O4zD7y0bKmYSF0zm35ynP4kMJgL3xZC8AerV2ktXYrjcqY/qDfqi1EjpxJItttl1hdmIS
 vxOgKAA4NlxshdLWQ+Bg5lcKNFYpVfWwFrcr0xlj3Gk5g25ZToLuzxwkwTEqXhR47ddjd
 lohMKZrIFrnxAc9xRGME9we+u69cxapq74gcEtS7EmAAIcsNaL8XV9mEaWYxFjsSGUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788374749;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=bxiicsu1+tIEK/oP4uZMS4rPusPafxG+h/gE4fN39bs=;
 b=gKSqx9Dx9tY+U60naltIrpVKhp3EGUr3mZoVt9dd46jJxAouvVGeAAKFvdr/jSeeB6JR
 MCnl30HJZuG8YjOTx4YtnZClDwogKs01CQaLUuajfXWdGb4qkiHPqfCYb6GU+DK4DBDKd
 ED4Eg7C0rp4lJVoILLpTpn0bYZrA8wdbBSGGgKmi1El6FCOHJ1SK2UHIdaHTjePeLpl4t
 +n+w91QW+XIjdMR0eg+sEuMBloAsCbdNpuKFqlb2w0hdnLrGn0m9+NJekgSuXX2wVfDot
 gEs6hXkhR1WbHq3z8DroHx7Sp6b+MoEgjlhLtTnA1H3cBEVKpOlu8LBAWkQcCzoZL4g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=idQEjSan; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=idQEjSan
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2C8B40158
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 18:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788374750; x=1819910750; h=date:from:to:subject:message-id;
 bh=dHbGLS6guDysgdghq3+KZdSLTy0M7Ex1v9FzszfHzII=;
 b=idQEjSanqF7nWoc30AWeB4lnhY2zPsxh72t9pUJe5iuCpM4VehhPoqNW
 cdACt+h6T2/iIZ2zs00ktAbJ80z7g0yjRbNZPYnHuQM5cl2oksMw89zhH
 PW2FCgFoFHyygzRqNtVF25dbUjKRjhM7A4OQ1qNRTNvh1H8GlxjbJ9P3B
 nlI/H8cZlnBXC1mPsGMnrlASewP99xNkwGZ+nbYjYLYQgVMA7hSBE3eAT
 XHEvRv17Us84OpiQlC1nPD5j3L1jrx4E/m32v69qfXFfkkJJPjjWRe9/w
 2tEyJP4/KnlnkJUMrxcSbwQLV2jMjzjLBK+PCZUGie1cN/m8XbQZ/Hqsn w==;
X-CSE-ConnectionGUID: gHcW4s8fST6Oj47BOZTKeA==
X-CSE-MsgGUID: lUGikSYTRSOrDn8xEt6U2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100359287"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="100359287"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 11:45:49 -0700
X-CSE-ConnectionGUID: mFfis6MPStyMJv57A8rN/g==
X-CSE-MsgGUID: l5EFLe/gQg2P7v/PpuDVgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="265176236"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
 by fmviesa006.fm.intel.com with ESMTP; 02 Sep 2026 11:45:47 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x1pxx-0000000039e-0da0;
 Wed, 02 Sep 2026 18:45:45 +0000
Date: Thu, 03 Sep 2026 02:45:19 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:10GbE] BUILD SUCCESS
 c8ea08ba34f2a2e9bfb18ff3d69eb2d69b324f49
Message-ID: <202609030203.NDVsLaQC-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
branch HEAD: c8ea08ba34f2a2e9bfb18ff3d69eb2d69b324f49  Merge branch 'netlink-specs-rt-link-ipv6-devconf-updates'

elapsed time: 1744m

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
