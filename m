Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AD3606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=YWFLHb62;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fu3EVd0+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8F7A40908;
	Tue, 17 Nov 2026 16:29:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qYlLNMtlSzM4; Tue, 17 Nov 2026 16:29:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E68D840945
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932956;
	b=C8TskbNrt2pUPhz4di4lzJxBsWBrkpvZLjpPAOAPdVgtDmiapZAvXIjQ5fBWs1fN7RsV
	 6hZg1HGK3PRHbuunzt9p72nNCH07JODw06vvleNYkjLRh6HTOgLyYIrPC9spB67+tEDR4
	 vha/HlLxdNW77T4jiDfaylSuWJ0tWkGXzjqENV1jnm1fbSviB37cP4Vvt/dRyiazLwD8J
	 FvUX9VI+33/SLKKHIl6TPo2+fDdoLER4ft/FKhRaEKDOnyocNRcGygIJNHlPPxNdC0vXc
	 wkCE7EI43ibhN/aVC/WVA3R6Qhk6rU8B9sfBDK8y1/Bpv3gqYSBRveLAs3oVAGMnedQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932956;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WHBOqD2eXB9OnYWRQPiBoFc35ni///xtz0x2mmN/PH0=;
	b=JTGgqcuPeoStG9E6Z2rPEfutkeA8RnDhfr+kgW2dufx68iEnOqPhKmU8yU5WKtRoXZ8G
	 +40lCz6Wv/WsTK89/FglRm1oUSginpbGJo7y4Yd82doo+nqGPb/av4/MeRpbwGHpS4rOi
	 F8aXVWq9RlVP5nc9le7k+FnihNLHZCcqWTWInyHa41U4g+TcLRttjNn2TD/hVj5mMqmeU
	 7mGlK+g9z3UP302t7SG1aEr1T50UDCggXfxfn8BQxn5PD5RhqKy/dGVJ/0IkoBW6v5hp5
	 9NhDp5QlnpWQM9P09fHtYX0+n9fhPi8RQsb9QbiKmVCwmoNZBtXALbC6AfApTMlMQbg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932955;
	bh=WHBOqD2eXB9OnYWRQPiBoFc35ni///xtz0x2mmN/PH0=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YWFLHb62aPFWbe+VIwSz1XRLnLe5YA9MF3vfn8c5jInkm4/Linrvs2pAOqZIM+8Qv
	 ztHNfDj0PFsEJr6FrYG6pch81zPLxAz66xCsNYgo0a+ROu4rPD6nTJJQPzdpH2VPuD
	 ZUkspbA2EmE0wPcjJotAEr2y6zRYfov9tCqMjb1BqNC0aD1GUQVLWH7IONo8nYuk4x
	 kwiomlq0hWgm103WPZkPw3zaJWy3VpMMhJXYt2w7qgOzh7Kmt7SpG6Rq5y55vea8WY
	 LpOZ7wTNuKzkJ1BGoF2L+YQva7dGNGsZIA97yXAwyrQaTgRMYH9IDdty/u+W2QdOd+
	 QlSU8KF/a7kiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E68D840945;
	Tue, 17 Nov 2026 16:29:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C0C7E04
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0C96608FA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VKRre8hsP2jP for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:55:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C3129608EF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f45"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f45; helo=mail-qv1-xf45.google.com;
 envelope-from=38gr8agukdxcfgxa53bb381.zb95ag18-j5e10-8xa85fgf.bfhbf8.be3@flex--stani.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=fu3EVd0+
