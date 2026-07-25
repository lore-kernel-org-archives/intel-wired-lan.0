Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECD7C531C9
	for <intel-wired-lan@archiver.kernel.org>; Sat, 25 Jul 2026 08:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF193407CD;
	Sat, 25 Jul 2026 08:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q5Bpw7gj321F; Sat, 25 Jul 2026 08:26:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3748640732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784968001;
	bh=l0gW9xRYFRAg3MelY7p/GkZQBOYLjmW3fH/aW4FtQSM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h2y0rA/RQN5Mp57eSrkKVcmqxakArbffW14E4g8ADMMZObUY+qKTH673rBdELcqB+
	 PDW2lKP1bi5+hBkd5TjtBJo8wbvkAawE5CZ0pweGeCh1NocYnGnQ8L3GCIyGBYhiFm
	 AdNQj8bhWvJgBNzzTnzpe8tC7J+JBjbJmoN+P1Ojx2llyDTMQHzTUHuPD/QdAshrFi
	 DFSlWflLj+pWreefw10HHscUMFtvV7+LHa+DahTjjAqBFXlBY9R9AsIvmbK6SnYGoW
	 r3iP+dtzExn0MjHQkkSP5BroAcLAKiS60tSQbA910bSwCckL4X1zNkG3w2j4atUMSJ
	 ea7r1j6T7CLJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3748640732;
	Sat, 25 Jul 2026 08:26:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0729736E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 08:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC78981184
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 08:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o92nhlCeS9vv for <intel-wired-lan@lists.osuosl.org>;
 Sat, 25 Jul 2026 08:26:39 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C836481180
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C836481180
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C836481180
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 08:26:37 +0000 (UTC)
X-CSE-ConnectionGUID: D1QU/HneRySHItDiV4nd9w==
X-CSE-MsgGUID: zaWrL0x5R4yxmKqrzGnPHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85666592"
X-IronPort-AV: E=Sophos;i="6.25,184,1779174000"; d="scan'208";a="85666592"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2026 01:26:37 -0700
X-CSE-ConnectionGUID: NFVnDjVSR+K6IKLHSUMIJg==
X-CSE-MsgGUID: H/sGEth+Tte1iKxIO/ybOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,184,1779174000"; d="scan'208";a="255564672"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jul 2026 01:26:36 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wnXhP-00000000ba2-17vo;
 Sat, 25 Jul 2026 08:26:04 +0000
Date: Sat, 25 Jul 2026 16:25:13 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607251640.28RHtI3R-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784967999; x=1816503999;
 h=date:from:to:subject:message-id;
 bh=PyRLZCkFK7zfZJmCx3S2RgzTnTVV/URRfQWA8RhTuVE=;
 b=beLco4RBoB5DuRMZ04AnzzBjkIfyG/O0Qh6TwA3DjtfKzqKxdP+Aa6S+
 KVReCtn30NX3E6YS9dKWXbb0k4VMJbhRWVnf8GJ+koyldOEOo5cjT6d/b
 2vrb6XFKW3MCkE4cTSdNqUE+V8Ey0m1CeRUfBm4Ed0KE1swyjIo7E+F5W
 IhXqe8+TO7kkoHokEfHf69eSvmvGM7h4bEBHF9F0dzbAhbm+g+Wr5qmU4
 nNuFcj/EgTFTfrlj09pPUUUdujgs/L0DKjL7ckLu/pYTvzCAnNEVW3g7S
 LX2W5I7+LEVnHlseegwDpOkzK4FOBMNakJRxM3H21yTIh1zzb1mnHVriA
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=beLco4RB
Subject: [Intel-wired-lan] [tnguy-next-queue:10GbE] BUILD SUCCESS
 298bb2b8903323f6ef2eab4819a2e477765f0ff1
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
branch HEAD: 298bb2b8903323f6ef2eab4819a2e477765f0ff1  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

elapsed time: 6707m

configs tested: 17
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha          allnoconfig    gcc-16.1.0
alpha         allyesconfig    gcc-16.1.0
alpha            defconfig    gcc-16.1.0
arc           allmodconfig    gcc-16.1.0
arc           allyesconfig    gcc-16.1.0
csky          allmodconfig    gcc-16.1.0
i386          allmodconfig    gcc-14
loongarch        defconfig    clang-24
mips       ath79_defconfig    gcc-16.1.0
nios2         allmodconfig    gcc-11.5.0
nios2          allnoconfig    gcc-11.5.0
parisc        allmodconfig    gcc-16.1.0
parisc        allyesconfig    gcc-16.1.0
parisc           defconfig    gcc-16.1.0
sh               defconfig    gcc-16.1.0
x86_64               kexec    clang-22
x86_64        rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
