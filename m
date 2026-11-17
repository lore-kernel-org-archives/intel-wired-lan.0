Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C607606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=WBaZyrlA;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NuY1nDf1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BA9160906;
	Tue, 17 Nov 2026 16:29:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jFE_YCxGpWFQ; Tue, 17 Nov 2026 16:29:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 39EC86090B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932946;
	b=bXE+X/XszwJxq4AyCmywJXL6EsedogAot5igFAzPGGkD19PnoY52I+oa+eyviu2NYjG8
	 I4BJx6+Jc9ngplvw/QC1lJqgFn24xLAzIDavtfiN4BQ2QRTEjSmmI+9bgVqePG7IollsM
	 JgZB9ZUYkSbdp/M+qCmHCbOQiBzZ4vex5JgTZ26G8IUK/ryskQLZl6Sb+T8uw3mEt4dvp
	 ra4zNJyvbDqda8NjwyAI6gTktxPQsv8NDAH9dxuAwDBGz2rNAKwQjyO3pLEWXvXccMIVr
	 Bec0ghx5YgAb1rc/RKvOAxA21+8489QZt4jdSX8tphWCHA4/6DASR9diWqSDKALMJnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932946;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=agHaMKF1X/5Jq3s3efJgu//prqDZJn7txlwnU3WYV+8=;
	b=qZORQ8v1HaVrP1EVA41uHW/Xt7AtwLcHrGuk6T8iyMuHMruR/MVzD5F/NLGBlWm7E4/B
	 Kyblsi4F+sKtvXxd7l4euq9Dj4ycTyASAlcQoRIDckQTH3zQRniNNaXXORoWScon+fPFS
	 W9ZedRvx6uwScT8kEg8pR13uDaazE2XH4/MyNl7GTb1oNPEmdwMsbt9YNXMSTTmtITtEz
	 0LRaE0LfGmAU9BC56QhG5is9fG0N7Hjz99k18KT/CR3U6Un8K+zjpNMXCmGQiRSgzmPfA
	 ASAK8NNvfht5cNJFjU4TT0BP4WU8qvkZ3X7Kzpr7Sbo0nObecqHed8a4XGnirhIcGBA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932946;
	bh=agHaMKF1X/5Jq3s3efJgu//prqDZJn7txlwnU3WYV+8=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WBaZyrlAnt9D0yAXPjLIln4ul2M9Sf1eCkOMKZf4AaoMZu3R6yXD7pq+6aUmkHy+d
	 S3SobQS2lCe3srnSf9pbknVARUA3zzxxZL/Mx7dH2AKhMf2yYOXTJpszbCaj3ZKqwN
	 qx68aHntEICzJ5Z78x6H5p4kbn/o9mgR9Cl2WpGiwaXPHBMZQzN/PQW8LhKuxt+NAZ
	 SF6B/CsIgOgSfDWtIUrNeV5bYLXqU4AsdIk7eTI1MXXy+O4FK7LPLDGKQnXxeSHDCS
	 sNe18BQncjzb/AZrXDImuxa0n/u7DgSdrsZ3t0Ntt+AaZ/kGMPXNSXhfwHnkEpBy5K
	 FCC3v7JEiZcXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39EC86090B;
	Tue, 17 Nov 2026 16:29:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CB59249B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1D5D400BB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7YRzRsWy8gg8 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:55:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C5AE640333
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b146"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b146; helo=mail-yx1-xb146.google.com;
 envelope-from=372r8agukdxyefw942aa270.ya849f07-i4d0z-7w974efe.aegae7.ad2@flex--stani.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=NuY1nDf1
