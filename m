Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25925C5DF67
	for <intel-wired-lan@archiver.kernel.org>; Sun, 16 Aug 2026 00:04:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAE0B80BB5;
	Sun, 16 Aug 2026 00:04:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 42VPJbZ1uKQB; Sun, 16 Aug 2026 00:04:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 013CE80BBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786838666;
	bh=k2W3m2DdmX/G4obRt5Gz3dF5aAX2B3GqPSzl8/gibf0=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i7Mn/cHjBIEBD9j4Hz+FsFXeIcRafy4mYxjrNB1hcZ5H6TyoyFm34cUAgcBIxxQVp
	 lKTL6GNXlGZl1PGf0uzQEXS0SbAwBmRNduDddhgNzUYOe2FUfy7XJyhDQQk4AIR+l4
	 GRPVLjLwLPK5bxTSgQJNoEvifqh+vBqpfNWz40GZQx64/IGRiSCyal0IX6gYAo1UM6
	 lAQmeudcqhrMqoB0sViPgK/q1RJ1iKyxvbRY8WxLlmxJK2EDVOWBpT8hOndVFlwDVi
	 1fmwIsRgMpbs2IerbpwK+MH6AdRZ+mihn16ubVw1lvnt1DZgrVFsrr5ymvFXGPaTCV
	 2w+Z66shvrf0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 013CE80BBE;
	Sun, 16 Aug 2026 00:04:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 68D5F109
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 00:04:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5AB23400CD
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 00:04:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4YyNu-cOaFRm for <intel-wired-lan@lists.osuosl.org>;
 Sun, 16 Aug 2026 00:04:23 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4BB70400BB
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4BB70400BB
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Qa4I2ZO/
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4BB70400BB
 for <intel-wired-lan@lists.osuosl.org>; Sun, 16 Aug 2026 00:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786838663; x=1818374663; h=date:from:to:subject:message-id;
 bh=ZTcvTrVNTu+ijzefmjsQc2IGU0Gv1O6f+7GeMmII4SU=;
 b=Qa4I2ZO/mhG7PeUgQskak1N4/byx4C+DI5B7iFlZYAIFN3kpHe7vUCjL
 5/+6BzvjYzzw/qKWSA8IalQk5a+aIT4DJQaNhe/xqnuWO9S2LmTNI+awx
 75u7raZ088gEGaUdRk1Stxbya5rvlFDPjU4SzCEPP+YVeIrllfBdvMWzj
 n09bYfBmV6znoJmbOTkMxtbHp0tgOz/mZLpXIN88LqT3ILBsVDXYdT58n
 WRbIRtVlJZit66vFRSxBomYW1uG7yMveWEQQApMzZrjS1ehLoIlSjZenx
 ZLzgX6Sh+SaKXVw8aDQxksLFTdAXFxs2grluzWntPpeBMzjlR3Bu5LSdR w==;
X-CSE-ConnectionGUID: JLuclOixTC+9j1gFEn1fpQ==
X-CSE-MsgGUID: 9CgpittgSk2QD/13Yquv/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="87224167"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; d="scan'208";a="87224167"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2026 17:04:22 -0700
X-CSE-ConnectionGUID: CASJGGgaT+SpH1Bannq73g==
X-CSE-MsgGUID: HJ9wGidITO2gigKTYyVS6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; d="scan'208";a="263222752"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa010.jf.intel.com with ESMTP; 15 Aug 2026 17:04:22 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wvOMN-00000000cYg-3IHR;
 Sun, 16 Aug 2026 00:04:19 +0000
Date: Sun, 16 Aug 2026 08:04:02 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608160849.37muDBCx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 9dc6c1cf460c0ec718824deb93bed50c43ccca4f
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
branch HEAD: 9dc6c1cf460c0ec718824deb93bed50c43ccca4f  ixgbe: implement Total Port Shutdown for E610

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 774m

configs tested: 15
configs skipped: 1

tested configs:
alpha           allnoconfig    gcc-16.1.0
alpha          allyesconfig    gcc-16.1.0
alpha             defconfig    gcc-16.1.0
arc            allmodconfig    gcc-16.1.0
arc            allyesconfig    gcc-16.1.0
csky           allmodconfig    gcc-16.1.0
i386           allmodconfig    gcc-14
loongarch         defconfig    clang-24
nios2          allmodconfig    gcc-11.5.0
nios2           allnoconfig    gcc-11.5.0
parisc         allmodconfig    gcc-16.1.0
parisc         allyesconfig    gcc-16.1.0
parisc            defconfig    gcc-16.1.0
powerpc    bamboo_defconfig    clang-21
sh                defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
