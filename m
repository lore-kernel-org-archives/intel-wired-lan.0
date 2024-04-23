Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E96C10F15
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 Apr 2024 10:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3958481E17;
	Tue, 23 Apr 2024 10:24:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fSVSrGvFWAaZ; Tue, 23 Apr 2024 10:24:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 929A881E0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1713867896;
	bh=TlA1wYh3gUjJTOs9PplfnS/DRdE9om0csvqcDnlkLf8=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YWMXJjQnasdWE5/IBOPHFZSYn8rDsUtc30/BJK7UqMPkBVud7+fZeZKorBMZknbHD
	 /W7/FLhd/iHmoUYOiBLeHmBQwV4nQFFcY3Z1Ep+hh5qiNAsCWSc2FVA4QNPa99C/Ov
	 Cer2pIJMv4kOGnU3I6UOsP/jLbcg2C7pK02hpBD7Eei8WCo4tfDlu25UVKwGhaEV3D
	 0+s1tL3rpUGBo6dBu8g8ASbPQI+dTsMUQxf6QOKKJdEnxXZdyURDbfHCamo2sWszky
	 CtSHm8YZI0LUuMUGe2AFiiFCVHO9eKzZNLg7cbSd+SCB87wYkDmc6rIgXfxIByBz8D
	 0QIdGoZ/3nn/A==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 929A881E0C;
	Tue, 23 Apr 2024 10:24:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id CC1201BF2FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Apr 2024 10:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B600681E0C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Apr 2024 10:24:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id repoF_cSH5-O for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 Apr 2024 10:24:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=vinschen@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D615881E0B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D615881E0B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D615881E0B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Apr 2024 10:24:54 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-rsb7kCBkOvW8gIp_12clWw-1; Tue, 23 Apr 2024 06:24:48 -0400
X-MC-Unique: rsb7kCBkOvW8gIp_12clWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78E4E802E4D;
 Tue, 23 Apr 2024 10:24:48 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57AA944048;
 Tue, 23 Apr 2024 10:24:48 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 0A9ACA80BA0; Tue, 23 Apr 2024 12:24:47 +0200 (CEST)
From: Corinna Vinschen <vinschen@redhat.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Date: Tue, 23 Apr 2024 12:24:46 +0200
Message-ID: <20240423102446.901450-1-vinschen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1713867893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TlA1wYh3gUjJTOs9PplfnS/DRdE9om0csvqcDnlkLf8=;
 b=CJUnPwRRsE/hkirslcUlw8Z0YN5B2VSzPS0ZIgLjn4vsEIZs3jjvRgROixTwfoKskIUZzv
 I53bcUIyv9EPiHTFF2cllOCjQAR3jWzvLMV0PX/QOBSV9i/wu5dvflEiGBunbD/WnGrak8
 Es5IVUOfUhB8ejPpaPokOp3fQuvl3iM=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=CJUnPwRR
Subject: [Intel-wired-lan] [PATCH] igb: cope with large MAX_SKB_FRAGS.
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Paolo Abeni <pabeni@redhat.com>

Sabrina reports that the igb driver does not cope well with large
MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
corruption on TX.

The root cause of the issue is that the driver does not take into
account properly the (possibly large) shared info size when selecting
the ring layout, and will try to fit two packets inside the same 4K
page even when the 1st fraglist will trump over the 2nd head.

Address the issue forcing the driver to fit a single packet per page,
leaving there enough room to store the (currently) largest possible
skb_shared_info.

Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAG")
Reported-by: Jan Tluka <jtluka@redhat.com>
Reported-by: Jirka Hladky <jhladky@redhat.com>
Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Tested-by: Sabrina Dubroca <sd@queasysnail.net>
Tested-by: Corinna Vinschen <vinschen@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a3f100769e39..22fb2c322bca 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4833,6 +4833,7 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
 
 #if (PAGE_SIZE < 8192)
 	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
+	    SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2) ||
 	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
 		set_ring_uses_large_buffer(rx_ring);
 #endif
-- 
2.44.0

