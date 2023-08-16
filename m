Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D432C0015E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Aug 2023 01:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AEE941B93;
	Wed, 16 Aug 2023 01:07:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AEE941B93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692148041;
	bh=vJH7YoDemgehPcluiXBBNgwLIG2RMfqFDBtPvFUS0u8=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=93+sz3ZMo2652gQEvJC476LVhsvY65yTchFHWh+xjIs1Z6+yykJZsZLgQWcc4NU8N
	 wE0s+JTEI9/yFKxzpPBSfOlMaveVSMbklAWMfV9Oh4vK5BNzVgwB/XPmc+C08h+sYS
	 yn6c4e2mTRQiliQW8YRT6WK4hQr0RCKc8WN86BIsDQVsZIttDcxFrqS1buWXzcTPzN
	 aSe4nHgvO9MO0N1Rifav/rumxoqFASsE2eEPuaMYIyds6oauigS8rgzHz6HPHmPRyO
	 WFTCPTarIsV5+WhvMUT64hdhytUZlfFfNBm+RDZ+Z1MxOUJfWBopf+5dKejS0vScVE
	 sJ6UBr+kJC4dQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3TOtACXPuj_6; Wed, 16 Aug 2023 01:07:20 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86B7141B99;
	Wed, 16 Aug 2023 01:07:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86B7141B99
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 5844B1BF3CB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Aug 2023 01:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CFB9611FD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Aug 2023 01:07:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CFB9611FD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6hTx7rzxr25r for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Aug 2023 01:07:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1602E60A61
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Aug 2023 01:07:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1602E60A61
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357388352"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; d="scan'208";a="357388352"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2023 18:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824049528"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; d="scan'208";a="824049528"
Received: from jbrandeb-saw1.jf.intel.com ([10.166.28.102])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2023 18:07:13 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 15 Aug 2023 18:07:03 -0700
Message-ID: <20230816010705.1360446-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692148035; x=1723684035;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3UAI8MmbAW1Uz6lsnl70avcPdBJLOdqOXAwW6oAPDko=;
 b=MyKgZA+09qfCYIFQ3/u3iNVTfqoBUf+8IW8rTUnItvt5np/9JlsK7ooq
 hffjRcFWG9ozD4NarJSUyKxaj3/VT3CQzX/sGLN47p8rystRN62mYxcsH
 RZmfanwnCrTEOrb0oB8Gwpjhy90TATHr/VkUYjrwzRI9UUa4KaE1u3Juz
 AnOT5Wbvl1gfRcYRm1kcREyMnf8Ai4nIgJqce/wVT7xC0YNKjhEJMVeYz
 IkKaKsLdDeo0nOGf+0fGtwKvwhJUw2I4cJcnPfM4OV2RqjDpQjD3l1iP+
 RMsRNtvKV7hoGDkTzEU+sZua14dSIAWEC21U25XTc0D26JbCBhIu3A9kp
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MyKgZA+0
Subject: [Intel-wired-lan] [PATCH iwl-next v1 0/2] ice: minor cleanings
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Make a couple of quick cleanups to the GNSS code, resulting in a little
less code and a little more readability.

Jesse Brandeburg (2):
  ice: refactor code to remove unused variable
  ice: trivial: normalize strings

 drivers/net/ethernet/intel/ice/ice_gnss.c | 9 ++++-----
 drivers/net/ethernet/intel/ice/ice_gnss.h | 1 -
 2 files changed, 4 insertions(+), 6 deletions(-)


base-commit: 8e5db4d73415c64d07aa7ca7743c4a2882c8979b
-- 
2.41.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
