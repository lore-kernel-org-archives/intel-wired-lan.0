Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B0606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=t9XgFj/r;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AdFaDQvU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35BFE60A44;
	Tue, 17 Nov 2026 16:29:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G7j04yrOUe5S; Tue, 17 Nov 2026 16:29:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2D6FD60A46
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932954;
	b=senG6SrTeW7+V8hKPjzYW9jcrH60vkLmYgaDIrR5cXIVlRdNEGt8jrQhk3UbWFbbXAZW
	 9dtxuR9gNlPy+1JfxBklLD1f34dnmeN7EHIvRW17JcQ+kDud1LE4YdwR/Ltntm0iOr1Dj
	 GsOxAaY8AAygDNQTAYWqui/5LMTVWD9GctX6JQT+O0GDpQ5PApKRgCYTdXmlBNnf/pzPG
	 aPmV9CuHIgML2bDNrEXjGWD1WBPRNA+ziVD9xQIICS1dRaSAlEQv7kMotqUpIRyTPUAhm
	 qGkCBnn3gTl//VrorVs+T2ZLyMfbZAkVpObrusBtYx7j/ZESLAxaChYx/xjG8ZW8EtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9xGhqAumENcBNtzDfruylYbHUoXUw8SL2Wwg6sFFVmM=;
	b=dp3tgxJYqYz5z5lIen+oEIAF5Z5extgGks+XiRuko4IBKxNh7d8KyIY6gA8b04W31oJ/
	 tujfEE3WC/sIxkjco0WHBUjatbupcX1jtAvFqhHofNjHczD80OpZETKI50u5C8062iKiC
	 AR7ZdSbudSa3UbMyK1lQ2IhnGoovUNYrUm5d1uNdY3gv5n2mrrhLute9EELT8PbU/e5ri
	 JCNt/mixkXYkxeS6undpCu5UAstsw+M+30XLVPbsWUywdak/celiCozyApInR7qDNqALw
	 CiYRTnRZ2xq/nMAidMvYrljpyb/eNEEqMJI1LmTO/eb4GyZnYOL5dYoPEAiu/lcUZTg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AdFaDQvU;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932954;
	bh=9xGhqAumENcBNtzDfruylYbHUoXUw8SL2Wwg6sFFVmM=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t9XgFj/rEfM1CcqEprnXYwfAV3EtBb0QRBor8ncghMdrycm+o2Aij77EYsDFbwmOf
	 QY2NvvS5TgYu+qYTbNTEdQViL8KVSzd9joQzfy38eG0/N3uhrHW/icp68iBg8+xxeW
	 Mycm85rTsuikrHsgbefRY/U3GYkn9ZwkMZsaaqRFsR4GsZPZh1NV+j5u0Fhj+8TKTZ
	 HlWZBNo1UBWk3ejYKE6JOCp5fUIm6VybJFunqamy5XWwxJln5kEkK/js/FSlkTmP3R
	 P76jB1cset0M/ZSxE5nWRZIY7Rm1F3eQtnGvwT6OcC6zTCArbxUdBCrTPdCac05GWc
	 Ye7IBnPP5JwVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D6FD60A46;
	Tue, 17 Nov 2026 16:29:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 33C57D5B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B6B5608F8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fh4Sf6W5TgVE for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:55:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C613608EF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b148"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b148; helo=mail-yx1-xb148.google.com;
 envelope-from=37mr8agukdxudev8319916z.x9738ez6-h3czy-6v863ded.9df9d6.9c1@flex--stani.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=AdFaDQvU
Received: from mail-yx1-xb148.google.com (mail-yx1-xb148.google.com
 [IPv6:2607:f8b0:4864:20::b148])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C613608EF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:43 +0000 (UTC)
Received: by mail-yx1-xb148.google.com with SMTP id
 956f58d0204a3-6798fd97f3aso9863343d50.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 06:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794927342; x=1795532142; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9xGhqAumENcBNtzDfruylYbHUoXUw8SL2Wwg6sFFVmM=;
 b=AdFaDQvUJd7yB80y5BFe6EjRpg/BNKEC82oVI72IyKTsfioYcGh1D1q38xsPXr+uLu
 6FjlEG7vRn/DHrc5L5lmrAfur8uZzLFqQMnLqtv9fIGlKC0GmpfsJs+3CkCmK61gNGzw
 GUPxzaDpASoJpp4LPnqjmKTME7pMm/nTcu3x6SLyy8eTncMFpol7Wl/2bQCg1gOgZG9Q
 gs5gKtc/on61/QP/PBh3RqQf3TxsCVz/jiEtvezTYV6sHcdd25eisEJvUtAtPvvk5p9u
 R8Uzn1kCLIHGcZn+xxf8eRmB2zzz3pGSF43TcmR1opzEh41ofBdDcIVf73nrkgNko/G2
 ffQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927342; x=1795532142;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9xGhqAumENcBNtzDfruylYbHUoXUw8SL2Wwg6sFFVmM=;
 b=CTCy2dFxnnHWtrgTHKLQnBBlBmt7+KI03gTaDvvui3ix9czI1aCVEk5k2flf27NDdd
 KwzZCQXkCvaHkPB1RsKXeQ2l3YIe9Avny5Bj7ZxUMvAt2SiYTu70xjvRdYnCfLtjB8Y7
 2QVcA1qKvnrJJp1KlI4rKLk1woljW1aMlMlxrLliRRbGGNMrORBj8xYNoV8CQcqVn8wr
 SJFK8S9j0h4Wj/52I91J18z0jLBcZCbVysHxCpjA7wTaq2O52lWtQfFwONzqYxAwbtc+
 KCjEeelsZBKMHRnXdTz5GknKHAX3R0fH4SDtOFBPtsrulpggIsxSdACyUqhTejttSbmj
 cLJw==
