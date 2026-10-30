Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E41606A326
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=3uSv1zJj;
	dkim=pass (2048-bit key, unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google header.b=0aspaTIi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A13D40507;
	Mon,  2 Nov 2026 22:32:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDvWL3h5-C3k; Mon,  2 Nov 2026 22:32:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 30B8B40515
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658770;
	b=RxTN/P9gC4G9f869YJw48g/oJ/UKmV+Fy8jli/mjanwPOHNR9RaXQs4CpNxjYCgklpoY
	 ybiGNCqhMd9FfUTumDj+eT9ITeZTXAPRMscFaFNt33SLTchhFqrbtSWVxT4JAeckd1J/i
	 +e17TIlT9ksoRFzksI9l7unsHBeIb4YOk+y8kEWLLdn//J1TLdw8dISApe5bkjgNaYlRh
	 kj77snZMMAUN50n7NcWNfJOcjQPgwSI5FlOXlHMYxoNCDk20Jg6cE426tyRYd1aOz2R9O
	 KsV3M1GKPqXVwnJ/+IPsWBKOrvkPlyRKjqmW2eXKbun04dm+e9h6+1UGijWtufDVsbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658770;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vGjtMvqUjjQQlfnOmLLXETqY/y43eIZFaXdz4rybB2c=;
	b=aTYiSPwJ9n4u9EJGM/jyJvPGmxf3ZAahm3eHW7jqiNeRzMEcCKVZ+nKbHCSyzgqsxye3
	 NBxGGEdF51UHH/JfYZs8pxxvVf2S+X0dpefl/thV/dHyt0u76C6lb1tCSQCp36S02MsRl
	 P9nU26O4MMpMOWMA21VI3F3eqqmGd8Xxiqg3IERpVFbB7x2KjwBvWls4imyRczPuPN2hI
	 G6HScKj/+TsnDnGBkfCRqA688vAfxI7jbecOQh84HjOqg75imPGNBrMcKqdqbdpBX7kvC
	 yNfozP4pSmU2UnKRXpHCSuexJpzd7EoWhleLGcZ5IbUDCjBY294uXZhZrRWBOfiwMaw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793658770;
	bh=vGjtMvqUjjQQlfnOmLLXETqY/y43eIZFaXdz4rybB2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3uSv1zJjGLkVL8Y5QWeetmFwdKkehwpRwTlFUbvI8QR/hSSKMvaJBPMA036eolX6B
	 J+Csm/Uu9IB1+fV7hl4nB1CasdoEpgYITq23XexKXhoiV/4ZplKU4vpfaCms53A/LC
	 K7r25LGLfjkyKRKlQrPd2TfkuZvWxEc2610amPCljm4zW6NLMyfz5a2ZFblpR5hZ/m
	 ZzC1jdMCOFBTR5YCcJreKLTMlIQgTDibdJolj/OlRnRH/AzfPcyehV/JP9rs5UqZ3k
	 YmtpjUBkaQBE1+XpFvIioeUMif8r9G8uKsDh6LOtGkUIwML4IgoKyVlwMktDaFyIU0
	 qVdMrxe7zVxtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30B8B40515;
	Mon,  2 Nov 2026 22:32:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 48A31235
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2EB8340541
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sAfn3hHFACoe for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 18:15:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E333740083
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793384152;
 b=qndVu5TXKWksrkWpcLzVZmtwUFNNx1rEbE/+1vTGuUlKvwn2QJe7FT/vDMfdIGEu2GcY
 8wI3n4ILLCC2cLpjsHq+dmX/mHGCNp4PihcYV/cSwjvGAqJDBvuGbgct7oK9OZ3euBG4B
 m5HxqKt11qjg3VTiruDJfMhRdbe2wvnJewhgdUyLpP0yNVRx1iSrVUnfiD1UQvqvFoiak
 x2GrAr4MvQLjbfru6Mgg4svFQZc5an/9IpdGq0qd2wfdVOPMEn6+srbN1nOQ80kQyKbCA
 v++xmV/SCBlSVinp9zW117XtRhRfP5rizrAp8M8mOVcxfVotxhP2jVLqmp0llZ1SrCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793384152;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=vGjtMvqUjjQQlfnOmLLXETqY/y43eIZFaXdz4rybB2c=;
 b=tT/MIA2tnRc9ze/bpDBhAIzpFoxkAE33hg1s6UsJNaiikAqEwH6/kZYxd/FL+ik/QSmm
 bx/blCkdrg00ZV+J2gBBDvG6yalp1127try162hXhFxLIXhdxp+lJt9p5ogzZ/pXnTLaW
 hHmy2luACJDdCuAT04WqlypPW7wtf4hX77XHm3EdDib/iJL4rFqP0KtJXtYWL52ygyNGV
 HvoPzqvtbwYT7Qh4CiKtX0hM7WCc/jd7PSOjn7CW62HYEm68P4CUq1NWSH43FYO6MYBwv
 lEpjvKWtw/nrm3+Wr9RyX5/kqZbCNr3+mW+33a3E1mIR/y9noKDNwKRQovFj8IxtmZQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=x6u.co;
 dkim=pass header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google
 header.b=0aspaTIi; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2d; helo=mail-vs1-xe2d.google.com;
 envelope-from=dhu@x6u.co; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256
 header.s=google header.b=0aspaTIi
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E333740083
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:51 +0000 (UTC)
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-7cc0ccc2fddso338548137.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1793384150; x=1793988950; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vGjtMvqUjjQQlfnOmLLXETqY/y43eIZFaXdz4rybB2c=;
 b=0aspaTIi0D7zOnMFv7WKBbBXJ0ljhcC9bmwDQAbs6xFjBuKIl90Qu3HZoJXd0j3fiD
 vTELLHsodPr3WQf2aM+EZDftNHEvK4Od9tRTdOdDdIlxXmjBgawCu3nwfmggkLmEeLhO
 nfr5QpogWxxtwzpGkVBbsaX+FvINmAf094U6rU/DyRUvekvi9A3FRvc6SKmSLYZOYYMK
 ZtH+sybalKKfFGxXJTmLKJSXW3Fje7TZt+yZzw6HZv7sRihzjxVRhIThK7kQrov5426Q
 JlSuaCidJJZSWtDOZ5xPQK0qMF4Yl9B7Wct3g2Dgm4svfkKMZMElOog9gFZjmzv3DRN3
 Lc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384150; x=1793988950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vGjtMvqUjjQQlfnOmLLXETqY/y43eIZFaXdz4rybB2c=;
 b=PKN+SJ66TYCI+ClFDJ2DqjX3ulHqxfEu8sog8wpluOW8m1xCitrocVzv3EWsGMdp3M
 uW8I8zb8kLoa8cjAVF93OChJ6dle6kvE/vqpondvHFk7T5093s8pik/mV2BgjQxs8Pwn
 ELavXT+E+c92kxZognydCv71OObhixi6AdtBXLiI3g36i2SYWnrW5VkqTg980rHKMhWw
 1PpYNcIF5c0kEjQE9Uz+V0zQtzGZpu2xkP2peHd0jruSalAf4bwGRUYkCxKqcrsDbUMx
 JBWVH/Y5dpDTIUchYgAJY6cExia326A/t3BqZyZ5sKf7zq+8hIiXP0MIofTZwNmR47ua
 UIag==
X-Forwarded-Encrypted: i=1;
 AKwUvBykWkCVOkCrwOKalM9HGukVgC2o6H0Su4g4cH1lV6203vXrDpg3gBRecKuyFP3+hmhQW2nErD07kRAMB8rT+Lg=@lists.osuosl.org
X-Gm-Message-State: AFq9FYLOXv/mw/Di29qv4pgAVVke5MdPZQPa5KU6pEpGooS0E+nm243C
 b9lV5/m9K2mOYgo6QobzAD3hvaknOjJ68uAjpUy+q+CA6NFLlhFhgT2/QymYERenUu3t
X-Gm-Gg: AYBFou3YCIUjdANv9j8YXWKhy2sU/WDWnFrVnRenw3VBurNSaK8q5e3KiPLZyb/pZ6E
 AUJkeRAI6UH0zhM/cIYX/6t2/TB7ldLeQxZ0MZfI11V2hsHlCsggHBLztnvFGR7Dm9Qcl0+pifF
 GuCsKWuYTzaQhZVIobRQSl5BGvpHJh7ftxGpi3AVsMkhtVedqz02uUa+JLiERWa7kmE5KP+8nhF
 eopKCrXGVCoOwqW4bgfORUtFxOJWqC7y3SogEpmI0sBocAJqGMgjVPjBbRT9WmdM2w/QEUCeyVP
 i1WoBV1Z5gVR6+a87FTb/ByeCQJL/PFn/jl+Kmvdj+tPcB0N2bK7wZK06FAHtNK8NG3pbKI+mwG
 0nDovw5KEm5JbrV+oBnzNQ0zmuasNms9/Cgq2bCFYQhi01zpP7CStFfH5xP/M42+iChgExaBmNq
 jOROAdUq60b7t8VuLgKnfKK+QCBrkVEjhWp+Yoskf+KxCFUDIcb+OCND41yxFZWaSwh/26QAWHQ
 md3YV35Xh6tkKfBtLNoasKx9Ch8xKbajgYozms9VNGoYQA/2qqJCKD0nYMnYsY/adPJNGwrksj3
 wnqoUatNXj5QDDLNHo6/6IPAa/RnDgm1qPcISWdzllechfoBxlyhTkcCVeuNUTosiXU2JdkVQgF
 Flxl6Ni2OTwICbnx1uZFSZOD4HoxUYrzOS7KW0aqv3/1kvan5bFgZVi2rGXvyjrcm
X-Received: by 2002:a05:6102:5811:b0:7cc:2c29:54f0 with SMTP id
 ada2fe7eead31-7d072238fbamr1525259137.4.1793384149876; 
 Fri, 30 Oct 2026 11:15:49 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com
 (109.243.150.34.bc.googleusercontent.com. [34.150.243.109])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d07754c1c6sm3077931137.3.2026.10.30.11.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:15:49 -0700 (PDT)
From: David Hu <dhu@x6u.co>
To: Mustafa Ismail <mustafa.ismail@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Moroni <jmoroni@google.com>, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Hu <xuehaohu@google.com>
Subject: [PATCH rdma-next v4 4/6] RDMA/irdma: Split CQ setup to umode and kmode
Date: Fri, 30 Oct 2026 18:15:10 +0000
Message-ID: <20261030181512.2056056-5-dhu@x6u.co>
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

Add user mode cq callback `irdma_create_user_cq()` to separate out user
mode creation logic from kernel mode cq.

Original common setup logic is broken into shared helper routines, so
duplicate code can be avoided. Core creation logic is preserved to be
identical to original routine, however.

Signed-off-by: David Hu <xuehaohu@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 416 +++++++++++++++++-----------
 1 file changed, 252 insertions(+), 164 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 578c2d4b4d3c..9f4905fdb791 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2624,41 +2624,198 @@ static inline int cq_validate_flags(u32 flags, u8 hw_rev)
 	return flags & ~IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION ? -EOPNOTSUPP : 0;
 }
 
