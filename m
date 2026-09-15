Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F4EC88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD0D980D8A;
	Tue, 15 Sep 2026 17:18:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gPmWlI8N_g6C; Tue, 15 Sep 2026 17:18:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 097B180D8D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492690;
	b=LldbD3GjlujACcpldu1gfmeHhJKrJVR/2cR4wG858aJwfVFoFlN2QBA9AjlvSXQ7z9JX
	 cKmbEQQqM/YPxNEJ4AWCJp6+c/efliOYGOwYA1JDmb705Btq96yzxMGTpXVLUP4HNDePe
	 PAB324shkKYhZbADtVhB3us4+au2DAFqxDsml85os9C3nS1G3tSmzlRVdOhnaNAa222gv
	 x/O0fBmmYYr9xc6ZHPAzUGpFqWlroWjbYLM/HJIuqr/hivpA6iRCwSWfoDJ/fWz3Jo5W8
	 DAelbXeRSkS8SDxR1tKhrVTR+d0mphlZ5CzdiLBhCfhIa83cnGDEs0u4DSJ87J0/oLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492690;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=owXpxkdaiz3FjoIP3af9pZnf5S2SeMbdOA3eIgSOhpI=;
	b=KHcjgCnmXQo9RIZBIbGPsbi33j3VkffoNczJTSUUEdMZRRJ/AHlkxUCFU8U5/3wlRK5x
	 fSGSzIscbM/T07+WMoZtgsZ3KNU6Xln9YdMiopm6/o1muitOMcoRMAKmk2Hs25V0jlXZe
	 v7X/lTzIa3F+Lswke9StD01iycdcjS7F+W3pfJmX1wyQNVNhvtGJPbGC+v/OSemjyiGZY
	 yl4/sTogJ+L+T7DTsN34eqWw03ALQjzZJ4wb3XDkm25ftW7R07p2oiJjkcJeyJQTQXiTc
	 TXJzKz4HZSGVnANCISL7z1ZTtGqwFkFn/82NgeEUcIKXyAmxHrEb6NfKdrwTIfedNJg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=END5wxQg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492690;
	bh=owXpxkdaiz3FjoIP3af9pZnf5S2SeMbdOA3eIgSOhpI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Cih/CpuQsFEHc5RTmAAYQG/imaVg8vCDJOhZqM1A8ZMkA/98x65EHaIpwqMlcgZ6v
	 gCOTYklhKqcPu1p/n7H8dm2i/475295tJ1wYmUw3HHYxBNlsZRsNWHyY2KQTIEfqfX
	 GdHPPn14UkYNDP3MLR14NwPXn1SQTw7ZWlONQNuCD2+W+tJt/HJwLatNnu5QTcbCbD
	 YLDuIwdjVaV4n6Ce6yTCVPEf4+RE0t2oBKwQtbSm4jRR60KhtjoUxRQSLRiLosGU1L
	 DGgwrOEzYKKk/Xu7sBhZ+Yn5PcCLsipWcvgrnNYT9E/o5DKclgXDFpZA92G94d6LWN
	 1v+KN0Zs/Rk8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 097B180D8D;
	Tue, 15 Sep 2026 17:18:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 621B5362
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 11:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F27D80CC3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 11:59:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bgn8f_AQdk2h for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 11:59:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1F9A380C74
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789473594;
 b=IToiI+hw6Fy13Kw2O0jUI8L4NY+lFUq83l01P7T6zCzQkiKkAx8HSDWcqBXdB9EHcgdi
 HUoWLX1TsEVcKC0DI5tNhCHOQyDnPIdJBuPxGt5v9uNRqXmoNdnIi9GYvO/T8m1u+oMeC
 teRozc14DZ6DXGJyTlrfttMleKPg5YsD5vHXshXOaymTuQpCeFcWIWmSntqFFi1qMV/Kx
 rK5Z0cvUCf0rNzyK3FEua1l/KlHzeSTps+bHz5+DdIGquPsadnQSaQ6O8cVecTj3bi0t7
 R4b0qxkVHStX2C/D5YmpxhruciOD/AOv1bG6azHOAzpg3KFXbaNs725bqxAQyuw1BNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789473594;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
 X-Mimecast-Originator:Content-Transfer-Encoding:content-type;
 bh=owXpxkdaiz3FjoIP3af9pZnf5S2SeMbdOA3eIgSOhpI=;
 b=feh22tJ80UjygmNkQpgtrSZHISIFBnE9XBkulIxLQJef69QFd7WVZaUrKMMTZTIeMx0p
 vmkw9+1PFtjoVJhCzdVdaNFF++PddgN2QKOuEwCkAF07aA0gofTVGmOwy9OsDf8hgeGoI
 SAr/bdReGkNVVr+P3d5mHRp75wW2lpicdbaGm1kTO8Cw9UCRYI8joXUq437cHLhdyPBcB
 1BWebFp8D2bw1DOnIqwvMvK3YQ+mEquZAuOFWmzDMAetEYXwWZkCLp4YHEtjoG/zEHRWr
 tY2e4rFvaekNuvkADyuVJ9qgHl+cXEAxH0+qGOkAufjr1KEw66Ys7lD3MfYzyys0qoA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=END5wxQg; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=fballuch@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=END5wxQg
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F9A380C74
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 11:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789473591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=owXpxkdaiz3FjoIP3af9pZnf5S2SeMbdOA3eIgSOhpI=;
 b=END5wxQgpq6VVC9JOz64XlX7xGqNy4175cyD/uEsa6UUK2SP7whbG9H5xf/5kbcbCc1jWB
 +0/5LpIOrOC7oa9eMMdEF6tsvuwHmsHLLqnHdxRqynU/tAwS1XbLKmt2GOP9DiZUko3N8H
 pUbZgHRnBC00Rb5bdCzHZO9f8Dxz0F8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-w7d3T18TPyOItpXF1_D_bA-1; Tue,
 15 Sep 2026 07:59:48 -0400
X-MC-Unique: w7d3T18TPyOItpXF1_D_bA-1
X-Mimecast-MFC-AGG-ID: w7d3T18TPyOItpXF1_D_bA_1789473586
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 586601944B32; Tue, 15 Sep 2026 11:59:46 +0000 (UTC)
Received: from fballuch-thinkpadx1carbongen13.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B59D1956045; Tue, 15 Sep 2026 11:59:43 +0000 (UTC)
From: Filip Balluch <fballuch@redhat.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Filip Balluch <fballuch@redhat.com>
Subject: [PATCH] i40e: fix freeing of TX rings on RX allocation failure
Date: Tue, 15 Sep 2026 13:59:39 +0200
Message-ID: <20260915115939.56716-1-fballuch@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: wJgA62KtGG5h_XLUmeomovptkdh-a-IKAyTmsv2Iat0_1789473586
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

