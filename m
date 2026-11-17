Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6835606A32A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xXxbViqg;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EvE76S02
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97C67408FB;
	Tue, 17 Nov 2026 16:29:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lP22Em-y08Z8; Tue, 17 Nov 2026 16:29:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74AFC4094B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932952;
	b=SCkC6BqVErVYbnVe4VXJ/+YHBXtx8z5eEcYeK7M3sKTmKZUCF0YVtSDhWRNjWlbS3b8A
	 +23hYHnxNIhv3FmJw7sfRKjt0QJaaPi4ll+Hk+NaDTfjWgOGIdXts9Wfkk0F7QvU6ux44
	 +ffYQgSyuMyb/qZq4Wa4N6pOEyhn7P3fZ04C4QeBMlakG5mxXYoy5Y4UB2dX7M8Y42kNq
	 1Nb6PzvXeD9TyG70imogF6C8QhDQzMw+/88T9kpA+cSefOTJR4oNlCHxK3DwIT9rL6ffj
	 BqplJ5xV2TDFYt3u0CP0o0fIR8VvPnSt1Vy9maVAGMtaqIzouztKtUSj4hik766KsBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932952;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=j/02eyou4M60KpUrF8lLMNeinWTXVYjClptMJA9JWgg=;
	b=B3tmkrV2ao8qG0Z0mB3Oz4/oMKP2RVDIltCaomx5TyzUddQDBWWtLASDcCNgo76Pzkh7
	 kfFsKFt48CEAVn2oyKxpBMsf6KACR4DwlnXGC4btwh1jyGQ0jmqNIsqbWnpUtRBtqHtED
	 vgF9JCK2y3oc/fADCPJoRJnUwXPVzn+PN2hevTffOCBEnZz47brZh7KXBR15QMFzP3Rru
	 DSlqG+0+L0JfEEh9GnzdfUJShfFzLrFQY/UF1wZMlTi42pBvPbzS9ZYbVPKagjgXt4Fq5
	 i+MZx2fK3Phj1R4xGdiEv1nBd4LYJT1HOjAOWn2DxYYaD/+zrfm/WeGhfvz+6ZB/TcQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EvE76S02;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932952;
	bh=j/02eyou4M60KpUrF8lLMNeinWTXVYjClptMJA9JWgg=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xXxbViqg+tPMMJvTwxvXLmUgz5SCwR38pXbsLCKoxZW8hbdtLX1LE0jkDKSewgcj5
	 DPcok85S9gVPZQQDWL05rhIoQTGPD1A/nX3C4HOuz0cVh2iopmDDoyvY73iNC1+4UL
	 +yKAiGugYO92PNzv41rGG0ifDUCcKRT5rio5hQCN4Zd6Bjo4bP7AU7in3VRlTKvBUO
	 KvOFhSumHyknyV8mFc6B7Dt9K445ylZzUCji0UhxL2x1xg7+yptgYbrdnuk8A8MFZJ
	 /CDI5EYv3xK+XzF37ctmqsuk/yHS3Qoh1iz3vHw+Pt/GgNXHee0bCOpAVrGko/G+6k
	 x3qUjh94FZWHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74AFC4094B;
	Tue, 17 Nov 2026 16:29:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7079370B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56560408B5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fS0sIWX7RRVG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:55:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 68D6D40897
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1145"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1145; helo=mail-yw1-x1145.google.com;
 envelope-from=3-gr8agukdx8no5idbjjbg9.7jhdio9g-rdm98-g5igdnon.jnpjng.jmb@flex--stani.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=EvE76S02
