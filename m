Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35232606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=4e7SdoNP;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lmI6tBdn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1887360A37;
	Tue, 17 Nov 2026 16:29:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pl0M6W5sHQ82; Tue, 17 Nov 2026 16:29:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3151F60A38
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932949;
	b=oMUsxwvlRiSywbvf8BtOGr5PAnPCI4vZJNPE2VoYYP6ZM+jEUSz0VFMh538gm8RqIjxa
	 55+tFTwgf8qnSmiA/ADfmhoc0hCHedKrczUo6TXZ/05erU06r1+ue/tTKYb5bz1Nvaozr
	 jtfzJZEJPWRfPpjPwOFdkhnRA4/h4d3hwM5P36K1TcanmEZXYJKhqbf8RShf4QJHvxHtx
	 bL6UKmFdp72bxd5C5kuONW2CAmqMQru/NBk9Bchoc5oOX/nmumO14Y22tK6IwmzbNVSvB
	 mJfCfO4xQxeL8qdxB1MdSzmQbK+WrNPRS/YTiiB+2Hs3UOd3SrmU2NXIh4YQmJvnD2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wt+9JWcwL2nVatIor+f5wPjDE3yZm0NfWPflpZZJfb0=;
	b=ma4W2yTCOU2K0mR60e0FyxrbGjsp2JbF6No9p5ERJAgY3gpbLuiQLPp06Bh7dcrm10c4
	 TvxRE78ljzgJeh16LFunBzzvnRrs9V3tJLcvoCa6Ce0jN7GRLmvYhNDJCkoAB/od7XG6F
	 vaRpu3WHbA01S4Y54+XUxt1knwhKM6cru13YS1t7i47OGL1AY1YPfgzOnVMauQJ5Orkej
	 4Iz8KyRnTFcxze2SMQGi3om7nrdrR6U5cUmoUA5LxccaKjdyI6F6pHz08JzvCig8mGixJ
	 ekdhaxqVMvOlzx24AReDueBt5Y1b5vSspHLtde9aQBocgjOXbNtPhghZT4BJT4EJo/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932949;
	bh=wt+9JWcwL2nVatIor+f5wPjDE3yZm0NfWPflpZZJfb0=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4e7SdoNPS7ZONLzgkqufTD7e6mgX6KDkvaVRARN6dmYO3ZZZvp96Na+8hnV3rl90t
	 AWUi25eUNSWzHp7T5oA5Ko8mAI1ZKzNlQnSefsljMU00Ue6YN4vz8L/GQGgbthgUWu
	 0kmRxUpehFpBAbrtrLeUwqaynliH+A58uAEukAtPOK0POGwCPubBEFoyD4/RCRO+18
	 ZAKYlJqBpRSOdiNyUNq9uI9QALx8eovRMKqkqyT5gs1AUn7fo+JuXtQn+JQjLglvGi
	 /d/FvoEtONF+6UOa08ysWXzy89rtoDfuNH15lFyRS1jnN2ByhM5Dd6lnpZaHOymA0A
	 pnazZ7+5WWFuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3151F60A38;
	Tue, 17 Nov 2026 16:29:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC83E49B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D24D6408C4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B9cBr7NmodKT for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:55:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BBF32408C3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b147"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b147; helo=mail-yx1-xb147.google.com;
 envelope-from=382r8agukdxoij0d86ee6b4.2ec8dj4b-m8h43-b0db8iji.eikeib.eh6@flex--stani.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=lmI6tBdn
Received: from mail-yx1-xb147.google.com (mail-yx1-xb147.google.com
 [IPv6:2607:f8b0:4864:20::b147])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBF32408C3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:49 +0000 (UTC)
