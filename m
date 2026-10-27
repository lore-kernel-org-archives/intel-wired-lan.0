Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D6A606A31A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=eWrKzDvb;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VvVE/4FH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF8DD809F6;
	Tue, 27 Oct 2026 00:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nQYHw7uNjrKR; Tue, 27 Oct 2026 00:29:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB2B980AC5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793060978;
	b=Awx2Hj1mx6kFjGtX+GTfAOz1T1ssfGE09M+NopgMILzWYUY2PfWkqvz3dDoX7dQImkfE
	 0mAOKqkfKDl8x3tLKYFw3oXd5LgXUTSILLyV+nqEDDcVgjDniJktTPv9A3C/g+cRo5/vI
	 GSB2yKSE98uIQNrUmxnNTLKfPuyRH3p+c/jbgNTXADzn2bhJzxc+AlLumOqNLjrTAlQHD
	 /SCSdhq8swVq5dFRQkvKIAKf21fqBMCxbN6Qv3+19z6MbKEsMvLrxvC3QJaQXeQ43GvrA
	 L8H4kY/YpJbTwcTnI+TQYpmimQyDQV9WraqK2ltQUGChNPMJaGDuCVJJq1lN+/52abQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793060978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6Uuwxrck4lTa20WbeLyBhgwwxp0d9ol2UJbBSqAkJtM=;
	b=YH+cn6V7k8ddXdmnE0zmxOcFD2e5ljOSJZrYeANVi0Xzbf3ZiESq1TO43/uDu6uwFcVU
	 D3r2ou4IKUxa1tETjsaebMcd9P/Yne8cl4N1IA2AB4CUmx1TnD/qIFwWg80cIvvDYOQ4x
	 jvrvJOeopN4NYUIjslPIDf5ahVr96Es5lfoS0QjBBwgEYcQR2+tioc6WU9wLt6CzJRKIH
	 bj085pW7wAZk1gR6ZaQaIjeZA15CSFD0Nw0B4l0zIaOU3twDj+i40WcNdnUK9Dku/lMCU
	 5OSig2Fw2jnDBvJigHZCw6C9jOEXkrtU6eBmcO8CnfF+v/OvGLhebyJ6AzYeZw6Sbnw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793060978;
	bh=6Uuwxrck4lTa20WbeLyBhgwwxp0d9ol2UJbBSqAkJtM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eWrKzDvbZQRmH9g0hE1rCLocjqnybjadxUgf7+oYHQzvzWklN//72oVmJZeNDjHxc
	 SyMWjPWqWSEOWQqPxNkofTzKir9+7YBuiqxP6bj3sxSvaUYa5N1sbsVouZQCa8VezG
	 d9eomlnW6862hm4n4A19CW6bzYw/E51xPVSt8DV105XUPZrcZ+NzC3w191aVZPD8dA
	 It2xD3w1R40KiAhH9380pFnnE3RV3t9iClsJk4topeqSeFU1JlaIcDcyWuPc4qwpuu
	 BSBRJ1gfem5zTbZ0drerpT8I++el29KiieMYw94izFeuR0ziOcM3hJUzYLYXhoqNQ/
	 x0BjWGpkjnsAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB2B980AC5;
	Tue, 27 Oct 2026 00:29:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DFA32F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 00:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 641BD40205
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 00:29:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FRrNrtx5-uOv for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 00:29:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8F24940062
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793060976;
 b=jV2vflH0ZuCIaEjclr+PPHoW/SsUqPaYVABLduZRCA/Y2NjOMp2JqlXKyLS0aprRdoZu
 kmz+8f0PqLVNMF4gI4vnO4ZQ3D7aZZG+SQVVQpPaCmV55oPjfPcf1YSu9auV9i4/w+gGq
 6lExAjLtoz7Y1AeYjphGvxetLKHuq7Il48I2fSJSFtFXLunua8Cb/YLP2ve+F22pISJQl
 787UIxqmADhXsdGYsBPJAvG8SI85J+0ikZjKeSGo71UPbEjivkAXYVUwQdKKzfuQ25pO+
 HUy6hAiiibK9H+he6xD3AaByX1G3oInsdz0eTqaGhAD4xL4poYv1+ChC7kiTVAM80Pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793060976;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=6Uuwxrck4lTa20WbeLyBhgwwxp0d9ol2UJbBSqAkJtM=;
 b=WKht1bnOai6SGL4p0lCZ2e+Exf1v474pCch32UKjc3Ee8p5qS21CUEZemrxxIWJjDYY7
 WI5bju1tQzWVRrmHuIufjqg2ZMeBLMew5dxU09XDHKyF3qx8fHC0X09+SCnJYzxQV9Kqt
 pTGvdpiCAqx/flFueT+dCXZLSDwAwvi3aqAplbxVU3yep0KVv8a6NTQX8Y0YNmjUF9gTQ
 n9w9NHqubdvG/dzcrsSgxhDxUbT6w84jE31J7nK2/u0pcIaHgCcFgoEuMpFbGFGOt8fIu
 jUqvJhiOtM/rd94oGiLORdhYO6GMBC9nM7041p5q9NP51e0iqBlF9xMiemVQ2J3BTAw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="VvVE/4FH"; 
 arc=none smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VvVE/4FH
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F24940062
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 00:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793060977; x=1824596977; h=date:from:to:subject:message-id;
 bh=9BDpSWvhm/dmDsHPAi0Ak1EHNe1IuS2zgDdreE+07KY=;
 b=VvVE/4FH4+t4pjUfhtM3GtuJfCnfQiTHJ7bX/97wj196eJtOSgPn8q7j
 TD6wSTMQWZOHANZuvmueMVbLRgX1TZjfG90pfKjJMfcgcw0U8112gcFc+
 VZBwLYlvlz4Te5VHMYmxkclovI+OR2yJRbYKC+wqmx9EwbiBoaOPzOZlH
 X2X/Bakqnn+PUH/yeshker0o7TTD+biZFFpr2TxESo/vTR0yrRZPuhOGI
 PI6CQHfcLAXyiE/xLYNRe47lNuxxOKkcNJBsA8suiTCU25PlIOIOZen7T
 6QU9ugPSlg6AYwsLI+CwSoXv/7VeG1teXwvUpWm4WFAY2ogNZyv06lZA/ g==;
