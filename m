Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C952CA9EBB
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D80F081491;
	Fri,  9 Oct 2026 21:43:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 74Irb5hGgTu5; Fri,  9 Oct 2026 21:43:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D720B812A7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791582213;
	b=GpLaEpU/0nGcGfM+3g17EC0uLGgswwrpdyDsWBEl0yQVHECSD3gyGC4nAxnCkgxVqf3e
	 rAf7+A7TOIB/i2lF8iqpt6TtN9Src0z3j7xdfeRNJuwpOymtrPYCuSN5PoWjbWrFps4os
	 RapFrs2qvzP9UaTcbgpLxU5RSv83NjzYpNBCp4WaCn5Uw84Ovrdamo0ZpNpCs/m8o8W0H
	 9jKttplamdymTURg/L5442HD/FjjLpDZoF1N3I53bKKC0j5C4C952SrZz/+OLPJLatqum
	 l/TzSM9TFDA3x1luGI5S3qEUFXzzQkItZfxO/IIKPJa/O5a+Lv0kqnomhyl9cqdqPLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791582213;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7OUVn6Ofw2Q1QjPDeDBa6yKAsYT3dGGmFoqb5a28lag=;
	b=KdsskwgraF6l9Tvz5jhUEPsMmzFCawWlhr2d/Djacj0NKO1LZwNlq0TJCZ/zDOucONb8
	 ne+8Dn9RUox/a/PwuLM5x0cUNWHeCMZZxMJRuk6pK0+saDjc6PVc4OeWDFGrROutV8gER
	 2U0C+WFvayxcyCDqOWpWfXyf1vTm4jiEB6TW0iW0xli/vxsjg7UiCBjQhnj0PbZkMhj8h
	 ls1E+hEiLobbK71oSSjdQGshAUV6evninG0TaKOa9ctOPRPnxCs+YbOH/xffsNBy6U8Qe
	 VraZZ3NYEX72vBTJuxwBb880sKaJ5eS+EkSrH/FYmoSdSCqcAvJndupbDDHkdC9wEDA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NVSqdC4h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791582213;
	bh=7OUVn6Ofw2Q1QjPDeDBa6yKAsYT3dGGmFoqb5a28lag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ghmgye5SCxOuwdZ3yeZegPxSebbLaAc/cTpHKsv5XA9ovaxNdxivt8xQleBHkt6OI
	 YGNZucyvWUsiR9L2gluG9MLkfdAGDJjoq7SvoHKwzST+tFjI/Aa3rDVPTmQHWGIJi1
	 YBc+oGPgFsrYexOuie4P8fUM2P5ZUnQpH3E8/IvBqbY8u5lt4kYURhsYGnyKsfQcrY
	 KTeMtNtzdHIpis986SIPer/v9f7wXtJj6XFbh4F470Af0JxmlTsaY+nl9EQHcqY0gy
	 bjWCjyHApHlv5Ul5NWxp6SMttvH7yu6SHxrueb3DtIfYOkU8Aqh2vIsat/KW3l0SGi
	 0QkZQ0d/ey8lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D720B812A7;
	Fri,  9 Oct 2026 21:43:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDF40184
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3F39812AB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:43:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QTm4pl_hQrLf for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:43:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B9D95812A7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791582210;
 b=KHbIQPbzbJF3qEjL0C/kPKHKHRqkXhdQuLJBcnUOKjCbioP34lfOvx/F5sJjWebwpVEV
 8qSpIQvC0UCaOtCPwpio0Av78kJ/ej0IPHa4cCo9+NIBFIPai6+smlfhyTtP6Izf3pZRu
 5on36/P+hckpPnUpz1dN/TYdWjEGoP1o1d4KBcheP+IvbeURUMhUXBODk89e5eAbTiXej
 7mzRiDhLWS0waQz2PcCBI0b7J6sqi2EqbTYvsN6FTxMHSk70NmOVWSwynEb2YX/59gqJk
 ycYBflWL5PbYaXMcRyDSejB+Vdgmo25YgM21s83YaUp49YE3dvPtXNhNIhKjrV9wZFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791582210;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=7OUVn6Ofw2Q1QjPDeDBa6yKAsYT3dGGmFoqb5a28lag=;
 b=ADSzn5Andq2+/hlj/D2Yb/hXK3YMYS8XT15DB9G+A66wtWycRyC2yBzefDWCDcyVHJUD
 34Q2sYTKCyyBCtQCYB9WVmWRXdLtueXO/ItVCytg57wcxHMjW0lYTdsjKNx7a/7Ld41ae
 KK0Ezr6ib6iDALrgYq8bzPiX6vgPXVgvJzA+bhFOyLwrpkyG2oXVHzixSfSv8anYlwOpl
 N5+okVt3uypYtfItGhR9zbTW0C8aSDmTMc39qMVWi7foa4BY86jGyjsK5glqXlVffV3kr
 ex923D2TFtL6IUbVZfzBYqgrUiNxEJ31yAA76IkZhQu1ikOs6IuWGHjR7iFIeJ9Fi7Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NVSqdC4h; 
 arc=none smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NVSqdC4h
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9D95812A7
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791582211; x=1823118211;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YWjHk4SXpw8oB7PQmH9+yg6GcRI7rg9FfzK2ACp265Y=;
 b=NVSqdC4h3tsSHOVrXiTc3Tek5W63LPTUOjszeGLEJrmEkQJoBBmeH2h8
 FFsDRheVmAKQglfzVnPXwb9fNCanyBNBqwJe5AhO+BGrTTstqwVXQO8ke
 GY648XKzLdNZQztyXW0WpH+JtwpEpdNQ/bOnf3wHBQK49+jah+r9ipVCh
 qQJwnAjQbrIFHApPsvrM1IKHjOB+COgqXHYPU+xSZcbsgPr4X56RmUlm1
 ls5i22KwJCHo4ESbYqbVYeCgft0EI0jmi9XkTp+LAHv3FuandDc3VE3+N
 orTom5Dfz+39mxkn2dxVnXftOW3JXGRABSM4hhp8sS5B0H5m38ocKRpbl g==;
