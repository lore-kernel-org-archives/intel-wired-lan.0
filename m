Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFCEC5DF87
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Aug 2026 02:02:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10B214086E;
	Fri, 21 Aug 2026 02:02:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TadChdW_dPuX; Fri, 21 Aug 2026 02:02:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787277729;
	bh=YaQXJFOgTuo8flU80GkUBch35PbtffmnKkNWXz5stGg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=4+h+REBt6Vw+rePHYaXmqFIzqGA4/sQP4ok5HSvj+n04ql5sM5VZ4v1WAxHyKZisy
	 trNYwt3P+/TZ90tlcc+AqaEt1xC12czyuHE0kCEpakb5ENdulXpwn+gZQp+pcIwG0q
	 piMlobBifqZLO+ll7C99maqXxHPnhwEfWAl692TGa5EylOtH0eIZ+kZhGACdgCZ3q0
	 OPyRA/+DuPmhk0dPoylBcldl7GH8lgHADuSZMp2HbY2gH19oxiArqxr59KADY3Qc1o
	 dVknsr+Bl2glnoVlkOwFq+ieKpWPFSHTOzvkl+UlaPwXjvspOIHH1Th/0FoeiibGXx
	 I62i8g7uoYiGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E01740840;
	Fri, 21 Aug 2026 02:02:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 018881B8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 02:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D378340840
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 02:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MmqFWlSNCDxj for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Aug 2026 02:02:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kq/5C6jF
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1834D4083E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 02:02:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3CCEC60A58;
 Fri, 21 Aug 2026 02:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F181F000E9;
 Fri, 21 Aug 2026 02:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787277724;
 bh=YaQXJFOgTuo8flU80GkUBch35PbtffmnKkNWXz5stGg=;
 h=From:To:Cc:Subject:Date;
 b=kq/5C6jFp0meV1PcWnp2RW0xHccmkAgDp5nUO5Pk5JTOaTF9CHfYnad2luB8eih2X
 RVWclynkl+MELPpp7pcrohpqr2Ixj5f+S3yLkNytNUfx408pS+MxnhT7wI/A4vlUGZ
 qpqrn3KX2IEoz5ApMcVTmuKHTjs0iCYTAyIMVKkCmFOLscoCl/TojCD146QhovzMAw
 P1u7yU90PAgPvS8bGxxUeeMQnyqHN069tq7W9wwr9Kj00iDEbCtU73O24tHVM7Ti/r
 +sBs7EdBqYxVylRIIh11ovLDcVdcQ+Sp7BPLnoCv8pWQXlKhD6R5/Y8ndreUpZipSq
 +P0ncHbqVAJYw==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 przemyslaw.kitszel@intel.com, jbrandeb@kernel.org,
 benjamin.h.shelton@intel.com
Subject: [PATCH iwl] eth: ice: don't dereference pointers from TP_printk()
Date: Thu, 20 Aug 2026 19:02:01 -0700
Message-ID: <20260821020201.1337338-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

After forwarding net-next during the v7.3 merge window we started
seeing:

  TRACE EVENT ERROR: Event ice_tx_dim_work has double dereference in TP_printk: REC->q_vector->tx.tx_ring->q_index
  WARNING: kernel/trace/trace_events.c:420 at test_double_dereference.cold+0x39/0x4b

this is due to extra checks added in tracing subsystem in
commit b5cc230af5e5 ("tracing: Warn when an event dereferences a pointer in TP_printk()").

Printing happens long after the event was recorded, by which point
the pointers may be invalid (the ring or the dim instance).
Copy the eight scalars into the event instead.

Fixes: 3089cf6d3caa ("ice: add tracepoints")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: anthony.l.nguyen@intel.com
CC: przemyslaw.kitszel@intel.com
CC: jbrandeb@kernel.org
CC: benjamin.h.shelton@intel.com
---
 drivers/net/ethernet/intel/ice/ice_trace.h | 64 ++++++++++++++--------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h b/drivers/net/ethernet/intel/ice/ice_trace.h
