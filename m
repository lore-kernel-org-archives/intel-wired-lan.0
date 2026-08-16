Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD24EC5CFC1
	for <intel-wired-lan@archiver.kernel.org>; Sun, 16 Aug 2026 00:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A1CF40522;
	Sun, 16 Aug 2026 00:05:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VXBlLoF1p0ua; Sun, 16 Aug 2026 00:05:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A92E3406AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786838726;
	bh=3FMR8fmlvpvPGKG4ugHYTw4EySExEWotZbp/yxdO4kQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Cq+jYOPPNvXWcrq3oBmx3ZHdqjcrAluET0VzM82Z7/cTdvObHR9nzKJQ5FwpY7CRZ
	 D02zeKy484Bv1sA1N4Us3zd0zfn7OAzQvBD2bwHpNnKg+Aji20v8Pe5hfojMnpzN/I
	 VSSszq0TJNTIxsqww8ZBtamPUfi3Km4TD8iOg87eSFSRXCXSvY9IbCgLSzWBHvIQCm
	 pt9vhgIwOUZMB9gCJp6GqzZYIZwCybSlzzW+KjwtWX3J4Zo74IY36Bj5rwF5tvQT1X
	 f7TlmdUuqUgr5f3D4h5l7DLSNJjOJtrvTv/rmmoTsOBtfHLcRwKr+wqovuyY7VK0BX
	 q9vcF+xYmRszw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A92E3406AC;
	Sun, 16 Aug 2026 00:05:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 218C3109
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 00:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1327680E8C
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 00:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CxyHdB5IHO3L for <intel-wired-lan@lists.osuosl.org>;
 Sun, 16 Aug 2026 00:05:24 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2F09380DF7
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F09380DF7
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IlZMNh9f
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F09380DF7
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 00:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786838724; x=1818374724; h=date:from:to:subject:message-id;
 bh=Y8DnXQLTMtgfxcEYJ2RPpbaU8IWzKf6f2n1p3gb/+2I=;
 b=IlZMNh9fu51Au/+8niNmFB8KHYqr10RXmdh0m2fMYbL3WfacVNX4KpRp
 lE9iheNRSjPb4gPOjgxRqQ9HcWbmtDLNQ9G7apsIO0mVIDn2Bx/jrsRpZ
 gMMTBiGmjT4XaLU58s90DZ+RqEHeAWJKwn+9BKhYSei0zX01CywseG37B
 xv3tT0IEISsVnYFHKW6h04l5L0Ppq9wf92UGbrkkWepO2qF9EmW58Opj4
 cKvSCWpj4NWuSjcQJK0K2YyozfyQhUcHgxskC+ogDlvdmZFg7Wx9t9c/Z
 06IRii3JjLG7Ik7EfhefoGNS2VhfJlDqbeMers4A5g7OFObPNgwQYB/5A g==;
X-CSE-ConnectionGUID: NcMc8OSjS2ObqSWal/ZI0Q==
X-CSE-MsgGUID: Zl7s4YhvSFOO4IQy4y7pOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="87576792"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; d="scan'208";a="87576792"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2026 17:05:23 -0700
X-CSE-ConnectionGUID: 1/WQHQgZQnSGcNPLCZhAQA==
X-CSE-MsgGUID: L8qbeVJ7RNeo2YwaRBXmVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; d="scan'208";a="261284154"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa007.fm.intel.com with ESMTP; 15 Aug 2026 17:05:23 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wvONM-00000000cYq-15M7;
 Sun, 16 Aug 2026 00:05:20 +0000
Date: Sun, 16 Aug 2026 08:04:21 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608160810.SfMV3CHo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 e09249a68f3e50cca3ba3b9d49da71b0a4cb2252
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: e09249a68f3e50cca3ba3b9d49da71b0a4cb2252  ice: Recalibrate PHY after settime64 on E825-C

elapsed time: 774m

configs tested: 15
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
alpha           defconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc          allyesconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
i386         allmodconfig    gcc-14
loongarch       defconfig    clang-24
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
parisc       allmodconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
parisc          defconfig    gcc-16.1.0
sh              defconfig    gcc-16.1.0
xtensa     virt_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
