Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC5606A337
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=OWlPYqKq;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aiSTUKZm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A94B4060F;
	Mon,  2 Nov 2026 17:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yu2ac9um-CDN; Mon,  2 Nov 2026 17:51:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C9944069C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793641864;
	b=raZFL0hREY7eVlDP+0KOa83O7tThcKZV/6YZiNrGmzgiVlh1p/AgHmOde22VZE0cbVGF
	 KhROnFn0W58N0UPKfHFquqBQyinolzLpTLUSHvkidNIJj+ZQhtnuQxmqddXW3EtFDSJ2T
	 fg4/A4njXf7jM2p1fIJoiejowDNOEpsCorSWmXrsQye9FG1nTxHGuu4hKJ5colgrQtzG8
	 6YHWRysg/JBK0xL9d8Mlg8JP1aZyOkK1D2DMb+KIpOGvT4HN7+EMcQsllIVhbVafEaLAf
	 XKjrLjJvaLeesm+xEIgM0+GhaFB2RripYkHNggsxNLTq9ZRmWq72adOZck9dEWoz27A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793641864;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RWQqbkhJ3TwuvOfI6eVqfWWQeqlasG5GK+c61//qZSM=;
	b=XzsZcjeb0xM3Lvy8B431WOnFQ8JYE77f/tMv7/t6mGTxE3I/DjqwUQubEJl8aJvQ44fS
	 tWqhttPUoF3CqNS+7pgL9ZL3hVNGyWD3ShogvboBc1d7Sj0E+s9xS0W1Ex4BJXZrBVYrj
	 GaCvgVuk0vYLAusBnmGu5Nq27o3o2bd+lDw7/WJLGLwzHdCQwt2PMmSg7H7wAfO2SlqMS
	 WuoRaSbAQwR8KO3tr+gDV3Qy+ZBCRXDbzhVshVnbFr8pS0sURbsJoUMvU+yiePm4Ic/TG
	 Kr+Hpcd3gAW/suf9mAh8lKHVfjuq/PYBN3qXfPT/GUUqIux0wZ5MISsARa8IqBON73A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793641864;
	bh=RWQqbkhJ3TwuvOfI6eVqfWWQeqlasG5GK+c61//qZSM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OWlPYqKqhS2A9abELPlS9RpVi+/g5AzWqYyOs5/x2jT4dTAi5k3eydyObgUq66LaE
	 RrYtzyxDiYk+iE4loigEkUO+RiriwkLwS0ugvbxDixxHtTc6eFdN4b3oTcbIU7cSOo
	 9itauVc20l6vOSCkRJjEfpXUhhqz7gdshOUiDLzzu5Dagad+/HuYYDGfB6mYaD0Gaz
	 vblf/MIaiif0oMZtFLTqW9IweRJH3Tba6fcZIf1XLzZfWNVckPRfs14YgiXiniddok
	 V9qoH2KAN31C3mtNk86kJndM4oxzf6NR9d1xKG0UkJtOpqHzlLmmJTqj7bpZBb2wd/
	 +RAhIiAMP5/9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C9944069C;
	Mon,  2 Nov 2026 17:51:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB1EC235
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 17:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8688810DF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 17:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e9mg8mQJa2Y9 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 17:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3D9F1810DD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793641861;
 b=sn5WXj9DldoTJl0Pf9wku+wC6194r6asIJWpmTtDk/cHerq+PGEBm9I0xjZxJaQLQrsG
 xwyRJA/eR13NWXfqFErIaSOzNPKQiaG24P8fE+6DnID4AQDz+3bCJlB7Rqv1hehfTFo38
 Fpm/1zFlFMwBzeGy6SUKH+mdG0HUlVPSL+i2kdUHAjelQ9Ld69qFsEE40KEzB6ox3TRuo
 HlleQosCGV5TTM/jpeh2EUdrHiS6aujvf5XQ8vr6pzAtUN62dn7nbG73AOTEC7cveUiP8
 ZIDnizaUTpd46Huy7QeVODZmJARlwkU8YECpRkJhr3Uhi/Kl5I0U3xeLKu7/jxzo9Qg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793641861;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=RWQqbkhJ3TwuvOfI6eVqfWWQeqlasG5GK+c61//qZSM=;
 b=ZT39v5yhqaFkQwa97jRPtlwWtlLby0vz27v88BfHez9rX8UnhAFb7U0Salbawc8hQphU
 4wJiUcBD7LMN6cUyHh9a848b0pdmBGe8QIvappn4fSdIMkhT+V0JPCYrZw/03Xg24SLSv
 G8n5XS5YXzODbJ/enrRe3vjRU0jOpa+ac5+mbmInOGrqOa6FwAhkYOEmD2EPOoa3JwwMC
 TxzuQiFZEEYiA+Nn2XK5T0eMoKnaPQYw0KDdZRqM3m24B6wyIsOxp9XPmSA6XwbPxwe/c
 H0f1Xzn0AI3E2PzszOdEq2m+kh0VuncKd+U7Lcpv1k2nnadKr1i9KzTvdIY8KRmensQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aiSTUKZm; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aiSTUKZm
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D9F1810DD
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 17:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793641861; x=1825177861; h=date:from:to:subject:message-id;
 bh=sHWYVYRfPKZseBE4JeanfxEYbgf5euzFvnT56Yc1VME=;
 b=aiSTUKZm3gSggztPxDolPftsaqdN1aICspue4+4WKTVUE7IT1Y3MPRiI
 oLL3HZeQNqbuhBvMmEsHroKqRuNSZ2Cnfc9ZH7WWq0FlBOlGCc0+TV/BK
 Upsk1cM92lk7N49n90xNrBt1y1xMw5B1R0bCPLIuBIlFTm/ssGo2Hg7PJ
 h1hS/+xussabPcEiTJyf+jgBYDW1a4SQkw7mcncK+bE8Ok5zMPOQb9wIc
 rgbu275C0Y2yLKmE5KZgPZhxwnggGwO9j87IGkrsLySReTJ+U0I4zf+no
 iUvTq5+vYMIk4TjacQmkX8ohrNqBEt6M1UoXgBn/GyVv7xtVf4csA0jii Q==;