X-CSE-ConnectionGUID: EedHROutRPKKOuixzDydNA==
X-CSE-MsgGUID: 3tMtoRskTpaH6DohFeWYLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="381507"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="381507"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 14:43:29 -0700
X-CSE-ConnectionGUID: E6k94X20RC2Sm8zrTR0bTA==
X-CSE-MsgGUID: N5td6YnvRoiwqJVfLjItwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="366985"
Received: from coyote-pass-p6-34563.jf.intel.com ([10.166.80.105])
 by orviesa001.jf.intel.com with ESMTP; 09 Oct 2026 14:43:29 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: milena.olech@intel.com, konstantin.ilichev@intel.com,
 joshua.a.hay@intel.com, namangulati@google.com, decot@google.com,
 madhu.chittim@intel.com
Subject: [PATCH iwl-net 1/2] idpf: fix use-after-free in the PTP auxiliary
 worker
Date: Fri,  9 Oct 2026 14:25:36 -0700
Message-Id: <20261009212537.3996-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20261009212537.3996-1-emil.s.tantilov@intel.com>
References: <20261009212537.3996-1-emil.s.tantilov@intel.com>
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

idpf_ptp_update_cached_phctime() runs from the PTP auxiliary worker and
walks the Rx queues of every vport to refresh rxq->cached_phc_time. There
is a small window on down that can result in use-after-free, detected by
KASAN:

  BUG: KASAN: slab-use-after-free in idpf_ptp_update_cached_phctime+0x367/0x4a0 [idpf]
  Write of size 8 at addr ff11002146c2a4a0 by task ptp3/8084
  ...
  idpf_ptp_update_cached_phctime+0x367/0x4a0 [idpf]
  idpf_ptp_do_aux_work+0x37/0x50 [idpf]
  ptp_aux_kworker+0x64/0xd0
  kthread_worker_fn+0x289/0xa20
  ...
  Allocated by task 8615 on cpu 5 at 812.655509s:
  idpf_vport_queues_alloc+0x9e5/0x2580 [idpf]
  idpf_vport_open.constprop.0+0x12c/0x10f0 [idpf]
  idpf_open+0x1bb/0x230 [idpf]
  __dev_open+0x2f5/0x7c0
  ...
  Freed by task 8628 on cpu 10 at 814.925757s:
  idpf_rxq_group_rel.part.0+0xef/0x5a0 [idpf]
  idpf_vport_queues_rel+0xaf/0x140 [idpf]
  idpf_vport_stop+0x49e/0x850 [idpf]
  idpf_stop+0x6d/0xc0 [idpf]
  __dev_close_many+0x24c/0x650

