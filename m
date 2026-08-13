Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA749C5CFDB
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Aug 2026 19:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FB9F80B40;
	Thu, 13 Aug 2026 19:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5e_cMBnbRnwe; Thu, 13 Aug 2026 19:59:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 971A580BC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786651158;
	bh=c4tSWfiDFnS35Oj88xBrkJXA0Hg43F4+Y8AXwlVWi08=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NrQn2HFqmnvQeoeA0psTI3R0haGOXjUmGyx/7LyDOkrDSCd9p/diwkZZlZN+2J4N5
	 KKPRkzK9FVFfXBM4kB2sWDngz3St3EEQq0MM1VVrwA7XM01RGy/EdWEFp0+1yPE5jj
	 Ckb80sp1UPPYHeIoNJO3IeNYTV75KUyWWoSmmt2x8FHO23Kztd48VcJ6rlzURHh00l
	 vk7+WegqHeYuPrzfHOjDJrkzCy2lWqoX0lW4oCvyMICCBHhU1BxPRxh2RPkgNKiqn0
	 gy3BqlobTOoWWJMvqwCiekM4FYSsB5cjaZFNZAsdqLBKXjtNCWPXeRsQaqNmlgT9zP
	 ehM/DGfMQt/7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 971A580BC4;
	Thu, 13 Aug 2026 19:59:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DCA8D1394
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEBC240CC3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:59:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DtfomsRZV7Ac for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Aug 2026 19:59:16 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0F03640CC8
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F03640CC8
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Oqq4qcTw
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F03640CC8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786651156; x=1818187156; h=date:from:to:subject:message-id;
 bh=StXZknISzpmBWI7kUX6kdTgUzNKfUZReckWnOoJGh2s=;
 b=Oqq4qcTwqBvy5pOPKQTtXok48l2FtIQl8/8wnDV+62pkjslkmyIf9DJF
 zvha6r50/M7Biqm1OhC01ZZHirPaAu8Ftc4zTvzJK/CmjrhMz30DhHEqM
 PSVCWJOBN8epoZATeH+pmHqZk1LbiVDCUP5K5pQOB67QVFMHSnMRbCOqD
 p9in0dhMv5iaQifEakAKra48FgsLu7YrE6DxKCLEPPB0+v3Tzniav7LA2
 n29LqfR0q5n5GOWmZeiDe7+cz3XHJEyoSujWq5uhYbvCRJtFMT9rx3KVI
 Z6ZlSJDp5jrU5u1z+Ah1KFdyPeS5srXP1RyWCoX1dSSSyPwfZHt10czdf w==;
X-CSE-ConnectionGUID: kZ+AQRKHTCu6stGUboawHA==
X-CSE-MsgGUID: VtdcL8OaQDGlVU+Qzm1UDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="89755381"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="89755381"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 12:59:15 -0700
X-CSE-ConnectionGUID: G2eAPkDjSO2YE6W49Aj1bw==
X-CSE-MsgGUID: 9C3CnxJETWyPgsT7UJ+x9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="264060905"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa007.jf.intel.com with ESMTP; 13 Aug 2026 12:59:15 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wuba4-00000000WS3-221y;
 Thu, 13 Aug 2026 19:59:12 +0000
Date: Fri, 14 Aug 2026 03:59:07 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608140354.nlW2wrvy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 b4e6f546ff52a42455814106dbc85bf9793d1507
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: b4e6f546ff52a42455814106dbc85bf9793d1507  ice: use per-interface clock_id for E825 generic DPLLs

Unverified Error/Warning (likely false positive, kindly check if interested):

    drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1206:1: internal compiler error: in final_scan_insn_1, at final.cc:2823

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 785m

configs tested: 27
configs skipped: 1

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arm64                randconfig-001-20260813    clang-24
arm64                randconfig-002-20260813    gcc-8.5.0
arm64                randconfig-003-20260813    gcc-9.5.0
arm64                randconfig-004-20260813    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260813    gcc-16.1.0
csky                 randconfig-002-20260813    gcc-16.1.0
i386                            allmodconfig    gcc-14
loongarch                          defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
powerpc                      eiger_defconfig    clang-24
sh                                 defconfig    gcc-16.1.0
x86_64     buildonly-randconfig-001-20260813    gcc-14
x86_64     buildonly-randconfig-002-20260813    clang-22
x86_64     buildonly-randconfig-003-20260813    gcc-14
x86_64     buildonly-randconfig-004-20260813    gcc-14
x86_64     buildonly-randconfig-005-20260813    gcc-14
x86_64     buildonly-randconfig-006-20260813    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
