Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B1606A324
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=OR0004c7;
	dkim=pass (2048-bit key, unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google header.b=I28cIJSt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 251396066E;
	Mon,  2 Nov 2026 22:32:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e4d5uGeYxbls; Mon,  2 Nov 2026 22:32:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3B407606B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658769;
	b=TDdiD2pe6vp+MLE6l1n868rptnkPrzbTGMKksmXtFXZQso1/YL64RUqEs8YVUVfESTss
	 31wpM08inbmh02p3lF4Rz0Y5wfGwVj+UKxUTeAaluHeF9sr56D6PL0DF4C6+TjpGbKSxz
	 zevMbPF+3TY9lUf8TpPjJcajqlxY4bILoPqyWZqYr4N+fqsb92bt+4816lPLnrCmheFhr
	 hBOTyXP8y+WHaXVHG0IK9wPqq5GzweFDnsa9/Rz2VEF3OL+dRwY1V1jqtrqXMLTOp9nDn
	 4L7MLRtdZ4QKPY7gISEur/bpbsZ97GB34G8c4J0tce9JNyOlmSa5vsYQ9Ie5a3hnPjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658769;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zkionQZ0VbqPNgyFPnoBpRmBwDyjjH4K2FfrRrkvEio=;
	b=huRI1wbtxTxKASXlnonodSGAQyRnkjPZwATE8A4tKnQHJSR+I2K4bCbGfcsoXXRaLmEx
	 kEynx4N3lal78snly9IdED+oZoEzFik1esNYXxpGvrGG/k8wmECwwmsl/ZHsWSNFKRMEl
	 JHU1/Rit/JY02HL9h0CGQPY9EWoZdgpGZMpotF0glqbkly7i3R99z4h2ubO4QWcFNeoWD
	 pDSVaXS7GFdcC03HmPztTLwWmq1P/HMqyADMd7Hyn98luV01otJN9Boa+v3dypuwHzjyI
	 DFl07YfqjnCNt+Nw/FbynZy21w+V4g7qwMx6zNoB2MN8sCgRbZFTHCe1QBodNeKMRhQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793658769;
	bh=zkionQZ0VbqPNgyFPnoBpRmBwDyjjH4K2FfrRrkvEio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OR0004c7dYrvsAda8hwcY3mxIzef9ROlFih84JM01Mw1ss5DwJyx968KADwkDRO09
	 3zaw2FGKV7yN2ctfE+AJTm5RJtIiQjJjVG8S9JThfJfLq2aMWtRQJSaNA+Pr5kDaev
	 qMKDZ1Z3oRsAkrM+HhnK5J/k0PDvJgW/3Stp7ioO46KvgStPwY6pHz0Qhohy5gMS0A
	 mDs+gapEDMbVx3gObfvo+rCiv3h2+CSpV86vxZrt80pMZwNjD/hYN6JLqQxTE1HGVK
	 emv/Lj61isYSKSpyMUvPKkf6YvfSPBk+xJ1SaEK87S/EcwMyJ/+OLvkZkWp7t3nWSg
	 NUOtLXdoUAnzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B407606B6;
	Mon,  2 Nov 2026 22:32:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7ACA5235
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 61503811AA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GzjVYZIClub6 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 18:15:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E9C0810EA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793384151;
 b=YSFFRbuX+JGA8f8GJAuK5Q/O+hGTchkwerQ4NPZ0ScPfhIm1juNHbk7TG3OpFyf3hkYm
 4B2/8v7TgT+jz1uB/zMEoUTld51gI4CW99Mn9GYHWl3ZrlE9ZYaAfwRGtOWYjALqvxxVU
 WVj2qMvgpOEeJEkc53lGek7NrhOBX/55a731GYa7ILagJBaGmHY1T92NUI8Ry22b/xNOJ
 IsbOYhcPXcKaXP08yOSUXCufNOdYtnV4hH+K5HbUMc9sF/sre1+UoD+8KUCj8JB6JkWEq
 0RaFYVHBGQhVF7LyQ+Xbrmq6xsd+h7rxtHdEDw2Ty3Sr+Jzh04VThSQ+IlXFcEjTYgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793384151;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=zkionQZ0VbqPNgyFPnoBpRmBwDyjjH4K2FfrRrkvEio=;
 b=a3YOfvkotSJ68Jl2V86SZUCGSguIY5ctzCeL9p/TD3eVjHVGZ1wifrnGSgzv6jONz2eT
 FzZVSQjeJawmOPa0QjpATw1BRf281AJjnYFN45cONgUPcyngEyQeHJF7U3VPKdCIPEEz5
 I3RS/rO083Segf9fJpk9awEQ+dTravtlNOD7ZR1KkU7V8GL7rBNwJZ2D93lMo4wnY6RVE
 ws9Yyq0twKa+CpU05tKgGYQenLMNh3bXbvv8Azygr8FoDHeCVWbLwb7LY4+F49C7YAlWt
 nqwrj/tGaIXXoTrErpdbVHZC/A0nW9Zf++BreUPOjNFkzvCgYXqLVaHyy95D/OaFkUg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=x6u.co;
 dkim=pass header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google
 header.b=I28cIJSt; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92f; helo=mail-ua1-x92f.google.com;
 envelope-from=dhu@x6u.co; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256
 header.s=google header.b=I28cIJSt
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E9C0810EA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:49 +0000 (UTC)
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-980c4258105so572203241.2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 11:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1793384148; x=1793988948; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zkionQZ0VbqPNgyFPnoBpRmBwDyjjH4K2FfrRrkvEio=;
 b=I28cIJStebtNXwTE4kuk1bS6KJJwXcRrHEWrY3MeJDcyF8fV0aDvUivjElxlfMWcoz
 +sil2Gl+4YHPjjzmCjEmTisCvV5IvdeGWHqpK8iwE5pOFglalETYQZRs0tUSHzr7S5OI
 FKHckt6ErInWANGon0pKIE6NwiCw3AgDXOyDrWihlZgf0Fvd24LXJfWNXo7itLiPx9l9
 a1rGFhFvze5pnGtPBnb5PBt2fe1fgdSJN1w8r3SE16fNyW9nMsldkZ4N8D6WMib+J3ig
 7FZg8uiNACB7CCxh76GkKjAP9FZa4hNJOCgQ62gehPvJHx2sr9Dsb2BDIbsBTIr5QPWn
 VqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384148; x=1793988948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zkionQZ0VbqPNgyFPnoBpRmBwDyjjH4K2FfrRrkvEio=;
 b=yl3Qz+Ab3u6gI5JNKTts71CwTC3gB63JK7ETBK8ksZOBMlnPX8W7rimbbyzszbU6cB
 ycBPzwBT/PFE57e33ZrrK1VXRsMX466zEuvbhc2BCcDYt9AwU/69X5OX8pdCA7AF+DWD
 YPMAISg7eiio0g7YaYG9swk9vcdtjVbhCydl+KWCoWmUkH9diJRws8HjLYpup2xf4WWs
 ECxox1AppgOZl9nYmYIGZqCXfDP0ehVE8y8cVlvUR7vmtQEtn1BQJ7C7CFYBGrXn4RnM
 tnOKq1fOzXlbJ/xMk5A7wt3b9/fHlvehlxSLbxMb17NgmH6pYJtKz5fkQI4G6g9kYWnA
 /Qjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxL23iXxxAtAHARmdcHsE1wYqmcb3wc3tteHyLIqt7wt+EKbchdM6JKvLm3fOLIMfpM6zWd5UUv6sWYurlLeNg=@lists.osuosl.org
X-Gm-Message-State: AFq9FYJs65jQF2pe409vI+J/NXhjZW7S4iM/x1VSOh2wxjLec2OcKR5W
 ymlD2eRnFiZ+0TgoxTdGEVqlr1jeN9WDIHJh9tWPQVgrjUIbR2JVUrSngjjzx1E2Kg5I
X-Gm-Gg: AYBFou0DaaA3DxQdIpRPFx0Q/w4iHkR0aNioHtuUso2pj5yijN3RPUZr7CZQDxOWqF0
 BYGrQdGDhDI3+ibkYJkQqfxBntPW91REP7KP4WooPDJtXHDsRrnY9jr9+GWZHbB05/FuQup8faN
 7Ud/1sT1a5c0lsbRpgQFJNDyv4b99klwyAJ2NdtoPcNEfLWZtBzR6NV2x7oTeEtZpZF4hq6sun0
 laaygnKZnwByNUKhTd6E18vIHdbHowlyg0cB1NupInc/XeXKdFKkz+X3YIY1PtVPtYRTspCggAy
 InUcetsyYTJ0UTP2O7c4RMJ1wXxCAwHscUgqF/2LCHR7pc13CPHfPNidwTTMmg83/GZ7D2chqPF
 yeMj0duwkfRxKYjpAkkSnPyC9Hrz5scC2JPoQB4FMTKYvMxqP+s1Wdz7pzZluYgD28qxbGRIxB5
 GkXHToQawzQPzmIbxoWafXIuVuf5Qxn9dastkmfXGqFUaVSJbxK+fckJ8eDqiMqu78bl/4Y0Kmb
 fy82pKec7GV9MOKWSXhsHWfuFhwVT29HdqKf/y88iYm5MNrXxZB74RTBzEXS8FmEiEOGEjkNLAL
 rUq0+4ZDa16JE3o2r3W8pnoIQtMutIn/KkWvi4yIwuI/0cvMFZMOpgpnAPFsJioprDK844WSDTX
 f1cqxBTyxEO+H+f2+gWPIQDcCjtf7ZM1fOP9666zZBjU=
X-Received: by 2002:a05:6102:2906:b0:7d0:57e3:d480 with SMTP id
 ada2fe7eead31-7d072bc7545mr1865185137.11.1793384148439; 
 Fri, 30 Oct 2026 11:15:48 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com
 (109.243.150.34.bc.googleusercontent.com. [34.150.243.109])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d07754c1c6sm3077931137.3.2026.10.30.11.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:15:47 -0700 (PDT)
From: David Hu <dhu@x6u.co>
To: Mustafa Ismail <mustafa.ismail@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Moroni <jmoroni@google.com>, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Hu <xuehaohu@google.com>
Subject: [PATCH rdma-next v4 3/6] RDMA/irdma: Support UMEM attribute for QP
 creation
Date: Fri, 30 Oct 2026 18:15:09 +0000
Message-ID: <20261030181512.2056056-4-dhu@x6u.co>
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

Support the standard 1-step queue buffer creation model for QP by using
`UVERBS_ATTR_CREATE_QP_BUF_UMEM` and `ib_umem_get_attr()`.

Add `irdma_setup_q_pbl_from_umem()` to allocate the backing MR and program
hardware pble directly from the pinned umem. Proper umem and pble cleanup
is added to `irdma_free_qp_rsrc()` upon QP destruction.

We retain backward compatibility for legacy 2-step registration if the
UMEM attribute is not provided.

`irdma_alloc_iwmr()` assumed there is always a valid PD, which is valid
for regular MR, and QP. That is not the case for CQ. This modernization
fixes `irdma_alloc_iwmr()` to take in an `ibdev` to avoid a potential
NULL dereference.

Note for MR teardown: This patch unifies the teardown of legacy 2-step
queue MR and modern 1-step dummy MR via,

`refcount_dec_and_test(&iwmr->user_ring_refs)`

For legacy queue MR, ref count starts at 2 (one by queue, and one by
`ib_mr`), it goes to 1 during queue teardown, while deferring memory
teardown to `irdma_dereg_mr`.

For 1-step dummy MR, ref count starts at 1, and teardown happens cleanly
here.

The teardown sequence (`ib_umem_release`, `irdma_free_pble`, `kfree`) is
inlined in `utils.c` here because `irdma_free_iwmr` is statically scoped
in `verbs.c`. Combining was considered, and we think it belongs to a
future project.

Signed-off-by: David Hu <xuehaohu@google.com>
---
 drivers/infiniband/hw/irdma/utils.c |  12 ++-
 drivers/infiniband/hw/irdma/verbs.c | 132 +++++++++++++++++++++++++---
 2 files changed, 127 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 290ad02ed657..1e5694a4fd91 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -1170,9 +1170,15 @@ void irdma_free_qp_rsrc(struct irdma_qp *iwqp)
 	kfree(iwqp->kqp.rq_wrid_mem);
 
 	if (iwqp->user_mode && iwqp->iwpbl) {
-		struct irdma_mr *iwmr = iwqp->iwpbl->iwmr;
-
-		refcount_dec(&iwmr->user_ring_refs);
+		struct irdma_pbl *iwpbl = iwqp->iwpbl;
+		struct irdma_mr *iwmr = iwpbl->iwmr;
+
+		if (iwmr && refcount_dec_and_test(&iwmr->user_ring_refs)) {
+			ib_umem_release(iwmr->region);
+			if (iwpbl->pbl_allocated)
+				irdma_free_pble(rf->pble_rsrc, &iwpbl->pble_alloc);
+			kfree(iwmr);
+		}
 	}
 }
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index dd824720671c..578c2d4b4d3c 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -18,6 +18,12 @@ static const struct uapi_definition irdma_uapi_defs[] = {
 	{}
 };
 
