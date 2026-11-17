Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C28606A32A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=qf/lEBst;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h8PNS0k6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C712A6090B;
	Tue, 17 Nov 2026 16:29:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bOOdBislyJMw; Tue, 17 Nov 2026 16:29:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A063760A40
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932951;
	b=VOOHGGtWvK+HKQkBC6iZl8OvJEqm/QIuoqi9Z61VuKmGB501qFfFTqP6lrdTRMezLyDB
	 NEGGpUjA8C1ZDItpZVZKgaVnYg/9UMF5t++Rspc1grtHBond2Mx70f4Yr/A2ub6naBJZ3
	 vNHeiM8meGF/zgIYRgVO80LPq83zPmUZY8ApOjxq40sNRK9bX7kTh2dOEHVaiX/uQjahn
	 PbdKDSDRWKIeeEYygJJ3Smq+Xi2ua94hm/gfZSDr+Kz7d9VS9vO/z6Ze8dLjiIpJ6oVzX
	 4qR+lLqjPRVnkEu9Aq8848Ru4FDlawbS834I+E6COv7sWMIkceqkeoyaM40DLsHouXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932951;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=f291SqQ6q+076z3UtQOZ+jJ9ozrVepELzwf6z3mqRLM=;
	b=LT5L4fpKsoEz9FGR6FVUTZWtsp5wiJJIp5bQ8UyTyWIAq/oJA9ICQTWxhkcfKAqLKciz
	 OKLRimH+HtI8O/s0z3zE31Q4OJ2guAwuciV9/zLGNokvkTYVXwL93aZRITmIDRL0llukA
	 S+YrEqVmclGljFSAYjA78NWDJv6Gim2QGyRU1FqucHLJ2E0K9OQ6QbUCKJ0SXJ1+aR3i4
	 ZGCXZtI1ZmhZS6KCTT/bRqu64a6+ZzTiLaq55KCLGA6KHUgKw55D2boy6PAP4IXgU7tUh
	 wpCr+sVhw6UUEDGlaqkuDlFt6Ixvgxu/v/YQDdTbNPshjWeUAUMPe/O6q2vZpRjDxbQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932951;
	bh=f291SqQ6q+076z3UtQOZ+jJ9ozrVepELzwf6z3mqRLM=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qf/lEBstsb2MhyPA2Uonf/aVaYmAoX/DZCYVU8cdehU3Dy8EfMkadEPTe90MTeGoS
	 PPjbaXDaKTCV+Kbl+MRQbSDzi6ebvLKhTE4gKkdFNZqXUwbApBJVkfCMCgkF6kIyXY
	 /cdzSGGWz3A/pDwgUzxKXNXUhoO8sLwUq2d3r9oxgKPa799uGCWDe21ma8oy+2i/nq
	 y2MuC2u1/hGLmPYJUm0NkZlNHmLk0VL8w9Mu4Lc98awOlZjmY497aKPQulQjb/0P2m
	 a2ItHaX2uFWEhSOM+artUuZaLRhGS1OY2KGMheccgRVHdKxSubOblSmn9wE/iNz/DI
	 EV8d9nZ8805uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A063760A40;
	Tue, 17 Nov 2026 16:29:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BFF5A70B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1E3E40333
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id agzCRVwdXPyd for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:55:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 73279400BB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b146"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b146; helo=mail-yx1-xb146.google.com;
 envelope-from=392r8agukdx4mn4hcaiiaf8.6igchn8f-qcl87-f4hfcmnm.imoimf.ila@flex--stani.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=h8PNS0k6
Received: from mail-yx1-xb146.google.com (mail-yx1-xb146.google.com
 [IPv6:2607:f8b0:4864:20::b146])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 73279400BB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:52 +0000 (UTC)
