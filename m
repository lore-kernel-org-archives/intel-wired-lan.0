Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299BFC44514
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 20:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE14A40A21;
	Thu, 16 Jul 2026 20:40:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5mAUCNdJErQ; Thu, 16 Jul 2026 20:40:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E519540A20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784234421;
	bh=zbiQCJXxoF1V0QWZTVJ4AqLTgVotZAhrVXGloSDL1tQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ENlRWrBpvFMgxRNuXwAcxk7FhSv0i2wf1WsKemlc8HMhV4TjLMugTid9LI06H0d9C
	 I9zeba32Ss5RK2leMKOZE+VyvuyM5FO79oXrYSuLTKq6nAhVFiMVI9UAj1bAyveer/
	 soEaU/rVVcaqGsCl3fPs/eINJCSC/iWJAbqkkDgoeaWwxwWHtyvgMNxCQVHTpRCodf
	 3gRMowIUI13DsouZ2v4ngOj2P47vEb7A7D0XRNcLafWAMayZzP3yFd9GLZw33Bdvjb
	 AqyPogEtXWLcoNvC2brm9nvpZ1n2kIP92wpEm5sue8GcrmB9BwEVoX2cKLSxcML68p
	 ZBPFxwYv1RJdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E519540A20;
	Thu, 16 Jul 2026 20:40:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 92D261F6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 20:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78F5440A22
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 20:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 47ny64Ltl756 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 20:40:19 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5AA0640A20
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5AA0640A20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AA0640A20
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 20:40:18 +0000 (UTC)
X-CSE-ConnectionGUID: bku9hVycS9SD8x/XA3RWjA==
X-CSE-MsgGUID: tRQW9HxGSIGJsHyoxoSHlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84934020"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="84934020"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 13:40:18 -0700
X-CSE-ConnectionGUID: dvQ5t9FXRYiXAhh9ymSrvA==
X-CSE-MsgGUID: 8oqKYwvXQ2mJriROFOCePQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by fmviesa003.fm.intel.com with ESMTP; 16 Jul 2026 13:40:17 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wkSsR-00000000Q3m-0sb2;
 Thu, 16 Jul 2026 20:40:15 +0000
Date: Fri, 17 Jul 2026 04:37:37 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607170425.uDNmxi3S-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784234419; x=1815770419;
 h=date:from:to:subject:message-id;
 bh=ooCW959eJB9y1KFXEY8963t3wogg7bOGQhcockiXlnY=;
 b=aWOawbZZo7nQ8Qrlx5lbgE8aioCiJhdE7J1efGEQtsFf9IC33gkTax/5
 aoKUkcD8kUrN/pquqB2ucSEruf+cxighp4PYjZdzkD+067UFo++O8P4z1
 sxjwj0Rwr08IMXCSkjD781wSfJEQIMVwUce9gdeMazRDFu3qmizCgxcuy
 GBsw7ta83fwnO67jSedgYdif/fQWdch74Vg7fnOkT/Bjrr1Ekp0rcqeoe
 1YC+ex99PyMS97NpnxE2kelsMPnAWL77/+qCQjO4lf3YIVoxVlTy7mTa+
 XylnXmILwVsY4tXXBd4xRGuCYG3PxF2cFaZjvtuHXKGoqFdZLkFjjTKU+
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aWOawbZZ
Subject: [Intel-wired-lan] [tnguy-next-queue:200GbE] BUILD SUCCESS
 2f0f674d37199edc06202e1e89ad4f0ccbb7898c
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
branch HEAD: 2f0f674d37199edc06202e1e89ad4f0ccbb7898c  ixd: add devlink support

elapsed time: 1546m

configs tested: 54
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    gcc-16.1.0
arm           allnoconfig    clang-17
arm          allyesconfig    gcc-16.1.0
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon       allnoconfig    clang-24
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-20
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    gcc-16.1.0
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-16.1.0
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