Received: from mail-yx1-xb146.google.com (mail-yx1-xb146.google.com
 [IPv6:2607:f8b0:4864:20::b146])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5AE640333
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:45 +0000 (UTC)
Received: by mail-yx1-xb146.google.com with SMTP id
 956f58d0204a3-67db8cd0925so3482261d50.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 06:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794927344; x=1795532144; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=agHaMKF1X/5Jq3s3efJgu//prqDZJn7txlwnU3WYV+8=;
 b=NuY1nDf1Wv46BlVsSwHtVD0XLZ5yjFifOO7zhqm4nuIL+BCfB189D6G3vIBlud2ViA
 98XO/zA34hNp862HjgC7dqzl7od2hf7IEDCWbFRUq5pON6rc42j+cJGKJOwmLRItwGc5
 f+d119wEbwdvAO3qktK0zkvXX7j8Bu/0bduW/f5FQjnI8TtBfa++1qm1EDPWSwc40zvP
 EVCNMNrgoegdIj9xW51N57UAnpEBZd2P2u+M5TKP3BfNvxiU/LsRyhx6UBR7//VhamMY
 N2Po6mac08hLqYELI59oQRced+MabStxWFY1ECyFZ/b9LGEUiL+sSaJhStFmupXzhbkA
 36nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927344; x=1795532144;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=agHaMKF1X/5Jq3s3efJgu//prqDZJn7txlwnU3WYV+8=;
 b=mKhj0rRpodD3sRTR0wJiZVpvsTBdiBvCrCNFo62GVAGL1h8p5tz6b7eIrUMiEXqVQQ
 cnJpbjqXQLDmK5r7DBRJ0Agh3NehiZOGwlQU5AO7Jdvw9vtUm8Dy2QYuZ+ycEOJ5zCEI
 LxOPrkHvyN47VLkrYPmEn0jhqmec/5feHNZBDMHkZaVyuUDO8xsEGdw6J/J76KfbH6Wg
 +ObjZXQW4u3uctiiLGA4DPZvDmxpPBXa/6Ftj8prGICIRAMFbfVQ76ZCM7n+WNsGs8vN
 noHRA6iU1EA9uG0YsG4rWJesknJ3AdH1SGKlXUGmdKJmoZVjNDVT+krT+LMnaT1mxfI+
 fk3w==
X-Forwarded-Encrypted: i=1;
 AL+hErH2wQPUAInvKA7kXOHLErITYCZ+obubm4dOC5N7MBZuworW/SZnL/vXRbg77sIG8CIC9dyqUGFW1pMy1qm8Dy0=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/8y9SMJCGIXg75YjIndjbBDMdodAh13AxjCEZDH4V/h+neHOnT
 Ahj2Gz1svwtHl7sj4U8lp2yZwyJdVwvy4F4N3r1Ycin5YkhFOVQwZWr1GGkfqGH+Py8D5YUUAHV
 L5g==
X-Received: from yxca14.prod.google.com ([2002:a05:690e:44ce:b0:67c:562c:4b1c])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1188:b0:67d:98b7:8861
 with SMTP id 956f58d0204a3-67d98b79810mr6860138d50.48.1794927343834; Tue, 17
 Nov 2026 06:55:43 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:12 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-7-stani@google.com>
Subject: [PATCH iwl-next 06/15] idpf: psp: add support for psp capabilities
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

Add support for negotiating the PSP capabilities:
- Introduce VIRTCHNL2_OP_PSP_GET_CAPS (565), enum virtchnl2_psp_caps
  and struct virtchnl2_psp_get_caps (64 bytes, sent from the stack).
- Introduce the common PSP key definitions:
  enum virtchnl2_psp_key_type, VIRTCHNL2_PSP_KEY_SIZE_V0/V1,
  enum virtchnl2_psp_domain_type and struct virtchnl2_psp_key_domain.
- Implement idpf_send_get_psp_caps(), which requests all PSP
  capabilities, and call it from idpf_psp_negotiate_caps(). PSP stays
  disabled unless PSP version 0 keys are granted. The granted
  capabilities are stored in adapter->psp.psp_caps.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 15 ++++-
 .../net/ethernet/intel/idpf/idpf_psp_def.h    |  3 +
 .../ethernet/intel/idpf/idpf_psp_virtchnl.c   | 66 +++++++++++++++++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.h   |  2 +
 include/linux/net/intel/virtchnl2.h           | 65 ++++++++++++++++++
 5 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
index c4f46f7337ef..252ddb773cf5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -18,8 +18,9 @@
 static int idpf_psp_negotiate_caps(struct idpf_adapter *adapter)
 {
 	struct virtchnl2_crypto_get_caps crypto_caps = { };
+	struct virtchnl2_psp_get_caps psp_caps = { };
 	struct device *dev = &adapter->pdev->dev;
-	u32 sadb_entries;
+	u32 caps, sadb_entries;
 	int err;
 
 	err = idpf_send_get_crypto_caps(adapter, &crypto_caps);
@@ -51,6 +52,18 @@ static int idpf_psp_negotiate_caps(struct idpf_adapter *adapter)
 		return -EOPNOTSUPP;
 	}
 
