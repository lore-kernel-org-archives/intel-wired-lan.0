Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81863FEA810
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Mar 2026 06:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 418CB40B0F;
	Wed, 25 Mar 2026 06:32:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p2qPaj3sSaPd; Wed, 25 Mar 2026 06:32:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 789D740ADB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774420345;
	bh=LeY8on+QxrjVOh3Y9M+byc87lOW3st4MCgF+2x97gFY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=xM1xoqhF32nwWjJhdvDu6iXTH2ylXPMXq7exVxlOGd1n+qrEYMbFvR/KlQm4GK+Py
	 OdOO6Mk/zl0gUbId924cxHATwNo4e0MiVH6X9efnZPBTAxgUZ0jmBEAxAdttnnKEWy
	 WsSjoJJC2Hp8CB8wbSij2oAYvaF+Ka4WjtECB5y1MCOpxKvLycalX8YbIMcpBu1xtc
	 60TTaPoSEVkPTgJ4pvr1UJl4TYMh73F+ZED33BfU9L5YGIxk5Jyf0HeW48jAggBbFR
	 mSCNqcqDvufkdy6KGC/PxtdmedNqUdiVQDaOQmExr5sYcUnJtVmamngI3p2/UVJItZ
	 n1xjhCXp7Xq3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 789D740ADB;
	Wed, 25 Mar 2026 06:32:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DA17F4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 06:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E75A81E98
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 06:32:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N-NkOWNbaL2b for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Mar 2026 06:32:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A029181E82
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A029181E82
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A029181E82
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 06:32:22 +0000 (UTC)
X-CSE-ConnectionGUID: exkLTYqIRM6W5WGU4JkaGQ==
X-CSE-MsgGUID: vEKie1oTSWCgJyeEwZbTqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79308059"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="79308059"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 23:32:03 -0700
X-CSE-ConnectionGUID: c4AZVoq4R++XfBqFDgcO0w==
X-CSE-MsgGUID: AkmZzNiURHaHCed3r6J5yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="221693624"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa008.fm.intel.com with ESMTP; 24 Mar 2026 23:31:55 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.24])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id A69C92FC5;
 Wed, 25 Mar 2026 06:31:53 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Date: Wed, 25 Mar 2026 07:26:51 +0100
Message-ID: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774420344; x=1805956344;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rr6l49RKEKgpQ2DNOXWch18uCBagDtqaiQoNtQSds+k=;
 b=UUzYjqmccxV8QKj9Q3UBirv4U1MuCQWoxV3CrrJjN1r3c8GqY4Ge6Bfw
 yWmoiMNPrnzdFImCB+XXXFc+Kqn8jSqWntDBuAQegkldpqh2uofW/sCE7
 VENmfIrdIDf3f1tRXv/mDVYwJQNtGPfBqNChAiNEDZss8HjlYrQGh5EbP
 H6/tawS2lGuipmSGTFPH3n0mzpXX722IJV9cjZ469hulJQ9QnqjDlIj2j
 hCGOs45K41kTRbua7Ztn6heDOqx7xwY90dUClj4+etpqUxxFbxNyh80mH
 qUf8ZYzkckMUj59c8ltM6liA/2SzX/zFL19Pqg6mC9HV3TS71dPwst47K
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UUzYjqmc
Subject: [Intel-wired-lan] [PATCH net-next 0/2] devlink: shared devlink
 improvements
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>


First patch unifies access to priv data set by driver
(changelog in the patch).

Second patch improves support of devlink resources registered for shared
instance (new in v2 of the series).

Przemek Kitszel (2):
  devlink: unify devlink_shd_get_priv() into devlink_priv()
  devlink: unregister shared devlink resources on destroy

 net/devlink/devl_internal.h |  7 +++++++
 net/devlink/core.c          | 10 +++++++++-
 net/devlink/sh_dev.c        |  9 +++++----
 3 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.51.1

