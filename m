Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE02C5AD5A
	for <intel-wired-lan@archiver.kernel.org>; Sat, 15 Aug 2026 13:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AF0B81106;
	Sat, 15 Aug 2026 13:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cl_qlCqx4hg0; Sat, 15 Aug 2026 13:39:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8298E80DB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786801179;
	bh=G5kW+yWI1bfMfldyXL5Bi8MYKMIhAVAcGKklRIioJb0=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0qFQZ0qViVWbvC8c8xNwrQjXhoAgjnwMhcoXMg88/DHz+B7UK1Qdy+hfg+LKovkFX
	 dihuU1XXEHfQ0n3Qw0sIbMH30mOC9cKUlH/W1T62y/Ek0H3eZr/2zfo2p20IW7naKP
	 t9EPBp32YbWGsC9GsqQQpzFXm170yaAtxlAe7opJaW9DpUaovvMK0BOYK1u/Dm8y+G
	 t5Ug430EmxmFEGWnRWbZLeOeSoIYeU6GVLmcPU4LAP3oFOQW8GlsdbFC1tR11CnFD6
	 8fDhREwvSrh+z8OvM4bqAo9OWaidMOIJxOmgrAiwXjpXhKK2Ew83wL1P649S+DgwZS
	 9t6gY9U2HivtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8298E80DB0;
	Sat, 15 Aug 2026 13:39:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 33A17392
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 13:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 198F280D00
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 13:39:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bX5hR7QLQ91y for <intel-wired-lan@lists.osuosl.org>;
 Sat, 15 Aug 2026 13:39:37 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CAD7780B1B
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CAD7780B1B
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PRL96xDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAD7780B1B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 13:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786801177; x=1818337177; h=date:from:to:subject:message-id;
 bh=dTAQWG3lW8QcKftsdSabkbdvX3UNRWPfvIv9Lj4mmH4=;
 b=PRL96xDTzd5hMt8LmDSHgaJXTPrfpqbs9J60x/st5FIC9iJldd8IkPVd
 +rbz8Pd8MT9UC6Hb6yBUjXixt5+C/Rcqk4ZkGVFvXQmsX9POANufBLukK
 XPQw80Trlgb2keJMh+voY5518G+O/dMOoPrqbes5Ic1oWWUJ7VM0f5aZ+
 clki2uxdoIZ72mWGuZJ7xGy7VZEyFIJVFl5zMC+zjQHoszAOTnpL5SMAv
 xKRQBVEkDorqgfcMMAKbCRu3ld5wu6L7X6f2HbJUMwJNo16x6y9qDrKYw
 708k29teYomxqTuw8l1n98JlIX3KKM1O03CJdifGnAIscP/AOb71yYbzx A==;
X-CSE-ConnectionGUID: ouJlutBiQ2a43Ev6i3BXpQ==
X-CSE-MsgGUID: gxUp6TUlSlOGTuIf6GfCTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="86471203"
X-IronPort-AV: E=Sophos;i="6.25,225,1779174000"; d="scan'208";a="86471203"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2026 06:39:36 -0700
X-CSE-ConnectionGUID: G20b0DpKQ4mfM8KMT2U9bg==
X-CSE-MsgGUID: 5G9QmbVfQ/2ZP4cQXWKMNg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 15 Aug 2026 06:39:35 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wvEbl-00000000c8I-0A20;
 Sat, 15 Aug 2026 13:39:33 +0000
Date: Sat, 15 Aug 2026 21:38:53 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608152142.DP5rsDTI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Subject: [Intel-wired-lan] [tnguy-net-queue:main] BUILD SUCCESS
 24ef02f934eeb48830cff6b739abc3c62b1d107b
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git main
branch HEAD: 24ef02f934eeb48830cff6b739abc3c62b1d107b  net: page_pool: fix UAF in __page_pool_release_netmem_dma on xa_cmpxchg race

elapsed time: 1751m

configs tested: 23
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arm                         pxa3xx_defconfig    clang-17
csky                            allmodconfig    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260815    gcc-14
i386       buildonly-randconfig-002-20260815    gcc-14
i386       buildonly-randconfig-003-20260815    gcc-14
i386       buildonly-randconfig-004-20260815    gcc-14
i386       buildonly-randconfig-005-20260815    gcc-14
i386       buildonly-randconfig-006-20260815    gcc-14
loongarch                          defconfig    clang-24
loongarch               loongson64_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
sh                                 defconfig    gcc-16.1.0
x86_64                                 kexec    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