Received: from mail-yw1-x1145.google.com (mail-yw1-x1145.google.com
 [IPv6:2607:f8b0:4864:20::1145])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68D6D40897
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:53 +0000 (UTC)
Received: by mail-yw1-x1145.google.com with SMTP id
 00721157ae682-8b4e8af48c8so21009047b3.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 06:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794927352; x=1795532152; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j/02eyou4M60KpUrF8lLMNeinWTXVYjClptMJA9JWgg=;
 b=EvE76S02lzLoeQQ8Px1uIKiweE+G90yv/pX/AaPrfwbrk3XJfsu1Bbq+nKAMLF2yD6
 RmryvQ2z6g5p0LsFs5aVQ0wUrZ09NtzsBBfSu4frr03lwxIe/hTIMrlTid3gZBTSD+Yc
 RzqTaspbyp+PBmG0v4rWanXs8/O07YGYafIa0YoUWhTjUYL0hQXtexSfth2CHcpgdvEm
 /SQf7QCiEiCPqNj+lRQ4yVwX8+icmE26ryYMPsED8hgZMCKupA/V7JSVUz2AWaPoLkku
 tq/2Z/y3sA1hMjaY9tD2BoESV9G8Njmky3f1QQDNeFKmynePbHKebLZA2xFDgqFSoy8r
 ZWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927352; x=1795532152;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j/02eyou4M60KpUrF8lLMNeinWTXVYjClptMJA9JWgg=;
 b=o+ljvivqHDubJS831e+pYJLK3tXjLNJUrfXtw6eZslXCwsAx2wIWYUPDSB6PfyJB+p
 QTkjR6KcigfxIsPe9JNLzbGE/ujSkIwuInttzcl2TkBCsFja3bGScZyGF2dBZbqMiSgY
 OJa9DSCqrobJnq4HGaBXQjWlWPqO5hBQxXeXsp+Pl+MtX24734zZF5K8YoVnsAFWYuiT
 m3+hFuO1c9P/8Id143B9bFWGwAcH6VVsFrM/bHyGjPeQRfdZbg68c6ysI3fAebZ29kGJ
 JZNF62B6HepKFsYJRKH3EGZTmWtHMA0CQP/JG8djacoV17K8cVhUkDJMWcpk/oRNy74H
 NYeA==
X-Forwarded-Encrypted: i=1;
 AL+hErEL1mUW6dNbvQdyhWE3INJT3iUM/SUlLrwydcO+Prd5mbzTbVv0CgzdNVWj8C8+658lu9qox44txrJR0c2oerk=@lists.osuosl.org
X-Gm-Message-State: APuU4Z935j4sJz27WhHAiCBWJnC5nEKLBhChiFC0nuBlT8JsNqMf43Tl
 mrNlzOIv7f8hzCAjA+jHYfOlFT44wOT88F70WtTIcja+pxpdbF2T4NimTu8aqza3gfdiQr+aRpx
 AFg==
X-Received: from ywzz28.prod.google.com ([2002:a05:690c:a71c:b0:8ab:3345:c617])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:e64b:b0:8b0:d9ff:4f74
 with SMTP id 00721157ae682-8b4aa32e148mr55968407b3.42.1794927352263; Tue, 17
 Nov 2026 06:55:52 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:21 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-16-stani@google.com>
Subject: [PATCH iwl-next 15/15] idpf: psp: add psp tx key registration
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

Add idpf_psp_queue_insert(), which queues a TX key for insertion:
- The key reserves a SADB entry, released if the insertion fails, or
  once its SA index was deleted. An SA index that couldn't be deleted
  keeps its SADB entry, as does the SA index of a late insertion reply
  until it is deleted.
- New keys are refused with -ENOSPC once the SADB or the insert queue
  (IDPF_PSP_INS_QUEUE_MAX keys) is full.
- The RX SPI allocation refuses the RX keys of new connections then,
  instead of failing their TX keys later.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 62 +++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_psp.h    |  2 +
 .../net/ethernet/intel/idpf/idpf_psp_def.h    |  4 ++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.c   |  4 ++
 4 files changed, 72 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
index 95926ac99777..1dfec4177c43 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -11,6 +11,9 @@
 /* Delay before the PSP work sends again a request that couldn't be sent */
 #define IDPF_PSP_RETRY_MSEC		100
 