Received: by mail-yx1-xb147.google.com with SMTP id
 956f58d0204a3-67dabc6d5dfso4626902d50.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 06:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794927348; x=1795532148; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wt+9JWcwL2nVatIor+f5wPjDE3yZm0NfWPflpZZJfb0=;
 b=lmI6tBdnoaXEQ95PGM2nfHG1UaodXNYGg+QfhayZrTQpjKum+/uTyZPa4Wm8AOc20/
 OI8V3BbYWvpD5nWu0xm6tKr4gHXZNWSmWoHN6EGrkzvlMBW10fij9mAJzrE3XHGozykJ
 OyqPOEJ2KjRH8CtjmCFaxbsVIVAnahH6yjzXGj80LjQGuIx2pmUqpT5dLRT/y43Bwciv
 8w7SKEc45Cs+xdPyl9t6kxJ/uzYhGZnLTQF/slKCUNaPqFPBsTU/SHy/Dqa1HgKBRtcE
 RGSow4g97gobSHo3EJ+y+nIj5m5Jc0J+dO+yhRKK6yREcKNogoXabLcF1SxZ23BsCRUG
 xr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927348; x=1795532148;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wt+9JWcwL2nVatIor+f5wPjDE3yZm0NfWPflpZZJfb0=;
 b=NP22z5TyM21ta4SYkrH+U+4iAjjufy8Vli+J9TCMpv9jgdRJFN6YFE/6WFMqy/vQdK
 OGl5JmL7wkOJfniE6RI8HJYUiOPPYFtJNgfAfb21WVu1ZMa8WL6vEOY2DRhi8x8Bmmcv
 PHyl02idUf0XbVBLlnu62JAI4EIS3AL/L9EfY5rKkgatR31RH8xTh7VMRzvUGF/DKTtl
 okWL7KhJ2FUDiquAUj9QrWiWW0ot0Q9bZ1H6L7hXoGSOVIhWF0XUoKCmxXSpqTGW6am2
 fgXy4TlxvXt/jT2ASeCbQjJ9OuQjziZYe304nlHMzpMv0gXEAsna522oPuSBu/7TQb9x
 5prg==
X-Forwarded-Encrypted: i=1;
 AL+hErGLlFcA7WNFVRnH7RW51QPEAsPPvm1HXjhIw5J57F8a3a5tPjAkv3Fq9SBjWo0ibT2XtvVZlYUJUt/tACtx+Vs=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/bRvyVRcOoSoliUnhMhb//SeVBXaZuyPID4w/p8I1KZbsgsYGC
 2N0aepK+JMf5yo2bMpPiGJMLT1uTulXGhrY1WZsg9+FJGXGl9DPVMhKC7yU6U7pAWJzR2PqL97J
 wWQ==
X-Received: from yxvo14.prod.google.com ([2002:a53:ce8e:0:b0:67d:8220:1db9])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1382:b0:67d:aee7:a138
 with SMTP id 956f58d0204a3-67daee7bce3mr4616821d50.89.1794927347672; Tue, 17
 Nov 2026 06:55:47 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:16 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-11-stani@google.com>
Subject: [PATCH iwl-next 10/15] idpf: psp: add support for psp statistics
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

Add support for the PSP device statistics:
- Introduce VIRTCHNL2_OP_GET_PSP_GLOBAL_STATS (566),
  enum virtchnl2_psp_global_stats_type,
  struct virtchnl2_psp_global_stats_request/_response,
  struct virtchnl2_psp_global_common_stats and
  struct virtchnl2_psp_global_addon_stats.
- Implement idpf_send_get_psp_global_stats(): only the requested stat
  groups present in the reply are reported as supported.
- Implement the get_stats PSP device op. The last statistics read are
  kept in adapter->psp.stats and reported when they can't be read,
  e.g. during a reset.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 51 +++++++++++++
 .../net/ethernet/intel/idpf/idpf_psp_def.h    | 13 ++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.c   | 52 +++++++++++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.h   |  2 +
 include/linux/net/intel/virtchnl2.h           | 75 +++++++++++++++++++
 5 files changed, 193 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
index cf0216640ddc..844463754632 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -249,11 +249,62 @@ static int idpf_psp_key_rotate(struct psp_dev *psd,
 	return 0;
 }
 
