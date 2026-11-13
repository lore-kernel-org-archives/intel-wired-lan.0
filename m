Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37BF606A321
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 01:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=2IpHfL4q;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IeBP1nEX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 786D3606FF;
	Fri, 13 Nov 2026 01:11:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BsSGsPs3YSsE; Fri, 13 Nov 2026 01:11:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 88525606B1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794532290;
	b=ZAPPlf7YEN+abemuSGvvMXzk6U+DnWjdmmxZMlDUdv7fWUf1idHq+jslPwqbDUCMPfU4
	 Q5hFS+IFd2N+LCbWLBdDQXqRZHzBiTdi1bxPohs8BYt1eQc/j2t/4QccX3DiGvpQekhVa
	 adJYFvKnqmwX/m4/HBFvtiEn7jFXv7HOdOpn4lc2vZJyEM3OZ8+TN+sneI5upPjOeFHAF
	 1/BeRjYXq1ge0WiCaKXMdm3h3K7tdP9/wVYE6Ptc9+i17ZP/rAYokwtnK3bzbt9s/9/0O
	 3d12ApL+hQsoTwa3TqXASlSRpofAJ7OlhSpgUenzPHAUmGPCZ+ErCO4nWJ6JnQfLgMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794532290;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fEz/73mbSMGPllxrFuSOQ51F5joon0GOd8GKnxm4xLE=;
	b=p4FoohbILZVQ+B+43Fpqd8EYzNSyYpUK72hyXNDSZP62Q5nWYoFq7jByX5hH0dF+E+ti
	 C4Y861bsL43KHqcum+0D096OeltHwYL/odLDZU1j+njIEpmIjXwS/bmCGIy91r6MiaviW
	 HEjjiI+6rvjTuTsJ5HUk/Rwdf8iy6hQgI+f1n3QiEzFjLdUjPdo7tHh5J4g2kmxVLC45X
	 R9ixD/UFS9g2pNBz7s+x5mxPLbv9vzvjnic58Nz0kSjHVy+CtDwJb7LpZcai06nE2v8NA
	 KhRbINx6yxO0tqSTO3r9giIU2Iyqt4zOVrqJO2UiyXlbPq8bdp++Kb6lJZSmy6RcDMg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794532290;
	bh=fEz/73mbSMGPllxrFuSOQ51F5joon0GOd8GKnxm4xLE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2IpHfL4q110kmaUkwwTWZ0LKrE6WAGTHKqP2wBK7o81OFOL4kL4l12DkZV5MEqHYJ
	 byrX3SI5xiQ4EI8fxyT6heY30TbVAET5v+h2H3ITKyed4g7OEUFRxrLomISJXlHLoZ
	 22Ij7Xztm+bX2r63RTCMhjm/C4LB/8U+H1xWrcNQNdt74MVjdlng1jEdcNZqjLnLlk
	 2Y9IEECGxGOPHcSEVtEHz3GxbTS8uqrACB4/nGFW12Xf8+1I94j1XdRh0dGi5ZtYX2
	 vcfdZTm0SciuVaZ58RAdaajc0AHzWkyGamBnP57bAam9moGDPu9yfZeBrnYJNnbrAl
	 SBpJ8+YqrfUTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88525606B1;
	Fri, 13 Nov 2026 01:11:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5740F2FE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 01:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D60E40AA2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 01:11:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kHi0jdV00v0C for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 01:11:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB50240A79
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IeBP1nEX
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB50240A79
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 01:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794532287; x=1826068287; h=date:from:to:subject:message-id;
 bh=xinG5ePjEfG3trjhlH4cQ9qkHzECpRJnYFZE7e8YPG8=;
 b=IeBP1nEXWGPIc2BO6cqv2+T+Pnp1t/3p5qv6BvWS8hLUc5Bip73Zwgxu
 5r2ePakGZMvZjxcA3unxKGhBDCGuTMh3J6RzZ4nu3MAWJ7rnOXfHjKSL6
 X7AQBTCKgUhdLRf3RP5k0TH5jjCOFvq0b8y0+WKa/ywnp4VdbY+YJEcW/
 qnCBZTurQnChASYVEss99GeXPtKLYyWYHCKP5P+LRV9s/DQqXOVheYsgd
 6CaWxUf92dw4Jy1QJoS8fwghEe59Z/+2ktu+l+2bR9cF/c2CCyYutvcc/
 4lmwV6rNrmX20R78kAAcvMUab0xZr0NXRXq14Zowb0qv9vVDTROobB6aH A==;
X-CSE-ConnectionGUID: TzY41ynEQRqiPkAhRs1rjg==
X-CSE-MsgGUID: lonoh49YSJiMQEchBaO+rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3429160"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3429160"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 17:11:26 -0800
X-CSE-ConnectionGUID: zJqmEPGmT16u4x2iomir5g==
X-CSE-MsgGUID: w0pGPsq1TyKru+piXy6vcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8627361"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa008.jf.intel.com with ESMTP; 12 Nov 2026 17:11:26 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xRfp5-000000012H9-2DDR;
 Fri, 13 Nov 2026 01:11:23 +0000
Date: Fri, 13 Nov 2026 09:11:21 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 ff2563fbe0e6d28f561d58012efb9b47595fd933
Message-ID: <20261113091121.eBAMg7MT-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: ff2563fbe0e6d28f561d58012efb9b47595fd933  ixgbe: document raw ip4 flow match

elapsed time: 2900m