X-Forwarded-Encrypted: i=1;
 AL+hErEvqYjeVic+lYKhwT0Rgz01X6YOJ2cG0h+A3BAKXUGQ91a4cUy8C0s5i8Q8u8246viATtww8AcN6E+A2TO33M8=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/4RdiED07A7mWl+PPcRgD8AhJOsN9eMJl/k9D/64X85pzRRjlf
 +lhHQmxkM89r/yBt6JCvVf75glvR2Zg9eteeO2MxsFA7rA4vYaGUZuNd5DDwk29mAbsiZ9NcGxd
 d4Q==
X-Received: from ywbi9-n2.prod.google.com
 ([2002:a05:690c:e209:20b0:8ab:3506:f904])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:43c3:b0:67b:f19f:9690
 with SMTP id 956f58d0204a3-67d8971eb9dmr3968944d50.115.1794927342132; Tue, 17
 Nov 2026 06:55:42 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:10 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-5-stani@google.com>
Subject: [PATCH iwl-next 04/15] idpf: psp: add psp offload initialization
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

Add the PSP offload initialization:
- Introduce VIRTCHNL2_CAP_CRYPTO (bit 26 of the other capabilities)
  and request it in VIRTCHNL2_OP_GET_CAPS if CONFIG_INET_PSP is
  enabled.
- Add struct idpf_adapter_psp to struct idpf_adapter.
- Implement idpf_psp_init(), called from idpf_vc_core_init() on each
  core init, including after a hard reset, and idpf_psp_free(), called
  from idpf_remove(). PSP is enabled if VIRTCHNL2_CAP_CRYPTO was
  granted, see idpf_is_psp_ena(). A failure disables PSP instead of
  failing the core init.
- Add the PSP device ops with idpf_psp_set_config(), and
  idpf_psp_register()/idpf_psp_unregister(). The PSP device is
  registered in a later patch, once all mandatory PSP device ops and the
  datapath are implemented.
- Build idpf_psp.c only with CONFIG_INET_PSP, with static inline stubs
  in idpf_psp.h otherwise.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/Makefile      |   2 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  15 +++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   1 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   2 +
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 115 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_psp.h    |  24 ++++
 .../net/ethernet/intel/idpf/idpf_psp_def.h    |  21 ++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |   7 ++
 include/linux/net/intel/virtchnl2.h           |   1 +
 9 files changed, 188 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp_def.h

diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 81b27a406747..3162ea913417 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -21,5 +21,7 @@ idpf-$(CONFIG_IDPF_SINGLEQ)	+= idpf_singleq_txrx.o
 idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_ptp.o
 idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_virtchnl_ptp.o
 
+idpf-$(CONFIG_INET_PSP)		+= idpf_psp.o
+
 idpf-y				+= xdp.o
 idpf-y				+= xsk.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 77729921b0a3..fe16fd99a41d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -28,6 +28,7 @@ struct idpf_rss_data;
 #include <linux/net/intel/virtchnl2.h>
 
 #include "idpf_txrx.h"
+#include "idpf_psp_def.h"
 
 #define GETMAXVAL(num_bits)		GENMASK((num_bits) - 1, 0)
 
@@ -625,6 +626,7 @@ struct idpf_rdma_irq {
  * @req_vec_chunks: Requested vector chunk data
  * @mb_vector: Mailbox vector data
  * @irq_mb_handler: Handler for hard interrupt for mailbox
+ * @psp: PSP offload state, see idpf_psp_init()
  * @tx_timeout_count: Number of TX timeouts that have occurred
  * @avail_queues: Device given queue limits
  * @vports: Array to store vports created by the driver
@@ -683,6 +685,7 @@ struct idpf_adapter {
 	struct idpf_q_vector mb_vector;
 	irqreturn_t (*irq_mb_handler)(int irq, void *data);
 
+	struct idpf_adapter_psp psp;
 	u32 tx_timeout_count;
 	struct idpf_avail_queue_info avail_queues;
 	struct idpf_vport **vports;
@@ -761,6 +764,18 @@ static inline bool idpf_is_rdma_cap_ena(struct idpf_adapter *adapter)
 	return idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_RDMA);
 }
 
