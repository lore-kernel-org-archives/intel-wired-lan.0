Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CDC606A32A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=G5A+1Uok;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Se5+NuaR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56EE6408FB;
	Tue, 17 Nov 2026 16:29:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 24PfFwn_MAUS; Tue, 17 Nov 2026 16:29:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 64A1940937
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932945;
	b=ohakp5fhrSY/OvVMJycYUOw25G3HYUsBKOAKnY1jZdKSHzweDOWymu4JNbIbNKEz6ffD
	 Qyr3KRXQsWL3ma3NoC/2JjinGRVkOCELzR/cyk81FVukr9ANPPxJ1OClc1flVTa/3dyfr
	 e4qcGb3q5EG7BH6GX0w5RiwstCIWGA2/m6QlsYFLTw8rvQlv90Md4dezmIPPu13ljggp9
	 1Q3R0HAKQOsd55UM37r56z+Sugcpr1U+kevvL3bEDekIEmNXEozarOz02oP36uvw9hzfm
	 aiwpLx1HsCz8UkvHHWZbxSkW38gGBLCsnjEvN7TFCb88o/chHCfvcYF2t5TpgkFVVkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932945;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YXN/cmE2b18TH9R1wcOBPcApNcBvXcI1LLfj/l4dFc4=;
	b=agSzTEyf81c4hlmlS51O2xGzlMT76yvv5HaEjBteQMPAFA8zdbLUtd8vajE1HSgG/8ho
	 s1Ytx5xNPFVBTctOyIYcIp+WIUODY0GLIiHROVewpL2dJ0Tfg9Tubi0x3SFQOEnT0GFXA
	 qH264kjJRDjwsTNWdiWBQ4LvfO+6jDkCOMrcOh7aGW8NwX41BSrRML2Lobtcd5D3Tth79
	 LzzLfL33Vry4P8XQyFRjFeyX62/0TIzu2imTANdv3x3BXh/iJX8aYxO7A7ND7/b1Z3Rm4
	 Fgpp8NWt+k2e+1eRppPRhWrvKGnMCbEiwvl4ABjsezf4TNmQDTYJYJ8o94D4rsVL0Cw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932945;
	bh=YXN/cmE2b18TH9R1wcOBPcApNcBvXcI1LLfj/l4dFc4=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G5A+1UokA9kfXdEY4i3XE5VJFR4gzuLXBhPo5aeQw/5tmgHkrXRQZ7DxF3ihD9U1C
	 llnvNOMMeulqTtyje3oIMi6UWKJrsNFqfGllkoYWviDeoTEfB9KQfC7kC+ToQIRLSw
	 hHxIe6h+ObDOAjBIqo4OFdE/KEI3/wM8EVq1lVbEdlTBE2dYqal2wYm3i60isLPujb
	 JHP/mS/EE8djB8FsGl9XOANtkHcgj2vz71q8MZdQIxVKUwwpwM+J14FaB2epQoPiXm
	 V50MS2S57A/hqSUT2r5eAs8X3fhEGwvhpSSFe7bsOUZgZGf0akDi1wOdIBlqSkgT4e
	 NzQC2117airtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64A1940937;
	Tue, 17 Nov 2026 16:29:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0160949B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E774E4033A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oR7MujfIrv7i for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:55:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C764C400BB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b146"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b146; helo=mail-yx1-xb146.google.com;
 envelope-from=372r8agukdxyefw942aa270.ya849f07-i4d0z-7w974efe.aegae7.ad2@flex--stani.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=Se5+NuaR
Received: from mail-yx1-xb146.google.com (mail-yx1-xb146.google.com
 [IPv6:2607:f8b0:4864:20::b146])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C764C400BB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:44 +0000 (UTC)
