Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D509ACDB47E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Oct 2023 17:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91CC141B33;
	Fri, 13 Oct 2023 17:08:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91CC141B33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697216909;
	bh=rETaXyGJqlh2KTDccIm686FSmoxhOCzyIcUC8+1iXuU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=PPW6ple4J7CatwRsZIVbQT6usupLH5d3EgzKpjUf458WRekh1kzT2E3Ya4rqxOreu
	 ulzJYXFNfRPp4IAZ6m6OkErJ1cBhaKYlDCkDve6FwRj89uTNDFns7wmySpBrtV9Gdk
	 jysniswe6qxlQJhf9jJwbrpdSeDYQl8hGXmdmRWuSbXa7hCR6TOPqhqWQfaGlMhjum
	 DFCOhvvYyrlzwKhIkPp/Ii0mt0sFQuoaA+Zt4+l9gAJxw9OYvns5SAF2t6kqZR9xxO
	 es8KbOgXtd5mt2SENECuiVQ/dAjHQ2ikOJoXAIxaDFAr/GV8B1f/4tnFsI91aqZ9Yd
	 w6YR2tAs3cWaQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XSDz8BvsaqCZ; Fri, 13 Oct 2023 17:08:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F64B41F34;
	Fri, 13 Oct 2023 17:08:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F64B41F34
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id A51ED1BF425
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Oct 2023 17:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D54A4185D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Oct 2023 17:08:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D54A4185D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L2TgjSJuh_n8 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Oct 2023 17:08:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B2CA41FE0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Oct 2023 17:08:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B2CA41FE0
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-679-y7q8E_PHOtS-o4wjcSZ9Eg-1; Fri, 13 Oct 2023 13:08:07 -0400
X-MC-Unique: y7q8E_PHOtS-o4wjcSZ9Eg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74E3581D785;
 Fri, 13 Oct 2023 17:08:06 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F19D1C060DF;
 Fri, 13 Oct 2023 17:08:04 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Date: Fri, 13 Oct 2023 19:07:55 +0200
Message-ID: <20231013170755.2367410-6-ivecera@redhat.com>
In-Reply-To: <20231013170755.2367410-1-ivecera@redhat.com>
References: <20231013170755.2367410-1-ivecera@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1697216898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxrYnBgqo6Ypf3qFn6oPVVOuF0D+Jrw2SWHdpcdDDnA=;
 b=DevoyWqLSttgXh64edRxo+lOwZMFHXg142vLRomfSlYG+nYFC7MnXYdGpNmmmcIxLgs8MH
 Qg/B0dbFMd/E7MVW/GcVvBXfCN6ucnTtKTpBsdQfKEuS5MDg6Vj/MXPoMc71Mklj+gry2S
 FPDFXbZjPhavFhuf5O3f2ysWxiNUrXA=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DevoyWqL
Subject: [Intel-wired-lan] [PATCH net-next 5/5] i40e: Add PBA as board id
 info to devlink .info_get
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
Cc: intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Expose stored PBA ID string as unique board identifier via
devlink's .info_get command.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_devlink.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index fb6144d74c98..9168ade8da47 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -29,7 +29,15 @@ static void i40e_info_fw_api(struct i40e_hw *hw, char *buf, size_t len)
 	snprintf(buf, len, "%u.%u", aq->api_maj_ver, aq->api_min_ver);
 }
 
+static void i40e_info_pba(struct i40e_hw *hw, char *buf, size_t len)
+{
+	buf[0] = '\0';
+	if (hw->pba_id)
+		strscpy(buf, hw->pba_id, len);
+}
+
 enum i40e_devlink_version_type {
+	I40E_DL_VERSION_FIXED,
 	I40E_DL_VERSION_RUNNING,
 };
 
@@ -41,6 +49,8 @@ static int i40e_devlink_info_put(struct devlink_info_req *req,
 		return 0;
 
 	switch (type) {
+	case I40E_DL_VERSION_FIXED:
+		return devlink_info_version_fixed_put(req, key, value);
 	case I40E_DL_VERSION_RUNNING:
 		return devlink_info_version_running_put(req, key, value);
 	}
@@ -90,6 +100,12 @@ static int i40e_devlink_info_get(struct devlink *dl,
 	i40e_info_civd_ver(hw, buf, sizeof(buf));
 	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
 				    DEVLINK_INFO_VERSION_GENERIC_FW_UNDI, buf);
+	if (err)
+		return err;
+
+	i40e_info_pba(hw, buf, sizeof(buf));
+	err = i40e_devlink_info_put(req, I40E_DL_VERSION_FIXED,
+				    DEVLINK_INFO_VERSION_GENERIC_BOARD_ID, buf);
 
 	return err;
 }
-- 
2.41.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