+	err = idpf_send_get_psp_caps(adapter, &psp_caps);
+	if (err)
+		return err;
+
+	/* The driver only allocates and inserts PSP version 0 keys */
+	caps = le32_to_cpu(psp_caps.psp_caps);
+	if (!(caps & VIRTCHNL2_CAP_PSP_PROTO_V0)) {
+		dev_notice(dev, "PSP version 0 keys not granted by CP\n");
+		return -EOPNOTSUPP;
+	}
+
+	adapter->psp.psp_caps = caps;
 	adapter->psp.sadb_entries = sadb_entries;
 	adapter->psp.saidx_width = crypto_caps.saidx_width;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
index 3a9e40284106..0829d0bbd92b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
@@ -17,6 +17,8 @@
  *	     idpf_is_psp_ena()
  * @sadb_entries: SADB size granted by VIRTCHNL2_OP_CRYPTO_GET_CAPS
  * @saidx_width: SA index width granted by VIRTCHNL2_OP_CRYPTO_GET_CAPS
+ * @psp_caps: PSP capabilities granted by VIRTCHNL2_OP_PSP_GET_CAPS, see
+ *	      enum virtchnl2_psp_caps
  * @psp_dev: the PSP device, see idpf_psp_register()
  * @caps: capabilities of @psp_dev
  */
