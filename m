Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7B7C79FB6
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Sep 2026 23:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 953D740A06;
	Wed,  9 Sep 2026 23:08:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jI7TEsNeOPMG; Wed,  9 Sep 2026 23:08:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D739A40A29
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788995322;
	b=LJAtGUQFGTzucPnLf51eNmxL1VFOjWEtuAOsLtoZWj+lPOMxDl4QXLUrTGFvO9HjsBdl
	 hg2s4lTemNURQwv7P/6edoF2PtOFQNyzkPBzun80En/dYsx2/i6LpNyv0l0oks1ltJasZ
	 1REMe27lZ4LD7Xuwkm/Of9jY+hasBO4TjS+pBSKsrZCGPeGADQhasnrqzXYKoXK3eBeyW
	 t/Pf0NXvFzBJD+gQ/aR/m7FzGR5J1nqXEupC5kIb2w8hsZ7ADMwPQRt0ZWkpe207KZ1jv
	 vkGFkn24YatO3jqoW1TIjctK6+HMtqNuCExw4WaTL71yMEbasOowgVfORPp3dnVTpxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788995322;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CucV1oa7JQUmQOYUUmxHlutO5zGJN7TFjCOtiePOdaY=;
	b=S9UKlM5un9TbtpwA3B9hWjIeURJZqZeGbmCVjgGpL9lM4wBcUtZbHg7z1hcX+yWGztjS
	 RX7LKXLo3i5tVtiMLaNY+zGVD/xe8taw0mv8LCY2O5SgUg0BSskKgT1vBoJ8bn/fTYxRy
	 CEnvews3w5BLtcgNEdD9KsQCDNqH5iwIvKr1HmZdS7slc3tsBnhJWf9yhYJeaVPI6tl96
	 k3okyjXjUTDdiT5LrVA/get1IwjruQ4MG+vgX4aSIlWDwpIE96KoY7JTsmb96QxNcKzXW
	 TOMs+KDA8aX8KJngR5v0urhqyLduc5I5BWI1vpwdmynzVlMsOPnfsrf7Y7T9zKQGZoQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="it/+GdFH";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788995322;
	bh=CucV1oa7JQUmQOYUUmxHlutO5zGJN7TFjCOtiePOdaY=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C8YPsTi39b7XOtCrZed4uGPF5Cm6ZdfhllIdrrPedLGYgnwplz2Xgvej92uH5kHnR
	 cRsCdl5tegrhD2oD8y7Ym40Cmf5VgQ+yJhP/KNtkgrmoqmRiKftWatUtZM51AUD7A3
	 QYAKG7oaTKETsuJIfQ5V2N16SUVprHvqdRbFrTBhcGfqjUemaxPzvWoK18ySpD/LOw
	 XU2G3e/MRXQtgERae/+wCFl8hOQWPLkp1Ebx/L1RHGznvT3uwBJ6xa07ILa6KzMzp+
	 bZbcM7bN39Zusu6yi9gvyVSdxTf49bGSg+Xp0YE8hbnqbTCMRWiJQ+tWzwDNeQ4ez8
	 JSl9KXdjytHZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D739A40A29;
	Wed,  9 Sep 2026 23:08:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E9D473AF
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 23:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C414E40A29
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 23:08:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BtQPtGJzsGV0 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Sep 2026 23:08:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 66A1640795
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788995321;
 b=nKwnIAbfrpwuflF079q8M/5+/lF56AZ4zyjPxTQZw7tf0ItVGZk50TOlDVupUNhHXb5L
 YlRWf+iVXeOUBi8Cw6VeNXMulWgq0Dk4U6CAAj//yi4Q3ySzgZV4Kri/ZtDzTgLSgMpQm
 bbS7YaocMNHCDJG3cLJKGHq6L0GaUyUjc/HEbd7fKIXI7fY6YT0MxlM1DE8NfmT8hgYLd
 fPT+DcCfTqKieWxgwr4C1vLukYXQcDJrmsUgOZ0XNtHNRdjEmEvlyIzgkajND3DhrbjoR
 GDTNjLDR+QXa3VyC5gRjpPTqvD6sU0QRgaCxnTmEDvzG+wn+OxH4dqBW1bxxBrNybBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788995321;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=CucV1oa7JQUmQOYUUmxHlutO5zGJN7TFjCOtiePOdaY=;
 b=b6B5pE8D8HLUCtQVqzrScAgqOXdsRj1Qg1jUBHbFCRhyiE6LhX/vNZJB7bd7EM7yg89k
 wg9F+fSpeF10gLQ0yu+7AKlcN+FQWN23jwQOfFB3HZYnBIpzmXa/TIirfA/5fzAYGuvq9
 i5/hNC0Zk88gspDriHq3HsWCfHMqTydnqltQsfEU1nLndZEcrtuCayAqZUifcXpidIMG2
 CgDGszzHeu4o8WfxmOV3+afymNoyk1qA7YRxF6JjunNcyaBXjAvI1vt0GEow0YwcBVahj
 Oj0tRNr6INyUcrp5471j/fwZPv+ffi5BVSf4M12XrJoOjqONldizHqc+VBnodiWlChw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="it/+GdFH"; 
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=it/+GdFH
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66A1640795
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 23:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788995320; x=1820531320; h=date:from:to:subject:message-id;
 bh=tVDcFfIpBxDuWC0Hd3MiCn0mhr5atZ/Lzkqans1Xz68=;
 b=it/+GdFHEDfmmhOpOBT1eWNc2ZyW9VeqQqwUQtxPqF+5hG5rzI8fO1hC
 fz1WPaqIyUzKUaQ6KIRNydOZDgazsof+X55U//x/1U7m4rGdzODIrKLq2
 mGjER1YR4S/rjb9DGc/WiO/C3uScUL2yL37Qt3r/gUxAs+excMYHPmk0e
 4TM01CIqLM+aZ0H6IGYzMHOBRfaed95J/nrFSHjA1h0qsexf6m+ormMzf
 XXWsB5b1V0V8qM0U2iyAHi97gpKcMd07YTkve/oi5B3Dxf1izp/thb4rW
 FF4ZgGuiymGBuhDfSKFW8g+1YIIR/4ADzpRhcpDU5FWMxVUqFPolQrWm9 g==;
