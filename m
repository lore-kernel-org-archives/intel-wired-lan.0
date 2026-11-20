Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D4A606A688
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=H/Bb91SU;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k8KfvQEO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39D8F60621;
	Fri, 20 Nov 2026 23:03:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dQOAkTNAz13F; Fri, 20 Nov 2026 23:03:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E7D9606F3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795215804;
	b=bEr9bLhrtXFavTWAouXP3EKIGv7TAJxT0WEchSFzDgMybMrGzg5GaRfRK8Qm+1NeysGw
	 JuKfNmglMb4tw+MkB8rXL3FBN2o8nB4kFwoFae9Pe7vuJHB4yLMQiyGIU0+YjP8CXcjPJ
	 YG7w3Zv2xvgeLyfanChDL5rbbmjmVof7Z5TcBLz1MSIrQej7qAiRUHxeVoQTkCQJlcmgw
	 1e7XBY4mDt58MAw8ifiDQxval5vEZv33TDXZkMtIfnyQGOil1Dln73hw2grvb05qarhig
	 wWxkvos9MBPq4lSzDmmY7RtyV7mS6Hbr1i/wwtf1gYLiuHfJHe68YCxxE6cVeLL+Tnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795215804;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WXqwIQ9sl92uY5FIkrg/YOlMWkwy4K6T6+lK9eeLVGk=;
	b=Mkg08cJ1IzmFXF9xUVubXaTIrrQCnFDGRqe19Yosfy9AQd7OHZVxPNVkrVMOJ744WZTe
	 AVUVnDMxADJ8RuqJtrVeSs7zs3ZR9f/KpvrxwJrfY6NyaeGXnqqxRamPuRi9rRMCFuRux
	 j+pJlSiGkPfw9AqhrSxxlmcLKlc2X1pqTDfy8QFfpMDx2vXA9SckqBAWuFsHCdvMs4WKq
	 OLHN6QBwiKPGHm0QbvCJpFbH9LJou4ITvsIBLpmaK6Fx3T5tVEa8SI6nSonOJfhcTTx0e
	 dAWtMCUj0ZvH4uzj49WTbkgdSmQ0sUjcRAg+Ngj9LrXJ5rkeGm1eB+eDPEnqvv1w29g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795215804;
	bh=WXqwIQ9sl92uY5FIkrg/YOlMWkwy4K6T6+lK9eeLVGk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H/Bb91SUzUggAfkYE6N3nJQnNeiROoJB6088fSoNfUsE5FMcp9J+s42C66jBE9Pi0
	 9W6FepOWL+evtoHxaTzPkR3nle9hweT4kXkfyyTTDHBGATjtEUmnGt1MesHasH62mE
	 4tW+REH3aiCFPoLqT7PTGeFE/H6atxx3rV38lGOVtHYBBX38w5G3EUEnAeEImw5I2c
	 oQega1Da1QxSQe52hdrDafLZrOBD13pKseGLquhVZfd4/3oAsdv8s0Wvt3yQgj4q1C
	 oNEZOAhDvQJSZ0PtNXyl5ibECRNYfe7shvbAclmOg1PbNc/1vZyFvhPXUNKZwsVIHU
	 kwxa6TCd64xWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E7D9606F3;
	Fri, 20 Nov 2026 23:03:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D37361C9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 23:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B92F640208
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 23:03:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hlbQSRwV9vDj for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 23:03:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CD79B40176
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.15
Received-SPF: Temperror (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=k8KfvQEO
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CD79B40176
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 23:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795215800; x=1826751800; h=date:from:to:subject:message-id;
 bh=MfAUOKHJEsy/3fZtH0z2kxL/RbsOuAg63ZaoJlU/04U=;
 b=k8KfvQEOrMBrS8oWcUiYtX6usE8MBhazs6H0xaSCGrHpsijcGmYoutwq
 dPTDyVZCITVhZSEYyAcvrhuaU7Hs7CaiUdPOuxvcImQRDh1mcrCUtejOI
 oRlz65ERCmwgDXuW4rMufPR+iQQZLifYiewNNLCUB09VuhJAYHCoMqO4G
 goQ9vA4YBS2jaTefyHPyXhMHGBmbwgfPFrSUveoiquBZk6SuVjfXrVMhj
 kmTzazftH8qkJp/HnNmy6zuXmUK6geM0A24xl4eoGuSHBpginvISuPCN/
 eFlIylEiFbKSvNjy679nj9nKnSGk/byxeu9bf6tdy0ZMplQEOfPqMQyvN w==;
X-CSE-ConnectionGUID: TG6deDUfSEO3yuYTgaEBJg==
X-CSE-MsgGUID: Is1jHwCBRkaZXisLTkRVaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4108543"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4108543"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 15:02:08 -0800
X-CSE-ConnectionGUID: Ui7fP1+bQBSWXGchqAp20g==
X-CSE-MsgGUID: 9qYh37usSuqgO0l6dMlc3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="10934169"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 20 Nov 2026 15:02:04 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xUXcI-00000001IrI-2TuC;
 Fri, 20 Nov 2026 23:02:02 +0000
Date: Sat, 21 Nov 2026 07:01:41 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:10GbE] BUILD SUCCESS
 a0abc1e4c9d5b8b846abe4293b7bca578736da8a
Message-ID: <20261121070141.0CD1Bt2X-lkp@intel.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 10GbE
branch HEAD: a0abc1e4c9d5b8b846abe4293b7bca578736da8a  ieee802154: require CAP_NET_ADMIN for SIOCSIFADDR

elapsed time: 1071m

