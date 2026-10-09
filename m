Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF1CCA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 12:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 828D640850;
	Fri,  9 Oct 2026 12:40:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZtsJ1sqPRNZh; Fri,  9 Oct 2026 12:40:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34FF340852
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791549625;
	b=l9KIuUSrlQHphcvLxUiS5DNSXrYgua1jecoM8qxF4oaQTr8+jFI9YpqkpeOunHfLJl3m
	 BNmwzebSOkICRmuexHDH1cq1ddC2/eZ6MfXtIu1CpBs5HFRaGk6T2/GTtHAIfVBbzeRsw
	 6zcaOdbNLTk7kyCKvzgG+ykpHipKNx/a5E1YFButF9kOA66zpBBUAqKgIU20PagIEkwFm
	 sE52NATqpE4IHq9H6lLFAqyzSutNSLXDjGdLLWkLEo8LQQO+tUXPLs5k/m9AXQ9FEL46b
	 agYWKhTVjnHOlBiEGnFVgD4okp8FCuWSnWNzZUTJkxiYV7yL4u8TO08EAQsFdGuNxIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791549625;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5ZzXIuTtadhI/UCbe5pnZLWBy0RcH0ww0Yi09fUJXGM=;
	b=odjlAXhVgCG+iweU++AnQu+nVHKkEZUQGln+dBCD0D1Kvh/2FBLBHvGIs2N5kmu6dm4R
	 Zkedh44TNRVqYtRhemU5UdtJBvUCz0Y/M9Fun+wddWCqfuejUEKPBWycVg38fq8zi0I75
	 ybeYP9WC+Osgs9tNXdDAfcSVIzU3Tfcjonncg2XwwRK4DzdpzXqVvgTduJ7VIJxx++fvz
	 2GLsg5use+wWpprmPPgJPJ6nZ4HxkT0YxI/71yJPfZzJXK5ZzDKZTl28P7LuO5fCC/sK5
	 XihoATkfu912VKouHk2ENkZk5LTbA4+EnJPsSR2hlOBxgBo21W5mkyP8k+2Fqqd0wQw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791549625;
	bh=5ZzXIuTtadhI/UCbe5pnZLWBy0RcH0ww0Yi09fUJXGM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hJepF65B1Jm7Yfz4UMEpERZ2msKIuIuXKuyuEFfXz9JXTJv74td3TtFCLkTjUJtqU
	 M0NEUiYMYQgWsT1EQQ/NvOH7DoUqK19dtgM2HwhOB2J6pybuWUzKxUGmhAQO6gH125
	 vliIGbvrFrHTIGj/lLW42Z98Mo5nBNgRL/PzElYRm3FsQfqd9CTMxA0Bdp/70TVQUP
	 lBRcb8/Gs17izlYKUTU68v4UBudQlxMjOwUf7l/adpI6HF9aWYmAFuohjQiSOWvbAG
	 GWXUHsvsrvb1B3jYupNgdbK00cf61giNE3tPvxkq40YNAQqMRExqwXTKNgf+705ScN
	 2Y8lrRapKhCNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34FF340852;
	Fri,  9 Oct 2026 12:40:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF954422
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5A71400AB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:40:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6U-TUY4bzo_7 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 12:40:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1A87D40061
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791549622;
 b=ooB1L/V7mxdsqoagD4IKtlF5B08iyTvalsXsBsuakXjvESikyRACev1pERnX7gBPiHEI
 M1WmcDbh594Xdh3A8OxXDoXd17J5n8uAm4nqAqDK3hQAvD8o9yK96kIzPQO7ZBIHsbF2k
 66rlu+4R/z7pW+7LzdmYQPT2P/w2MROwSRC5eHN1tkppIuaw9SZ/el/YpxTE0e2EdZEcZ
 w54qZ8N4KNNubwHMR4R96N03TW2PR4hODH5sXUTIWpCaUWR6JEpHAziT0LXiJT+0xxykL
 GOzIIWteZZB1tLN2LyRPCSfepB4BioLzDkWjjlKum2GfWmqMr8pXqwjzq/qfViF1+AQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791549622;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=5ZzXIuTtadhI/UCbe5pnZLWBy0RcH0ww0Yi09fUJXGM=;
 b=LeCGUc9xTf06nNBmJW+ZqlKqGWEvbCxAPWD+ezNwt/v0AIehknh18AwZmSlT2e6bwdtc
 DsdjqfCIVrLs0yDplhjjk8U8nRfpkwKwHpkHUEQNeNBlv6aR/5B+F3Q/R40zTrG4q2w5v
 uw3PE8aEVJKXQ8C14yjba53gt9gOwWzMQ2dRY3czOyCGhogdS+cGvyYSyJaadyzUjlAJd
 vknYrZYOuSaID5QI5iqPRwDa/c1WD5r3+krmwp99sqOXrGGsQ7BYS3yglqa7Emw6cKQB1
 rX7cerOzp0IH5k6RbkCDUIlSmftOKOM67CQIBIqg1Gnv6BMtJSj4qW+RWOtQNxZOuaA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aQlmBxyo; 
 arc=none smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aQlmBxyo
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A87D40061
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791549622; x=1823085622; h=date:from:to:subject:message-id;
 bh=tvjCKxNMBMQ1nXMmIUrkiP2v9WoOKjzpEMOQSdjdKx8=;
 b=aQlmBxyosRZfj2Sho6VnFUfz2koRY7xvX/GwNfHmP9XqzbTosgx7rH3j
 C7ImbsK6bTsj6rpsMURwnP9+t5Iy0Y1fE2kKsmfVjVjZSwWF5/GuEysWd
 tUC1fJJThjEscXFxxGPBm0ere3VLhcBWrQNQdYlySV7GSQX09hjS8cokC
 25y1mSbdrmI42kyD1l7JIcTPS0XbMtldqDn3RUaEogGpAsgB3OKC+C3NK
 tcBkUNVafvdlIActHMAk0bBxTBTZo9bGe1r+YF/WysIFWagr2hlC6Ojru
 4JyyJojGEe09Axx+yO+SwVPkM9VMW28SJ4+fvWS++671KNBWl6r+Y7DiV Q==;
