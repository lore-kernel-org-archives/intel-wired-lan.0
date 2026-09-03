Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72810C624D6
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 03:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17F2980FFB;
	Thu,  3 Sep 2026 03:26:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LekW8ydiqZdN; Thu,  3 Sep 2026 03:26:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 48E4380FF4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788406007;
	b=Grwl4NP9guCtt2IeKqtS1GhC7M7MVnfgXxlWNsR5VP4QS/jkENcV27sPPRNzRv0XnmES
	 W5V+wsaWjGN4J3zuWd1jlkYXP37xHWzdua6XU4wt/1ZhHkvFVHeCVYwZWCKV5A1A674nb
	 9YMIZSEUrOFUnytZTU+aYJ/0KF1Oe49zgXyin+cT7upcxfEMiOEYgc1TkYwkGIVPB/YM6
	 s07VYTCXzdi4LUBZQUKoRcnQAtZPLh+mnsCQMPt+HRuGYK3dPVGhdMWDx8IgrCGkoG1nJ
	 3LNbNbHu91SDRIoFeQ2SpV5Ng7DTqDlJGRrXJV+rb85ONtwWn50VEP5h5LNFsu0C8fA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788406007;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CVpKwm2wiWKnbQpQM8w3KfFqI9COcXb05ZoYYj3PiBg=;
	b=YcBm8BscWGSXL/GW6Skp+SgBx/49OGiUOoUlPps6Z7XVU4AHp1we4qSQOA/rLFB38hnN
	 0YedjJhLOv52zbM183XBx59bHoUqf+jpsdNpa8mcqt2DfnxkymGZ1g4W1z7/gbgF4Wfgk
	 q8Ie3TaLmQa13FkKnMh3ZvOTApQetiiEMmS0jwdcyr3w0KCHtase5oEKAe4GLChkoSN41
	 g2Ioevdq1l42Snb8JL3bg6iw3gRV6z05ve8EPwRwevWkmZBSG/yd2IGxCsJiKKMPgTCHZ
	 yend+ix5Y6idbMgZj8FS0J7C4rdTEnT/amyylEzA0cpWHIMsVDeKG1Q+KuTsYgOsG8g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788406007;
	bh=CVpKwm2wiWKnbQpQM8w3KfFqI9COcXb05ZoYYj3PiBg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=V8z0p/9G5BvcHSzpN2cGMOnjEuZm5p72MkTTfCzrRr/d0MW7IaU6IZ4/nAUQPNRZB
	 MjHGLzhkSHrMrqlHgWvnWgGqPjw3kpz5jdntICRa+C+ClYst0OndUWYAEGf6G9ICEN
	 k2CovorvQh/C0T8DtPZV+kc2sqdZmcCRx2L+elSsM4j9/IPX/8rClux/xNtUwl7Chf
	 f7VdTNEdw2Wny7D8Pt38MoysvY2BOOY+rkgPdktFiCko98fz4xz6XJwZthawa7Fv+K
	 R0OdKHWuw2LRf7p23amDjCpHaT9Qsd2nOpDhtP6Cd7E3EIWXP6RE0JW/1rtkeqAgAW
	 GtYyrTSUeWBGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48E4380FF4;
	Thu,  3 Sep 2026 03:26:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B2B32FD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 03:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D92740A87
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 03:26:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wyqIY6Gz_Q63 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 03:26:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B921940A86
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788406005;
 b=qIXe8Raij0Xrpxw9YJhMG7rIpiS9MrEcJqKLl156G36/HK1A4tKtq7SKoQWvBVqXGO28
 O3epUZI95YPn6urobzGA0MvrIIHC1f2hvYMyRryXYTLDBCoibE6FNzZSxUzwLUGEjfGL1
 a6QrAbjePF1SUftWWIcLSV3z5RZMtLlxswgmos9bLmW7a5CrB3qEzhAQEwF64EmSJcofE
 BremeBjOtlyb/55+VSiljDID6AHz16+eNKxPFE8yz2vZZY1XPc51gSXTr/k/0DXkryj94
 /zTK9U7hezKdVUj6Y0Iyq29NNOOrsCW/zi9lNE/AYLouQ96/vYEq3O4x12/10mzT9pA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788406005;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=CVpKwm2wiWKnbQpQM8w3KfFqI9COcXb05ZoYYj3PiBg=;
 b=BEuXj54F/Ez7jXNDCqcuVW7YVSn9DyB+JOa/+yPvExa6BnGG3Ref2DlTY5VdEB1Hpdmi
 oG2M4LcUp8MddhkMRVOlLf/KLcV+QIYdRr+qHkevCroK8WtK5L+KDXiJLxmnGLWi80mI4
 Y4jUNmLYEGaRq7f+jey1GWigL//CuJxfCIGFiV3qWuBlIKJOPx4IQkUAVCI9d4CoOwOjU
 BZ96lpl6fcGE2b0Zvga8BxpUPqzFBTntC98Hn4LJYu73QHaFiw35v9jqWzAeKPUF6IHOs
 BGzvkpkh3q4xp/9ynGaUGyWlVXo1AVjhxNHK2jtDEs9o5wPjLWbZsX7zj6kGXHw3XoA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bJ9+9T26; 
 arc=none smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bJ9+9T26
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B921940A86
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 03:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788406005; x=1819942005; h=date:from:to:subject:message-id;
 bh=Ac2+Ild0ioPPRNYkofKEB4FY0CyQHX/il2yFJ86fkRs=;
 b=bJ9+9T26q6qMTastMtf7CmEVszHesWeTsBany1hAHupE0WxmTfl1Amhp
 kppQW323vjr1jFTbYqAqX1DwR5h8AjVty8WujqksXT/Al7KH5J7+Yuxrd
 UzRDVAD/dSJR0Xo9LDC7gqQmPdHrykJrarsOWhc9ack8YXfpAnVGPIGTq
 3dHbDAAgUhlDWrxZ+mFAY0ys8y1P0sQZGdmj4Vnsh5P14pHbEpKppiG6p
 kDRQgQz5TgJtW+QU+YiX6hdOgnV5CdxuWWlkLKSpxrZ8PXzRNJAcqvDTk
 FYhXAuxbBrr2mePIG8n5sY7NrTdeG10Av/9iBxMamPc68OPjmn92kX3Zk g==;
