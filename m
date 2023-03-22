Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA57C6FD1C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Mar 2023 16:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B492080AD5;
	Wed, 22 Mar 2023 16:03:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B492080AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1679500987;
	bh=VuTDfqdLYTnE1p/NvmhjEQYy3bi4XuU+T/dBouWqYa4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=VqyC7ggQ+dE41OEAXwfj5kNt5KZAn4YAXNWbDHW1ZS0VAzwXO/OvwcG8GQBVznrgc
	 +UmM4ef6DDrc48cOLtSwMnHwV2ttVoZVIJZfb3Q39D1vPcQSqU2Jecx4WgxaOC5n+8
	 k4hQIr40f0kwGx5wrHizi/+tiilk6nI3QZ1loiO8xSxvNb6ftkYVRveFE8RcV/fqbV
	 SwXEqH+utDoO9zJ63ms+3V0/o+oFinUVn7yjkhv2G5Wos4KCJyJicf5c1E0g2FWItO
	 LyUtgS+7iI9DOgOKDMPAj8w7ao5nQv/8zWcIJw4rm7JQnTo7mBnxFaH/XBMbdbBPUu
	 GdSlwn51MGXRw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TVDtGlFU7I8Y; Wed, 22 Mar 2023 16:03:05 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0C3A8229A;
	Wed, 22 Mar 2023 16:03:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0C3A8229A
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 5A7491BF5A5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Mar 2023 16:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E57E417DD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Mar 2023 16:03:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E57E417DD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3_sokNbvZDOK for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Mar 2023 16:03:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F1C3417D8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F1C3417D8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Mar 2023 16:03:01 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-PysmsBezPACYGbiORGLfKg-1; Wed, 22 Mar 2023 12:01:40 -0400
X-MC-Unique: PysmsBezPACYGbiORGLfKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA97580C8C5;
 Wed, 22 Mar 2023 16:01:38 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DD9F40C6E68;
 Wed, 22 Mar 2023 16:01:38 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
 by firesoul.localdomain (Postfix) with ESMTP id A933F30736C72;
 Wed, 22 Mar 2023 17:01:37 +0100 (CET)
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: bpf@vger.kernel.org
Date: Wed, 22 Mar 2023 17:01:37 +0100
Message-ID: <167950089764.2796265.5969267586331535957.stgit@firesoul>
In-Reply-To: <167950085059.2796265.16405349421776056766.stgit@firesoul>
References: <167950085059.2796265.16405349421776056766.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1679500979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjoXfv22y8bGZIaFBiqJSnnyyPeBBhNiGzC+o+ftHU0=;
 b=MxzhvHg4jyM+UKtNWjrfA2Ou5eSLPq949oFzeUk1I9brIS0CCXO1s4inCI//7gzfC8wPv3
 bRA75Dnm4W6OarbMNoZW4bqVuuQ4wwyK8jORUnCXNG+z+RaU7+7R7Pzsvbl7XXjOVFpZJd
 UoXzpVbGDKFauC+TER42wwwhhFDra+U=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxzhvHg4
Subject: [Intel-wired-lan] [PATCH bpf-next V3 5/6] igc: add XDP hints kfuncs
 for RX timestamp
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
Cc: xdp-hints@xdp-project.net, martin.lau@kernel.org, daniel@iogearbox.net,
 larysa.zaremba@intel.com, netdev@vger.kernel.org, john.fastabend@gmail.com,
 ast@kernel.org, jesse.brandeburg@intel.com, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, Stanislav Fomichev <sdf@google.com>,
 yoong.siang.song@intel.com, Jesper Dangaard Brouer <brouer@redhat.com>,
 boon.leong.ong@intel.com, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, davem@davemloft.net, hawk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The NIC hardware RX timestamping mechanism adds an optional tailored
header before the MAC header containing packet reception time. Optional
depending on RX descriptor TSIP status bit (IGC_RXDADV_STAT_TSIP). In
case this bit is set driver does offset adjustments to packet data start
and extracts the timestamp.

The timestamp need to be extracted before invoking the XDP bpf_prog,
because this area just before the packet is also accessible by XDP via
data_meta context pointer (and helper bpf_xdp_adjust_meta). Thus, an XDP
bpf_prog can potentially overwrite this and corrupt data that we want to
extract with the new kfunc for reading the timestamp.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |    1 +
 drivers/net/ethernet/intel/igc/igc_main.c |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index bc67a52e47e8..29941734f1a1 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -503,6 +503,7 @@ struct igc_rx_buffer {
 struct igc_xdp_buff {
 	struct xdp_buff xdp;
 	union igc_adv_rx_desc *rx_desc;
+	ktime_t rx_ts; /* data indication bit IGC_RXDADV_STAT_TSIP */
 };
 
 struct igc_q_vector {
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index a78d7e6bcfd6..f66285c85444 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2539,6 +2539,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
 			timestamp = igc_ptp_rx_pktstamp(q_vector->adapter,
 							pktbuf);
+			ctx.rx_ts = timestamp;
 			pkt_offset = IGC_TS_HDR_LEN;
 			size -= IGC_TS_HDR_LEN;
 		}
@@ -2727,6 +2728,7 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 		if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
 			timestamp = igc_ptp_rx_pktstamp(q_vector->adapter,
 							bi->xdp->data);
+			ctx->rx_ts = timestamp;
 
 			bi->xdp->data += IGC_TS_HDR_LEN;
 
@@ -6481,6 +6483,23 @@ u32 igc_rd32(struct igc_hw *hw, u32 reg)
 	return value;
 }
 
+static int igc_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp)
+{
+	const struct igc_xdp_buff *ctx = (void *)_ctx;
+
+	if (igc_test_staterr(ctx->rx_desc, IGC_RXDADV_STAT_TSIP)) {
+		*timestamp = ctx->rx_ts;
+
+		return 0;
+	}
+
+	return -ENODATA;
+}
+
+const struct xdp_metadata_ops igc_xdp_metadata_ops = {
+	.xmo_rx_timestamp		= igc_xdp_rx_timestamp,
+};
+
 /**
  * igc_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -6554,6 +6573,7 @@ static int igc_probe(struct pci_dev *pdev,
 	hw->hw_addr = adapter->io_addr;
 
 	netdev->netdev_ops = &igc_netdev_ops;
+	netdev->xdp_metadata_ops = &igc_xdp_metadata_ops;
 	igc_ethtool_set_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
 


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
