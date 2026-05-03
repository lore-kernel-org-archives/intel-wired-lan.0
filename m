Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C01FF886F
	for <intel-wired-lan@archiver.kernel.org>; Sun,  3 May 2026 07:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2F6F841D0;
	Sun,  3 May 2026 07:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wxVRImgfWxPV; Sun,  3 May 2026 07:18:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F052841C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777792710;
	bh=WoIznTlOmOKFexYRynMDyfHePHx5ixp4VPtdRauiCK0=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QATPHCFjK+gFGDsilO6ddbtcLRQIXYWE9DjPv937ypGz/u8p3p+AmGG1cermOC3X4
	 aJt1gVbhAd8lQiUak5B33MrHpVkxddntDX9aimYkVc2C9mFIzGeLXwDMbCUneVrKH+
	 PoV6oJsF4CtwJ5vemCaKXQHL5CyhetTqMyJEMr0GUipIdLV1eCEA7WztpylRQomLcL
	 5hKiw827zVm0Gbt7z/SnHx0o5C/Y0XgmmcY/XTN1jqqpvZ+218aB5Zt7rsGEx14mi6
	 1hBZmuzQssLg/2yphC0ujQU9UTP96n5fOfOrE7jiR1fxz6mYpRRAegTt9sYlMInfB2
	 CcpjDT1tPpZnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F052841C9;
	Sun,  3 May 2026 07:18:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC6C2127
 for <intel-wired-lan@lists.osuosl.org>; Sun,  3 May 2026 07:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1CD661210
 for <intel-wired-lan@lists.osuosl.org>; Sun,  3 May 2026 07:18:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ezVdKdvg-dtJ for <intel-wired-lan@lists.osuosl.org>;
 Sun,  3 May 2026 07:18:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E89F9611C3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E89F9611C3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E89F9611C3
 for <intel-wired-lan@lists.osuosl.org>; Sun,  3 May 2026 07:18:27 +0000 (UTC)
X-CSE-ConnectionGUID: 28VOm/lCT5mNvQyZJgDX/w==
X-CSE-MsgGUID: eEbx8FwQTUiVMGLQbrQVOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="82558798"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; d="scan'208";a="82558798"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2026 00:18:27 -0700
X-CSE-ConnectionGUID: 4ExgxmYZR8+X5GXaocpsUQ==
X-CSE-MsgGUID: nHww94PcSYqMsGEzmM9qHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; d="scan'208";a="234203261"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 03 May 2026 00:18:26 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wJR5r-000000002JB-2rjt;
 Sun, 03 May 2026 07:18:23 +0000
Date: Sun, 03 May 2026 15:17:26 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202605031515.G4C0mzG8-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777792708; x=1809328708;
 h=date:from:to:subject:message-id;
 bh=4tQlnksb5DLQ3E0Zku77gtivjBiS1kgsZ6DOkc40WUg=;
 b=cZLQfNK1Vn5SXPudqQNgq0E+0G2at/ywVVDFE2Lt31sBGjaRgVEUug55
 K0r8dQ2oo1wv6cvuG52hbgjOyhxjMrSrz7bZFCpB3RbGxX3pKhaQuQFcY
 +tA7LNq8/Dg2HoDJuxli5iXuBm2g2lLYZtSwCnZCEw5dZLpCqgkclu1NU
 GQ026ZHmq503E1DLbvuQK8YXomx1oSs4n4BLGgrvYWo6t4/C6x1fWnQMN
 M20nNYq2wSLKy/HKAf8qqI6eMrQALzlX1uE4NK+Y64q59axKRWsrPnFmQ
 yQl15BveOlTkYtPuB+zhxBYvj+l6aCVOubg5O+1laroWvdAso0IrN3Exu
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cZLQfNK1
Subject: [Intel-wired-lan] [tnguy-next-queue:200GbE] BUILD SUCCESS
 a7347c4a60405a988bee5ef9d65d6d5a9e2de3a6
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 200GbE
branch HEAD: a7347c4a60405a988bee5ef9d65d6d5a9e2de3a6  ixd: add devlink support

elapsed time: 6185m

configs tested: 52
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-23
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-23
um           allmodconfig    clang-19
um            allnoconfig    clang-23
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