X-CSE-ConnectionGUID: rDdVMpA1RqWdZn4FjuG+PA==
X-CSE-MsgGUID: /e7QcGyiSIeM7JplgLYVmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="89087849"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="89087849"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 20:26:43 -0700
X-CSE-ConnectionGUID: 7JhvSKE+TzurS3gkLnAC7A==
X-CSE-MsgGUID: GH+QpC0gR6OvjmCdDUW4iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="270141875"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
 by orviesa009.jf.intel.com with ESMTP; 02 Sep 2026 20:26:43 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x1y64-000000003uu-386s;
 Thu, 03 Sep 2026 03:26:40 +0000
Date: Thu, 03 Sep 2026 11:25:51 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD REGRESSION
 07709e83c8c345361a7ab2a56097fb49e4fc028b
Message-ID: <202609031148.TDvQGR8a-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 07709e83c8c345361a7ab2a56097fb49e4fc028b  e100: prevent shift-out-of-bounds in EEPROM access

Unverified Error/Warning (likely false positive, kindly check if interested):

    drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c:436:1: internal compiler error: in final_scan_insn_1, at final.cc:2823

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 1588m

configs tested: 43
configs skipped: 0

tested configs:
alpha        allnoconfig    gcc-16.1.0
arc         allmodconfig    gcc-16.1.0
arc          allnoconfig    gcc-16.1.0
arc         allyesconfig    gcc-16.1.0
arm          allnoconfig    clang-17
arm         allyesconfig    gcc-16.1.0
arm64        allnoconfig    gcc-16.1.0
csky        allmodconfig    gcc-16.1.0
csky         allnoconfig    gcc-16.1.0
hexagon      allnoconfig    clang-24
i386         allnoconfig    gcc-14
loongarch    allnoconfig    clang-20
m68k        allmodconfig    gcc-16.1.0
m68k         allnoconfig    gcc-16.1.0
m68k        allyesconfig    gcc-16.1.0
microblaze   allnoconfig    gcc-16.1.0
microblaze  allyesconfig    gcc-16.1.0
mips        allmodconfig    gcc-16.1.0
mips         allnoconfig    gcc-16.1.0
mips        allyesconfig    gcc-16.1.0
nios2       allmodconfig    gcc-11.5.0
nios2        allnoconfig    gcc-11.5.0
openrisc    allmodconfig    gcc-16.1.0
openrisc     allnoconfig    gcc-16.1.0
parisc      allmodconfig    gcc-16.1.0
parisc       allnoconfig    gcc-16.1.0
parisc      allyesconfig    gcc-16.1.0
powerpc     allmodconfig    gcc-16.1.0
powerpc      allnoconfig    gcc-16.1.0
riscv        allnoconfig    gcc-16.1.0
riscv       allyesconfig    clang-24
s390        allmodconfig    clang-24
s390         allnoconfig    clang-24
s390        allyesconfig    gcc-16.1.0
sh           allnoconfig    gcc-16.1.0
sh          allyesconfig    gcc-16.1.0
sparc        allnoconfig    gcc-16.1.0
sparc64     allmodconfig    clang-20
um          allmodconfig    clang-17
um           allnoconfig    clang-17
x86_64       allnoconfig    clang-22
xtensa       allnoconfig    gcc-16.1.0
xtensa      allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
