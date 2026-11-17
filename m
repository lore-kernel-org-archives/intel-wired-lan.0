Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97A5606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mX86fXjU;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=op1rLTqn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C862C4091C;
	Tue, 17 Nov 2026 16:29:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R4-mEdoKPlQM; Tue, 17 Nov 2026 16:29:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0221040945
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932955;
	b=DHYZjXqXVwOpwPzqtz1w86YwF6rwre96en5nLb8WovwPm3XFgqjuz1UrEYNsF1RIYTBg
	 R++3lVPmG6EjK5uAL/NTGAy1SGjetsC5XIr8Uj0M82fakjle25YiEj3xWIgkCn0uDt90r
	 0z2omcryhyiIlhfuk5TOnoGOpQSoluKJC3VEF+u+ExakyrpvDMGJFbnGJftQoDBV/pKST
	 Vct1M2hQj5xWKLNr9b1t5EsS2mHVIIUzGuf5oeOuv5Ig5sxC3OCTufINL5Bu4rugipNyn
	 /6I01SKqNvc/mDPOys1uhR5S3oF/fxncxldUWwt1at9Sn6C0cOXtjmqK7elRklib5cA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932955;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=N2W1vGbTN1fxXgYMzqAEGGqqwODSJcSkIJEHTLlETcw=;
	b=ISvX6sEulMwHDTGw3H/SKQrjJoTDra6r4FFbAFwOkeOnkF/z4/tRLDAe4iOyPUSlevWF
	 ZAb3z1aCU+WmD1gkt20lBIYR12kmAyOZoU45hJFR9oz0Vy3qguWwJjJ4V9t7eYUKKMX1/
	 dv7ASdwxselOKYjnvdGsaZewvzcFT1wr5g0I6+C9FRfQn0TjKtzvKlSpwCJy2G2m3mq/P
	 su6QFzJzn0I37BNc03GGvYvL78QZ5Tsb24z2ayrsb+7Ed+Duv3g0UrpUAS9fPsHSi0BpU
	 q7hZK1BHlYARf1Gd6pPpLtzO78wj48ZuG0PVhVru5EUqqHcf7R8WuI4E+BSUvGgci6A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932955;
	bh=N2W1vGbTN1fxXgYMzqAEGGqqwODSJcSkIJEHTLlETcw=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mX86fXjUENSoDi2dTsIdUo26dPrRFht3wl6Jjezy2lfzPCfBYX/eIHFxObwcqtyqM
	 XPn/L3q9KVNVY5xu8J9bXe4JYLfLegpRm3j7JH31EFiCnZgVsmfDOyiuhHOQ/mDQK2
	 h1M9IBn5AHOl12dM5oF7dU+/QRxkVHDU24lNUW0pBJ/dXof1eK6NYfk7oBvXF6lTjw
	 eoZ2yBoltf8Cc1r6uduM/HKBC1+TxVKXbX59dBk+9JuyDU2to7YF2mwriOnGsZkK6+
	 a7D/d8l05LtENw60V5EgxONBkV6QSt8ysS//z0UXgP6enqRvNKxQTfy+6mvFRlBfLo
	 BUa4uk+FquYhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0221040945;
	Tue, 17 Nov 2026 16:29:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B69BDD6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9FAB608EF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 66snVK_f4Uef for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:55:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C07A0608EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b145"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b145; helo=mail-yx1-xb145.google.com;
 envelope-from=39gr8agukdxsjk1e97ff7c5.3fd9ek5c-n9i54-c1ec9jkj.fjlfjc.fi7@flex--stani.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=op1rLTqn
Received: from mail-yx1-xb145.google.com (mail-yx1-xb145.google.com
 [IPv6:2607:f8b0:4864:20::b145])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C07A0608EA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:50 +0000 (UTC)
