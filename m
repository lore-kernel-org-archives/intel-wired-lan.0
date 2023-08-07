Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374A0C001B0
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Aug 2023 16:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B54D060743;
	Mon,  7 Aug 2023 16:02:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B54D060743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691424155;
	bh=4vixqmd6s2FqsTJEZUVjdrTQ4Sz2komxVOBJy2LGwGQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=6NiHJpgpi9wDIQrwLXQv9oDYLGBxF5kOEgOlMPjV6CsempOHAfIkGxZI6WsrScW75
	 ecWrAnRf5eoHzLINImvkTaRM2+WcLDCSiYu6dyMgku18rie1I1rfBEG9vDE2Vvs0rS
	 +vosxfyGDjGrYVuLxWkz5/GQPkykgCN5ursxsrI/Il0pVBmHhmDlXj5sQWMuM6XfSk
	 zsG4+JW6ymDULlczGMKns/JZKwUlAYDvIF5c69BXwtA9YqFW8PBFpxiNKX5A+3pTAP
	 50R2Y0xqMEyD/S8XM9kmfCVgkp2wRMC+Sxhxg9u1VPFlsugPAvEBIyjyhKMLnSOLD1
	 ERDqUX7i5PXCA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EM-Gyc1l-9Ow; Mon,  7 Aug 2023 16:02:35 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 720BB60FF4;
	Mon,  7 Aug 2023 16:02:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 720BB60FF4
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 8C20C1BF280
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Aug 2023 16:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6223540985
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Aug 2023 16:01:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6223540985
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4uZM6nN4tBLM for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Aug 2023 16:01:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D2CB415EB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Aug 2023 16:01:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D2CB415EB
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="456967051"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; d="scan'208";a="456967051"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 09:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="796365562"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; d="scan'208";a="796365562"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmsmga008.fm.intel.com with ESMTP; 07 Aug 2023 09:01:34 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id E64A3312D4;
 Mon,  7 Aug 2023 17:01:33 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  7 Aug 2023 11:58:45 -0400
Message-Id: <20230807155848.90907-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691424098; x=1722960098;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cUqjKer+5uwiSyBxYhhMd/RhPbu+D0VIVAEb66SA7io=;
 b=FsuGAiUgjYbuVM9oIMO8pwuEy9G99P+we0MhaOOx1J5q+pX48xUsiokY
 axznCRYaOGjl0I7PkG9u7u5GEGaOEVZEWNtSgwdBVdOWPtWpmdbiez7ja
 7+MvmEJjj5Nr6SCPppqDg+utFyncNQE72SJr6sFhcvLeaYK4i1QxJEe8g
 JGzTy2jfd7A/vtUsV1Vh0F1w7Ht5FkZxDZY/wPMovUb6BYdzfpuBcyW7E
 3O8kgrKA5cbsd/7HVAz2CoLzSOYJ8ncj/y767G3fLke8694x/AQFPeROo
 v1GsYobCZAUIMR9ypKwwuUYFG48LXCSG54TmqiwIsbqYedLiVI7a8/V4k
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=FsuGAiUg
Subject: [Intel-wired-lan] [PATCH iwl-next v3 0/3] ice: split
 ice_aq_wait_for_event() func into two
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
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Mitigate race between registering on wait list and receiving
AQ Response from FW.

The first patch fixes bound check to be more inclusive;
the second one refactors code to make the third one smaller,
which is an actual fix for the race.

Thanks Simon Horman for pushing into split, it's easier to follow now.

v3: split into 3 commits

Przemek Kitszel (3):
  ice: ice_aq_check_events: fix off-by-one check when filling buffer
  ice: embed &ice_rq_event_info event into struct ice_aq_task
  ice: split ice_aq_wait_for_event() func into two

 drivers/net/ethernet/intel/ice/ice.h          |  21 +++-
 .../net/ethernet/intel/ice/ice_fw_update.c    |  45 ++++----
 drivers/net/ethernet/intel/ice/ice_main.c     | 100 +++++++++---------
 3 files changed, 94 insertions(+), 72 deletions(-)


base-commit: 1efaa6ca8af14114dafb99924bc922daa135f870
-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
