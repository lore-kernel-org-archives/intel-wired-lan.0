Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB41C79F9E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 21:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5310404F4;
	Mon,  7 Sep 2026 21:50:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7BFZ-iuWTXyg; Mon,  7 Sep 2026 21:50:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F1597404F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788817846;
	b=BbJ7YqnZXLZeLCtIrUqOjto9obZPZgjkNTJS5aHbUx67VMLB3b2KAOBmz/wK338kib6j
	 Lejrnf6V8GK3ou3BZgBRnlPSqxIujBHrBOB6r5zsHcEYCnQ8VEXR+0KhfZpiuixwGpwMo
	 Vgu0jmfD/T6rlays6rFQuTWBur775Fe1HRzsFe/Es88nC1WSr+0RIXAEJ2Jkg0OB0fsxx
	 8cCq1tL0VIciCpfobPDkK45cjI6TkNE+IHoCVHyO/sj2smMmssUMuGaVIa4LK+2D23lzV
	 JPc/umwO4IhNpCSireCqn+tisZ5pyaffXcU9sDaA4tu5FyvAi8KQAzHKi8H+oeiFlWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788817846;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GWdSwZhsTx9XMZrs6zM+dsHClKQjBIDcqTdaHZKZ0qk=;
	b=jbYDWlJZeO/cZPeFhiv1VhtZMFcW9j3I0sEzAnrplvSGE55bAysV8KNzlQc4trL9FlBH
	 p+IyQBt4/mffWVYuBQw525Oq0CnnMfuOSGxKp8uPGDYaRjvKAewF2FzTmBiI364+a800c
	 Ze/18c492yrCpX6DWWP+IupYyenjkxU3jqiJSo4hTtdgNrRs1twcL/MxcphOlkGl9E7vP
	 h3Kqga7vBQtkY+ZSNElSnFdkFcl/dxayT5SjYLd7VkWE4kmWJitvbDRSHb2Vg+ct2bssz
	 JwG7J1vftiGyYfcifPVUd1eC3FmBF0oLEDd3iL/SOVVIQrnRwS10TEQ6BDGURTl2GCg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BY3929vN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788817846;
	bh=GWdSwZhsTx9XMZrs6zM+dsHClKQjBIDcqTdaHZKZ0qk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S3PPvluBm710jkcjno2TdhphddFQMHVu6LPh2czJLai3la+6X8SKkq7eSgDIr+llY
	 EdDkXQNoZRYkjOpBoGO4eX1k3MvK/2RliWDrtjtyIb3uCeMlpw8RavT4gqgkAKc669
	 mtftMT795HCnNJDHIPUudBYeHPOx8W/Ru7LZCOZOybT4YSputCKeebtVHwN+MMO4x3
	 fqHDqhpTqt63NN3edQcjAcSlT8va84GGB43ZDIKabMzIIWMGSbN5Eu3Rs5+RCQPKu8
	 H3J5ahd5qV3UhRyZeqmkulKeVWH2WD+PBKz0zwu0h6g5NKAMENmmG0EqQWmJ+BUkR5
	 OrTZt5eMlJcFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1597404F8;
	Mon,  7 Sep 2026 21:50:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 32E3B49D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 10269404F8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eera_7Wome76 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 21:50:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 75FDD404F4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788817843;
 b=GnZP8MBhHtRf/XhmXeiqszlRnHVFkvq9H2y+LL2CWk9ubYbQJXKuYvldnvOM+rVAabcf
 APrUYRQ07YGF2djBwTWPgj33ezp1JMHCloh2aPHymM28qQP5lY/p6+G8tObGWJ1gXy+vQ
 ugQo20r9sWCgEM7lM4tfWLBt28IkiLqxHKTi1KHWAKpUGON98+u/BYlROoclsQDGYSbEO
 jZuvBw7dPi/6RGBXIcLTyFF40vPrfBoK9v6qAwp5t6kqRCXYY2KnOIicSrYJt7EcBM5To
 fuCkVvzyKhQ14vAQVfxEPCfwi7kfSlIVc231DEIXMrqEDDh4A6vfhnFSmnt6Kdsb2tA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788817843;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=GWdSwZhsTx9XMZrs6zM+dsHClKQjBIDcqTdaHZKZ0qk=;
 b=fM5F29alpg6JKcw1pBUFUW8dHoIJHhf3OyE12yobpNCdLAjC4ZNlCJ5vcBiHGPeTyBtL
 3rkgWzduEg06gCAUDhj3fFZae+X9To5Qhnc29nS3m9DwBJ8fJpPbcdaGVthAekL8V9elT
 W2tgTNzxXvMWCjHW9ixX9wcRHg334dVF+aYRyu2LHjlOqfb5Cj+l1J0BVH46kzfVFZHh7
 sKoKZpcZyw59STeS2MKNr95n2CvQ4PwNC0+RN6F4mJseHMKN5mFraR5I6El51jSwIdCOR
 1907Mf5HnjnMvGC5DgKkhYirkb+E87XixliNcY5xbA5lmT/v8FdstKefgsabM3tw9Kg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BY3929vN; 
 arc=none smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BY3929vN
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75FDD404F4
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788817843; x=1820353843; h=date:from:to:subject:message-id;
 bh=Wbm+urIklXMJ1qixHsV9YF6RayaMgrRNCvPIhvEhGoY=;
 b=BY3929vN7aWGobqg7hGfRhMeXnXS90NJyjcUk97k6RUGwJW47CmKOJ6u
 4l84CIHXRV1ZzkVdXZTgXpL1EkTCTJrYUfr96G09Hp0033SCk2hAA95lc
 Gr+IUthA3xuPe+B697YISROkb1CMo40fWQSYTQc5EocNYmiMwksntRD2M
 e5LzM43HY3moS9AS15DnisEXbF/C5iINzzZ3HNSSTjnqdnF1bBOhiS3hr
 i+fYygJSZan19U5b1mE3fPuNoE7M5K7d5lfJvmxgZt40DR0RzrJk/Io0Y
 b6d7L27psnjl8Y3aTahBpfJQwXP11soSIF4K+MMM58rfuflu76lptipEO Q==;
