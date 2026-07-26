Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23B7C531CC
	for <intel-wired-lan@archiver.kernel.org>; Sun, 26 Jul 2026 07:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65A01605EE;
	Sun, 26 Jul 2026 07:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KgGO5VfOIIx4; Sun, 26 Jul 2026 07:13:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35ABC605E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785050002;
	bh=NoRFc3lSOjDXQ6qeUQ65Et5uEQZBkbJ2OZE3H/SQSlc=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Cu5AbrCrqLDd+QYkf1T03iDqIthplCq+SZ/UmZc1avBTQRCqNE7MXJGt7Tvw2OiZk
	 IiEZklQnrMwTx6kpRSYgUB1EXaZb85innZPNPSwCIxqXKC0CzA8snicH/ynbhJgbMX
	 7rFI3DmWc/lCEWwR9n1wyZF7SUJZahhba8aFAlYS9Y77sG4zeH8YMI+eeFjnT+mpdi
	 8kHErkSjVJjvMZFWBXNNRrpjQ/P7xvODHZ7Qtpa20BxRm4tzYhMH2B5OicsK9s2KT3
	 gz2+rbbGBBxXdDP8VA5JLmHBo0h8wYUAZUW0ErsugoZLyvPiaDy9mVR/hRRaXgC8oT
	 H+Blq/vzKhWeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35ABC605E9;
	Sun, 26 Jul 2026 07:13:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B8A5194
 for <intel-wired-lan@lists.osuosl.org>; Sun, 26 Jul 2026 07:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40B4D40073
 for <intel-wired-lan@lists.osuosl.org>; Sun, 26 Jul 2026 07:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wIsupHbSYJGa for <intel-wired-lan@lists.osuosl.org>;
 Sun, 26 Jul 2026 07:13:20 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 677DF40072
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 677DF40072
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 677DF40072
 for <intel-wired-lan@lists.osuosl.org>; Sun, 26 Jul 2026 07:13:19 +0000 (UTC)
X-CSE-ConnectionGUID: kcTK2HraTUaGP/6a7At2Bg==
X-CSE-MsgGUID: UWH0pa6kR2eUS/Fh7AHd2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11856"; a="111195219"
X-IronPort-AV: E=Sophos;i="6.25,186,1779174000"; d="scan'208";a="111195219"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2026 00:13:19 -0700
X-CSE-ConnectionGUID: Qx78KRPQRBSPr5JYzb8aSQ==
X-CSE-MsgGUID: 0hSkidPLRlKKMQ0AQtTViA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,186,1779174000"; d="scan'208";a="252779520"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by fmviesa009.fm.intel.com with ESMTP; 26 Jul 2026 00:13:18 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wnt2q-00000000cN9-2Ahm;
 Sun, 26 Jul 2026 07:13:09 +0000
Date: Sun, 26 Jul 2026 15:12:03 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607261538.VbNCBAOV-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785050000; x=1816586000;
 h=date:from:to:subject:message-id;
 bh=KGqFq7WDPmmoPvau47GqI33mBdboK2qCy7TnvK9L9+Y=;
 b=m+6NJLdTyfNxL5FXhVyE7+EL6n0XHabYlVXZj4DgS//Kiv4z3OgfxOpr
 Rtv87c9eJ4pmKv1VCdprrz2af/qXww1TAwd42FSw6a5H5hcYAI6ZgOX94
 Syq2yvdXZumN0rQoYosr9y5dbXAFGRib8EdxZAbEAoiHJ2BHulUjv6Uv3
 PCFbptJMUeq5rXjjVKysGyNc5CH7yzxTgTToK5XA1xfanMq230NooES3L
 RXdD5ji20JbwYOvxR13qJ4Ahzm69FRZZumBUptknR0CPNkOO5NQ41y0r8
 As7ozkYFF8azm+vkFF1PS3Od7LHBsORfArUhNVz5tMl1Bd39hMantrcOg
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=m+6NJLdT
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 99f048736e33ad82564a27e361b95533886d9159
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
branch HEAD: 99f048736e33ad82564a27e361b95533886d9159  ice: rephrase LLDP filter fallback message

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 858m

configs tested: 47
configs skipped: 1

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
arm64      randconfig-001-20260726    clang-24
arm64      randconfig-002-20260726    clang-24
arm64      randconfig-003-20260726    gcc-8.5.0
arm64      randconfig-004-20260726    gcc-8.5.0
csky                  allmodconfig    gcc-16.1.0
csky       randconfig-001-20260726    gcc-16.1.0
csky       randconfig-002-20260726    gcc-16.1.0
hexagon    randconfig-001-20260726    clang-24
hexagon    randconfig-002-20260726    clang-24
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
loongarch  randconfig-001-20260726    gcc-12.5.0
loongarch  randconfig-002-20260726    gcc-14.3.0
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
nios2      randconfig-001-20260726    gcc-11.5.0
nios2      randconfig-002-20260726    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
parisc     randconfig-001-20260726    gcc-8.5.0
parisc     randconfig-002-20260726    gcc-15.2.0
powerpc    randconfig-001-20260726    gcc-10.5.0
powerpc    randconfig-002-20260726    gcc-16.1.0
powerpc64  randconfig-001-20260726    clang-17
powerpc64  randconfig-002-20260726    clang-24
riscv      randconfig-001-20260726    clang-24
riscv      randconfig-002-20260726    clang-24
s390       randconfig-001-20260726    clang-24
s390       randconfig-002-20260726    clang-24
sh                       defconfig    gcc-16.1.0
sh         randconfig-001-20260726    gcc-16.1.0
sh         randconfig-002-20260726    gcc-16.1.0
sparc      randconfig-001-20260726    gcc-8.5.0
sparc      randconfig-002-20260726    gcc-8.5.0
sparc64    randconfig-001-20260726    gcc-8.5.0
sparc64    randconfig-002-20260726    clang-24
um         randconfig-001-20260726    clang-24
um         randconfig-002-20260726    gcc-14
x86_64                alldefconfig    gcc-14
xtensa     randconfig-001-20260726    gcc-8.5.0
xtensa     randconfig-002-20260726    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