-/**
- * irdma_create_cq - create cq
- * @ibcq: CQ allocated
- * @attr: attributes for cq
- * @attrs: uverbs attribute bundle
- */
-static int irdma_create_cq(struct ib_cq *ibcq,
-			   const struct ib_cq_init_attr *attr,
-			   struct uverbs_attr_bundle *attrs)
+static int __irdma_create_cq(struct irdma_device *iwdev,
+			     struct irdma_cq *iwcq,
+			     struct irdma_cq_init_info *info,
+			     struct ib_udata *udata)
 {
-#define IRDMA_CREATE_CQ_MIN_RESP_LEN offsetofend(struct irdma_create_cq_resp, cq_size)
-	struct ib_udata *udata = &attrs->driver_udata;
-	struct ib_device *ibdev = ibcq->device;
-	struct irdma_device *iwdev = to_iwdev(ibdev);
 	struct irdma_pci_f *rf = iwdev->rf;
-	struct irdma_cq *iwcq = to_iwcq(ibcq);
-	u32 cq_num = 0;
-	struct irdma_sc_cq *cq;
-	struct irdma_sc_dev *dev = &rf->sc_dev;
-	struct irdma_cq_init_info info = {};
 	struct irdma_cqp_request *cqp_request;
+	struct irdma_sc_cq *cq = &iwcq->sc_cq;
 	struct cqp_cmds_info *cqp_info;
-	struct irdma_cq_uk_init_info *ukinfo = &info.cq_uk_init_info;
-	unsigned long flags;
 	int err_code;
+
+	info->shadow_read_threshold = min(info->cq_uk_init_info.cq_size / 2,
+					  (u32)IRDMA_MAX_CQ_READ_THRESH);
+
+	if (irdma_sc_cq_init(cq, info)) {
+		ibdev_dbg(&iwdev->ibdev, "VERBS: init cq fail\n");
+		err_code = -EPROTO;
+		goto cq_free_rsrc;
+	}
+
+	cqp_request = irdma_alloc_and_get_cqp_request(&rf->cqp, true);
+	if (!cqp_request) {
+		err_code = -ENOMEM;
+		goto cq_free_rsrc;
+	}
+
+	cqp_info = &cqp_request->info;
+	cqp_info->cqp_cmd = IRDMA_OP_CQ_CREATE;
+	cqp_info->post_sq = 1;
+	cqp_info->in.u.cq_create.cq = cq;
+	cqp_info->in.u.cq_create.check_overflow = true;
+	cqp_info->in.u.cq_create.scratch = (uintptr_t)cqp_request;
+	err_code = irdma_handle_cqp_op(rf, cqp_request);
+	irdma_put_cqp_request(&rf->cqp, cqp_request);
+	if (err_code)
+		goto cq_free_rsrc;
+
+	if (udata) {
+		struct irdma_create_cq_resp resp = {};
+
+		resp.cq_id = info->cq_uk_init_info.cq_id;
+		resp.cq_size = info->cq_uk_init_info.cq_size;
+		err_code = ib_respond_udata(udata, resp);
+		if (err_code)
+			goto cq_destroy;
+	}
+
+	init_completion(&iwcq->free_cq);
+
+	/* Populate table entry after CQ is fully created. */
+	smp_store_release(&rf->cq_table[iwcq->cq_num], iwcq);
+
+	return 0;
+cq_destroy:
+	irdma_cq_wq_destroy(rf, cq);
+cq_free_rsrc:
+	irdma_cq_free_rsrc(rf, iwcq);
+
+	return err_code;
+}
+
+static int irdma_setup_kmode_cq(struct irdma_device *iwdev,
+				struct irdma_cq *iwcq,
+				struct irdma_cq_init_info *info,
+				const struct ib_cq_init_attr *attr)
+{
+	struct irdma_cq_uk_init_info *ukinfo = &info->cq_uk_init_info;
+	struct irdma_pci_f *rf = iwdev->rf;
+	struct irdma_sc_dev *dev = &rf->sc_dev;
 	int entries = attr->cqe;
 	bool cqe_64byte_ena;
 	u8 cqe_size;
+	int rsize;
 
-	err_code = cq_validate_flags(attr->flags, dev->hw_attrs.uk_attrs.hw_rev);
+	cqe_64byte_ena = dev->hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_64_BYTE_CQE ?
+			 true : false;
+	cqe_size = cqe_64byte_ena ? 64 : 32;
+
+	entries += 2;
+	if (!cqe_64byte_ena && dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
+		entries *= 2;
+
+	if (entries & 1)
+		entries += 1; /* cq size must be an even number */
+
+	if (entries * cqe_size == IRDMA_HW_PAGE_SIZE)
+		entries += 2;
+
+	ukinfo->cq_size = entries;
+
+	if (cqe_64byte_ena)
+		rsize = ukinfo->cq_size * sizeof(struct irdma_extended_cqe);
+	else
+		rsize = ukinfo->cq_size * sizeof(struct irdma_cqe);
+	iwcq->kmem.size = ALIGN(round_up(rsize, 256), 256);
+	iwcq->kmem.va = dma_alloc_coherent(dev->hw->device,
+					   iwcq->kmem.size,
+					   &iwcq->kmem.pa, GFP_KERNEL);
+	if (!iwcq->kmem.va)
+		return -ENOMEM;
+
+	iwcq->kmem_shadow.size = ALIGN(IRDMA_SHADOW_AREA_SIZE << 3, 64);
+	iwcq->kmem_shadow.va = dma_alloc_coherent(dev->hw->device,
+						  iwcq->kmem_shadow.size,
+						  &iwcq->kmem_shadow.pa,
+						  GFP_KERNEL);
+	if (!iwcq->kmem_shadow.va)
+		return -ENOMEM;
+
+	info->shadow_area_pa = iwcq->kmem_shadow.pa;
+	ukinfo->shadow_area = iwcq->kmem_shadow.va;
+	ukinfo->cq_base = iwcq->kmem.va;
+	info->cq_base_pa = iwcq->kmem.pa;
+
+	return 0;
+}
+
+static int irdma_setup_umode_cq(struct irdma_device *iwdev,
+				struct irdma_cq *iwcq,
+				struct irdma_cq_init_info *info,
+				struct uverbs_attr_bundle *attrs)
+{
+	struct ib_udata *udata = &attrs->driver_udata;
+	struct irdma_create_cq_req req = {};
+	struct irdma_pci_f *rf = iwdev->rf;
+	struct irdma_ucontext *ucontext;
+	struct irdma_cq_mr *cqmr_shadow;
+	struct irdma_cq_mr *cqmr;
+	unsigned long flags;
+	int err_code;
+
+	iwcq->user_mode = true;
+	ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
+					     ibucontext);
+	/* Even though the last member of struct irdma_create_cq_req
+	 * was always user_shadow_area, we need backwards compat with
+	 * the legacy i40iw struct i40iw_ucreate_cq which stopped
+	 * at user_cq_buffer.
+	 */
+	err_code = ib_copy_validate_udata_in(udata, req, user_cq_buf);
 	if (err_code)
 		return err_code;
 
-	if (udata && udata->outlen < IRDMA_CREATE_CQ_MIN_RESP_LEN)
-		return -EINVAL;
+	spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
+	iwcq->iwpbl = irdma_get_pbl((unsigned long)req.user_cq_buf,
+				    &ucontext->cq_reg_mem_list);
+	spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
+	if (!iwcq->iwpbl)
+		return -EPROTO;
+
+	cqmr = &iwcq->iwpbl->cq_mr;
+
+	if (rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
+	    IRDMA_FEATURE_CQ_RESIZE) {
+		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
+		iwcq->iwpbl_shadow =
+			irdma_get_pbl((unsigned long)req.user_shadow_area,
+				      &ucontext->cq_reg_mem_list);
+		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
+
+		if (!iwcq->iwpbl_shadow)
+			return -EPROTO;
+
+		cqmr_shadow = &iwcq->iwpbl_shadow->cq_mr;
+		info->shadow_area_pa = cqmr_shadow->cq_pbl.addr;
+	} else {
+		info->shadow_area_pa = cqmr->shadow;
+	}
+	if (iwcq->iwpbl->pbl_allocated) {
+		info->virtual_map = true;
+		info->pbl_chunk_size = 1;
+		info->first_pm_pbl_idx = cqmr->cq_pbl.idx;
+	} else {
+		info->cq_base_pa = cqmr->cq_pbl.addr;
+	}
+
+	return 0;
+}
+
+static int irdma_alloc_cq(struct irdma_device *iwdev,
+			  struct irdma_cq *iwcq,
+			  const struct ib_cq_init_attr *attr,
+			  struct irdma_cq_init_info *info)
+{
+	struct irdma_cq_uk_init_info *ukinfo = &info->cq_uk_init_info;
+	struct irdma_pci_f *rf = iwdev->rf;
+	struct irdma_sc_dev *dev = &rf->sc_dev;
+	int entries = attr->cqe;
+	struct irdma_sc_cq *cq;
+	bool cqe_64byte_ena;
+	u32 cq_num = 0;
+	int err_code;
 
 	err_code = irdma_alloc_rsrc(rf, rf->allocated_cqs, rf->max_cq, &cq_num,
 				    &rf->next_cq);
@@ -2674,169 +2831,99 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	iwcq->cq_num = cq_num;
 	iwcq->iwpbl = NULL;
 	iwcq->iwpbl_shadow = NULL;
-	info.dev = dev;
+	info->dev = dev;
 	ukinfo->cq_size = max(entries, 4);
 	ukinfo->cq_id = cq_num;
 	cqe_64byte_ena = dev->hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_64_BYTE_CQE ?
 			 true : false;
-	cqe_size = cqe_64byte_ena ? 64 : 32;
 	ukinfo->avoid_mem_cflct = cqe_64byte_ena;
-	iwcq->ibcq.cqe = info.cq_uk_init_info.cq_size;
+	iwcq->ibcq.cqe = ukinfo->cq_size;
 	if (attr->comp_vector < rf->ceqs_count)
-		info.ceq_id = attr->comp_vector;
-	info.ceq_id_valid = true;
-	info.ceqe_mask = 1;
-	info.type = IRDMA_CQ_TYPE_IWARP;
-	info.vsi = &iwdev->vsi;
-
-	if (udata) {
-		struct irdma_ucontext *ucontext;
-		struct irdma_create_cq_req req = {};
-		struct irdma_cq_mr *cqmr;
-		struct irdma_cq_mr *cqmr_shadow;
-
-		iwcq->user_mode = true;
-		ucontext =
-			rdma_udata_to_drv_context(udata, struct irdma_ucontext,
-						  ibucontext);
-		/* Even though the last member of struct irdma_create_cq_req
-		 * was always user_shadow_area, we need backwards compat with
-		 * the legacy i40iw struct i40iw_ucreate_cq which stopped
-		 * at user_cq_buffer.
-		 */
-		err_code = ib_copy_validate_udata_in(udata, req, user_cq_buf);
-		if (err_code)
-			goto cq_free_rsrc;
-
-		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
-		iwcq->iwpbl = irdma_get_pbl((unsigned long)req.user_cq_buf,
-					    &ucontext->cq_reg_mem_list);
-		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
-		if (!iwcq->iwpbl) {
-			err_code = -EPROTO;
-			goto cq_free_rsrc;
-		}
+		info->ceq_id = attr->comp_vector;
+	info->ceq_id_valid = true;
+	info->ceqe_mask = 1;
+	info->type = IRDMA_CQ_TYPE_IWARP;
+	info->vsi = &iwdev->vsi;
 
-		cqmr = &iwcq->iwpbl->cq_mr;
-
-		if (rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
-		    IRDMA_FEATURE_CQ_RESIZE) {
-			spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
-			iwcq->iwpbl_shadow = irdma_get_pbl(
-					(unsigned long)req.user_shadow_area,
-					&ucontext->cq_reg_mem_list);
-			spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
+	return 0;
+}
 
-			if (!iwcq->iwpbl_shadow) {
-				err_code = -EPROTO;
-				goto cq_free_rsrc;
-			}
-			cqmr_shadow = &iwcq->iwpbl_shadow->cq_mr;
-			info.shadow_area_pa = cqmr_shadow->cq_pbl.addr;
-		} else {
-			info.shadow_area_pa = cqmr->shadow;
-		}
-		if (iwcq->iwpbl->pbl_allocated) {
-			info.virtual_map = true;
-			info.pbl_chunk_size = 1;
-			info.first_pm_pbl_idx = cqmr->cq_pbl.idx;
-		} else {
-			info.cq_base_pa = cqmr->cq_pbl.addr;
-		}
-	} else {
-		/* Kmode allocations */
-		int rsize;
+/**
+ * irdma_create_user_cq - create user cq
+ * @ibcq: CQ allocated
+ * @attr: attributes for cq
+ * @attrs: uverbs attribute bundle
+ */
+static int irdma_create_user_cq(struct ib_cq *ibcq,
+				const struct ib_cq_init_attr *attr,
+				struct uverbs_attr_bundle *attrs)
+{
+#define IRDMA_CREATE_CQ_MIN_RESP_LEN offsetofend(struct irdma_create_cq_resp, cq_size)
+	struct ib_udata *udata = &attrs->driver_udata;
+	struct ib_device *ibdev = ibcq->device;
+	struct irdma_device *iwdev = to_iwdev(ibdev);
+	struct irdma_pci_f *rf = iwdev->rf;
+	struct irdma_cq *iwcq = to_iwcq(ibcq);
+	struct irdma_sc_dev *dev = &rf->sc_dev;
+	struct irdma_cq_init_info info = {};
+	int err_code;
 
-		if (entries < 1 || entries > rf->max_cqe) {
-			err_code = -EINVAL;
-			goto cq_free_rsrc;
-		}
+	err_code = cq_validate_flags(attr->flags, dev->hw_attrs.uk_attrs.hw_rev);
+	if (err_code)
+		return err_code;
 
-		entries += 2;
-		if (!cqe_64byte_ena && dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
-			entries *= 2;
+	if (udata->outlen < IRDMA_CREATE_CQ_MIN_RESP_LEN)
+		return -EINVAL;
 
-		if (entries & 1)
-			entries += 1; /* cq size must be an even number */
+	err_code = irdma_alloc_cq(iwdev, iwcq, attr, &info);
+	if (err_code)
+		return err_code;
 
-		if (entries * cqe_size == IRDMA_HW_PAGE_SIZE)
-			entries += 2;
+	err_code = irdma_setup_umode_cq(iwdev, iwcq, &info, attrs);
+	if (err_code)
+		goto cq_free_rsrc;
 
-		ukinfo->cq_size = entries;
+	return __irdma_create_cq(iwdev, iwcq, &info, udata);
+cq_free_rsrc:
+	irdma_cq_free_rsrc(rf, iwcq);
 
-		if (cqe_64byte_ena)
-			rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_extended_cqe);
-		else
-			rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_cqe);
-		iwcq->kmem.size = ALIGN(round_up(rsize, 256), 256);
-		iwcq->kmem.va = dma_alloc_coherent(dev->hw->device,
-						   iwcq->kmem.size,
-						   &iwcq->kmem.pa, GFP_KERNEL);
-		if (!iwcq->kmem.va) {
-			err_code = -ENOMEM;
-			goto cq_free_rsrc;
-		}
+	return err_code;
+}
 
