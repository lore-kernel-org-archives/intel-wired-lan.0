Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F63C4167B
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Nov 2023 19:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86FE641B42;
	Thu, 30 Nov 2023 19:31:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86FE641B42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701372706;
	bh=YzDapIStIpruR3HpTu6lC54fMQEJ3zOozDS3g/SoZg4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=FqSYWwGC1okqkSItWqE7Fe0X8sGr9WT7JSrqh1EwyZcxwyO0oAhIbXsddSK2nYC/B
	 z5qT/wR7z4XR+0P2EWjv9W5kmmrqDH8e7tJeebvIMM7dnkCiAbAg457xBzUrQWF/S6
	 Cw0qNYqLw4x8qx5ofK1x3+ZJzQ325bgyZcm1Iixf+YoR827E9BfCfgrlvUYVRxcnWX
	 pMIUOdTlNl8sQzCUKTKqpwMx9y5HCY6DlOW+P2WLlJnHWDRD+vy1D3cqGbhQiTdTad
	 dJGQLigDKXKUPkei77OOqGOhCRaz2ueNvl8VHZyXSULZY0OAe67iDRL+toSPo0xM6s
	 BAihqcg/i1gFw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HnakWpmyJAw8; Thu, 30 Nov 2023 19:31:45 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8876641F3E;
	Thu, 30 Nov 2023 19:31:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8876641F3E
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 919041BF40F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Nov 2023 19:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 680094362A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Nov 2023 19:31:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 680094362A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L3VHKShSgj4H for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Nov 2023 19:31:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8364040122
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Nov 2023 19:31:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8364040122
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-ruzrkH6zNcqvsDcI07CyeA-1; Thu, 30 Nov 2023 14:31:38 -0500
X-MC-Unique: ruzrkH6zNcqvsDcI07CyeA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACBB485A58C;
 Thu, 30 Nov 2023 19:31:37 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 061F31C060AE;
 Thu, 30 Nov 2023 19:31:35 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Date: Thu, 30 Nov 2023 20:31:34 +0100
Message-ID: <20231130193135.1580284-1-ivecera@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1701372702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XUKjduYx0sBCtPzyCQgJXjX+AsFij/jhpdfQd/PC2MQ=;
 b=fbC7+/9w4/a+PTJLG5fk7ArUBOoV88utdx0e5FiRGg9qP4UGbzOm+WL7fANbzR8Gdl3PGn
 3A10r+FLG/OtNHpZ8HNxFsIk+NXQ3YWyVwJbqBJsw8ojOzfH/TkDo7ySHOdqQ21KEtEAfI
 ZPdL5Z8azgAJsf1enpoJ609ffOX+jwI=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fbC7+/9w
Subject: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix wrong mask used during
 DCB config
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
Cc: "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Mask used for clearing PRTDCB_RETSTCC register in function
i40e_dcb_hw_rx_ets_bw_config() is incorrect as there is used
define I40E_PRTDCB_RETSTCC_ETSTC_SHIFT instead of define
I40E_PRTDCB_RETSTCC_ETSTC_MASK.

The PRTDCB_RETSTCC register is used to configure whether ETS
or strict priority is used as TSA in Rx for particular TC.

In practice it means that once the register is set to use ETS
as TSA then it is not possible to switch back to strict priority
without CoreR reset.

Fix the value in the clearing mask.

Fixes: 90bc8e003be2 ("i40e: Add hardware configuration for software based DCB")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 68602fc375f6..073ffbfcbe8d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -1576,7 +1576,7 @@ void i40e_dcb_hw_rx_ets_bw_config(struct i40e_hw *hw, u8 *bw_share,
 		reg = rd32(hw, I40E_PRTDCB_RETSTCC(i));
 		reg &= ~(I40E_PRTDCB_RETSTCC_BWSHARE_MASK     |
 			 I40E_PRTDCB_RETSTCC_UPINTC_MODE_MASK |
-			 I40E_PRTDCB_RETSTCC_ETSTC_SHIFT);
+			 I40E_PRTDCB_RETSTCC_ETSTC_MASK);
 		reg |= ((u32)bw_share[i] << I40E_PRTDCB_RETSTCC_BWSHARE_SHIFT) &
 			 I40E_PRTDCB_RETSTCC_BWSHARE_MASK;
 		reg |= ((u32)mode[i] << I40E_PRTDCB_RETSTCC_UPINTC_MODE_SHIFT) &
-- 
2.41.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