The existing rxq_grps test does not help. It is evaluated before the
pointer is read again, so the worker can equally run past the kfree() and
dereference a NULL rxq_grps with a stale num_rxq_grp.

Add a per vport rxq_grps_lock and use it to serialize every transition of
rsrc->rxq_grps against the worker:

  - Teardown: idpf_rxq_group_rel() sets rsrc->rxq_grps to NULL under the
    lock before anything reachable through it is freed. The worker
    re-reads the pointer under the same lock, so it either sees a live
    array while the release path is still blocked on the lock, or sees
    NULL and skips that vport. The frees stay outside the lock.

  - Allocation: Build the rxq_grps array privately and publish it to
    rsrc->rxq_grps under the lock only once every group is complete. The
    freeing of the group contents moves to idpf_rxq_grps_free(), which
    takes the array explicitly so the allocation error path can unwind
    safely.

  - Soft reset: idpf_vport_stop() freed rxq_grps and cleared the live
    vport's copy under rxq_grps_lock. Drop the stale pointer in the clone
    so the memcpy() below does not republish the freed array to
    the PTP aux worker before idpf_vport_open() reallocates it. The lock
    sits past the offsetof(struct idpf_vport, link_up) boundary that
    idpf_initiate_soft_reset() stops its memcpy() at, next to the wait
    queues and mutexes that are already kept out of the copy, so a soft
    reset never byte-copies it. The data it guards, dflt_qv_rsrc, is
    inside that copied region, which is why the clone has to be cleared
    rather than relying on the lock alone.

Also, fix the NULL check in idpf_ptp_update_phctime_rxq_grp(). The split
queue case took the address of a member before testing it, which can never
be NULL, so test the rxq_sets[] entry itself.

Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h      |  5 ++
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |  6 ++
 drivers/net/ethernet/intel/idpf/idpf_ptp.c  | 16 ++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 65 +++++++++++++++------
 4 files changed, 71 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 470bc23c844c..9d63feda1bc6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -373,6 +373,8 @@ struct idpf_q_vec_rsrc {
  * @default_vport: Use this vport if one isn't specified
  * @crc_enable: Enable CRC insertion offload
  * @link_up: True if link is up
+ * @rxq_grps_lock: Serializes every transition of the @dflt_qv_rsrc.rxq_grps
+ *		   pointer of a vport against the PTP auxiliary worker
  * @tx_tstamp_caps: Capabilities negotiated for Tx timestamping
  * @tstamp_config: The Tx tstamp config
  * @tstamp_task: Tx timestamping task
@@ -406,6 +408,9 @@ struct idpf_vport {
 	bool crc_enable;
 	bool link_up;
 
+	/* Must be past the point idpf_initiate_soft_reset() memcpy()s */
+	spinlock_t rxq_grps_lock;
+
 	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
 	struct kernel_hwtstamp_config tstamp_config;
 	struct work_struct tstamp_task;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 827c795afcb6..a1c739cdd540 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1276,6 +1276,7 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	vport->compln_clean_budget = IDPF_TX_COMPLQ_CLEAN_BUDGET;
 	vport->default_vport = adapter->num_alloc_vports <
 			       idpf_get_default_vports(adapter);
+	spin_lock_init(&vport->rxq_grps_lock);
 
 	rsrc = &vport->dflt_qv_rsrc;
 	rsrc->dev = &adapter->pdev->dev;
@@ -2075,6 +2076,11 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	} else {
 		set_bit(IDPF_VPORT_DEL_QUEUES, vport->flags);
 		idpf_vport_stop(vport, false);
+
+		/* Drop the stale pointer in the clone, as rxq_grps was freed
+		 * by idpf_vport_stop().
+		 */
+		new_rsrc->rxq_grps = NULL;
 	}
 
 	err = idpf_send_add_queues_msg(adapter, vport_config, new_rsrc,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 71fe8b2a8b4e..9b15973d2f7e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -348,9 +348,11 @@ idpf_ptp_update_phctime_rxq_grp(const struct idpf_rxq_group *grp, bool split,
 		}
 	} else {
 		for (i = 0; i < grp->splitq.num_rxq_sets; i++) {
+			if (!grp->splitq.rxq_sets[i])
+				continue;
+
 			rxq = &grp->splitq.rxq_sets[i]->rxq;
-			if (rxq)
-				WRITE_ONCE(rxq->cached_phc_time, systime);
+			WRITE_ONCE(rxq->cached_phc_time, systime);
 		}
 	}
 }
