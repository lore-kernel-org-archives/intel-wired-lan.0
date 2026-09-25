Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB8BC9831E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 02:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60CF440ACB;
	Fri, 25 Sep 2026 02:16:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6pQi74AIAws; Fri, 25 Sep 2026 02:16:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 58FD740ACD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790302618;
	b=OJGKDlAFuQ/8EbjVP/bolNuR55ExP/ytrMR5bAeNLnIUj5JoOru9lDm+Y6t91ZZiHo1f
	 T0isDk9h7n218aVFRmkOMl9RF9jY4Rd8/Kq05qae/L4IwGZRBzJDnE3ULq/iozzD2OPs4
	 dRJpLzAkJmN8T0iODJmixv3J6gS91EEGuOubhtOQ7YgMTFWy59NVVmDeW13gBSAFLxoWa
	 815Zq3YGaG0Y3VwJI/TRbJzf1ADgS/V9rUl2+H5JhxPdUj6qD/4vH06mV9dIb2PcqDoo3
	 ag0CkUC87/EC5dvwzUFbBaSZ23olptRgbCQjkYmgLTNiA7FFtAFLL/qjTvKgw0js9Zw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790302618;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=anTl1wGHQgrfWj3lkCsW6tzidV4N9maKfIzLs10OvgA=;
	b=QGxiVc4N8nNDwiuseXUWGQALhmVC/NLwBwgXp7TlU+y/ERrRQ/ukiPsNtVFR/HbXFMZA
	 WZLEKkBlM4OK7CQvZ1Eg/oqMex3OIluv+axyJlYHmPFnRIxxldV1Ne92Stsd3PGeJPRLQ
	 swfgdx4Uja+MjD+yChL09ki0D/wF9mBM/emK8eDPrN8ZXn6b20WXlhXtJFSvx6kUIl4+c
	 YCVmowdi/5JGHmQbVS7ToUeRVesC3txrAdCpLbtwRdwJOnRARyf8gn4SGtXLxTV+onAaS
	 P2d1rxHSKu07L4TLgnRyDNWoAyPbwBiWt2oSzYqCnuUDMhQ6n4TLlR+WD9cw5iTg/dw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790302618;
	bh=anTl1wGHQgrfWj3lkCsW6tzidV4N9maKfIzLs10OvgA=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=22McUSe+nliwDd9Sw4xT730p2rRr8KJVWK8LL7RKRJtDiH/DaPfHsxwTxTPIsjBOL
	 BNmPCRMqsKgx+EDUr++5v6A+31d2HNT4Is8YJZRYj/Nw5QoVtN19Y+RUb2+w6oJeIH
	 1akg/ZyAQM1pcFYNS6klPqomQhScA9rXS2r7YNHI5ik8iCJIfG4Otmb92jyvyNyvB3
	 BkUXhPx0bspJ4r4zBB1kuwmWTWbxdJPIQpwWWofYUdPlvec8urGqDYKY0qz6J9RZCu
	 luPFqRJOBvveHvzei80FXl5PHaNG89W7dC2niat+dVaOSxE450HKVj1sjARzge01Jd
	 gykBAG70przSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58FD740ACD;
	Fri, 25 Sep 2026 02:16:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 40E2C332
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 02:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26ED381224
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 02:16:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OlEvCx3dOXeR for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 02:16:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A8122811F1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790302615;
 b=p8Zw84ikBk0mzocPYl9e75MKdCHqMegtPhDKYaot/B0ZNsbuqWX+UGg4cZI1bjnFT246
 kqCRzzoG2WUqsn52l1brzJj5GY9j/5rjd13T4Uk2wTkoPK9mDCTG6fVQFqQi1uV3QUSaC
 0zc3OEEtPt5NJm1o2YRUC1boeF3n0t2VbesFd/G7y4pTsl9EyUt0ujXg+b8eNKVcNyY1/
 Sna1PwE/bFJB4bp/WLWTskSumjuovtGBIPXzcdilPWywUdJVnseLSenRJs7VpCW9HuE1r
 N8XPGDTgBL94A7eV1NoVCqSOv/ojsO1wagOJ0JtmV4srHLYCqCb+YKnGS+wHTjfs7Ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790302615;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=anTl1wGHQgrfWj3lkCsW6tzidV4N9maKfIzLs10OvgA=;
 b=tHQR+inh/kN1Nm1hRM8jnL359F+pF0stopbXj+V2noX26F/LY5h4G55AtTFcZxRKhoME
 uNKI4vJWVUHgGEu2okprD16VSnlLXH7GWTW0htmy8pZoum3bCsjWACB2fJO2KX7KWXXSH
 WGx59qJcqvjj5lD8d/ukyng5NykZSScem84RRaj1BNn8qGKnp5KkexCJLb8zDPrKuue0H
 gFZ0y2mSLW/lCtffammmBDq3g6ObziJEt9FR6yNRYKr2TIhFyFIsi/Vsx25/lByelP3e1
 DvLleOJpUGLGxuZs/Ht00EkTOIZICn7ELHmDsdUrcwP5acuo7lHh/OP0PA3ZLsrqhEg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="h/Q6ePba"; 
 arc=none smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=h/Q6ePba
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8122811F1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 02:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790302616; x=1821838616; h=date:from:to:subject:message-id;
 bh=HW4oQUsEexBmBWJHkeoqmBKQ+F7hjvyfjI2c5tZYeVI=;
 b=h/Q6ePbaM7UIR1RNNaCUnEglV6c72UMlJu/gmCFLS0NTQF2PUG/ln/Qo
 pCr90oHOe8ReqGUYVAUEL89adMbK28c0dqco7i5w1o1+zy51tr5T8KLng
 +f+9e7YFxCfvl/BiB12tmfs6PgmkClUvtw6kJDdd1Tppjm/+bAhaB7LxG
 ucEyCuYNvTTPSqkzBuRuE1cZ0doXThOpPMHroYhj2hxc0PnH+3YIFpv9d
 zCqm1S3Tm2J4YLGhaDGO5eoq5Py1qJZh7H6+7eTNXJiMgsmDuCG/KaMZt
 MjNSLMkqzesK4bjVRXSn7nU1zNebNqlAkRXaLEf/CkkIh4KKG7NR/zhEA g==;
