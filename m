Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E79C0015E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Jul 2023 15:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 987AF81461;
	Mon, 17 Jul 2023 15:27:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 987AF81461
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1689607632;
	bh=YWEphFwdB/ICz08fi4rUmUGaulQqabJ9QjJ4a4KsXis=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=yVF2F2JuSgoZRXmCXrUu94kBlyJSRa086gsfuD2qLjd4XuGhOWLJrnmBc+M1mw/QI
	 Ucu3Ppt1JK6Yek3CBPHDUqiLth8ldXJEhIULGNzg1cqSfNmnd8xo/VqMI6czgbmMeh
	 5yY3AWPAo9b08VNm79xBrMumE5VwwH8Onf60MTnCRrwZg+gT9j+YO8lKGxCE5a8Ahx
	 lNXvybq4N7buIJJG+I1QC0t6MU0nI/RluBEwd0RV+ir7vsTIQMXRLv+ujaIjo05uZ2
	 rjeqiBAtH8HnIkhnJ1E7ePUTrhBmYmsO5Sp942fUv2JebiYHxCfTx0tNxIEb/Fq4B+
	 RbFHo3P/jBYIw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rXm-nY9djorb; Mon, 17 Jul 2023 15:27:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 199D18149C;
	Mon, 17 Jul 2023 15:27:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 199D18149C
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 56A7F1BF377
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Jul 2023 03:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A8D9408CB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Jul 2023 03:12:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A8D9408CB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j_zVyoy1vkOa for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Jul 2023 03:11:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E6D340140
Received: from mail.nfschina.com (unknown [42.101.60.195])
 by smtp2.osuosl.org (Postfix) with SMTP id 2E6D340140
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Jul 2023 03:11:58 +0000 (UTC)
Received: from localhost.localdomain (unknown [180.167.10.98])
 by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 7E30B6012605B;
 Mon, 17 Jul 2023 11:11:55 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Wu Yunchuan <yunchuan@nfschina.com>
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Mon, 17 Jul 2023 11:11:54 +0800
Message-Id: <20230717031154.54740-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 17 Jul 2023 15:27:05 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 5/9] ice: remove unnecessary
 (void*) conversions
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
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 Wu Yunchuan <yunchuan@nfschina.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

No need cast (void*) to (struct ice_ring_container *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 19a5e7f3a075..6d021597506f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6249,7 +6249,7 @@ static void ice_tx_dim_work(struct work_struct *work)
 	u16 itr;
 
 	dim = container_of(work, struct dim, work);
-	rc = (struct ice_ring_container *)dim->priv;
+	rc = dim->priv;
 
 	WARN_ON(dim->profile_ix >= ARRAY_SIZE(tx_profile));
 
@@ -6269,7 +6269,7 @@ static void ice_rx_dim_work(struct work_struct *work)
 	u16 itr;
 
 	dim = container_of(work, struct dim, work);
-	rc = (struct ice_ring_container *)dim->priv;
+	rc = dim->priv;
 
 	WARN_ON(dim->profile_ix >= ARRAY_SIZE(rx_profile));
 
-- 
2.30.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