+/* Maximum number of TX keys queued for insertion */
+#define IDPF_PSP_INS_QUEUE_MAX		1024
+
 /**
  * idpf_queue_psp_work - Queue the PSP work
  * @adapter: private data struct
@@ -237,6 +240,8 @@ void idpf_psp_init(struct idpf_adapter *adapter)
 	atomic_set(&psp->keys_inserted, 0);
 	atomic_set(&psp->insert_errors, 0);
 	atomic_set(&psp->insert_late, 0);
+	atomic_set(&psp->sadb_used, 0);
+	atomic_set(&psp->keys_refused, 0);
 
 	WRITE_ONCE(psp->enabled, true);
 }
@@ -436,6 +441,8 @@ void idpf_psp_tx_key_failed(struct idpf_adapter *adapter,
 			    struct idpf_psp_tx_key *key)
 {
 	atomic_inc(&adapter->psp.insert_errors);
+	/* The SADB entry reserved for the key wasn't used */
+	atomic_dec(&adapter->psp.sadb_used);
 
 	spin_lock_bh(&key->lock);
 	if (key->idx == IDPF_PSP_IDX_IN_PROG)
@@ -443,6 +450,54 @@ void idpf_psp_tx_key_failed(struct idpf_adapter *adapter,
 	spin_unlock_bh(&key->lock);
 }
 
+/**
+ * idpf_psp_sadb_full - Check if new PSP keys must be refused
+ * @adapter: private data struct
+ *
+ * Return: true if the SADB or the insertion queue is full, false otherwise.
+ */
+static bool idpf_psp_sadb_full(struct idpf_adapter *adapter)
+{
+	/* sadb_entries fits in 26 bits, see idpf_psp_negotiate_caps() */
+	return atomic_read(&adapter->psp.sadb_used) >=
+	       (int)adapter->psp.sadb_entries ||
+	       READ_ONCE(adapter->psp.ins_queued) >= IDPF_PSP_INS_QUEUE_MAX;
+}
+
+/**
+ * idpf_psp_queue_insert - Queue a TX key for insertion into the SADB
+ * @adapter: private data struct
+ * @key: the TX key, with its SPI and key set
+ *
+ * Reserve a SADB entry for the key and queue it for insertion. The PSP work
+ * inserts the queued keys, see idpf_send_insert_psp_keys(), and releases the
+ * reference taken on @key once the insertion completed.
+ *
+ * Return: 0 on success, -ENOSPC if the SADB or the insertion queue is full.
+ */
+int idpf_psp_queue_insert(struct idpf_adapter *adapter,
+			  struct idpf_psp_tx_key *key)
+{
+	struct idpf_adapter_psp *psp = &adapter->psp;
+
+	spin_lock_bh(&psp->insert_lock);
+	if (idpf_psp_sadb_full(adapter)) {
+		spin_unlock_bh(&psp->insert_lock);
+		atomic_inc(&psp->keys_refused);
+		return -ENOSPC;
+	}
+
+	atomic_inc(&psp->sadb_used);
+	idpf_psp_tx_key_get(key);
+	list_add_tail(&key->ins_node, &psp->ins_list);
+	WRITE_ONCE(psp->ins_queued, psp->ins_queued + 1);
+	spin_unlock_bh(&psp->insert_lock);
+
+	idpf_queue_psp_work(adapter);
+
+	return 0;
+}
+
 /**
  * idpf_psp_set_config - Set the PSP device configuration
  * @psd: PSP device
@@ -515,6 +570,13 @@ static int idpf_psp_rx_spi_alloc(struct psp_dev *psd, u32 version,
 		return -EOPNOTSUPP;
 	}
 
+	/* Refuse new connections whose TX key couldn't be inserted */
+	if (idpf_psp_sadb_full(adapter)) {
+		atomic_inc(&adapter->psp.keys_refused);
+		NL_SET_ERR_MSG_MOD(extack, "PSP SADB full");
+		return -ENOSPC;
+	}
+
 	err = idpf_send_allocate_psp_key(adapter, &rx_key);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed to allocate RX SPI and key");
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.h b/drivers/net/ethernet/intel/idpf/idpf_psp.h
index 0b2ae019b4a0..377cd4889f51 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.h
@@ -59,6 +59,8 @@ void idpf_psp_tx_key_inserted(struct idpf_adapter *adapter,
 			      struct idpf_psp_tx_key *key, u32 saidx);
 void idpf_psp_tx_key_failed(struct idpf_adapter *adapter,
 			    struct idpf_psp_tx_key *key);
