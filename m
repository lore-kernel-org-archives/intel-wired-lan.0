Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5115CC79FB6
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Sep 2026 17:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDD46407AE;
	Wed,  9 Sep 2026 17:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aTOMYWKXOOks; Wed,  9 Sep 2026 17:03:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 19124407B7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788973403;
	b=rbx1BZOSGl2OdLyuahICVTNaZu0ZqSe3bzn3vGsKjbNEd1A6YqJMBwahhIFMtaz36ERX
	 0WWbKz3bBdcvmrhjakp5pujqhveKz0+HDQY0mbR5ihgtveJVoUYv4TWgttwiwxVUo2rdY
	 u5dA/NfEZK+h5ckXqZlLpm80MLK1f/RR0i+0ewCDN98y81D+aek8xuZBpj357P5MymJ03
	 D5uCxTHmwpwZeLs55Szh5zKBTeYi/susZtd5uqrFf1ajmsEmO2XVypzDzagJwV+HXpeyM
	 Cha3mvn2eZdNxSdNV2Yc0UpzLkwyICmx5Af7yByaWykbwZ69E03sjyGB4L2TSlz7N+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788973403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SFMW+hGbjftiNbB+cdEKee56PfokfoqY5Ep8Kpabo4I=;
	b=JWwMrt379z5PEDJqELk+3RLSo4RG3TiXHwbQVSnUIU44TpM5Mc3c380eLIhE84ymv25V
	 v+inAopDYOXAi3/R9cleSHQA3buM6rXUjWoEC+QBNB55u1whGnqLNugpSVMqTRajzf3MN
	 JiDdmYQuDv/mf6HyeFt0vwXcIYbh1VUjCI/pLuTTL7zbSmevr5mJE+FQJgPrX8BoQ8Sfj
	 N0YBjHvC/TpwyW4ZdMjI7qT/FgYE65wgAr9rgGlUhW1+ImT9Eq5ojGW/I2m2O4oLdordD
	 VxAuNs610887IxcGAOjE2lotESnTpnlErkB94BErPyqcxmqBxcJTDF8Jn18+j9VwAiw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gBQasniH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788973403;
	bh=SFMW+hGbjftiNbB+cdEKee56PfokfoqY5Ep8Kpabo4I=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DeyK3xm78Vj4zpH/DPkXLGe6X8cscEnDbJrhx7SUxFAgAEL9wNXfh39RgwGNQzGZm
	 e5MXH/bqZNz+3NSDQp5W2giLqyFqltIcQcaHsofr87Cc/n7Cq/NbZy8Q9mrMRiG7VZ
	 4VU9k/SMxyubA22hdiN4IVePjc3OwERWsBCz5NIAjtLCLBIJ+9zucNsLS69ahwaU6W
	 QtbS/XIH7zpV4EAD0hG3rUq8AWDXbezCJ19E8QRjy31DJCNBofIJeCVHX/4ASFVRwX
	 cRlZqFs2ZRhFlqi/g6HtB/A3WBRIDF6vJl90tBQEd2AYvHOgzoQofK510ATh0hicGs
	 tBB8RtxXOys5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19124407B7;
	Wed,  9 Sep 2026 17:03:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8552C268
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 17:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77246407B7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 17:03:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kybvQuY4JC8X for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Sep 2026 17:03:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 509C9407AE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788973398;
 b=WOVTO44uZnl0reezlMBw3ihUJxY8zFlrQMHSvoeok94zfcy0KB9aB3kYV0ALnMDDNBV+
 MJw123FHvotgg3kL9OP3juPrkAYC6D6t7LFVGOWPOj8cjaVcy7/iAZA29+yEqbaeOhrTw
 39wt4gb6oibtfk5L4z9uxOIbkd6tqY6sgrWp6rcrYExMlfs2ZQHXyJMXa3ePMMFYybCIv
 cmlj0Z5RuaXDbzoakCEyaKCHTNDDLfvASsSkN+cFJ1bLTOxwPQvqRpOLnlqT4SAAzJI82
 XQ1uw8Lwf3iHYXLf1YL3NE5LNcZcIqPQU8f9R3O94eGW3VV3WgEgkZuRs9jJOvwbRQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788973398;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=SFMW+hGbjftiNbB+cdEKee56PfokfoqY5Ep8Kpabo4I=;
 b=jE/scf0R07Omnle3h6YPp5nSypOAYPmlJdFSVoJE8t8WxGT1eW0yAFllYkzzB/FMdI5h
 xLqpX4ibl7+9KieVjhFYXYUvV41TtNBBY6zZMXYnspBBNKhtCVQy0GaGThen1yb1dR8T1
 ahHZ7lpvbw5jEsk49gaDzfBPosOHZYj4/V07GPMkFQ1yoPT9sjSgA/3TD4dYpWEaSrpuf
 gJJNXdwEYNibB2H8gAzjCIyqAr243/VUH/FOcNiCmRhlPeGqhClroG+o2NpsYg7nEIm8B
 8CZcpSSqXZCHGSBBN17s6LLBWaIileSpJx0dj+fJXvm9OXvXqcVvL3Gye3VSzAHxuCg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gBQasniH; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gBQasniH
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 509C9407AE
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788973399; x=1820509399; h=date:from:to:subject:message-id;
 bh=6trR1iJiaaLcihK66wt9ovY9DV20RYsMWUgaAjgNEs0=;
 b=gBQasniHhorerhLdhlnIZ6oKDgRhdwQSuHIBHETyZcUgnquVPFaHn7ZV
 rtp107a1Nn3LPUykZtzMVlPSgUWk5wLBL4ARI36t1lZTpR3kIOsVEG5mu
 GHD/HmDHIutXjek2yWFG6tSirmTypBghSnsZgYFzn24AM3JKd+jJZM5Au
 Pbi/2xhpjLpAMDeejHUyYz9eowrJZ0Q5qAfMc68CGvm1nQlVVZI5fUaFY
 ukSKbXVnKXYGOKSxArzu5ZMhdic/wghtj30eyob3k9kepvhT2yROajbcV
 r6+3yjzhoV/bn5qDIp7AXXHPI5+dG5mnuewbwQgaudl228KOK7IPlB2tf g==;
X-CSE-ConnectionGUID: 0t92XRSARF6ioz1dVfXdqg==
X-CSE-MsgGUID: t8Xt2WqXRRa5Vd06jjxctw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93275180"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="93275180"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 10:03:17 -0700
X-CSE-ConnectionGUID: VyBXFoopTVy+Z7jyzlFkLQ==
X-CSE-MsgGUID: D59jsXH9QRKcIHqTAAydhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="267085191"
Received: from lkp-server01.sh.intel.com (HELO a3e91e2cf319) ([10.239.97.150])
 by fmviesa006.fm.intel.com with ESMTP; 09 Sep 2026 10:03:15 -0700
Received: from kbuild by a3e91e2cf319 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x4LhZ-000000000f3-1UYX;
 Wed, 09 Sep 2026 17:03:13 +0000
Date: Thu, 10 Sep 2026 01:02:34 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:main] BUILD SUCCESS
 e0554c6276da957b6e72849520c70a97404cd1ae
Message-ID: <202609100130.tWrJOfb7-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git main
branch HEAD: e0554c6276da957b6e72849520c70a97404cd1ae  Merge branch 'net-ethernet-cortina-fix-rx-budget-accounting'

elapsed time: 1798m

configs tested: 84
configs skipped: 5

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
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
i386         allyesconfig    gcc-14
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
