Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9FD606A324
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 01:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=S1VPzsB7;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FGT4PF3q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F36840564;
	Tue,  3 Nov 2026 01:19:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id icF4f9qBRgC6; Tue,  3 Nov 2026 01:19:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4E41D40586
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793668782;
	b=teADR1hxNwbqqsATrVoKwtFp1eIndFUtwYxlYt4/lcPyX58DPUdw8yJmZwS/zsYbsYHe
	 Q2iw8ObAvVVp9kOMwu/1X2ZjJQoaV2Sf/EjMDYeF9xNPywm1LACZWOHhvf3KDTT/DKWoV
	 9Zrp+houO9AhHqLhWxQxwZpZ7Euvyd4RRC5N4QUBSlvtXPcFDswAH3hsJdipsqaTOSRFw
	 CxRoey5LL57Kj/GBm0VzDdlebmc8JVIaRWKOx0DSDx5/tr4yYJHMy60FQU//EAQ3xE1AH
	 1uJ3tSyKfIMrB5qoHtxardD+sJXZNgR0ob3Og4eOpHrigIVltGBR59oRXxkw7Id6adQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793668782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cIsBlDMv9q1afbMj11ERnkjQ8A9v25NnkphIk761Yys=;
	b=X0g7ZcjymIHh1k/MGJf236L1QpKvgXIn8oyaPznCngbJkgVXLYCWx3NZK8pfaMBbZE+7
	 FHGiK5ydLw3PXVSOdLjIwRhAvkI58a6tlkZDTa37Y9oP+3D5XDvMjLy0a9R3zspMY3sia
	 z710tHCFknSpsEwLTWoc+gUY9bhw7acbfvZV/ZcHqsr2x54Dc21Sa1Xwjk09GbYhNhDTO
	 CGTxQ0QM3QYfw7WvRuNm2iXpQ9Eutk62TwwgrES/PnIrsA5LFDmkZrb/GjnFES4+fkTMy
	 4VzQBxhzj+NZ/e6CZnMsr33qEPplLrOzqT+ZAeBuRYxPDkj5kwyTsSqiN9bXzKaBeMw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FGT4PF3q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793668782;
	bh=cIsBlDMv9q1afbMj11ERnkjQ8A9v25NnkphIk761Yys=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S1VPzsB7A6NSZ/C4itdgPplBTq3ClPAXazmVHbWmZqXpqxCoqYXYwlgV5VkYZXiep
	 zurpl7DxHfr2lRNi/ybBHFkqakMY08VjP6OGF8cUaSJw/8Aw06gjfqRYJYIY/G9+DP
	 3Xh3AGbZbLR4+ZMF10asU/UnEOK9XZvlMh3JI6fBJLLeglY0qgVf4kRLQWubruEgeW
	 lTq+dbU2qYC8clbV4Q7SqlpNB8Vao8sBp1K7M46p3HBT3KOEExjUw9vyG1mRGiKLDq
	 41cbDOWOXcfHK2bZ676Ul1o9JQM2Oi8G9YRx6hf3WRBk0hTnbUqRrv43YNI/+v9sB0
	 o0e/IYE1BQCWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E41D40586;
	Tue,  3 Nov 2026 01:19:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F1413356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 01:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DAE1940586
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 01:19:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mWhOhMgDUIsJ for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 01:19:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC67B40564
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793668780;
 b=X6cz6NYBKnzFFrU/7+C9+VMPwYXlUl93ezPE/K5oNiRF/KLocAbecZZfTKh44Bpst20T
 vnW32BCFiUQg8Mz/PxOCQhjGJa3127FX+xjzB/bpkBiDDqtcp9rwRgvSlBSzaClg+ToVl
 9fvlh9+r4FmFbmrLnIcmBGcPlPnw3UItprrqTW0hPY+aeEJq/buZaAneL06kcAS2WaCR5
 ZARBqszcywqT8Drw5FuuJhGrKcICFe5+xicdPR2ckbF+tSsR2hBQw+i5IN/3ZPqO2n2f8
 yQSs26lVu0/5uQuDOZ+1C3jWT47kFVToSBRw+WruAoPqCgjLBQnm0qkoXb95pyd9P5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793668780;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=cIsBlDMv9q1afbMj11ERnkjQ8A9v25NnkphIk761Yys=;
 b=rvJk++lTercGxwfAWruv2d9KpI9Ui2WyV/4hBWy1dIx9kyMYxPfx6MACfzu7/GBYM+57
 0rmWzaibfLjRsE5WJ+b5BhP+M+gIvsCkAdi4jLeB+LTXGUXfK0fgiV2tym2bZkeztlL8D
 Ey+8gVexAQYmZ6U7pI4nvUOlx12IcrLI4U7dNrV9IRbEM6woz4q3uqEjcfbk01TZ4oWcQ
 KrBOAUNk6Oqv4++DkWZCoeiNvnzEojUl7NZpMCSnYseAwsdhmdhoZwlK0kujzidJrquW7
 FHiQEo7YITLF5Iz7RGpi5W29McB4/2Z7cgdWIVxt+G0zLHzujeDLBb+SlOE4dA8ukAA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FGT4PF3q; 
 arc=none smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FGT4PF3q
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC67B40564
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 01:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793668779; x=1825204779; h=date:from:to:subject:message-id;
 bh=R/ft77z1GbemuS2jvEOYIzDnV4h1Wk4E/vHHjuDQUqc=;
 b=FGT4PF3qTh+UefFS+o4qQdjw1ZMzh0l94zabDLY7dK9i0414QKCdFHGw
 3nkiAevT37jlJaLdcMwiEuB+pMbM7o9gurn3OYwGqepazm6vmHcISUIcL
 n2QKQyJBU+Cw4igi7H4J5f2ralyTjaZ/kAgOGxAWwxe9REfLvOyl5hFJV
 vTAv4cfYf3xoEVivvaYtU0Sq3dDTE+JNM6cKs2sgFTEkklN8Fc5MGs6TZ
 P67HzYfIQKszUuXYgyk8b7a37Fhse52MrLvqunHwBkZu/Y4opzSrtN0mZ
 1DlffqMXW+3RRlKlew42kXcR7i286MpjmmhWcRpH/CAc+PIOLA/pqAZcU Q==;
