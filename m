Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB52C4452A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 13:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79285606C8;
	Mon, 20 Jul 2026 13:58:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7u6cpLVxMFjn; Mon, 20 Jul 2026 13:58:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A506606B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784555936;
	bh=B+N+tI3fTlFvgqkGyWfTCEbLLuo0kNzByKg6eMoo7gc=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DO4/VFXn94xKfJ5jrBu5KQgR/J2kCxcgFI2k3tkgR7cvgL6nGttrOt8Vv0uvXgbt0
	 UA/9ei9M/PgOZqi7QOceqTpXUU4kEIYKMACdEMu1koy+Asp8/ANER/K9e8gn5NGkaQ
	 bwr538xg56IeBQLfgneJgJ53BU1sTFyAk5RDxEl6IKeVLQmiEdAzFGr6DNu/FiNyT5
	 WJ7VEXb+AA3x6g8x832SV64GCeLrVLOiOZ+54zm4y3OWH1gM/wr4hlN1ytGkWqS2MR
	 +oqRE6WmbbNVj2CSlrcrHi4Xq+aa9zs6cPXgI+bpzoV/OolvVbBgj3j87BdwBfCzah
	 01g/Ce2Zj6DSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A506606B4;
	Mon, 20 Jul 2026 13:58:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DE29F1F6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 13:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF72540621
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 13:58:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cLfl28fBoK6e for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 13:58:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com;
 envelope-from=mhun512@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 231874061F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 231874061F
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 231874061F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 13:58:54 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cc891373e0so124750255ad.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 06:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784555933; x=1785160733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B+N+tI3fTlFvgqkGyWfTCEbLLuo0kNzByKg6eMoo7gc=;
 b=bHzaFGvDBWG2spf4YWGj2JU2UaWd+dmgC2ZAhmS0268AC2tkzGIyzxRa6x9DyRfWaa
 awyUYxSmugesgstCo4yiXhzqxLrwsobaA0SaLiQGEuyDLcwOmRK1/ncyuFziVYYOmj5C
 qI81lRo27Io/LoDH0atA6J3uiQHtfZWOi6393Ozh9twM9oJaLv0Oju+u2XBtfC0PMik8
 n5D0ZrnZUTjnq9N/Ew+E/jxv2hK8qo8NS/MPi3HL7WPyaD2jNOJTyMiDFuAmZOvKdtiv
 v3IDu3fQVByCm+zKUNDo+lNt5uIooxpViFEc2dFrfXXmhaj33VHlqY0FC+PI+8KZlOgR
 uKjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcCFoh2v+e8WAledCHCTKzvd9m95N7QKWXUQgVgspC7VldE1Ct2wkpZHGXWGgBuNZnZpnqqY+ehezueKiFhAw=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyycggH+B4siEvy0KLrr4MyLvf3sVEEhF9WeKJrRNYQ0TzcXFAH
 BnU+CLpQpOvhdrRYic8gppObP+qxOvcFCSDMpyU9sBxJLll/Ar1NmEI=
X-Gm-Gg: AR+sD13JGyuX0cZBrLKEGKn/jn1cBTBchaF1inSu0S24kKe03DN+SSvFjjYqJk8W550
 L3yL5494veBFpiuu4FL3TUukqFMcw3pRufsykD7YncWsTP2y7H0lD+Bvaf1GAHVx0ce0y0MNzDK
 T61d/voxBraP39IdOdLEG4ueX6OSMLQCkS0/Xu5cSZvwjHeqpixxa5xO5JUtEp36FWgscVGZ6jg
 6LGDi8N13piUnuGLJN8iYsB86iYLkv7YZ6xbIZ0q3CrdL5o+O85llRrlAIXqYHcdyP3VwDieBnP
 H6v6gJcIaaf6j+wVZ62QagDqjYcY8tHHdmrfZ3TF48OaE8LiG3qS1lMHVULAq9gYIUloFyziQOv
 O/dJcLvtCQrUez0rGUvtR+7Rrsa4AmxIELDwfgv5f0cYsxTMJYRuX3w6xiUBkTlzNMRZmZMUCGs
 hVw28/5LoZWqRBVqRDjGUUog9g6KuxzPQz2qe53I6jyf2DQXk+KQCNoo9pmphZ8w015oUrGD7Xt
 TQveoVkQRpgBF+g+WC52G7cTuRBpFZZZk53vwfM
X-Received: by 2002:a17:902:f542:b0:2cc:741a:ff33 with SMTP id
 d9443c01a7336-2cf34a39f67mr150605265ad.43.1784555933163; 
 Mon, 20 Jul 2026 06:58:53 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf3448ee28sm57045415ad.11.2026.07.20.06.58.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Jul 2026 06:58:52 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Date: Mon, 20 Jul 2026 22:58:46 +0900
Message-ID: <20260720135846.76229-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784555933; x=1785160733; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B+N+tI3fTlFvgqkGyWfTCEbLLuo0kNzByKg6eMoo7gc=;
 b=g6xbSr6645mX5PvqjDMgPr1iishz+cs2TJhFvr+aSGLmEWVZo0dDMKzydfrC13pQ2m
 S0fo8S5aFYMgbp+7YXwR+IRPgxCW1k50gnMd0dyA56EeUEnvt+lgJir7KDrWNMn0PFHE
 hCyUybiM+iwWQOk04t6rWvUbD85wFs2UoawPKGvDIMuEkvyXaur41oWd8PCh8ntTNlMD
 MMEbiH/VMGmlKWciVVaneTDAcQ3cth3VjyBrR/e4/HpmMYc2ygKRHR0LkEefAzGQWiYz
 chAOipFcZcA2R8ru6YOp9OtLrABwSGKMyOEk+9CYhzQCihLN+9vTksos6MW1cqtPaYr/
 XG2A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=g6xbSr66
