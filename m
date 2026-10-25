Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574D606A31A
	for <intel-wired-lan@archiver.kernel.org>; Sun, 25 Oct 2026 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=BY1TTJaA;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CaW3hChw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B6B881466;
	Sun, 25 Oct 2026 13:43:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eCJctVFUVcrs; Sun, 25 Oct 2026 13:43:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 929FA81469
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792935805;
	b=MfvK9qqQQjD6em7v/5wHdDmbIqdYixxe2+gYxi648mL8o7Rw9avgnhp2md3x2fGHgSPj
	 PBAVub1XeLREXZYiXxzGmfQdmDCGeW/vLx4WSedXkmb9ym6ojVflOdPWi6ATo8O/izQGF
	 NSS44TLSLyi5m7cU9s+VfitQ6M6bjO0zVeKuOrTANb/kZSl+3HddP4raQYb5FDx9QaRnV
	 oePc0cdlvvh43y6ZPfaoMS4zlZChlNai34gAVvC4czg0XT79zLFVFoxc5x4vA4LCUm3+N
	 Vj3J1qhXsaXUsGjtZPMOaUwRo/nSZldSRdf/3cEV0IIvlOodEQnwP9BvyOw17wUb8GQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792935805;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+bbK2Knu4FHsbrcTUeT/X177Qbi7zYX6mHoqll4cLZM=;
	b=Qunw2HGzSZnhsw2eEueN9oHyl07TgQVqoK1sxYXROoqR7fLNGzrAfAyEuXWv0fi49Cw9
	 ZSxt1EpgilliGlpooTA+cedxMmYbyoYou6HIbPXfTrw4cv/cwwE9WJqS7DZ9lKOc+8Y40
	 e/z4U6s1PRwGhMTRIg4uwgg3A6dwZTOYvXrhDD8cjXTUJGb1p5xZNFYMrFSW6iEu7vOTb
	 O/S1T2fwLYasXLMuATQzVa2USXUhtgE0rZJalFfpYT8YMowXtH8Q4hwSlnMflSIwUCtuf
	 WLwEmRD4vghdPyOjh9ISuN7ISHtUWMaQ25Rcvd8/nW6s/+uq6yiQX8N+szL0xIiLECA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792935805;
	bh=+bbK2Knu4FHsbrcTUeT/X177Qbi7zYX6mHoqll4cLZM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BY1TTJaAOF8+G3ZkquAQkWiXJ4CM/84BEpX7o37jQ68dQQZgta2902foWqbiM+fgW
	 UjyzdaT5Ws2bZZUoX35wHjTEmhJYeQtTsFmggoDXtbnNaBuXxXT1uZ13CULoBDQsot
	 KRuvi6tYV1+FHE6LAjjRxx6458vVuN/RkhmBEU5/TWlXrR4JNkCuYEKBapGQ/TSsg4
	 6GoPrj2y6Jf7IMc8xt+KWY1JZvJPjkKnLIv3Vm7LwsxucZNKDLK4M7dDJGiLZaIkX4
	 9Pn0TNFKmXG4nq/hWT/kYt4KXURX91VAV2MXmtZjAz+MgcegFi6WdCyyM7vz/qzMad
	 hNxso8Bu5w0TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 929FA81469;
	Sun, 25 Oct 2026 13:43:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F9563AF
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Oct 2026 13:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 15E3F4008E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Oct 2026 13:43:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pAMcBEWLYdQh for <intel-wired-lan@lists.osuosl.org>;
 Sun, 25 Oct 2026 13:43:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F1D2540057
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792935803;
 b=QPZTBkUxwPbcq0eL5VMUNVdVMQ8xxWaHAQAQ2KZT+1AZRsiE7oTClgy2FkioaMRAKt+S
 0YBkp6wqbP65Cm4QcYVqR9VEUG0dz8XL/zGvp/EBeDUced0GbgQmk9n67WPRffEuH9rRt
 FlIzkM01WSVBJvj9X6vXjbD78b7HghBddwsu4lwD3DlLhb6qOFilrtmir2u/Or9ZsiUSG
 wCLIpPQqECYMorFR1QmTzA+XILgeM8plPIg7upiwFrGv9GG3RFENQV3hKFw+sua3qQJmR
 3A5ilarK+W0X+S+9v0X+uMHUq8syCopXOjY1SLHKkchl4Ly2KiBdinbBpTbViO4xpHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792935803;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=+bbK2Knu4FHsbrcTUeT/X177Qbi7zYX6mHoqll4cLZM=;
 b=WwGV+KzT7iR5dpJELxN3dtt+bQatW5L2b3ZDOBJ+ygCzI3tHGQy0xZCUOMpx0BgVXYp1
 O8tcxIo0XJhDRbzaIbaEbijilw8MbCGK7YDn/VXXLUcCWmwjpDAheJp4JQEVNPFGG96Qt
 0ZS+5QeI/tkC6Mte4GebndPZRa4epvTXMdd1dWuSNURJdyWXztD3qMZTqGymn98DlSrSJ
 iqWjksZZyhs3ZFfXj3fn/EHQM6C0+YgH6x+b2aHodfWM8X9wnWEa9IAEmnQiKS54NRHcE
 qe5w2EhW19tkkvLCPo6wqGtaKF1E4OMzRJfbsuP91EKDi+AXuhujieG7oo06gamoz0Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CaW3hChw; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CaW3hChw
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1D2540057
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Oct 2026 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792935803; x=1824471803; h=date:from:to:subject:message-id;
 bh=0/mkXIXoZ7crnR0LidrAEgq6vNiHsYTgO2qEWSLNevc=;
 b=CaW3hChweOFxyng5qYt4cy5fhbQl6icA2G/34GH3q3bYB1Iw3+t5dYKE
 GRM5A5mX1KZWoFUW5kCCJlvvftJrC8tW+7P/yVOyI/cSZQP2JwuRv+831
 i0c3MTk0IVQHPqOvp552VfKvkZipVPSHKXeHx/ewhv6xQn1vREbEMSMVm
 quXlVx4yaRhYRG0fOi4v/mU91AR9SWwsxclfH0UYSJgZqPYRwIu+IVGgT
 RyNKC70pI+z7jdJ4EoDvEc7UqbDK2gV6NIYoV6UJpu4S3TyT0Q/ThkTX0
 aTqU+FDhEtLwYGKZR4+ktT2B7IJeemw2OKHYNSlAS+nDPHjp3R+zQFIT8 w==;
