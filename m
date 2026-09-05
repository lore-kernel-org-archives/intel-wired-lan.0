Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A57C624DB
	for <intel-wired-lan@archiver.kernel.org>; Sat,  5 Sep 2026 20:11:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71FB480F53;
	Sat,  5 Sep 2026 20:11:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id op6FwoUEuKJQ; Sat,  5 Sep 2026 20:11:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 40F3780F36
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788639064;
	b=gKypYTYCb+WeIV8iTKMunKoVvxAahomUmiDX4tGisFQO5EaCpQezQjbAIRrvJLslKoT7
	 238Q57fXHHcwHJIUL88pbMnN3k/2/0kod8NukiHcpx0/ByXtKVH97wK7UE7y9DCpuMMTq
	 Cl8VMPLEBB9BkDLLOUHuMdggzBvBHmXdcv1AqTqvaCePaZa3FogQs3ipbk0YkwjFlRbGA
	 JKtuGJReDAnGltaKIgOdJxC0X5h2aGuBnHu11Tci3RNwadI2FfPiBPT3Pmk3W1flenkVV
	 5a9LFSXR08v7UXH6c5LNKF+dg5NxUpWuMW48sjZluIr8D417VqERLiKhUgBPGh9icCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788639064;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=l3j0US7EBwxNL7LaEVU3V2JuUPkgQa2nHqEeZd55kYI=;
	b=EYhrfXLCUa8S0rf/1ho4ETdKCHrb55pL1PNWZj07AM6IrCPHMFWYP99vNVpa5up8QZMS
	 B/Y9yfGph0cuSruagoMoQaf3rAv5kHohwrURixkSwdPg/8QRCInF6wlPBFbSyOy7vXSQf
	 n9o94vCF268aoi9D2u3pukwrYPm0B21a7nuWRxBHqxxgnJZ1pK2nXV0a3eCiHwhOeCG9e
	 EYLr3YO/11A4PxjLPTFv+tJJmtnW/z0qnviwUiKi4xOf8xhvhS900riOBxsu7b0rU7T1h
	 W6mZfXlyHOiU/iwzG2XfUdTPkVP3LHdPYzl9HJBDo88pC7m4YnOSPTkO/Z1t/Lvohnw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788639064;
	bh=l3j0US7EBwxNL7LaEVU3V2JuUPkgQa2nHqEeZd55kYI=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6EO6iKni6Wqg3c8JP6NTK9YjWPnVzf4JYO+1mZICnqvbweK/oMAAoJoJGosStZMbJ
	 +xducabh6Kcx3Kni7X02+0L+9sPDZq9eo1kfUf2rVzREhbKHoKTe5Hl26nxZSGYjKX
	 rM32t0TS2ryu2WFyCqaZkDnJkW0ibA0KyMZHOJcuEfqZVj0qgWF33v2dbGv0OiowCm
	 tevBhvGoPWzKWFxo74pKGYuSmhRbRdoO9hFKtq9UiM3DdCr1LfCCWrkeGCVmH52iaZ
	 wDyFbesx8E8bJobcNQuhLSijE7nepeu0jKahM1ClbMYnYIHrfIngpi75/PuLLNe06O
	 YyO6rLUYfCDlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40F3780F36;
	Sat,  5 Sep 2026 20:11:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3929C72C
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 20:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A14560600
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 20:11:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SaZqw7XFHLSd for <intel-wired-lan@lists.osuosl.org>;
 Sat,  5 Sep 2026 20:11:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3974A605FF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788639062;
 b=FozP7adLfd7U4ZnfS+oYYdmwdOGO9rpjAlpZFtfKvljkfbnVdTt0l0clmLQb5FePHPiR
 GvlGultl9+tSmFXL4YEbCvNmwvwOjHPVvILZkDPPY0uCBFPaM0vMQ+WIQZjWUTo1yLpSA
 VAYAKQeO5hjD131nlwM+GGyYx8lyad51F75QILBVvXOUCvl/0r/7F4JzLMREfoCJPYuKf
 7N/g4oUCdAKawe0wpatgHlTX0guhc4d805YCg8VoPScNkhMywNOdkykh9Tws/TnIS92Ka
 3vLTgY7eq62IKUpEtbXjQnZA8WYuyxH8cED1diutSa/P0ZUBJsWYWW49CG+uyNjNujw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788639062;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=l3j0US7EBwxNL7LaEVU3V2JuUPkgQa2nHqEeZd55kYI=;
 b=lLci5Wzg50JkQPo2zGfG8GTmmx5rAVR5chEFnOwp3t7h236EFglFKdRX9HJTYgk+Oy0m
 GucAb6nkIQMBbCGTSLt1zVaTCHZ66C09YGhahmayhiB6JBR6916/LUkHT7pOswDrSZc+P
 JN69mghp9cMhCw/ORDkC2JfJfp7ElALO1v5awkaIk85dzWaM4f2thx+Ly1Ya3rU0tGs7w
 VGFsP2Ux9q+WPxE6e724TsgghF/Y6kN4koygJzyef0/xyzqyjH0u3YGxperBdtfjIQY46
 +T1GCepznjX6SCileV8cvhaT0Lr7HPhc2Mg1JrreGeHzA4CD9cl+HAw6EFZvwhUTucA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OqhzIHhI; 
 arc=none smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OqhzIHhI
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3974A605FF
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 20:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788639063; x=1820175063; h=date:from:to:subject:message-id;
 bh=jx4ht/N5EFh2lBcxajZNnt72awl4wLvrIGzFnHPub94=;
 b=OqhzIHhI9iSyUHBQc5fRh8MWTITBuyhn405oY37an0J/ydG1lYH1HwLg
 q3j+bzkCiNVmO7UoNR+hkynklLJmKuN1O7jxAc5IJAjodIDNgfmPJqfPb
 lC2ZZ4r9/jgiGD2RSGXcDvJTqi23gvuuzBWU8YAhByXBVEaYLZ7kgeWa2
 7gZaXsyvNYtVE1kv16yo/OUq5g4ufP+D/MZYGDhgCpraEYMfAN7xHGQxD
 KndKq8AjP6MY86XZVmjOsC7CtOdZud38tVf1nsA189fXo2bazEu6JnZnE
 D8iPZXg5JQ04pLg4EEnLx9Wcj634NTR4sWvYMk+9/YC5Lkxgepr6ZhX9I Q==;
