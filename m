Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3E8606A31C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=zHNl94Qs;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E/Hg5UX2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0489040652;
	Mon, 16 Nov 2026 09:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J2-gy5KfAlMG; Mon, 16 Nov 2026 09:21:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4B2984062A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794820905;
	b=NupoZe6KBTT0xC4VNaMk39+pMKkNH6L3YuYbGYHG6OGmyxnq9r51tf5FEIo9V+JfcGEP
	 ia4ivG+iWeWAr7TcgoaPWJ0/pOMYbBtgjFp2skjCago/gG9NQmmnOb0gfepMbQn/WPc0a
	 XNILYowkc4NMsLe0al10JhwA19jLaF5uPf7Cbb3XncS2XfAewUA6jn7kv6qWF/pMlu5Py
	 2E8njI1yR/KFnT5EUv+RZMUIlRmahcTwa/r3w24AzvI1u9X/mI3ANzXATLsprrTX/ya6j
	 o6MdO7MlNP5c+MdAxLJHpMOkET5iEcZ/EoZoSf5owUYJW52NJHEuDfI0i0EbrrL+ECw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794820905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=69jQIMNr49WJysFnqRVKbmvXqvB+117MCuLrDFqX89E=;
	b=tgbkhqFICDl6kwau97UfhNXdHHVwIBp47I94hawnNz6W3V7M/DD5s4BodPxy6HfErFFf
	 FxTmLGdm5Xl6kWSdu1wcWzx1L9avFUvdapeL1gGWaQu/ZsnPY5ZIQ/dXab9VhiGZFJOSs
	 5bCdghk+AfR86nhGqR59ycP0Hl9VSgeI10U5JRju284EQZJGGLuHE0SqM7zx0GtXbcXZk
	 jXsm8jadzZwQPNbMgVqyQzy2DQ0n4BhQCKcYwdU1slrQ2CLzMsL7d6b9kjS/hn5ttibDl
	 V9XlArggWfuWkzVa1fAnNaEeI8kU3vKCYabM7OzJpPogLHkJSIKZ2/RZPfZlyIWsu7g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794820905;
	bh=69jQIMNr49WJysFnqRVKbmvXqvB+117MCuLrDFqX89E=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zHNl94QsZl4XRZR+k62NDxj9pfPeFHoDchFv0zVP9oz2WHbJTCMi1036kWAd5M/nN
	 R69NiAwFI1Oj3jVYjsfntnbmWgdR49dyHi1CPMJZR1HncOlDZWdoDZslAS9AqwRHHg
	 n5BHyFOQLASyKrxgVOe/5hnpu3z24isifi9cPPxGoE2RyGljAtqraZi38LCCCMhWQF
	 IaoYtYNpDoF+HnVqZqGgtELok2Ecx93EYubQ9qvrV7W558O3Nh/wNbOgiFpVMiTPkY
	 IEdE1c2XMhFvoEUI/7od++u0AUBsnWYHyahzOcW9fNj9itC1VwLqIo1M87v7w16aH6
	 5Tbttr4mwfv/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B2984062A;
	Mon, 16 Nov 2026 09:21:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 60DCB260
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 09:21:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51E7980E1D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 09:21:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Izzbx-jJJD45 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 09:21:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B98AC80E38
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=E/Hg5UX2
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B98AC80E38
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 09:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794820903; x=1826356903; h=date:from:to:subject:message-id;
 bh=EsXv5i0CRPx6yIT0cWsep7EiITEbazBOvWqjrEAVo8s=;
 b=E/Hg5UX2lN9OgYJEcg+eP9eweRfIaMdpZZmzN8O+8qBf9WXebPSAMdhJ
 Rj1HdTYyPlBQM2+sbfDq9O4SBOREKHwt2wqDTLEqUQhkNBEiM9vLCnHfC
 vEr7xTLpTQqM5JEf5S0woEQ8lP7tL7KiIHJLFFZISkzcBNtWSBvlI7lWo
 oPo+3tKeWOlkhM+yizBECqSVBtWwPI9NBZ8BuIuo6LeNzX/Z0vOxXlMpa
 aN3yDvrHDLQaK76ILAOu7sG9N/Gt+QhvgXjhhA4C1+qRi0019KMoBCtPg
 BvrXXfHUyN+JwC8KoM/nVfQv4c2Q/RaLG4YuhKpbAqmB5U0OK/T0Xqrgo g==;
X-CSE-ConnectionGUID: 0+CR6FT6RxemW3bxaDfxyg==
X-CSE-MsgGUID: 51hm5q7MTOSsgJr7QcV/cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3591934"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3591934"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 01:21:41 -0800
X-CSE-ConnectionGUID: 5tyaaAidQAG1FunF8WN7Lg==
X-CSE-MsgGUID: 4pdMzfLVSG6Ic1sT/ysfeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9826952"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa001.fm.intel.com with ESMTP; 16 Nov 2026 01:21:40 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xSsu9-000000018DP-2Ynz;
 Mon, 16 Nov 2026 09:21:37 +0000
