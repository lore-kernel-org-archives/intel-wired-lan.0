Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D371EC79FB6
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Sep 2026 17:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B5E3407AE;
	Wed,  9 Sep 2026 17:03:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IWoGLuBypXtC; Wed,  9 Sep 2026 17:03:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BC32B407B7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788973425;
	b=tcX5aSfGgHP+S7ljKtic/opxOu6Nlh7udI0UB8AaWvZoaSnnR5A6Xpd+0SIiZfG0JQmg
	 c4kIfgt54S43xSKTGvkqVaTFsCQlvSFnDtbYIZ6A2ahu/wJQBdonSIzIGSKKbOUAZwT7C
	 Mux5U/9b3AtMdalIbiA+ugG+0aIshihvw+KtZTU3cwFtql0YHg2BcevaYqXALNK8eyIRB
	 PUYVX2SjpAyBS+E9/rT2l69hGABm+cl4Qq2f4IZpVAnx/NlZN3Wd+6AqsEvLikV6PYFW2
	 OsdIGX6+IBxFQXzxP0mTITj3DA7s7h9ufDnm45kPT4C/v38rznT1dJ0pTSyBsqZIV8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788973425;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:Received:Date:From:To:Subject:Message-ID:User-Agent:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KNC8xyEdRsiLy65sdub3JZYm4MuVxcOvJVrikqZtSfk=;
	b=WOd5syQJD+gRqCs837lr0pSI2Y0+U3+w4uDNHjqK1JNBmDQn3L8b4HGtPov7IfnrUDAr
	 g8dJv3peNn4dm5ZFOtUXP85vsW91MUxyFrCvLez4t0F95oTiAO3ruYiJHalUyrs6xvZsQ
	 6ik5cTsogtep6e0NPCnawZTTpMxX0XnhakFSnkOLfp6OCW/xLhyT1hz4EUeIQtxNaPh7a
	 1urbF4VWj6GzGN8fsz2vedB5yjyukuVEOUZvNVSbCFDcFECUyredlZanBQ3dWNj0OlI8p
	 mCt2ZOJuFcgx/pyVSLtVuhNQ9cpDd6XRkl1s3K7nPpg3nuE9pPNuJb1TOQ7kN4iNC9g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788973425;
	bh=KNC8xyEdRsiLy65sdub3JZYm4MuVxcOvJVrikqZtSfk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hUexZjb6LKD3R9d8unPuzbtBUvmC/NOXLSXUikMpFHj7Yj4kCVOzudc569vEQL/wv
	 PMLboGMtlJ9ic+/li3tb/oIxRmGtykbrjVbQDMFm6h4PmBxyCZYWjuDvG4FyNmY8zH
	 PzX2IWmIAYIRgtK7yJ4aHcCcif/rtvRxRLbZeu9vCsd5rSvHMVyCW42jJdB2tU/fpo
	 bznCTXNGkJtwdctHg1ncJrzOzrdVDC74P7cxczU8jj3Vv9xtPUrH1rUf5a3cPO+pzg
	 pU0o2byT156TI1JopqAM058s7mKFYbt8m3Ap7xCpuFH+6KcNAh7UBnp9KtT3YE4/gj
	 59egnJV4kE51w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC32B407B7;
	Wed,  9 Sep 2026 17:03:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9990D29C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 17:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B404400BC
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 17:03:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nRnWTVCC5eKG for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Sep 2026 17:03:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 49EA640055
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788973423;
 b=NWFZI2tkyUfWdXWXdbJxt/t2JTAD6K4Xb0E77QzH4ysI6I0OaljvcrIJ9YWuHXdHiQ5F
 dqoz6JxXWzV4MyJCDDkF/grHyjM3htE+6/Tvg5j1dAqGQb6sGa2BHJ+1tfAHfh9BIUUoR
 1H5qNCIybjqTTYbVhY0d9f2e+ua6Z3r98jnehGRii8L26/dMyCYVXWeiRUYzDIqmR5+sZ
 re7sTCGevttTN46C36y9/RAeaZM9t3sI2ZFkguKhWhyWFLDZqbZ4hOI1sHN8mJIyTXsaz
 xcofHhXY40NToq8gSNIxzOHSyy9WoOrmb1de6gjIqYaZU17423aGoCsbMiUtrYwPQqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788973423;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:Received:Date:From:To:Subject:
 Message-ID:User-Agent;
 bh=KNC8xyEdRsiLy65sdub3JZYm4MuVxcOvJVrikqZtSfk=;
 b=nntl5LFeZBMBVH7UTgqptnX+u9D3LnvhjxV7tWhnOggNnRFkjUr+KYwE7DirNbfB3STc
 3iWrl8xwGP1XCflCSXdTENoSWffVwySF18hmETOb2eJk1QWlMi1f4IKyLz82hpORDTEzv
 GOm4ivxktji1QfrWWVh0K53NOvrOD1g02NXbkELxz5aDVszfj1LqK5gy4f8aISGIm/xsN
 0IghfnxhCVeASRQshziYCSKogPS6QqI5hNqC5JNiA+rYdZ9FVPnbSQQameRjr7ermunxj
 L6Uxmuxtg22bWINQ3PprsCcbWetACw3hwTmEFMtVCQcYWZiwnpkoioobmxW/yCbVUbg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GryYrVus; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GryYrVus
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49EA640055
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 17:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788973424; x=1820509424; h=date:from:to:subject:message-id;
 bh=RwW4OZfNz6xWpI5IlWTc8+owC79N5xM4Rz5VMpVqvW4=;
 b=GryYrVusTKRwzwecsMexRp1JCrEuE4MiuRgK0gPAqYRfohwnXvA/hcF8
 Ohrdu5Dh04CHvJjRIhVHIGxINVs/DGGZMC0mr5Ynfvp/yA2Y8zrhbj8p4
 /EzyA3vSof8gS7qxH9pRGe+cW/9wVG4Kawazs7z1J6D5BV4CHLoZOMkDE
 b8H4juN05KPt3a2FNqSoQa027oNaNE4oJQIicb2jePFcotcmk6IAzUBVu
 tBMnXqbKCiRHtupQmly8ySJXQmYkDoj7dzdm5PDfkEjpolbWyDKIsnXFz
 Ya9LWtcgrdY/tBR3B0WeICJFTFACll16DSDTU1wWjlC1Z+TT0QnBN7Hor g==;
