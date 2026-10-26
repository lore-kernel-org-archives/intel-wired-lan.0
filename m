Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F12606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=esOGtHWJ;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eQ5mks6d
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1617480BF4;
	Mon, 26 Oct 2026 22:37:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R81QQhDOc3Uy; Mon, 26 Oct 2026 22:37:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5902980BF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793054240;
	b=al5Ic+6tCOaXQeQ49YmQHa74NYHNWzyQTgU58gYq12tGvdnbhq/qdeqUZ5UM9lQHAazk
	 6wgP3YcwgYjr25uBKJc05ZNYKH3qa+nliu2UrGajfxGq0DUi0u8UlVmzmXkqZi0N1W82t
	 qMNRHCB6ESK5CxakCQyz17hM3Tg0djkaYbAdggHN6ICA1Xsu5XWvocx2omPxsCuA/Wafz
	 qbOZ6kL51PllpysLG0PCw7SkNU+NyFDAliH8OK0UJ9Pg53zb6S78O1eDvILoWs3Dy7hKn
	 XLPNll0My/Q0QoHzOWCTrQ8Ylwl+JA276TBBNdPEOPPL9vHnoC5EX0ZxHRBnrOwCBvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793054240;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TF0/R1eqrutWjwgcw8aX9e1pnYyy5C9f/Cdd1ymwAEQ=;
	b=NPCUoBO1yNNk5yCOY8rjqmwCoomjXCL840/PRebTMj4kXrFq+ZdT6mk3q8fY8cmXFxuj
	 Yom/LyI7Ld8MtIzk9y7/912wNJxXMahplSTqEGuxfACu+iGq5AZ+RorlL+o9xKqA1gPFA
	 BHmT52R9GVckFajuu2ejP+ovzI/OUfIsJEGM4Jk1XLLAeFk2OjPhaKJ2/g57X+0qEiyjb
	 3vduaxLFan8zEixsTZwUjNknlU6b0IOE/02TGp3q+F+DRaj8FfUJf6xQ+um9FawkDhNew
	 tFc7Q/Wco3KdBqhwTxxzdwo7NV5ziUEY8PC5n3XmcuW5POtMlDlsHbsc1zXKRD9V1hg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793054240;
	bh=TF0/R1eqrutWjwgcw8aX9e1pnYyy5C9f/Cdd1ymwAEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=esOGtHWJhub41V57t5YAtcJsEB9PXo7an09D5wG6Lqx3JmeeaRJ9krJdW1LrYzqUJ
	 WHYuEM8Mt31DYVQNdG11AZT2p1ZfXqgGJV9x3+i0JGCXRc7LrdPNSsqjEnAbvXz4R6
	 nGfvF1wPZWcDaCV6ZWnuuXmX6H2czH9ki4WPqLVw2zf8Cn0o4SHMVkzclTc8itD/ui
	 O2JjubQ3XztdH3K5kO1hVvWxNcPDrYB0+5S3oyGgGb/gueJxxVmbIlw+70cDmByTk6
	 PSKCAsjuAjGLMvP+MDg0JYMOwTHJvdOGYltXfxxuiTQKE3liJYmWVa1eJeuTHHonNr
	 1kB0pBw37YgsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5902980BF5;
	Mon, 26 Oct 2026 22:37:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DE0C23422
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D018640541
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GA-6WX1xv9Yl for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 22:37:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B252340543
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793054236;
 b=pRhpu4qhMICrVsbYpAYVQJ0lZyiVsFpK8QsFLnMKED2h0iW1TwkvIQMYP98AA1xpvCkO
 nlwp95/nDys0QNDcH0cKYjgEWCaO7UR1FoX+UvVKJdGjG6MSG1wVnxctcwnp7e97DRLkX
 O2WZd/PMYEpoBrsF4xnfLrS9/ip/C0zQXsgnp8JAXsUT2nMNRqxWvEkq5DeiCg1/46Bbh
 1TbYGip6gN9hNxcrxiHodl7VG4KLWC06+1X2172KF5Axe7dE7OX1Cexuk7COz/Lo+JFgn
 m2S2kwJga79nqIZgau+qqD9XR4Gt66apQPT6CpVy14JpQWSJFEfX1wvOOGtfHfI+3Wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793054236;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=TF0/R1eqrutWjwgcw8aX9e1pnYyy5C9f/Cdd1ymwAEQ=;
 b=D6aXOa0NJNXXsPkam915CfAI2WeljIxFgOuty15kHaWCIszBSIkDq1Gjt0BUPFC6XUNw
 DNsxpg/jM+HBmSW2ldA3qNHnKb3W3GEv2GPfgHnbqJMHPdzNwZD+d4DHjCMLulpC0inMl
 jP9XywINLd+n/4GDrn43e4dHdLeu2mJ7xzvFmV2u9WMiu6kbDXlJdLrsiVslh0zYdcpjI
 T5u1N9yJfSSYEbb4QkrrRDH//rdhIBjBfg1akS0LjYovQpPprIta72ejK6nFGgMLUX0xE
 VIqzj54BFWt+HHRShSq927yN4xohkTTJPjBmQ2WL6i0tPix6UyNWb2ETiju2s/HeEQQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eQ5mks6d; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eQ5mks6d
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B252340543
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793054235; x=1824590235;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dYulTDc9w0lo2RXOMa5BeYcub/S5hCcI7q5H1VDBL7Q=;
 b=eQ5mks6dmtOIKx5paMkKldGUo2huX8z1971Pdmq+cSs+8LeGTTf6SToH
 mzh+GuqICguHqk8mvGpPf6sNNCrx9f13n7MIMljv60KRO6ZmBAUiS/2Jh
 daXmU+rlEAEthSBF9u15taUe8DmXKwomcu1oLMm3d6vG8ezyBaBbaDP+t
 sdegUqPlEVWAvNOLLLxEBquICyHd6CMpxMvLkgC/tiC1yFqQwFmXnPjgd
 VxHy0aSDz1P9axOZbFP2rcm4f5Lw/ywNlRG/mUcvprSitg55nKmVHJKih
 RTT6gwIDge+8OwtQpAB0hRb/8GYTZuJyDVwDUM/7Fz8NHTEuLrMrGspid A==;