+/**
+ * idpf_is_psp_ena - Determine if PSP offload is enabled
+ * @adapter: private data struct
+ *
+ * Return: true if PSP offload was negotiated in the last core init, see
+ * idpf_psp_init(), false otherwise
+ */
+static inline bool idpf_is_psp_ena(const struct idpf_adapter *adapter)
+{
+	return IS_ENABLED(CONFIG_INET_PSP) && READ_ONCE(adapter->psp.enabled);
+}
+
 #define IDPF_CAP_RSS (\
 	VIRTCHNL2_FLOW_IPV4_TCP		|\
 	VIRTCHNL2_FLOW_IPV4_UDP		|\
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index e03661503e5f..1385209519b2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -6,6 +6,7 @@
 #include "idpf_ptp.h"
 #include "xdp.h"
 #include "xsk.h"
+#include "idpf_psp.h"
 
 static const struct net_device_ops idpf_netdev_ops;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 566d5804c8c1..2fab58f4b02b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -5,6 +5,7 @@
 #include "idpf_devids.h"
 #include "idpf_devlink.h"
 #include "idpf_lan_vf_regs.h"
+#include "idpf_psp.h"
 #include "idpf_virtchnl.h"
 
 #define DRV_SUMMARY	"Intel(R) Infrastructure Data Path Function Linux Driver"
@@ -180,6 +181,7 @@ static void idpf_remove(struct pci_dev *pdev)
 	}
 	kfree(adapter->vport_config);
 	adapter->vport_config = NULL;
+	idpf_psp_free(adapter);
 	kfree(adapter->netdevs);
 	adapter->netdevs = NULL;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