X-CSE-ConnectionGUID: A7Zaa1MfRr+mDbQ9p5R98Q==
X-CSE-MsgGUID: zqigW2WSQDu2VEYV0mPxzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1756210"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1756210"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 17:29:36 -0700
X-CSE-ConnectionGUID: UTdJuOp+TK2Uc3c9kOehbw==
X-CSE-MsgGUID: KzJxJXDvTAaAIKitlgiLeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4387717"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa002.jf.intel.com with ESMTP; 26 Oct 2026 17:29:35 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xLV4G-00000000Wdk-07Zs;
 Tue, 27 Oct 2026 00:29:32 +0000
Date: Tue, 27 Oct 2026 08:28:51 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:100GbE] BUILD SUCCESS
 9ebbb58e13b4759605d0107ba8538409b9acbf4d
Message-ID: <202610270843.pjVbZwuK-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 9ebbb58e13b4759605d0107ba8538409b9acbf4d  ice: don't clear in_use until HW clears ready bitmap

elapsed time: 3596m

configs tested: 79
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    gcc-16.2.0
arm                                allnoconfig    clang-17
arm                               allyesconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                 randconfig-1000-20261027    gcc-13.5.0
arm64                 randconfig-1001-20261027    clang-17
arm64                 randconfig-1002-20261027    gcc-8.5.0
arm64                 randconfig-1003-20261027    gcc-8.5.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                  randconfig-1000-20261027    gcc-16.2.0
csky                  randconfig-1001-20261027    gcc-16.2.0
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon               randconfig-1000-20261027    clang-24
hexagon               randconfig-1001-20261027    clang-24
i386                               allnoconfig    gcc-14
i386        buildonly-randconfig-1000-20261027    gcc-14
i386        buildonly-randconfig-1001-20261027    gcc-14
i386        buildonly-randconfig-1002-20261027    clang-22
i386        buildonly-randconfig-1003-20261027    gcc-14
i386        buildonly-randconfig-1004-20261027    clang-22
i386        buildonly-randconfig-1005-20261027    clang-22
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch             randconfig-1000-20261027    gcc-13.5.0
loongarch             randconfig-1001-20261027    gcc-15.3.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    gcc-11.5.0
nios2                 randconfig-1000-20261027    gcc-8.5.0
nios2                 randconfig-1001-20261027    gcc-8.5.0
openrisc                          allmodconfig    gcc-16.2.0
openrisc                           allnoconfig    gcc-16.2.0
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    gcc-16.2.0
parisc                            allyesconfig    gcc-16.2.0
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261027    gcc-12.5.0
parisc                randconfig-1001-20261027    gcc-10.5.0
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    gcc-16.2.0
powerpc               randconfig-1000-20261027    gcc-15.3.0
powerpc               randconfig-1001-20261027    gcc-8.5.0
powerpc64             randconfig-1000-20261027    gcc-10.5.0
powerpc64             randconfig-1001-20261027    clang-22
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    gcc-16.2.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    clang-18
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    gcc-16.2.0
sh                                allyesconfig    gcc-16.2.0
sparc                              allnoconfig    gcc-16.2.0
sparc                                defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                allyesconfig    gcc-14
x86_64                             allnoconfig    clang-22
xtensa                             allnoconfig    gcc-16.2.0
xtensa                            allyesconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