Received: by mail-yx1-xb146.google.com with SMTP id
 956f58d0204a3-67dad09be07so2492662d50.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 06:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794927343; x=1795532143; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YXN/cmE2b18TH9R1wcOBPcApNcBvXcI1LLfj/l4dFc4=;
 b=Se5+NuaRq+WEoP1zkZEhSHFInwtWiiltGAw8tuwTQqZ2KErbb34ZL6maOIOIc1uBud
 O4vYQMmZf6qRJlhdKnZy1U1crQeKfCr89DSW7+xKbEsVvJeT2WxaJ0j9SOKlTFmVVC9u
 S4iJc8piMbiD51ME8OzejQF25QFB6BkNUgdXr/U0AXpAriy3uLaoVs+MVXDTItBX+UE5
 62gxLzF+LpfyTBrjA3rAe+eRILJBYewP1yG30lussV1CxRlK8FTTNCzCAGZvpT5DgCGt
 bTUgcXppL0LAgKAl5uqyuLQma5M689KVG/zgdPMsSt5jL/trAZdrUNoa8AJHLXFNZon8
 jqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927343; x=1795532143;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YXN/cmE2b18TH9R1wcOBPcApNcBvXcI1LLfj/l4dFc4=;
 b=HMJ9P7IAInYpB5MknkeGA7eFrzhXGhYMb/+nkcVODmqz81BVtW6Ql80GdPsXoFJgg8
 +sZD01zHBDGpapzdrSrNdw+qCDhVTwx+NMTbW9KGPPmjZGScaH1GkGgnPPrBbjXee8Zz
 xUeAipiPC5SuSpTcs7Cyd1dRQIyemtRoVB064w+cXsPECto8e/h+zow+EcIQlNC91+Ov
 T6+6VRt4it/mI5NB6C0IjPWRE+9Q23Hi/iPJpWy0Y8Hgyk/tXBMN+dP2yjnAbT0h40ci
 aUw5cCabh0FnLInnmC3pVXZQbuoPSzQ2ToCPbnSLZGLD1VUsN8USVfYjfjplOBVmF4lE
 VnmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEE5SnFUmtqvor7w3B5JNYJE2o1YH6/wVnzF4y+z+jqeL2A9TKu9W1n8PNxBlKQornzEfrWM3dpxeSdNCbV7Qg=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9PX/MoBV1CNgopdG2ZZQe17xXnE4QMbJUdLUDQSl6u9NKhYene
 kX8qXUnoiqCstGayszlhCbtynjT/Nu3i5TJaG3ZiRw5NZcWpcUH/TaBxTTxrY3TutknRpxg8Nfc
 RQg==
X-Received: from yxpq15.prod.google.com ([2002:a53:e8cf:0:b0:67d:a676:2621])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:168d:b0:679:c7d1:ffd6
 with SMTP id 956f58d0204a3-67d896a36cfmr9511324d50.36.1794927343014; Tue, 17
 Nov 2026 06:55:43 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:11 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-6-stani@google.com>
Subject: [PATCH iwl-next 05/15] idpf: psp: add support for crypto capabilities
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

Add support for negotiating the crypto offload capabilities:
- Introduce VIRTCHNL2_OP_CRYPTO_GET_CAPS (564),
  enum virtchnl2_cap_crypto and struct virtchnl2_crypto_get_caps.
- Implement idpf_send_get_crypto_caps() in the new
  idpf_psp_virtchnl.c and call it from idpf_psp_negotiate_caps() in
  idpf_psp_init(). PSP stays disabled, without failing probe, unless
  PSP crypto offload and SADB entries are granted with a 21 or 26 bit
  SA index width, and the SA indexes of all the SADB entries fit in
  the width.
- Store the SADB size and the SA index width of the adapter in
  adapter->psp.sadb_entries and adapter->psp.saidx_width.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/Makefile      |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 61 ++++++++++++++++
 .../net/ethernet/intel/idpf/idpf_psp_def.h    | 10 +++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.c   | 71 +++++++++++++++++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.h   | 13 ++++
 include/linux/net/intel/virtchnl2.h           | 26 +++++++
 6 files changed, 182 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h

diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 3162ea913417..8db28c228e04 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -21,7 +21,7 @@ idpf-$(CONFIG_IDPF_SINGLEQ)	+= idpf_singleq_txrx.o
 idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_ptp.o
 idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_virtchnl_ptp.o
 
-idpf-$(CONFIG_INET_PSP)		+= idpf_psp.o
+idpf-$(CONFIG_INET_PSP)		+= idpf_psp.o idpf_psp_virtchnl.o
 
 idpf-y				+= xdp.o
 idpf-y				+= xsk.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
index c1297ec59163..c4f46f7337ef 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -3,6 +3,59 @@
 #include <net/psp.h>
 
 #include "idpf_psp.h"