-		iwcq->kmem_shadow.size = ALIGN(IRDMA_SHADOW_AREA_SIZE << 3,
-					       64);
-		iwcq->kmem_shadow.va = dma_alloc_coherent(dev->hw->device,
-							  iwcq->kmem_shadow.size,
-							  &iwcq->kmem_shadow.pa,
-							  GFP_KERNEL);
-		if (!iwcq->kmem_shadow.va) {
-			err_code = -ENOMEM;
-			goto cq_free_rsrc;
-		}
-		info.shadow_area_pa = iwcq->kmem_shadow.pa;
-		ukinfo->shadow_area = iwcq->kmem_shadow.va;
-		ukinfo->cq_base = iwcq->kmem.va;
-		info.cq_base_pa = iwcq->kmem.pa;
-	}
+/**
+ * irdma_create_cq - create kmode cq
+ * @ibcq: CQ allocated
+ * @attr: attributes for cq
+ * @attrs: uverbs attribute bundle
+ */
+static int irdma_create_cq(struct ib_cq *ibcq,
+			   const struct ib_cq_init_attr *attr,
+			   struct uverbs_attr_bundle *attrs)
+{
+	struct ib_device *ibdev = ibcq->device;
+	struct irdma_device *iwdev = to_iwdev(ibdev);
+	struct irdma_pci_f *rf = iwdev->rf;
+	struct irdma_cq *iwcq = to_iwcq(ibcq);
+	struct irdma_sc_dev *dev = &rf->sc_dev;
+	struct irdma_cq_init_info info = {};
+	int err_code;
 
-	info.shadow_read_threshold = min(info.cq_uk_init_info.cq_size / 2,
-					 (u32)IRDMA_MAX_CQ_READ_THRESH);
+	err_code = cq_validate_flags(attr->flags, dev->hw_attrs.uk_attrs.hw_rev);
+	if (err_code)
+		return err_code;
 
-	if (irdma_sc_cq_init(cq, &info)) {
-		ibdev_dbg(&iwdev->ibdev, "VERBS: init cq fail\n");
-		err_code = -EPROTO;
-		goto cq_free_rsrc;
-	}
+	if (attr->cqe > rf->max_cqe)
+		return -EINVAL;
 
-	cqp_request = irdma_alloc_and_get_cqp_request(&rf->cqp, true);
-	if (!cqp_request) {
-		err_code = -ENOMEM;
-		goto cq_free_rsrc;
-	}
+	err_code = irdma_alloc_cq(iwdev, iwcq, attr, &info);
+	if (err_code)
+		return err_code;
 
-	cqp_info = &cqp_request->info;
-	cqp_info->cqp_cmd = IRDMA_OP_CQ_CREATE;
-	cqp_info->post_sq = 1;
-	cqp_info->in.u.cq_create.cq = cq;
-	cqp_info->in.u.cq_create.check_overflow = true;
-	cqp_info->in.u.cq_create.scratch = (uintptr_t)cqp_request;
-	err_code = irdma_handle_cqp_op(rf, cqp_request);
-	irdma_put_cqp_request(&rf->cqp, cqp_request);
+	err_code = irdma_setup_kmode_cq(iwdev, iwcq, &info, attr);
 	if (err_code)
 		goto cq_free_rsrc;
 
-	if (udata) {
-		struct irdma_create_cq_resp resp = {};
-
-		resp.cq_id = info.cq_uk_init_info.cq_id;
-		resp.cq_size = info.cq_uk_init_info.cq_size;
-		err_code = ib_respond_udata(udata, resp);
-		if (err_code)
-			goto cq_destroy;
-	}
-
-	init_completion(&iwcq->free_cq);
-
-	/* Populate table entry after CQ is fully created. */
-	smp_store_release(&rf->cq_table[cq_num], iwcq);
-
-	return 0;
-cq_destroy:
-	irdma_cq_wq_destroy(rf, cq);
+	return __irdma_create_cq(iwdev, iwcq, &info, NULL);
 cq_free_rsrc:
 	irdma_cq_free_rsrc(rf, iwcq);
 
@@ -5643,6 +5730,7 @@ static const struct ib_device_ops irdma_dev_ops = {
 	.alloc_pd = irdma_alloc_pd,
 	.alloc_ucontext = irdma_alloc_ucontext,
 	.create_cq = irdma_create_cq,
+	.create_user_cq = irdma_create_user_cq,
 	.create_qp = irdma_create_qp,
 	.dealloc_driver = irdma_ib_dealloc_device,
 	.dealloc_mw = irdma_dealloc_mw,
-- 
2.56.0.317.g454f8302e1-goog