@@ -24,6 +26,7 @@ struct idpf_adapter_psp {
 	bool enabled;
 	u32 sadb_entries;
 	u8 saidx_width;
+	u32 psp_caps;
 	struct psp_dev *psp_dev;
 	struct psp_dev_caps caps;
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
index 65f7a9f63f90..ba114324d818 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
@@ -69,3 +69,69 @@ int idpf_send_get_crypto_caps(struct idpf_adapter *adapter,
 	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
 	return err;
 }
+
+/**
+ * idpf_print_psp_caps - Print values inside virtchnl2_psp_get_caps
+ * @adapter: Driver specific private structure
+ * @caps: Pointer to virtchnl2_psp_get_caps structure
+ */
+static void idpf_print_psp_caps(struct idpf_adapter *adapter,
+				const struct virtchnl2_psp_get_caps *caps)
+{
+	u32 psp_caps = le32_to_cpu(caps->psp_caps);
+
+	dev_dbg(&adapter->pdev->dev,
+		"virtchnl2_psp_get_caps: psp_caps=0x%08x (PROTO_V0=%u, PROTO_V1=%u, REQUEST_ROTATION=%u, DOMAIN=%u)\n",
+		psp_caps,
+		!!(psp_caps & VIRTCHNL2_CAP_PSP_PROTO_V0),
+		!!(psp_caps & VIRTCHNL2_CAP_PSP_PROTO_V1),
+		!!(psp_caps & VIRTCHNL2_CAP_PSP_REQUEST_ROTATION),
+		!!(psp_caps & VIRTCHNL2_CAP_PSP_DOMAIN));
+}
+
+/**
+ * idpf_send_get_psp_caps - Send VIRTCHNL2_OP_PSP_GET_CAPS request to CP
+ * @adapter: Driver specific private structure
+ * @caps: Output buffer for virtchnl2_psp_get_caps
+ *
+ * Request all PSP capabilities, PSP capabilities that are not requested are
+ * not available.
+ *
+ * Return: 0 on success, negative on failure.
+ */
+int idpf_send_get_psp_caps(struct idpf_adapter *adapter,
+			   struct virtchnl2_psp_get_caps *caps)
+{
+	struct libie_ctlq_xn_send_params xn_params = {
+		.chnl_opcode	= VIRTCHNL2_OP_PSP_GET_CAPS,
+		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	struct virtchnl2_psp_get_caps send_caps = {
+		.psp_caps = cpu_to_le32(VIRTCHNL2_CAP_PSP_PROTO_V0 |
+					VIRTCHNL2_CAP_PSP_PROTO_V1 |
+					VIRTCHNL2_CAP_PSP_REQUEST_ROTATION |
+					VIRTCHNL2_CAP_PSP_DOMAIN),
+	};
+	int err;
+
+	err = idpf_send_mb_msg_stack(adapter, &xn_params, &send_caps);
+	if (err) {
+		dev_err(&adapter->pdev->dev, "Failed to get PSP caps: %d\n",
+			err);
+		return err;
+	}
+
+	if (xn_params.recv_mem.iov_len < sizeof(*caps)) {
+		dev_err(&adapter->pdev->dev, "Invalid PSP caps reply size: %zu\n",
+			xn_params.recv_mem.iov_len);
+		err = -EIO;
+		goto release_rx;
+	}
+
+	memcpy(caps, xn_params.recv_mem.iov_base, sizeof(*caps));
+	idpf_print_psp_caps(adapter, caps);
+
+release_rx:
+	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
+	return err;
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
index cf82ac9182ef..b1c64575b417 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
@@ -9,5 +9,7 @@
 
 int idpf_send_get_crypto_caps(struct idpf_adapter *adapter,
 			      struct virtchnl2_crypto_get_caps *caps);
+int idpf_send_get_psp_caps(struct idpf_adapter *adapter,
+			   struct virtchnl2_psp_get_caps *caps);
 
 #endif /* !_IDPF_PSP_VIRTCHNL_H_ */
diff --git a/include/linux/net/intel/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
index 59c379afcb71..45cdfc0651e3 100644
--- a/include/linux/net/intel/virtchnl2.h
+++ b/include/linux/net/intel/virtchnl2.h
@@ -86,6 +86,7 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_DEL_FLOW_RULE			= 553,
 	/* Crypto/PSP opcodes */
 	VIRTCHNL2_OP_CRYPTO_GET_CAPS			= 564,
+	VIRTCHNL2_OP_PSP_GET_CAPS			= 565,
 };
 
 /**
@@ -1843,4 +1844,68 @@ struct virtchnl2_crypto_get_caps {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(256, virtchnl2_crypto_get_caps);
 
+/* PSP capability flags */
+enum virtchnl2_psp_caps {
+	/* PSP capability 0 is reserved */
+	VIRTCHNL2_CAP_PSP_PROTO_V0			= BIT(1),
+	VIRTCHNL2_CAP_PSP_PROTO_V1			= BIT(2),
+	VIRTCHNL2_CAP_PSP_REQUEST_ROTATION		= BIT(3),
+	/* If not granted, the domain field of PSP requests is ignored */
+	VIRTCHNL2_CAP_PSP_DOMAIN			= BIT(4),
+	/* PSP capabilities 16 and above are reserved for OEM */
+};
+
+/**
+ * struct virtchnl2_psp_get_caps - PSP global capabilities
+ * @psp_caps: See enum virtchnl2_psp_caps
+ * @padding: Padding to 64 bytes
+ *
+ * Request and response of VIRTCHNL2_OP_PSP_GET_CAPS. PSP capabilities are set
+ * per function: a capability that is not requested is not available.
+ */
+struct virtchnl2_psp_get_caps {
+	__le32 psp_caps;
+	u8 padding[60];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(64, virtchnl2_psp_get_caps);
+
+enum virtchnl2_psp_key_type {
+	VIRTCHNL2_PSP_KEY_TYPE_V0			= 1,
+	VIRTCHNL2_PSP_KEY_TYPE_V1			= 2,
+};
+
+#define VIRTCHNL2_PSP_KEY_SIZE_V0			16
+#define VIRTCHNL2_PSP_KEY_SIZE_V1			32
+
+/* PSP key domain types. Types VIRTCHNL2_PSP_DOMAIN_RESERVED_START to
+ * VIRTCHNL2_PSP_DOMAIN_RESERVED_END are reserved for future versions of the
+ * API, types VIRTCHNL2_PSP_DOMAIN_OEM_START to VIRTCHNL2_PSP_DOMAIN_OEM_END
+ * are OEM specific.
+ */
+enum virtchnl2_psp_domain_type {
+	VIRTCHNL2_PSP_DOMAIN_NONE			= 0,
+	VIRTCHNL2_PSP_DOMAIN_RESERVED_START		= 1,
+	VIRTCHNL2_PSP_DOMAIN_RESERVED_END		= 0x7fff,
+	VIRTCHNL2_PSP_DOMAIN_OEM_START			= 0x8000,
+	VIRTCHNL2_PSP_DOMAIN_OEM_END			= 0xffff,
+};
+
+/**
+ * struct virtchnl2_psp_key_domain - PSP key domain
+ * @type: See enum virtchnl2_psp_domain_type
+ * @pad: Reserved/padding
+ * @value: Security context used as part of the PSP SPI binding, must be 0
+ *	   if @type is VIRTCHNL2_PSP_DOMAIN_NONE
+ *
+ * Key domains prevent steering attacks: PSP does not authenticate the IP
+ * header, so a compromised VM changing the destination IP address must not
+ * be able to decrypt the packets of another VM on the same host.
+ */
+struct virtchnl2_psp_key_domain {
+	__le16 type;
+	u8 pad[6];
+	__le64 value;
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_psp_key_domain);
+
 #endif /* _VIRTCHNL_2_H_ */
-- 
2.56.0.679.gc527c65306-goog

