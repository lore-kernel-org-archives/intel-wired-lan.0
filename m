Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BF3C79FB6
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Sep 2026 17:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A94E040742;
	Wed,  9 Sep 2026 17:25:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VAcyiU1lQWCk; Wed,  9 Sep 2026 17:25:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D474640786
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788974722;
	b=P78mx35kUcoCfSAAnOT2xXbmz7xkO8L/7+gnCcSqOiY4nM6cycHeuCzyKmpOz3/yvkGf
	 kSI03l6z0MCHZ4WGEf6LM9HE8L7NwknbSrNjO4l1++BqmlSeG5OIg/BUSxajwaEt87Ut+
	 vYQoDsOFB70xEYkMuS+ctxFAYKmY4XH8hao3n/RF3amrihSMTXm8YBN69oUdQf2HN6GYa
	 l2ZRRrBoQFU+5PnzCsExt4oC0CgoNR/kjXQzjytdTuUvwi9ixSWGHVgALki5+vSOpkq5d
	 G2p9izfoIeSPEnrpSITkqHb8ZZWXMCNJ8mvFa2gns9IqpDNabiZl2qUX8DW5Veicueg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788974722;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Lki0JwS5aAXuGTnAMhDABel+6xiKQczqKllK6pDiTrQ=;
	b=OgaZ0johFHwIESoY9fHuvScL5Pw4eBG+7BpVmdDup5jxu4fV+CibOr+dibKlbtVkZCAC
	 smSRAdMRdwQe2hfzNUze4unTrd0LiNJv9TxCZsMfKYerMi8AE4+er0p1oGguVOkUn5Zja
	 FrhZcDKNFeBYUVeXnXjYZkP2NeYDqCZDvCkPeKXxMhoo6p0M4Tilq7jykwCOoMpM7i4Ju
	 8G7Uy76bWWAbFUW5RJZs6k8yj/SC8l5QxXvw5z1Se1u0PTRc5d/YTIueXhzOQjkRLRV1C
	 HLPXOCzsIZHd8n8UQC7hrLLYriPNF41YbGRE9IzRItspVRJIQaMA0DXes6qOql+ckVQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I0H0nJ1l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788974722;
	bh=Lki0JwS5aAXuGTnAMhDABel+6xiKQczqKllK6pDiTrQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0a2NGHveOjoJiN0L0evxULAbRWGYz1SYAJ7NuWB4o62cDKUoioNoRB0j55H6Or8/1
	 1svVYcuYrMOzIApXRxdF7wrDrTvipyxayOSVhMmMLlAgMOkuMUHLihdzlG5MdHn0z+
	 DMOryOGz1LwDyz0RVpw9XH+ZmCguC0T01Wv6wpf3sIGHvGTjK3G2y+a21Bcj4KvUI0
	 F76s+Rqd7BCLyT7KiuS2Yy/MVdpYZXuAPW9HEIPVoIoR/Sf/GZEwp0YhF6IqMpwvqH
	 wnWEaG5pgF1I3VtSPzqY9mrsKJHinziFc+R9s5EpATPh9TZQhFqvTCZswW2bHwMCiB
	 4QoQNYHTqECYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D474640786;
	Wed,  9 Sep 2026 17:25:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 099BE268
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 17:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF96B40786
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 17:25:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ybefA1KdjpY for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Sep 2026 17:25:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F077D40742
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788974720;
 b=i+DVHumEA4/IkYLXFj4x8GPexqGkXCAtkpVagmLyemgOwZqTCpRA0XNA3kaIWtCvnRiI
 8l4w0cI0pgmZ3lj5iCNy6val7PLePrKUzUhHlIlaW+i4i8o3QLk5JIAn8FgM/0hl4Pcb4
 Jcr+gWOGUq7XoR/v2d1fsX72M4H+wFykDbVhli/BubPwdg4T2vCsNjPcH1o7wp8fSS71M
 7n/lshvBplJcO6fhPTsWbGzfFgWw5zW5MIn9EV7VgPruhx+H5qefYrQNEcfid6sxrIj5m
 V/IcEqiSqzwLGOrTL0pGyTZKqW3G99TFV+khVaGGcPAcktXoVTDYjA31gL9EaKEytog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788974720;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=Lki0JwS5aAXuGTnAMhDABel+6xiKQczqKllK6pDiTrQ=;
 b=sfRkG3soEwVUCxcd4E2uoF1XU27FyUWpCBWs7KoJFkMt3jKbN2t1/WBfy7R/xNpgMnBB
 cBwrWm51SaSV+fBMC/DjL8Bf38uL6RLzeQn4Qz0yR6eqIX3ajddMlNZFJJ5MoNNPqMEMI
 L+ywBSBDOgDVTGIVi3jXu1l4iEosOQtg2SHHKaUfhXckYdgKQyg/vzHER3Mdw2nWhwhaW
 lyyrRRCmiZxRrhWcAjyhvKygzKn6ntBBiQh+D8BNtEQrCtx9VKXDnGfRZedL788WZEdBK
 rUqblm8zUaXQK87DgAP9kDvLGL0q2dk7Pea9cI9KsWZ6ltNFRW9l+w1ulLimr1m0vXw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=I0H0nJ1l; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=I0H0nJ1l
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F077D40742
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788974719; x=1820510719; h=date:from:to:subject:message-id;
 bh=fsLu1aZYlhBlk2rI8vImeZUYtuEHRmfDMn8fLAw36No=;
 b=I0H0nJ1lwjKsxkc5PD1M7NmPMcpfPFBJqorRfujWtWUkCkUZxeO5nWwV
 Opv84XtAn5NBtUJ7xZJ+Wog0Rz/PVT6I2rAQF8a////htphEwcIywqbJ5
 S1zX+FrnDucIZ+qpePme4+jKa5SCSbogAfLp6NISK5jUoWKQEazkfgdBa
 fI0dQ7DHvoNERebcw0nWEqK1rMZGNBtGuq3/eTd3eCLYVqfCu/wxh2218
 leQYEoB9QRWCLesHCSj9tjdLwjeAMnZjkCveZrd7xpH4bXATRL1AwUrl+
 xXM3BgD0JFIEQZStqZLUCY6QL1OSFhfH68Ic1yblKY447kueUtPv/c560 A==;
X-CSE-ConnectionGUID: zrCOqecLRy2RCrW8ygA0dw==
X-CSE-MsgGUID: RIDJ5ww7TZyVBVIo6YOGaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100007081"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="100007081"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 10:25:18 -0700
X-CSE-ConnectionGUID: KQCW3e0oQueip0vvUxForg==
X-CSE-MsgGUID: RhMM+tFrTgaoqrkCIDWEfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="267701271"
Received: from lkp-server01.sh.intel.com (HELO a3e91e2cf319) ([10.239.97.150])
 by fmviesa010.fm.intel.com with ESMTP; 09 Sep 2026 10:25:18 -0700
Received: from kbuild by a3e91e2cf319 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x4M2t-000000000i4-2pL6;
 Wed, 09 Sep 2026 17:25:15 +0000
Date: Thu, 10 Sep 2026 01:24:49 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:100GbE] BUILD SUCCESS
 05cfe2afb5ef78dd936bb06f753e7993d8e837b6
Message-ID: <202609100146.7If3yHy1-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 05cfe2afb5ef78dd936bb06f753e7993d8e837b6  ice: Recalibrate PHY after settime64 on E825-C

elapsed time: 1050m

configs tested: 55
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
nios2         allnoconfig    clang-24
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc       allyesconfig    clang-17
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh           allyesconfig    clang-17
sparc         allnoconfig    clang-24
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
