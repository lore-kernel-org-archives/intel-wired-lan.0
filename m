Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8FEC79F99
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 11:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C517780CB2;
	Mon,  7 Sep 2026 11:04:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 64dZGPAmfNsI; Mon,  7 Sep 2026 11:04:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 911ED80C88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788779073;
	b=IfSC8Nl9ns+5wnf2MvsvVjdQ7stZigx7ltYuQJBP0KqERCOGxUHBjOdS0ajiZPa3B/52
	 w1FfeAO1GUWTvsk0a34oBiTMVcMT+GaFLDa9Wc3N3t8aNQiC7c3B5zEuLDYShmp7deS8F
	 K2xHSKD2M41B8LL7N68712vLdPM7YiS4z8tjq/3w1lEbPD6ubNkZVe++nlGKUa2yXz3jo
	 2rVCxaTEk00D84dbNegKCO5uHb8W4cStSoUiVnC9PhrltehED9J2C6LN0j9xvb2KBBYQt
	 x3Zo9DkdYtArUsi962epLWZZIhFsDDRvdFOZe6gGLoFj3GUn+iMF7PTsYntY1uPpKWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788779073;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Oldt411nSOmL7oqHQCSixNv33d1712gRl5QS9hRyrPk=;
	b=MOsMfm4c3SX1y4AcM0sEpK3Oo+cSk3HDari9tD1qdI3GxhbcERyBajw7I/voGfzkYN64
	 CVB9jJOWyFPXFgGfBKrZjMPEQYQ6K8Cs+tJXxbt9aR9apnyBNH2iXzLaMH0N1M4ctj7i8
	 SAF8pBebBRM6dfm4VmdiiaSdgF2guzfkkp3lG6hMGf+p8zWixGrt9hjPO//rmwwqAmrSP
	 E+i2SGfD7hN4smiOnoyyLe+A72MjG21JCSODJW/kcWLRtN44EzJtuRDDE7gve2rhVMtlU
	 WbMGIIRaOLNi+fdonGlIn/mgYVPZbJ2lo596xTsupHEW8WRpBVARlSGRnCcsbZ1E9rA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G+Pc7Gwm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788779073;
	bh=Oldt411nSOmL7oqHQCSixNv33d1712gRl5QS9hRyrPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UZeP3YdLzQ+fNWwdz5zyJEZ3CPUgTl4tA1GDwUw+nWnGN7I/etZb5H7+0LvuFdyK+
	 KU3L6V6jV9Zc/zE7cClkuVCEklnx8+ZhZlCJsA6e+9xsixKG1mN6gB1hU6YXj4nRh7
	 dVyCf0ZG0Lwc/ZGpOB/Ql7g4V7fc7oZwcoTuF6kjlrLzS1a4yi2R/13YrezecEd/kH
	 6t/lktWDilT672Ku2CjGOIKkbSwYKLt8A6ILfw2qlYPQDFqS4KjPLLjZrBQyrI9C8X
	 4aT7wLO+CB5VzNRBtef9NESePZF/cTTTknlrnjooNsdx8JolvlKxJSo4KdHDnu2hhe
	 5F2YB3P0hfqgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 911ED80C88;
	Mon,  7 Sep 2026 11:04:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 41F4EA48
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27F1D80CC2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UuuvT7vQnVn3 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 11:04:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9D5A580C8E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788779069;
 b=sTTv7upV3P5pdp6fa9loS17ElrGw9Y3mKuWtCL9UtsyULasicDx+MMpUyt0qP2JXhiRK
 0dqk18CHWe3x0Fxzs03G8BiazPJFwNLLoytET+855mtgOVpn3VTUNHivhs8ys1mOWcgRK
 +EC5D5wImMjU0ZK+t27O629R2oy0rszjGcROLmyOyGitfuxmjUxUBS0CMXIV/dGgqOKVH
 a4CbWq19fzx34PcYKfYmZ7/XCjNF56trG1vXT0UCuRfrl7BALQ0slfIn+VsinrVJUrF2H
 KkWaxveB51zpnQJYnK2Lp7gQATNv3/WI5Gtf52llQVJyvRm+E8tnxhBbwaI9pjl5rxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788779069;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Oldt411nSOmL7oqHQCSixNv33d1712gRl5QS9hRyrPk=;
 b=cX13rTumQssFEvRK8cgtL557ddkhKGQvAs3B6+SQkbW3oBNNeKxnonyK7abPUl69qUbq
 HZkK2tzVgyAc1u19YP1hckZ2+v8XKPhthmMGOC9bY5va8f9yN12kSLdcnyF6i+ijOoj8Y
 +aXmZLsaPVia2RN+0s9V9KPV/QIFDAbX+wP0Bm+KrgRCQsnW5PcBmscRohtEo0VlzSshe
 FjQ7CWlASDG32eoBsBFP7XxGvvtUK/8kod35IGfi8vKM2SUaa+z1cppzsx3daKcP4XN3W
 vn8S1OHI/UVApa0KLL5ZRn6nT27aCV5gAYSshqBTOQp8BWMsN7ay15p7H06jqh8qyXw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=G+Pc7Gwm; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=G+Pc7Gwm
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D5A580C8E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788779070; x=1820315070;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xWcIDBt+E7k9tkra/IyKc/WQz/V4uiXx9JIb4qGWjdQ=;
 b=G+Pc7Gwmc5lIHq0NveK2uOkuqfiaqakvokEbKVky0kExcEXjv6HIXYhs
 ZMYNFRIOjg2IbzAdUwjxZSrgE/NJ2aImgv8cxzd16g0Ywkw9miBGyOhUP
 wct7Op1ejTwMt99sseru/5rGNweJUxy/wYik2G4Vzb5PczzKmuCUT27tq
 RtPNl1RVAunVCdj1t4Pe8z1UaOlpkMxT/YUE911JR0NUfRynM0i3Q/Ye9
 TyjcaOvpZQmfiz996o7i2D2e7fF9hYjL5dL8ZinUBpawSp3kE1Kr4m3DS
 1VvTwNqfjqrhqO30TPMRSg+jgqGzjayXpRbjWuPdqaZHlnyRjhhQz3oBH w==;
