Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A49F606A324
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=szK8trSC;
	dkim=pass (2048-bit key, unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google header.b=CE9tyou+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F01E8606E5;
	Mon,  2 Nov 2026 22:32:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z4rozpLpjueN; Mon,  2 Nov 2026 22:32:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 43CA060705
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658772;
	b=Bympau1oUoXma83CwWEQEgA6eeV9iJIKq+7Q4snXgM/AKIW4oqNhd80FEp7BNNfJ3z/+
	 OmtWX4joT1OGMrEwYXkm24M96kc2jPRYRWQ+sgGzuA6xvK33MKsQs9d04N2XuQuR3FxoF
	 4suvj86b0J+zFkSbPmT1CX6eQljznc6KM2Uh3c/nixsv0VV3658lBKz+qxj/vTeaDtUCy
	 iqoBN+GH4EF3kzDGEAfR+LUniMy7wgyo5FpNGwykwUSPXJeZr6VY2P9hn2avRWg+Qo7jQ
	 bCRT8BOpFUjy4tUeyfDkP0LAFs/lrNofP0qKJaC1leHAXrNste5azgN21+3uHeyDNCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658772;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L7ar4WAN3UXBnRdyQx7m5lT8b0DpMHKQHo9PR1aXr18=;
	b=CAIAfMMFvppvH77PKv2rqHFAoz6+IVBB1oKkByLHS5z82UYDm+anDo+D9IzXbeEaErOp
	 qD0PPaZEwAXGOMiPVHCi6yQqvdp6kGKS6lyORM12UVg+pn/5+GcCGPF/a4hV/ukYkZiW/
	 T3NkX9ALMPEbN2wSj4vML/bjuCwCXMk2txEnBXBT2XmqddKHHwyopRWPsW1ISVfRU50i+
	 mtnBUswvXjS5egWEqadgRaKe29jOpsBdIID+juzXv+/v4p0Uo9oUob6B6/dQwZnCmIbwo
	 V/+epUIUfkltogTxO/tw9D2XrQsE7ABZhrhxTOGW1qfIMFnoSDp5Mp9L9Yje80muwxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=x6u.co;
	dkim=pass header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google header.b=CE9tyou+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793658772;
	bh=L7ar4WAN3UXBnRdyQx7m5lT8b0DpMHKQHo9PR1aXr18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=szK8trSCilLipCO19ck/sd3alWRPPyW9nrbo6/lFSR3J2awfSYjFo8LLs8T8MnzNw
	 CEZvRHw5MTUiFBeRLmRJnt5OE99qKTdrKd7W7Z3vBQPBeAZhDlM7aKdmzOqZraRg2n
	 2go6C8DZvmoyqVW3c5m1wc7mdxwjvmUVT7+PgF5lc1OZrdABFQRAXQZG93LH0xFlXv
	 c1RpgpAew95dX24FzXfUhTKnOPQ1Lny8T86YNE9PSjus9jVtYxWf9AXsNh+DktvdnK
	 gXdB/oCp0vhzDPhd1CVoXFF2F1suTlIfijb1+GgTmWzps4MODn3IEcU0MUMV99mRA5
	 Eu8rySGN1o5HQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43CA060705;
	Mon,  2 Nov 2026 22:32:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A5CC6235
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8BB2060A90
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s2aNMX_TEV85 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 18:15:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8D86460A86
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793384154;
 b=MqR5eGIwLWcfXtpwVn1cxJCqo/jlMt8cUTOBNwtX6soaSs77CC/ba88dqzkJ/rKJKv0j
 qWToI1Gj0FGQ7TJGTkBKmILWqmNqMrHzZpCGisa5iwL7/JmNbP5LdWGZYPtjeWpxfkSUz
 FeiXXmASQbyXsoVceAf+fw3J3o6hrqcrWymxXE3Aj3ktBynUdG0WEeTXozDrsESP7Jg/j
 hmp+GubrhHcctWX5olduXPizjyxhJ4ukPy3imqV8ZICKaO6NpWfJRuvUaSHLAd72Tn1mx
 Qdkp6jSVWyKUCdoflt6OkfQjB3L+lg9KphtvfbEHmkxNv1SdiDMVCf+dWi41LzpRiAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793384154;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=L7ar4WAN3UXBnRdyQx7m5lT8b0DpMHKQHo9PR1aXr18=;
 b=D0lBKB7MT4W8SqpFkZd3lYKcnk/IJaWSOxgqnn67HYACJHvTDKGOobX0zL9MiLtN1ksa
 DIShpYOWtjQKNEiatOL9sw3NOA9o33ymin0Qta2tD5qcqzPuQ0fJPdiDf1UKz7LeQ8ZL5
 frt0yrZ1A2uhS5EXSwHu1w8vy3G/EY+EuQoOZlbupitb/4BIV0+RInCk3/b3cfcNh8X4l
 R1d5K34/rFsbsEYF0itwUV31xOFcUOLgqJkRLKl8rN3xMnQg2HH6VEust5asEr57d+oef
 7d4BsSUNr5/R6Viky1fMTqcrir08It1SXueTo+1L9Jcw27MA5G5+546C/tiM5f8a0eQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=x6u.co;
 dkim=pass header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google
 header.b=CE9tyou+; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e34; helo=mail-vs1-xe34.google.com;
 envelope-from=dhu@x6u.co; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256
 header.s=google header.b=CE9tyou+
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D86460A86
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:53 +0000 (UTC)
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-7cc1cf48a39so293196137.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1793384153; x=1793988953; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L7ar4WAN3UXBnRdyQx7m5lT8b0DpMHKQHo9PR1aXr18=;
 b=CE9tyou+zSXuPzXGicgQ2LgNJCxxfkkcCtQn6TDootspqi4URmfwhrCXYFo/ogK1en
 HGhGUZYOJvoaOWoWoucuD4V0KsGZQlzfT3lFfrZb0DTziZj2QnADTuDP/2lvvVnFdJLB
 jnFDhv4N4c0Qb4UAQHN1DjxLazllcvQuEtFj8qoqRUYdFX6VZSYL5wWjKN1/34F1AHTH
 kWQhakSA42B0bvYYm/hvOCLALoVYC1LNCzTki2aOfXKuvEfiYjBdBEi1A/HmQAnBTwF6
 O9pdf8xFEqxuyM82lu6mWVTjfF7MZILn900+QKYSEuif3W0Bq1auplHNS5iZowEfMb9E
 k4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384153; x=1793988953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L7ar4WAN3UXBnRdyQx7m5lT8b0DpMHKQHo9PR1aXr18=;
 b=yjIcy316D75PhFsL9mAQvtORZ8ssPLlpkW3Zn9scmTBX7px1wEuxTRH+FbMZXcokWD
 TMPX6ouZJUiqrdQGx3t2wgpFXdS4cwy1bpP/WSaX3YFcE2JkbFw+NwV4+SqmbLnpQlPQ
 x0R5lqWX4waCWyjJpZa4hz7Jri6bTEFPtGMntankZh01LH2GP61G03gdSAsmRgsLGbdx
 NwGX08IuwS4kWcf/tuc/hOLNdKUE69w0b3fmEiA/EH2ooMfAHOvz4MeyytclKtDHWQTN
 9AFeWpspy42vmDVdoztEODKBOt/ErYJ/Thj9X5nBa94OoUxGvG6IS/YsRrA+KDf9frkW
 ctZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBgieog8ExxWqy5h+0yQvoL6olYTZ8x6ZsRI95S493VR4UmTP2rSUE02NdvwmQYVmK4XZVYTTYCVYN6zV2j4Q=@lists.osuosl.org
X-Gm-Message-State: AFq9FYKHdCsdsVkDVXeYBoHV1UPecch6ySxnjeBUghAsL3j8YDyklbW6
 pUCuqGs0uOmDolpJJCdujgIlyret9Fl3wZemv693tioMz/2h+M8KdmeXUFFfSfkxkreT
X-Gm-Gg: AYBFou0vZWXcWUZv+6uqY04S/2wpKrAzaWcpCwexisptcLPs7uWldwosSF256RKcBEL
 JfOJRz/sG59SUxbfNga9HX5gCD7cFedlgY8NU7DmiG9SBTKyvMeX4RnWAYp5ntw83WngGBgpT8+
 lrJYeYvxnx7fQHf8+sjQAiStNv9cySq2KIj8BEr3cclIlSZhbnFsHytdA+nWjEX0exMpm5BoTos
 3lT0MHMCEp5hsRublxK/tsWIRkIybA7fmiPvhEX0wrQEUNk4lJKl1+4NQ3MX/w0pg5jUeZWEVe6
 1VuXtUX/fkW2FbTdFqm5W8jF8I3gFl+ctBwcFcVrikpCc0GBR+DrguafZk+k3wKaCocneA05pjK
 1KOaH8TcQ0MC+i+DXiAUwFamh16nbgWgcwBZyM6hFylgjbvt7vnRIF3s9WUYdZHdSd3iZ1C/+cL
 1+7vyIVvWkL3rqvdyN4kOArEBjtg77gjnuvUknwwikeWbNGxnO47Ry8uk85gDUHKF2Ik4ppezb3
 kIcBwRDFZgI1E1iXRryLWgNaBspB4CME3Ed6l2CvDhfRV8u6urVZjo3qg0+99pfFe7aiS4moFnH
 W+iemffbHQsUMGsBYv8Hpe8Ff9rd3B4eTuAomuuYG8ef1EiWCCJiXdx+kp4MztkMsXq9kLFiwAv
 v7z5opgGZ0NyrTIgpfRob+Nn0IcnFD/99VNHzaz2TIdI=
X-Received: by 2002:a05:6102:8097:b0:7c3:3890:6076 with SMTP id
 ada2fe7eead31-7d0725cfd65mr1551425137.6.1793384152685; 
 Fri, 30 Oct 2026 11:15:52 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com
 (109.243.150.34.bc.googleusercontent.com. [34.150.243.109])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d07754c1c6sm3077931137.3.2026.10.30.11.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:15:52 -0700 (PDT)
From: David Hu <dhu@x6u.co>
To: Mustafa Ismail <mustafa.ismail@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Moroni <jmoroni@google.com>, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Hu <xuehaohu@google.com>
Subject: [PATCH rdma-next v4 6/6] RDMA/irdma: Support UMEM attribute for SRQ
 creation
Date: Fri, 30 Oct 2026 18:15:12 +0000
Message-ID: <20261030181512.2056056-7-dhu@x6u.co>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Hu <xuehaohu@google.com>

Support the standard 1-step queue buffer creation for SRQ by
`UVERBS_ATTR_CREATE_SRQ_BUF_UMEM` via `ib_umem_get_attr()`.

Set up hardware pble directly from the pinned SRQ umem via
`irdma_setup_q_pbl_from_umem()`.

Proper umem and pble cleanup, and error unwind are added into existing
`irdma_srq_free_rsrc()` upon SRQ destruction.

We maintain backward compatibility for the legacy 2-step registration if
the UMEM attribute is not provided.

Signed-off-by: David Hu <xuehaohu@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 68 ++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 41e56ab8aa6d..7e8a5e481730 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1996,9 +1996,16 @@ static void irdma_srq_free_rsrc(struct irdma_pci_f *rf, struct irdma_srq *iwsrq)
 		iwsrq->kmem.va = NULL;
 	} else {
 		/* Not called in any failure path, so iwpbl is valid. */
-		struct irdma_mr *iwmr = iwsrq->iwpbl->iwmr;
+		if (iwsrq->iwpbl) {
+			struct irdma_mr *iwmr = iwsrq->iwpbl->iwmr;
 
-		refcount_dec(&iwmr->user_ring_refs);
+			if (iwmr && refcount_dec_and_test(&iwmr->user_ring_refs)) {
+				ib_umem_release(iwmr->region);
+				if (iwsrq->iwpbl->pbl_allocated)
+					irdma_free_pble(rf->pble_rsrc, &iwsrq->iwpbl->pble_alloc);
+				kfree(iwmr);
+			}
+		}
 	}
 
 	irdma_free_rsrc(rf, rf->allocated_srqs, srq->srq_uk.srq_id);