X-CSE-ConnectionGUID: EpqUC8ILSU6BbOp/XDGdUg==
X-CSE-MsgGUID: WgexuvJTSAClsFoRpfNdSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100927785"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="100927785"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 10:02:17 -0700
X-CSE-ConnectionGUID: Eo7otc+HQwyun54FSc/t6Q==
X-CSE-MsgGUID: GrlLVAzjQRi67gv9wajSTg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO a3e91e2cf319) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2026 10:02:15 -0700
Received: from kbuild by a3e91e2cf319 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x4Lga-000000000ea-3yVj;
 Wed, 09 Sep 2026 17:02:12 +0000
Date: Thu, 10 Sep 2026 01:02:12 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:main] BUILD SUCCESS
 ab217fbb9b2169ce677b09a66558d5c3adcfbb76
Message-ID: <202609100108.8txea7Rs-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git main
branch HEAD: ab217fbb9b2169ce677b09a66558d5c3adcfbb76  Merge branch 'net-sysfs-use-ops-lock-for-speed-and-duplex'

elapsed time: 1644m

configs tested: 82
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arc          allyesconfig    gcc-16.1.0
arm           allnoconfig    clang-17
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm          allyesconfig    gcc-16.1.0
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    clang-24
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    clang-24
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-14
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-19
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    clang-20
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
m68k         allyesconfig    gcc-16.1.0
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    clang-24
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
openrisc     allmodconfig    gcc-16.1.0
openrisc      allnoconfig    clang-24
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    clang-17
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    clang-24
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-14
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    clang-20
xtensa       allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