X-CSE-ConnectionGUID: KWtMI+ZLS9CAP/Gupo6rmg==
X-CSE-MsgGUID: VwbWZZkdQdKAKIqC/+6j7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89214087"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="89214087"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 04:04:30 -0700
X-CSE-ConnectionGUID: 5cJgFWV2QiK6Ew2tqRMCXg==
X-CSE-MsgGUID: TYyln9+IQgKRuoyVHgdm+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="274195483"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 04:04:28 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 08/10] ice: use libie_irq for interrupts managing
Date: Mon,  7 Sep 2026 12:24:15 +0200
Message-ID: <20260907102418.2697317-9-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260907102418.2697317-1-michal.swiatkowski@linux.intel.com>
References: <20260907102418.2697317-1-michal.swiatkowski@linux.intel.com>
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

Change interrupts code to fit the libie_irq calls.

There is not many difference. Bool for dynamic alloc in libie is changed
to enum for STATIC and DYNAMIC. Rest code is the same. Instead of custom
ice_irq_tracker there is libie_irq that tracks the interrupts.

Previous code fallback to STATIC when there is not more dynamic. Do the
same by introducing ANY type in libie_irq.

Dynamic alloc is always set to true if there is support. In libie_irq
code check for dynamic support is done inside. LIBIE_IRQ_ANY can be
always pass in case of getting interrupts for VSI. If there is no
platform support it is changed to LIBIE_IRQ_STATIC inside libie code.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/Kconfig        |   1 +
 drivers/net/ethernet/intel/ice/ice.h      |   5 +-
 drivers/net/ethernet/intel/ice/ice_base.c |   4 +-
 drivers/net/ethernet/intel/ice/ice_idc.c  |   4 +-
 drivers/net/ethernet/intel/ice/ice_irq.c  | 181 ++--------------------
 drivers/net/ethernet/intel/ice/ice_irq.h  |  14 --
 drivers/net/ethernet/intel/ice/ice_lib.c  |   3 -
 drivers/net/ethernet/intel/ice/ice_main.c |  15 +-
 drivers/net/ethernet/intel/libie/irq.c    |  30 +++-
 include/linux/net/intel/libie/irq.h       |   2 +
 10 files changed, 51 insertions(+), 208 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 1228ae099b15..bd0dd8c28352 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -301,6 +301,7 @@ config ICE
 	select LIBIE
 	select LIBIE_ADMINQ
 	select LIBIE_FWLOG if DEBUG_FS
