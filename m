Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BAAC79F9F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 16:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42F3040B32;
	Thu, 10 Sep 2026 16:57:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qmaB4LV6YpHW; Thu, 10 Sep 2026 16:57:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7086D40B33
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789059425;
	b=osObSwhHviWLpxtTVXIo/sjFvvCTtykBejKMmEAULstOrsMrLCoREtw6MPNfmCzRMQ3W
	 wJLwKqkv82G5Ql43jRTpcsP1PgycvK/PgaYpcF/5bZg2MLH0RzEp46RToghBRhEGDuuKb
	 iRtxRCdoe3miHAKcOTjeYI855MuAyDoFf58sl5ez5eHkYQH/ENvU8kayamMb1oe6p9G3C
	 ICmmuLub13PrKSogfZQWp8hMnLBOl0bh8SFpQ2AKV7QGGjhGgOgSHqPIqzYJhWt13KzE5
	 lyJ1P0UI53n4xYvhAl5ZtzlSSYDpWI/bPJib9vdEXZFeHZk3cG1DR1HuCS4tV27RBQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789059425;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Date:From:To:Subject:Message-ID:User-Agent:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Z4TDIRDjLRLO4tQ5/GSvuPgOzYflarRkPf6inIyDkJM=;
	b=BT9lbYq5ieTE6RN4ib0vE50CsNTtuoL8kloPBK2ircyPP5KLtlbGIOwzP6h3TvVOdv5r
	 lw6SEpezN7GWRe0GKoCvAjPSFxuoLOLbPf1+uTGoL4j+6G/9RNp1EhF+fjb1mcnmhWXVP
	 qRxuKhzf6dPMGslZ9jHgKX4d6pLT8349UIZKII82kys1ns2J512SmSUZqGwjalYnYAD9X
	 HgBcuOBwgoDzMeWMbTDxybLPasy2fj0TfdNG8FwAyvghStcYsW6s4/Ir4EA6tkAHbEr5+
	 b9q0S7nDO3gOm1nxFZ059o38DYRjPZwK/KVwrO1pSjbiHBWi5/St836DBEAJeeFf82g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789059425;
	bh=Z4TDIRDjLRLO4tQ5/GSvuPgOzYflarRkPf6inIyDkJM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MVAOJXKs4p5HuJDHv5NtH+P4+3M3c6g5rRucPANIShMtMNwkWsSC0zZITGycM6KLb
	 qe+rrL/OIttaDakST1L1RjMvODao0I8n1CNToGnDIDeRvwBx8qkTz+s9JRNMXAqLAp
	 Cm1SK4hE51Txws5ho1fxXUgUcAGvFpsfbBWgzdI2D6x3oRHUbHptetx4TGYNJeJYHS
	 4WjpjZunNNGgR1W5cQYCZQEhmOIoux3diOS589j+wwV0Un+2mrmCTSxW3w4IhwCHmY
	 Y8BJ55uK7/jIQpfLB67hZjJVXXGrCTjguSwgbdegk8/b3zpAp7FSLp3e4hNYmVA9bR
	 f0c2Xi8awDU+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7086D40B33;
	Thu, 10 Sep 2026 16:57:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09240268
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 16:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06ED860B7B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 16:57:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9aS_pHW9qsi for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 16:57:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E5B7F60BA5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789059423;
 b=dgGcpTW+oPY3CgjD6ymvpm3oe5l3WpNJLE8qLqTlp8H+4tNDtUCTwwBmo4m6/7V/cN4S
 SDr5SmGAYt6qoLmjnixb/uAQv6cw+UBfoNUInol2plnS+fN80GNB0ChyDdlIAEAF5a3xV
 Ra+wfreYfO4R3UVw+CXMSbg/Zuh6nsUBFNKis72SODXi0IbfMhXeonmg+bmJHPyL3RXrH
 mnVtAFx/B9RHuvnPzFoEDQ+AduoSc/W3NEEzRh4rwp5LTGnHdRcILrBnvmvuy6V/iOWeh
 Vmt088LuTFv7qSRjTQp7Cyab7ThzAbDWZnaCRJqQ9bXeUBAPtQ5L82R70lJMhBybzlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789059423;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Date:From:To:Subject:
 Message-ID:User-Agent;
 bh=Z4TDIRDjLRLO4tQ5/GSvuPgOzYflarRkPf6inIyDkJM=;
 b=HbTLlCPp6txvfg1nLKDp8abwhXCQfW9XBU9Db2Jjb/qFS9kMIOg7Xc2M5vCIn0bEi1Ym
 x83Sri1BoMepLhnqQOStfJEfiu+V60KKhNm/2tbZC0o1xWB4m+uIXxZzatm+EKr6Nh7Ov
 +CGhYtbW/bTjGMp9FU2+Zff5UIUu2njIoM92mFQKDP43bq9Nwm3v3VMKdZJZT78xzamn4
 mifO7BABE036zZ8BwUMAOd+7nde02zU3JadzTMAA36XnwhboKhNxNPL1reBlUUsYuGP5h
 Os8m93TOLWQ0r32PtCmmfu98mZWXUN034//bPcndbOAwteURH58IarJ1hP0XYFVlNvw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YjaSjgQf; 
 arc=none smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YjaSjgQf
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E5B7F60BA5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 16:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789059423; x=1820595423; h=date:from:to:subject:message-id;
 bh=nkBPGyvR82iR7NJ22PIk8pGrhlitSaTlqlka9t0Qfls=;
 b=YjaSjgQfm3zoIflK19TZi2tZTxCNVOgyOhkeBmJgZGYzx8l3CDJB4AbE
 /ziwG2t0k++MsqJc/KJ1ibIJSBzhMyXej2rBIRgWAnyRDHC1tE5EDcRvg
 0gWdkLYk97eyCKE3ejWF7t0LtiTRJBthinJL3Tg42UyPgc8EmLqif3hYy
 6ryQR9J75VNUyIexagKvzVyyWQWujCzMI8VFg8miKz3dVLKZUIPdEQc7n
 wBwWNh2vIfjwdkOMoBddow+RBXQu40vdbQBtBo/EwR8246HNGfwYnj8oZ
 jHmsnbeFJMAk0vWB4a2xeoE04PHjIV/2+dHXdIYTUBoMQOsNt9zkr01Zi Q==;