X-CSE-ConnectionGUID: jLXegSgXQjii3UAZqqoktQ==
X-CSE-MsgGUID: 6G+bkReDTSyiva9Bd8hgZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99876030"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="99876030"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 14:50:42 -0700
X-CSE-ConnectionGUID: +OTkxbEQQZ2P6iSDax1xcA==
X-CSE-MsgGUID: yIc4PVMDQ62UlK2ybXBxCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="276075663"
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
 by fmviesa005.fm.intel.com with ESMTP; 07 Sep 2026 14:50:41 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x3hEc-000000001LR-1LRm;
 Mon, 07 Sep 2026 21:50:38 +0000
Date: Tue, 08 Sep 2026 05:50:10 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 7561dab9b6b34c34dc4ed32e5e4e6be263a6e03b
Message-ID: <202609080508.52Yi5213-lkp@intel.com>
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
branch HEAD: 7561dab9b6b34c34dc4ed32e5e4e6be263a6e03b  iavf: add missing PTP adjustment callbacks

elapsed time: 4538m

configs tested: 67
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allnoconfig    gcc-16.1.0
alpha       allyesconfig    gcc-16.1.0
arc         allmodconfig    clang-24
arc          allnoconfig    gcc-16.1.0
arc         allyesconfig    gcc-16.1.0
arm          allnoconfig    clang-17
arm          allnoconfig    gcc-16.1.0
arm         allyesconfig    clang-24
arm64       allmodconfig    clang-24
arm64        allnoconfig    gcc-16.1.0
csky        allmodconfig    gcc-16.1.0
csky         allnoconfig    gcc-16.1.0
hexagon     allmodconfig    clang-24
hexagon     allmodconfig    gcc-16.1.0
hexagon      allnoconfig    clang-24
hexagon      allnoconfig    gcc-16.1.0
i386         allnoconfig    gcc-14
i386         allnoconfig    gcc-16.1.0
loongarch   allmodconfig    clang-19
loongarch    allnoconfig    clang-20
loongarch    allnoconfig    gcc-16.1.0
m68k        allmodconfig    gcc-16.1.0
m68k         allnoconfig    gcc-16.1.0
m68k        allyesconfig    clang-24
m68k        allyesconfig    gcc-16.1.0
microblaze   allnoconfig    gcc-16.1.0
microblaze  allyesconfig    gcc-16.1.0
mips        allmodconfig    gcc-16.1.0
mips         allnoconfig    gcc-16.1.0
mips        allyesconfig    gcc-16.1.0
nios2       allmodconfig    clang-20
nios2        allnoconfig    clang-24
nios2        allnoconfig    gcc-11.5.0
openrisc    allmodconfig    clang-20
openrisc     allnoconfig    clang-24
openrisc     allnoconfig    gcc-16.1.0
parisc      allmodconfig    gcc-16.1.0
parisc       allnoconfig    clang-24
parisc       allnoconfig    gcc-16.1.0
parisc      allyesconfig    gcc-16.1.0
powerpc     allmodconfig    gcc-16.1.0
powerpc      allnoconfig    clang-24
powerpc      allnoconfig    gcc-16.1.0
riscv       allmodconfig    clang-24
riscv        allnoconfig    clang-24
riscv        allnoconfig    gcc-16.1.0
riscv       allyesconfig    clang-24
s390        allmodconfig    clang-24
s390         allnoconfig    clang-24
s390        allyesconfig    gcc-16.1.0
sh          allmodconfig    gcc-16.1.0
sh           allnoconfig    clang-24
sh           allnoconfig    gcc-16.1.0
sh          allyesconfig    gcc-16.1.0
sparc        allnoconfig    clang-24
sparc        allnoconfig    gcc-16.1.0
sparc64     allmodconfig    clang-20
um          allmodconfig    clang-17
um           allnoconfig    clang-17
um           allnoconfig    clang-24
um          allyesconfig    gcc-14
um          allyesconfig    gcc-16.1.0
x86_64       allnoconfig    clang-22
x86_64       allnoconfig    clang-24
xtensa       allnoconfig    clang-24
xtensa       allnoconfig    gcc-16.1.0
xtensa      allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