X-CSE-ConnectionGUID: PIapcgv4SIWeDO5X/f89IA==
X-CSE-MsgGUID: 5pwMRnIVRzyqae+aBu0R9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1616400"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1616400"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:37:14 -0700
X-CSE-ConnectionGUID: ceN3VG+iQK2f2nTSKJm/Xw==
X-CSE-MsgGUID: Ywi5ya+SR1Wr5FnNIOy5JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6217176"
Received: from coyote-pass-p6-34563.jf.intel.com ([10.166.80.105])
 by fmviesa013.fm.intel.com with ESMTP; 26 Oct 2026 15:37:14 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: phani.r.burra@intel.com, larysa.zaremba@intel.com, joshua.a.hay@intel.com,
 horms@kernel.org
Subject: [PATCH iwl-net v2 3/4] libie: release all waiters once the
 transaction manager drains
Date: Mon, 26 Oct 2026 15:19:07 -0700
Message-Id: <20261026221908.24690-4-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20261026221908.24690-1-emil.s.tantilov@intel.com>
References: <20261026221908.24690-1-emil.s.tantilov@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

libie_ctlq_xn_shutdown() waits on xnm->can_destroy for the outstanding
transactions to be returned. libie_ctlq_xn_push_free() signals it with
complete() when the last entry goes back to the free bitmap. Once the
manager is shut down, libie_ctlq_xn_pop_free() hands out no more entries,
so that point is reached exactly once and only one waiter is woken.

Nothing restricts libie_ctlq_xn_shutdown() to a single caller, though.
If two threads call it while a transaction is still outstanding, both see
the entry in use and both wait, and the one that is not woken blocks
forever, as wait_for_completion() has no timeout.

A drained manager stays drained until libie_ctlq_xn_deinit() frees it, so
signal it with complete_all(). All callers waiting at that point are
released, and later ones find the bitmap full and return at once.

Signal it before free_xns_bm_lock is dropped. A caller that finds the
bitmap full then knows the completion has already been signalled. That
leaves libie_ctlq_xn_push_free() holding the lock after it has woken the
waiters, so have a woken waiter take and release free_xns_bm_lock before
it returns, the same lock/unlock pair completion_done() uses to wait for
complete(), see commit dec13c42d21a ("completion: Replace
spin_unlock_wait() with lock/unlock pair"). Its unlock is then the last
access to the manager by the time any caller returns.

The manager must still outlive every caller, since a woken waiter has to
retake the completion and bitmap locks before it returns. Spell that out
in the kernel-doc: libie_ctlq_xn_deinit() must not be called until every
libie_ctlq_xn_shutdown() caller has returned.

The next patch makes idpf call libie_ctlq_xn_shutdown() from its service
task, which can run concurrently with the reset and remove paths.

Fixes: b4ff4e626a7c ("libie: add bookkeeping support for control queue messages")
Assisted-by: LLM
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/libie/controlq.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index 6214fc036ce5f..9bcb022ed9782 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -735,13 +735,10 @@ static bool __libie_ctlq_xn_push_free(struct libie_ctlq_xn_manager *xnm,
 static void libie_ctlq_xn_push_free(struct libie_ctlq_xn_manager *xnm,
 				    struct libie_ctlq_xn *xn)
 {
-	bool can_destroy;
-
-	scoped_guard(spinlock, &xnm->free_xns_bm_lock)
-		can_destroy = __libie_ctlq_xn_push_free(xnm, xn);
+	guard(spinlock)(&xnm->free_xns_bm_lock);
 
-	if (can_destroy)
-		complete(&xnm->can_destroy);
+	if (__libie_ctlq_xn_push_free(xnm, xn))
+		complete_all(&xnm->can_destroy);
 }
 
 /**
@@ -1171,7 +1168,9 @@ EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_send_clean, "LIBIE_CP");
  * @xnm: pointer to the transaction manager
  *
  * Synchronously terminate existing transactions and stop accepting new ones.
- * Async transactions are discarded without invoking resp_cb.
+ * Async transactions are discarded without invoking resp_cb. May be called
+ * concurrently, libie_ctlq_xn_deinit() must not be called until every caller
+ * has returned.
  */
 void libie_ctlq_xn_shutdown(struct libie_ctlq_xn_manager *xnm)
 {
@@ -1218,8 +1217,12 @@ void libie_ctlq_xn_shutdown(struct libie_ctlq_xn_manager *xnm)
 
 	spin_unlock(&xnm->free_xns_bm_lock);
 
-	if (must_wait)
+	if (must_wait) {
 		wait_for_completion(&xnm->can_destroy);
+		/* Synchronize with libie_ctlq_xn_push_free() unlocking */
+		spin_lock(&xnm->free_xns_bm_lock);
+		spin_unlock(&xnm->free_xns_bm_lock);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_shutdown, "LIBIE_CP");
 
-- 
2.37.3