+#include "idpf_psp_virtchnl.h"
+
+/**
+ * idpf_psp_negotiate_caps - Negotiate the crypto and PSP capabilities
+ * @adapter: private data struct
+ *
+ * Query the crypto and PSP capabilities granted by the CP, check that they
+ * cover what the driver implements and apply the negotiated values. Must only
+ * be called if VIRTCHNL2_CAP_CRYPTO was negotiated.
+ *
+ * Return: 0 if PSP offload can be used, negative error code otherwise.
+ */
+static int idpf_psp_negotiate_caps(struct idpf_adapter *adapter)
+{
+	struct virtchnl2_crypto_get_caps crypto_caps = { };
+	struct device *dev = &adapter->pdev->dev;
+	u32 sadb_entries;
+	int err;
+
+	err = idpf_send_get_crypto_caps(adapter, &crypto_caps);
+	if (err)
+		return err;
+
+	if (!(le32_to_cpu(crypto_caps.crypto_caps) & VIRTCHNL2_CAP_CRYPTO_PSP)) {
+		dev_notice(dev, "PSP crypto offload not granted by CP\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (crypto_caps.saidx_width != IDPF_PSP_SAIDX_WIDTH_21 &&
+	    crypto_caps.saidx_width != IDPF_PSP_SAIDX_WIDTH_26) {
+		dev_err(dev, "Unsupported PSP SA index width %u\n",
+			crypto_caps.saidx_width);
+		return -EOPNOTSUPP;
+	}
+
+	sadb_entries = le32_to_cpu(crypto_caps.num_sadb_entries);
+	if (!sadb_entries) {
+		dev_notice(dev, "No PSP SADB entries granted by CP\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* The SA indexes of all the SADB entries must fit in the width */
+	if (sadb_entries > BIT(crypto_caps.saidx_width)) {
+		dev_err(dev, "%u PSP SADB entries don't fit in %u bit SA indexes\n",
+			sadb_entries, crypto_caps.saidx_width);
+		return -EOPNOTSUPP;
+	}
+
+	adapter->psp.sadb_entries = sadb_entries;
+	adapter->psp.saidx_width = crypto_caps.saidx_width;
+
+	return 0;
+}
 
 /**
  * idpf_psp_init - Initialize PSP offload
@@ -18,6 +71,7 @@ void idpf_psp_init(struct idpf_adapter *adapter)
 {
 	struct idpf_adapter_psp *psp = &adapter->psp;
 	struct device *dev = &adapter->pdev->dev;
+	int err;
 
 	WRITE_ONCE(psp->enabled, false);
 
@@ -26,6 +80,13 @@ void idpf_psp_init(struct idpf_adapter *adapter)
 		return;
 	}
 
+	err = idpf_psp_negotiate_caps(adapter);
+	if (err) {
+		dev_warn(dev, "PSP disabled, capability negotiation failed: %d\n",
+			 err);
+		return;
+	}
+
 	WRITE_ONCE(psp->enabled, true);
 }
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
index 2edb114784c1..3a9e40284106 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
@@ -5,15 +5,25 @@
 
 #include <net/psp.h>
 
+/* SA index widths supported by the driver, negotiated per adapter with
+ * VIRTCHNL2_OP_CRYPTO_GET_CAPS, see idpf_psp_negotiate_caps().
+ */
+#define IDPF_PSP_SAIDX_WIDTH_21		21
+#define IDPF_PSP_SAIDX_WIDTH_26		26
+
 /**
  * struct idpf_adapter_psp - PSP offload state of an adapter
  * @enabled: PSP was negotiated with the CP in the last core init, see
  *	     idpf_is_psp_ena()
+ * @sadb_entries: SADB size granted by VIRTCHNL2_OP_CRYPTO_GET_CAPS
+ * @saidx_width: SA index width granted by VIRTCHNL2_OP_CRYPTO_GET_CAPS
  * @psp_dev: the PSP device, see idpf_psp_register()
  * @caps: capabilities of @psp_dev
  */
 struct idpf_adapter_psp {
 	bool enabled;
+	u32 sadb_entries;
+	u8 saidx_width;
 	struct psp_dev *psp_dev;
 	struct psp_dev_caps caps;
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
new file mode 100644
index 000000000000..65f7a9f63f90
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "idpf_psp_virtchnl.h"
+#include "idpf_virtchnl.h"
+
+/**
+ * idpf_print_crypto_caps - Print values inside virtchnl2_crypto_get_caps
+ * @adapter: Driver specific private structure
+ * @caps: Pointer to virtchnl2_crypto_get_caps structure
+ */
+static void idpf_print_crypto_caps(struct idpf_adapter *adapter,
+				   const struct virtchnl2_crypto_get_caps *caps)
+{
+	u32 num_sadb_entries = le32_to_cpu(caps->num_sadb_entries);
+	u32 crypto_caps = le32_to_cpu(caps->crypto_caps);
+
+	dev_dbg(&adapter->pdev->dev,
+		"virtchnl2_crypto_get_caps: crypto_caps=0x%08x (PSP=%u), num_sadb_entries=%u, saidx_width=%u\n",
+		crypto_caps, !!(crypto_caps & VIRTCHNL2_CAP_CRYPTO_PSP),
+		num_sadb_entries, caps->saidx_width);
+}
+
+/**
+ * idpf_send_get_crypto_caps - Send VIRTCHNL2_OP_CRYPTO_GET_CAPS request to CP
+ * @adapter: Driver specific private structure
+ * @caps: Output buffer for virtchnl2_crypto_get_caps
+ *
+ * Request the PSP crypto offload. Must only be sent if VIRTCHNL2_CAP_CRYPTO
+ * was granted.
+ *
+ * Return: 0 on success, negative on failure.
+ */
+int idpf_send_get_crypto_caps(struct idpf_adapter *adapter,
+			      struct virtchnl2_crypto_get_caps *caps)
+{
+	struct libie_ctlq_xn_send_params xn_params = {
+		.chnl_opcode	= VIRTCHNL2_OP_CRYPTO_GET_CAPS,
+		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	struct virtchnl2_crypto_get_caps *send_caps;
+	int err;
+
+	/* Too large to be sent from the stack */
+	send_caps = kzalloc_obj(*send_caps);
+	if (!send_caps)
+		return -ENOMEM;
+
+	send_caps->crypto_caps = cpu_to_le32(VIRTCHNL2_CAP_CRYPTO_PSP);
+
+	err = idpf_send_mb_msg_kfree(adapter, &xn_params, send_caps,
+				     sizeof(*send_caps));
+	if (err) {
+		dev_err(&adapter->pdev->dev, "Failed to get crypto caps: %d\n",
+			err);
+		return err;
+	}
+
+	if (xn_params.recv_mem.iov_len < sizeof(*caps)) {
+		dev_err(&adapter->pdev->dev, "Invalid crypto caps reply size: %zu\n",
+			xn_params.recv_mem.iov_len);
+		err = -EIO;
+		goto release_rx;
+	}
+
+	memcpy(caps, xn_params.recv_mem.iov_base, sizeof(*caps));
+	idpf_print_crypto_caps(adapter, caps);
+
+release_rx:
+	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
+	return err;
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
new file mode 100644
index 000000000000..cf82ac9182ef
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _IDPF_PSP_VIRTCHNL_H_
+#define _IDPF_PSP_VIRTCHNL_H_
+
+#include <linux/net/intel/libie/controlq.h>
+
+#include "idpf_psp.h"
+
+int idpf_send_get_crypto_caps(struct idpf_adapter *adapter,
+			      struct virtchnl2_crypto_get_caps *caps);
+
+#endif /* !_IDPF_PSP_VIRTCHNL_H_ */
diff --git a/include/linux/net/intel/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
index ec1a742b6557..59c379afcb71 100644
--- a/include/linux/net/intel/virtchnl2.h
+++ b/include/linux/net/intel/virtchnl2.h
@@ -84,6 +84,8 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_ADD_FLOW_RULE			= 551,
 	VIRTCHNL2_OP_GET_FLOW_RULE			= 552,
 	VIRTCHNL2_OP_DEL_FLOW_RULE			= 553,
+	/* Crypto/PSP opcodes */
+	VIRTCHNL2_OP_CRYPTO_GET_CAPS			= 564,
 };
 
 /**
@@ -1817,4 +1819,28 @@ struct virtchnl2_flow_rule_add_del {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_flow_rule_add_del);
 
+/* Generic crypto offload types */
+enum virtchnl2_cap_crypto {
+	VIRTCHNL2_CAP_CRYPTO_PSP			= BIT(0),
+};
+
+/**
+ * struct virtchnl2_crypto_get_caps - Crypto global capabilities
+ * @crypto_caps: See enum virtchnl2_cap_crypto
+ * @num_sadb_entries: Number of SADB entries of the function, not shared with
+ *		      the other functions of the device
+ * @saidx_width: SA index width in bits
+ * @padding: Padding to 256 bytes
+ *
+ * Request and response of VIRTCHNL2_OP_CRYPTO_GET_CAPS. On input @crypto_caps
+ * holds the requested capabilities, on output the granted ones.
+ */
+struct virtchnl2_crypto_get_caps {
+	__le32 crypto_caps;
+	__le32 num_sadb_entries;
+	u8 saidx_width;
+	u8 padding[247];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(256, virtchnl2_crypto_get_caps);
+
 #endif /* _VIRTCHNL_2_H_ */
-- 
2.56.0.679.gc527c65306-goog

