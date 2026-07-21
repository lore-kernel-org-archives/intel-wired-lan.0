Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AA6C44529
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Jul 2026 06:12:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7680C80E17;
	Tue, 21 Jul 2026 06:12:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ufJgjhMPoUNf; Tue, 21 Jul 2026 06:12:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D83E80DF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784614344;
	bh=n7e0mXT1ILltdvvGkX3vKWczOSD9Z3IL6o2XC7kzS8Y=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PuMpNmtUvb+xYGm9PdYDy1NLk9qTyjkfqrxyT+b1NOxybaKN5ejuedFWp6W1ldZ5b
	 mB85L4cts2mKSEv38Ebvy0QsQLZyjZnDuhbBvux+nAFwaAMwXvbI6JljrYPFndKT8V
	 Vg8qxWtFnfzrMcHP78eYQqTTOgUjuSBykcom+3TH5RkeppaP/l0KKNdYgXYDSmTpii
	 47uy8P+yXxSGuFFdqKbbZWSdnNrChph/a4brYHlzmmO5SVMMYO59JBuvriMUC1NhIO
	 UKy+HxItc9B7RjKwHgVtpLl0jCI3MfpvLCjIvaEy38rPfWDmxtBMn3EMtssgZAqopw
	 hq7I9FMrLWcKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D83E80DF7;
	Tue, 21 Jul 2026 06:12:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 826A51093
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 06:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B182607D7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 06:12:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KGd1-tU7c5_6 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Jul 2026 06:12:22 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 65D6D607D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65D6D607D3
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65D6D607D3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 06:12:22 +0000 (UTC)
X-CSE-ConnectionGUID: Sc6w5U+0QoGelnpkrSWDbg==
X-CSE-MsgGUID: rQxIjku9RTuDP244nlxcNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95854166"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95854166"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 23:12:21 -0700
X-CSE-ConnectionGUID: 7sjCbp6tRkewygq6ss08SA==
X-CSE-MsgGUID: ekgxbKnZRzWrEHTs7lc7vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="256468077"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by orviesa010.jf.intel.com with ESMTP; 20 Jul 2026 23:12:21 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wm3iD-00000000XGA-2vMf;
 Tue, 21 Jul 2026 06:12:17 +0000
Date: Tue, 21 Jul 2026 14:11:58 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607211442.QthLzvac-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784614342; x=1816150342;
 h=date:from:to:subject:message-id;
 bh=iFegCCea8NbwneXs7juKTdlmr2W5AaUbao3riADcphs=;
 b=fvCsiMBdEVyL9jSV2W1f3+sk1hZ0lYgSxknIM+GoEAwppiy/N922BnSR
 pNmkayRqM0wtRGzRLFuMswFYYGKUw89KggdGAJd7ozAA7A91FaLsyoAq6
 ronBdd0Hcz08X4qYJtr+nj3SemTap5JRwi/rN6QShfLYD5CzXFSO2hEIa
 6FJOsuC3RAPC+M4SuIeCk8LG2RPnBUrEo4uxE0BfkguExMGfvr3QrItTZ
 btyMJgBIHOY7kXTwUpiz7mRPVJ6TWhGK4vW4R70yYYDp4u9JJii1q3lP0
 Dcgx2MZ1376v141gbwESIPqMoZ2SlfwnGSz0j16eFPEqpuHIfpX9f7QNa
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fvCsiMBd
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 3cc5b386f7183c9db0fc0906a0ca3b9b57ef56ab
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
branch HEAD: 3cc5b386f7183c9db0fc0906a0ca3b9b57ef56ab  igc: Support ACPI-based MAC passthrough

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 755m

configs tested: 15
configs skipped: 1

tested configs:
alpha                   allnoconfig    gcc-16.1.0
alpha                  allyesconfig    gcc-16.1.0
alpha                     defconfig    gcc-16.1.0
arc                    allmodconfig    gcc-16.1.0
arc                    allyesconfig    gcc-16.1.0
csky                   allmodconfig    gcc-16.1.0
i386                   allmodconfig    gcc-14
loongarch                 defconfig    clang-24
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
parisc                 allmodconfig    gcc-16.1.0
parisc                 allyesconfig    gcc-16.1.0
parisc                    defconfig    gcc-16.1.0
sh                        defconfig    gcc-16.1.0
sh         sh7770_generic_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
