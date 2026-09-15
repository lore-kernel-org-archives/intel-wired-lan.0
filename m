Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB570C982C1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A4E480AD5;
	Tue, 15 Sep 2026 17:18:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zky012FM6Miu; Tue, 15 Sep 2026 17:18:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BD82280D1F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492691;
	b=deYcsYgWxFVcZh9eLU/Mvmu4z5KjMOBgZqKc0ZWWnnd7mFBCsdmrtpoEpStaQl8vmRT5
	 YpeL34CyybLsNkVSl6v5wSZwpP6A1Io5BODU2cxvhDVfKh5JkzHkbP2+bK4J1gpy2WqVu
	 /aertz9wfrgwmIStAODaHCWhHzZpoojAPYVDUiOdP7EwvKXhM1XDGeUiX/9Ed0yWyup+b
	 Lssm0tCdUdqO5H4+A5HcsUwrRs7ZBk+GLy4YZbYnk57WvA+oFQRBMMNzbaM87cGAkkFMo
	 NT869KxB/ZusCf4b8lCgd+ruzZN/DmpNXocpeWwtQ+jVXWjH4a3+NNGFqY8mNzcm55A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492691;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=owXpxkdaiz3FjoIP3af9pZnf5S2SeMbdOA3eIgSOhpI=;
	b=d/wG7wu6U/Iz0vbubuTwuPOBrbwiNJVgocqs3VkgqfQP03rI482bG5pSYhyttXMuTXm6
	 wHnDYtK1O/jZfh+3CMQ8Hud0+trtMjh1whvf89/qZerfdGZ5A4o7sicPk5+SOsCvdT8gD
	 PONxSFizGIamR1VmfrHjAfHl93aujtvTSnF56icZX0W/W+4OL+mIHLEfX+736yWUyQqss
	 Ro4qFjrK/Z4Ei7GsCGiRY8rl0llQf8RyR1ieRaZTZbtdv3kA8BtkvakAnawJ6z6Kw9qn9
	 cVjlTtJEtbFwzNg/Ymijz5qSbbxlWheFj6+P9XoEMtq51ynSs4mdiizUk+5Q6yLyrOg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492691;
	bh=owXpxkdaiz3FjoIP3af9pZnf5S2SeMbdOA3eIgSOhpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=li0ZM7zm/Qq5VKq4uK8kS7+HPLLK+ICGmAWYKYU5MXtf8LLGFX1ukuo3zEcU9kwBj
	 FuobovlAHXgKj8DpvujCE5J6OW9yS7h1r6OSqeuIMViAMZO+VZ3L9uAS3vmRK9SMsz
	 xpPoTHtERw4TxMoTbVDV/zVtbfhsTJIV06Rjd1gC7c6bbGUeVLxgItUc3B2D0CGNER
	 THdluUEp9pXpCFtFwzvU26sLG4sIibYc/rGOirmbdfbxRYSDHIT1b4uP5z1GkGihj9
	 rM2aFNlB12c2J4DXEEH8sv607LY/fGXz3Wpu+jASKew2JTEwAV77udHJBMNkyLS8uK
	 xK7nsY5YGVa4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD82280D1F;
	Tue, 15 Sep 2026 17:18:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A88E259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF8CC60760
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:27:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f4yXIigBRmh6 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:27:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3C1CE605D7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789475220;
 b=QLTVt3d8wqAqNyuUfSgXZdv+0YeodLhEzjGm5hUIWebgbapp5qJK/XAGeKvdOUIDu+Jy
 PL9lh7KT4KT8WTq+g7nGKt8r+aQjNCIFEy4guHn1abhjgExMbHMeNknNhBGCwqHMJ45ov
 NaZMEFMmQBVzDI6ylCS6EhqfKxu/lMlSoK0TEnsZzlRHdoX9SVlDEZaxSvpsZXv/+JqbL
 XCfduSCJxeVALWhplPP2npJcww2n9a8Gbnq6xF79x1OsMpcHC2o+KUXBrE3IEXcr1NWao
 hE8ul4AG9cqA431OMvE2J1YbtA+qO1UHCml09ilgeqW0XUqMwaJAs5d81ncrpkPFYgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789475220;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=owXpxkdaiz3FjoIP3af9pZnf5S2SeMbdOA3eIgSOhpI=;
 b=r+bmfcRr1HtTOEkV1ffj1DJaJLqI2DsjAcqvtTZy2tAfBvdVYjzY0u5Wl0SfsDASV5eB
 64seofb1HdBV1W6SY9AgTvTVoEVvEUI75J6RD+K/ZW3IlpoyPcpN18Ib++G4oyThxchvh
 lbID5IBjI7ARzFmROK+SWOW4Mz8PpPxgw5QJR59ZVB9ZbI9s6VWwy4Db9qUMhANN7mWEg
 7Jna0/UaJqO7EJaaew27CRcfY0bHlIdaFpu1ayygxyjAvrns1ntvDK/SozkqYEM4kCDx2
 YPcU/D9ec5VoXEJITnfnXErJctjdAtO78MEhgMCFZXxjdCjygDy6Lhso7wmN9c4R81g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="Mhyi/hZ5"; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=fballuch@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mhyi/hZ5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C1CE605D7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789475218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=owXpxkdaiz3FjoIP3af9pZnf5S2SeMbdOA3eIgSOhpI=;
 b=Mhyi/hZ5IhrE+zFLyinK7uyi/UkxLa0WHNP5CGlLLYgFcOS3babAzL+YQmkieQsgirmkrO
 QvQIGEB2jP9SARxymgaFl3D8fVaUn0XUiE5exbsyXlMcbW5hBZRsXzFiTJDvNHDfNWt51D
 fa2r4EgGk5ko8d6yyrZzz5AjpmQgG7A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-AOyTse_KPj22WjctNb7Zzw-1; Tue,
 15 Sep 2026 08:26:55 -0400