X-CSE-ConnectionGUID: lV0LZeLmQlKqqCpqlrIZiQ==
X-CSE-MsgGUID: IVekqdLeSmyZTtTMvornWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1496202"
X-IronPort-AV: E=Sophos;i="6.27,177,1787036400"; 
   d="scan'208";a="1496202"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 06:43:21 -0700
X-CSE-ConnectionGUID: 4mxGSyVPQ0iRDJlUpkD9Og==
X-CSE-MsgGUID: t5LVZWPlQcicySReDczhHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,177,1787036400"; 
   d="scan'208";a="4052326"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa004.jf.intel.com with ESMTP; 25 Oct 2026 06:43:20 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xKyVK-00000000UpK-3IF6;
 Sun, 25 Oct 2026 13:43:18 +0000
Date: Sun, 25 Oct 2026 21:42:53 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:100GbE_E825_timecounter] BUILD SUCCESS
 9264218524c36e8c3a8e2ebd48b59192f7031ffc
Message-ID: <202610252144.vnBZMwBT-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE_E825_timecounter
branch HEAD: 9264218524c36e8c3a8e2ebd48b59192f7031ffc  ice: use struct timecounter for E825 and E830

elapsed time: 4395m

configs tested: 50
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allnoconfig    gcc-16.2.0
alpha       allyesconfig    gcc-16.2.0
arc         allmodconfig    gcc-16.2.0
arc          allnoconfig    gcc-16.2.0
arc         allyesconfig    gcc-16.2.0
arm          allnoconfig    clang-17
arm         allyesconfig    gcc-16.2.0
arm64       allmodconfig    clang-24
arm64        allnoconfig    gcc-16.2.0
csky        allmodconfig    gcc-16.2.0
csky         allnoconfig    gcc-16.2.0
hexagon     allmodconfig    clang-24
hexagon      allnoconfig    clang-24
i386         allnoconfig    gcc-14
loongarch   allmodconfig    clang-19
loongarch    allnoconfig    clang-20
m68k        allmodconfig    gcc-16.2.0
m68k         allnoconfig    gcc-16.2.0
m68k        allyesconfig    gcc-16.2.0
microblaze   allnoconfig    gcc-16.2.0
microblaze  allyesconfig    gcc-16.2.0
mips        allmodconfig    gcc-16.2.0
mips         allnoconfig    gcc-16.2.0
mips        allyesconfig    gcc-16.2.0
nios2       allmodconfig    gcc-11.5.0
nios2        allnoconfig    gcc-11.5.0
openrisc    allmodconfig    gcc-16.2.0
openrisc     allnoconfig    gcc-16.2.0
parisc      allmodconfig    gcc-16.2.0
parisc       allnoconfig    gcc-16.2.0
parisc      allyesconfig    gcc-16.2.0
powerpc     allmodconfig    gcc-16.2.0
powerpc      allnoconfig    gcc-16.2.0
riscv       allmodconfig    clang-24
riscv        allnoconfig    gcc-16.2.0
riscv       allyesconfig    clang-24
s390        allmodconfig    clang-24
s390         allnoconfig    clang-24
s390        allyesconfig    gcc-16.2.0
sh          allmodconfig    gcc-16.2.0
sh           allnoconfig    gcc-16.2.0
sh          allyesconfig    gcc-16.2.0
sparc        allnoconfig    gcc-16.2.0
sparc64     allmodconfig    clang-20
um          allmodconfig    clang-17
um           allnoconfig    clang-17
um          allyesconfig    gcc-14
x86_64       allnoconfig    clang-22
xtensa       allnoconfig    gcc-16.2.0
xtensa      allyesconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