X-CSE-ConnectionGUID: J9Udog6rTgO4ET8u9Q2jbA==
X-CSE-MsgGUID: 2giWX+fTSl+s/PEcZZpI+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2244527"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2244527"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:51:00 -0800
X-CSE-ConnectionGUID: xjvMpW3IQrW6ARJF6pRMhg==
X-CSE-MsgGUID: eWsR2MQDTu2TGE2fpl/kQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6343124"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 02 Nov 2026 09:50:59 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xNwBN-00000000hbU-09vd;
 Mon, 02 Nov 2026 17:50:57 +0000
Date: Tue, 03 Nov 2026 01:50:29 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:100GbE_E825_timecounter] BUILD SUCCESS
 3f3ca43bb77f800814e88fc923238ad0a122d79f
Message-ID: <20261103015029.GykOzBnB-lkp@intel.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE_E825_timecounter
branch HEAD: 3f3ca43bb77f800814e88fc923238ad0a122d79f  ice: use struct timecounter for E825 and E830

elapsed time: 5273m

configs tested: 42
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                    allnoconfig    gcc-16.2.0
arc                      allnoconfig    gcc-16.2.0
arm                      allnoconfig    clang-17
arm              multi_v4t_defconfig    clang-19
arm64                    allnoconfig    gcc-16.2.0
arm64       randconfig-1000-20261102    gcc-12.5.0
arm64       randconfig-1002-20261102    gcc-8.5.0
arm64       randconfig-1003-20261102    clang-24
csky                     allnoconfig    gcc-16.2.0
csky        randconfig-1000-20261102    gcc-15.3.0
hexagon                  allnoconfig    clang-24
hexagon     randconfig-1000-20261102    clang-24
hexagon     randconfig-1001-20261102    clang-24
i386                     allnoconfig    gcc-14
loongarch                allnoconfig    clang-20
loongarch                  defconfig    clang-24
loongarch   randconfig-1000-20261102    clang-18
loongarch   randconfig-1001-20261102    clang-19
m68k                    allmodconfig    gcc-16.2.0
m68k                     allnoconfig    gcc-16.2.0
m68k                       defconfig    gcc-16.2.0
microblaze               allnoconfig    gcc-16.2.0
microblaze                 defconfig    gcc-16.2.0
mips                     allnoconfig    gcc-16.2.0
nios2                   allmodconfig    gcc-11.5.0
nios2                    allnoconfig    gcc-11.5.0
nios2                      defconfig    gcc-11.5.0
nios2       randconfig-1000-20261102    gcc-8.5.0
nios2       randconfig-1001-20261102    gcc-9.5.0
openrisc                 allnoconfig    gcc-16.2.0
parisc                   allnoconfig    gcc-16.2.0
parisc64                   defconfig    gcc-16.2.0
powerpc                  allnoconfig    gcc-16.2.0
riscv                    allnoconfig    gcc-16.2.0
s390                     allnoconfig    clang-24
sh                       allnoconfig    gcc-16.2.0
sh                      allyesconfig    gcc-16.2.0
sh          randconfig-1000-20261102    gcc-16.2.0
sparc                    allnoconfig    gcc-16.2.0
um                       allnoconfig    clang-17
x86_64                   allnoconfig    clang-22
xtensa                   allnoconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
