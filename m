Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25572C5516D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 14:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E355760B04;
	Fri, 31 Jul 2026 14:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v21xJTvUzy_u; Fri, 31 Jul 2026 14:24:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2927460AEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785507856;
	bh=VipFG2v1Puaf5w30DdDB/zpLsc4uxtu7Q03hqBYEr/o=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sLGTyl08EWYbVpeyU4HDBmaxpj2O1QMjuVbmwrSR2DBornHpnX9O9VftWQAig87t9
	 Os0I2zhJ0KONGmKi/gQEf/88H53icdFF5IidTsugYR03azbA0XxGC7lQm5bp5dZJrp
	 DIcM00aU37CKrsLEB0bCb6UKM2DSDIAgAiSbYPz9/QHeikgS5C4rrmPj4AIyZ7cQdo
	 fAZBfli+kHHPbTDyDoARL5g2wCdzaWbdABaPojg6QCRm+Mmm+6x0TacuWQAgxYgVWq
	 WxRP7xpRVljfuLYqan0jZ7szR4FX0ZqkWe4syEmeqiz+C6nqaE9jIT5OyZmqauiXe1
	 gvvopbXJTB4qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2927460AEC;
	Fri, 31 Jul 2026 14:24:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7214126E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 14:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6409F400A4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 14:24:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bYQQ0PdSPLTq for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 14:24:14 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9136A4004C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9136A4004C
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9136A4004C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 14:24:14 +0000 (UTC)
X-CSE-ConnectionGUID: tPx+AZwCRoSzWWYkFHNByQ==
X-CSE-MsgGUID: YsfVQipVRRSaUrw5C6twkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="97291068"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="97291068"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 07:24:14 -0700
X-CSE-ConnectionGUID: +57Gs6RTS/6rAmVVZF+TUQ==
X-CSE-MsgGUID: DSLImuEmQSa8yL+R+5zuvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="283921445"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 31 Jul 2026 07:24:13 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wpo9i-000000001Dd-2n5W;
 Fri, 31 Jul 2026 14:24:10 +0000
Date: Fri, 31 Jul 2026 22:24:03 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607312250.MGnaB60d-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785507854; x=1817043854;
 h=date:from:to:subject:message-id;
 bh=uIN9QW0yUY20vvq7KAMhJaAcHQV94bJIoAgbDaD3OF0=;
 b=UP4znDaX1cZW0YLGgVHjKQUeJ5V2UB9U9HRDSNZVTQpbyqAjmybt/2BC
 kHbVkDuWelwDeoDM9towQFLQQsOY6So4xXPy9zejHNAvsXGKo8SSagwNo
 jb55FzPlJzCydLns97xqGdLsAKZxv6ZZAgNil0afcF68twL4VN36Rfmc/
 Od0UHBck0GGoiO0KAQl1D3nh0mPlB2bKDyKFEMqRjlB0mkd0BpB/tP3Qk
 9HyMEJrkPlDkHtRZ1F3y70UHFiJCdCuj3sI0kvnlgOs6iIxYypcjEJpVL
 mXzQl1/q+lE6+saRLuGdumNMor1FVovdpB7zAxAQuaGKSRk1oN6QmgNxO
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UP4znDaX
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 6e41d29c60deeb29a88debd2540dab757674834d
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
branch HEAD: 6e41d29c60deeb29a88debd2540dab757674834d  i40e: trigger PF reset when re-enabling ATR via ethtool

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 803m

configs tested: 15
configs skipped: 1

tested configs:
alpha                allnoconfig    gcc-16.1.0
alpha               allyesconfig    gcc-16.1.0
alpha                  defconfig    gcc-16.1.0
arc                 allmodconfig    gcc-16.1.0
arc                 allyesconfig    gcc-16.1.0
csky                allmodconfig    gcc-16.1.0
i386                allmodconfig    gcc-14
loongarch              defconfig    clang-24
nios2               allmodconfig    gcc-11.5.0
nios2                allnoconfig    gcc-11.5.0
parisc              allmodconfig    gcc-16.1.0
parisc              allyesconfig    gcc-16.1.0
parisc                 defconfig    gcc-16.1.0
powerpc    mpc834x_itx_defconfig    clang-24
sh                     defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
