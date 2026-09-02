Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE3DC624D7
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 23:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94B1B607FF;
	Wed,  2 Sep 2026 23:06:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LlLnsWQDdVRf; Wed,  2 Sep 2026 23:06:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D44436079F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788390367;
	b=PpF8wwdQfw3rVjMXa+gRupIW/wznK/0tMqv/i0tSaGhX3h2ed2I9xQaD01vPKbFZ6WsR
	 e2ZA6xVB71mQyS5NYhf0IyO83O7ucJ+WDvLOKHYsx+Y9Qncu+hH5HLURX3pGGD2KBFanP
	 7HyPjZ4QGiyRRWfAJyz8U5bFAsJtuHkeVtwS29jaIqlw45PHhDztZFL8kxS6qHHQAXzit
	 pjElh7XXq5SkJWOjchQVanUBpajAFhRKdsxAhuACXoRNsSdxl5iOXB1gPdtdtAE3qthRO
	 PUdKlMhkxK7twigNKe9uui7yYKvvcBcx+Tu/iy6fTcO/MU20+e9tCvCsgWF3sh7+UuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788390367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=v+iQO6SnIjkpGOuGcfc59Pc1Gsagq9XOxuPLGxqbDCQ=;
	b=WLWjRS5oysiyIszk9jQqmaw43IViWTMGKytyIphWZPEppHGDqvPHYhA4leFHEfHyyRpI
	 jlwjRbHdqfQ5eJOH2gnCgrx8Xg4eAffbPXZTdLLHWYAUgPX/2lIH4+4dUtV6eWgDx3SW0
	 qBgbmtkxZ6GRCdA/Ivx2Ypf3ai8hZHtiEzWSt+dhdNB67Yq+e8XSVSjj0p2P16o4HqyYE
	 1+fR9lf8RaC4pmeooFNUIGMLnAE+DRxQhQ9LXIqm8pmDwr9DDoI9M8O93Hou4gB+9vgLo
	 7rivWiXbiDC3OA6vifDk5Vc4ivSM9w03GP1bHjp+AQEqct0Cay2A+sErZz3TzZOWoog==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788390367;
	bh=v+iQO6SnIjkpGOuGcfc59Pc1Gsagq9XOxuPLGxqbDCQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WEGpqdoPKO8yGQ74Z2Qpbnh/kQ72I5ZN0d4ScISeprK78+GtZqY6a2ZBEM87Wb8Ii
	 mm+j3Cu77y9ACSQZLiLedS9bBuZRmIMUFnbYapWrWVlB5US21P7JeRw2FQSJCinj7E
	 5yp8zl55e4f92M86+uty8XarrIDuG6VyO0wRWW85/jnmRCJ2z8TJrU+EAjZYj5gvaw
	 1vNO8GRVqgvyl1SondWv/up4ZUnL6WephHPq8U/wMS58lZcBHrAl8I0fqbPJ0Z1aVR
	 5PL1ve2dLe7YtSBsPRNbSrpvFtBZrV3kFG3btkglnbSIDx9RCj1TNzCTV1patl6t8O
	 RnJaFX9WW1NSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D44436079F;
	Wed,  2 Sep 2026 23:06:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1674C498
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 23:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06C9D81082
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 23:06:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iS2sCxRl4ITn for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 23:06:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1E1D281080
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788390365;
 b=CSwyAZPIAlN5fSWkQDUH5QgEc1NxbzKFe59jk7+osKWiXU/3Lydc/RiTyf9ms2kO52fO
 WHsJ9C0TEBXU6SPbf4ngAxnUfUBx0fNrVaZqbcH6pAG2mvwlq5E/LwnNhUEgRq7wDITdA
 Ua4Tpl8tLSNTIyXfFtPZaFeL97oQluVZWyQgQKS0yVGqg3lJw1+UUE0Ap4RrntgK1Z0n2
 VUyTUE+koXxpZcvsz8NzoSfWfitPJTalELWWPPw+5S+R2WkSHkcrNOS64as6hiU+KDjCb
 lFISGjvzsp2RpOd+kSM2Xyaz9y0NyLmFOsiZE3xwcfAGgzCMVRCyoFQxP0kZMwNY2ZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788390365;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=v+iQO6SnIjkpGOuGcfc59Pc1Gsagq9XOxuPLGxqbDCQ=;
 b=fipCcBCw7wI0Y+sUTX0FI+M5szfp/Gi5vjKgqHmcRz3/KMm2odCKJhbIEqr7JjY+eVfo
 FmFaHUWQU1M+Q7Lqb0t4o1OlkfA9IR5Li4sFhnofx8iypZDrJHWtcrtckYY8ScNXj32fG
 ysn5wG8fRQ2oFUlLHXzwBbGRQC0RvVoa67nbCBRE+ILe7Zn6MBhUvyrcn9Xi+KTgchReC
 3cUMeieA0cDs9iuyPBxssnTvFhSbsUWTLZ2Nb0c/ZNN2LsZZpI4RCLPOWuK2bRFZ2Eq4e
 uhu3gs+6K/bOBtdFlnGxVQh1wj8y+VsUy0wEUhXF8XdQ/ZNV7O3KlwfdUqCAsq1FhfA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AtXaXmYy; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AtXaXmYy
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E1D281080
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 23:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788390365; x=1819926365; h=date:from:to:subject:message-id;
 bh=v7JRwqULjtorBQudYIS0TvWJRyJSu9NsCSdGNhM+DJU=;
 b=AtXaXmYylaPvQseDyKbcuyPh6nntINSiRruud0YX7ie1j4Fs+WwOeR81
 yBtGAdwzT3ExP9nsUFNwJ1r0aJDNnxSlokxeKZj15zL34mSLXBZwlDGvj
 d5U4aeXcwxnYwVZi2K8FMT5qTyuICE/FS9IMRq9Q7PYRAqRcYjuto1ncR
 LbwRti1dF8LX7qrCq+8+seMLPIH2raXkT9gJEqyGxkCnRzXd/pFAaJcdH
 DXV7Mu4ymUNxrfZ0ZvS9bvyc+eSUTRksBq+30ysS9uQxdzGqZXh8LGcvM
 Ov1I3/JaVJNsZoq6CMdCvT9aFUVy6yi8wTezeQoSIb4vaqNBD75m0TXth w==;
X-CSE-ConnectionGUID: teYow6I8R8OzTgIE1G+WAQ==
X-CSE-MsgGUID: I4cVFa7TSMKLbgu84yThCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88981965"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="88981965"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 16:06:04 -0700
X-CSE-ConnectionGUID: 3mHcQI2CRBiJabYOVeGTMg==
X-CSE-MsgGUID: iNW/W9NURia0bUxufx6yFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="266950795"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 02 Sep 2026 16:06:02 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x1u1o-000000003Qm-1X1L;
 Wed, 02 Sep 2026 23:06:00 +0000
Date: Thu, 03 Sep 2026 07:05:16 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 6af500682f0ec1bf4cec4ac9ddc2c07e6ee204e4
Message-ID: <202609030713.eUqzIogx-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 6af500682f0ec1bf4cec4ac9ddc2c07e6ee204e4  iavf: add missing PTP adjustment callbacks

elapsed time: 1329m

configs tested: 71
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
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