@@ -387,10 +389,17 @@ static int idpf_ptp_update_cached_phctime(struct idpf_adapter *adapter)
 		struct idpf_q_vec_rsrc *rsrc;
 		bool split;
 
-		if (!vport || !vport->dflt_qv_rsrc.rxq_grps)
+		if (!vport)
 			continue;
 
 		rsrc = &vport->dflt_qv_rsrc;
+
+		spin_lock(&vport->rxq_grps_lock);
+		if (!rsrc->rxq_grps) {
+			spin_unlock(&vport->rxq_grps_lock);
+			continue;
+		}
+
 		split = idpf_is_queue_model_split(rsrc->rxq_model);
 
 		for (u16 i = 0; i < rsrc->num_rxq_grp; i++) {
@@ -398,6 +407,7 @@ static int idpf_ptp_update_cached_phctime(struct idpf_adapter *adapter)
 
 			idpf_ptp_update_phctime_rxq_grp(grp, split, systime);
 		}
+		spin_unlock(&vport->rxq_grps_lock);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index af3213eae393..96f79554a4d0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1358,16 +1358,15 @@ static void idpf_rxq_sw_queue_rel(struct idpf_rxq_group *rx_qgrp)
 }
 
 /**
- * idpf_rxq_group_rel - Release all resources for rxq groups
+ * idpf_rxq_grps_free - Free an Rx queue group array and everything in it
  * @rsrc: pointer to queue and vector resources
+ * @rxq_grps: group array to free, not reachable through @rsrc any more
  */
-static void idpf_rxq_group_rel(struct idpf_q_vec_rsrc *rsrc)
+static void idpf_rxq_grps_free(struct idpf_q_vec_rsrc *rsrc,
+			       struct idpf_rxq_group *rxq_grps)
 {
-	if (!rsrc->rxq_grps)
-		return;
-
 	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
-		struct idpf_rxq_group *rx_qgrp = &rsrc->rxq_grps[i];
+		struct idpf_rxq_group *rx_qgrp = &rxq_grps[i];
 		u16 num_rxq;
 
 		if (idpf_is_queue_model_split(rsrc->rxq_model)) {
@@ -1388,19 +1387,40 @@ static void idpf_rxq_group_rel(struct idpf_q_vec_rsrc *rsrc)
 			}
 		}
 	}
