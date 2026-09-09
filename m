Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A949C79FBF
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Sep 2026 17:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B1A1607CB;
	Wed,  9 Sep 2026 17:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iPO3_N2NGERr; Wed,  9 Sep 2026 17:03:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3E14C607C5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788973400;
	b=JIRdLY0aXLlLmo0+beJiNkG7itxWgWTwBPT6I/MggKtioTwH6+9u0pYWuL4xlThGOurB
	 wfucmrdPRdR8gZNOCLqvpU2YZarlA/9k4ZK1NFqLA/+Pdiu3HDLLQNAa2w0yZwkl4a7Ig
	 LHxKsbRL+nSlGiS7/3SkJrIQ7O2VeeDHuOjtmL8dLFH6Gh+KdhTQoSX/LJ860McMhUYpj
	 4ZYo7JGn+rQsLTSjvvylvxHFApDZ3zczrOzOuGh9vk2zPlFK1wNIwt/X/fAHqi9y+nBcs
	 TgUXtLgDI7Yh9Ia5ChzuKq6eTaOIN/ZJUZmBqHAVX41beWYGiH11GwRNnIHMLG73TQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788973400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IZN0qz0B8VU1f6kCKA8NYDMeQa/kyVvQA2BIQSlPfA4=;
	b=PvLHi8AKe5T7kEJnE2NZBPXFKN9VEWwK64K8N0bmrNWwxNw2QDFns9ZkWbEZURnltLui
	 71h9UgNCpI+byDMuj8JQ4p9BV7h1eTW3ka1VMSoIK59UuD71vGCOk8/eJasMzlUJJmUix
	 mhjcG5UmMx2VuSQxrO9XYBAtn5OTeui8mwOE2FW2Rr3Abz8giIq2N9vr6TlhMl7I6BKM4
	 LoaGnHDwBowdFqYOX/5JV/ObJqByJRWD7RIz1djys4BPRwmx0pkDUKujBuOOF+9CILFpC
	 BPvnUsVzC0UfYptQY4Jnt6fc8+fpBKD/BaxGxKrIdn6okKKhy3j35F9FDu2WHqW/nTg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788973400;
	bh=IZN0qz0B8VU1f6kCKA8NYDMeQa/kyVvQA2BIQSlPfA4=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BQpyb3Ny4c/UOeFEczhNwMg2ZuzSe/zYxmtnpSiD5mBTPni4skIsCcCrJt5K2vC+c
	 qcxd0DYuwxb421+UQtvreQnocZFKjEUKnC/L/lkG0mZR2Idet1RqSFUKxsG5pJP9Bp
	 fCsyJDK2Dji0HrRFi8Uqi3IGu8DeNOI4/nW/4jPHVJPP6ZaWKk7nTK+MCQwcSFssQv
	 X4KpT586uTg7B/u8gijuSEYLUQugx1atUPNKncuj4UwfTAfkrzh5/Ug64G0kO1BJ9G
	 JoK7VmQR8QkZClpBn4v/tjQtfz3BhWMJwDMhtF8TryQMZ/IhYhqfgpvArjnaCdwx6d
	 NXu7w67M6MaWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E14C607C5;
	Wed,  9 Sep 2026 17:03:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 592A0268
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 17:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A400407B7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 17:03:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y5fhg_2mQRrY for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Sep 2026 17:03:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B0EBA407B8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788973398;
 b=V2l1xgJh66Bk1Zk6Cjr0AXoLLS8TL0PsP1Y1Ow7BRdrMQ0ayc3P5o4elGJ71Mp1H4awB
 Ms3QCiNjwl367KjqTw88gihzxYNSgq9Iz5eJAdFatMAy49Z966zO+v7337bo847Il2NyB
 E1WYv8RZ+tkMKMsstO4rIHThUutzHe0UoqMuOOefVoG5cY0xk6hFplPXfgQTDnEeCcZnn
 aPT2nFQl4g9376z0ApsGSLgUIbUlr/zNEh+5PeJ6+DvcoGvWe0ONibO3gp7qoT8h8A7nI
 iA773Pv2nurTMY8znL7OSiKno5VaHtK5RXPP6yRqwSAAt3I3QhfAoacg8XfVNIsbJMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788973398;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=IZN0qz0B8VU1f6kCKA8NYDMeQa/kyVvQA2BIQSlPfA4=;
 b=Qt7gokmqXwAtAQpg//9gswq5KWZuuVLpgUEMUjfhZjsNlAIonqiKcB+Djw/XHZJ6f9xq
 tY6zNeQ+hW/Fhi2DGr6rLRD1vB04q30HAzc0T6PwUV9zgX812X19F/CjKodVJ2sdMPExZ
 iAvpbf70SlcUBlLDdb9obLmE+eLmKMR/xqXuE4rcbWEkMbFz6KHkQY3c7Aq+yjQ7F/S9e
 dbK7qqzRm2nBOXg7hT5XTTQhaRU8dUruNE0Qp62EnjuRZVZkBVukJtQMs/RhBNe2eR18D
 r7klZdaHykkDlFyp8xJyhrxftCOt8/Bq5mNkRuhMfmdrSfEHMSfXQ9Lzbb0sQIVhC+Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gLlUJ+QO; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gLlUJ+QO
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B0EBA407B8
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 17:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788973398; x=1820509398; h=date:from:to:subject:message-id;
 bh=zhR+4E3ki28Dl9cKEarzrcuny91dkbeXI2Ps7uDuyZE=;
 b=gLlUJ+QOc+bl3JdOtTrmzILeCNfDoZY42zviHuH806+MCL+MYaxT+dKV
 HIB/TBy87LehiB46/I1KGQvHtSBjk6xAgxTdy1W3vm9qS1ND/VVbRH4AE
 akZZWd0s/fGuuWVLtrXxfJrhSXTyiYC6WTtye8SYfLv8Ln0KoaOhWyGm0
 X/Pgspw4aQbc59aEs66CDfd3iIZGx9KYJ2XrRMyon1pvojFvLpZ1tf6ly
 yLXdrqCkzBmovud5Rqy5u7RulRAYGmSdSfPMduoQj50Sqfrf/gWzEd+sD
 WW7JVQtmWFD87jfPJGW5Pdybxyf9xAseEiVB/Vkxw/Mht169cN30efAVS w==;