Date: Mon, 16 Nov 2026 17:20:52 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 53eff18876c7dd44ba6f89c79c96c07586e10302
Message-ID: <20261116172052.JuDMFsr7-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 53eff18876c7dd44ba6f89c79c96c07586e10302  ice: do not classify EAPOL MAC address as LLDP

elapsed time: 2956m

configs tested: 151
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        randconfig-2000-20261114    gcc-12.5.0
alpha        randconfig-2001-20261114    gcc-12.5.0
alpha        randconfig-2200-20261114    gcc-9.5.0  smatch
alpha       randconfig-r2303-20261114    gcc-8.5.0  sparse
alpha       randconfig-r2306-20261114    gcc-13.5.0 sparse
arc          randconfig-2000-20261114    gcc-11.5.0
arc          randconfig-2001-20261114    gcc-11.5.0
arc          randconfig-2002-20261114    gcc-11.5.0
arc          randconfig-2003-20261114    gcc-11.5.0
arc          randconfig-2004-20261114    gcc-11.5.0
arc          randconfig-2005-20261114    gcc-11.5.0
arc          randconfig-2200-20261114    gcc-8.5.0  smatch
arc         randconfig-r2103-20261114    gcc-15.3.0 cocci
arm          randconfig-2000-20261114    gcc-10.5.0
arm          randconfig-2001-20261114    gcc-10.5.0
arm          randconfig-2002-20261114    gcc-10.5.0
arm          randconfig-2200-20261114    clang-17   smatch
arm64        randconfig-2000-20261114    gcc-10.5.0
arm64        randconfig-2001-20261114    gcc-10.5.0
arm64        randconfig-2002-20261114    gcc-10.5.0
arm64        randconfig-2200-20261114    clang-17   smatch
csky         randconfig-2000-20261114    gcc-16.2.0
csky         randconfig-2001-20261114    gcc-16.2.0
csky         randconfig-2200-20261114    gcc-16.2.0 smatch
csky        randconfig-r2107-20261114    clang-24   cocci
csky        randconfig-r2302-20261114    gcc-8.5.0  sparse
csky        randconfig-r2307-20261114    gcc-13.5.0 sparse
csky        randconfig-r2310-20261114    gcc-13.5.0 sparse
hexagon      randconfig-2000-20261114    gcc-16.2.0
hexagon      randconfig-2001-20261114    gcc-16.2.0
hexagon      randconfig-2200-20261114    clang-24   smatch
i386         randconfig-2000-20261114    clang-22
i386         randconfig-2001-20261114    clang-22
i386         randconfig-2002-20261114    clang-22
i386         randconfig-2003-20261114    clang-22
i386         randconfig-2004-20261114    clang-22
i386         randconfig-2005-20261114    clang-22
i386         randconfig-2100-20261114    gcc-14     cocci
i386         randconfig-2101-20261114    gcc-14     cocci
i386         randconfig-2102-20261114    gcc-14     cocci
i386         randconfig-2103-20261114    gcc-14     cocci
i386         randconfig-2104-20261114    gcc-14     cocci
i386         randconfig-2105-20261114    gcc-14     cocci
i386         randconfig-2200-20261114    gcc-14     smatch
i386         randconfig-2300-20261114    clang-22   sparse
i386         randconfig-2301-20261114    clang-22   sparse
i386         randconfig-2302-20261114    clang-22   sparse
i386        randconfig-r2300-20261114    gcc-8.5.0  sparse
loongarch    randconfig-2000-20261114    gcc-11.5.0
loongarch    randconfig-2001-20261114    gcc-11.5.0
loongarch    randconfig-2200-20261114    clang-18   smatch
m68k         randconfig-2000-20261114    gcc-12.5.0
m68k         randconfig-2001-20261114    gcc-12.5.0
m68k         randconfig-2200-20261114    gcc-16.2.0 smatch
m68k        randconfig-r2301-20261114    gcc-8.5.0  sparse
microblaze   randconfig-2000-20261114    gcc-12.5.0
microblaze   randconfig-2001-20261114    gcc-12.5.0
microblaze   randconfig-2200-20261114    gcc-9.5.0  smatch
mips         randconfig-2000-20261114    gcc-16.2.0
mips         randconfig-2001-20261114    gcc-16.2.0
mips         randconfig-2002-20261114    gcc-16.2.0
mips         randconfig-2200-20261114    gcc-15.3.0 smatch
mips        randconfig-r2308-20261114    gcc-13.5.0 sparse
nios2        randconfig-2000-20261114    gcc-11.5.0
nios2        randconfig-2001-20261114    gcc-11.5.0
nios2        randconfig-2200-20261114    gcc-11.5.0 smatch
openrisc     randconfig-2000-20261114    gcc-16.2.0
openrisc     randconfig-2001-20261114    gcc-16.2.0
openrisc     randconfig-2002-20261114    gcc-16.2.0
openrisc     randconfig-2200-20261114    gcc-16.2.0 smatch
openrisc    randconfig-r2101-20261114    gcc-15.3.0 cocci
openrisc    randconfig-r2309-20261114    gcc-13.5.0 sparse
parisc       randconfig-2000-20261114    gcc-11.5.0
parisc       randconfig-2001-20261114    gcc-11.5.0
parisc       randconfig-2200-20261114    gcc-8.5.0  smatch
parisc      randconfig-r2305-20261114    gcc-8.5.0  sparse
powerpc      randconfig-2000-20261114    gcc-8.5.0
powerpc      randconfig-2001-20261114    gcc-8.5.0
powerpc      randconfig-2002-20261114    gcc-8.5.0
powerpc      randconfig-2200-20261114    clang-24   smatch
powerpc     randconfig-r2100-20261114    gcc-15.3.0 cocci
powerpc     randconfig-r2111-20261114    clang-24   cocci
powerpc64    randconfig-2000-20261114    gcc-8.5.0
powerpc64    randconfig-2001-20261114    gcc-8.5.0
powerpc64    randconfig-2002-20261114    gcc-8.5.0
powerpc64    randconfig-2200-20261114    clang-17   smatch
powerpc64   randconfig-r2106-20261114    clang-24   cocci
powerpc64   randconfig-r2110-20261114    clang-24   cocci
riscv        randconfig-2000-20261114    gcc-12.5.0
riscv        randconfig-2001-20261114    gcc-12.5.0
riscv        randconfig-2002-20261114    gcc-12.5.0
riscv        randconfig-2003-20261114    gcc-12.5.0
riscv        randconfig-2004-20261114    gcc-12.5.0
riscv        randconfig-2005-20261114    gcc-12.5.0
riscv        randconfig-2200-20261114    clang-24   smatch
s390         randconfig-2000-20261114    clang-24
s390         randconfig-2001-20261114    clang-24
s390         randconfig-2002-20261114    clang-24
s390         randconfig-2003-20261114    clang-24
s390         randconfig-2004-20261114    clang-24
s390         randconfig-2005-20261114    clang-24
s390         randconfig-2200-20261114    clang-24   smatch
sh           randconfig-2000-20261114    gcc-13.5.0
sh           randconfig-2001-20261114    gcc-13.5.0
sh           randconfig-2002-20261114    gcc-13.5.0
sh           randconfig-2003-20261114    gcc-13.5.0
sh           randconfig-2004-20261114    gcc-13.5.0
sh           randconfig-2005-20261114    gcc-13.5.0
sh           randconfig-2200-20261114    gcc-9.5.0  smatch
sh          randconfig-r2102-20261114    gcc-15.3.0 cocci
sh          randconfig-r2104-20261114    gcc-15.3.0 cocci
sparc        randconfig-2000-20261114    clang-21
sparc        randconfig-2001-20261114    clang-21
sparc        randconfig-2200-20261114    gcc-8.5.0  smatch
sparc       randconfig-r2105-20261114    gcc-15.3.0 cocci
sparc       randconfig-r2108-20261114    clang-24   cocci
sparc       randconfig-r2304-20261114    gcc-8.5.0  sparse
sparc64      randconfig-2000-20261114    clang-21
sparc64      randconfig-2001-20261114    clang-21
sparc64      randconfig-2200-20261114    gcc-16.2.0 smatch
sparc64     randconfig-r2311-20261114    gcc-13.5.0 sparse
um           randconfig-2000-20261114    clang-21
um           randconfig-2001-20261114    clang-21
um           randconfig-2200-20261114    gcc-14     smatch
x86_64                          kexec    clang-22
x86_64       randconfig-2000-20261114    gcc-14
x86_64       randconfig-2001-20261114    gcc-14
x86_64       randconfig-2002-20261114    gcc-14
x86_64       randconfig-2003-20261114    gcc-14
x86_64       randconfig-2004-20261114    gcc-14
x86_64       randconfig-2005-20261114    gcc-14
x86_64       randconfig-2100-20261114    gcc-14     cocci
x86_64       randconfig-2101-20261114    gcc-14     cocci
x86_64       randconfig-2102-20261114    gcc-14     cocci
x86_64       randconfig-2103-20261114    gcc-14     cocci
x86_64       randconfig-2104-20261114    gcc-14     cocci
x86_64       randconfig-2105-20261114    gcc-14     cocci
x86_64       randconfig-2200-20261114    gcc-14     smatch
x86_64       randconfig-2300-20261114    clang-22   sparse
x86_64       randconfig-2301-20261114    clang-22   sparse
x86_64       randconfig-2302-20261114    clang-22   sparse
x86_64                       rhel-9.4    clang-22
x86_64                   rhel-9.4-bpf    clang-22
x86_64                  rhel-9.4-func    clang-22
x86_64            rhel-9.4-kselftests    clang-22
x86_64                 rhel-9.4-kunit    clang-22
x86_64                   rhel-9.4-ltp    clang-22
x86_64                  rhel-9.4-rust    clang-22
xtensa       randconfig-2000-20261114    gcc-16.2.0
xtensa       randconfig-2001-20261114    gcc-16.2.0
xtensa      randconfig-r2109-20261114    clang-24   cocci

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