Received: from mail-qv1-xf45.google.com (mail-qv1-xf45.google.com
 [IPv6:2607:f8b0:4864:20::f45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3129608EF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:46 +0000 (UTC)
Received: by mail-qv1-xf45.google.com with SMTP id
 6a1803df08f44-920f9885cb1so19748226d6.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 06:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794927345; x=1795532145; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WHBOqD2eXB9OnYWRQPiBoFc35ni///xtz0x2mmN/PH0=;
 b=fu3EVd0+zsvjScLtStR3/dGPkdrd1QKpbCP6XFvThDGj+PyD9M1VR9Rdlrai+48aw7
 XL2xc+6ZXUZHoYAjKVxpbbwmfNEkzT6iETT5GHwI7WxxbRTOlQYxHmFqyJJ+9YtgYTBb
 ZjQ/apnoZ50ZKWMvCLwwMDeMF44sp0C1UF9/6HG20lll3fRd5XEFZbhRKKdnNHbq1NAE
 v8JN3SeeiiDjPvYphClH97PoEFUULJROkV5KeuGQeXQjlKFjeul3JPX/SjrJRIiFG2YE
 TVXZ7XJgjE4dyyFWCTGfnN65UF0nl0P0UlTDPSzG0eXajc2i2OIsgBhicVaj4B03QMeE
 eJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927345; x=1795532145;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WHBOqD2eXB9OnYWRQPiBoFc35ni///xtz0x2mmN/PH0=;
 b=TYfVU0N4hLDoxfMAEI0dOBiozepR96TfH0iqHfl29G+Y5Crwe2ihCfPlFBVH+ndP1T
 ARyzwSrfEljbcaa4s6zMK/13QPJUKSzoYeA+Lz7BoKnZNlPLy83gWVnoryKeLJknYjfz
 aifLVIp1GzCuf0Wfzr8yuVc9HCAWGeZcABHOB0qjttTOet1vKmQYQcbuQoAZJzzHzOpU
 f5SKKfVUmaXU1yDWl6BpfqoO5XWGWVfTcITUgt54yQEdB2nZ/H8niJr+5DZDGPrQ9TmJ
 FejRRd3W8iBQYH4cDa63Q7yCUB/1SH2CFBQ49nCmUzIIB+s7CZu5f7zlpZyz4CmHkuVk
 UPpA==
X-Forwarded-Encrypted: i=1;
 AL+hErHKF3DWS8pjSnBZn4zoylDfm84RNwBmXzn8ElFzgYlBg63Q6Qd13LYRT88ZZ/ps/bOl+o+wLqLxn7p4w1EuOls=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8zG//j7Inwa3buxpe4nN+rhfZoEh2J/I0289rOLjxhRD0PQNqi
 qTpF5Q03cu/sMbLzEaDzM5hVz3j6ouUV2ZF5c9evxd/UxN4wrnMA4AJpaAYGrQB6VqIuvVTLTy8
 VDg==
X-Received: from qkntn22.prod.google.com
 ([2002:a05:620a:3c16:b0:945:ebee:5f07])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:440d:b0:93f:5f83:2ca7
 with SMTP id af79cd13be357-9494bc3da2amr2443427785a.52.1794927344689; Tue, 17
 Nov 2026 06:55:44 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:13 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-8-stani@google.com>
Subject: [PATCH iwl-next 07/15] idpf: psp: add support for fips compliance
 status
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

Add support for querying the FIPS compliance status of the crypto
offload:
- Introduce VIRTCHNL2_OP_GET_FIPS_COMPLIANCE_STATUS (567) and
  struct virtchnl2_get_fips_compliance_status_resp.
- Implement idpf_send_get_fips_compliance_status(), called from
  idpf_psp_init(), which logs the status as
  "compliant@cmvp_cert_<a>_and_<b>" or "noncompliant". The status is
  informational only: failing to read it doesn't disable PSP.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_psp.c    |  6 ++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.c   | 59 +++++++++++++++++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.h   |  1 +
 include/linux/net/intel/virtchnl2.h           | 14 +++++
 4 files changed, 80 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
index 252ddb773cf5..67f1f1d7508c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -100,6 +100,12 @@ void idpf_psp_init(struct idpf_adapter *adapter)
 		return;
 	}
 
+	/* The FIPS compliance status is informational only */
+	err = idpf_send_get_fips_compliance_status(adapter);
+	if (err)
+		dev_warn(dev, "Failed to get PSP FIPS compliance status: %d\n",
+			 err);
+
 	WRITE_ONCE(psp->enabled, true);
 }
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
index ba114324d818..0502ce0b7abe 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
@@ -135,3 +135,62 @@ int idpf_send_get_psp_caps(struct idpf_adapter *adapter,
 	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
 	return err;
 }
