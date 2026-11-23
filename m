Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FBE606A31E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=bpMaGtw1;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DuWfEAe/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBFF840721;
	Mon, 23 Nov 2026 21:16:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N0fh836KwObz; Mon, 23 Nov 2026 21:16:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5D6F740707
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795468602;
	b=hz5Gxg1DAuq9CcD9GOmnfPGV+IbLuJ09XZmWrBa8rxEpyw2tlyhanTjf2ALuWOecqn4D
	 qHAy26sTfgwQ1QNE6cs0ASd1Qf1W8+2RNWUq6Y9uZJrSgxBkcHzgRMOlqDH2bKbQvBaVi
	 950kvhUtIast48RYYy1tIa7kjiElh09VHYPJUxenoMDt0KyN41G7Y14UQ5B+c8oNMVEwO
	 cHaR/dQbcKtZDuCwprRQAPKrj1iEIXOK8LjpMNMEB4mFkJes6w8CBqwTscOWnVJ4hZJyK
	 ZeJtJOEqfGqVrJl4Da0ektobXCKVhlC3jKIea+Y6dVDGW3f9IlOoUD8brNKvXEzDBrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795468602;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=L8FXm9XTG6AsFZsA8tq6+QWASijBpOvyn7rDGZ+mgJU=;
	b=TmQPqTLlKA2D+/VM9aGokURBswyPVcZ0h4fphdCrAhuHWrmeM2z49FVrijChUGPQVvGB
	 yLIfqaT0yAoaknRHxM4PRIgiZjZJaBMmM8rjCXH2tqQ7YeKtu9mem0WEkZraKpCNkh+4E
	 ewhotcG3eEl/GTboFPKnO+RUGBGZ1+QnnOMzwdPD5iKSqgjtqxQ2/2dnlEbtzemU1LVgR
	 u9W/812NjXnPTkdjBq97GJ2STb00iasTG8wJG1ONXFsqMtiw0KHrEw4JPEQ8EipSPMHYu
	 34rQujeIBxcnd/VdMKqkLVItnjmhEnPPmVeTy5My3aN6JwcrGwyXKL2INnEiPh2LKzA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795468602;
	bh=L8FXm9XTG6AsFZsA8tq6+QWASijBpOvyn7rDGZ+mgJU=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bpMaGtw1n+8YP1BP+u7JVfKEOlrGS8QiwCHT93CxK+BhN85+MYw0/BGsZ9JoVcTdX
	 2SQSlOowI7L5GThU2QRuFrsM1gUVsQkwEp+28Rx+2kdIkZb3npdiXFXCkrBupkX9IL
	 HOcF8OsvZixtNt4k0uS/Jwapzk7RAYDVer98iyh5ZIUSgv8xSVXMWqIleClUswic1X
	 8hrXBIryt6WCO2toJYE61mAaASQ2UxdYrdPomtvKyb+pD1tNRpE/xU/g2ngzwLyx/F
	 D17up9/Tso4Bnpi+LMj2jg2DY9Wv/q4KM+BfiUUmLOU3xPeTdoQjWQWiKkMygu0GLX
	 b8hw4LFIt1agg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D6F740707;
	Mon, 23 Nov 2026 21:16:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 748E7311
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 21:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51A4580E9D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 21:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGynvg0pdozF for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 21:16:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2050780E5D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DuWfEAe/
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2050780E5D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 21:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795468600; x=1827004600; h=date:from:to:subject:message-id;
 bh=3mAJMV0q35XT3eh0L2eLvfd++dMoyxLNyKrbpDcU19c=;
 b=DuWfEAe/5p2w04tk1BhAQSvMAHzreNv5kuFbG1r4169a1YXkUnFX0KdU
 XbdWhOIor+KEG/Go07bdwjXJo+7GVvVOu5NKy9sKa49jaQsmZbUvyFTlY
 CuHoWE4ncc4x+YexWduxZLUqSYvq+6WjWU1GlFmvk2a00pVkHSwHjMlRd
 uTRv+UjXmJKy4o7lscVWldYwo68ATAfeFTrPLglBTUkyrYipYCaubO9st
 P9c7NnHrNMQ2umM9yMO7WkC0mjTS0H+ujGrXHDJZ8RwSPDKPBcyaK7ZcM
 +SYRT9sYhYSJ3kMnhazaTQm0DAy/rE+pRhbVMYYtX/GrVJyBWRCciT0Z8 A==;