index 4f35ef8d6b29..7568c917cdbe 100644
--- a/drivers/net/ethernet/intel/ice/ice_trace.h
+++ b/drivers/net/ethernet/intel/ice/ice_trace.h
@@ -63,23 +63,33 @@
 DECLARE_EVENT_CLASS(ice_rx_dim_template,
 		    TP_PROTO(struct ice_q_vector *q_vector, struct dim *dim),
 		    TP_ARGS(q_vector, dim),
-		    TP_STRUCT__entry(__field(struct ice_q_vector *, q_vector)
-				     __field(struct dim *, dim)
+		    TP_STRUCT__entry(__field(u16, q_index)
+				     __field(u8, state)
+				     __field(u8, profile_ix)
+				     __field(u8, tune_state)
+				     __field(u8, steps_right)
+				     __field(u8, steps_left)
+				     __field(u8, tired)
 				     __string(devname, q_vector->rx.rx_ring->netdev->name)),
 
-		    TP_fast_assign(__entry->q_vector = q_vector;
-				   __entry->dim = dim;
+		    TP_fast_assign(__entry->q_index = q_vector->rx.rx_ring->q_index;
+				   __entry->state = dim->state;
+				   __entry->profile_ix = dim->profile_ix;
+				   __entry->tune_state = dim->tune_state;
+				   __entry->steps_right = dim->steps_right;
+				   __entry->steps_left = dim->steps_left;
+				   __entry->tired = dim->tired;
 				   __assign_str(devname);),
 
 		    TP_printk("netdev: %s Rx-Q: %d dim-state: %d dim-profile: %d dim-tune: %d dim-st-right: %d dim-st-left: %d dim-tired: %d",
 			      __get_str(devname),
-			      __entry->q_vector->rx.rx_ring->q_index,
-			      __entry->dim->state,
-			      __entry->dim->profile_ix,
-			      __entry->dim->tune_state,
-			      __entry->dim->steps_right,
-			      __entry->dim->steps_left,
-			      __entry->dim->tired)
+			      __entry->q_index,
+			      __entry->state,
+			      __entry->profile_ix,
+			      __entry->tune_state,
+			      __entry->steps_right,
+			      __entry->steps_left,
+			      __entry->tired)
 );
 
 DEFINE_EVENT(ice_rx_dim_template, ice_rx_dim_work,
@@ -90,23 +100,33 @@ DEFINE_EVENT(ice_rx_dim_template, ice_rx_dim_work,
 DECLARE_EVENT_CLASS(ice_tx_dim_template,
 		    TP_PROTO(struct ice_q_vector *q_vector, struct dim *dim),
 		    TP_ARGS(q_vector, dim),
-		    TP_STRUCT__entry(__field(struct ice_q_vector *, q_vector)
-				     __field(struct dim *, dim)
+		    TP_STRUCT__entry(__field(u16, q_index)
+				     __field(u8, state)
+				     __field(u8, profile_ix)
+				     __field(u8, tune_state)
+				     __field(u8, steps_right)
+				     __field(u8, steps_left)
+				     __field(u8, tired)
 				     __string(devname, q_vector->tx.tx_ring->netdev->name)),
 
-		    TP_fast_assign(__entry->q_vector = q_vector;
-				   __entry->dim = dim;
+		    TP_fast_assign(__entry->q_index = q_vector->tx.tx_ring->q_index;
+				   __entry->state = dim->state;
+				   __entry->profile_ix = dim->profile_ix;
+				   __entry->tune_state = dim->tune_state;
+				   __entry->steps_right = dim->steps_right;
+				   __entry->steps_left = dim->steps_left;
+				   __entry->tired = dim->tired;
 				   __assign_str(devname);),
 
 		    TP_printk("netdev: %s Tx-Q: %d dim-state: %d dim-profile: %d dim-tune: %d dim-st-right: %d dim-st-left: %d dim-tired: %d",
 			      __get_str(devname),
-			      __entry->q_vector->tx.tx_ring->q_index,
-			      __entry->dim->state,
-			      __entry->dim->profile_ix,
-			      __entry->dim->tune_state,
-			      __entry->dim->steps_right,
-			      __entry->dim->steps_left,
-			      __entry->dim->tired)
+			      __entry->q_index,
+			      __entry->state,
+			      __entry->profile_ix,
+			      __entry->tune_state,
+			      __entry->steps_right,
+			      __entry->steps_left,
+			      __entry->tired)
 );
 
 DEFINE_EVENT(ice_tx_dim_template, ice_tx_dim_work,
-- 
2.55.0

