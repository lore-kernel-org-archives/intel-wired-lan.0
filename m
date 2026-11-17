Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DACA606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=NLKO7ftE;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c62fXNIg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FD4740944;
	Tue, 17 Nov 2026 16:29:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0cpvRLAMBgY2; Tue, 17 Nov 2026 16:29:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1126440932
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932947;
	b=oRph/OMWV0b7DQLwkQmBG9AMOd6DAzoa3ffbdWFPML5YWUrLMpcIr975gJlaaaif5WW9
	 FPCmr21mxdJC+0Yds+nBvxac5fkGt8XbMkLAoBrLS3y+vNUwxJH2Oh4VqZzK8qp/Io90Y
	 mOOVAxceu1IJiKmDfwiLALJT/b5l5nUZmNwt3bg6K66MNlpfEylONRje6UTcxjNjxxqFx
	 lF2e7tkxc1wdCUpVDzuJIrLPQ1p10SCnk7Mcpm8hkQMJaKCmWFII2KmnZxHkG/Jq99THU
	 PTqUmOjRZFfdfjO2UvLLsjqi5JXXIHzdNuo7+sg/GJsV6pDY6yOi0jD1rDOEVtSy08w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932947;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Yrk3C/Qn8YI7zDrjT4eCPCundwlQjbduafoUtLob2BE=;
	b=eKyItkugPPBl0yOjs3tM/2UN+tg3VRDFZWXuM/C57QA9SfEWY7T+G5+Cy/CTITWMLck3
	 TFHCFX5cCGcyp/sU2ZfHJwdYdUUOnbQ2+Ob9CWe+rx1jbJJeDI1El2iw7+MTVtvG6tH1m
	 zKMSrdkAXV5g2l1670kbYaac9W7Lm/GLZ1AG0iJFzTAEC5l5aFwJ4m14H78aXKObl/0qs
	 Yby1zoAp+P1e57KJoBvdB8db2wZw8pdTMbQJwPMNKXAv+hY4yFpxBq82aE0doPjGeiC89
	 YR5zwiJsT2je5HsaODLlzOUka7JKEFJ055/cCX6H+MS6FoBGOR8qOYbciFScEaDIorg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932947;
	bh=Yrk3C/Qn8YI7zDrjT4eCPCundwlQjbduafoUtLob2BE=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NLKO7ftEYJCVa34huTWZZBpvq9IdvNpa2xkpz45n07eVoxxRhhRVxVOkiGEKGJEWj
	 Z+77gxc77UXWAjwfh4sTSfq+QlI50sGSk26nUKvNj/vdgq5Ga02vi1WOS7/xiApIIC
	 n/HPrh2xGlD/MAUy3/lC0kchD4dedOhVPiOYMivHoCiZ2NPuVVpBbAZeGy8xl8501O
	 enAK+fjTXNgZgUaIdXPCzZxCQbBlXmkbiTm+iVd+gDwvbldEUCsgCc8Xma3S3quAT6
	 dBin2WpgHCE28pdtZjZ24mcKjuIk/pXuSgu1+kArmaOO+AUP641CLQ+SguE4MWF3ce
	 qMifyx0VfzelQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1126440932;
	Tue, 17 Nov 2026 16:29:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 27EE049B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1976580CFA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OAXjSOnB_l83 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:55:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C47DB8111E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::747"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::747; helo=mail-qk1-x747.google.com;
 envelope-from=38wr8agukdxgghyb64cc492.0ca6bh29-k6f21-9yb96ghg.cgicg9.cf4@flex--stani.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=c62fXNIg
Received: from mail-qk1-x747.google.com (mail-qk1-x747.google.com
 [IPv6:2607:f8b0:4864:20::747])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C47DB8111E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:47 +0000 (UTC)