Received: by mail-yx1-xb146.google.com with SMTP id
 956f58d0204a3-6768601940bso1758213d50.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 06:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794927352; x=1795532152; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f291SqQ6q+076z3UtQOZ+jJ9ozrVepELzwf6z3mqRLM=;
 b=h8PNS0k6ArHoZwS1bAbgyGGsFSIYLLqbblLzGvwAWSQ6lPu1VKQAcP08uWtaiWH3cD
 pbHA8E3GsWDzVTkjGStx6Oy4K+0pz1mR5YglOR3Axkz767MOrls8JSKOZheGnfxgOsli
 kUDKT3KVj5FYdYbAhqlkPJyLy4D6KVl7fSomI+cVNHupzTiTu0v9gSr/WsQMeEqwjCQf
 /7Ynrw+BPN9cmNr9eDMWrpXmMxugnz+0S3mAr+L+L+qIuLyTAMw/OoBY7h9Gv71JYwpF
 iRiXHtLNs00y5WRmETjcN2XpxTvcK+QZDXZjtxaITN2NpLVPMHYsGAabZrVUG/1f3hiL
 8/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927352; x=1795532152;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f291SqQ6q+076z3UtQOZ+jJ9ozrVepELzwf6z3mqRLM=;
 b=IhYFDtmFDjD2ez6vqH/r9Vzm4fMzr2REXlVs0Za7Yc9JOsJnehRR6tbWgn53mtu/qT
 yPDj6nojUBH5q/wuI7pBrz3S0A51WpJ7A0xtyLIyN2wAReiHc7qA8oNG1uHXqbfE0+O+
 5tak3mUaoGOUiUzgOEYTzMXal+bVO9kr77SqhML0DYjJlRFQH0NsVouVq3dELyIsNZw/
 YXMPUVz1DnKnhN37TxIzelHxiCrwmJ88XjcIxIPLP3oMAOK+y+QGUhulXGWn6WXrXusL
 8uS3/2xBmMztAc0lYGR4xz0yhMH+QFcyUNDl166w3PvfuN32m4QeSlwtLQzMx7qpvTME
 LPZw==
X-Forwarded-Encrypted: i=1;
 AL+hErGIX724rd+k7h1IZano9eMqTZ0e6F+e4KTEoDF5L6JixWHifdZpbiElb9ILN5PJySWJ+cRyh/Zm0RvpOT1rfKk=@lists.osuosl.org
X-Gm-Message-State: APuU4Z92CK63Fxn6DR3e6xu/8KbP9/IV26oSb3jMmabAKC75Itc2jCrv
 79OR/5cnchmpKx/iJhKtneOCrgHGI5xtrmGyWdYrSQRl7kG3eYx326jkPGYRbaJWVTAuOzXZqCS
 5Cg==
X-Received: from yxqr13.prod.google.com ([2002:a53:a94d:0:b0:67b:ebbb:a796])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:47a0:20b0:67b:f56b:4a4f
 with SMTP id 956f58d0204a3-67dc772ee10mr1043899d50.26.1794927351439; Tue, 17
 Nov 2026 06:55:51 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:20 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-15-stani@google.com>
Subject: [PATCH iwl-next 14/15] idpf: psp: add support for psp tx key insertion
From: Stan Iliev <stani@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Decotigny <decot@google.com>, Madhu Chittim <madhu.chittim@intel.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Brian Vazquez <brianvv@google.com>, Li Li <boolli@google.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 17 Nov 2026 16:29:00 +0000
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for inserting TX keys into the SADB:
- Introduce struct virtchnl2_insert_psp_key and
  struct virtchnl2_psp_insert_keys_request.
- Add the insert queue, a list of the TX keys to insert with their SPI
  and key.
- Implement idpf_send_insert_psp_keys(), called from the PSP work,
  which inserts up to IDPF_PSP_INSERT_KEYS_MAX (101) queued TX keys
  with one asynchronous request. A request that couldn't be sent puts
  its keys back in the queue, they are sent again after a delay.
- Implement its response callback idpf_psp_insert_keys_cb(): the CP
  inserts the keys in request order and stops at the first failure,
  the keys without a valid SA index in the reply are failed. The
  callback queues the work again for the next request, so the work
  never waits for a reply.
- The keys are wiped once the request completed, the request buffer is
  freed with kfree_sensitive() by idpf_send_mb_msg_kfree().

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_psp.c    |  13 ++
 .../net/ethernet/intel/idpf/idpf_psp_def.h    |  12 +-
 .../ethernet/intel/idpf/idpf_psp_virtchnl.c   | 190 ++++++++++++++++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.h   |   1 +
 .../intel/idpf/idpf_psp_virtchnl_def.h        |   4 +
 include/linux/net/intel/virtchnl2.h           |  35 ++++
 6 files changed, 254 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