+static struct irdma_pbl *irdma_setup_q_pbl_from_umem(struct irdma_device *iwdev,
+						     struct ib_umem *region,
+						     struct ib_pd *pd,
+						     enum irdma_memreg_type reg_type,
+						     struct irdma_mem_reg_req *req);
+
 /**
  * irdma_query_device - get device attributes
  * @ibdev: device pointer from stack
@@ -670,17 +676,6 @@ static int irdma_setup_umode_qp(struct irdma_ucontext *ucontext,
 	iwqp->ctx_info.qp_compl_ctx = req->user_compl_ctx;
 	iwqp->user_mode = 1;
 
-	spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
-	iwqp->iwpbl = irdma_get_pbl((unsigned long)req->user_wqe_bufs,
-				    &ucontext->qp_reg_mem_list);
-	spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
-
-	if (!iwqp->iwpbl) {
-		ret = -ENODATA;
-		ibdev_dbg(&iwdev->ibdev, "VERBS: no pbl info\n");
-		return ret;
-	}
-
 	if (!ucontext->use_raw_attrs) {
 		/**
 		 * Maintain backward compat with older ABI which passes sq and
@@ -713,6 +708,52 @@ static int irdma_setup_umode_qp(struct irdma_ucontext *ucontext,
 		ukinfo->rq_size = ukinfo->rq_depth >> ukinfo->rq_shift;
 	}
 
+	if (attrs && uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_QP_BUF_UMEM)) {
+		struct irdma_mem_reg_req qp_req = {};
+		struct ib_umem *umem;
+		u32 total;
+
+		/* Legacy context does not provide depth info */
+		if (!ucontext->use_raw_attrs)
+			return -EOPNOTSUPP;
+
+		qp_req.sq_pages = DIV_ROUND_UP(ukinfo->sq_depth * IRDMA_QP_WQE_MIN_SIZE,
+					       IRDMA_HW_PAGE_SIZE);
+		/* In case srq is used, this will be a single page */
+		qp_req.rq_pages = DIV_ROUND_UP(ukinfo->rq_depth * IRDMA_QP_WQE_MIN_SIZE,
+					       IRDMA_HW_PAGE_SIZE);
+		total = qp_req.sq_pages + qp_req.rq_pages + IRDMA_SHADOW_PGCNT;
+
+		umem = ib_umem_get_attr(&iwdev->ibdev, attrs,
+					UVERBS_ATTR_CREATE_QP_BUF_UMEM,
+					total << IRDMA_HW_PAGE_SHIFT,
+					IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(umem))
+			return PTR_ERR(umem);
+
+		iwqp->iwpbl = irdma_setup_q_pbl_from_umem(iwdev, umem,
+							  iwqp->ibqp.pd,
+							  IRDMA_MEMREG_TYPE_QP,
+							  &qp_req);
+		if (IS_ERR(iwqp->iwpbl)) {
+			ret = PTR_ERR(iwqp->iwpbl);
+			iwqp->iwpbl = NULL;
+			ib_umem_release(umem);
+			return ret;
+		}
+	} else {
+		spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
+		iwqp->iwpbl = irdma_get_pbl((unsigned long)req->user_wqe_bufs,
+					    &ucontext->qp_reg_mem_list);
+		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
+
+		if (!iwqp->iwpbl) {
+			ret = -ENODATA;
+			ibdev_dbg(&iwdev->ibdev, "VERBS: no pbl info\n");
+			return ret;
+		}
+	}
+
 	irdma_setup_virt_qp(iwdev, iwqp, info);
 
 	return 0;