X-CSE-ConnectionGUID: IiFds0HOQIuEJ9KqS/HhMw==
X-CSE-MsgGUID: +ThuFggxSi+OWhtUHFdN/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="93807210"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="93807210"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 19:16:54 -0700
X-CSE-ConnectionGUID: gk4S1eAfQ4GSptlcxkkDXw==
X-CSE-MsgGUID: ELNsbk1IQNOtC9V2X73Jmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="277365508"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by orviesa003.jf.intel.com with ESMTP; 24 Sep 2026 19:16:53 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x9vUY-00000000Jvy-2JbR;
 Fri, 25 Sep 2026 02:16:50 +0000
Date: Fri, 25 Sep 2026 10:16:01 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:40GbE] BUILD SUCCESS
 56624fc3e6f0580d8e07ee103f41661569b22b99
Message-ID: <202609251055.D9oZ1xuR-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: 56624fc3e6f0580d8e07ee103f41661569b22b99  i40e: xsk: fix multi-buffer XDP_PASS skb construction

elapsed time: 4603m

configs tested: 93
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arm                                allnoconfig    clang-17
arm                               allyesconfig    gcc-16.1.0
arm64                              allnoconfig    gcc-16.1.0
arm64                 randconfig-1000-20260924    gcc-11.5.0
arm64                 randconfig-1001-20260924    gcc-8.5.0
arm64                 randconfig-1002-20260924    gcc-11.5.0
arm64                 randconfig-1003-20260924    gcc-13.4.0
arm64                randconfig-r1303-20260924    clang-17   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                  randconfig-1000-20260924    gcc-16.1.0
csky                  randconfig-1001-20260924    gcc-14.3.0
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
i386                               allnoconfig    gcc-14
i386                  randconfig-1000-20260924    gcc-14
i386                  randconfig-1001-20260924    clang-22
i386                  randconfig-1002-20260924    gcc-12
i386                  randconfig-1003-20260924    gcc-14
i386                  randconfig-1004-20260924    gcc-14
i386                  randconfig-1005-20260924    clang-22
i386                  randconfig-1006-20260924    gcc-12
loongarch                          allnoconfig    clang-20
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                 randconfig-r1302-20260924    gcc-13.4.0 sparse
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    gcc-11.5.0
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    gcc-16.1.0
openrisc             randconfig-r1300-20260924    gcc-13.4.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    gcc-16.1.0
parisc                randconfig-1000-20260924    gcc-14.3.0
parisc                randconfig-1001-20260924    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    gcc-16.1.0
powerpc               randconfig-1000-20260924    gcc-8.5.0
powerpc               randconfig-1001-20260924    gcc-15.2.0
powerpc64             randconfig-1000-20260924    gcc-8.5.0
powerpc64             randconfig-1001-20260924    gcc-10.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                 randconfig-1000-20260924    clang-17
riscv                 randconfig-1001-20260924    gcc-15.2.0
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                  randconfig-1000-20260924    gcc-9.5.0
s390                  randconfig-1001-20260924    clang-17
s390                 randconfig-r1305-20260924    gcc-13.4.0 sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    gcc-16.1.0
sh                                   defconfig    gcc-16.1.0
sh                    randconfig-1000-20260924    gcc-16.1.0
sh                    randconfig-1001-20260924    gcc-16.1.0
sparc                              allnoconfig    gcc-16.1.0
sparc                randconfig-r1304-20260924    gcc-14.3.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
um                                 allnoconfig    clang-17
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                              i386_defconfig    gcc-14
um                   randconfig-r1301-20260924    gcc-14     sparse
um                            x86_64_defconfig    clang-24
x86_64                             allnoconfig    clang-22
x86_64      buildonly-randconfig-1000-20260924    clang-22
x86_64      buildonly-randconfig-1001-20260924    gcc-12
x86_64      buildonly-randconfig-1002-20260924    gcc-14
x86_64      buildonly-randconfig-1003-20260924    gcc-14
x86_64      buildonly-randconfig-1004-20260924    gcc-14
x86_64      buildonly-randconfig-1005-20260924    gcc-14
x86_64                               defconfig    gcc-14
x86_64                randconfig-1006-20260924    gcc-14
x86_64                randconfig-1007-20260924    gcc-14
x86_64                randconfig-1008-20260924    clang-22
x86_64                randconfig-1009-20260924    clang-22
x86_64                randconfig-1010-20260924    gcc-14
x86_64                randconfig-1011-20260924    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