X-CSE-ConnectionGUID: 9zcm2OzkR5qQqCLA1/CcGQ==
X-CSE-MsgGUID: J8PTBvCrS5yp2IgELKM9KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4189298"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4189298"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 13:16:38 -0800
X-CSE-ConnectionGUID: ztwk5810SrKMOB2hx3+x7A==
X-CSE-MsgGUID: Yw6xcqniTFy1fkH6gTGLLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11731588"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa006.fm.intel.com with ESMTP; 23 Nov 2026 13:16:37 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xVbOs-00000001Nw2-3njj;
 Mon, 23 Nov 2026 21:16:34 +0000
Date: Tue, 24 Nov 2026 05:16:04 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 74630312ba107fe432d0cc52ff8990df57b4151e
Message-ID: <20261124051604.kugQaOMB-lkp@intel.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 74630312ba107fe432d0cc52ff8990df57b4151e  idpf: preserve tcp-data-split setting across hard resets

elapsed time: 2899m

configs tested: 132
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        randconfig-2000-20261121    gcc-16.2.0
alpha        randconfig-2001-20261121    gcc-14.4.0
alpha        randconfig-2200-20261121    gcc-10.5.0 smatch
alpha       randconfig-r2102-20261121    gcc-16.2.0 cocci
arc          randconfig-2000-20261121    gcc-8.5.0
arc          randconfig-2001-20261121    gcc-10.5.0
arc          randconfig-2002-20261121    gcc-16.2.0
arc          randconfig-2003-20261121    gcc-14.4.0
arc          randconfig-2004-20261121    gcc-12.5.0
arc          randconfig-2005-20261121    gcc-8.5.0
arc          randconfig-2200-20261121    gcc-14.4.0 smatch
arm          randconfig-2000-20261121    clang-17
arm          randconfig-2001-20261121    clang-24
arm          randconfig-2002-20261121    clang-24
arm          randconfig-2200-20261121    clang-19   smatch
arm         randconfig-r2310-20261121    clang-20   sparse
arm64        randconfig-2000-20261121    gcc-15.3.0
arm64        randconfig-2001-20261121    gcc-13.5.0
arm64        randconfig-2002-20261121    clang-24
arm64        randconfig-2200-20261121    clang-22   smatch
csky         randconfig-2000-20261121    gcc-16.2.0
csky         randconfig-2001-20261121    gcc-16.2.0
csky         randconfig-2200-20261121    gcc-16.2.0 smatch
csky        randconfig-r2111-20261121    gcc-16.2.0 cocci
csky        randconfig-r2311-20261121    gcc-16.2.0 sparse
hexagon      randconfig-2000-20261121    clang-24
hexagon      randconfig-2001-20261121    clang-24
hexagon      randconfig-2200-20261121    clang-24   smatch
i386         randconfig-2000-20261121    gcc-14
i386         randconfig-2001-20261121    gcc-14
i386         randconfig-2002-20261121    gcc-14
i386         randconfig-2003-20261121    clang-22
i386         randconfig-2004-20261121    gcc-14
i386         randconfig-2005-20261121    gcc-14
i386         randconfig-2200-20261121    clang-22   smatch
i386        randconfig-r2300-20261121    gcc-12     sparse
i386        randconfig-r2309-20261121    gcc-14     sparse
loongarch    randconfig-2000-20261121    clang-22
loongarch    randconfig-2001-20261121    gcc-16.2.0
loongarch    randconfig-2200-20261121    gcc-16.2.0 smatch
m68k         randconfig-2000-20261121    gcc-13.5.0
m68k         randconfig-2001-20261121    gcc-8.5.0
m68k         randconfig-2200-20261121    gcc-8.5.0  smatch
m68k        randconfig-r2105-20261121    gcc-8.5.0  cocci
m68k        randconfig-r2304-20261121    gcc-14.4.0 sparse
m68k        randconfig-r2305-20261121    gcc-16.2.0 sparse
microblaze   randconfig-2000-20261121    gcc-8.5.0
microblaze   randconfig-2001-20261121    gcc-10.5.0
microblaze   randconfig-2200-20261121    gcc-8.5.0  smatch
microblaze  randconfig-r2109-20261121    gcc-10.5.0 cocci
mips         randconfig-2000-20261121    clang-24
mips         randconfig-2001-20261121    gcc-8.5.0
mips         randconfig-2002-20261121    clang-24
mips         randconfig-2200-20261121    clang-21   smatch
nios2        randconfig-2000-20261121    gcc-11.5.0
nios2        randconfig-2001-20261121    gcc-8.5.0
nios2        randconfig-2200-20261121    gcc-10.5.0 smatch
nios2       randconfig-r2301-20261121    gcc-8.5.0  sparse
nios2       randconfig-r2307-20261121    gcc-11.5.0 sparse
openrisc     randconfig-2000-20261121    gcc-12.5.0
openrisc     randconfig-2001-20261121    gcc-14.4.0
openrisc     randconfig-2002-20261121    gcc-16.2.0
openrisc     randconfig-2200-20261121    gcc-14.4.0 smatch
openrisc    randconfig-r2110-20261121    gcc-16.2.0 cocci
parisc       randconfig-2000-20261121    gcc-10.5.0
parisc       randconfig-2001-20261121    gcc-16.2.0
parisc       randconfig-2200-20261121    gcc-16.2.0 smatch
parisc      randconfig-r2103-20261121    gcc-11.5.0 cocci
parisc      randconfig-r2303-20261121    gcc-13.5.0 sparse
powerpc      randconfig-2000-20261121    clang-24
powerpc      randconfig-2001-20261121    gcc-15.3.0
powerpc      randconfig-2002-20261121    clang-24
powerpc      randconfig-2200-20261121    gcc-11.5.0 smatch
powerpc64    randconfig-2000-20261121    clang-24
powerpc64    randconfig-2001-20261121    gcc-10.5.0
powerpc64    randconfig-2002-20261121    gcc-8.5.0
powerpc64    randconfig-2200-20261121    gcc-10.5.0 smatch
powerpc64   randconfig-r2101-20261121    gcc-15.3.0 cocci
riscv        randconfig-2000-20261121    gcc-9.5.0
riscv        randconfig-2001-20261121    gcc-11.5.0
riscv        randconfig-2002-20261121    clang-17
riscv        randconfig-2003-20261121    gcc-11.5.0
riscv        randconfig-2004-20261121    gcc-8.5.0
riscv        randconfig-2005-20261121    clang-17
riscv        randconfig-2200-20261121    clang-24   smatch
riscv       randconfig-r2107-20261121    clang-24   cocci
riscv       randconfig-r2308-20261121    clang-24   sparse
s390         randconfig-2000-20261121    clang-24
s390         randconfig-2001-20261121    clang-24
s390         randconfig-2002-20261121    clang-22
s390         randconfig-2003-20261121    clang-20
s390         randconfig-2004-20261121    gcc-9.5.0
s390         randconfig-2005-20261121    gcc-15.3.0
s390         randconfig-2200-20261121    gcc-8.5.0  smatch
s390        randconfig-r2104-20261121    clang-24   cocci
s390        randconfig-r2108-20261121    gcc-8.5.0  cocci
sh           randconfig-2000-20261121    gcc-12.5.0
sh           randconfig-2001-20261121    gcc-10.5.0
sh           randconfig-2002-20261121    gcc-16.2.0
sh           randconfig-2003-20261121    gcc-16.2.0
sh           randconfig-2004-20261121    gcc-16.2.0
sh           randconfig-2005-20261121    gcc-10.5.0
sh           randconfig-2200-20261121    gcc-10.5.0 smatch
sh          randconfig-r2100-20261121    gcc-16.2.0 cocci
sh          randconfig-r2306-20261121    gcc-10.5.0 sparse
sparc        randconfig-2000-20261121    gcc-16.2.0
sparc        randconfig-2001-20261121    gcc-14.4.0
sparc        randconfig-2200-20261121    gcc-8.5.0  smatch
sparc64      randconfig-2000-20261121    gcc-9.5.0
sparc64      randconfig-2001-20261121    gcc-8.5.0
sparc64      randconfig-2200-20261121    clang-20   smatch
sparc64     randconfig-r2106-20261121    clang-24   cocci
um           randconfig-2000-20261121    clang-17
um           randconfig-2001-20261121    clang-24
um           randconfig-2200-20261121    gcc-14     smatch
um          randconfig-r2302-20261121    clang-24   sparse
x86_64       randconfig-2000-20261121    clang-22
x86_64       randconfig-2001-20261121    clang-22
x86_64       randconfig-2002-20261121    clang-22
x86_64       randconfig-2003-20261121    gcc-14
x86_64       randconfig-2004-20261121    gcc-14
x86_64       randconfig-2005-20261121    clang-22
x86_64       randconfig-2100-20261121    clang-22   cocci
x86_64       randconfig-2101-20261121    gcc-14     cocci
x86_64       randconfig-2102-20261121    gcc-14     cocci
x86_64       randconfig-2103-20261121    clang-22   cocci
x86_64       randconfig-2104-20261121    clang-22   cocci
x86_64       randconfig-2105-20261121    gcc-14     cocci
x86_64       randconfig-2200-20261121    gcc-14     smatch
xtensa       randconfig-2000-20261121    gcc-8.5.0
xtensa       randconfig-2001-20261121    gcc-12.5.0
xtensa       randconfig-2200-20261121    gcc-12.5.0 smatch

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