X-CSE-ConnectionGUID: MgoO5A1oQaq3UAl6Te+yug==
X-CSE-MsgGUID: TZSc5gAsQTaTMb1viErGMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93275179"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="93275179"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 10:03:17 -0700
X-CSE-ConnectionGUID: LKMme4jqTBGMFr7pKwR2Fw==
X-CSE-MsgGUID: cteaEE8sSJWiqMRH0+kXgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="267085189"
Received: from lkp-server01.sh.intel.com (HELO a3e91e2cf319) ([10.239.97.150])
 by fmviesa006.fm.intel.com with ESMTP; 09 Sep 2026 10:03:15 -0700
Received: from kbuild by a3e91e2cf319 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x4LhZ-000000000ez-1Orf;
 Wed, 09 Sep 2026 17:03:13 +0000
Date: Thu, 10 Sep 2026 01:02:23 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 46cd38dd9ad34dcff3acf363a2a74942d480d7da
Message-ID: <202609100120.OjAxqX2Y-lkp@intel.com>
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
branch HEAD: 46cd38dd9ad34dcff3acf363a2a74942d480d7da  iavf: add missing PTP adjustment callbacks

elapsed time: 1489m

configs tested: 50
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allnoconfig    gcc-16.1.0
alpha       allyesconfig    gcc-16.1.0
arc         allmodconfig    gcc-16.1.0
arc          allnoconfig    gcc-16.1.0
arc         allyesconfig    gcc-16.1.0
arm          allnoconfig    clang-17
arm         allyesconfig    gcc-16.1.0
arm64       allmodconfig    clang-24
arm64        allnoconfig    gcc-16.1.0
csky        allmodconfig    gcc-16.1.0
csky         allnoconfig    gcc-16.1.0
hexagon     allmodconfig    clang-24
hexagon      allnoconfig    clang-24
i386         allnoconfig    gcc-14
loongarch   allmodconfig    clang-19
loongarch    allnoconfig    clang-20
m68k        allmodconfig    gcc-16.1.0
m68k         allnoconfig    gcc-16.1.0
m68k        allyesconfig    gcc-16.1.0
microblaze   allnoconfig    gcc-16.1.0
microblaze  allyesconfig    gcc-16.1.0
mips        allmodconfig    gcc-16.1.0
mips         allnoconfig    gcc-16.1.0
mips        allyesconfig    gcc-16.1.0
nios2       allmodconfig    gcc-11.5.0
nios2        allnoconfig    gcc-11.5.0
openrisc    allmodconfig    gcc-16.1.0
openrisc     allnoconfig    gcc-16.1.0
parisc      allmodconfig    gcc-16.1.0
parisc       allnoconfig    gcc-16.1.0
parisc      allyesconfig    gcc-16.1.0
powerpc     allmodconfig    gcc-16.1.0
powerpc      allnoconfig    gcc-16.1.0
riscv       allmodconfig    clang-24
riscv        allnoconfig    gcc-16.1.0
riscv       allyesconfig    clang-24
s390        allmodconfig    clang-24
s390         allnoconfig    clang-24
s390        allyesconfig    gcc-16.1.0
sh          allmodconfig    gcc-16.1.0
sh           allnoconfig    gcc-16.1.0
sh          allyesconfig    gcc-16.1.0
sparc        allnoconfig    gcc-16.1.0
sparc64     allmodconfig    clang-20
um          allmodconfig    clang-17
um           allnoconfig    clang-17
um          allyesconfig    gcc-14
x86_64       allnoconfig    clang-22
xtensa       allnoconfig    gcc-16.1.0
xtensa      allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