X-CSE-ConnectionGUID: Xcs4QrDqSdqNktx5qFuzLw==
X-CSE-MsgGUID: JpJMmK8tQOa5obfu/xIvfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100793159"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="100793159"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 16:08:37 -0700
X-CSE-ConnectionGUID: 62+4pgB4TQWqwG0tcYHhmQ==
X-CSE-MsgGUID: 4O26YmezSFKLnOIo2eZz2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="276696626"
Received: from lkp-server01.sh.intel.com (HELO a3e91e2cf319) ([10.239.97.150])
 by fmviesa005.fm.intel.com with ESMTP; 09 Sep 2026 16:08:36 -0700
Received: from kbuild by a3e91e2cf319 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x4RP8-0000000012o-1shp;
 Wed, 09 Sep 2026 23:08:34 +0000
Date: Thu, 10 Sep 2026 07:08:29 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:100GbE] BUILD SUCCESS
 97bd063c08a27d0cc5c9367cca5590725c970fa6
Message-ID: <202609100726.TvylydXo-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: 97bd063c08a27d0cc5c9367cca5590725c970fa6  ice: use per-interface clock_id for E825 generic DPLLs

elapsed time: 1494m

configs tested: 50
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allnoconfig    gcc-16.1.0
alpha       allyesconfig    gcc-16.1.0
arc         allmodconfig    gcc-16.1.0
arc          allnoconfig    gcc-16.1.0
arc         allyesconfig    gcc-16.1.0
arm          allnoconfig    clang-17
arm         allyesconfig    gcc-16.1.0
arm64       allmodconfig    clang-24
arm64        allnoconfig    gcc-16.1.0
csky        allmodconfig    gcc-16.1.0
csky         allnoconfig    gcc-16.1.0
hexagon     allmodconfig    clang-24
hexagon      allnoconfig    clang-24
i386         allnoconfig    gcc-14
loongarch   allmodconfig    clang-19
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
riscv       allmodconfig    clang-24
riscv        allnoconfig    gcc-16.1.0
riscv       allyesconfig    clang-24
s390        allmodconfig    clang-24
s390         allnoconfig    clang-24
s390        allyesconfig    gcc-16.1.0
sh          allmodconfig    gcc-16.1.0
sh           allnoconfig    gcc-16.1.0
sh          allyesconfig    gcc-16.1.0
sparc        allnoconfig    gcc-16.1.0
sparc64     allmodconfig    clang-20
um          allmodconfig    clang-17
um           allnoconfig    clang-17
um          allyesconfig    gcc-14
x86_64       allnoconfig    clang-22
xtensa       allnoconfig    gcc-16.1.0
xtensa      allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
