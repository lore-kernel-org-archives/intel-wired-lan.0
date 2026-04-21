Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8EDF8925E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Apr 2026 11:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B39E66131A;
	Tue, 21 Apr 2026 11:12:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hXGiS1VpYRKU; Tue, 21 Apr 2026 11:12:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 730616131C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776769968;
	bh=iEkfECukKbV80ZZBX+sDP9TLbBqsQA+hSKML9YufPe0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=GuAr0y8pdxf8Eokv8laNFz7MlMZqq8QUsElfGcOhreb+Qq5Hxhw92PC4p3deZ9M/o
	 +RLWd7VnsEfg8+gI18vL2ycNpbYbatnz8RkxnfsLUPC5a1BlsV6DNL/VjsGNOcrOEG
	 AtigLK7P5Hu+ibHoxeZr7h0HPipQtCwvEfdvYU2Xc1n3C5gVoxkQyoMZwRqhynWVH4
	 OtaZDNIwkDRn1kMBntceN0qYqj1L9yqttbceZMkFngGYgYior40mEXrEZXPP84YaqN
	 397f0ivBSxR+wI6ZpCABQdEAXhC4yQMTcxpG94NWQjuemhiiZqPGla2F8Kk4rY6B21
	 5f8e7cxCdnEQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 730616131C;
	Tue, 21 Apr 2026 11:12:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C5260259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Apr 2026 11:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AAC1141F29
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Apr 2026 11:12:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JFvSBmfZfI92 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Apr 2026 11:12:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=vinschen@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 85B5541F28
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85B5541F28
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85B5541F28
 for <intel-wired-lan@osuosl.org>; Tue, 21 Apr 2026 11:12:44 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-syRl3_z_M6yGUyI_u16pAw-1; Tue,
 21 Apr 2026 07:12:39 -0400
X-MC-Unique: syRl3_z_M6yGUyI_u16pAw-1
X-Mimecast-MFC-AGG-ID: syRl3_z_M6yGUyI_u16pAw_1776769959
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF5AC1800473; Tue, 21 Apr 2026 11:12:38 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.44.32.45])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D216195608E; Tue, 21 Apr 2026 11:12:38 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1DFEAA80C56; Tue, 21 Apr 2026 13:12:36 +0200 (CEST)
From: Corinna Vinschen <vinschen@redhat.com>
To: intel-wired-lan@osuosl.org,
	netdev@vger.kernel.org
Date: Tue, 21 Apr 2026 13:12:36 +0200
Message-ID: <20260421111236.875379-1-vinschen@redhat.com>
In-Reply-To: <IA3PR11MB898664A49E614F197D4FED6EE52C2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB898664A49E614F197D4FED6EE52C2@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: TvCiq_WA3BB_K-bjga2TQ7L7tK2Qak_BZX2JSb7v8nw_1776769959
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1776769963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iEkfECukKbV80ZZBX+sDP9TLbBqsQA+hSKML9YufPe0=;
 b=Lc6wpenGroj0PVanbJ5m1/7THRCCrkLuNyhY8jvV+FIFVhcfnLtcvwWic70bgBy3GttzEa
 7aqu3P8XwpXyDsPnfD37YJfSlX90KNi6ZsRO+Z3zhdiBPIFUlTlgAAGM60HxRqTPEObrZE
 CguQIB3+fnOSOqbBuDdmM6OZm7IBhv8=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Lc6wpenG
Subject: [Intel-wired-lan] [PATCH net] iavf: iavf_virtchnl_completion: drop
 duplicate ether_addr_equal() test
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
Cc: Corinna Vinschen <vinschen@redhat.com>, stable@vger.kernel.org,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This is just a simple cleanup fix.  Commit 35a2443d0910f ("iavf: Add
waiting for response from PF in set mac") introduced a duplicate
ether_addr_equal() check, so the current code tests the new MAC twice
against the former MAC.

Remove the outer ether_addr_equal() test, remnant of commit c5c922b3e09b
("iavf: fix MAC address setting for VFs when filter is rejected")

Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
Fixes: 35a2443d0910f ("iavf: Add waiting for response from PF in set mac")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
Added CC: stable@vger.kernel.org

 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index a52c100dcbc5..9b8e7e4376c2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2579,13 +2579,11 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	case VIRTCHNL_OP_ADD_ETH_ADDR:
 		if (!v_retval)
 			iavf_mac_add_ok(adapter);
-		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr))
-			if (!ether_addr_equal(netdev->dev_addr,
-					      adapter->hw.mac.addr)) {
-				netif_addr_lock_bh(netdev);
-				eth_hw_addr_set(netdev, adapter->hw.mac.addr);
-				netif_addr_unlock_bh(netdev);
-			}
+		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr)) {
+			netif_addr_lock_bh(netdev);
+			eth_hw_addr_set(netdev, adapter->hw.mac.addr);
+			netif_addr_unlock_bh(netdev);
+		}
 		wake_up(&adapter->vc_waitqueue);
 		break;
 	case VIRTCHNL_OP_GET_STATS: {
-- 
2.53.0