X-MC-Unique: AOyTse_KPj22WjctNb7Zzw-1
X-Mimecast-MFC-AGG-ID: AOyTse_KPj22WjctNb7Zzw_1789475213
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5099185FDA2; Tue, 15 Sep 2026 12:26:53 +0000 (UTC)
Received: from fballuch-thinkpadx1carbongen13.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C73D93003EEE; Tue, 15 Sep 2026 12:26:50 +0000 (UTC)
From: Filip Balluch <fballuch@redhat.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Filip Balluch <fballuch@redhat.com>
Subject: [PATCH] i40e: fix freeing of TX rings on RX allocation failure
Date: Tue, 15 Sep 2026 14:26:39 +0200
Message-ID: <20260915122639.64936-2-fballuch@redhat.com>
In-Reply-To: <20260915122639.64936-1-fballuch@redhat.com>
References: <20260915122639.64936-1-fballuch@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 6todbTis_tbITOoXZ8L5pq_wxs0_xJvPpSz6T8Q7FYQ_1789475213
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Tue, 15 Sep 2026 17:17:36 +0000
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
Errors-To: intel-wired-lan-bounces@osuosl.org

When ethtool -G is used to change ring buffer sizes while the interface is up, i40e_set_ringparam()
allocates temporary TX and RX rings. If the RX ring allocation fails, the error path at the
free_tx label incorrectly calls i40e_free_tx_resources(vsi->tx_rings[i]), freeing the live TX rings
instead of the temporary tx_rings[i].

Since the interface is still up, the next TX completion interrupt causes i40e_clean_tx_irq() to dereference
the freed ring descriptors, resulting in a NULL pointer dereference in IRQ context and a kernel panic.

This can be reproduced on systems with Intel X710 NICs under memory pressure, where
the second port's DMA allocation fails after the first port succeeds.

Fix by freeing the temporary tx_rings[i] in the error path instead of
the live vsi->tx_rings[i].

Signed-off-by: Filip Balluch <fballuch@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 3da9ec49cc74..6d2b076049f7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2249,7 +2249,7 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	if (tx_rings) {
 		for (i = 0; i < tx_alloc_queue_pairs; i++) {
 			if (i40e_active_tx_ring_index(vsi, i))
-				i40e_free_tx_resources(vsi->tx_rings[i]);
+				i40e_free_tx_resources(&tx_rings[i]);
 		}
 		kfree(tx_rings);
 		tx_rings = NULL;
-- 
2.55.0