+
+/**
+ * idpf_send_get_fips_compliance_status - Get the FIPS compliance status
+ * @adapter: Driver specific private structure
+ *
+ * Query the FIPS compliance status of the crypto offload with
+ * VIRTCHNL2_OP_GET_FIPS_COMPLIANCE_STATUS and log it in the legacy
+ * "compliant@cmvp_cert_<a>_and_<b>" form, or as "noncompliant".
+ *
+ * Return: 0 on success, negative on failure.
+ */
+int idpf_send_get_fips_compliance_status(struct idpf_adapter *adapter)
+{
+	struct libie_ctlq_xn_send_params xn_params = {
+		.chnl_opcode	= VIRTCHNL2_OP_GET_FIPS_COMPLIANCE_STATUS,
+		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	const struct virtchnl2_get_fips_compliance_status_resp *resp;
+	struct device *dev = &adapter->pdev->dev;
+	char status[128];
+	size_t reply_sz;
+	u32 num_certs;
+	int len, err;
+	/* The request has no payload, but libie can't send empty messages */
+	u8 dummy = 0;
+	u32 i;
+
+	err = idpf_send_mb_msg(adapter, &xn_params, &dummy, sizeof(dummy));
+	if (err)
+		return err;
+
+	reply_sz = xn_params.recv_mem.iov_len;
+	resp = xn_params.recv_mem.iov_base;
+	if (reply_sz < sizeof(*resp)) {
+		err = -EIO;
+		goto release_rx;
+	}
+
+	num_certs = le32_to_cpu(resp->num_certs);
+	if (struct_size(resp, certs, num_certs) > reply_sz) {
+		err = -EIO;
+		goto release_rx;
+	}
+
+	if (!num_certs) {
+		dev_info(dev, "PSP FIPS compliance: noncompliant\n");
+		goto release_rx;
+	}
+
+	len = scnprintf(status, sizeof(status), "compliant@cmvp_cert_");
+	for (i = 0; i < num_certs; i++)
+		len += scnprintf(status + len, sizeof(status) - len, "%s%u",
+				 i ? "_and_" : "", le32_to_cpu(resp->certs[i]));
+	dev_info(dev, "PSP FIPS compliance: %s\n", status);
+
+release_rx:
+	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
+	return err;
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
index b1c64575b417..2ade2df2e34e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
@@ -11,5 +11,6 @@ int idpf_send_get_crypto_caps(struct idpf_adapter *adapter,
 			      struct virtchnl2_crypto_get_caps *caps);
 int idpf_send_get_psp_caps(struct idpf_adapter *adapter,
 			   struct virtchnl2_psp_get_caps *caps);
+int idpf_send_get_fips_compliance_status(struct idpf_adapter *adapter);
 
 #endif /* !_IDPF_PSP_VIRTCHNL_H_ */
diff --git a/include/linux/net/intel/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
index 45cdfc0651e3..c3a0e7b1b8e2 100644
--- a/include/linux/net/intel/virtchnl2.h
+++ b/include/linux/net/intel/virtchnl2.h
@@ -87,6 +87,7 @@ enum virtchnl2_op {
 	/* Crypto/PSP opcodes */
 	VIRTCHNL2_OP_CRYPTO_GET_CAPS			= 564,
 	VIRTCHNL2_OP_PSP_GET_CAPS			= 565,
+	VIRTCHNL2_OP_GET_FIPS_COMPLIANCE_STATUS		= 567,
 };
 
 /**
@@ -1908,4 +1909,17 @@ struct virtchnl2_psp_key_domain {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_psp_key_domain);
 
+/**
+ * struct virtchnl2_get_fips_compliance_status_resp - FIPS compliance response
+ * @num_certs: Number of certificates, 0 if not FIPS compliant
+ * @pad: Reserved/padding
+ * @certs: Flexible array of certificate IDs
+ */
+struct virtchnl2_get_fips_compliance_status_resp {
+	__le32 num_certs;
+	u8 pad[4];
+	__le32 certs[] __counted_by_le(num_certs);
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_get_fips_compliance_status_resp);
+
 #endif /* _VIRTCHNL_2_H_ */
-- 
2.56.0.679.gc527c65306-goog