Received: by mail-yx1-xb145.google.com with SMTP id
 956f58d0204a3-67dabc6d5dfso4626943d50.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 06:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794927349; x=1795532149; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N2W1vGbTN1fxXgYMzqAEGGqqwODSJcSkIJEHTLlETcw=;
 b=op1rLTqncqqRuPeNHry0kK8qDZ3dk9Qb2U+p8IwJqbRV+ncvk08Btkkq+naiAiib+7
 hxH+IprPnJVt7lBgQZHsQqxnpZT08KmHWH+OVBKsMtkz0juKoAWrAqcW9YagfG4nXDaj
 bsyaZIRL3QAwFSbj37XUKoK7yZWBYt5CBT+hrlbkr/aNGcJMevqs3mE+CGsh0cOd/yAd
 GwH2J8mOXXvw3YYEF4SMEdIEqxR9wvuQJeqTPDBzyp/mjS8aRfgcLuBMmS4u5e3yuaaU
 SQy/rbuGxA1eiosmHcJb8UnoL4gamEknBbBOacSSYXlG4kAPVuYQ6BklvsZqGLF9Et9R
 gAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927349; x=1795532149;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N2W1vGbTN1fxXgYMzqAEGGqqwODSJcSkIJEHTLlETcw=;
 b=FJ7+prZ6t6M+hXRCS/GV8OOTYl3o6TN62UIji/cxltlExud5umVSDl85duUyPZpOu+
 I+qcxsIZANtZzN2dqlNxTLA2IEVW/0SbPBhbpuXjdkojuvJ7Ikby8jT/MKwJIQOcXisX
 h/yviLDLwelSuRlwYDyuLS2+SiaoXfYPXTthIrvLscIJnDrtBOemtcEJCMhdUcQ9K9ON
 shCfDhGhgdvTGs/6zSLmrIqXIU0mtxQp4ZCuTXgFfLByDyce3tDJHqkqUlj4k49umS/K
 sRd254mC1YwxHmczS0njxdbYKhjf1nUnV7wPw93eNb7PsPnLy+opw6rmKrCZsTVTzvfx
 +QqA==
X-Forwarded-Encrypted: i=1;
 AL+hErFcvk0VpFe32jCtjgg5gtRfUo9Ikpn2vDxtXcKgtsjcQs0nZntdyA7j9GvSwPUGx0/AwiO8eySIV/X1QbgA74s=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/oh3bebhwBIEte4YxCjEMMDHBG+WKB2F5Vmr2BqwrQIglX8Xw6
 4p1ktklIaw3d6ICfDh8uVIieG9aywZhwoL6jrPIWwUsHXJrPs1zYiBB6pPh7aKsSoBwHQG+QreX
 RYA==
X-Received: from yxbv18.prod.google.com ([2002:a05:690e:7d2:b0:675:604a:47fe])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:d8f:b0:67c:8ea:be13
 with SMTP id 956f58d0204a3-67d896a0ae3mr6694528d50.52.1794927348674; Tue, 17
 Nov 2026 06:55:48 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:17 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-12-stani@google.com>
Subject: [PATCH iwl-next 11/15] idpf: psp: add psp tx key state
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TX keys are inserted into the SADB asynchronously: the SA index of a
key is only known when the CP replies. Add struct idpf_psp_tx_key, the
reference counted state of a TX key, stored in the driver data of its
PSP association in a later patch:
- idpf_psp_tx_key_alloc(), idpf_psp_tx_key_get() and
  idpf_psp_tx_key_put(). The TX path reads the SA index of the key
  under RCU: the key is freed after an RCU grace period.
- The SA index is IDPF_PSP_IDX_IN_PROG while the insertion is pending,
  IDPF_PSP_IDX_ERROR if it failed and IDPF_PSP_IDX_DELETED once the key
  was deleted, see idpf_psp_idx_valid().
- idpf_psp_saidx_ok() checks the SA indexes returned by the CP against
  the SA index width negotiated for the adapter.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 51 +++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_psp.h    | 31 +++++++++++
 .../net/ethernet/intel/idpf/idpf_psp_def.h    | 30 +++++++++++
 3 files changed, 112 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
index 844463754632..ef23b1699b09 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -128,6 +128,57 @@ void idpf_psp_free(struct idpf_adapter *adapter)
 	idpf_psp_unregister(adapter);
 }
 