Received: by mail-qk1-x747.google.com with SMTP id
 af79cd13be357-948d83322f6so793989185a.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 06:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794927346; x=1795532146; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Yrk3C/Qn8YI7zDrjT4eCPCundwlQjbduafoUtLob2BE=;
 b=c62fXNIgp9vrWSLdPxuWn7EbcoDubxwjW/sngyGHQtqBGjihqRmCzCQLDVjWPOWaEs
 qJ5w94tkyDez1pzo61/FMJn/dtesQiUPVp0L8lHbHOspzKamzw5UFPAYbzic5uoT7sRA
 s8eP+73W3RMCyry4JCgdnoyAyjU1b7pEwxA6XzeIZcdnflQsg5uPltkQUunql++pxEXv
 AsrGxA24XyZuO9Tk+6PYbhM1Acn3GE9fhOWllBE0R9ImcFBDpQP1Gxq5iyKgZr6Xhugg
 xdBQKZUaXHVMma1H9jjAaKXlUz47/R4BswgSg9fue1e+KgBswmTprcMHVacsesGEvQUl
 LF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927346; x=1795532146;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yrk3C/Qn8YI7zDrjT4eCPCundwlQjbduafoUtLob2BE=;
 b=uPjOXK/O6m4EV0WaT/bYjWqowTZwr+BODJYVpNcHTF7Jc/M6RrjHb6aARhC6XdvNp8
 WH6rN+EOCI7qGg1y06y58qTUw1DNDT+7jwdn0NsQXKE4slu/P0dYNlCHwoxfgJGC8xrt
 YtaMzMibz+SgAaQ5ccx5O35qeFV550MSKdGIHR+wftEmW0G0K40tuLFP/9cqgcLDjQ0M
 8JhGTFP6tmP1OgHiA7agSwBCtnM2X/A3foBZDlo41sZKpxe31fwbfRuhCaPRLuhebn4U
 1PQBSLDBHzQKtQrwZdyTDuXZROtH0vUXDhTbDcA0Kj5b8tP7r2TZE3BjAhYe8oeftZyo
 gaoA==
X-Forwarded-Encrypted: i=1;
 AL+hErE0D4yBqMM2lQUJg4vLbhifkmc5nlAeOHAoTLbbtdqJl01Thy4NURbRHVTOVzYOAaixYM1vaZmfmvDSSgdkCoY=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9e81aMsSPdFmBaDTL8VyxkCiBQJxRgDq4oiVXyGSngtoU3/HFK
 1voAmJW9DE5GeR39TRUgTTRWpQU70Ga887IoGxYPyU5LiTslAOn7XwQrbfDMNbQRdHPE0EFdiUr
 +KA==
X-Received: from qkhx17.prod.google.com ([2002:ae9:f811:0:b0:93f:18ba:bf7a])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6497:b0:947:7857:bb7c
 with SMTP id af79cd13be357-9494bc3834fmr2027349985a.33.1794927345501; Tue, 17
 Nov 2026 06:55:45 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:14 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-9-stani@google.com>
Subject: [PATCH iwl-next 08/15] idpf: psp: add support for psp rx key
 allocation
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

Add support for allocating PSP RX keys on demand:
- Introduce VIRTCHNL2_OP_PSP_ALLOCATE_KEYS (560),
  enum virtchnl2_psp_allocate_response_flags,
  struct virtchnl2_psp_allocate_keys_request/_response and
  struct virtchnl2_allocate_psp_key_v0/_v1.
- Implement idpf_send_allocate_psp_key(), which allocates one V0 RX
  key with a synchronous request, validates the reply (key type,
  keys_size_bytes, length, and an SPI with a key ID, which the PSP core
  requires) and wipes the key from the mailbox buffer. The key, its SPI
  and its master key generation are returned in struct idpf_psp_rx_key.
- Implement the rx_spi_alloc PSP device op. It gets the adapter from
  the netdev of the PSP device, as the vports can be freed while the
  PSP device is registered.
- Keep a copy of the vport ID in adapter->psp.vport_id, for the same
  reason.