+	select LIBIE_IRQ
 	select NET_DEVLINK
 	select PACKING
 	select PLDMFW
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 65dcc60a8da1..a9d27c4bc5e2 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -36,6 +36,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/auxiliary_bus.h>
+#include <linux/net/intel/libie/irq.h>
 #include <linux/net/intel/virtchnl.h>
 #include <linux/cpu_rmap.h>
 #include <linux/dim.h>
@@ -352,8 +353,6 @@ struct ice_vsi {
 	u32 rx_buf_failed;
 	u32 rx_page_failed;
 	u16 num_q_vectors;
-	/* tell if only dynamic irq allocation is allowed */
-	bool irq_dyn_alloc;
 	bool hsplit:1;
 
 	u16 vsi_num;			/* HW (absolute) index of this VSI */
@@ -566,7 +565,7 @@ struct ice_pf {
 	struct devlink_port devlink_port;
 
 	/* OS reserved IRQ details */
-	struct ice_irq_tracker irq_tracker;
+	struct libie_irq irq;
 	struct ice_virt_irq_tracker virt_irq_tracker;
 
 	u16 ctrl_vsi_idx;		/* control VSI index in pf->vsi array */
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1667f686ff75..b592d3c389c0 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -140,7 +140,7 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, u16 v_idx)
 		}
 	}
 
-	q_vector->irq = ice_alloc_irq(pf, vsi->irq_dyn_alloc);
+	q_vector->irq = libie_irq_alloc(&pf->irq, LIBIE_IRQ_ANY);
 	if (q_vector->irq.index < 0) {
 		err = -ENOMEM;
 		goto err_free_q_vector;
@@ -209,7 +209,7 @@ static void ice_free_q_vector(struct ice_vsi *vsi, int v_idx)
 	    ice_get_vf_ctrl_vsi(pf, vsi))
 		goto free_q_vector;
 