+/**
+ * idpf_psp_tx_key_alloc - Allocate the state of a PSP TX key
+ *
+ * Return: the TX key with a reference, NULL if it couldn't be allocated.
+ */
+struct idpf_psp_tx_key *idpf_psp_tx_key_alloc(void)
+{
+	struct idpf_psp_tx_key *key;
+
+	key = kzalloc_obj(*key);
+	if (!key)
+		return NULL;
+
+	kref_init(&key->ref);
+	spin_lock_init(&key->lock);
+	key->idx = IDPF_PSP_IDX_IN_PROG;
+
+	return key;
+}
+
+/**
+ * idpf_psp_tx_key_free - Free the state of a PSP TX key
+ * @ref: reference count of the TX key
+ */
+static void idpf_psp_tx_key_free(struct kref *ref)
+{
+	struct idpf_psp_tx_key *key = container_of(ref, struct idpf_psp_tx_key,
+						   ref);
+
+	/* The TX path may still read the SA index of the key */
+	kfree_rcu(key, rcu);
+}
+
+/**
+ * idpf_psp_tx_key_get - Get a reference on a PSP TX key
+ * @key: the TX key
+ */
+void idpf_psp_tx_key_get(struct idpf_psp_tx_key *key)
+{
+	kref_get(&key->ref);
+}
+
+/**
+ * idpf_psp_tx_key_put - Release a reference on a PSP TX key
+ * @key: the TX key
+ */
+void idpf_psp_tx_key_put(struct idpf_psp_tx_key *key)
+{
+	kref_put(&key->ref, idpf_psp_tx_key_free);
+}
+
 /**
  * idpf_psp_set_config - Set the PSP device configuration
  * @psd: PSP device
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.h b/drivers/net/ethernet/intel/idpf/idpf_psp.h
index 34534076da47..44ac750e2c3b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.h
@@ -16,6 +16,37 @@ void idpf_psp_recv_late_reply(struct idpf_adapter *adapter,
 void idpf_psp_rotation_event(struct idpf_adapter *adapter,
 			     const struct libie_ctlq_msg *ctlq_msg);
 
+struct idpf_psp_tx_key *idpf_psp_tx_key_alloc(void);
+void idpf_psp_tx_key_get(struct idpf_psp_tx_key *key);
+void idpf_psp_tx_key_put(struct idpf_psp_tx_key *key);
+
+/**
+ * idpf_psp_saidx_ok - Check an SA index returned by the CP
+ * @adapter: private data struct
+ * @saidx: the SA index
+ *
+ * Return: true if @saidx fits in the SA index width negotiated for the
+ * adapter, false otherwise.
+ */
+static inline bool idpf_psp_saidx_ok(const struct idpf_adapter *adapter,
+				     u32 saidx)
+{
+	return saidx < BIT(adapter->psp.saidx_width);
+}
+
+/**
+ * idpf_psp_idx_valid - Check if the SA index of a TX key is usable
+ * @idx: SA index or state of a TX key, see struct idpf_psp_tx_key
+ *
+ * Only SA indexes checked with idpf_psp_saidx_ok() are stored in a TX key.
+ *
+ * Return: true if @idx is an SA index, false if it is a state.
+ */
+static inline bool idpf_psp_idx_valid(u32 idx)
+{
+	return idx <= IDPF_PSP_IDX_MAX;
+}
+
 #else /* !CONFIG_INET_PSP */
 
 static inline void idpf_psp_init(struct idpf_adapter *adapter) { }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
index fdd65bc5321a..9ba99e08853a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
@@ -3,6 +3,8 @@
 #ifndef _IDPF_PSP_DEF_H_
 #define _IDPF_PSP_DEF_H_
 
+#include <linux/kref.h>
+#include <linux/spinlock.h>
 #include <linux/net/intel/virtchnl2.h>
 #include <net/psp.h>
 
@@ -12,6 +14,34 @@
 #define IDPF_PSP_SAIDX_WIDTH_21		21
 #define IDPF_PSP_SAIDX_WIDTH_26		26
 
+/* Largest SA index the driver supports. The SA indexes the CP returns are
+ * checked against the width negotiated for the adapter before they are used,
+ * see idpf_psp_saidx_ok().
+ */
+#define IDPF_PSP_IDX_MAX		(BIT(IDPF_PSP_SAIDX_WIDTH_26) - 1)
+/* States of a TX key without a usable SA index, see struct idpf_psp_tx_key */
+#define IDPF_PSP_IDX_NONE		(U32_MAX - 3)	/* no SA index */
+#define IDPF_PSP_IDX_IN_PROG		(U32_MAX - 2)	/* insertion pending */
+#define IDPF_PSP_IDX_ERROR		(U32_MAX - 1)	/* insertion failed */
+#define IDPF_PSP_IDX_DELETED		U32_MAX		/* key deleted */
+
+/**
+ * struct idpf_psp_tx_key - State of a PSP TX key
+ * @ref: reference count, held by the PSP association, see
+ *	 idpf_psp_tx_key_add(), and by the lists and the insert request the
+ *	 key is on
+ * @lock: protects @idx and @hw_idx updates, and @tx_queue
+ * @idx: SA index the TX path uses, or IDPF_PSP_IDX_IN_PROG,
+ *	 IDPF_PSP_IDX_ERROR or IDPF_PSP_IDX_DELETED. Read without @lock.
+ * @rcu: for freeing the key after the RCU readers of the TX path
+ */
+struct idpf_psp_tx_key {
+	struct kref ref;
+	spinlock_t lock;		/* protects the SA indexes and tx_queue */
+	u32 idx;
+	struct rcu_head rcu;
+};
+
 /**
  * struct idpf_psp_rx_key - PSP RX key allocated by the CP
  * @spi: SPI of the key
-- 
2.56.0.679.gc527c65306-goog