- Wipe the RX keys of late replies, which libie passes to
  idpf_recv_event_msg() after the request timed out.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 +
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 43 +++++++++
 drivers/net/ethernet/intel/idpf/idpf_psp.h    |  6 ++
 .../net/ethernet/intel/idpf/idpf_psp_def.h    | 19 ++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.c   | 89 +++++++++++++++++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.h   |  2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  3 +
 include/linux/net/intel/virtchnl2.h           | 78 ++++++++++++++++
 8 files changed, 243 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 1385209519b2..062753a62f59 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1144,6 +1144,9 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	/* fill vport slot in the adapter struct */
 	adapter->vports[idx] = vport;
 	adapter->vport_ids[idx] = idpf_get_vport_id(vport);
+	/* Copy for the PSP requests that can run while the vports are freed */
+	if (IS_ENABLED(CONFIG_INET_PSP) && !idx)
+		WRITE_ONCE(adapter->psp.vport_id, adapter->vport_ids[idx]);
 
 	adapter->num_alloc_vports++;
 	/* prepare adapter->next_vport for next use */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
index 67f1f1d7508c..8ce390bcd617 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -106,6 +106,9 @@ void idpf_psp_init(struct idpf_adapter *adapter)
 		dev_warn(dev, "Failed to get PSP FIPS compliance status: %d\n",
 			 err);
 
+	/* The counters cover the time since the core init */
+	atomic_set(&psp->keys_allocated, 0);
+
 	WRITE_ONCE(psp->enabled, true);
 }
 
@@ -136,9 +139,49 @@ static int idpf_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
 	return 0;
 }
 