X-CSE-ConnectionGUID: tr4sDx5LQy+0lqOVDbzTkQ==
X-CSE-MsgGUID: uT4ACHFzQkaTCv4s+5KEQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="244240"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="244240"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 05:40:21 -0700
X-CSE-ConnectionGUID: oJFKnCSET+SdPUuBZn+3cw==
X-CSE-MsgGUID: IKK7Vem/T1O5WwHzix+Png==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="429233"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:40:19 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xF9tZ-000000005kq-2Ytx;
 Fri, 09 Oct 2026 12:40:17 +0000
Date: Fri, 09 Oct 2026 20:40:08 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:main] BUILD SUCCESS
 ab699d296e066eb64f51d2a8a1d42237a3b186c8
Message-ID: <202610092005.rNROyrAj-lkp@intel.com>
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
branch HEAD: ab699d296e066eb64f51d2a8a1d42237a3b186c8  Merge branch 'net-always-dissect-gso-packets-in-__virtio_net_hdr_to_skb'

elapsed time: 1421m

configs tested: 369
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2102-20261007    clang-17   cocci
alpha                randconfig-r2104-20261007    gcc-8.5.0  cocci
alpha                randconfig-r2202-20261007    gcc-8.5.0  smatch
alpha                randconfig-r2302-20261007    clang-24   sparse
alpha                randconfig-r2304-20261007    gcc-14.3.0 sparse
alpha                randconfig-r2305-20261007    clang-17   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261009    gcc-10.5.0
arc                   randconfig-1001-20261009    gcc-10.5.0
arc                  randconfig-r2100-20261007    clang-20   cocci
arc                  randconfig-r2101-20261007    gcc-15.2.0 cocci
arc                  randconfig-r2102-20261007    gcc-15.2.0 cocci
arc                  randconfig-r2103-20261007    gcc-11.5.0 cocci
arc                  randconfig-r2107-20261007    gcc-10.5.0 cocci
arc                  randconfig-r2107-20261007    gcc-8.5.0  cocci
arc                  randconfig-r2202-20261007    gcc-8.5.0  smatch
arc                  randconfig-r2304-20261007    clang-17   sparse
arc                  randconfig-r2305-20261007    gcc-16.1.0 sparse
arc                  randconfig-r2306-20261007    clang-24   sparse
arc                  randconfig-r2309-20261007    gcc-8.5.0  sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          bcm2835_defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                             mps2_defconfig    clang-24
arm                   randconfig-1000-20261009    gcc-10.5.0
arm                   randconfig-1001-20261009    gcc-10.5.0
arm                   randconfig-1002-20261009    gcc-10.5.0
arm                   randconfig-1003-20261009    gcc-10.5.0
arm                  randconfig-r2100-20261007    clang-17   cocci
arm                  randconfig-r2103-20261007    gcc-15.2.0 cocci
arm                  randconfig-r2104-20261007    gcc-12.5.0 cocci
arm                  randconfig-r2104-20261007    gcc-8.5.0  cocci
arm                  randconfig-r2107-20261007    gcc-16.1.0 cocci
arm                  randconfig-r2202-20261007    gcc-12.5.0 smatch
arm                  randconfig-r2304-20261007    clang-20   sparse
arm                  randconfig-r2306-20261007    gcc-14     sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261009    gcc-15.2.0
arm64                 randconfig-1001-20261009    gcc-15.2.0
arm64                 randconfig-1002-20261009    gcc-15.2.0
arm64                 randconfig-1003-20261009    gcc-15.2.0
arm64                randconfig-r2102-20261007    gcc-8.5.0  cocci
arm64                randconfig-r2104-20261007    gcc-8.5.0  cocci
arm64                randconfig-r2106-20261007    clang-22   cocci
arm64                randconfig-r2107-20261007    gcc-8.5.0  cocci
arm64                randconfig-r2201-20261007    clang-24   smatch
arm64                randconfig-r2300-20261007    gcc-16.1.0 sparse
arm64                randconfig-r2301-20261007    clang-17   sparse
arm64                randconfig-r2301-20261007    clang-24   sparse
arm64                randconfig-r2301-20261007    gcc-16.1.0 sparse
arm64                randconfig-r2303-20261007    clang-17   sparse
arm64                randconfig-r2305-20261007    clang-20   sparse
arm64                randconfig-r2309-20261007    clang-24   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261009    gcc-15.2.0
csky                  randconfig-1001-20261009    gcc-15.2.0
csky                 randconfig-r2100-20261007    gcc-10.5.0 cocci
csky                 randconfig-r2104-20261007    gcc-16.1.0 cocci
csky                 randconfig-r2305-20261007    clang-24   sparse
csky                 randconfig-r2308-20261007    gcc-14     sparse
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261009    clang-18
hexagon               randconfig-1001-20261009    clang-18
hexagon              randconfig-r2102-20261007    clang-20   cocci
hexagon              randconfig-r2103-20261007    gcc-8.5.0  cocci
hexagon              randconfig-r2105-20261007    gcc-8.5.0  cocci
hexagon              randconfig-r2106-20261007    gcc-8.5.0  cocci
hexagon              randconfig-r2107-20261007    clang-22   cocci
hexagon              randconfig-r2200-20261007    clang-24   smatch
hexagon              randconfig-r2201-20261007    clang-24   smatch
hexagon              randconfig-r2300-20261007    gcc-14     sparse
hexagon              randconfig-r2304-20261007    clang-17   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261009    clang-22
i386        buildonly-randconfig-1001-20261009    clang-22
i386        buildonly-randconfig-1002-20261009    clang-22
i386        buildonly-randconfig-1003-20261009    clang-22
i386        buildonly-randconfig-1004-20261009    clang-22
i386        buildonly-randconfig-1005-20261009    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261009    clang-22
i386                  randconfig-1001-20261009    clang-22
i386                  randconfig-1002-20261009    clang-22
i386                  randconfig-1003-20261009    clang-22
i386                  randconfig-1004-20261009    clang-22
i386                  randconfig-1005-20261009    clang-22
i386                  randconfig-1006-20261009    clang-22
i386                  randconfig-1007-20261009    clang-22
i386                  randconfig-1008-20261009    clang-22
i386                  randconfig-1009-20261009    clang-22
i386                  randconfig-1010-20261009    clang-22
i386                  randconfig-1011-20261009    clang-22
i386                  randconfig-1012-20261009    clang-22
i386                  randconfig-1013-20261009    clang-22
i386                  randconfig-2100-20261007    clang-22   cocci
i386                  randconfig-2101-20261007    clang-22   cocci
i386                  randconfig-2102-20261007    clang-22   cocci
i386                  randconfig-2103-20261007    clang-22   cocci
i386                  randconfig-2200-20261007    gcc-14     smatch
i386                  randconfig-2300-20261007    clang-22   sparse
i386                  randconfig-2301-20261007    clang-22   sparse
i386                  randconfig-2302-20261007    clang-22   sparse
i386                 randconfig-r2106-20261007    gcc-12.5.0 cocci
i386                 randconfig-r2106-20261007    gcc-8.5.0  cocci
i386                 randconfig-r2201-20261007    clang-22   smatch
i386                 randconfig-r2300-20261007    gcc-16.1.0 sparse
i386                 randconfig-r2302-20261007    clang-20   sparse
i386                 randconfig-r2302-20261007    gcc-16.1.0 sparse
i386                 randconfig-r2305-20261007    gcc-16.1.0 sparse
i386                 randconfig-r2307-20261007    clang-17   sparse
i386                 randconfig-r2307-20261007    gcc-13.4.0 sparse
i386                 randconfig-r2307-20261007    gcc-8.5.0  sparse
i386                 randconfig-r2309-20261007    gcc-14     sparse
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261009    clang-18
loongarch             randconfig-1001-20261009    clang-18
loongarch            randconfig-r2104-20261007    gcc-8.5.0  cocci
loongarch            randconfig-r2105-20261007    gcc-16.1.0 cocci
loongarch            randconfig-r2106-20261007    gcc-16.1.0 cocci
loongarch            randconfig-r2300-20261007    clang-17   sparse
loongarch            randconfig-r2301-20261007    gcc-16.1.0 sparse
loongarch            randconfig-r2304-20261007    gcc-16.1.0 sparse
loongarch            randconfig-r2309-20261007    clang-17   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                           hp300_defconfig    clang-24
m68k                 randconfig-r2100-20261007    gcc-11.5.0 cocci
m68k                 randconfig-r2102-20261007    gcc-10.5.0 cocci
m68k                 randconfig-r2301-20261007    clang-17   sparse
m68k                 randconfig-r2301-20261007    gcc-16.1.0 sparse
m68k                 randconfig-r2305-20261007    gcc-14.3.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2104-20261007    gcc-10.5.0 cocci
microblaze           randconfig-r2200-20261007    gcc-8.5.0  smatch
microblaze           randconfig-r2303-20261007    gcc-16.1.0 sparse
microblaze           randconfig-r2306-20261007    gcc-13.4.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm63xx_defconfig    clang-24
mips                            ci20_defconfig    gcc-16.1.0
mips                 randconfig-r2103-20261007    gcc-15.2.0 cocci
mips                 randconfig-r2202-20261007    clang-17   smatch
mips                 randconfig-r2304-20261007    gcc-14     sparse
mips                 randconfig-r2308-20261007    gcc-8.5.0  sparse
nios2                             alldefconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261009    clang-18
nios2                 randconfig-1001-20261009    clang-18
nios2                randconfig-r2100-20261007    clang-17   cocci
nios2                randconfig-r2100-20261007    gcc-15.2.0 cocci
nios2                randconfig-r2101-20261007    gcc-11.5.0 cocci
nios2                randconfig-r2105-20261007    gcc-8.5.0  cocci
nios2                randconfig-r2307-20261007    gcc-11.5.0 sparse
nios2                randconfig-r2309-20261007    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2101-20261007    gcc-10.5.0 cocci
openrisc             randconfig-r2101-20261007    gcc-8.5.0  cocci
openrisc             randconfig-r2107-20261007    gcc-12.5.0 cocci
openrisc             randconfig-r2302-20261007    gcc-16.1.0 sparse
openrisc             randconfig-r2303-20261007    clang-20   sparse
openrisc             randconfig-r2308-20261007    gcc-11.5.0 sparse
openrisc             randconfig-r2309-20261007    gcc-13.4.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261009    gcc-8.5.0
parisc                randconfig-1001-20261009    gcc-8.5.0
parisc               randconfig-r2106-20261007    gcc-10.5.0 cocci
parisc               randconfig-r2303-20261007    gcc-14.3.0 sparse
parisc               randconfig-r2305-20261007    gcc-14     sparse
parisc               randconfig-r2305-20261007    gcc-16.1.0 sparse
parisc               randconfig-r2306-20261007    gcc-11.5.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                     amigaone_defconfig    gcc-16.1.0
powerpc                       chrp32_defconfig    clang-24
powerpc                        holly_defconfig    clang-24
powerpc               randconfig-1000-20261009    gcc-8.5.0
powerpc               randconfig-1001-20261009    gcc-8.5.0
powerpc              randconfig-r2101-20261007    gcc-8.5.0  cocci
powerpc              randconfig-r2104-20261007    gcc-13.4.0 cocci
powerpc              randconfig-r2201-20261007    clang-24   smatch
powerpc              randconfig-r2301-20261007    gcc-14.3.0 sparse
powerpc              randconfig-r2302-20261007    gcc-14     sparse
powerpc              randconfig-r2306-20261007    clang-17   sparse
powerpc              randconfig-r2307-20261007    gcc-11.5.0 sparse
powerpc              randconfig-r2308-20261007    clang-24   sparse
powerpc              randconfig-r2308-20261007    gcc-13.4.0 sparse
powerpc64             randconfig-1000-20261009    gcc-8.5.0
powerpc64             randconfig-1001-20261009    gcc-8.5.0
powerpc64            randconfig-r2100-20261007    gcc-15.2.0 cocci
powerpc64            randconfig-r2200-20261007    clang-24   smatch
powerpc64            randconfig-r2201-20261007    clang-24   smatch
powerpc64            randconfig-r2202-20261007    gcc-10.5.0 smatch
powerpc64            randconfig-r2303-20261007    clang-17   sparse
powerpc64            randconfig-r2303-20261007    clang-24   sparse
powerpc64            randconfig-r2303-20261007    gcc-16.1.0 sparse
powerpc64            randconfig-r2306-20261007    gcc-8.5.0  sparse
riscv                             alldefconfig    gcc-16.1.0
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261009    gcc-16.1.0
riscv                 randconfig-1001-20261009    gcc-16.1.0
riscv                 randconfig-2000-20261007    gcc-12.5.0
riscv                 randconfig-2001-20261007    gcc-12.5.0
riscv                randconfig-r2101-20261007    clang-17   cocci
riscv                randconfig-r2102-20261007    gcc-15.2.0 cocci
riscv                randconfig-r2105-20261007    gcc-8.5.0  cocci
riscv                randconfig-r2106-20261007    gcc-8.5.0  cocci
riscv                randconfig-r2201-20261007    clang-24   smatch
riscv                randconfig-r2308-20261007    clang-17   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261009    gcc-16.1.0
s390                  randconfig-1001-20261009    gcc-16.1.0
s390                  randconfig-2000-20261007    gcc-12.5.0
s390                  randconfig-2001-20261007    gcc-12.5.0
s390                 randconfig-r2101-20261007    clang-20   cocci
s390                 randconfig-r2105-20261007    gcc-13.4.0 cocci
s390                 randconfig-r2106-20261007    gcc-8.5.0  cocci
s390                 randconfig-r2200-20261007    clang-22   smatch
s390                 randconfig-r2308-20261007    gcc-8.5.0  sparse
s390                 randconfig-r2309-20261007    gcc-8.5.0  sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-24
sh                    randconfig-1000-20261009    gcc-16.1.0
sh                    randconfig-1001-20261009    gcc-16.1.0
sh                    randconfig-2000-20261007    gcc-12.5.0
sh                    randconfig-2001-20261007    gcc-12.5.0
sh                   randconfig-r2105-20261007    clang-22   cocci
sh                   randconfig-r2105-20261007    gcc-10.5.0 cocci
sh                   randconfig-r2300-20261007    gcc-16.1.0 sparse
sh                   randconfig-r2305-20261007    clang-17   sparse
sh                   randconfig-r2306-20261007    gcc-8.5.0  sparse
sh                   randconfig-r2307-20261007    gcc-8.5.0  sparse
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261009    clang-18
sparc                 randconfig-1001-20261009    clang-18
sparc                 randconfig-2000-20261007    clang-24
sparc                 randconfig-2001-20261007    clang-24
sparc                randconfig-r2100-20261007    gcc-8.5.0  cocci
sparc                randconfig-r2102-20261007    gcc-8.5.0  cocci
sparc                randconfig-r2103-20261007    clang-17   cocci
sparc                randconfig-r2105-20261007    gcc-12.5.0 cocci
sparc                randconfig-r2107-20261007    gcc-13.4.0 cocci
sparc                randconfig-r2107-20261007    gcc-8.5.0  cocci
sparc                randconfig-r2301-20261007    clang-20   sparse
sparc                randconfig-r2302-20261007    gcc-14.3.0 sparse
sparc                randconfig-r2303-20261007    gcc-14     sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261009    clang-18
sparc64               randconfig-1001-20261009    clang-18
sparc64               randconfig-2000-20261007    clang-24
sparc64               randconfig-2001-20261007    clang-24
sparc64              randconfig-r2100-20261007    gcc-8.5.0  cocci
sparc64              randconfig-r2101-20261007    gcc-15.2.0 cocci
sparc64              randconfig-r2102-20261007    gcc-11.5.0 cocci
sparc64              randconfig-r2103-20261007    clang-20   cocci
sparc64              randconfig-r2106-20261007    gcc-13.4.0 cocci
sparc64              randconfig-r2200-20261007    clang-21   smatch
sparc64              randconfig-r2201-20261007    gcc-16.1.0 smatch
sparc64              randconfig-r2300-20261007    clang-20   sparse
sparc64              randconfig-r2304-20261007    clang-24   sparse
sparc64              randconfig-r2309-20261007    gcc-11.5.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261009    clang-18
um                    randconfig-1001-20261009    clang-18
um                    randconfig-2000-20261007    clang-24
um                    randconfig-2001-20261007    clang-24
um                   randconfig-r2300-20261007    clang-24   sparse
um                   randconfig-r2301-20261007    gcc-14     sparse
um                   randconfig-r2302-20261007    clang-17   sparse
um                   randconfig-r2307-20261007    gcc-14     sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261009    clang-22
x86_64      buildonly-randconfig-1001-20261009    clang-22
x86_64      buildonly-randconfig-1002-20261009    clang-22
x86_64      buildonly-randconfig-1003-20261009    clang-22
x86_64      buildonly-randconfig-1004-20261009    clang-22
x86_64      buildonly-randconfig-1005-20261009    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261009    gcc-14
x86_64                randconfig-1001-20261009    gcc-14
x86_64                randconfig-1002-20261009    gcc-14
x86_64                randconfig-1003-20261009    gcc-14
x86_64                randconfig-1004-20261009    gcc-14
x86_64                randconfig-1005-20261009    gcc-14
x86_64                randconfig-1012-20261009    gcc-14
x86_64                randconfig-1013-20261009    gcc-14
x86_64                randconfig-1014-20261009    gcc-14
x86_64                randconfig-1015-20261009    gcc-14
x86_64                randconfig-1016-20261009    gcc-14
x86_64                randconfig-1017-20261009    gcc-14
x86_64                randconfig-2100-20261007    clang-22   cocci
x86_64                randconfig-2101-20261007    clang-22   cocci
x86_64                randconfig-2102-20261007    clang-22   cocci
x86_64                randconfig-2103-20261007    clang-22   cocci
x86_64                randconfig-2200-20261007    gcc-14     smatch
x86_64                randconfig-2300-20261007    clang-22   sparse
x86_64                randconfig-2301-20261007    clang-22   sparse
x86_64                randconfig-2302-20261007    clang-22   sparse
x86_64               randconfig-r2104-20261007    clang-22   cocci
x86_64               randconfig-r2202-20261007    clang-22   smatch
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
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   audio_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20261009    clang-18
xtensa                randconfig-1001-20261009    clang-18
xtensa                randconfig-2000-20261007    clang-24
xtensa                randconfig-2001-20261007    clang-24
xtensa               randconfig-r2102-20261007    clang-17   cocci
xtensa               randconfig-r2103-20261007    gcc-8.5.0  cocci
xtensa               randconfig-r2201-20261007    gcc-8.5.0  smatch
xtensa               randconfig-r2300-20261007    clang-17   sparse
xtensa               randconfig-r2300-20261007    gcc-14.3.0 sparse
xtensa               randconfig-r2302-20261007    clang-17   sparse
xtensa               randconfig-r2307-20261007    clang-24   sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