-	ice_free_irq(pf, q_vector->irq);
+	libie_irq_free(&pf->irq, q_vector->irq);
 
 free_q_vector:
 	kfree(q_vector);
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 102d63c3018b..337ba65b6318 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -239,7 +239,7 @@ int ice_alloc_rdma_qvector(struct iidc_rdma_core_dev_info *cdev,
 		return -EINVAL;
 
 	pf = pci_get_drvdata(cdev->pdev);
-	map = ice_alloc_irq(pf, true);
+	map = libie_irq_alloc(&pf->irq, LIBIE_IRQ_ANY);
 	if (map.index < 0)
 		return -ENOMEM;
 
@@ -268,7 +268,7 @@ void ice_free_rdma_qvector(struct iidc_rdma_core_dev_info *cdev,
 
 	map.index = entry->entry;
 	map.virq = entry->vector;
-	ice_free_irq(pf, map);
+	libie_irq_free(&pf->irq, map);
 }
 EXPORT_SYMBOL_GPL(ice_free_rdma_qvector);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index cd59579568b7..a883b65b4e34 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -5,21 +5,6 @@
 #include "ice_lib.h"
 #include "ice_irq.h"
 
-/**
- * ice_init_irq_tracker - initialize interrupt tracker
- * @pf: board private structure
- * @max_vectors: maximum number of vectors that tracker can hold
- * @num_static: number of preallocated interrupts
- */
-static void
-ice_init_irq_tracker(struct ice_pf *pf, unsigned int max_vectors,
-		     unsigned int num_static)
-{
-	pf->irq_tracker.num_entries = max_vectors;
-	pf->irq_tracker.num_static = num_static;
-	xa_init_flags(&pf->irq_tracker.entries, XA_FLAGS_ALLOC);
-}
-
 static int
 ice_init_virt_irq_tracker(struct ice_pf *pf, u32 base, u32 num_entries)
 {
@@ -33,76 +18,11 @@ ice_init_virt_irq_tracker(struct ice_pf *pf, u32 base, u32 num_entries)
 	return 0;
 }
 
-/**
- * ice_deinit_irq_tracker - free xarray tracker
- * @pf: board private structure
- */
-static void ice_deinit_irq_tracker(struct ice_pf *pf)
-{
-	xa_destroy(&pf->irq_tracker.entries);
-}
-
 static void ice_deinit_virt_irq_tracker(struct ice_pf *pf)
 {
 	bitmap_free(pf->virt_irq_tracker.bm);
 }
 
-/**
- * ice_free_irq_res - free a block of resources
- * @pf: board private structure
- * @index: starting index previously returned by ice_get_res
- */
-static void ice_free_irq_res(struct ice_pf *pf, u16 index)
-{
-	struct ice_irq_entry *entry;
-
-	entry = xa_erase(&pf->irq_tracker.entries, index);
-	kfree(entry);
-}
-
-/**
- * ice_get_irq_res - get an interrupt resource
- * @pf: board private structure
- * @dyn_allowed: allow entry to be dynamically allocated
- *
- * Allocate new irq entry in the free slot of the tracker. Since xarray
- * is used, always allocate new entry at the lowest possible index. Set
- * proper allocation limit for maximum tracker entries.
- *
- * Returns allocated irq entry or NULL on failure.
- */
-static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf,
-					     bool dyn_allowed)
-{
-	struct xa_limit limit = { .max = pf->irq_tracker.num_entries - 1,
-				  .min = 0 };
-	unsigned int num_static = pf->irq_tracker.num_static - 1;
-	struct ice_irq_entry *entry;
-	unsigned int index;
-	int ret;
-
-	entry = kzalloc_obj(*entry);
-	if (!entry)
-		return NULL;
-
-	/* only already allocated if the caller says so */
-	if (!dyn_allowed)
-		limit.max = num_static;
-
-	ret = xa_alloc(&pf->irq_tracker.entries, &index, entry, limit,
-		       GFP_KERNEL);
-
-	if (ret) {
-		kfree(entry);
-		entry = NULL;
-	} else {
-		entry->index = index;
-		entry->dynamic = index > num_static;
-	}
-
-	return entry;
-}
-
 #define ICE_RDMA_AEQ_MSIX 1
 static int ice_get_default_msix_amount(struct ice_pf *pf)
 {
@@ -118,8 +38,7 @@ static int ice_get_default_msix_amount(struct ice_pf *pf)
  */
 void ice_clear_interrupt_scheme(struct ice_pf *pf)
 {
-	pci_free_irq_vectors(pf->pdev);
-	ice_deinit_irq_tracker(pf);
+	libie_irq_deinit(&pf->irq);
 	ice_deinit_virt_irq_tracker(pf);
 }
 
@@ -130,7 +49,7 @@ void ice_clear_interrupt_scheme(struct ice_pf *pf)
 int ice_init_interrupt_scheme(struct ice_pf *pf)
 {
 	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
-	int vectors;
+	int err;
 
 	/* load default PF MSI-X range */
 	if (!pf->msix.min)
@@ -143,97 +62,15 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 	pf->msix.total = total_vectors;
 	pf->msix.rest = total_vectors - pf->msix.max;
 
-	if (pci_msix_can_alloc_dyn(pf->pdev))
-		vectors = pf->msix.min;
-	else
-		vectors = pf->msix.max;
-
-	vectors = pci_alloc_irq_vectors(pf->pdev, pf->msix.min, vectors,
-					PCI_IRQ_MSIX);
-	if (vectors < 0)
-		return vectors;
-
-	ice_init_irq_tracker(pf, pf->msix.max, vectors);
-
-	return ice_init_virt_irq_tracker(pf, pf->msix.max, pf->msix.rest);
-}
-
-/**
- * ice_alloc_irq - Allocate new interrupt vector
- * @pf: board private structure
- * @dyn_allowed: allow dynamic allocation of the interrupt
- *
- * Allocate new interrupt vector for a given owner id.
- * return struct msi_map with interrupt details and track
- * allocated interrupt appropriately.
- *
- * This function reserves new irq entry from the irq_tracker.
- * if according to the tracker information all interrupts that
- * were allocated with ice_pci_alloc_irq_vectors are already used
- * and dynamically allocated interrupts are supported then new
- * interrupt will be allocated with pci_msix_alloc_irq_at.
- *
- * Some callers may only support dynamically allocated interrupts.
- * This is indicated with dyn_allowed flag.
- *
- * On failure, return map with negative .index. The caller
- * is expected to check returned map index.
- *
- */
-struct msi_map ice_alloc_irq(struct ice_pf *pf, bool dyn_allowed)
-{
-	struct msi_map map = { .index = -ENOENT };
-	struct device *dev = ice_pf_to_dev(pf);
-	struct ice_irq_entry *entry;
-
-	entry = ice_get_irq_res(pf, dyn_allowed);
-	if (!entry)
-		return map;
-
-	if (pci_msix_can_alloc_dyn(pf->pdev) && entry->dynamic) {
-		map = pci_msix_alloc_irq_at(pf->pdev, entry->index, NULL);
-		if (map.index < 0)
-			goto exit_free_res;
-		dev_dbg(dev, "allocated new irq at index %d\n", map.index);
-	} else {
-		map.index = entry->index;
-		map.virq = pci_irq_vector(pf->pdev, map.index);
-	}
-
-	return map;
-
-exit_free_res:
-	dev_err(dev, "Could not allocate irq at idx %d\n", entry->index);
-	ice_free_irq_res(pf, entry->index);
-	return map;
-}
-
-/**
- * ice_free_irq - Free interrupt vector
- * @pf: board private structure
- * @map: map with interrupt details
- *
- * Remove allocated interrupt from the interrupt tracker. If interrupt was
- * allocated dynamically, free respective interrupt vector.
- */
-void ice_free_irq(struct ice_pf *pf, struct msi_map map)
-{
-	struct ice_irq_entry *entry;
-
-	entry = xa_load(&pf->irq_tracker.entries, map.index);
-
-	if (!entry) {
-		dev_err(ice_pf_to_dev(pf), "Failed to get MSIX interrupt entry at index %d",
-			map.index);
-		return;
-	}
-
-	dev_dbg(ice_pf_to_dev(pf), "Free irq at index %d\n", map.index);
+	err = libie_irq_init(&pf->irq, pf->pdev, pf->msix.min, pf->msix.max);
+	if (err)
+		return err;
 
-	if (entry->dynamic)
-		pci_msix_free_irq(pf->pdev, map);
+	err = ice_init_virt_irq_tracker(pf, pf->msix.max, pf->msix.rest);
+	if (err)
+		libie_irq_deinit(&pf->irq);
 
-	ice_free_irq_res(pf, map.index);
+	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_irq.h b/drivers/net/ethernet/intel/ice/ice_irq.h
index b2f9dbafd57e..a4ecf50e9ccf 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.h
+++ b/drivers/net/ethernet/intel/ice/ice_irq.h
@@ -4,17 +4,6 @@
 #ifndef _ICE_IRQ_H_
 #define _ICE_IRQ_H_
 
-struct ice_irq_entry {
-	unsigned int index;
-	bool dynamic;	/* allocation type flag */
-};
-
-struct ice_irq_tracker {
-	struct xarray entries;
-	u16 num_entries;	/* total vectors available */
-	u16 num_static;	/* preallocated entries */
-};
-
 struct ice_virt_irq_tracker {
 	unsigned long *bm;	/* bitmap to track irq usage */
 	u32 num_entries;
@@ -28,9 +17,6 @@ struct ice_virt_irq_tracker {
 int ice_init_interrupt_scheme(struct ice_pf *pf);
 void ice_clear_interrupt_scheme(struct ice_pf *pf);
 
-struct msi_map ice_alloc_irq(struct ice_pf *pf, bool dyn_only);
-void ice_free_irq(struct ice_pf *pf, struct msi_map map);
-
 int ice_virt_get_irqs(struct ice_pf *pf, u32 needed);
 void ice_virt_free_irqs(struct ice_pf *pf, u32 index, u32 irqs);
 #endif
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 93e405dd6f5a..6eb758404f54 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -211,7 +211,6 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 		vsi->alloc_txq = 1;
 		vsi->alloc_rxq = 1;
 		vsi->num_q_vectors = 1;
-		vsi->irq_dyn_alloc = true;
 		break;
 	case ICE_VSI_VF:
 		if (vf->num_req_qs)
@@ -572,8 +571,6 @@ ice_vsi_alloc_def(struct ice_vsi *vsi, struct ice_channel *ch)
 			return -ENOMEM;
 	}
 
-	vsi->irq_dyn_alloc = pci_msix_can_alloc_dyn(vsi->back->pdev);
-
 	switch (vsi->type) {
 	case ICE_VSI_PF:
 	case ICE_VSI_SF:
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 464171216c39..65b3272d0abe 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -44,6 +44,7 @@ MODULE_IMPORT_NS("LIBETH_XDP");
 MODULE_IMPORT_NS("LIBIE");
 MODULE_IMPORT_NS("LIBIE_ADMINQ");
 MODULE_IMPORT_NS("LIBIE_FWLOG");
+MODULE_IMPORT_NS("LIBIE_IRQ");
 MODULE_LICENSE("GPL v2");
 MODULE_FIRMWARE(ICE_DDP_PKG_FILE);
 
@@ -3357,7 +3358,7 @@ static void ice_free_irq_msix_ll_ts(struct ice_pf *pf)
 	synchronize_irq(irq_num);
 	devm_free_irq(ice_pf_to_dev(pf), irq_num, pf);
 
-	ice_free_irq(pf, pf->ll_ts_irq);
+	libie_irq_free(&pf->irq, pf->ll_ts_irq);
 }
 
 /**
@@ -3378,7 +3379,7 @@ static void ice_free_irq_msix_misc(struct ice_pf *pf)
 	synchronize_irq(misc_irq_num);
 	devm_free_irq(ice_pf_to_dev(pf), misc_irq_num, pf);
 
-	ice_free_irq(pf, pf->oicr_irq);
+	libie_irq_free(&pf->irq, pf->oicr_irq);
 	if (pf->ll_ts_irq.index >= 0)
 		ice_free_irq_msix_ll_ts(pf);
 }
@@ -3447,7 +3448,7 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 		goto skip_req_irq;
 
 	/* reserve one vector in irq_tracker for misc interrupts */
-	irq = ice_alloc_irq(pf, false);
+	irq = libie_irq_alloc(&pf->irq, LIBIE_IRQ_STATIC);
 	if (irq.index < 0)
 		return irq.index;
 
@@ -3458,7 +3459,7 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 	if (err) {
 		dev_err(dev, "devm_request_threaded_irq for %s failed: %d\n",
 			pf->int_name, err);
-		ice_free_irq(pf, pf->oicr_irq);
+		libie_irq_free(&pf->irq, pf->oicr_irq);
 		return err;
 	}
 
@@ -3468,7 +3469,7 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 		goto skip_req_irq;
 	}
 
-	irq = ice_alloc_irq(pf, false);
+	irq = libie_irq_alloc(&pf->irq, LIBIE_IRQ_STATIC);
 	if (irq.index < 0)
 		return irq.index;
 
@@ -3478,7 +3479,7 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 	if (err) {
 		dev_err(dev, "devm_request_irq for %s failed: %d\n",
 			pf->int_name_ll_ts, err);
-		ice_free_irq(pf, pf->ll_ts_irq);
+		libie_irq_free(&pf->irq, pf->ll_ts_irq);
 		pf->ll_ts_irq.index = -ENOENT;
 		return err;
 	}
@@ -3963,7 +3964,7 @@ void ice_deinit_pf(struct ice_pf *pf)
 	if (pf->ptp.clock)
 		ptp_clock_unregister(pf->ptp.clock);
 
-	if (!xa_empty(&pf->irq_tracker.entries))
+	if (!xa_empty(&pf->irq.entries))
 		ice_free_irq_msix_misc(pf);
 
 	xa_destroy(&pf->dyn_ports);
diff --git a/drivers/net/ethernet/intel/libie/irq.c b/drivers/net/ethernet/intel/libie/irq.c
index b8c144329aac..d15a80e66ab8 100644
--- a/drivers/net/ethernet/intel/libie/irq.c
+++ b/drivers/net/ethernet/intel/libie/irq.c
@@ -96,6 +96,7 @@ static struct libie_irq_entry *libie_get_irq(struct libie_irq *irq,
 					     enum libie_irq_type type)
 {
 	struct libie_irq_entry *entry;
+	struct xa_limit limit;
 	unsigned int index;
 
 	/* Change entry type if dynamic isn't supported. Reflect correct type
@@ -108,9 +109,26 @@ static struct libie_irq_entry *libie_get_irq(struct libie_irq *irq,
 	if (!entry)
 		return NULL;
 
-	if (xa_alloc(&irq->entries, &index, entry, irq->limits[type],
-		     GFP_KERNEL))
-		goto free_entry;
+	/* If any, first try dynamic */
+	if (type == LIBIE_IRQ_ANY)
+		limit = irq->limits[LIBIE_IRQ_DYNAMIC];
+	else
+		limit = irq->limits[type];
+
+	if (xa_alloc(&irq->entries, &index, entry, limit, GFP_KERNEL)) {
+		if (type != LIBIE_IRQ_ANY)
+			goto free_entry;
+		/* Dynamic for any type failed, try static */
+		if (xa_alloc(&irq->entries, &index, entry,
+			     irq->limits[LIBIE_IRQ_STATIC], GFP_KERNEL))
+			goto free_entry;
+
+		type = LIBIE_IRQ_STATIC;
+	}
+
+	/* If still any it is dynamic */
+	if (type == LIBIE_IRQ_ANY)
+		type = LIBIE_IRQ_DYNAMIC;
 
 	entry->index = index;
 	entry->type = type;
@@ -144,6 +162,7 @@ EXPORT_SYMBOL_NS_GPL(libie_put_irq, "LIBIE_IRQ");
  *
  * For LIBIE_IRQ_DYNAMIC function allocs new interrupt and return it.
  * For LIBIE_IRQ_STATIC function returns already allocated one.
+ * For LIBIE_IRQ_ANY first try DYNAMIC, if it failed try STATIC
  *
  * The function should be called for getting irq information (index and virq)
  * for specific irq type. Returned information should be stored to use index for
@@ -197,8 +216,9 @@ EXPORT_SYMBOL_NS_GPL(libie_irq_alloc, "LIBIE_IRQ");
  * @irq: libie_irq structure
  * @map: msi_map structure returned from libie_alloc_irq()
  *
- * In case of dynamic allocation and LIBIE_IRQ_DYNAMIC type pci_msix_free_irq()
- * is called. Otherwise only free driver irq entry related resources.
+ * In case of dynamic allocation and LIBIE_IRQ_DYNAMIC (or LIBIE_IRQ_ANY)
+ * type pci_msix_free_irq() is called. Otherwise only free driver irq entry
+ * related resources.
  *
  * It is safe to call this function with map that doesn't exist in xarray
  * as long as the map.virq is 0 or negative. It is true when libie_irq_alloc()
diff --git a/include/linux/net/intel/libie/irq.h b/include/linux/net/intel/libie/irq.h
index 47f3cdcd30b4..aceaf276d8d7 100644
--- a/include/linux/net/intel/libie/irq.h
+++ b/include/linux/net/intel/libie/irq.h
@@ -18,6 +18,7 @@
  * enum libie_irq_type - enum representing types of irq entries
  * @LIBIE_IRQ_STATIC: irq static allocated from kernel at driver probe
  * @LIBIE_IRQ_DYNAMIC: irq dynamic allocated during normal driver operation
+ * @LIBIE_IRQ_ANY: use when STATIC or DYNAMIC can be allocated
  * @LIBIE_IRQ_NUM_TYPES: must be the last one, used to define the array size
  *
  * Enum is used to get software irq indexes from some kind of pool. The pool is
@@ -32,6 +33,7 @@
 enum libie_irq_type {
 	LIBIE_IRQ_STATIC,
 	LIBIE_IRQ_DYNAMIC,
+	LIBIE_IRQ_ANY,
 	LIBIE_IRQ_NUM_TYPES,
 };
 
-- 
2.49.0