index 373edbef9a7e..95926ac99777 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -66,6 +66,7 @@ static void idpf_psp_work(struct work_struct *work)
 	    test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
 		return;
 
+	idpf_send_insert_psp_keys(adapter);
 	if (idpf_send_delete_psp_keys(adapter))
 		idpf_queue_psp_work(adapter);
 }
@@ -208,6 +209,7 @@ void idpf_psp_init(struct idpf_adapter *adapter)
 		INIT_DELAYED_WORK(&psp->work, idpf_psp_work);
 		spin_lock_init(&psp->insert_lock);
 		timer_setup(&psp->insert_timer, idpf_psp_insert_timeout, 0);
+		INIT_LIST_HEAD(&psp->ins_list);
 		psp->initialized = true;
 	}
 
@@ -266,6 +268,8 @@ void idpf_psp_quiesce(struct idpf_adapter *adapter)
 	spin_lock_bh(&psp->insert_lock);
 	req = psp->insert_req;
 	psp->insert_req = NULL;
+	list_splice_init(&psp->ins_list, &keys);
+	WRITE_ONCE(psp->ins_queued, 0);
 	spin_unlock_bh(&psp->insert_lock);
 
 	if (req) {
@@ -276,6 +280,12 @@ void idpf_psp_quiesce(struct idpf_adapter *adapter)
 		kfree(req);
 	}
 
+	list_for_each_entry_safe(key, tmp, &keys, ins_node) {
+		list_del_init(&key->ins_node);
+		idpf_psp_tx_key_failed(adapter, key);
+		idpf_psp_tx_key_put(key);
+	}
+
 	spin_lock_bh(&psp->del_lock);
 	list_splice_init(&psp->del_list, &keys);
 	spin_unlock_bh(&psp->del_lock);
@@ -322,6 +332,7 @@ struct idpf_psp_tx_key *idpf_psp_tx_key_alloc(void)
 	key->idx = IDPF_PSP_IDX_IN_PROG;
 	key->hw_idx = IDPF_PSP_IDX_NONE;
 	INIT_LIST_HEAD(&key->del_node);
+	INIT_LIST_HEAD(&key->ins_node);
 
 	return key;
 }
@@ -335,6 +346,8 @@ static void idpf_psp_tx_key_free(struct kref *ref)
 	struct idpf_psp_tx_key *key = container_of(ref, struct idpf_psp_tx_key,
 						   ref);
 
+	/* In case the key was never copied into an insert request */
+	memzero_explicit(key->key, sizeof(key->key));
 	/* The TX path may still read the SA index of the key */
 	kfree_rcu(key, rcu);
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
index 4c42755615cb..5af3347d9596 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
@@ -39,6 +39,9 @@
  * @idx: SA index the TX path uses, or IDPF_PSP_IDX_IN_PROG,
  *	 IDPF_PSP_IDX_ERROR or IDPF_PSP_IDX_DELETED. Read without @lock.
  * @hw_idx: SA index of the key in the SADB, IDPF_PSP_IDX_NONE if it has none
+ * @spi: SPI of the key
+ * @key: the key, wiped once copied into the insert request
+ * @ins_node: entry in the insert queue, see idpf_psp_queue_insert()
  * @del_node: entry in the delete queue, see idpf_psp_queue_delete()
  * @del_single: delete @hw_idx in a request of its own, after a request that
  *		failed