new file mode 100644
index 000000000000..c1297ec59163
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <net/psp.h>
+
+#include "idpf_psp.h"
+
+/**
+ * idpf_psp_init - Initialize PSP offload
+ * @adapter: private data struct
+ *
+ * Called on each core init, including after a hard reset: PSP offload is
+ * negotiated again, the CP may grant different capabilities. PSP offload uses
+ * the virtchnl2 crypto offload API: if VIRTCHNL2_CAP_CRYPTO was not granted or
+ * the negotiation fails, PSP stays disabled for the adapter instead of failing
+ * the core init, see idpf_is_psp_ena().
+ */
+void idpf_psp_init(struct idpf_adapter *adapter)
+{
+	struct idpf_adapter_psp *psp = &adapter->psp;
+	struct device *dev = &adapter->pdev->dev;
+
+	WRITE_ONCE(psp->enabled, false);
+
+	if (!idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_CRYPTO)) {
+		dev_notice(dev, "PSP disabled, crypto capability not granted\n");
+		return;
+	}
+
+	WRITE_ONCE(psp->enabled, true);
+}
+
+/**
+ * idpf_psp_free - Release the PSP offload resources
+ * @adapter: private data struct
+ *
+ * Called on remove, after idpf_vc_core_deinit().
+ */
+void idpf_psp_free(struct idpf_adapter *adapter)
+{
+	idpf_psp_unregister(adapter);
+}
+
+/**
+ * idpf_psp_set_config - Set the PSP device configuration
+ * @psd: PSP device
+ * @conf: new configuration
+ * @extack: netlink extended ack for error reporting
+ *
+ * The configuration is applied by the PSP core.
+ *
+ * Return: 0.
+ */
+static int idpf_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
+			       struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+/* PSP device operations, see idpf_psp_register() */
+static struct psp_dev_ops idpf_psp_ops = {
+	.set_config	= idpf_psp_set_config,
+};
+
+/**
+ * idpf_psp_register - Register the PSP device
+ * @adapter: private data struct
+ *
+ * Register the PSP device of the first netdev if PSP offload was negotiated
+ * and the netdev is registered.
+ */
+void idpf_psp_register(struct idpf_adapter *adapter)
+{
+	struct device *dev = &adapter->pdev->dev;
+	struct psp_dev *psd;
+
+	if (!idpf_is_psp_ena(adapter) || adapter->psp.psp_dev)
+		return;
+
+	if (!adapter->netdevs || !adapter->netdevs[0] ||
+	    !test_bit(IDPF_VPORT_REG_NETDEV, adapter->vport_config[0]->flags))
+		return;
+
+	/* The driver only allocates and inserts PSP version 0 keys */
+	adapter->psp.caps.versions = BIT(PSP_VERSION_HDR0_AES_GCM_128);
+
+	psd = psp_dev_create(adapter->netdevs[0], &idpf_psp_ops,
+			     &adapter->psp.caps, NULL);
+	if (IS_ERR(psd)) {
+		dev_err(dev, "PSP failed to register: %pe\n", psd);
+		return;
+	}
+
+	adapter->psp.psp_dev = psd;
+	dev_info(dev, "PSP Netlink device registered successfully: id=%u\n",
+		 psd->id);
+}
+
+/**
+ * idpf_psp_unregister - Unregister the PSP device
+ * @adapter: private data struct
+ *
+ * The PSP core deletes the TX keys of all the associations, see
+ * idpf_psp_tx_key_del(). Called before the netdev of the PSP device is
+ * unregistered.
+ */
+void idpf_psp_unregister(struct idpf_adapter *adapter)
+{
+	struct psp_dev *psd = adapter->psp.psp_dev;
+
+	if (!psd)
+		return;
+
+	psp_dev_unregister(psd);
+	adapter->psp.psp_dev = NULL;
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.h b/drivers/net/ethernet/intel/idpf/idpf_psp.h
new file mode 100644
index 000000000000..0f89dcc3b398
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _IDPF_PSP_H_
+#define _IDPF_PSP_H_
+
+#include "idpf.h"
+
+#if IS_ENABLED(CONFIG_INET_PSP)
+
+void idpf_psp_init(struct idpf_adapter *adapter);
+void idpf_psp_free(struct idpf_adapter *adapter);
+void idpf_psp_register(struct idpf_adapter *adapter);
+void idpf_psp_unregister(struct idpf_adapter *adapter);
+
+#else /* !CONFIG_INET_PSP */
+
+static inline void idpf_psp_init(struct idpf_adapter *adapter) { }
+static inline void idpf_psp_free(struct idpf_adapter *adapter) { }
+static inline void idpf_psp_register(struct idpf_adapter *adapter) { }
+static inline void idpf_psp_unregister(struct idpf_adapter *adapter) { }
+
+#endif /* CONFIG_INET_PSP */
+
+#endif /* !_IDPF_PSP_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
new file mode 100644
index 000000000000..2edb114784c1
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _IDPF_PSP_DEF_H_
+#define _IDPF_PSP_DEF_H_
+
+#include <net/psp.h>
+
+/**
+ * struct idpf_adapter_psp - PSP offload state of an adapter
+ * @enabled: PSP was negotiated with the CP in the last core init, see
+ *	     idpf_is_psp_ena()
+ * @psp_dev: the PSP device, see idpf_psp_register()
+ * @caps: capabilities of @psp_dev
+ */
+struct idpf_adapter_psp {
+	bool enabled;
+	struct psp_dev *psp_dev;
+	struct psp_dev_caps caps;
+};
+
+#endif /* !_IDPF_PSP_DEF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index fedac4716b08..3f669683c8c0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -9,6 +9,7 @@
 #include "idpf.h"
 #include "idpf_virtchnl.h"
 #include "idpf_ptp.h"
+#include "idpf_psp.h"
 
 /**
  * idpf_vid_to_vport - Translate vport id to vport pointer
@@ -584,6 +585,10 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 			    VIRTCHNL2_CAP_PTP			|
 			    VIRTCHNL2_CAP_EDT);
 
+	/* PSP offload uses the virtchnl2 crypto offload API */
+	if (IS_ENABLED(CONFIG_INET_PSP))
+		caps.other_caps |= cpu_to_le64(VIRTCHNL2_CAP_CRYPTO);
+
 	err = idpf_send_mb_msg_stack(adapter, &xn_params, &caps);
 	if (err)
 		return err;
@@ -3179,6 +3184,8 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		goto intr_rel;
 	}
 
+	idpf_psp_init(adapter);
+
 	err = idpf_ptp_init(adapter);
 	if (err)
 		pci_err(adapter->pdev, "PTP init failed, err=%pe\n",
diff --git a/include/linux/net/intel/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
index 39fea65c075c..ec1a742b6557 100644
--- a/include/linux/net/intel/virtchnl2.h
+++ b/include/linux/net/intel/virtchnl2.h
@@ -221,6 +221,7 @@ enum virtchnl2_cap_other {
 	/* Other capability 20 is reserved */
 	VIRTCHNL2_CAP_FLOW_STEER		= BIT_ULL(21),
 	VIRTCHNL2_CAP_LAN_MEMORY_REGIONS	= BIT_ULL(22),
+	VIRTCHNL2_CAP_CRYPTO			= BIT_ULL(26),
 
 	/* this must be the last capability */
 	VIRTCHNL2_CAP_OEM			= BIT_ULL(63),
-- 
2.56.0.679.gc527c65306-goog