-	kfree(rsrc->rxq_grps);
+	kfree(rxq_grps);
+}
+
+/**
+ * idpf_rxq_group_rel - Release all resources for rxq groups
+ * @vport: vport the queue groups belong to
+ * @rsrc: pointer to queue and vector resources
+ */
+static void idpf_rxq_group_rel(struct idpf_vport *vport,
+			       struct idpf_q_vec_rsrc *rsrc)
+{
+	struct idpf_rxq_group *rxq_grps;
+
+	if (!rsrc->rxq_grps)
+		return;
+
+	spin_lock(&vport->rxq_grps_lock);
+	rxq_grps = rsrc->rxq_grps;
 	rsrc->rxq_grps = NULL;
+	spin_unlock(&vport->rxq_grps_lock);
+
+	idpf_rxq_grps_free(rsrc, rxq_grps);
 }
 
 /**
  * idpf_vport_queue_grp_rel_all - Release all queue groups
- * @vport: vport to release queue groups for
+ * @vport: vport the queue groups belong to
  * @rsrc: pointer to queue and vector resources
  */
-static void idpf_vport_queue_grp_rel_all(struct idpf_q_vec_rsrc *rsrc)
+static void idpf_vport_queue_grp_rel_all(struct idpf_vport *vport,
+					 struct idpf_q_vec_rsrc *rsrc)
 {
 	idpf_txq_group_rel(rsrc);
-	idpf_rxq_group_rel(rsrc);
+	idpf_rxq_group_rel(vport, rsrc);
 }
 
 /**
@@ -1419,7 +1439,7 @@ void idpf_vport_queues_rel(struct idpf_vport *vport,
 	idpf_rx_desc_rel_all(rsrc);
 
 	idpf_xdpsqs_put(vport);
-	idpf_vport_queue_grp_rel_all(rsrc);
+	idpf_vport_queue_grp_rel_all(vport, rsrc);
 
 	kfree(vport->txqs);
 	vport->txqs = NULL;
@@ -1803,18 +1823,19 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 				u16 num_rxq)
 {
 	struct idpf_adapter *adapter = vport->adapter;
+	struct idpf_rxq_group *rxq_grps;
 	bool hs, rsc;
-	int err = 0;
+	int err;
 
-	rsrc->rxq_grps = kzalloc_objs(struct idpf_rxq_group, rsrc->num_rxq_grp);
-	if (!rsrc->rxq_grps)
+	rxq_grps = kzalloc_objs(struct idpf_rxq_group, rsrc->num_rxq_grp);
+	if (!rxq_grps)
 		return -ENOMEM;
 
 	hs = idpf_vport_get_hsplit(vport) == ETHTOOL_TCP_DATA_SPLIT_ENABLED;
 	rsc = idpf_is_feature_ena(vport, NETIF_F_GRO_HW);
 
 	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
-		struct idpf_rxq_group *rx_qgrp = &rsrc->rxq_grps[i];
+		struct idpf_rxq_group *rx_qgrp = &rxq_grps[i];
 
 		rx_qgrp->vport = vport;
 		if (!idpf_is_queue_model_split(rsrc->rxq_model)) {
@@ -1915,9 +1936,17 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 		}
 	}
 
+	/* Publish only once every group is built, the PTP aux worker reads
+	 * the array as soon as it becomes visible.
+	 */
+	spin_lock(&vport->rxq_grps_lock);
+	rsrc->rxq_grps = rxq_grps;
+	spin_unlock(&vport->rxq_grps_lock);
+
+	return 0;
+
 err_alloc:
-	if (err)
-		idpf_rxq_group_rel(rsrc);
+	idpf_rxq_grps_free(rsrc, rxq_grps);
 
 	return err;
 }
@@ -1948,7 +1977,7 @@ static int idpf_vport_queue_grp_alloc_all(struct idpf_vport *vport,
 	return 0;
 
 err_out:
-	idpf_vport_queue_grp_rel_all(rsrc);
+	idpf_vport_queue_grp_rel_all(vport, rsrc);
 
 	return err;
 }
-- 
2.37.3