@@ -49,6 +52,9 @@ struct idpf_psp_tx_key {
 	spinlock_t lock;		/* protects the SA indexes and tx_queue */
 	u32 idx;
 	u32 hw_idx;
+	__be32 spi;
+	u8 key[VIRTCHNL2_PSP_KEY_SIZE_V0];
+	struct list_head ins_node;
 	struct list_head del_node;
 	bool del_single;
 	struct rcu_head rcu;
@@ -122,10 +128,12 @@ struct idpf_psp_rx_gen {
  * @del_list: TX keys whose SA index is queued for deletion
  * @wq: workqueue of @work
  * @work: sends the insertion and deletion requests
- * @insert_lock: protects @insert_req
+ * @insert_lock: protects @insert_req, @ins_list and @ins_queued
  * @insert_req: the VIRTCHNL2_OP_PSP_INSERT_KEYS request in flight, if any
  * @insert_timer: makes the mailbox task time out a lost insert request,
  *		  see idpf_psp_insert_timeout()
+ * @ins_list: TX keys queued for insertion
+ * @ins_queued: number of keys in @ins_list
  * @keys_allocated: RX keys allocated
  * @keys_inserted: TX keys inserted into the SADB
  * @insert_errors: TX keys whose insertion failed
@@ -162,6 +170,8 @@ struct idpf_adapter_psp {
 	spinlock_t insert_lock;		/* protects the insertions */
 	struct idpf_psp_insert_req *insert_req;
 	struct timer_list insert_timer;
+	struct list_head ins_list;
+	u32 ins_queued;
 	atomic_t keys_allocated;
 	atomic_t keys_inserted;
 	atomic_t insert_errors;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
index e813dca8961d..480b56ce8164 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
@@ -559,6 +559,79 @@ bool idpf_send_delete_psp_keys(struct idpf_adapter *adapter)
 	return false;
 }
 
+/**
+ * idpf_psp_insert_keys_cb - VIRTCHNL2_OP_PSP_INSERT_KEYS response callback
+ * @ctx: struct idpf_psp_insert_req of the request
+ * @buff: reply, NULL if the request timed out
+ * @status: 0 on success, -EFAULT if the CP failed the request, -ETIMEDOUT if
+ *	    the request timed out
+ *
+ * libie calls the response callback once per request that was sent, except on
+ * shutdown, see idpf_psp_quiesce(). It is called from the mailbox task with the
+ * transaction locked, it must not sleep. The CP inserts the keys in request
+ * order and stops at the first failure: the keys without an SA index in the
+ * reply failed.
+ */
+static void idpf_psp_insert_keys_cb(void *ctx, struct kvec *buff, int status)
+{
+	const struct virtchnl2_psp_insert_keys_response *resp = NULL;
+	struct idpf_psp_insert_req *req = ctx;
+	struct idpf_adapter *adapter = req->adapter;
+	struct idpf_adapter_psp *psp = &adapter->psp;
+	u32 i, num_sa_indexes = 0;
+
+	if (!status) {
+		size_t reply_sz = buff && buff->iov_base ? buff->iov_len : 0;
+
+		if (reply_sz >= sizeof(*resp)) {
+			resp = buff->iov_base;
+			num_sa_indexes = min3(le32_to_cpu(resp->num_sa_indexes),
+					      (u32)((reply_sz - sizeof(*resp)) /
+						    sizeof(resp->sa_indexes[0])),
+					      req->num_keys);
+		} else {
+			net_warn_ratelimited("%s: short reply %zu\n", __func__,
+					     reply_sz);
+		}
+	} else {
+		net_warn_ratelimited("%s: request %s\n", __func__,
+				     status == -ETIMEDOUT ? "timed out" :
+							    "failed");
+	}
+
+	spin_lock_bh(&psp->insert_lock);
+	if (psp->insert_req == req)
+		psp->insert_req = NULL;
+	spin_unlock_bh(&psp->insert_lock);
+	timer_delete(&psp->insert_timer);
+
+	for (i = 0; i < req->num_keys; i++) {
+		struct idpf_psp_tx_key *key = req->keys[i];
+		u32 saidx = IDPF_PSP_IDX_NONE;
+
+		if (i < num_sa_indexes)
+			saidx = le32_to_cpu(resp->sa_indexes[i]);
+
+		if (idpf_psp_saidx_ok(adapter, saidx)) {
+			idpf_psp_tx_key_inserted(adapter, key, saidx);
+		} else {
+			if (i < num_sa_indexes)
+				net_warn_ratelimited("%s: invalid SA index %u\n",
+						     __func__, saidx);
+			idpf_psp_tx_key_failed(adapter, key);
+		}
+
+		/* The key was copied into the request */
+		memzero_explicit(key->key, sizeof(key->key));
+		idpf_psp_tx_key_put(key);
+	}
+
+	kfree(req);
+
+	/* Send the next request */
+	idpf_queue_psp_work(adapter);
+}
+
 /**
  * idpf_psp_insert_late - Delete the SA indexes of a late insertion reply
  * @adapter: Driver specific private structure
@@ -600,6 +673,123 @@ static void idpf_psp_insert_late(struct idpf_adapter *adapter,
 	}
 }
 
+/**
+ * idpf_psp_insert_requeue - Queue the TX keys of an unsent request again
+ * @adapter: Driver specific private structure
+ * @req: insert request that couldn't be sent
+ *
+ * The keys are sent again after a delay, see idpf_retry_psp_work().
+ */
+static void idpf_psp_insert_requeue(struct idpf_adapter *adapter,
+				    struct idpf_psp_insert_req *req)
+{
+	struct idpf_adapter_psp *psp = &adapter->psp;
+	u32 i;
+
+	spin_lock_bh(&psp->insert_lock);
+	if (psp->insert_req == req)
+		psp->insert_req = NULL;
+	/* In request order, at the head of the queue */
+	for (i = req->num_keys; i; i--)
+		list_add(&req->keys[i - 1]->ins_node, &psp->ins_list);
+	WRITE_ONCE(psp->ins_queued, psp->ins_queued + req->num_keys);
+	spin_unlock_bh(&psp->insert_lock);
+
+	kfree(req);
+	idpf_retry_psp_work(adapter);
+}
+
+/**
+ * idpf_send_insert_psp_keys - Insert queued TX keys into the SADB
+ * @adapter: Driver specific private structure
+ *
+ * Send one asynchronous VIRTCHNL2_OP_PSP_INSERT_KEYS request for the TX keys
+ * queued by idpf_psp_queue_insert(), at most as many as fit in one message.
+ * At most one request is in flight: the response callback queues the PSP work
+ * again, see idpf_psp_insert_keys_cb(). Called from the PSP work.
+ */
+void idpf_send_insert_psp_keys(struct idpf_adapter *adapter)
+{
+	struct libie_ctlq_xn_send_params xn_params = {
+		.chnl_opcode	= VIRTCHNL2_OP_PSP_INSERT_KEYS,
+		.timeout_ms	= IDPF_VC_XN_PSP_RESPONSE_TIMEOUT_MSEC,
+		.resp_cb	= idpf_psp_insert_keys_cb,
+	};
+	struct virtchnl2_psp_insert_keys_request *key_req;
+	struct idpf_adapter_psp *psp = &adapter->psp;
+	struct idpf_psp_insert_req *req;
+	u32 i, num_keys;
+	size_t buf_size;
+	int err;
+
+	BUILD_BUG_ON(struct_size_t(struct virtchnl2_psp_insert_keys_request,
+				   keys, IDPF_PSP_INSERT_KEYS_MAX) >
+		     LIBIE_CTLQ_MAX_BUF_LEN);
+
+	spin_lock_bh(&psp->insert_lock);
+	num_keys = psp->insert_req ? 0 :
+		   min_t(u32, psp->ins_queued, IDPF_PSP_INSERT_KEYS_MAX);
+	spin_unlock_bh(&psp->insert_lock);
+	if (!num_keys)
+		return;
+
+	req = kzalloc(struct_size(req, keys, num_keys), GFP_KERNEL);
+	if (!req) {
+		idpf_retry_psp_work(adapter);
+		return;
+	}
+
+	req->adapter = adapter;
+
+	/* Keys may have been deleted meanwhile */
+	spin_lock_bh(&psp->insert_lock);
+	req->num_keys = min(num_keys, psp->ins_queued);
+	for (i = 0; i < req->num_keys; i++) {
+		req->keys[i] = list_first_entry(&psp->ins_list,
+						struct idpf_psp_tx_key,
+						ins_node);
+		list_del_init(&req->keys[i]->ins_node);
+	}
+	WRITE_ONCE(psp->ins_queued, psp->ins_queued - req->num_keys);
+	if (req->num_keys)
+		psp->insert_req = req;
+	spin_unlock_bh(&psp->insert_lock);
+
+	if (!req->num_keys) {
+		kfree(req);
+		return;
+	}
+
+	buf_size = struct_size(key_req, keys, req->num_keys);
+	key_req = kzalloc(buf_size, GFP_KERNEL);
+	if (!key_req) {
+		idpf_psp_insert_requeue(adapter, req);
+		return;
+	}
+
+	key_req->vport_id = cpu_to_le32(READ_ONCE(psp->vport_id));
+	key_req->num_keys = cpu_to_le32(req->num_keys);
+	/* key_req->domain stays zeroed: VIRTCHNL2_PSP_DOMAIN_NONE */
+	for (i = 0; i < req->num_keys; i++) {
+		key_req->keys[i].spi = cpu_to_le32(be32_to_cpu(req->keys[i]->spi));
+		key_req->keys[i].key_type = VIRTCHNL2_PSP_KEY_TYPE_V0;
+		memcpy(key_req->keys[i].v0_key, req->keys[i]->key,
+		       VIRTCHNL2_PSP_KEY_SIZE_V0);
+	}
+
+	/* The request can complete as soon as it is sent */
+	xn_params.send_ctx = req;
+	idpf_psp_insert_timer_arm(adapter, xn_params.timeout_ms);
+	err = idpf_send_mb_msg_kfree(adapter, &xn_params, key_req, buf_size);
+	if (err) {
+		/* libie only calls the response callback of sent requests */
+		timer_delete(&psp->insert_timer);
+		net_warn_ratelimited("%s: request not sent: %d\n", __func__,
+				     err);
+		idpf_psp_insert_requeue(adapter, req);
+	}
+}
+
 /**
  * idpf_psp_recv_late_reply - Handle a late reply to a PSP request
  * @adapter: Driver specific private structure
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
index 8d8ce4478842..0013a9134cfc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
@@ -18,5 +18,6 @@ int idpf_psp_rotation_request(struct idpf_adapter *adapter);
 int idpf_send_get_psp_global_stats(struct idpf_adapter *adapter,
 				   struct virtchnl2_psp_global_stats_response *stats);
 bool idpf_send_delete_psp_keys(struct idpf_adapter *adapter);
+void idpf_send_insert_psp_keys(struct idpf_adapter *adapter);
 
 #endif /* !_IDPF_PSP_VIRTCHNL_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl_def.h
index 69a61fa421e0..76b00946119b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl_def.h
@@ -12,6 +12,10 @@
 /* PSP key insertion and deletion requests must fit in one mailbox buffer,
  * which limits the number of TX keys and SA indexes per request.
  */
+#define IDPF_PSP_INSERT_KEYS_MAX					\
+	((LIBIE_CTLQ_MAX_BUF_LEN -					\
+	  sizeof(struct virtchnl2_psp_insert_keys_request)) /		\
+	 sizeof(struct virtchnl2_insert_psp_key))
 #define IDPF_PSP_DELETE_KEYS_MAX					\
 	((LIBIE_CTLQ_MAX_BUF_LEN -					\
 	  sizeof(struct virtchnl2_psp_delete_keys_request)) /		\
diff --git a/include/linux/net/intel/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
index b8940e33fd04..225ddee93409 100644
--- a/include/linux/net/intel/virtchnl2.h
+++ b/include/linux/net/intel/virtchnl2.h
@@ -1992,6 +1992,41 @@ struct virtchnl2_psp_allocate_keys_response {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_psp_allocate_keys_response);
 
+/**
+ * struct virtchnl2_insert_psp_key - PSP TX key entry to insert into SADB
+ * @spi: Security parameter index
+ * @key_type: See enum virtchnl2_psp_key_type
+ * @pad: Reserved/padding
+ * @v0_key: 128-bit key for V0
+ * @v1_key: 256-bit key for V1
+ */
+struct virtchnl2_insert_psp_key {
+	__le32 spi;
+	u8 key_type;
+	u8 pad[3];
+	union {
+		u8 v0_key[VIRTCHNL2_PSP_KEY_SIZE_V0];
+		u8 v1_key[VIRTCHNL2_PSP_KEY_SIZE_V1];
+	};
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(40, virtchnl2_insert_psp_key);
+
+/**
+ * struct virtchnl2_psp_insert_keys_request - Insert PSP TX keys request
+ * @vport_id: Virtual port ID
+ * @num_keys: Number of keys to insert
+ * @domain: Key domain, must be zero-filled if VIRTCHNL2_CAP_PSP_DOMAIN was
+ *	    not granted
+ * @keys: Flexible array of keys to insert
+ */
+struct virtchnl2_psp_insert_keys_request {
+	__le32 vport_id;
+	__le32 num_keys;
+	struct virtchnl2_psp_key_domain domain;
+	struct virtchnl2_insert_psp_key keys[] __counted_by_le(num_keys);
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_psp_insert_keys_request);
+
 /**
  * struct virtchnl2_psp_insert_keys_response - Insert PSP TX keys response
  * @vport_id: Virtual port ID
-- 
2.56.0.679.gc527c65306-goog

