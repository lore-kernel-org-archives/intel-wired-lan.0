Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF509C88E4A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 11:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71EEA80EE8;
	Fri, 11 Sep 2026 11:39:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cZsFbc2iwk0A; Fri, 11 Sep 2026 11:39:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BCB2780E97
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789126750;
	b=MJ8PMEjPDzkGy5/o677NQGB2b55LcX1N9txQ6dr/q64VoJ155GmiwQjD75gehghmLbq1
	 3OWVc31Lha4Go2G0qM2n1toYnVSm+bnbIXASsCVQeR2EYqUoMRNlVcizsQHAMBsQmQKAQ
	 0UWPJn68kJoRWyYiFs4AipkcBfz20WA5/pmhfcLXRJu+gzae9jsQvfaPe9epewa0ZM2V+
	 ml2rwlH+Xj9LFTcHMBY8y+2WVZ1BsgtgHejmJyqyD3FyuN7wPfzaoP4LYkXuQlH4KLh67
	 Mmx0VUzifLATA8FtSdfxeo254QD35sKkx4flAqcnn5hAG8dnBVBQrLq5/0aLwQk7oRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789126750;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qjYEBQpEhWxdfT6uzekHLgUDItJgXgUiQvibPel1r7I=;
	b=ZsAQskywh6n6MzsI7hIPH/T+nkhhBw679SRQKO84z1mpF/7B6x27jue4dADb+vilzE6W
	 /Mof+GAFD/AXMLBol7XbAg2o5uXAznHZTPXiRHrr8z2U0S7QGpR+pBs0hc+dR3kLRWzzV
	 KEgkH1m6021kHRBtlROGq5jTcET1hURbgIQtH6CjuZSM1U0Tz1a2TdLUsqfWCzC7wWg43
	 sleN/t3P2NzxRstnmVWyMiI6KIidnPFj8wA3LpVZ4K4yF2m77jyfvAYz6vcyZMomLLOuw
	 UXmm7x+T9XAGBt63altthIfdQE8Y9q2SjpZeo9nCfD7XQ6aOp1jroCR8JDNEx7dBVcg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789126750;
	bh=qjYEBQpEhWxdfT6uzekHLgUDItJgXgUiQvibPel1r7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=okwMeDoxMsKfLD5pWCBe+zKIkvMk+QuGSRHWMM7CM/jA7C68tRbS2I7mQScACPKf/
	 InIn1VY1H21t1ygqfXXgKO8VwK+vGEL5Yd5dxGmbFhlxyd80PEClkPefHvLL44s6Dl
	 VotjSdxkgFWwJnvTxSPvyg5lblIaYUpbcPWb4QqKkZMAnqpkwUUsLQwVGHy1Gu0GTa
	 13X1kUc9eMuziVj7r4osMKCdgMGO0WH/rtjCdUWt3rCfAjDEd92WM+hmqx6htMmAZ5
	 br/R3TzcR4hSp4wyyzAHcsB83o5nBtqnIi7UAojJtF6utQj2upbq1EOSED2m97hyLW
	 gMcWtdG5qicCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCB2780E97;
	Fri, 11 Sep 2026 11:39:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E9151EA0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7119E605E7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y29HWJplTI4d for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 11:39:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AC4766068A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789126746;
 b=OlfyH9mXGp3+Zjtm6fFKuUpwudrLjOZHnxFhHidKAQQGltc3RJVivvATwjyPtXf799Rp
 cc59zSY6FIljpXe5zPFJLuiIa8nnLj0TwBeR/4wl9E1KP6vkYhfKmQX/YGzv3Omqezk04
 vE4aCBjA/tws3cbOvADxE8Y6kjtY+YnSeiESDcJvadCLZb8qvfYzHr0jqprOGLc+ebEg6
 S+TF0Bk+HTFUZlOMZD4vUeoqbArk6mthOoMA++fGXvwUK9GmSbRNeGSDxthrb8IT6fmid
 yBU0j6MS6Py95zsxQIyyuBj/jPM3PkdBrukT/gj/f1dKXHNl62pxkL7Zrx8GlfJTG9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789126746;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=qjYEBQpEhWxdfT6uzekHLgUDItJgXgUiQvibPel1r7I=;
 b=VKNek0zV60Sf4exItZfe9veA0D7j+/GxnuT0vVNMcxIaQyL8P/rgRNiJZoHyan2Einif
 O9aVHnmVYir6FF2MY/cD+xmtK+Q+bT+Xo1mZ+p8ZF1M8WnSqQWI3aTU6h4Q6YJV25x2dA
 GpTKhpRESfbJpwEKltj2VOiNcLm0+GZU6du604jMb5xE5ighN8uQDd9JtWwdXEQ/pNw2R
 orKcm85sMo9A8+6n/DAKOyGHnXCSKbJ5Q+1yuhVZgVijY/BdnEMKbFFwJxIm1FknJ5awu
 KNRW0WeG+Ex5IjYTbk8phTKkY49w35G7Av4WE7JjEabFqz87h+EEbJH3H9J+OrcAvqg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="LLWf/8f+"; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LLWf/8f+
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC4766068A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789126747; x=1820662747;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yZGMqDQKZVafTUD6mXjzgg/r+vPOzWaA5vBTGT1HiBU=;
 b=LLWf/8f+juqbVd4sv5LAaBThR16YtStVlf/Lgx8hn6gOKFAAT0XMq3hi
 FaJLrIx5OwCcfmS+XJkbqGPcxZC/SI6MgYoXGwz8lIDiBfK7h9X+sO+kD
 gELlJC2WRlqeLNo6X3ahys71pgLg088AkSsLntL0CsBQSTNR2QyV/iYRi
 hTDbSfW27bDp2/lNRiGcM+kg5DJuxOTGJge/MXHlSjYjWGgVrX3E2xz33
 3UQCwZ04TA4S7IunOpPd3MdpFJLzESRb9ahdkUABbmyemamK3BguvqhXi
 xqRabkAkxh4R8Q5zDfvfHdjyHrt1YgsvXjx8NHp42H/c4IQZiFY47evdf g==;