+/**
+ * idpf_psp_rx_spi_alloc - Allocate a PSP RX SPI and key
+ * @psd: PSP device
+ * @version: PSP version
+ * @key: filled with the allocated SPI and key
+ * @extack: netlink extended ack for error reporting
+ *
+ * Allocate one RX key with a synchronous VIRTCHNL2_OP_PSP_ALLOCATE_KEYS
+ * request.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int idpf_psp_rx_spi_alloc(struct psp_dev *psd, u32 version,
+				 struct psp_key_parsed *key,
+				 struct netlink_ext_ack *extack)
+{
+	struct idpf_adapter *adapter = idpf_netdev_to_adapter(psd->main_netdev);
+	struct idpf_psp_rx_key rx_key;
+	int err;
+
+	/* Only version 0 keys are allocated, see idpf_psp_register() */
+	if (psp_key_size(version) != sizeof(rx_key.key)) {
+		NL_SET_ERR_MSG_MOD(extack, "Unsupported PSP version");
+		return -EOPNOTSUPP;
+	}
+
+	err = idpf_send_allocate_psp_key(adapter, &rx_key);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to allocate RX SPI and key");
+		return err;
+	}
+
+	key->spi = rx_key.spi;
+	memcpy(key->key, rx_key.key, sizeof(rx_key.key));
+	memzero_explicit(&rx_key, sizeof(rx_key));
+
+	return 0;
+}
+
 /* PSP device operations, see idpf_psp_register() */
 static struct psp_dev_ops idpf_psp_ops = {
 	.set_config	= idpf_psp_set_config,
+	.rx_spi_alloc	= idpf_psp_rx_spi_alloc,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.h b/drivers/net/ethernet/intel/idpf/idpf_psp.h
index 0f89dcc3b398..fcafe71d3d00 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.h
@@ -11,6 +11,8 @@ void idpf_psp_init(struct idpf_adapter *adapter);
 void idpf_psp_free(struct idpf_adapter *adapter);
 void idpf_psp_register(struct idpf_adapter *adapter);
 void idpf_psp_unregister(struct idpf_adapter *adapter);
+void idpf_psp_recv_late_reply(struct idpf_adapter *adapter,
+			      const struct libie_ctlq_msg *ctlq_msg);
 
 #else /* !CONFIG_INET_PSP */
 
@@ -19,6 +21,10 @@ static inline void idpf_psp_free(struct idpf_adapter *adapter) { }
 static inline void idpf_psp_register(struct idpf_adapter *adapter) { }
 static inline void idpf_psp_unregister(struct idpf_adapter *adapter) { }
 
+static inline void
+idpf_psp_recv_late_reply(struct idpf_adapter *adapter,
+			 const struct libie_ctlq_msg *ctlq_msg) { }
+
 #endif /* CONFIG_INET_PSP */
 
 #endif /* !_IDPF_PSP_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
index 0829d0bbd92b..f21bd7de5ae8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
@@ -3,6 +3,7 @@
 #ifndef _IDPF_PSP_DEF_H_
 #define _IDPF_PSP_DEF_H_
 
+#include <linux/net/intel/virtchnl2.h>
 #include <net/psp.h>
 
 /* SA index widths supported by the driver, negotiated per adapter with
@@ -11,6 +12,18 @@
 #define IDPF_PSP_SAIDX_WIDTH_21		21
 #define IDPF_PSP_SAIDX_WIDTH_26		26
 
+/**
+ * struct idpf_psp_rx_key - PSP RX key allocated by the CP
+ * @spi: SPI of the key
+ * @generation: CP master key generation of the key
+ * @key: the key
+ */
+struct idpf_psp_rx_key {
+	__be32 spi;
+	u32 generation;
+	u8 key[VIRTCHNL2_PSP_KEY_SIZE_V0];
+};
+
 /**
  * struct idpf_adapter_psp - PSP offload state of an adapter
  * @enabled: PSP was negotiated with the CP in the last core init, see
@@ -19,6 +32,10 @@
  * @saidx_width: SA index width granted by VIRTCHNL2_OP_CRYPTO_GET_CAPS
  * @psp_caps: PSP capabilities granted by VIRTCHNL2_OP_PSP_GET_CAPS, see
  *	      enum virtchnl2_psp_caps
+ * @vport_id: ID of adapter->vports[0] for the PSP requests. A copy, as the
+ *	      PSP device stays registered while the vports are freed and
+ *	      allocated again during a soft reset. Set in idpf_vport_alloc().
+ * @keys_allocated: RX keys allocated
  * @psp_dev: the PSP device, see idpf_psp_register()
  * @caps: capabilities of @psp_dev
  */
@@ -27,6 +44,8 @@ struct idpf_adapter_psp {
 	u32 sadb_entries;
 	u8 saidx_width;
 	u32 psp_caps;
+	u32 vport_id;
+	atomic_t keys_allocated;
 	struct psp_dev *psp_dev;
 	struct psp_dev_caps caps;
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
index 0502ce0b7abe..aa50948873a7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
@@ -194,3 +194,92 @@ int idpf_send_get_fips_compliance_status(struct idpf_adapter *adapter)
 	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
 	return err;
 }
+
+/**
+ * idpf_send_allocate_psp_key - Allocate a PSP RX key
+ * @adapter: Driver specific private structure
+ * @key: filled with the allocated SPI and key and their master key generation
+ *
+ * Allocate one RX key with a synchronous VIRTCHNL2_OP_PSP_ALLOCATE_KEYS
+ * request. The caller must be allowed to sleep.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int idpf_send_allocate_psp_key(struct idpf_adapter *adapter,
+			       struct idpf_psp_rx_key *key)
+{
+	struct libie_ctlq_xn_send_params xn_params = {
+		.chnl_opcode	= VIRTCHNL2_OP_PSP_ALLOCATE_KEYS,
+		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	const struct virtchnl2_psp_allocate_keys_response *vc_reply;
+	struct virtchnl2_psp_allocate_keys_request key_req = { };
+	const struct virtchnl2_allocate_psp_key_v0 *v0_key;
+	size_t reply_sz;
+	u32 spi;
+	int err;
+
+	BUILD_BUG_ON(sizeof(key->key) != sizeof(v0_key->v0_key));
+
+	key_req.vport_id = cpu_to_le32(READ_ONCE(adapter->psp.vport_id));
+	key_req.num_keys = cpu_to_le32(1);
+	key_req.key_type = VIRTCHNL2_PSP_KEY_TYPE_V0;
+	/* key_req.domain stays zeroed: VIRTCHNL2_PSP_DOMAIN_NONE */
+
+	err = idpf_send_mb_msg_stack(adapter, &xn_params, &key_req);
+	if (err)
+		return err;
+
+	reply_sz = xn_params.recv_mem.iov_len;
+	vc_reply = xn_params.recv_mem.iov_base;
+	if (reply_sz < sizeof(*vc_reply) + sizeof(*v0_key) ||
+	    vc_reply->key_type != VIRTCHNL2_PSP_KEY_TYPE_V0 ||
+	    le32_to_cpu(vc_reply->keys_size_bytes) != sizeof(*v0_key)) {
+		net_warn_ratelimited("%s: invalid reply of %zu bytes\n",
+				     __func__, reply_sz);
+		err = -EIO;
+		goto release_rx;
+	}
+
+	v0_key = (const struct virtchnl2_allocate_psp_key_v0 *)vc_reply->keys;
+	spi = le32_to_cpu(v0_key->spi);
+	if (!(spi & PSP_SPI_KEY_ID)) {
+		net_warn_ratelimited("%s: invalid SPI %#x\n", __func__, spi);
+		err = -EIO;
+		goto release_rx;
+	}
+
+	key->spi = cpu_to_be32(spi);
+	key->generation = le32_to_cpu(vc_reply->master_key_generation);
+	memcpy(key->key, v0_key->v0_key, sizeof(key->key));
+	atomic_inc(&adapter->psp.keys_allocated);
+
+release_rx:
+	/* Don't leave the RX key in the recycled mailbox buffer */
+	memzero_explicit(xn_params.recv_mem.iov_base, reply_sz);
+	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
+	return err;
+}
+
+/**
+ * idpf_psp_recv_late_reply - Handle a late reply to a PSP request
+ * @adapter: Driver specific private structure
+ * @ctlq_msg: reply, its receive buffer is released by the caller
+ *
+ * libie passes the replies to requests that timed out to idpf_recv_event_msg().
+ * The RX key of an allocation reply is wiped.
+ */
+void idpf_psp_recv_late_reply(struct idpf_adapter *adapter,
+			      const struct libie_ctlq_msg *ctlq_msg)
+{
+	const struct kvec *buff = &ctlq_msg->recv_mem;
+
+	switch (ctlq_msg->chnl_opcode) {
+	case VIRTCHNL2_OP_PSP_ALLOCATE_KEYS:
+		if (buff->iov_base)
+			memzero_explicit(buff->iov_base, buff->iov_len);
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
index 2ade2df2e34e..7ba86b540f2b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
@@ -12,5 +12,7 @@ int idpf_send_get_crypto_caps(struct idpf_adapter *adapter,
 int idpf_send_get_psp_caps(struct idpf_adapter *adapter,
 			   struct virtchnl2_psp_get_caps *caps);
 int idpf_send_get_fips_compliance_status(struct idpf_adapter *adapter);
+int idpf_send_allocate_psp_key(struct idpf_adapter *adapter,
+			       struct idpf_psp_rx_key *key);
 
 #endif /* !_IDPF_PSP_VIRTCHNL_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 3f669683c8c0..056fd82b3162 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -91,6 +91,9 @@ void idpf_recv_event_msg(struct libie_ctlq_ctx *ctx,
 
 	adapter = container_of(ctx, struct idpf_adapter, ctlq_ctx);
 	if (ctlq_msg->chnl_opcode != VIRTCHNL2_OP_EVENT) {
+		/* Late reply to a PSP request that timed out */
+		idpf_psp_recv_late_reply(adapter, ctlq_msg);
+
 		dev_dbg(&adapter->pdev->dev,
 			"Unhandled message with opcode %u from CP\n",
 			ctlq_msg->chnl_opcode);
diff --git a/include/linux/net/intel/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
index c3a0e7b1b8e2..0ae439009f44 100644
--- a/include/linux/net/intel/virtchnl2.h
+++ b/include/linux/net/intel/virtchnl2.h
@@ -85,6 +85,7 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_GET_FLOW_RULE			= 552,
 	VIRTCHNL2_OP_DEL_FLOW_RULE			= 553,
 	/* Crypto/PSP opcodes */
+	VIRTCHNL2_OP_PSP_ALLOCATE_KEYS			= 560,
 	VIRTCHNL2_OP_CRYPTO_GET_CAPS			= 564,
 	VIRTCHNL2_OP_PSP_GET_CAPS			= 565,
 	VIRTCHNL2_OP_GET_FIPS_COMPLIANCE_STATUS		= 567,
@@ -1891,6 +1892,15 @@ enum virtchnl2_psp_domain_type {
 	VIRTCHNL2_PSP_DOMAIN_OEM_END			= 0xffff,
 };
 
+/* VIRTCHNL2_PSP_ALLOC_KEY_EXHAUSTED: the keys derived from the current master
+ * key are exhausted and a master key rotation will be performed
+ * automatically. Only set on partial success, i.e. if fewer keys than
+ * requested, but at least one, were allocated.
+ */
+enum virtchnl2_psp_allocate_response_flags {
+	VIRTCHNL2_PSP_ALLOC_KEY_EXHAUSTED		= BIT(0),
+};
+
 /**
  * struct virtchnl2_psp_key_domain - PSP key domain
  * @type: See enum virtchnl2_psp_domain_type
@@ -1909,6 +1919,74 @@ struct virtchnl2_psp_key_domain {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_psp_key_domain);
 
+/**
+ * struct virtchnl2_psp_allocate_keys_request - Allocate PSP RX keys request
+ * @vport_id: Virtual port ID
+ * @num_keys: Number of keys requested, 0 only reads the active master key
+ *	      generation
+ * @key_type: See enum virtchnl2_psp_key_type
+ * @pad: Reserved/padding
+ * @domain: Key domain, must be zero-filled if VIRTCHNL2_CAP_PSP_DOMAIN was
+ *	    not granted
+ */
+struct virtchnl2_psp_allocate_keys_request {
+	__le32 vport_id;
+	__le32 num_keys;
+	u8 key_type;
+	u8 pad[7];
+	struct virtchnl2_psp_key_domain domain;
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(32, virtchnl2_psp_allocate_keys_request);
+
+/**
+ * struct virtchnl2_allocate_psp_key_v0 - Allocated PSP V0 key entry
+ * @spi: Security parameter index
+ * @pad: Reserved/padding
+ * @v0_key: 128-bit key
+ */
+struct virtchnl2_allocate_psp_key_v0 {
+	__le32 spi;
+	u8 pad[4];
+	u8 v0_key[VIRTCHNL2_PSP_KEY_SIZE_V0];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_allocate_psp_key_v0);
+
+/**
+ * struct virtchnl2_allocate_psp_key_v1 - Allocated PSP V1 key entry
+ * @spi: Security parameter index
+ * @pad: Reserved/padding
+ * @v1_key: 256-bit key
+ */
+struct virtchnl2_allocate_psp_key_v1 {
+	__le32 spi;
+	u8 pad[4];
+	u8 v1_key[VIRTCHNL2_PSP_KEY_SIZE_V1];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(40, virtchnl2_allocate_psp_key_v1);
+
+/**
+ * struct virtchnl2_psp_allocate_keys_response - Allocate PSP RX keys response
+ * @vport_id: Virtual port ID
+ * @key_type: See enum virtchnl2_psp_key_type
+ * @allocate_response_flags: See enum virtchnl2_psp_allocate_response_flags
+ * @pad1: Reserved/padding
+ * @master_key_generation: Master key generation, increased by 1 every time
+ *			   the set of active master keys changes
+ * @keys_size_bytes: Total size of keys payload in bytes
+ * @keys: Flexible array of struct virtchnl2_allocate_psp_key_v0 or
+ *	  struct virtchnl2_allocate_psp_key_v1 entries
+ */
+struct virtchnl2_psp_allocate_keys_response {
+	__le32 vport_id;
+	u8 key_type;
+	u8 allocate_response_flags;
+	u8 pad1[2];
+	__le32 master_key_generation;
+	__le32 keys_size_bytes;
+	u8 keys[] __counted_by_le(keys_size_bytes);
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_psp_allocate_keys_response);
+
 /**
  * struct virtchnl2_get_fips_compliance_status_resp - FIPS compliance response
  * @num_certs: Number of certificates, 0 if not FIPS compliant
-- 
2.56.0.679.gc527c65306-goog

