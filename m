Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47257C0032E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Oct 2023 01:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B11AE60D7B;
	Mon, 23 Oct 2023 01:21:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B11AE60D7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1698024104;
	bh=XqHNIdcVk+ynyC6MqJDvQgS+NytTDyqJkHYG3Cno+yk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=cZW4uspzFuKkGN7bwIclVeg0HenAOPjQt5jxDBSrMXcXczFxTSP7NK3nWskJvLOtL
	 9fAe6wwvpPSxCTVQOz5OfJvNUraVtmF19wT/2+x52yDeHz6OtBpuXZP6WxImoRE/vk
	 5bynQQnObqCxKJG965TC0IW0HR1GzGjq8TRG1lpwfuAM/9SSurC3fWTllO/Vwi+bLk
	 faD9mVRSgTspaHtgEAoDz5HmKunwsv0ahWUlyTlrdjgFeKBDhxA12AlJ3brmK1BcoR
	 QQLEwSZckz1Q7FpbeTZRFOM9QZSOXKcXK3gtfkBUt4G93rvVZ3Jh8PjkycuN13OweK
	 IvT05/DTw8dIg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id APa7Ep_esX4D; Mon, 23 Oct 2023 01:21:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id C240660D88;
	Mon, 23 Oct 2023 01:21:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C240660D88
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 1442C1BF40E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Oct 2023 01:21:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DFA5560D88
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Oct 2023 01:21:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFA5560D88
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LEnqH0F7u-RT for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Oct 2023 01:21:40 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
 by smtp3.osuosl.org (Postfix) with SMTP id 2C3B360D7B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Oct 2023 01:21:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C3B360D7B
Received: from localhost.localdomain (unknown [180.167.10.98])
 by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 157906047A509;
 Mon, 23 Oct 2023 09:20:59 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com
Date: Mon, 23 Oct 2023 09:20:25 +0800
Message-Id: <20231023012024.18757-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Subject: [Intel-wired-lan] [PATCH v2 RESEND] i40e: add an error code check
 in i40e_vsi_setup
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
Cc: Su Hui <suhui@nfschina.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

check the value of 'ret' after calling 'i40e_vsi_config_rss'.

Signed-off-by: Su Hui <suhui@nfschina.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Resend to hit the intel0wired-lan list.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index de7fd43dc11c..4904bc8f5777 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14567,9 +14567,13 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	if ((pf->hw_features & I40E_HW_RSS_AQ_CAPABLE) &&
 	    (vsi->type == I40E_VSI_VMDQ2)) {
 		ret = i40e_vsi_config_rss(vsi);
+		if (ret)
+			goto err_config;
 	}
 	return vsi;
 
+err_config:
+	i40e_vsi_clear_rings(vsi);
 err_rings:
 	i40e_vsi_free_q_vectors(vsi);
 err_msix:
-- 
2.30.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
