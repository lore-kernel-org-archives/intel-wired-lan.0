Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB47606A326
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=4w93qNSJ;
	dkim=pass (2048-bit key, unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google header.b=IpmeZF8o
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CED540509;
	Mon,  2 Nov 2026 22:32:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l5OxtaBe2bSf; Mon,  2 Nov 2026 22:32:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 57B944050D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658767;
	b=QwjU/0SPTojXmQMdAWos9tgLxLuiEOcIqN9EqyCQ+T1RTtHZt+jV1rOuhW5baucwpfBn
	 zlyuPFnI+jFZ3hy6uAnAZAGjXCvjPA0ppoKIi42DuYngnTb/UcZV1U4zOkuelmWb3UWvI
	 rnWjyAI/kg1ns7/YLlPaahupZ6cWz3L7NaL0WTLQmlCwOc87flg0sTP+QRamGTT5Gnn9a
	 RTL2JZeckOzKHVi/T/GyL0LRjpGNoaezebe0ZS/32TCYWWIlSf9SjQ+L9swzAEjw07bS1
	 2q9fbjeFZBEtY5GCIv+bsrnUUtCsS/Pw8zV5uHzjUxhCNZ92ATTUR4m34y6EZ4zXvaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658767;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nF9bQw3tAQtyXn+Lf9VhF9hLMi4KceB22RjvEpSde1s=;
	b=pQ3tHYOb7wlLXaG9L6z1JncR0KrBHZHfbmBmKLRAD/QY1d3I4n8s5XZb56up1ekWvnuq
	 19cVWB/VwhwLw3BGRdUehPQ9b7y16SLToqOhn+wB5+Uk5kn/GAdZL3HnS3muxuNLCn9Q/
	 L/MK3/AC3rIqpjZv8F5snT2omNQ4QV+yDDon/3ZkaVrxSJmGStA1CMoSCoC5ZlsfSLKum
	 Cm23m8+k4nrh1BrPWgxXZbd0XbGS1po5FXI1CVnuNdyRuUROBPTBixOtjbLLc7e46hICz
	 1tUvArN96PS+KixTDN/UTueRCbJTve27MKhWeMzEZsBJln8bcUCjE9c7R527oHFFLOw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=x6u.co;
	dkim=pass header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google header.b=IpmeZF8o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793658767;
	bh=nF9bQw3tAQtyXn+Lf9VhF9hLMi4KceB22RjvEpSde1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4w93qNSJ//8GKUFPlPxjorKPkPRq/FhH3IDJlvD36WPi1LYKNFXuttdUPdTxoRavF
	 POayL2AqoXBw7LeuimzcsVai8RQzt3xBGjCeJW9aea79R2D/a0f/WpWMrBPLUSOaw4
	 Ox8zo1diPdy14ftgv+nKfZz5wKpBCRXGMymoGi4PtBgS54adV9t+ljWlvQ5iSfQxki
	 KnMlvtmDE0li4XoSqLCMQPNNtdf6wBiLzBRIXlIAsO+t03SokSDSM0d0rJ+64F1akK
	 FPZhK8TVhdWS39MSANYxJasXZ9Cj5ksn56UYeA0oPWkcwenx0KMCcJpPveq3BRREDs
	 mbBQzd6z4Yx9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57B944050D;
	Mon,  2 Nov 2026 22:32:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 565BB235
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 53DAB40B42
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VrfO0ToBiQH7 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 18:15:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 387A440B41
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793384148;
 b=fCmG5FP0NRddQCiuKQFDVvFk3UbUDe4hcvIrQnA2MlPdNNdZrl9VxamyuK9makNLELh6
 9GEr7VaO8TT+Ld67m/rhqVh5J0jAZqfsb2tZ4gFHi2F7b03yyQB9oAo+w3ubGEtK3HBGH
 Wueqe6HRgVTwJPyheJCK0XzIENNd6FE9A1Qzl8/mznJ0Kc85Rc8i6ucpVi+/ZYWD5ATCC
 1U0e0/2/dwWcEcUuzgTakiODkOKKg/1RCCUnvCp0Uhh6+S/uM/7ddsFqW3XqIE91ZcxfC
 ix5iU+b/bT6aiLnLMqCKn6rq7fVq2SS/dHlNfigk4wog6KTECchHBO0KxYMVrA8mUMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793384148;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=nF9bQw3tAQtyXn+Lf9VhF9hLMi4KceB22RjvEpSde1s=;
 b=V88HQE5ucTgJmS4GVr6bdf1aZxIstZTQpWZZMpG5PmvOmzOQd52KdjxHD6E1BFWR/0kl
 ZtIYFLJ5v2ZUidXmb/CCffD/kdvETA0+K41CyyC4MXSjGS0jmFMNdF9omkFrFiS/ho7jC
 PPmZxN3rH59wfSbC4NS3mpgrHMEhttlZeBBKM5ovWkEABZVbFDZIXsCJiNVud+1LimwnE
 U0YYX4pHyri2FU19nPGEnrpE9rpyke0HvWN299MF7+/mkCywEztfMWAYDKez5aArtkMvD
 3lLz0tDa4yajm+XOBKihgkqt8wMKco+l9+TXtRGNM15mPOSftlKslu22JwtMGs7I3yw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=x6u.co;
 dkim=pass header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google
 header.b=IpmeZF8o; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e33; helo=mail-vs1-xe33.google.com;
 envelope-from=dhu@x6u.co; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256
 header.s=google header.b=IpmeZF8o
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 387A440B41
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:46 +0000 (UTC)
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-7cc81984fceso319908137.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1793384145; x=1793988945; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nF9bQw3tAQtyXn+Lf9VhF9hLMi4KceB22RjvEpSde1s=;
 b=IpmeZF8oWYeXbVvo6asDivY/9IFJTndtWyEi8Suw/oJGyeIB1YV7CBIY959vm1S8PM
 qAfJdh05UnHa81DUFFgKEjzIYiKV3Dd38JE36ENTrfmi1qpBgPtgdoyRCxsMAI7HfAKL
 6mn4JNWeRQ9M1ojoqmU8Woh6L6ELuAn/HwvsoZewaiwRUUhDFsLmy3/2+VoWA/GFTIrI
 vx/79yl6YPRzHE/6+OjXZ77VoVHuk1nBPu3be/3LENJIrVfStmyBId9H1dCGiSgrHMXR
 3ShxECeXcB71DwwCY7yTIwZuhoRAxbQFEZ/BVSgpXwfOAcJtkMUEbsvFeQvOD5kQ3wo9
 y/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384145; x=1793988945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nF9bQw3tAQtyXn+Lf9VhF9hLMi4KceB22RjvEpSde1s=;
 b=Nlib/Nkpo6MxE8RPiI1DkkzKGKumq5uX4OcTF2Fi79Jglygc4KwPozaStsUZuHvbPp
 fQxQKoCin8qEBNpnsT07T6XALtenmhsE1A2mRu+/VY/dodj37a5lFpMmYsAEw7F1LCZ7
 fICEsZcQ/zJGyPYizXLd80W5MXYYKio27O5oMD6EbZ9CKc4gniAFTU5rxwTNjjVldMIW
 WrUAevtYsDCmvAgKkQRGf5SAhGCC5Z3bJdjrW2uSUr9+3/8SMALzN8e7jbcB2W6nr+cY
 HxVMwLmSbHhKllW4fVv2Zb24RTKeEjk6KPACaJiDV4BfnXGm2R0Ogp0FfMYfZUssMiJt
 Xirg==
X-Forwarded-Encrypted: i=1;
 AKwUvByYxtcEp+lo9bY4JH3zmrzQRYHlVyldkxv3qG2ogzbofxDU/vTvW6o11H16bMbp5CAcbbTpZ82XvP9eY9YuiDU=@lists.osuosl.org
X-Gm-Message-State: AFq9FYL28kCp3eMqm/Mg/hEQQYa3scRSrt3s6jLSEAtQ9dcFKB/qkHLZ
 HoOfy8v+OakMZ8i82RwcDeXCfvVvrtMOIiaT6R/9XlY900eQAu7Slah07neC96CnJSO5MgJhAfG
 wWk8Mnw==
X-Gm-Gg: AYBFou1BHFlhWUj26KkYb67xKMak5w8qK8yr7q6eNVoDhF702d02E5ISiNmAkDiGk+T
 AP5B9b/enLvsnYGfySGpharoa+SG09fHbOd1gR4lGSDIRy7kUb5LxhK7eS6Gx/5heeBbws4z8lf
 QNikTn30wtOWHbLFvDr+n/rNyx1mYds+CYj20nIxZ/vGMcZmVsEXymGDeyIl1q+2ovSRbeZANXF
 bbq4IKuecyMstgokJX4MITX62b6JPdyVL+kLBe1k+9UC90c4lKQUjP7iFqzVK14mTE/n1WMoXlM
 I0bAq9Jyz2PHP//Rb5wgFB+ZakXtqxRRoj4ZCdSKdADiymW6VW9QDaoP87/IFqLzec0AqArx0nj
 oJl5pJb/9WIpRv76yzjTh9i6rm+adgTN46C0vrxl3ldjZaVhdgvL2X5JCM+uGUxsK/JVQVHKkSS
 oQ3D0jQAqc+/kJwy7q8ZOZWDr/C8I7CN93ou40OR76lR7AgKfREsxlYpq+mai6dsXdd9azPmCFh
 DBl501f1PbjgVSKtXRgVRGTD8lNfsFuDM+GZ4FSuJZcv7x+T1pz1cYmSFpOC25/MCw70/fRH3uQ
 5/TmjI344VKy2eeLuXGC7+XmxOe0Z6XkTeCzT0gnvQjtY10K6qu5G0/LhSInl20OLIlkFs0WTnO
 Qd6/DEV9WEM5EQ4P7+UrYIxsDiXjvIQTV/gZboVZpnjI=
X-Received: by 2002:a05:6102:14a3:b0:7cc:232b:f5a9 with SMTP id
 ada2fe7eead31-7d07272efedmr1462792137.24.1793384145522; 
 Fri, 30 Oct 2026 11:15:45 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com
 (109.243.150.34.bc.googleusercontent.com. [34.150.243.109])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d07754c1c6sm3077931137.3.2026.10.30.11.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:15:45 -0700 (PDT)
From: David Hu <dhu@x6u.co>
To: Mustafa Ismail <mustafa.ismail@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Moroni <jmoroni@google.com>, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Hu <xuehaohu@google.com>
Subject: [PATCH rdma-next v4 1/6] RDMA/irdma: Plumb uverbs_attr_bundle for QP,
 SRQ
Date: Fri, 30 Oct 2026 18:15:07 +0000
Message-ID: <20261030181512.2056056-2-dhu@x6u.co>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261030181512.2056056-1-dhu@x6u.co>
References: <20261030181512.2056056-1-dhu@x6u.co>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 22:32:42 +0000
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Hu <xuehaohu@google.com>

In preparation to support modern UVERBS ioctl attributes (such
as UVERBS_ATTR_UMEM for CoCo DMA bounce buffers), we pass down
`uverbs_attr_bundle` for inner QP, SRQ routines. Since standard
uAPIs provide `ib_udata`, we derive it via the helper macro,
`rdma_udata_to_uverbs_attr_bundle`. `irdma_create_cq()` supports
`uverbs_attr_bundle` already, therefore, this patch fills the gap for QP
and SRQ.

QP, SRQ uAPI will now have `ib_udata`, and CQ uAPI has `uverbs_attr_bundle`
as a top level input. However, we think it is a future project to unify
them.

Signed-off-by: David Hu <xuehaohu@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index c91c55917de9..811b1d532599 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -637,13 +637,15 @@ static void irdma_setup_virt_qp(struct irdma_device *iwdev,
  * @iwqp: qp ptr (user or kernel)
  * @info: initialize info to return
  * @init_attr: Initial QP create attributes
+ * @attrs: uverbs attribute bundle
  */
 static int irdma_setup_umode_qp(struct irdma_ucontext *ucontext,
 				struct irdma_create_qp_req *req,
 				struct irdma_device *iwdev,
 				struct irdma_qp *iwqp,
 				struct irdma_qp_init_info *info,
-				struct ib_qp_init_attr *init_attr)
+				struct ib_qp_init_attr *init_attr,
+				struct uverbs_attr_bundle *attrs)
 {
 	struct irdma_qp_uk_init_info *ukinfo = &info->qp_uk_init_info;
 	unsigned long flags;
@@ -981,10 +983,14 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	struct irdma_qp_init_info init_info = {};
 	struct irdma_qp_host_ctx_info *ctx_info;
 	struct irdma_create_qp_req ureq = {};
+	struct uverbs_attr_bundle *attrs = NULL;
 	struct irdma_srq *iwsrq;
 	bool srq_valid = false;
 	u32 srq_id = 0;
 
+	if (udata)
+		attrs = rdma_udata_to_uverbs_attr_bundle(udata);
+
 	if (init_attr->srq) {
 		iwsrq = to_iwsrq(init_attr->srq);
 		srq_valid = true;
@@ -1071,7 +1077,7 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 
 		init_info.qp_uk_init_info.abi_ver = iwpd->sc_pd.abi_ver;
 		err_code = irdma_setup_umode_qp(ucontext, &ureq, iwdev, iwqp,
-						&init_info, init_attr);
+						&init_info, init_attr, attrs);
 	} else {
 		INIT_DELAYED_WORK(&iwqp->dwork_flush, irdma_flush_worker);
 		init_info.qp_uk_init_info.abi_ver = IRDMA_ABI_VER;
@@ -2337,7 +2343,8 @@ static int irdma_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 static int irdma_setup_umode_srq(struct irdma_device *iwdev,
 				 struct irdma_srq *iwsrq,
 				 struct irdma_srq_init_info *info,
-				 struct ib_udata *udata)
+				 struct ib_udata *udata,
+				 struct uverbs_attr_bundle *attrs)
 {
 	struct irdma_create_srq_req req = {};
 	struct irdma_ucontext *ucontext;
@@ -2420,6 +2427,7 @@ static int irdma_create_srq(struct ib_srq *ibsrq,
 	struct ib_srq_attr *attr = &initattrs->attr;
 	struct irdma_pd *iwpd = to_iwpd(ibsrq->pd);
 	struct irdma_srq *iwsrq = to_iwsrq(ibsrq);
+	struct uverbs_attr_bundle *attrs = NULL;
 	struct irdma_srq_uk_init_info *ukinfo;
 	struct irdma_cqp_request *cqp_request;
 	struct irdma_srq_init_info info = {};
@@ -2430,6 +2438,9 @@ static int irdma_create_srq(struct ib_srq *ibsrq,
 	u32 depth;
 	u8 shift;
 
+	if (udata)
+		attrs = rdma_udata_to_uverbs_attr_bundle(udata);
+
 	uk_attrs = &rf->sc_dev.hw_attrs.uk_attrs;
 	ukinfo = &info.srq_uk_init_info;
 
@@ -2470,7 +2481,7 @@ static int irdma_create_srq(struct ib_srq *ibsrq,
 	attr->max_wr = iwsrq->max_wr;
 
 	if (udata)
-		err_code = irdma_setup_umode_srq(iwdev, iwsrq, &info, udata);
+		err_code = irdma_setup_umode_srq(iwdev, iwsrq, &info, udata, attrs);
 	else
 		err_code = irdma_setup_kmode_srq(iwdev, iwsrq, &info, depth,
 						 shift);
-- 
2.56.0.317.g454f8302e1-goog