configs tested: 92
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        randconfig-2000-20261111    gcc-14.4.0
alpha        randconfig-2001-20261111    gcc-12.5.0
alpha       randconfig-r2100-20261111    gcc-14.4.0 cocci
arc          randconfig-2000-20261111    gcc-14.4.0
arc          randconfig-2001-20261111    gcc-16.2.0
arc          randconfig-2002-20261111    gcc-14.4.0
arc          randconfig-2003-20261111    gcc-8.5.0
arc          randconfig-2004-20261111    gcc-10.5.0
arc          randconfig-2005-20261111    gcc-12.5.0
arm          randconfig-2000-20261111    gcc-16.2.0
arm          randconfig-2001-20261111    clang-18
arm          randconfig-2002-20261111    gcc-16.2.0
arm          randconfig-2200-20261111    gcc-8.5.0  smatch
arm         randconfig-r2110-20261111    gcc-8.5.0  cocci
arm64        randconfig-2000-20261111    gcc-8.5.0
arm64        randconfig-2001-20261111    gcc-11.5.0
arm64        randconfig-2002-20261111    gcc-9.5.0
arm64       randconfig-r2107-20261111    gcc-15.3.0 cocci
csky         randconfig-2000-20261111    gcc-16.2.0
csky         randconfig-2001-20261111    gcc-12.5.0
csky         randconfig-2200-20261111    gcc-16.2.0 smatch
hexagon      randconfig-2000-20261111    clang-22
hexagon      randconfig-2001-20261111    clang-21
hexagon      randconfig-2200-20261111    clang-24   smatch
i386         randconfig-2000-20261111    gcc-12
i386         randconfig-2001-20261111    gcc-14
i386         randconfig-2002-20261111    clang-22
i386         randconfig-2003-20261111    gcc-14
i386         randconfig-2004-20261111    gcc-14
i386         randconfig-2005-20261111    gcc-14
i386         randconfig-2100-20261111    gcc-14     cocci
i386         randconfig-2101-20261111    clang-22   cocci
i386         randconfig-2102-20261111    gcc-14     cocci
i386         randconfig-2103-20261111    clang-22   cocci
i386         randconfig-2104-20261111    gcc-14     cocci
i386         randconfig-2105-20261111    clang-22   cocci
i386         randconfig-2200-20261111    gcc-14     smatch
loongarch    randconfig-2000-20261111    clang-22
loongarch    randconfig-2001-20261111    clang-24
loongarch    randconfig-2200-20261111    gcc-16.2.0 smatch
loongarch   randconfig-r2106-20261111    gcc-16.2.0 cocci
m68k         randconfig-2000-20261111    gcc-15.3.0
m68k         randconfig-2001-20261111    gcc-8.5.0
m68k         randconfig-2200-20261111    gcc-9.5.0  smatch
m68k        randconfig-r2104-20261111    gcc-10.5.0 cocci
m68k        randconfig-r2108-20261111    gcc-8.5.0  cocci
microblaze   randconfig-2000-20261111    gcc-10.5.0
microblaze   randconfig-2001-20261111    gcc-12.5.0
microblaze   randconfig-2200-20261111    gcc-8.5.0  smatch
mips        randconfig-r2109-20261111    gcc-15.3.0 cocci
mips        randconfig-r2111-20261111    clang-24   cocci
nios2        randconfig-2000-20261111    gcc-11.5.0
nios2        randconfig-2001-20261111    gcc-8.5.0
nios2        randconfig-2200-20261111    gcc-8.5.0  smatch
openrisc     randconfig-2200-20261111    gcc-16.2.0 smatch
parisc       randconfig-2000-20261111    gcc-16.2.0
parisc       randconfig-2001-20261111    gcc-14.4.0
powerpc      randconfig-2000-20261111    clang-24
powerpc      randconfig-2001-20261111    gcc-8.5.0
powerpc      randconfig-2002-20261111    gcc-15.3.0
powerpc      randconfig-2200-20261111    gcc-13.5.0 smatch
powerpc64    randconfig-2000-20261111    gcc-8.5.0
powerpc64    randconfig-2001-20261111    gcc-11.5.0
powerpc64    randconfig-2002-20261111    gcc-13.5.0
powerpc64   randconfig-r2105-20261111    clang-24   cocci
riscv        randconfig-2000-20261111    clang-24
riscv        randconfig-2001-20261111    clang-20
riscv        randconfig-2002-20261111    gcc-8.5.0
riscv        randconfig-2003-20261111    clang-21
riscv        randconfig-2004-20261111    clang-24
riscv        randconfig-2005-20261111    clang-24
riscv        randconfig-2200-20261111    clang-24   smatch
riscv       randconfig-r2102-20261111    gcc-9.5.0  cocci
s390         randconfig-2000-20261111    gcc-15.3.0
s390         randconfig-2001-20261111    gcc-13.5.0
s390         randconfig-2002-20261111    clang-17
s390         randconfig-2003-20261111    gcc-13.5.0
s390         randconfig-2004-20261111    gcc-11.5.0
s390         randconfig-2005-20261111    gcc-8.5.0
sh           randconfig-2000-20261111    gcc-16.2.0
sh           randconfig-2001-20261111    gcc-16.2.0
sh           randconfig-2002-20261111    gcc-16.2.0
sh           randconfig-2003-20261111    gcc-16.2.0
sh           randconfig-2004-20261111    gcc-14.4.0
sh           randconfig-2005-20261111    gcc-16.2.0
sh           randconfig-2200-20261111    gcc-16.2.0 smatch
sparc        randconfig-2200-20261111    gcc-12.5.0 smatch
sparc64      randconfig-2200-20261111    gcc-9.5.0  smatch
x86_64       randconfig-2200-20261111    gcc-14     smatch
xtensa       randconfig-2000-20261111    gcc-8.5.0
xtensa       randconfig-2001-20261111    gcc-10.5.0
xtensa      randconfig-r2101-20261111    gcc-8.5.0  cocci

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
