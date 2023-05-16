Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2F1C77B7A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 16 May 2023 13:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 277E060BDA;
	Tue, 16 May 2023 13:23:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 277E060BDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684243433;
	bh=5zLXLQQfKbA7Eo18GsPTCVLdL8FkedPbOjOY+HD0RsU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=MVKGe13Mwcpqbns6Sa17fp5UCwF1mrA18N0T/hkP27TWRrEelgERjKu4hEYIVDa0N
	 G9zsz4RB2MK8o6HeINECffpNY+iGLrDIOvlsqedKsy24ht4WUq660rzeKpOwSTfJ+N
	 XHhh9cfZtVRMi2Olkp/TM8VAEQe2sKCGCRrJJLST2s4ydCgLIahw3tHxERe+bo36H5
	 WAI0186hay7kJ3PxBlGLMQ6uuEUKJfQi0GIjtfp7DauNfoGhqwn03kfICNxpNh/eZf
	 8mHHA06RD5bzm4H8X/LK4Fi73H4YMlkwaUGLkuIZPgVTLUFmHCI26NAXdUUbNJeH6/
	 Nm6t2ysAAa9iQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5PrLStjzjzJb; Tue, 16 May 2023 13:23:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1366660F39;
	Tue, 16 May 2023 13:23:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1366660F39
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 5A3771BF255
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 May 2023 13:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A851C40576
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 May 2023 13:23:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A851C40576
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0tdaEl5xWOqQ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 16 May 2023 13:23:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 11C884056D
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11C884056D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 16 May 2023 13:23:39 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="350314261"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; d="scan'208";a="350314261"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2023 06:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="825560474"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; d="scan'208";a="825560474"
Received: from gklab-018-208.igk.intel.com ([10.102.18.208])
 by orsmga004.jf.intel.com with ESMTP; 16 May 2023 06:23:37 -0700
From: Kamil Maziarz <kamil.maziarz@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 16 May 2023 15:23:30 +0200
Message-Id: <20230516132331.96017-4-kamil.maziarz@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230516132331.96017-1-kamil.maziarz@intel.com>
References: <20230516132331.96017-1-kamil.maziarz@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684243419; x=1715779419;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=slj4/eapHqcMRU6znZd7/ftpIhsj9tIY0Gsd95JyfA4=;
 b=FK+NpSEqnLCI2rdEjz9jS4q7lCa6OlsHI9HOY9f2AB2nM2NrkKRR6YkH
 JAY3CW3hg1ghwT4XpLLEkMFxhAARoAxZR+Pzm3NQusyBh0i+yWchDJnAS
 ZfIshcQCZzwI7Cleydv+trJC/w+vvuXAamNQrqQ2JlcvFrbEI8ybGQKtE
 JjpKBaJO658rFAyovnLrT//s5R+XtZy1mogGWOGgrEpNfbALzQNNeuj7G
 fKd4Bq6jXl+36I3sOdf4HU0nOAOJ8Wef5MDu+IxyFil7Kqhb56tR7deHT
 Jd3FTrcVf+rivogdnvOqrf5Xbz2g/EiMUjIMyN+Ihj9t453NMEnhv0m/Z
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=FK+NpSEq
Subject: [Intel-wired-lan] [PATCH iwl-net v7 3/4] Revert "iavf: Detach
 device during reset task"
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
Cc: Kamil Maziarz <kamil.maziarz@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Marcin Szycik <marcin.szycik@linux.intel.com>

This reverts commit aa626da947e9cd30c4cf727493903e1adbb2c0a0.

Detaching device during reset was not fully fixing the rtnl locking issue,
as there could be a situation where callback was already in progress before
detaching netdev.

Furthermore, detaching netdevice causes TX timeouts if traffic is running.
To reproduce:

ip netns exec ns1 iperf3 -c $PEER_IP -t 600 --logfile /dev/null &
while :; do
        for i in 200 7000 400 5000 300 3000 ; do
		ip netns exec ns1 ip link set $VF1 mtu $i
                sleep 2
        done
        sleep 10
done

Currently callbacks such as iavf_change_mtu() wait for reset and don't try
to take rtnl_lock if they already run under rtnl_lock (flag
IAVF_FLAG_RTNL_LOCK_TAKEN), therefore rtnl_lock will be released when reset
finishes, and only then another callback which uses rtnl_lock will be able
to start.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
---
v1->v7: no changes
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ef7b190ddda1..3d439f9ac97b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3015,11 +3015,6 @@ static void iavf_reset_task(struct work_struct *work)
 	int i = 0, err;
 	bool running;
 
-	/* Detach interface to avoid subsequent NDO callbacks */
-	rtnl_lock();
-	netif_device_detach(netdev);
-	rtnl_unlock();
-
 	/* When device is being removed it doesn't make sense to run the reset
 	 * task, just return in such a case.
 	 */
@@ -3027,7 +3022,7 @@ static void iavf_reset_task(struct work_struct *work)
 		if (adapter->state != __IAVF_REMOVE)
 			queue_work(adapter->wq, &adapter->reset_task);
 
-		goto reset_finish;
+		return;
 	}
 
 	while (!mutex_trylock(&adapter->client_lock))
@@ -3230,7 +3225,7 @@ static void iavf_reset_task(struct work_struct *work)
 	mutex_unlock(&adapter->client_lock);
 	mutex_unlock(&adapter->crit_lock);
 
-	goto reset_finish;
+	return;
 reset_err:
 	if (running) {
 		set_bit(__IAVF_VSI_DOWN, adapter->vsi.state);
@@ -3251,10 +3246,6 @@ static void iavf_reset_task(struct work_struct *work)
 	}
 
 	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
-reset_finish:
-	rtnl_lock();
-	netif_device_attach(netdev);
-	rtnl_unlock();
 }
 
 /**
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