@@ -2425,6 +2432,7 @@ static int irdma_setup_umode_srq(struct irdma_device *iwdev,
 				 struct ib_udata *udata,
 				 struct uverbs_attr_bundle *attrs)
 {
+	struct irdma_srq_uk_init_info *ukinfo = &info->srq_uk_init_info;
 	struct irdma_create_srq_req req = {};
 	struct irdma_ucontext *ucontext;
 	struct irdma_srq_mr *srqmr;
@@ -2440,14 +2448,49 @@ static int irdma_setup_umode_srq(struct irdma_device *iwdev,
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&ucontext->srq_reg_mem_list_lock, flags);
-	iwpbl = irdma_get_pbl((unsigned long)req.user_srq_buf,
-			      &ucontext->srq_reg_mem_list);
-	spin_unlock_irqrestore(&ucontext->srq_reg_mem_list_lock, flags);
-	if (!iwpbl)
-		return -EPROTO;
+	if (attrs && uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_SRQ_BUF_UMEM)) {
+		struct irdma_mem_reg_req srq_req = {};
+		struct ib_umem *umem;
+		u32 total;
+		u8 shift;
 
-	iwsrq->iwpbl = iwpbl;
+		irdma_get_wqe_shift(ukinfo->uk_attrs, ukinfo->max_srq_frag_cnt, 0, &shift);
+		srq_req.rq_pages =
+			DIV_ROUND_UP((ukinfo->srq_size << shift) * IRDMA_QP_WQE_MIN_SIZE,
+				     IRDMA_HW_PAGE_SIZE);
+		total = srq_req.rq_pages + IRDMA_SHADOW_PGCNT;
+
+		umem = ib_umem_get_attr(&iwdev->ibdev, attrs,
+					UVERBS_ATTR_CREATE_SRQ_BUF_UMEM,
+					total << IRDMA_HW_PAGE_SHIFT,
+					IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(umem))
+			return PTR_ERR(umem);
+
+		iwsrq->iwpbl = irdma_setup_q_pbl_from_umem(iwdev, umem,
+							   iwsrq->ibsrq.pd,
+							   IRDMA_MEMREG_TYPE_SRQ,
+							   &srq_req);
+		if (IS_ERR(iwsrq->iwpbl)) {
+			ret = PTR_ERR(iwsrq->iwpbl);
+			iwsrq->iwpbl = NULL;
+			ib_umem_release(umem);
+			return ret;
+		}
+		iwpbl = iwsrq->iwpbl;
+	} else {
+		if (!req.user_srq_buf)
+			return -EINVAL;
+
+		spin_lock_irqsave(&ucontext->srq_reg_mem_list_lock, flags);
+		iwpbl = irdma_get_pbl((unsigned long)req.user_srq_buf,
+				      &ucontext->srq_reg_mem_list);
+		spin_unlock_irqrestore(&ucontext->srq_reg_mem_list_lock, flags);
+		if (!iwpbl)
+			return -EPROTO;
+
+		iwsrq->iwpbl = iwpbl;
+	}
 	srqmr = &iwpbl->srq_mr;
 
 	if (iwpbl->pbl_allocated) {
@@ -2615,7 +2658,12 @@ static int irdma_create_srq(struct ib_srq *ibsrq,
 	if (iwsrq->user_mode && iwsrq->iwpbl) {
 		struct irdma_mr *iwmr = iwsrq->iwpbl->iwmr;
 
-		refcount_dec(&iwmr->user_ring_refs);
+		if (iwmr && refcount_dec_and_test(&iwmr->user_ring_refs)) {
+			ib_umem_release(iwmr->region);
+			if (iwsrq->iwpbl->pbl_allocated)
+				irdma_free_pble(rf->pble_rsrc, &iwsrq->iwpbl->pble_alloc);
+			kfree(iwmr);
+		}
 	}
 	irdma_free_rsrc(rf, rf->allocated_srqs, iwsrq->srq_num);
 	return err_code;
-- 
2.56.0.317.g454f8302e1-goog