Subject: [Intel-wired-lan] [PATCH net] idpf: disable DIM work before freeing
 q_vectors
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

idpf never drains the Tx/Rx DIM works before freeing the memory they
live in.  tx_dim and rx_dim are embedded in struct idpf_q_vector, they
are queued from the NAPI poll via net_dim(), and idpf_vport_intr_rel()
ends with kfree(rsrc->q_vectors).  Nothing in the driver cancels them.

idpf_tx_dim_work() and idpf_rx_dim_work() then run on freed memory:
idpf_vport_intr_write_itr() writes the ITR register through
q_vector->intr_reg.tx_itr / rx_itr, void __iomem pointers loaded out of
the freed q_vector.  No configuration is needed to get there --
IDPF_ITR_IS_DYNAMIC() is defined as (itr_mode) and idpf_vport_alloc()
initialises both modes to IDPF_ITR_DYNAMIC.

Draining after idpf_vport_intr_napi_dis_all() is not enough on its own.
idpf_net_dim() is called from inside the
"if (napi_complete_done(napi, work_done))" branch of the poll, and
napi_complete_done() has already cleared NAPIF_STATE_SCHED by then.
napi_disable_locked() waits only while (val & (NAPIF_STATE_SCHED |
NAPIF_STATE_NPSVC)), so napi_disable() can return while the poll tail is
still queueing the work, and a plain cancel_work_sync() would be
re-armed behind the drain.

Use disable_work_sync(): schedule_work() on a work with a non-zero
disable count is dropped by clear_pending_if_disabled() before
__queue_work() is reached.

Move idpf_init_dim() to idpf_vport_intr_alloc() so the works are
initialised on every path that can reach the drain -- the three
"goto intr_deinit" sites between idpf_vport_intr_init() and
idpf_vport_intr_ena() get there without the enable side having run.
Nothing re-enables them: rsrc->q_vectors is freed on every exit from
idpf_vport_open() and on every idpf_vport_stop(), so the count dies with
the object.

It is a race, not a deterministic failure -- net_dim() only schedules
once DIM_NEVENTS events have accumulated and the profile index changes.
A KASAN ifup/ifdown loop under load is the way to see it.

Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.9
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Found by static analysis; not tested on hardware.  Testing by someone at
Intel with an idpf device would be very welcome.

disable_work_sync() landed in v6.10, which is newer than the commits
this fixes, hence the annotation on the stable tag.  A backport to older
trees needs the work held down another way rather than a cherry-pick;
happy to send one if the bot reports a failure.

libwx does the same thing in the same order -- napi_disable() then
disable_work_sync() on the dim works -- in wx_napi_disable_all().

Based on v7.2-rc2.

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 7f9056404f64..cd98674fb648 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4148,6 +4148,26 @@ static void idpf_vport_intr_ena_irq_all(struct idpf_vport *vport,
 	writel(rsrc->noirq_dyn_ctl_ena, rsrc->noirq_dyn_ctl);
 }

+/**
+ * idpf_vport_intr_dis_dim_all - Disable DIM work for all q_vectors
+ * @rsrc: pointer to queue and vector resources
+ *
+ * The DIM works are embedded in the q_vector array that
+ * idpf_vport_intr_rel() frees, and the poll arms them after
+ * napi_complete_done() has already cleared NAPI_STATE_SCHED.  Disable
+ * rather than just cancel, so that a poll tail still running past
+ * napi_disable() cannot queue them again behind the drain.
+ */
+static void idpf_vport_intr_dis_dim_all(struct idpf_q_vec_rsrc *rsrc)
+{
+	for (u16 v_idx = 0; v_idx < rsrc->num_q_vectors; v_idx++) {
+		struct idpf_q_vector *q_vector = &rsrc->q_vectors[v_idx];
+
+		disable_work_sync(&q_vector->tx_dim.work);
+		disable_work_sync(&q_vector->rx_dim.work);
+	}
+}
+
 /**
  * idpf_vport_intr_deinit - Release all vector associations for the vport
  * @vport: main vport structure
@@ -4158,6 +4178,7 @@ void idpf_vport_intr_deinit(struct idpf_vport *vport,
 {
 	idpf_vport_intr_dis_irq_all(rsrc);
 	idpf_vport_intr_napi_dis_all(rsrc);
+	idpf_vport_intr_dis_dim_all(rsrc);
 	idpf_vport_intr_napi_del_all(rsrc);
 	idpf_vport_intr_rel_irq(vport, rsrc);
 }
@@ -4238,7 +4259,6 @@ static void idpf_vport_intr_napi_ena_all(struct idpf_q_vec_rsrc *rsrc)
 	for (u16 q_idx = 0; q_idx < rsrc->num_q_vectors; q_idx++) {
 		struct idpf_q_vector *q_vector = &rsrc->q_vectors[q_idx];

-		idpf_init_dim(q_vector);
 		napi_enable(&q_vector->napi);
 	}
 }
@@ -4581,6 +4601,8 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport,
 		q_coal = &user_config->q_coalesce[v_idx];
 		q_vector->vport = vport;

+		idpf_init_dim(q_vector);
+
 		q_vector->tx_itr_value = q_coal->tx_coalesce_usecs;
 		q_vector->tx_intr_mode = q_coal->tx_intr_mode;
 		q_vector->tx_itr_idx = VIRTCHNL2_ITR_IDX_1;
--
2.43.0