X-CSE-ConnectionGUID: rUfmUD8/Qwu12xV1l1+h/g==
X-CSE-MsgGUID: RNN7ZGs3SrqlU+RhQoLgRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100681081"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="100681081"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 09:57:01 -0700
X-CSE-ConnectionGUID: jOjuWiyLQMmie8pdB9Kfpw==
X-CSE-MsgGUID: eWLYgfbeTLOLPM4jMq/s+Q==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
 by fmviesa003.fm.intel.com with ESMTP; 10 Sep 2026 09:57:00 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x4i53-000000000L2-13h0;
 Thu, 10 Sep 2026 16:56:57 +0000
Date: Fri, 11 Sep 2026 00:49:51 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 369f5014279095f2c4b399b163758f928c89de69
Message-ID: <202609110046.Pwz2G8uV-lkp@intel.com>
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
branch HEAD: 369f5014279095f2c4b399b163758f928c89de69  ixgbe: fix MDIO bus lifetime

elapsed time: 1326m

configs tested: 67
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha          allnoconfig    gcc-16.1.0
alpha         allyesconfig    gcc-16.1.0
arc           allmodconfig    clang-24
arc            allnoconfig    gcc-16.1.0
arc           allyesconfig    clang-24
arc           allyesconfig    gcc-16.1.0
arm            allnoconfig    gcc-16.1.0
arm           allyesconfig    clang-24
arm64         allmodconfig    clang-24
arm64          allnoconfig    gcc-16.1.0
csky          allmodconfig    gcc-16.1.0
csky           allnoconfig    gcc-16.1.0
hexagon       allmodconfig    clang-24
hexagon       allmodconfig    gcc-16.1.0
hexagon        allnoconfig    gcc-16.1.0
i386          allmodconfig    clang-22
i386          allmodconfig    gcc-14
i386           allnoconfig    gcc-16.1.0
i386          allyesconfig    clang-22
i386          allyesconfig    gcc-14
loongarch     allmodconfig    clang-19
loongarch     allmodconfig    clang-24
loongarch      allnoconfig    gcc-16.1.0
m68k          allmodconfig    gcc-16.1.0
m68k           allnoconfig    gcc-16.1.0
m68k          allyesconfig    clang-24
microblaze     allnoconfig    gcc-16.1.0
microblaze    allyesconfig    gcc-16.1.0
mips          allmodconfig    gcc-16.1.0
mips           allnoconfig    gcc-16.1.0
mips          allyesconfig    gcc-16.1.0
nios2         allmodconfig    clang-20
nios2          allnoconfig    clang-24
openrisc      allmodconfig    clang-20
openrisc       allnoconfig    clang-24
parisc        allmodconfig    gcc-16.1.0
parisc         allnoconfig    clang-24
parisc        allyesconfig    clang-17
parisc        allyesconfig    gcc-16.1.0
powerpc       allmodconfig    gcc-16.1.0
powerpc        allnoconfig    clang-24
riscv         allmodconfig    clang-24
riscv          allnoconfig    clang-24
riscv         allyesconfig    clang-24
s390          allmodconfig    clang-17
s390          allmodconfig    clang-24
s390           allnoconfig    clang-24
s390          allyesconfig    gcc-16.1.0
sh            allmodconfig    gcc-16.1.0
sh             allnoconfig    clang-24
sh            allyesconfig    clang-17
sh            allyesconfig    gcc-16.1.0
sparc          allnoconfig    clang-24
sparc64       allmodconfig    clang-20
um            allmodconfig    clang-17
um             allnoconfig    clang-24
um            allyesconfig    gcc-14
um            allyesconfig    gcc-16.1.0
x86_64        allmodconfig    clang-22
x86_64         allnoconfig    clang-24
x86_64        allyesconfig    clang-22
x86_64        rhel-9.4-bpf    gcc-14
x86_64      rhel-9.4-kunit    gcc-14
x86_64        rhel-9.4-ltp    gcc-14
x86_64       rhel-9.4-rust    clang-22
xtensa         allnoconfig    clang-24
xtensa        allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