X-CSE-ConnectionGUID: WTTpVxppTVCwhegrChQbCA==
X-CSE-MsgGUID: rII+7i5JTSyikS8dwO/uBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="112359897"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="112359897"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 04:39:05 -0700
X-CSE-ConnectionGUID: zAEWc20WTMGT7Sfm8kklEQ==
X-CSE-MsgGUID: sX7sgY+cR9uAvZdEtPIeSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270135848"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa006.jf.intel.com with ESMTP; 11 Sep 2026 04:39:03 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.244.110])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id C2FB42877D;
 Fri, 11 Sep 2026 12:39:01 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v3 2/5] ice: extract ice_vsi_new_stat_arrays()
Date: Fri, 11 Sep 2026 13:26:17 +0200
Message-ID: <20260911113848.44086-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
References: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
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

Split the allocation of a struct ice_vsi_stats and its two ring stats
arrays out of ice_vsi_alloc_stat_arrays(), which is left with just the
lookup and the store into pf->vsi_stats[].

The sole caller keeps passing the very same queue counts as before,
vsi->alloc_txq and vsi->alloc_rxq. A later commit adds a second caller
in the rebuild path, which cannot use vsi->alloc_* because it has to
size the arrays before the VSI is reconfigured.

Note that the error path no longer clears pf->vsi_stats[vsi->idx]; the
early return above guarantees it is already NULL.

No functional change intended.
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 47 +++++++++++++-----------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index cd78c5c69a30..9c2863fc696c 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -519,6 +519,30 @@ static irqreturn_t ice_msix_clean_rings(int __always_unused irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static struct ice_vsi_stats *ice_vsi_new_stat_arrays(int txq, int rxq)
+{
+	struct ice_ring_stats **tx_ring_stats;
+	struct ice_ring_stats **rx_ring_stats;
+	struct ice_vsi_stats *vsi_stat;
+
+	vsi_stat = kzalloc_obj(*vsi_stat);
+	tx_ring_stats = kzalloc_objs(*tx_ring_stats, txq);
+	rx_ring_stats = kzalloc_objs(*rx_ring_stats, rxq);
+	if (!vsi_stat || !tx_ring_stats || !rx_ring_stats) {
+		kfree(vsi_stat);
+		kfree(tx_ring_stats);
+		kfree(rx_ring_stats);
+		return NULL;
+	}
+
+	vsi_stat->tx_ring_stats = tx_ring_stats;
+	vsi_stat->rx_ring_stats = rx_ring_stats;
+	vsi_stat->tx_ring_stats_len = txq;
+	vsi_stat->rx_ring_stats_len = rxq;
+
+	return vsi_stat;
+}
+
 /**
  * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
  * @vsi: VSI pointer
@@ -537,33 +561,12 @@ static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
 	/* realloc will happen in rebuild path */
 		return 0;
 
-	vsi_stat = kzalloc_obj(*vsi_stat);
+	vsi_stat = ice_vsi_new_stat_arrays(vsi->alloc_txq, vsi->alloc_rxq);
 	if (!vsi_stat)
 		return -ENOMEM;
 
-	vsi_stat->tx_ring_stats =
-		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
-	if (!vsi_stat->tx_ring_stats)
-		goto err_alloc_tx;
-	vsi_stat->tx_ring_stats_len = vsi->alloc_txq;
-
-	vsi_stat->rx_ring_stats =
-		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
-	if (!vsi_stat->rx_ring_stats)
-		goto err_alloc_rx;
-	vsi_stat->rx_ring_stats_len = vsi->alloc_rxq;
-
 	pf->vsi_stats[vsi->idx] = vsi_stat;
-
 	return 0;
-
-err_alloc_rx:
-	kfree(vsi_stat->rx_ring_stats);
-err_alloc_tx:
-	kfree(vsi_stat->tx_ring_stats);
-	kfree(vsi_stat);
-	pf->vsi_stats[vsi->idx] = NULL;
-	return -ENOMEM;
 }
 
 /**
-- 
2.51.1