X-CSE-ConnectionGUID: mbjo8NVfQfC2OasJ/GcyMQ==
X-CSE-MsgGUID: RR4l5g6+SWSN+1mmczFXsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2409937"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2409937"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 17:19:38 -0800
X-CSE-ConnectionGUID: KdR6WvO8RJaGq3wjK9ASCg==
X-CSE-MsgGUID: /boLRpMvQWGn9YwiCDsPHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6130259"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa008.jf.intel.com with ESMTP; 02 Nov 2026 17:19:37 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xO3BW-00000000i8a-15cI;
 Tue, 03 Nov 2026 01:19:34 +0000
Date: Tue, 03 Nov 2026 09:18:48 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:100GbE] BUILD SUCCESS
 3c73d34ba643c4e24ff549f3f083372a36b09952
Message-ID: <20261103091848.TpZTo1oI-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 3c73d34ba643c4e24ff549f3f083372a36b09952  ice: don't clear in_use until HW clears ready bitmap

elapsed time: 5722m

configs tested: 44
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                    allnoconfig    gcc-16.2.0
alpha                   allyesconfig    gcc-16.2.0
arc                      allnoconfig    gcc-16.2.0
arm                      allnoconfig    clang-17
arm64                    allnoconfig    gcc-16.2.0
csky                    allmodconfig    gcc-16.2.0
csky                     allnoconfig    gcc-16.2.0
hexagon                 allmodconfig    clang-24
hexagon                  allnoconfig    clang-24
i386                     allnoconfig    gcc-14
i386        randconfig-1007-20261103    clang-22
i386        randconfig-1008-20261103    clang-22
i386        randconfig-1009-20261103    clang-22
i386        randconfig-1010-20261103    gcc-14
i386        randconfig-1011-20261103    clang-22
i386        randconfig-1012-20261103    clang-22
i386        randconfig-1013-20261103    clang-22
loongarch                allnoconfig    clang-20
m68k                    allmodconfig    gcc-16.2.0
m68k                     allnoconfig    gcc-16.2.0
microblaze               allnoconfig    gcc-16.2.0
microblaze              allyesconfig    gcc-16.2.0
mips                     allnoconfig    gcc-16.2.0
mips                    allyesconfig    gcc-16.2.0
nios2                    allnoconfig    gcc-11.5.0
openrisc                 allnoconfig    gcc-16.2.0
parisc                   allnoconfig    gcc-16.2.0
parisc                  allyesconfig    gcc-16.2.0
powerpc                  allnoconfig    gcc-16.2.0
riscv                    allnoconfig    gcc-16.2.0
s390                     allnoconfig    clang-24
sh                      allmodconfig    gcc-16.2.0
sh                       allnoconfig    gcc-16.2.0
sh                      allyesconfig    gcc-16.2.0
sparc                    allnoconfig    gcc-16.2.0
um                       allnoconfig    clang-17
um                      allyesconfig    gcc-14
x86_64                   allnoconfig    clang-22
x86_64      randconfig-1007-20261103    gcc-14
x86_64      randconfig-1008-20261103    gcc-14
x86_64      randconfig-1009-20261103    gcc-14
x86_64      randconfig-1010-20261103    gcc-14
x86_64      randconfig-1011-20261103    gcc-13
xtensa                   allnoconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