+/**
+ * idpf_psp_get_stats - Get the PSP device statistics
+ * @psd: PSP device
+ * @stats: statistics to fill in
+ *
+ * Read the PSP global statistics with VIRTCHNL2_OP_GET_PSP_GLOBAL_STATS. The
+ * last statistics read are reported if they can't be read, e.g. during reset.
+ */
+static void idpf_psp_get_stats(struct psp_dev *psd, struct psp_dev_stats *stats)
+{
+	struct idpf_adapter *adapter = idpf_netdev_to_adapter(psd->main_netdev);
+	struct idpf_psp_dev_stats *cur = &adapter->psp.stats;
+	struct virtchnl2_psp_global_stats_response resp;
+	u32 supported;
+
+	if (!idpf_send_get_psp_global_stats(adapter, &resp)) {
+		supported = le32_to_cpu(resp.supported_stats);
+
+		if (supported & VIRTCHNL2_PSP_STAT_COMMON) {
+			const struct virtchnl2_psp_global_common_stats *cs =
+				&resp.common_stats;
+
+			cur->rx_packets = le64_to_cpu(cs->rx_decrypted_packets);
+			cur->rx_bytes = le64_to_cpu(cs->rx_decrypted_bytes);
+			cur->rx_auth_fail = le32_to_cpu(cs->rx_auth_failures);
+			/* PSP spec: rx_error counts length/framing errors,
+			 * rx_bad miscellaneous errors.
+			 */
+			cur->rx_error = le32_to_cpu(cs->rx_bad_packets);
+			cur->rx_bad = le32_to_cpu(cs->rx_misc_errors);
+			cur->tx_packets = le64_to_cpu(cs->tx_encrypted_packets);
+			cur->tx_bytes = le64_to_cpu(cs->tx_encrypted_bytes);
+			cur->tx_error = (u64)le32_to_cpu(cs->tx_misc_errors) +
+					le32_to_cpu(cs->tx_bad_packets);
+			if (supported & VIRTCHNL2_PSP_STAT_ADDON)
+				cur->tx_error +=
+					le32_to_cpu(resp.addon_stats.tx_inv_sa_packets);
+		}
+	}
+
+	stats->rx_packets = cur->rx_packets;
+	stats->rx_bytes = cur->rx_bytes;
+	stats->rx_auth_fail = cur->rx_auth_fail;
+	stats->rx_error = cur->rx_error;
+	stats->rx_bad = cur->rx_bad;
+	stats->tx_packets = cur->tx_packets;
+	stats->tx_bytes = cur->tx_bytes;
+	stats->tx_error = cur->tx_error;
+}
+
 /* PSP device operations, see idpf_psp_register() */
 static struct psp_dev_ops idpf_psp_ops = {
 	.set_config	= idpf_psp_set_config,
 	.rx_spi_alloc	= idpf_psp_rx_spi_alloc,
 	.key_rotate	= idpf_psp_key_rotate,
+	.get_stats	= idpf_psp_get_stats,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
index 3132efe00559..fdd65bc5321a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
@@ -56,6 +56,9 @@ struct idpf_psp_rx_gen {
  *		by the PSP device lock, see idpf_psp_key_rotate()
  * @rx_gen: generation of the master key of each SPI phase, protected by the
  *	    PSP device lock, see idpf_psp_rx_gen_update()
+ * @stats: last PSP device statistics read with
+ *	   VIRTCHNL2_OP_GET_PSP_GLOBAL_STATS, protected by the PSP device
+ *	   lock, see idpf_psp_get_stats()
  * @keys_allocated: RX keys allocated
  * @psp_dev: the PSP device, see idpf_psp_register()
  * @caps: capabilities of @psp_dev
@@ -68,6 +71,16 @@ struct idpf_adapter_psp {
 	u32 vport_id;
 	u8 generation;
 	struct idpf_psp_rx_gen rx_gen[2];
+	struct idpf_psp_dev_stats {
+		u64 rx_packets;
+		u64 rx_bytes;
+		u64 rx_auth_fail;
+		u64 rx_error;
+		u64 rx_bad;
+		u64 tx_packets;
+		u64 tx_bytes;
+		u64 tx_error;
+	} stats;
 	atomic_t keys_allocated;
 	struct psp_dev *psp_dev;
 	struct psp_dev_caps caps;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
index ddb9fd90291f..d36f46a46cfd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
@@ -350,6 +350,58 @@ void idpf_psp_rotation_event(struct idpf_adapter *adapter,
 			     le32_to_cpu(rt_event->psp_rotate_event.active_master_key_generation));
 }
 
+/**
+ * idpf_send_get_psp_global_stats - Send VIRTCHNL2_OP_GET_PSP_GLOBAL_STATS
+ * @adapter: Driver specific private structure
+ * @stats: Output buffer for virtchnl2_psp_global_stats_response
+ *
+ * Request the common and add-on PSP statistics. Only the stat groups set in
+ * @stats->supported_stats are valid: a group is only reported as supported if
+ * it was requested and is present in the reply, which may leave out trailing
+ * groups that are not supported.
+ *
+ * Return: 0 on success, negative on failure.
+ */
+int idpf_send_get_psp_global_stats(struct idpf_adapter *adapter,
+				   struct virtchnl2_psp_global_stats_response *stats)
+{
+	struct libie_ctlq_xn_send_params xn_params = {
+		.chnl_opcode	= VIRTCHNL2_OP_GET_PSP_GLOBAL_STATS,
+		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	const u32 requested = VIRTCHNL2_PSP_STAT_COMMON | VIRTCHNL2_PSP_STAT_ADDON;
+	struct virtchnl2_psp_global_stats_request req = {
+		.requested_stats = cpu_to_le32(requested),
+	};
+	size_t reply_sz;
+	u32 supported;
+	int err;
+
+	err = idpf_send_mb_msg_stack(adapter, &xn_params, &req);
+	if (err)
+		return err;
+
+	reply_sz = xn_params.recv_mem.iov_len;
+	if (reply_sz < offsetof(typeof(*stats), common_stats)) {
+		err = -EIO;
+		goto release_rx;
+	}
+
+	memset(stats, 0, sizeof(*stats));
+	memcpy(stats, xn_params.recv_mem.iov_base, min(reply_sz, sizeof(*stats)));
+
+	supported = le32_to_cpu(stats->supported_stats) & requested;
+	if (reply_sz < offsetofend(typeof(*stats), common_stats))
+		supported &= ~VIRTCHNL2_PSP_STAT_COMMON;
+	if (reply_sz < offsetofend(typeof(*stats), addon_stats))
+		supported &= ~VIRTCHNL2_PSP_STAT_ADDON;
+	stats->supported_stats = cpu_to_le32(supported);
+
+release_rx:
+	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
+	return err;
+}
+
 /**
  * idpf_psp_recv_late_reply - Handle a late reply to a PSP request
  * @adapter: Driver specific private structure
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
index f1b4f7747908..b7261385adf6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
@@ -15,5 +15,7 @@ int idpf_send_get_fips_compliance_status(struct idpf_adapter *adapter);
 int idpf_send_allocate_psp_key(struct idpf_adapter *adapter,
 			       struct idpf_psp_rx_key *key);
 int idpf_psp_rotation_request(struct idpf_adapter *adapter);
+int idpf_send_get_psp_global_stats(struct idpf_adapter *adapter,
+				   struct virtchnl2_psp_global_stats_response *stats);
 
 #endif /* !_IDPF_PSP_VIRTCHNL_H_ */
diff --git a/include/linux/net/intel/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
index 29dfa075e169..ca07c32b0f1a 100644
--- a/include/linux/net/intel/virtchnl2.h
+++ b/include/linux/net/intel/virtchnl2.h
@@ -89,6 +89,7 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_PSP_ROTATE_KEYGEN_REQUEST		= 563,
 	VIRTCHNL2_OP_CRYPTO_GET_CAPS			= 564,
 	VIRTCHNL2_OP_PSP_GET_CAPS			= 565,
+	VIRTCHNL2_OP_GET_PSP_GLOBAL_STATS		= 566,
 	VIRTCHNL2_OP_GET_FIPS_COMPLIANCE_STATUS		= 567,
 };
 
@@ -2040,6 +2041,80 @@ struct virtchnl2_psp_rotation_event {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(32, virtchnl2_psp_rotation_event);
 
+enum virtchnl2_psp_global_stats_type {
+	VIRTCHNL2_PSP_STAT_COMMON			= BIT(0),
+	VIRTCHNL2_PSP_STAT_ADDON			= BIT(1),
+};
+
+/**
+ * struct virtchnl2_psp_global_stats_request - PSP global stats request
+ * @requested_stats: Bitmask of requested stats (enum virtchnl2_psp_global_stats_type)
+ * @pad: Reserved/padding
+ *
+ * Stat groups that are not requested are not supported in the response.
+ */
+struct virtchnl2_psp_global_stats_request {
+	__le32 requested_stats;
+	u8 pad[4];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_psp_global_stats_request);
+
+/**
+ * struct virtchnl2_psp_global_common_stats - PSP global common stats
+ * @rx_decrypted_packets: Number of RX decrypted packets
+ * @rx_decrypted_bytes: Number of RX decrypted bytes
+ * @rx_auth_failures: Number of RX auth failures
+ * @rx_misc_errors: Number of RX misc errors
+ * @rx_bad_packets: Number of RX bad packets
+ * @pad1: Reserved/padding
+ * @tx_encrypted_packets: Number of TX encrypted packets
+ * @tx_encrypted_bytes: Number of TX encrypted bytes
+ * @tx_misc_errors: Number of TX misc errors
+ * @tx_bad_packets: Number of TX bad packets
+ */
+struct virtchnl2_psp_global_common_stats {
+	__le64 rx_decrypted_packets;
+	__le64 rx_decrypted_bytes;
+	__le32 rx_auth_failures;
+	__le32 rx_misc_errors;
+	__le32 rx_bad_packets;
+	u8 pad1[4];
+	__le64 tx_encrypted_packets;
+	__le64 tx_encrypted_bytes;
+	__le32 tx_misc_errors;
+	__le32 tx_bad_packets;
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(56, virtchnl2_psp_global_common_stats);
+
+/**
+ * struct virtchnl2_psp_global_addon_stats - PSP global addon stats
+ * @tx_inv_sa_packets: Number of TX invalid SA packets
+ * @pad: Reserved/padding
+ */
+struct virtchnl2_psp_global_addon_stats {
+	__le32 tx_inv_sa_packets;
+	u8 pad[4];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_psp_global_addon_stats);
+
+/**
+ * struct virtchnl2_psp_global_stats_response - PSP global stats response
+ * @supported_stats: Bitmask of supported stats returned
+ * @pad1: Reserved/padding
+ * @common_stats: Common stats structure
+ * @addon_stats: Addon stats structure
+ *
+ * An unsupported stat group followed by a supported one is zero-filled,
+ * trailing unsupported stat groups may be left out of the response.
+ */
+struct virtchnl2_psp_global_stats_response {
+	__le32 supported_stats;
+	u8 pad1[4];
+	struct virtchnl2_psp_global_common_stats common_stats;
+	struct virtchnl2_psp_global_addon_stats addon_stats;
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(72, virtchnl2_psp_global_stats_response);
+
 /**
  * struct virtchnl2_get_fips_compliance_status_resp - FIPS compliance response
  * @num_certs: Number of certificates, 0 if not FIPS compliant
-- 
2.56.0.679.gc527c65306-goog