+int idpf_psp_queue_insert(struct idpf_adapter *adapter,
+			  struct idpf_psp_tx_key *key);
 
 #else /* !CONFIG_INET_PSP */
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
index 5af3347d9596..449bcb3c9ee2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
@@ -134,6 +134,7 @@ struct idpf_psp_rx_gen {
  *		  see idpf_psp_insert_timeout()
  * @ins_list: TX keys queued for insertion
  * @ins_queued: number of keys in @ins_list
+ * @sadb_used: SADB entries used, or reserved by keys queued for insertion
  * @keys_allocated: RX keys allocated
  * @keys_inserted: TX keys inserted into the SADB
  * @insert_errors: TX keys whose insertion failed
@@ -141,6 +142,7 @@ struct idpf_psp_rx_gen {
  * @keys_removed: SA indexes deleted
  * @keys_lost: SA indexes that couldn't be deleted
  * @del_retries: SA indexes retried after a failed deletion request
+ * @keys_refused: RX and TX keys refused, SADB or insertion queue full
  * @psp_dev: the PSP device, see idpf_psp_register()
  * @caps: capabilities of @psp_dev
  */
@@ -172,6 +174,7 @@ struct idpf_adapter_psp {
 	struct timer_list insert_timer;
 	struct list_head ins_list;
 	u32 ins_queued;
+	atomic_t sadb_used;
 	atomic_t keys_allocated;
 	atomic_t keys_inserted;
 	atomic_t insert_errors;
@@ -179,6 +182,7 @@ struct idpf_adapter_psp {
 	atomic_t keys_removed;
 	atomic_t keys_lost;
 	atomic_t del_retries;
+	atomic_t keys_refused;
 	struct psp_dev *psp_dev;
 	struct psp_dev_caps caps;
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
index 480b56ce8164..0843f8e0ffea 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
@@ -416,6 +416,7 @@ static void idpf_psp_delete_done(struct idpf_adapter *adapter,
 	struct idpf_psp_tx_key *key, *tmp;
 
 	atomic_add(removed, &adapter->psp.keys_removed);
+	atomic_sub(removed, &adapter->psp.sadb_used);
 	if (lost) {
 		atomic_add(lost, &adapter->psp.keys_lost);
 		net_warn_ratelimited("%s: %u SA indexes couldn't be deleted\n",
@@ -661,6 +662,8 @@ static void idpf_psp_insert_late(struct idpf_adapter *adapter,
 			continue;
 
 		atomic_inc(&adapter->psp.insert_late);
+		/* The SA index is used until it is deleted */
+		atomic_inc(&adapter->psp.sadb_used);
 		key = idpf_psp_tx_key_alloc();
 		if (!key) {
 			atomic_inc(&adapter->psp.keys_lost);
@@ -826,6 +829,7 @@ void idpf_psp_recv_late_reply(struct idpf_adapter *adapter,
 				max(atomic_read(&adapter->psp.keys_lost), 0));
 		atomic_sub(deleted, &adapter->psp.keys_lost);
 		atomic_add(deleted, &adapter->psp.keys_removed);
+		atomic_sub(deleted, &adapter->psp.sadb_used);
 		break;
 	case VIRTCHNL2_OP_PSP_INSERT_KEYS:
 		if (idpf_is_psp_ena(adapter) && !ctlq_msg->chnl_retval)
-- 
2.56.0.679.gc527c65306-goog