configs tested: 855
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261118    gcc-16.2.0
alpha                 randconfig-2000-20261119    gcc-8.5.0
alpha                 randconfig-2001-20261118    gcc-16.2.0
alpha                 randconfig-2001-20261119    gcc-8.5.0
alpha                 randconfig-2200-20261118    gcc-13.5.0 smatch
alpha                 randconfig-2200-20261119    gcc-12.5.0 smatch
alpha                randconfig-r2101-20261118    clang-17   cocci
alpha                randconfig-r2104-20261118    clang-24   cocci
alpha                randconfig-r2106-20261118    gcc-11.5.0 cocci
alpha                randconfig-r2106-20261118    gcc-16.2.0 cocci
alpha                randconfig-r2107-20261118    gcc-9.5.0  cocci
alpha                randconfig-r2108-20261118    gcc-11.5.0 cocci
alpha                randconfig-r2111-20261118    clang-22   cocci
alpha                randconfig-r2111-20261118    gcc-16.2.0 cocci
alpha                randconfig-r2304-20261118    gcc-8.5.0  sparse
alpha                randconfig-r2305-20261118    gcc-16.2.0 sparse
alpha                randconfig-r2306-20261119    gcc-14     sparse
alpha                randconfig-r2307-20261118    gcc-11.5.0 sparse
alpha                randconfig-r2308-20261118    clang-24   sparse
alpha                randconfig-r2309-20261118    clang-24   sparse
alpha                randconfig-r2309-20261118    gcc-8.5.0  sparse
alpha                randconfig-r2311-20261118    gcc-8.5.0  sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                           axs103_defconfig    clang-24
arc                       axs103_smp_defconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261120    clang-17
arc                   randconfig-1000-20261121    clang-24
arc                   randconfig-1001-20261120    clang-17
arc                   randconfig-1001-20261121    clang-24
arc                   randconfig-2000-20261118    gcc-11.5.0
arc                   randconfig-2000-20261119    gcc-14.4.0
arc                   randconfig-2001-20261118    gcc-11.5.0
arc                   randconfig-2001-20261119    gcc-14.4.0
arc                   randconfig-2002-20261118    gcc-11.5.0
arc                   randconfig-2002-20261119    gcc-14.4.0
arc                   randconfig-2003-20261118    gcc-11.5.0
arc                   randconfig-2003-20261119    gcc-14.4.0
arc                   randconfig-2004-20261118    gcc-11.5.0
arc                   randconfig-2004-20261119    gcc-14.4.0
arc                   randconfig-2005-20261118    gcc-11.5.0
arc                   randconfig-2005-20261119    gcc-14.4.0
arc                   randconfig-2200-20261118    gcc-9.5.0  smatch
arc                  randconfig-r2101-20261118    clang-24   cocci
arc                  randconfig-r2102-20261118    gcc-8.5.0  cocci
arc                  randconfig-r2104-20261118    clang-22   cocci
arc                  randconfig-r2105-20261118    clang-22   cocci
arc                  randconfig-r2106-20261118    clang-22   cocci
arc                  randconfig-r2111-20261118    gcc-8.5.0  cocci
arc                  randconfig-r2302-20261118    clang-21   sparse
arc                  randconfig-r2302-20261118    clang-24   sparse
arc                  randconfig-r2302-20261118    gcc-8.5.0  sparse
arc                  randconfig-r2303-20261118    gcc-12.5.0 sparse
arc                  randconfig-r2304-20261118    gcc-12.5.0 sparse
arc                  randconfig-r2305-20261118    gcc-8.5.0  sparse
arc                  randconfig-r2307-20261118    gcc-12.5.0 sparse
arc                  randconfig-r2307-20261118    gcc-8.5.0  sparse
arc                  randconfig-r2308-20261118    gcc-8.5.0  sparse
arc                  randconfig-r2308-20261119    gcc-14     sparse
arc                  randconfig-r2310-20261118    clang-24   sparse
arc                  randconfig-r2310-20261118    gcc-8.5.0  sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          bcm2835_defconfig    clang-24
arm                         clps711x_defconfig    gcc-16.2.0
arm                           collie_defconfig    gcc-16.2.0
arm                                  defconfig    gcc-16.2.0
arm                         multi_v7_defconfig    clang-17
arm                          mv78xx0_defconfig    gcc-16.2.0
arm                         neponset_defconfig    gcc-16.2.0
arm                        omap2plus_defconfig    gcc-16.2.0
arm                           pxa168_defconfig    gcc-16.2.0
arm                           pxa3xx_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261120    clang-17
arm                   randconfig-1000-20261121    clang-24
arm                   randconfig-1001-20261120    clang-17
arm                   randconfig-1001-20261121    clang-24
arm                   randconfig-1002-20261120    clang-17
arm                   randconfig-1002-20261121    clang-24
arm                   randconfig-1003-20261120    clang-17
arm                   randconfig-1003-20261121    clang-24
arm                   randconfig-2000-20261118    gcc-13.5.0
arm                   randconfig-2000-20261119    gcc-16.2.0
arm                   randconfig-2000-20261120    gcc-8.5.0
arm                   randconfig-2001-20261118    gcc-13.5.0
arm                   randconfig-2001-20261119    gcc-16.2.0
arm                   randconfig-2001-20261120    gcc-8.5.0
arm                   randconfig-2002-20261118    gcc-13.5.0
arm                   randconfig-2002-20261119    gcc-16.2.0
arm                   randconfig-2002-20261120    gcc-8.5.0
arm                   randconfig-2200-20261118    gcc-8.5.0  smatch
arm                   randconfig-2200-20261119    clang-24   smatch
arm                  randconfig-r2102-20261118    clang-17   cocci
arm                  randconfig-r2104-20261118    gcc-16.2.0 cocci
arm                  randconfig-r2107-20261118    clang-22   cocci
arm                  randconfig-r2107-20261118    gcc-14     cocci
arm                  randconfig-r2303-20261118    gcc-14.4.0 sparse
arm                  randconfig-r2305-20261118    clang-21   sparse
arm                  randconfig-r2306-20261118    gcc-8.5.0  sparse
arm                  randconfig-r2310-20261118    clang-24   sparse
arm                  randconfig-r2310-20261118    gcc-16.2.0 sparse
arm                              rpc_defconfig    gcc-16.2.0
arm                         shmobile_defconfig    gcc-16.2.0
arm                         spear3xx_defconfig    gcc-16.2.0
arm                         vexpress_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261120    clang-18
arm64                 randconfig-1000-20261121    gcc-8.5.0
arm64                 randconfig-1001-20261120    clang-18
arm64                 randconfig-1001-20261121    gcc-8.5.0
arm64                 randconfig-1002-20261120    clang-18
arm64                 randconfig-1002-20261121    gcc-8.5.0
arm64                 randconfig-1003-20261120    clang-18
arm64                 randconfig-1003-20261121    gcc-8.5.0
arm64                 randconfig-2000-20261118    gcc-13.5.0
arm64                 randconfig-2000-20261119    gcc-16.2.0
arm64                 randconfig-2000-20261120    gcc-8.5.0
arm64                 randconfig-2001-20261118    gcc-13.5.0
arm64                 randconfig-2001-20261119    gcc-16.2.0
arm64                 randconfig-2001-20261120    gcc-8.5.0
arm64                 randconfig-2002-20261118    gcc-13.5.0
arm64                 randconfig-2002-20261119    gcc-16.2.0
arm64                 randconfig-2002-20261120    gcc-8.5.0
arm64                 randconfig-2200-20261118    clang-24   smatch
arm64                 randconfig-2200-20261119    clang-17   smatch
arm64                randconfig-r2100-20261118    gcc-13.5.0 cocci
arm64                randconfig-r2101-20261119    clang-19   cocci
arm64                randconfig-r2103-20261118    gcc-8.5.0  cocci
arm64                randconfig-r2105-20261118    gcc-16.2.0 cocci
arm64                randconfig-r2109-20261118    clang-24   cocci
arm64                randconfig-r2109-20261118    gcc-11.5.0 cocci
arm64                randconfig-r2111-20261118    gcc-9.5.0  cocci
arm64                randconfig-r2300-20261118    gcc-12.5.0 sparse
arm64                randconfig-r2303-20261118    gcc-8.5.0  sparse
arm64                randconfig-r2304-20261118    clang-21   sparse
arm64                randconfig-r2304-20261118    clang-24   sparse
arm64                randconfig-r2306-20261118    clang-24   sparse
arm64                randconfig-r2311-20261118    gcc-8.5.0  sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261120    clang-18
csky                  randconfig-1000-20261121    gcc-8.5.0
csky                  randconfig-1001-20261120    clang-18
csky                  randconfig-1001-20261121    gcc-8.5.0
csky                  randconfig-2000-20261118    gcc-16.2.0
csky                  randconfig-2000-20261119    gcc-16.2.0
csky                  randconfig-2001-20261118    gcc-16.2.0
csky                  randconfig-2001-20261119    gcc-16.2.0
csky                  randconfig-2200-20261118    gcc-16.2.0 smatch
csky                  randconfig-2200-20261119    gcc-16.2.0 smatch
csky                 randconfig-r2101-20261118    clang-22   cocci
csky                 randconfig-r2103-20261118    clang-17   cocci
csky                 randconfig-r2104-20261118    gcc-13.5.0 cocci
csky                 randconfig-r2105-20261118    clang-17   cocci
csky                 randconfig-r2108-20261118    gcc-11.5.0 cocci
csky                 randconfig-r2111-20261118    gcc-11.5.0 cocci
csky                 randconfig-r2302-20261118    gcc-12.5.0 sparse
csky                 randconfig-r2308-20261118    clang-24   sparse
csky                 randconfig-r2308-20261118    gcc-16.2.0 sparse
csky                 randconfig-r2310-20261118    gcc-12.5.0 sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261120    gcc-10.5.0
hexagon               randconfig-1000-20261121    gcc-11.5.0
hexagon               randconfig-1001-20261120    gcc-10.5.0
hexagon               randconfig-1001-20261121    gcc-11.5.0
hexagon               randconfig-2000-20261118    gcc-16.2.0
hexagon               randconfig-2000-20261119    gcc-16.2.0
hexagon               randconfig-2001-20261118    gcc-16.2.0
hexagon               randconfig-2001-20261119    gcc-16.2.0
hexagon               randconfig-2200-20261118    clang-20   smatch
hexagon               randconfig-2200-20261119    clang-17   smatch
hexagon              randconfig-r2100-20261118    clang-17   cocci
hexagon              randconfig-r2101-20261118    gcc-8.5.0  cocci
hexagon              randconfig-r2102-20261118    clang-17   cocci
hexagon              randconfig-r2104-20261118    clang-17   cocci
hexagon              randconfig-r2106-20261118    gcc-14     cocci
hexagon              randconfig-r2106-20261118    gcc-9.5.0  cocci
hexagon              randconfig-r2111-20261118    clang-24   cocci
hexagon              randconfig-r2300-20261118    gcc-12.5.0 sparse
hexagon              randconfig-r2305-20261118    gcc-10.5.0 sparse
hexagon              randconfig-r2305-20261119    clang-24   sparse
hexagon              randconfig-r2306-20261118    gcc-8.5.0  sparse
hexagon              randconfig-r2307-20261118    clang-24   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261120    clang-22
i386        buildonly-randconfig-1000-20261121    gcc-13
i386        buildonly-randconfig-1001-20261120    clang-22
i386        buildonly-randconfig-1001-20261121    gcc-13
i386        buildonly-randconfig-1002-20261120    clang-22
i386        buildonly-randconfig-1002-20261121    gcc-13
i386        buildonly-randconfig-1003-20261120    clang-22
i386        buildonly-randconfig-1003-20261121    gcc-13
i386        buildonly-randconfig-1004-20261120    clang-22
i386        buildonly-randconfig-1004-20261121    gcc-13
i386        buildonly-randconfig-1005-20261120    clang-22
i386        buildonly-randconfig-1005-20261121    gcc-13
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261120    clang-22
i386                  randconfig-1001-20261120    clang-22
i386                  randconfig-1002-20261120    clang-22
i386                  randconfig-1003-20261120    clang-22
i386                  randconfig-1004-20261120    clang-22
i386                  randconfig-1005-20261120    clang-22
i386                  randconfig-1006-20261120    clang-22
i386                  randconfig-1007-20261120    clang-22
i386                  randconfig-1007-20261121    gcc-14
i386                  randconfig-1008-20261120    clang-22
i386                  randconfig-1008-20261121    gcc-14
i386                  randconfig-1009-20261120    clang-22
i386                  randconfig-1009-20261121    gcc-14
i386                  randconfig-1010-20261120    clang-22
i386                  randconfig-1010-20261121    gcc-14
i386                  randconfig-1011-20261120    clang-22
i386                  randconfig-1011-20261121    gcc-14
i386                  randconfig-1012-20261120    clang-22
i386                  randconfig-1012-20261121    gcc-14
i386                  randconfig-1013-20261120    clang-22
i386                  randconfig-1013-20261121    gcc-14
i386                  randconfig-2000-20261118    gcc-14
i386                  randconfig-2000-20261119    gcc-14
i386                  randconfig-2001-20261118    gcc-14
i386                  randconfig-2001-20261119    gcc-14
i386                  randconfig-2002-20261118    gcc-14
i386                  randconfig-2002-20261119    gcc-14
i386                  randconfig-2003-20261118    gcc-14
i386                  randconfig-2003-20261119    gcc-14
i386                  randconfig-2004-20261118    gcc-14
i386                  randconfig-2004-20261119    gcc-14
i386                  randconfig-2005-20261118    gcc-14
i386                  randconfig-2005-20261119    gcc-14
i386                  randconfig-2100-20261118    gcc-14     cocci
i386                  randconfig-2100-20261119    clang-22   cocci
i386                  randconfig-2101-20261118    gcc-14     cocci
i386                  randconfig-2101-20261119    clang-22   cocci
i386                  randconfig-2102-20261118    gcc-14     cocci
i386                  randconfig-2102-20261119    clang-22   cocci
i386                  randconfig-2103-20261118    gcc-14     cocci
i386                  randconfig-2103-20261119    clang-22   cocci
i386                  randconfig-2104-20261118    gcc-14     cocci
i386                  randconfig-2104-20261119    clang-22   cocci
i386                  randconfig-2105-20261118    gcc-14     cocci
i386                  randconfig-2105-20261119    clang-22   cocci
i386                  randconfig-2200-20261118    gcc-13     smatch
i386                  randconfig-2200-20261119    gcc-14     smatch
i386                  randconfig-2300-20261118    gcc-14     sparse
i386                  randconfig-2300-20261119    gcc-14     sparse
i386                  randconfig-2301-20261118    gcc-14     sparse
i386                  randconfig-2301-20261119    gcc-14     sparse
i386                  randconfig-2302-20261118    gcc-14     sparse
i386                  randconfig-2302-20261119    gcc-14     sparse
i386                 randconfig-r2100-20261118    clang-22   cocci
i386                 randconfig-r2102-20261118    gcc-14     cocci
i386                 randconfig-r2103-20261118    clang-22   cocci
i386                 randconfig-r2105-20261118    clang-22   cocci
i386                 randconfig-r2107-20261118    gcc-10.5.0 cocci
i386                 randconfig-r2107-20261118    gcc-11.5.0 cocci
i386                 randconfig-r2107-20261118    gcc-8.5.0  cocci
i386                 randconfig-r2108-20261118    clang-22   cocci
i386                 randconfig-r2108-20261118    gcc-11.5.0 cocci
i386                 randconfig-r2108-20261119    clang-24   cocci
i386                 randconfig-r2109-20261118    clang-22   cocci
i386                 randconfig-r2110-20261118    gcc-14     cocci
i386                 randconfig-r2300-20261118    gcc-8.5.0  sparse
i386                 randconfig-r2303-20261118    clang-24   sparse
i386                 randconfig-r2305-20261118    gcc-16.2.0 sparse
i386                 randconfig-r2308-20261118    clang-20   sparse
i386                 randconfig-r2309-20261118    clang-24   sparse
i386                 randconfig-r2310-20261118    gcc-11.5.0 sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261120    gcc-10.5.0
loongarch             randconfig-1000-20261121    gcc-11.5.0
loongarch             randconfig-1001-20261120    gcc-10.5.0
loongarch             randconfig-1001-20261121    gcc-11.5.0
loongarch             randconfig-2000-20261118    gcc-11.5.0
loongarch             randconfig-2000-20261119    gcc-8.5.0
loongarch             randconfig-2001-20261118    gcc-11.5.0
loongarch             randconfig-2001-20261119    gcc-8.5.0
loongarch             randconfig-2200-20261118    gcc-16.2.0 smatch
loongarch             randconfig-2200-20261119    clang-24   smatch
loongarch            randconfig-r2100-20261118    clang-24   cocci
loongarch            randconfig-r2100-20261118    gcc-8.5.0  cocci
loongarch            randconfig-r2103-20261118    gcc-11.5.0 cocci
loongarch            randconfig-r2104-20261118    clang-24   cocci
loongarch            randconfig-r2109-20261118    gcc-8.5.0  cocci
loongarch            randconfig-r2110-20261118    gcc-16.2.0 cocci
loongarch            randconfig-r2111-20261118    clang-22   cocci
loongarch            randconfig-r2301-20261118    gcc-16.2.0 sparse
loongarch            randconfig-r2302-20261118    gcc-14.4.0 sparse
loongarch            randconfig-r2303-20261118    gcc-10.5.0 sparse
loongarch            randconfig-r2311-20261118    gcc-8.5.0  sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                           hp300_defconfig    gcc-16.2.0
m68k                        m5275evb_defconfig    clang-17
m68k                        m5275evb_defconfig    clang-24
m68k                        m5275evb_defconfig    gcc-16.2.0
m68k                         mvme147_defconfig    gcc-16.2.0
m68k                         mvme16x_defconfig    gcc-16.2.0
m68k                  randconfig-2000-20261118    gcc-16.2.0
m68k                  randconfig-2000-20261119    gcc-8.5.0
m68k                  randconfig-2001-20261118    gcc-16.2.0
m68k                  randconfig-2001-20261119    gcc-8.5.0
m68k                  randconfig-2200-20261118    gcc-12.5.0 smatch
m68k                  randconfig-2200-20261119    gcc-9.5.0  smatch
m68k                 randconfig-r2101-20261118    gcc-16.2.0 cocci
m68k                 randconfig-r2101-20261118    gcc-8.5.0  cocci
m68k                 randconfig-r2103-20261118    gcc-16.2.0 cocci
m68k                 randconfig-r2104-20261118    gcc-8.5.0  cocci
m68k                 randconfig-r2105-20261118    clang-17   cocci
m68k                 randconfig-r2105-20261118    gcc-8.5.0  cocci
m68k                 randconfig-r2107-20261118    clang-22   cocci
m68k                 randconfig-r2108-20261118    gcc-16.2.0 cocci
m68k                 randconfig-r2300-20261119    clang-24   sparse
m68k                 randconfig-r2301-20261118    gcc-16.2.0 sparse
m68k                 randconfig-r2301-20261118    gcc-8.5.0  sparse
m68k                 randconfig-r2303-20261118    gcc-8.5.0  sparse
m68k                 randconfig-r2306-20261118    clang-24   sparse
m68k                 randconfig-r2308-20261118    clang-24   sparse
m68k                 randconfig-r2309-20261118    clang-24   sparse
m68k                 randconfig-r2310-20261118    clang-24   sparse
m68k                 randconfig-r2310-20261118    gcc-8.5.0  sparse
m68k                         stmark2_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261118    gcc-16.2.0
microblaze            randconfig-2000-20261119    gcc-8.5.0
microblaze            randconfig-2001-20261118    gcc-16.2.0
microblaze            randconfig-2001-20261119    gcc-8.5.0
microblaze            randconfig-2200-20261118    gcc-13.5.0 smatch
microblaze            randconfig-2200-20261119    gcc-12.5.0 smatch
microblaze           randconfig-r2101-20261118    gcc-14     cocci
microblaze           randconfig-r2102-20261118    clang-22   cocci
microblaze           randconfig-r2104-20261119    clang-19   cocci
microblaze           randconfig-r2106-20261118    clang-22   cocci
microblaze           randconfig-r2110-20261118    clang-22   cocci
microblaze           randconfig-r2305-20261118    gcc-12.5.0 sparse
microblaze           randconfig-r2305-20261118    gcc-8.5.0  sparse
microblaze           randconfig-r2311-20261118    clang-24   sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                      cu1000-neo_defconfig    gcc-16.2.0
mips                          db1xxx_defconfig    clang-24
mips                 econet_en751221_defconfig    clang-17
mips                 econet_en751221_defconfig    gcc-16.2.0
mips                           eyeq5_defconfig    gcc-16.2.0
mips                      eyeq6lplus_defconfig    gcc-16.2.0
mips                            ip30_defconfig    clang-24
mips                            ip32_defconfig    clang-17
mips                      loongson2k_defconfig    gcc-16.2.0
mips                       maltasmvp_defconfig    gcc-16.2.0
mips                  randconfig-2000-20261118    gcc-15.3.0
mips                  randconfig-2000-20261119    gcc-16.2.0
mips                  randconfig-2001-20261118    gcc-15.3.0
mips                  randconfig-2001-20261119    gcc-16.2.0
mips                  randconfig-2002-20261118    gcc-15.3.0
mips                  randconfig-2002-20261119    gcc-16.2.0
mips                  randconfig-2200-20261118    clang-24   smatch
mips                  randconfig-2200-20261119    clang-24   smatch
mips                 randconfig-r2102-20261118    clang-22   cocci
mips                 randconfig-r2102-20261118    gcc-8.5.0  cocci
mips                 randconfig-r2106-20261118    clang-24   cocci
mips                 randconfig-r2107-20261118    gcc-11.5.0 cocci
mips                 randconfig-r2107-20261119    clang-24   cocci
mips                 randconfig-r2108-20261118    clang-24   cocci
mips                 randconfig-r2111-20261118    gcc-11.5.0 cocci
mips                 randconfig-r2304-20261118    gcc-14.4.0 sparse
mips                 randconfig-r2307-20261118    clang-24   sparse
mips                 randconfig-r2307-20261118    gcc-8.5.0  sparse
mips                 randconfig-r2309-20261118    gcc-8.5.0  sparse
mips                          rt305x_defconfig    clang-17
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261120    gcc-10.5.0
nios2                 randconfig-1000-20261121    gcc-11.5.0
nios2                 randconfig-1001-20261120    gcc-10.5.0
nios2                 randconfig-1001-20261121    gcc-11.5.0
nios2                 randconfig-2000-20261118    gcc-11.5.0
nios2                 randconfig-2000-20261119    gcc-8.5.0
nios2                 randconfig-2001-20261118    gcc-11.5.0
nios2                 randconfig-2001-20261119    gcc-8.5.0
nios2                 randconfig-2200-20261118    gcc-8.5.0  smatch
nios2                 randconfig-2200-20261119    gcc-11.5.0 smatch
nios2                randconfig-r2100-20261118    clang-17   cocci
nios2                randconfig-r2102-20261119    clang-19   cocci
nios2                randconfig-r2106-20261118    gcc-11.5.0 cocci
nios2                randconfig-r2108-20261118    gcc-8.5.0  cocci
nios2                randconfig-r2109-20261118    gcc-9.5.0  cocci
nios2                randconfig-r2300-20261118    gcc-8.5.0  sparse
nios2                randconfig-r2304-20261118    gcc-10.5.0 sparse
nios2                randconfig-r2308-20261118    clang-24   sparse
nios2                randconfig-r2309-20261118    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc          de0_nano_multicore_defconfig    clang-17
openrisc          de0_nano_multicore_defconfig    gcc-16.2.0
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261118    gcc-15.3.0
openrisc              randconfig-2000-20261119    gcc-16.2.0
openrisc              randconfig-2001-20261118    gcc-15.3.0
openrisc              randconfig-2001-20261119    gcc-16.2.0
openrisc              randconfig-2002-20261118    gcc-15.3.0
openrisc              randconfig-2002-20261119    gcc-16.2.0
openrisc              randconfig-2200-20261118    gcc-16.2.0 smatch
openrisc              randconfig-2200-20261119    gcc-16.2.0 smatch
openrisc             randconfig-r2100-20261118    clang-22   cocci
openrisc             randconfig-r2100-20261118    gcc-14     cocci
openrisc             randconfig-r2100-20261118    gcc-16.2.0 cocci
openrisc             randconfig-r2101-20261118    gcc-11.5.0 cocci
openrisc             randconfig-r2102-20261118    clang-24   cocci
openrisc             randconfig-r2103-20261118    gcc-11.5.0 cocci
openrisc             randconfig-r2104-20261118    clang-22   cocci
openrisc             randconfig-r2105-20261118    gcc-13.5.0 cocci
openrisc             randconfig-r2106-20261118    gcc-8.5.0  cocci
openrisc             randconfig-r2106-20261119    clang-24   cocci
openrisc             randconfig-r2107-20261118    gcc-16.2.0 cocci
openrisc             randconfig-r2108-20261118    clang-22   cocci
openrisc             randconfig-r2108-20261118    gcc-16.2.0 cocci
openrisc             randconfig-r2109-20261118    gcc-10.5.0 cocci
openrisc             randconfig-r2111-20261118    gcc-14     cocci
openrisc             randconfig-r2301-20261118    gcc-12.5.0 sparse
openrisc             randconfig-r2302-20261118    gcc-16.2.0 sparse
openrisc             randconfig-r2302-20261118    gcc-8.5.0  sparse
openrisc             randconfig-r2304-20261118    gcc-16.2.0 sparse
openrisc             randconfig-r2306-20261118    gcc-16.2.0 sparse
openrisc             randconfig-r2307-20261118    gcc-16.2.0 sparse
openrisc             randconfig-r2307-20261118    gcc-8.5.0  sparse
openrisc             randconfig-r2311-20261118    clang-20   sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                 generic-32bit_defconfig    gcc-16.2.0
parisc                 generic-64bit_defconfig    clang-17
parisc                randconfig-1000-20261120    gcc-11.5.0
parisc                randconfig-1000-20261121    gcc-10.5.0
parisc                randconfig-1001-20261120    gcc-11.5.0
parisc                randconfig-1001-20261121    gcc-10.5.0
parisc                randconfig-2000-20261118    gcc-11.5.0
parisc                randconfig-2000-20261119    gcc-8.5.0
parisc                randconfig-2001-20261118    gcc-11.5.0
parisc                randconfig-2001-20261119    gcc-8.5.0
parisc                randconfig-2200-20261118    gcc-11.5.0 smatch
parisc                randconfig-2200-20261119    gcc-14.4.0 smatch
parisc               randconfig-r2103-20261118    clang-24   cocci
parisc               randconfig-r2105-20261119    clang-19   cocci
parisc               randconfig-r2111-20261118    gcc-16.2.0 cocci
parisc               randconfig-r2301-20261118    gcc-14.4.0 sparse
parisc               randconfig-r2306-20261118    gcc-11.5.0 sparse
parisc               randconfig-r2308-20261118    gcc-12.5.0 sparse
parisc               randconfig-r2308-20261118    gcc-8.5.0  sparse
parisc               randconfig-r2309-20261118    clang-20   sparse
parisc               randconfig-r2310-20261118    gcc-8.5.0  sparse
parisc               randconfig-r2311-20261118    gcc-11.5.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       bamboo_defconfig    gcc-16.2.0
powerpc                       chrp32_defconfig    gcc-16.2.0
powerpc                       ep88xc_defconfig    gcc-16.2.0
powerpc                           g5_defconfig    gcc-16.2.0
powerpc                         icon_defconfig    gcc-16.2.0
powerpc                      mpc5200_defconfig    clang-24
powerpc                  mpc834x_itx_defconfig    gcc-16.2.0
powerpc                     mvme5100_defconfig    gcc-16.2.0
powerpc                       pmac32_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261120    gcc-11.5.0
powerpc               randconfig-1000-20261121    gcc-10.5.0
powerpc               randconfig-1001-20261120    gcc-11.5.0
powerpc               randconfig-1001-20261121    gcc-10.5.0
powerpc               randconfig-2000-20261118    clang-21
powerpc               randconfig-2000-20261119    gcc-15.3.0
powerpc               randconfig-2001-20261118    clang-21
powerpc               randconfig-2001-20261119    gcc-15.3.0
powerpc               randconfig-2002-20261118    clang-21
powerpc               randconfig-2002-20261119    gcc-15.3.0
powerpc               randconfig-2200-20261118    clang-24   smatch
powerpc               randconfig-2200-20261119    gcc-13.5.0 smatch
powerpc              randconfig-r2100-20261119    clang-19   cocci
powerpc              randconfig-r2103-20261118    gcc-13.5.0 cocci
powerpc              randconfig-r2105-20261118    gcc-14     cocci
powerpc              randconfig-r2111-20261118    gcc-10.5.0 cocci
powerpc              randconfig-r2111-20261118    gcc-11.5.0 cocci
powerpc              randconfig-r2300-20261118    gcc-10.5.0 sparse
powerpc              randconfig-r2306-20261118    clang-24   sparse
powerpc              randconfig-r2310-20261119    gcc-14     sparse
powerpc              randconfig-r2311-20261118    clang-24   sparse
powerpc                      skiroot_defconfig    clang-24
powerpc                      taishan_defconfig    gcc-16.2.0
powerpc                      tqm8548_defconfig    clang-24
powerpc64             randconfig-1000-20261120    gcc-11.5.0
powerpc64             randconfig-1000-20261121    gcc-10.5.0
powerpc64             randconfig-1001-20261120    gcc-11.5.0
powerpc64             randconfig-1001-20261121    gcc-10.5.0
powerpc64             randconfig-2000-20261118    clang-21
powerpc64             randconfig-2000-20261119    gcc-15.3.0
powerpc64             randconfig-2001-20261118    clang-21
powerpc64             randconfig-2001-20261119    gcc-15.3.0
powerpc64             randconfig-2002-20261118    clang-21
powerpc64             randconfig-2002-20261119    gcc-15.3.0
powerpc64             randconfig-2200-20261118    clang-24   smatch
powerpc64             randconfig-2200-20261119    clang-24   smatch
powerpc64            randconfig-r2100-20261118    gcc-11.5.0 cocci
powerpc64            randconfig-r2106-20261118    gcc-10.5.0 cocci
powerpc64            randconfig-r2107-20261118    clang-24   cocci
powerpc64            randconfig-r2110-20261118    gcc-9.5.0  cocci
powerpc64            randconfig-r2301-20261118    clang-21   sparse
powerpc64            randconfig-r2301-20261118    gcc-8.5.0  sparse
powerpc64            randconfig-r2303-20261118    gcc-12.5.0 sparse
powerpc64            randconfig-r2305-20261118    gcc-12.5.0 sparse
powerpc64            randconfig-r2305-20261118    gcc-14.4.0 sparse
powerpc64            randconfig-r2306-20261118    gcc-8.5.0  sparse
powerpc64            randconfig-r2311-20261118    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261120    gcc-11.5.0
riscv                 randconfig-1000-20261121    clang-17
riscv                 randconfig-1001-20261120    gcc-11.5.0
riscv                 randconfig-1001-20261121    clang-17
riscv                 randconfig-2000-20261118    gcc-8.5.0
riscv                 randconfig-2000-20261119    clang-24
riscv                 randconfig-2000-20261120    clang-24
riscv                 randconfig-2001-20261118    gcc-8.5.0
riscv                 randconfig-2001-20261119    clang-24
riscv                 randconfig-2001-20261120    clang-24
riscv                 randconfig-2002-20261118    gcc-8.5.0
riscv                 randconfig-2002-20261119    clang-24
riscv                 randconfig-2002-20261120    clang-24
riscv                 randconfig-2003-20261118    gcc-8.5.0
riscv                 randconfig-2003-20261119    clang-24
riscv                 randconfig-2003-20261120    clang-24
riscv                 randconfig-2004-20261118    gcc-8.5.0
riscv                 randconfig-2004-20261119    clang-24
riscv                 randconfig-2004-20261120    clang-24
riscv                 randconfig-2005-20261118    gcc-8.5.0
riscv                 randconfig-2005-20261119    clang-24
riscv                 randconfig-2005-20261120    clang-24
riscv                 randconfig-2200-20261118    clang-24   smatch
riscv                 randconfig-2200-20261119    clang-24   smatch
riscv                randconfig-r2100-20261118    gcc-8.5.0  cocci
riscv                randconfig-r2101-20261118    clang-17   cocci
riscv                randconfig-r2103-20261118    clang-24   cocci
riscv                randconfig-r2108-20261118    gcc-14     cocci
riscv                randconfig-r2108-20261118    gcc-9.5.0  cocci
riscv                randconfig-r2110-20261118    clang-24   cocci
riscv                randconfig-r2110-20261118    gcc-10.5.0 cocci
riscv                randconfig-r2300-20261118    gcc-16.2.0 sparse
riscv                randconfig-r2302-20261119    clang-24   sparse
riscv                randconfig-r2304-20261118    gcc-8.5.0  sparse
riscv                randconfig-r2305-20261118    clang-24   sparse
riscv                randconfig-r2306-20261118    gcc-12.5.0 sparse
riscv                randconfig-r2307-20261118    clang-24   sparse
riscv                randconfig-r2309-20261119    gcc-14     sparse
riscv                randconfig-r2310-20261118    gcc-8.5.0  sparse
riscv                randconfig-r2311-20261118    gcc-12.5.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261120    gcc-11.5.0
s390                  randconfig-1000-20261121    clang-17
s390                  randconfig-1001-20261120    gcc-11.5.0
s390                  randconfig-1001-20261121    clang-17
s390                  randconfig-2000-20261118    clang-24
s390                  randconfig-2000-20261119    clang-20
s390                  randconfig-2001-20261118    clang-24
s390                  randconfig-2001-20261118    gcc-12.5.0
s390                  randconfig-2001-20261119    clang-20
s390                  randconfig-2002-20261118    clang-19
s390                  randconfig-2002-20261118    clang-24
s390                  randconfig-2002-20261119    clang-20
s390                  randconfig-2003-20261118    clang-24
s390                  randconfig-2003-20261118    gcc-8.5.0
s390                  randconfig-2003-20261119    clang-20
s390                  randconfig-2004-20261118    clang-24
s390                  randconfig-2004-20261119    clang-20
s390                  randconfig-2005-20261118    clang-24
s390                  randconfig-2005-20261119    clang-20
s390                  randconfig-2200-20261118    gcc-8.5.0  smatch
s390                  randconfig-2200-20261119    clang-24   smatch
s390                 randconfig-r2103-20261118    clang-22   cocci
s390                 randconfig-r2103-20261119    clang-19   cocci
s390                 randconfig-r2105-20261118    clang-24   cocci
s390                 randconfig-r2108-20261118    gcc-10.5.0 cocci
s390                 randconfig-r2109-20261118    gcc-11.5.0 cocci
s390                 randconfig-r2109-20261118    gcc-16.2.0 cocci
s390                 randconfig-r2111-20261119    clang-24   cocci
s390                 randconfig-r2300-20261118    gcc-16.2.0 sparse
s390                 randconfig-r2303-20261118    gcc-16.2.0 sparse
s390                 randconfig-r2303-20261119    clang-24   sparse
s390                 randconfig-r2304-20261119    clang-24   sparse
s390                 randconfig-r2307-20261118    clang-20   sparse
s390                 randconfig-r2309-20261118    clang-24   sparse
s390                 randconfig-r2310-20261118    clang-20   sparse
s390                 randconfig-r2311-20261118    gcc-8.5.0  sparse
s390                        zfcpdump_defconfig    gcc-16.2.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    gcc-16.2.0
sh                 ecovec24-romimage_defconfig    gcc-16.2.0
sh                                j2_defconfig    gcc-16.2.0
sh                           kfr2r09_defconfig    gcc-16.2.0
sh                           r7785rp_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261120    gcc-11.5.0
sh                    randconfig-1000-20261121    clang-17
sh                    randconfig-1001-20261120    gcc-11.5.0
sh                    randconfig-1001-20261121    clang-17
sh                    randconfig-2000-20261118    gcc-9.5.0
sh                    randconfig-2000-20261119    gcc-12.5.0
sh                    randconfig-2001-20261118    gcc-9.5.0
sh                    randconfig-2001-20261119    gcc-12.5.0
sh                    randconfig-2002-20261118    gcc-9.5.0
sh                    randconfig-2002-20261119    gcc-12.5.0
sh                    randconfig-2003-20261118    gcc-9.5.0
sh                    randconfig-2003-20261119    gcc-12.5.0
sh                    randconfig-2004-20261118    gcc-9.5.0
sh                    randconfig-2004-20261119    gcc-12.5.0
sh                    randconfig-2005-20261118    gcc-9.5.0
sh                    randconfig-2005-20261119    gcc-12.5.0
sh                    randconfig-2200-20261118    gcc-13.5.0 smatch
sh                    randconfig-2200-20261119    gcc-16.2.0 smatch
sh                   randconfig-r2101-20261118    gcc-13.5.0 cocci
sh                   randconfig-r2102-20261118    gcc-11.5.0 cocci
sh                   randconfig-r2104-20261118    gcc-11.5.0 cocci
sh                   randconfig-r2105-20261118    gcc-8.5.0  cocci
sh                   randconfig-r2106-20261118    gcc-11.5.0 cocci
sh                   randconfig-r2300-20261118    clang-24   sparse
sh                   randconfig-r2303-20261118    gcc-16.2.0 sparse
sh                   randconfig-r2307-20261118    clang-24   sparse
sh                            se7780_defconfig    clang-17
sh                    secureedge5410_defconfig    gcc-16.2.0
sh                         sh7785lcr_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261120    clang-24
sparc                 randconfig-1000-20261121    gcc-14
sparc                 randconfig-1001-20261120    clang-24
sparc                 randconfig-1001-20261121    gcc-14
sparc                 randconfig-2000-20261118    clang-24
sparc                 randconfig-2000-20261119    clang-21
sparc                 randconfig-2001-20261118    clang-24
sparc                 randconfig-2001-20261119    clang-21
sparc                 randconfig-2200-20261118    gcc-13.5.0 smatch
sparc                 randconfig-2200-20261119    gcc-8.5.0  smatch
sparc                randconfig-r2100-20261118    gcc-11.5.0 cocci
sparc                randconfig-r2102-20261118    gcc-16.2.0 cocci
sparc                randconfig-r2103-20261118    gcc-8.5.0  cocci
sparc                randconfig-r2105-20261118    clang-24   cocci
sparc                randconfig-r2110-20261118    clang-22   cocci
sparc                randconfig-r2110-20261118    gcc-11.5.0 cocci
sparc                randconfig-r2301-20261118    gcc-12.5.0 sparse
sparc                randconfig-r2301-20261119    clang-24   sparse
sparc                randconfig-r2307-20261118    gcc-8.5.0  sparse
sparc                randconfig-r2309-20261118    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261120    clang-24
sparc64               randconfig-1000-20261121    gcc-14
sparc64               randconfig-1001-20261120    clang-24
sparc64               randconfig-1001-20261121    gcc-14
sparc64               randconfig-2000-20261118    clang-24
sparc64               randconfig-2000-20261119    clang-21
sparc64               randconfig-2001-20261118    clang-24
sparc64               randconfig-2001-20261119    clang-21
sparc64               randconfig-2200-20261118    clang-22   smatch
sparc64               randconfig-2200-20261119    gcc-13.5.0 smatch
sparc64              randconfig-r2101-20261118    clang-24   cocci
sparc64              randconfig-r2101-20261118    gcc-11.5.0 cocci
sparc64              randconfig-r2103-20261118    gcc-14     cocci
sparc64              randconfig-r2104-20261118    gcc-8.5.0  cocci
sparc64              randconfig-r2109-20261118    gcc-11.5.0 cocci
sparc64              randconfig-r2109-20261119    clang-24   cocci
sparc64              randconfig-r2301-20261118    gcc-10.5.0 sparse
sparc64              randconfig-r2302-20261118    gcc-12.5.0 sparse
sparc64              randconfig-r2310-20261118    clang-24   sparse
sparc64              randconfig-r2311-20261118    clang-24   sparse
sparc64              randconfig-r2311-20261118    gcc-16.2.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                              i386_defconfig    gcc-16.2.0
um                    randconfig-1000-20261120    clang-24
um                    randconfig-1000-20261121    gcc-14
um                    randconfig-1001-20261120    clang-24
um                    randconfig-1001-20261121    gcc-14
um                    randconfig-2000-20261118    clang-24
um                    randconfig-2000-20261119    clang-21
um                    randconfig-2001-20261118    clang-24
um                    randconfig-2001-20261119    clang-21
um                    randconfig-2200-20261118    clang-24   smatch
um                    randconfig-2200-20261120    clang-24   smatch
um                   randconfig-r2100-20261118    clang-24   cocci
um                   randconfig-r2102-20261118    clang-24   cocci
um                   randconfig-r2102-20261118    gcc-13.5.0 cocci
um                   randconfig-r2105-20261118    gcc-11.5.0 cocci
um                   randconfig-r2109-20261118    gcc-16.2.0 cocci
um                   randconfig-r2110-20261119    clang-24   cocci
um                   randconfig-r2300-20261118    clang-21   sparse
um                   randconfig-r2300-20261118    gcc-14.4.0 sparse
um                   randconfig-r2302-20261118    gcc-10.5.0 sparse
um                   randconfig-r2302-20261118    gcc-16.2.0 sparse
um                   randconfig-r2303-20261118    clang-21   sparse
um                   randconfig-r2306-20261118    clang-24   sparse
um                   randconfig-r2307-20261118    clang-24   sparse
um                   randconfig-r2308-20261118    clang-24   sparse
um                   randconfig-r2308-20261118    gcc-11.5.0 sparse
um                   randconfig-r2311-20261118    clang-24   sparse
um                   randconfig-r2311-20261119    gcc-14     sparse
um                            x86_64_defconfig    gcc-14
x86_64                            alldefconfig    gcc-16.2.0
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261120    clang-22
x86_64      buildonly-randconfig-1000-20261121    clang-22
x86_64      buildonly-randconfig-1001-20261120    clang-22
x86_64      buildonly-randconfig-1001-20261121    clang-22
x86_64      buildonly-randconfig-1002-20261120    clang-22
x86_64      buildonly-randconfig-1002-20261121    clang-22
x86_64      buildonly-randconfig-1003-20261120    clang-22
x86_64      buildonly-randconfig-1003-20261121    clang-22
x86_64      buildonly-randconfig-1004-20261120    clang-22
x86_64      buildonly-randconfig-1004-20261121    clang-22
x86_64      buildonly-randconfig-1005-20261120    clang-22
x86_64      buildonly-randconfig-1005-20261121    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261120    clang-22
x86_64                randconfig-1000-20261121    clang-22
x86_64                randconfig-1001-20261120    clang-22
x86_64                randconfig-1001-20261121    clang-22
x86_64                randconfig-1002-20261120    clang-22
x86_64                randconfig-1002-20261121    clang-22
x86_64                randconfig-1003-20261120    clang-22
x86_64                randconfig-1003-20261121    clang-22
x86_64                randconfig-1004-20261120    clang-22
x86_64                randconfig-1004-20261121    clang-22
x86_64                randconfig-1005-20261120    clang-22
x86_64                randconfig-1005-20261121    clang-22
x86_64                randconfig-1006-20261120    clang-22
x86_64                randconfig-1007-20261120    clang-22
x86_64                randconfig-1008-20261120    clang-22
x86_64                randconfig-1009-20261120    clang-22
x86_64                randconfig-1010-20261120    clang-22
x86_64                randconfig-1011-20261120    clang-22
x86_64                randconfig-1012-20261120    clang-22
x86_64                randconfig-1013-20261120    clang-22
x86_64                randconfig-1014-20261120    clang-22
x86_64                randconfig-1015-20261120    clang-22
x86_64                randconfig-1016-20261120    clang-22
x86_64                randconfig-1017-20261120    clang-22
x86_64                randconfig-2000-20261118    gcc-13
x86_64                randconfig-2000-20261119    clang-22
x86_64                randconfig-2001-20261118    gcc-13
x86_64                randconfig-2001-20261119    clang-22
x86_64                randconfig-2002-20261118    gcc-13
x86_64                randconfig-2002-20261119    clang-22
x86_64                randconfig-2003-20261118    gcc-13
x86_64                randconfig-2003-20261119    clang-22
x86_64                randconfig-2004-20261118    gcc-13
x86_64                randconfig-2004-20261119    clang-22
x86_64                randconfig-2005-20261118    gcc-13
x86_64                randconfig-2005-20261119    clang-22
x86_64                randconfig-2100-20261118    clang-22   cocci
x86_64                randconfig-2100-20261119    clang-22   cocci
x86_64                randconfig-2101-20261118    clang-22   cocci
x86_64                randconfig-2101-20261119    clang-22   cocci
x86_64                randconfig-2102-20261118    clang-22   cocci
x86_64                randconfig-2102-20261119    clang-22   cocci
x86_64                randconfig-2103-20261118    clang-22   cocci
x86_64                randconfig-2103-20261119    clang-22   cocci
x86_64                randconfig-2104-20261118    clang-22   cocci
x86_64                randconfig-2104-20261119    clang-22   cocci
x86_64                randconfig-2105-20261118    clang-22   cocci
x86_64                randconfig-2105-20261119    clang-22   cocci
x86_64                randconfig-2200-20261118    clang-22   smatch
x86_64                randconfig-2200-20261119    clang-22   smatch
x86_64                randconfig-2300-20261118    gcc-14     sparse
x86_64                randconfig-2300-20261119    gcc-14     sparse
x86_64                randconfig-2301-20261118    gcc-14     sparse
x86_64                randconfig-2301-20261119    gcc-14     sparse
x86_64                randconfig-2302-20261118    gcc-14     sparse
x86_64                randconfig-2302-20261119    gcc-14     sparse
x86_64               randconfig-r2102-20261118    gcc-11.5.0 cocci
x86_64               randconfig-r2104-20261118    gcc-14     cocci
x86_64               randconfig-r2105-20261118    gcc-11.5.0 cocci
x86_64               randconfig-r2109-20261118    gcc-14     cocci
x86_64               randconfig-r2110-20261118    gcc-8.5.0  cocci
x86_64               randconfig-r2307-20261119    gcc-14     sparse
x86_64               randconfig-r2309-20261118    clang-24   sparse
x86_64               randconfig-r2309-20261118    gcc-12.5.0 sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                            alldefconfig    gcc-16.2.0
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   cadence_csp_defconfig    gcc-16.2.0
xtensa                        common_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261120    clang-24
xtensa                randconfig-1000-20261121    gcc-14
xtensa                randconfig-1001-20261120    clang-24
xtensa                randconfig-1001-20261121    gcc-14
xtensa                randconfig-2000-20261118    gcc-16.2.0
xtensa                randconfig-2000-20261119    gcc-16.2.0
xtensa                randconfig-2001-20261118    gcc-16.2.0
xtensa                randconfig-2001-20261119    gcc-16.2.0
xtensa                randconfig-2200-20261118    gcc-15.3.0 smatch
xtensa                randconfig-2200-20261119    gcc-14.4.0 smatch
xtensa               randconfig-r2101-20261118    clang-22   cocci
xtensa               randconfig-r2106-20261118    gcc-16.2.0 cocci
xtensa               randconfig-r2107-20261118    gcc-11.5.0 cocci
xtensa               randconfig-r2107-20261118    gcc-16.2.0 cocci
xtensa               randconfig-r2110-20261118    gcc-11.5.0 cocci
xtensa               randconfig-r2301-20261118    clang-24   sparse
xtensa               randconfig-r2304-20261118    gcc-12.5.0 sparse
xtensa               randconfig-r2304-20261118    gcc-16.2.0 sparse
xtensa               randconfig-r2306-20261118    clang-20   sparse
xtensa               randconfig-r2308-20261118    gcc-8.5.0  sparse
xtensa               randconfig-r2309-20261118    gcc-11.5.0 sparse
xtensa               randconfig-r2309-20261118    gcc-16.2.0 sparse
xtensa                     xip_kc705_defconfig    gcc-16.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