X-CSE-ConnectionGUID: hXRXApmdQpu32l5SVz/1eQ==
X-CSE-MsgGUID: mvI6RznQRGCWP7m1hDkobg==
X-IronPort-AV: E=McAfee;i="6800,10657,11897"; a="99437055"
X-IronPort-AV: E=Sophos;i="6.25,264,1779174000"; d="scan'208";a="99437055"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2026 13:11:02 -0700
X-CSE-ConnectionGUID: h1fJphG7Tiqt5W73/uYIHw==
X-CSE-MsgGUID: s3/JvXLKQS2/j2dBoxH4/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,264,1779174000"; d="scan'208";a="308591954"
Received: from lkp-server01.sh.intel.com (HELO 73f3364bc37e) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 05 Sep 2026 13:11:01 -0700
Received: from kbuild by 73f3364bc37e with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x2wj4-0000000014P-1ygv;
 Sat, 05 Sep 2026 20:10:58 +0000
Date: Sun, 06 Sep 2026 04:10:48 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:main] BUILD SUCCESS
 641d03105cc0d2437e32fdeec164f91a4ccef6c4
Message-ID: <202609060446.cl905qyZ-lkp@intel.com>
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
branch HEAD: 641d03105cc0d2437e32fdeec164f91a4ccef6c4  Merge branch 'enic-fix-v2-vf-mailbox-reply-matching-and-carrier-reopen'

elapsed time: 2329m

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