@@ -3460,6 +3501,7 @@ static int irdma_reg_user_mr_type_mem(struct irdma_mr *iwmr, int access,
 }
 
 static struct irdma_mr *irdma_alloc_iwmr(struct ib_umem *region,
+					 struct ib_device *ibdev,
 					 struct ib_pd *pd, u64 virt,
 					 enum irdma_memreg_type reg_type)
 {
@@ -3475,7 +3517,7 @@ static struct irdma_mr *irdma_alloc_iwmr(struct ib_umem *region,
 	iwpbl->iwmr = iwmr;
 	iwmr->region = region;
 	iwmr->ibmr.pd = pd;
-	iwmr->ibmr.device = pd->device;
+	iwmr->ibmr.device = ibdev;
 	iwmr->ibmr.iova = virt;
 	iwmr->type = reg_type;
 	iwmr->len = region->length;
@@ -3503,6 +3545,68 @@ static void irdma_free_iwmr(struct irdma_mr *iwmr)
 	kfree(iwmr);
 }
 
+static struct irdma_pbl *irdma_setup_q_pbl_from_umem(struct irdma_device *iwdev,
+						     struct ib_umem *region,
+						     struct ib_pd *pd,
+						     enum irdma_memreg_type reg_type,
+						     struct irdma_mem_reg_req *req)
+{
+	struct irdma_pbl *iwpbl;
+	struct irdma_mr *iwmr;
+	u32 total;
+	u8 lvl;
+	int err;
+
+	/* Catch page not starting on OS page boundary */
+	if (ib_umem_offset(region))
+		return ERR_PTR(-EINVAL);
+
+	/* iWarp: Reject queue dma-buf as it is not supported */
+	if (!rdma_protocol_roce(&iwdev->ibdev, 1) && region->is_dmabuf)
+		return ERR_PTR(-EINVAL);
+
+	iwmr = irdma_alloc_iwmr(region, &iwdev->ibdev, pd, region->address, reg_type);
+	if (IS_ERR(iwmr))
+		return ERR_CAST(iwmr);
+
+	iwpbl = &iwmr->iwpbl;
+
+	switch (reg_type) {
+	case IRDMA_MEMREG_TYPE_QP:
+		total = req->sq_pages + req->rq_pages + IRDMA_SHADOW_PGCNT;
+		lvl = (req->sq_pages + req->rq_pages) > 2 ? PBLE_LEVEL_1 : PBLE_LEVEL_0;
+		break;
+	case IRDMA_MEMREG_TYPE_CQ:
+		total = req->cq_pages +
+			((iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
+			  IRDMA_FEATURE_CQ_RESIZE) ? 0 : IRDMA_SHADOW_PGCNT);
+		lvl = req->cq_pages > 1 ? PBLE_LEVEL_1 : PBLE_LEVEL_0;
+		break;
+	case IRDMA_MEMREG_TYPE_SRQ:
+		total = req->rq_pages + IRDMA_SHADOW_PGCNT;
+		lvl = req->rq_pages > 1 ? PBLE_LEVEL_1 : PBLE_LEVEL_0;
+		break;
+	default:
+		err = -EINVAL;
+		goto err_free_mr;
+	}
+
+	if (total > iwmr->page_cnt) {
+		err = -EINVAL;
+		goto err_free_mr;
+	}
+
+	err = irdma_handle_q_mem(iwdev, req, iwpbl, lvl);
+	if (err)
+		goto err_free_mr;
+
+	return iwpbl;
+
+err_free_mr:
+	irdma_free_iwmr(iwmr);
+	return ERR_PTR(err);
+}
+
 static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
 				     struct ib_udata *udata,
 				     struct irdma_mr *iwmr)
@@ -3648,7 +3752,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		return (struct ib_mr *)region;
 	}
 
-	iwmr = irdma_alloc_iwmr(region, pd, virt, req.reg_type);
+	iwmr = irdma_alloc_iwmr(region, pd->device, pd, virt, req.reg_type);
 	if (IS_ERR(iwmr)) {
 		ib_umem_release(region);
 		return (struct ib_mr *)iwmr;
@@ -3747,7 +3851,7 @@ static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
 		return ERR_CAST(umem_dmabuf);
 	}
 
-	iwmr = irdma_alloc_iwmr(&umem_dmabuf->umem, pd, virt, IRDMA_MEMREG_TYPE_MEM);
+	iwmr = irdma_alloc_iwmr(&umem_dmabuf->umem, pd->device, pd, virt, IRDMA_MEMREG_TYPE_MEM);
 	if (IS_ERR(iwmr)) {
 		err = PTR_ERR(iwmr);
 		goto err_release;
-- 
2.56.0.317.g454f8302e1-goog

