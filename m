Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1E5EB8FD5
	for <intel-wired-lan@archiver.kernel.org>; Wed,  6 Sep 2023 14:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0DE660AC2;
	Wed,  6 Sep 2023 14:14:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0DE660AC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1694009667;
	bh=m222mQGaxiZhnq6gV68ma2KGyWhOAiJSSefKyzvU+fw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=LT0WpIYMOZjQpEw0u60B5D88vQuDNmoW1qTrS9gSkkyux/e1I0bTD+T1zf50d+hCN
	 NrT4QarMm5drPTil88Zy3WrJDPSqMwQkll4fo/otNuHiLD05UMcTtxVpux8jjvoImQ
	 DCAQR7pN1/YKHxcbyWLNGldjqF4pcJmFJvtN8KffhSfHhr1qTf7PIUzGAWOGEtb1m1
	 ZIy35GPWclNgPQBGuA9UiTicWz3gAGiueiuxZzJEelr1EPXSprGRjsjUOcqLAVUfpi
	 uhAKrPACtjWwCjACF/qq/4tVgyPYSgddwtSm8jWTrLWTtRF1q+btm8z8K4xfyxXmSU
	 usO9PvQRDzy9g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9t-NNTwDDNAk; Wed,  6 Sep 2023 14:14:26 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 161E560E4F;
	Wed,  6 Sep 2023 14:14:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 161E560E4F
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id EAC1E1BF37E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Sep 2023 14:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3B6460AE3
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Sep 2023 14:14:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3B6460AE3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ijo3_iFbLZDc for <intel-wired-lan@lists.osuosl.org>;
 Wed,  6 Sep 2023 14:14:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3AEA60AC2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Sep 2023 14:14:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3AEA60AC2
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-yLMos6wtPQm2-6xQGW1xUQ-1; Wed, 06 Sep 2023 10:14:16 -0400
X-MC-Unique: yLMos6wtPQm2-6xQGW1xUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63BB11C07550;
 Wed,  6 Sep 2023 14:14:15 +0000 (UTC)
Received: from swamp.redhat.com (unknown [10.45.225.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB34D1121314;
 Wed,  6 Sep 2023 14:14:13 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Date: Wed,  6 Sep 2023 16:14:11 +0200
Message-ID: <20230906141411.121142-2-poros@redhat.com>
In-Reply-To: <20230906141411.121142-1-poros@redhat.com>
References: <20230906141411.121142-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1694009659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DOOoWT2kY2wb/QpswVRpo14Z/GIJ+wzCXioOsVk9PeA=;
 b=eH2D0+wytpPFD38bSJ8qOBOONKYnIJNFjEyQv7+ZD6FwrHAbjrnL02pRT5yT4P/K+yFkuw
 8IkPJgVbf/0fbfCSkBlTnXyltGEHU1KuLtGqTSvJOd6lOnZpqHTFZM3VGDnRRUA4UqfBJQ
 ND5ENtWPkwrktsY6GatswGglFOg77IQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eH2D0+wy
Subject: [Intel-wired-lan] [PATCH net 2/2] iavf: schedule a request
 immediately after add/delete vlan
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
Cc: ivecera@redhat.com, intel-wired-lan@lists.osuosl.org,
 jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, edumazet@google.com,
 anthony.l.nguyen@intel.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

When the iavf driver wants to reconfigure the VLAN filters
(iavf_add_vlan, iavf_del_vlan), it sets a flag in
aq_required:
  adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
or:
  adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;

This is later processed by the watchdog_task, but it runs periodically
every 2 seconds, so it can be a long time before it processes the request.

In the worst case, the interface is unable to receive traffic for more
than 2 seconds for no objective reason.

Signed-off-by: Petr Oros <poros@redhat.com>
Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Co-developed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 86d472dfdbc10c..d9f8ac1d57fd62 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -821,7 +821,7 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
 		list_add_tail(&f->list, &adapter->vlan_filter_list);
 		f->state = IAVF_VLAN_ADD;
 		adapter->num_vlan_filters++;
-		adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_VLAN_FILTER);
 	}
 
 clearout:
@@ -843,7 +843,7 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
 	f = iavf_find_vlan(adapter, vlan);
 	if (f) {
 		f->state = IAVF_VLAN_REMOVE;
-		adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_VLAN_FILTER);
 	}
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
-- 
2.42.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
