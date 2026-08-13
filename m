Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BE4C5B572
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Aug 2026 19:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A3B940CA1;
	Thu, 13 Aug 2026 19:15:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wW7lorylQpgd; Thu, 13 Aug 2026 19:15:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4409640CA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786648510;
	bh=VxS6hVC9vbnRYzImpWkv9G6sWKn6XZApCo+YR5WVzeM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=V8b6GFpzwrmcXU5yxQUE6tfWyrTLMIn9Ixbz/2wCNHqDMNxAK6LfbVfzSEh/2T6E3
	 6Wzr6fail8KHw0gv2768aSVSk8i69oZRV6YEzrugmXrNuVUkqy9lqRVo1a778kmNlm
	 KdlduyPozocRmpgUH7Ely0VHg3yFcV3jVGzs1ji5iGTt1ZMkIlRgFSw7QOsOdUebnO
	 lvgso/Fiq/Vn2qPLGEp0uy9L0KRe3xB255nUOa4qvTmHaeLrEDNiri1C4ZaWucuUcY
	 h8IJYlQfPAUCJtwYhypHxdNdnO9TCja98OAFkWm+dWwIRy02Xya82y1Jmw78eaXmb+
	 gWzI9McjdR3aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4409640CA6;
	Thu, 13 Aug 2026 19:15:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9556A3DF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8716A8136A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gvt453q4bZUo for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Aug 2026 19:15:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BA50181379
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA50181379
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DufUuaTD
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA50181379
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786648508; x=1818184508; h=date:from:to:subject:message-id;
 bh=TtjhvBeSr2BPAnZSImPidL5Y0Sp/NYrKajkf0mI0nac=;
 b=DufUuaTDslxHzlwhTaUxBZVwQIWXGNEbY3RJ156GLPzgyCPoMfb+uOn8
 IvgKspRGkW6MaPQJyE8mLJQu+YYitOj2ix3fjiITYjAnrkEXqjJUFHh69
 +/UP7xcXSNlywrtf/S9eeYDKBLxDAnSYXRJz4upVFokleV8kxQ/+BqY7M
 qMa92K+GWZj9P4Tx7yLF6OiF9ZthzLJ8pTxqFdHO0EJZogmuqfwyTyJ0I
 TWvcuVtvazEb7yGepOZLN6s5vZYQnqFDloZf/OAvuNjxZqXO8k6K8AhcB
 ELM8hdnrENPLS6IPkO/KftsB9NcJ7h8/FFvW4L7tNxOOqqsZ5Kd60xqoH A==;
X-CSE-ConnectionGUID: sos4fcPsReOXQ9V1xI7H4A==
X-CSE-MsgGUID: 91/Sv6a0SfORWLkbJuWvGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="86196015"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="86196015"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 12:15:07 -0700
X-CSE-ConnectionGUID: 2+vd5aZuTPm1nrSjiQl8Qg==
X-CSE-MsgGUID: eNYSsg3gSjutJ1CmHeHWSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="293955521"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa002.jf.intel.com with ESMTP; 13 Aug 2026 12:15:06 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wuatM-00000000WJl-0eHx;
 Thu, 13 Aug 2026 19:15:04 +0000
Date: Fri, 14 Aug 2026 03:14:42 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608140331.zh5DH6y9-lkp@intel.com>
User-Agent: s-nail v14.9.25
Subject: [Intel-wired-lan] [tnguy-next-queue:200GbE] BUILD SUCCESS
 f290d48f0299ced7f2cc939579396e79019a1b7c
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 200GbE
branch HEAD: f290d48f0299ced7f2cc939579396e79019a1b7c  ixd: add devlink support

elapsed time: 742m

configs tested: 15
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
alpha           defconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc          allyesconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
i386         allmodconfig    gcc-14
loongarch       defconfig    clang-24
mips       ip28_defconfig    gcc-16.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
parisc       allmodconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
parisc          defconfig    gcc-16.1.0
sh              defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
