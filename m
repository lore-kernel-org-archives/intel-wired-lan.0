Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3EAC624D3
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 18:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAA7F60725;
	Wed,  2 Sep 2026 18:21:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3yrl6u3_xTK7; Wed,  2 Sep 2026 18:21:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788373309;
	bh=DVyhIF43HrRBOMzh0ieYk/z+FYkY3J1ymuEHIE1nPWg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vPTFrPFAA3yJPaCftJXOp5NLDmDkwbtYHGRWboWSB+8cfBd0s8oOrfgNjW3ZHP2lP
	 1+0MsN2IqTXyjhtqKlF/iZtq1RjOuJwAChPO2Z/v+sPc8aM/S7eupAgxkbiv6D+MyA
	 FxwTLPIKf1B/K6rvKGQdWqkqfJI5C2nAaRH9ygUomMKX7A6EVv4sgMlkbydDuEKvfm
	 1cca/pvFTrRhyiGD0xwYXFsJOp7eekPBbgGJj73+wrlOIEhAYT0XQ0uYe6R4pGGN1M
	 N8xNkt8yJt4ZdwmQZugKMKc7hlvRUhlKndOa4BI3Wf86Du91zcUTTGOemzZZv+vBb7
	 ZwNngkMRAPaHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE846607FF;
	Wed,  2 Sep 2026 18:21:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 55FCE2B2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 18:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4754A607FF
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 18:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jHL4gtrn6Ecw for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 18:21:48 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QdrmaHFM
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 473E160725
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788373308; x=1819909308; h=date:from:to:subject:message-id;
 bh=BIRa0BV2M4xjGkHAAP3CYgWgIZMZQpN0wOHRDDlhls8=;
 b=QdrmaHFMbz2PN6n2lRSPLrsBf45zkIi4vaXWOrSJnq4tyS0Wl0ow4ZJV
 nEigUbKOzEE4SznkBGUBfF2fYRlbi4Nc1mrmzhzjVyA+geYn2Pys4MgRC
 zBoY6PKeZji1emFioQw+ENPmsYsBpoY05mNaoAYswlROJACjSpxT7nC41
 AxzUPISFmS1E8ZhWOt8GYXljtZD7cdYRsOI26iRwkar4zHFw8D9UJG5s/
 0A8R9YeDkn56lX/oD2U2HzvnoMHt/BcTh0KJBdsQxxFPhFpBNBX347nur
 uXPBBuyA7racWhYlvldLTZ0QAgR4OjnGGGrv9l5uKNNfv8ou2IZHfQx4W A==;
X-CSE-ConnectionGUID: gZ8qg2w0SDKDUanYL7O4og==
X-CSE-MsgGUID: QL0la7LvTnS9DfQpBTJ7PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="87779619"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="87779619"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 11:21:46 -0700
X-CSE-ConnectionGUID: 4vdwajjMSSatQpK6PanT5Q==
X-CSE-MsgGUID: Mr9BvpxaSmuxPbFiVRBA6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="292997083"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 02 Sep 2026 11:21:46 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x1pah-0000000038G-3Wo4;
 Wed, 02 Sep 2026 18:21:43 +0000
Date: Thu, 03 Sep 2026 02:20:18 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:100GbE] BUILD SUCCESS
 1d2929d0850fff683b8aff051275945e65f082c8
Message-ID: <202609030249.Sq70FAKs-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 1d2929d0850fff683b8aff051275945e65f082c8  net: psp: do not inherit the Rx association on clone

elapsed time: 1718m

configs tested: 55
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    clang-24
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc       allyesconfig    clang-17
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh           allyesconfig    clang-17
sparc         allnoconfig    clang-24
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
