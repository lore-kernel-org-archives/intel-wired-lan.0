Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F3606A324
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=OFalk2SW;
	dkim=pass (2048-bit key, unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google header.b=Wo2DJI+Z
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 306C680CDA;
	Mon,  2 Nov 2026 22:32:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ewiicK0gs8m9; Mon,  2 Nov 2026 22:32:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4DAFB80D02
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658771;
	b=EghUA3NMxLnhOg3hgwSwfwuV0lVsIe5IDxH2uEuqa910DUBNmWzuQXvwi2CoO84UDxXI
	 O6U7LNKNSjtY3NVQt8nhxiHDSlo9oIi+5mS4Xo2EGStjpQLK/YN5TFqbWOERppMlW1QUo
	 o3174jMMNyI9Nz7C+rHIWX2hjvwRUo+1vOj/Hf9eQlh84vJ2vUQDuB/cDsryx2Kz5wVgr
	 gMRJ0lj3LMLrJRYX9xDJAcF1D3BJPAm4E4RslJLXWsHHEyc41wU3nqkfR6kv0ES4Vum8P
	 rhtN4HgkGHFd+EZPYs+c/hbgPwK+E7ld3RefVz6lsNBZkJ2CYUYY7UOkSil6rAR4F6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658771;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=knp/tm/TZZVuxSSAFhZ+sMDH3dqo4kKd8WvgszJHIrU=;
	b=p9B+QGQBbMzRVR8lmzeL9p6maQZNs2ev+7+RtO8Pnnt81/40ZP2n3L9e7Qq6aKmIK0PV
	 zPk6GtyF2ErLYrRYSUMPIlZiuBWi326/Za/wvZrfPlZnn8LS1zfgXGwo4aKPDb/JTA4U6
	 KVh9cEioeuN5ccfn3fO8LNdFrZAKeebmU7HCvvjPT9AbQF79693j7ILkrcZNrml5U27Vt
	 po7lCH1yRxAQzASVEA4BMKuf9PJ9ddZgbslHmDLeSS5K3/Z2ZNEUDXHy0zX2EwevbWp2A
	 eChT4bUBQmLm+w1ps964OHUppzBeLYS0Q9QfbYf29ZuJX/W2Kkbi2Tg+bR4Z3ycghTQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793658771;
	bh=knp/tm/TZZVuxSSAFhZ+sMDH3dqo4kKd8WvgszJHIrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OFalk2SWCpfo7i5dZtO9Fh/3xQAbfAVX4QaW7Q+5sR1E0mglRhBjCqBvV0xDkXx5F
	 Yg6CdEP6HhFKsVMdJQqeJCm1YEfZDjOT4fmoy9PZI7xygiH2Pg8EaI3PcqN8KHqKtL
	 LjIpJrPC/j0GXXB12a49JdDBicqomk7BU+2jm9n/BxUoq+l3GoSc7PGeGRHvWZHaKl
	 dInvN/gMEcKsllFE7zXx9fRfu9iL2hlGeMCyqnyjFL8xUwz5pjFbsXohk/v+ebeq9y
	 LlmIvrnAAzsUxlKpDrimDwRyLeXVO6gYmxXZ9sf0QKVjwFRvLD0WNFbxFo1WLhx6Sa
	 QwTQGV4oQ0HIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DAFB80D02;
	Mon,  2 Nov 2026 22:32:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E8872AC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E95BC40083
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VmOTZ7-zxSS5 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 18:15:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 08A70400B3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793384153;
 b=aHKcKa4d22r5qwMGpJ0Cyx1Hxn0aQvEg2wVrQEWjGp3M2JHR6vHNput2+H47skDoiqnm
 ZRWwfpp7/sUKeiTytupOsZmoHrix8Wib0Ac/LxH4a8RV6Q1gnEH/hlO4kcfPAl5ZY4iyC
 9XGxijQz0BWRYh53bGiME5u8y+lqdzWanZxAcDa7TE7U7sBUFFwMQtwzBG5fZhELHzVgP
 fhOON6P0DnlrxOzr/afLtSaNsik+5+SULQpXVIyKmYWpdQO9yIwDoBTfpQ1xF3IUxvcdT
 hEv0NSWsOwR+qJGHBYzyEFcH5r/jA4qSV6sMmAiZ9Y54iIWHxccl/mNEZyYn7dBUDKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793384153;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=knp/tm/TZZVuxSSAFhZ+sMDH3dqo4kKd8WvgszJHIrU=;
 b=PF8tMSxkKfI4042zU553nUltcfGUWhn25jHY5JEq7DcxOp1IqOs0bQV1GSQAf6SEevHv
 jLMgBw5pN7VLc6EOp61PWfepqULfxX309/oNiWPymwU04HYkG4XiP4EwcOdEG7eUDcQSb
 9le/RUvnVW6CZM/yeozyrSRkBGvjjruR6sfYpXJ7jAGRHYjWQYRefDUpzn3MfWMrdu9vs
 XFSjvkA0XmffsxJFkD2DDYtRt8AFSBhxdi1wYumcyYYbriM48wdBt8a+HmS0IbEgp8NJW
 VIks9dCy7hDcSKnX2CfsaL9i7BFI9/8YjsfgQKYQ0BOcsIKrQJYady34D8oqeG0nZAw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=x6u.co;
 dkim=pass header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google
 header.b=Wo2DJI+Z; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92c; helo=mail-ua1-x92c.google.com;
 envelope-from=dhu@x6u.co; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256
 header.s=google header.b=Wo2DJI+Z
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 08A70400B3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:52 +0000 (UTC)
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-9906a5410f5so1930756241.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 11:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1793384151; x=1793988951; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=knp/tm/TZZVuxSSAFhZ+sMDH3dqo4kKd8WvgszJHIrU=;
 b=Wo2DJI+ZegdsOuN4HcVFkNcU5ISFvUtHHBpiRFFEOxXwZZQcp+irZrtdHccFiuzebT
 7hGmNDNyc7IhzAYN9sQaa2UMG448LujGMddKA6J7OIFF1dBb4GO9/S2cKh/ZSTHrNbba
 wMgAx45p4+OQ4Vj0T+MrT0kbveEWwYr4X75M7eq0B7ke3++iK87kb36O221VgLbtKErD
 ltR0emRnX25PPaLOd7garis2IYWN09WCM4opvgxaymTwDAIIIbcTd7j3nKDyM7e6nNEv
 aIYA+Kwwh3Ix4ZKmY1Za3qknkf58cj9Qtp9ODIGhf+xZ8kY9LdIXwYFq82mEvauh/HhI
 EGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384151; x=1793988951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=knp/tm/TZZVuxSSAFhZ+sMDH3dqo4kKd8WvgszJHIrU=;
 b=oZTBF9T3vvrkwkvsLsph5SXJknZ29XtRUFq8GVP1OnTSTF4Fs08heHgD457FtndwnG
 bOJZZYyJ+wLG//UDdYJzlinha0HiyimchWI5+7MqPHUGiosacYA4zzfWs+nA0CshDjfa
 7NdfJ2k+F523472tSdJOiDTijTuyWJn0Y4zQnv9NcaW5YZfwYfIlSvua1cNUQWvm1PtN
 zZI4eqqQGcZ+udXG/M1VxxypebhP2Y0p9DaBwRimw//2K61pePac2ty/QcDzUr3IKGgo
 1GNOrIpi0hOjAE8TyrF0FAwVPDVfEnfxQFFQKfUNueuHvFO/Y2FhHu1F9TmjL8l4Dqjn
 hemw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbcWiqMllXqbvIbNhENNahc1hZ+BdLUAHiAEfnOnFk8n5oTRjjQGTL06HLLr2u7/7t9LNVlTRlX+Cv83hpNy8=@lists.osuosl.org
X-Gm-Message-State: AFq9FYK+6eZo3EOiVngY34tCg2GS6jyzmpYVVVqir+mK2ND5jYlPWD73
 l+MkdVl4ri5EGMPZUxed/ZMfro3ouPBjrR8RaRHhOXmRFLvP2xxLRSPRuI/POkEkQYT6
X-Gm-Gg: AYBFou2HYAS5OSGyMa+bnFD7g/D5kSO09KZmgVVkKkKiojgiaQuNZmQRGTq1d1AMACe
 O9hwJoOLyDAe8He+57XQYpBGSHFiOi3vayrpE2ZHz94g/ryJobNVmkKbV5Llh2VbkQ5benjQxpg
 tOUe1rSg5bH3r/5Y+dKclFFF0a5jxwVAzG1n1w/q8hOEM9adC9ie1dJsnxDX5NrsBX9g7T7PC6R
 8wuS/p3e3oFfsDWkYk2JUVc9mK6Dkqw/ZLRK7nUsBg4Uo4yQAOUWAWhCUSlOUoAmZHM/RKLzgZ2
 SFcOHnpBHHkEqfWuX2t4X5eCvgGVDhqmxZ9bRnVt4dhhpq9jMLgx6SITMNjVj64Nh2JHkOq0OqX
 o//4UL41nKHvgQMclOiXGglET7q7QgiGEbHnPZbSoBd+RIAInG17FiYkRoML1cIqOt6rBkBU4Uy
 IlacKPi+KA87gLGz+cXisakZqhfQ3RdqSdPN8b6HkNZw6ex9enAHnhWHDYICA+owcaXO/w/xBMS
 lcLfLQkgAz/EsSMoL/X5SamffMzw4mcQEs991Q7woR5m0sESVuF5svhU0QkIHol4708M6JEK48i
 N9InHKqspOeHwA+8unPXGC8hseTPnem7hTUZ+3M7iBfWyLaqexq6zjo5DkDK3jHJyG7SxgjXfpL
 HXWHjKln/af3nsm44Qfr6czZCrk/DpCNxB12Do9gGOMdB
X-Received: by 2002:a05:6102:5106:b0:7c1:e804:3c91 with SMTP id
 ada2fe7eead31-7d072c398bdmr931456137.8.1793384151354; 
 Fri, 30 Oct 2026 11:15:51 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com
 (109.243.150.34.bc.googleusercontent.com. [34.150.243.109])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d07754c1c6sm3077931137.3.2026.10.30.11.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:15:50 -0700 (PDT)
From: David Hu <dhu@x6u.co>
To: Mustafa Ismail <mustafa.ismail@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Moroni <jmoroni@google.com>, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Hu <xuehaohu@google.com>
Subject: [PATCH rdma-next v4 5/6] RDMA/irdma: Support UMEM attribute for CQ
 creation
Date: Fri, 30 Oct 2026 18:15:11 +0000
Message-ID: <20261030181512.2056056-6-dhu@x6u.co>
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

Support the standard 1-step queue buffer creation model for CQ by
`UVERBS_ATTR_CREATE_CQ_BUF_UMEM`, `IRDMA_IB_ATTR_CREATE_CQ_SHADOW_BUF_UMEM`
via `ib_umem_get_attr()`.

Set up hardware pble directly from the pinned CQ and shadow umems via
`irdma_setup_q_pbl_from_umem()`.

Proper umem and pble cleanup are added into existing `irdma_cq_free_rsrc()`
upon CQ destruction.

We maintain backward compatibility for legacy 2-step registration if UMEM
attributes are not provided.

`irdma_resize_cq()` will have a possibility to deal with a pble/mr that
is created via one-step logic, after this change. Therefore, a proper
cleanup is added.

Signed-off-by: David Hu <xuehaohu@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 132 +++++++++++++++++++++++-----
 1 file changed, 111 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 9f4905fdb791..41e56ab8aa6d 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2028,13 +2028,24 @@ static void irdma_cq_free_rsrc(struct irdma_pci_f *rf, struct irdma_cq *iwcq)
 		if (iwcq->iwpbl) {
 			iwmr = iwcq->iwpbl->iwmr;
 
-			refcount_dec(&iwmr->user_ring_refs);
+			if (iwmr && refcount_dec_and_test(&iwmr->user_ring_refs)) {
+				ib_umem_release(iwmr->region);
+				if (iwcq->iwpbl->pbl_allocated)
+					irdma_free_pble(rf->pble_rsrc, &iwcq->iwpbl->pble_alloc);
+				kfree(iwmr);
+			}
 		}
 
 		if (iwcq->iwpbl_shadow) {
 			iwmr = iwcq->iwpbl_shadow->iwmr;
 
-			refcount_dec(&iwmr->user_ring_refs);
+			if (iwmr && refcount_dec_and_test(&iwmr->user_ring_refs)) {
+				ib_umem_release(iwmr->region);
+				if (iwcq->iwpbl_shadow->pbl_allocated)
+					irdma_free_pble(rf->pble_rsrc,
+							&iwcq->iwpbl_shadow->pble_alloc);
+				kfree(iwmr);
+			}
 		}
 	}
 
@@ -2161,6 +2172,7 @@ static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	struct irdma_dma_mem kmem_buf;
 	struct irdma_cq_mr *cqmr_buf;
 	struct irdma_pbl *iwpbl_buf = NULL;
+	struct irdma_pbl *old_iwpbl = NULL;
 	struct irdma_device *iwdev;
 	struct irdma_pci_f *rf;
 	struct irdma_cq_buf *cq_buf = NULL;
@@ -2273,17 +2285,12 @@ static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 
 	spin_lock_irqsave(&iwcq->lock, flags);
 	if (udata) {
-		struct irdma_pbl *old_iwpbl = iwcq->iwpbl;
+		old_iwpbl = iwcq->iwpbl;
 
 		/* Only update if the resize was successful. Otherwise, HW is
 		 * still pointing to the old PBL.
 		 */
 		iwcq->iwpbl = iwpbl_buf;
-		if (old_iwpbl) {
-			struct irdma_mr *old_iwmr = old_iwpbl->iwmr;
-
-			refcount_dec(&old_iwmr->user_ring_refs);
-		}
 	}
 	if (cq_buf) {
 		cq_buf->kmem_buf = iwcq->kmem;
@@ -2298,6 +2305,21 @@ static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	ibcq->cqe = info.cq_size - 1;
 	spin_unlock_irqrestore(&iwcq->lock, flags);
 
+	/* Old pble/umem is cleaned up outside spinlock's atomic context
+	 * since both of them take sleepable lock.
+	 */
+	if (old_iwpbl) {
+		struct irdma_mr *old_iwmr = old_iwpbl->iwmr;
+
+		if (old_iwmr && refcount_dec_and_test(&old_iwmr->user_ring_refs)) {
+			ib_umem_release(old_iwmr->region);
+			if (old_iwpbl->pbl_allocated)
+				irdma_free_pble(rf->pble_rsrc,
+						&old_iwpbl->pble_alloc);
+			kfree(old_iwmr);
+		}
+	}
+
 	return 0;
 error:
 	if (iwpbl_buf) {
@@ -2746,14 +2768,18 @@ static int irdma_setup_umode_cq(struct irdma_device *iwdev,
 				struct irdma_cq_init_info *info,
 				struct uverbs_attr_bundle *attrs)
 {
+	struct irdma_cq_uk_init_info *ukinfo = &info->cq_uk_init_info;
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct irdma_create_cq_req req = {};
 	struct irdma_pci_f *rf = iwdev->rf;
+	struct irdma_sc_dev *dev = &rf->sc_dev;
 	struct irdma_ucontext *ucontext;
 	struct irdma_cq_mr *cqmr_shadow;
 	struct irdma_cq_mr *cqmr;
 	unsigned long flags;
+	bool cqe_64byte_ena;
 	int err_code;
+	u8 cqe_size;
 
 	iwcq->user_mode = true;
 	ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
@@ -2767,26 +2793,87 @@ static int irdma_setup_umode_cq(struct irdma_device *iwdev,
 	if (err_code)
 		return err_code;
 
-	spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
-	iwcq->iwpbl = irdma_get_pbl((unsigned long)req.user_cq_buf,
-				    &ucontext->cq_reg_mem_list);
-	spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
-	if (!iwcq->iwpbl)
-		return -EPROTO;
+	cqe_64byte_ena = dev->hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_64_BYTE_CQE ?
+			 true : false;
+	cqe_size = cqe_64byte_ena ? 64 : 32;
+
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUF_UMEM)) {
+		struct ib_umem *umem;
+		struct irdma_mem_reg_req cq_req = {};
+		u8 shadow_pgcnt = (rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
+				   IRDMA_FEATURE_CQ_RESIZE) ? 0 : IRDMA_SHADOW_PGCNT;
+		u32 min_size;
+
+		cq_req.cq_pages = DIV_ROUND_UP(ukinfo->cq_size * cqe_size,
+					       IRDMA_HW_PAGE_SIZE);
+		min_size = (cq_req.cq_pages + shadow_pgcnt) << IRDMA_HW_PAGE_SHIFT;
+
+		umem = ib_umem_get_cq_buf(&iwdev->ibdev, attrs, min_size,
+					  IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(umem))
+			return PTR_ERR(umem);
+
+		iwcq->iwpbl = irdma_setup_q_pbl_from_umem(iwdev, umem, NULL,
+							  IRDMA_MEMREG_TYPE_CQ, &cq_req);
+		if (IS_ERR(iwcq->iwpbl)) {
+			err_code = PTR_ERR(iwcq->iwpbl);
+			iwcq->iwpbl = NULL;
+			ib_umem_release(umem);
+			return err_code;
+		}
+	} else {
+		if (!req.user_cq_buf)
+			return -EINVAL;
+
+		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
+		iwcq->iwpbl = irdma_get_pbl((unsigned long)req.user_cq_buf,
+					    &ucontext->cq_reg_mem_list);
+		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
+		if (!iwcq->iwpbl)
+			return -EPROTO;
+	}
 
 	cqmr = &iwcq->iwpbl->cq_mr;
 
 	if (rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
 	    IRDMA_FEATURE_CQ_RESIZE) {
-		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
-		iwcq->iwpbl_shadow =
-			irdma_get_pbl((unsigned long)req.user_shadow_area,
-				      &ucontext->cq_reg_mem_list);
-		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
+		if (uverbs_attr_is_valid(attrs, IRDMA_IB_ATTR_CREATE_CQ_SHADOW_BUF_UMEM)) {
+			struct ib_umem *shadow_umem;
+			struct irdma_mem_reg_req shadow_req = {
+				.cq_pages = IRDMA_SHADOW_PGCNT,
+			};
+
+			shadow_umem =
+				ib_umem_get_attr(&iwdev->ibdev, attrs,
+						 IRDMA_IB_ATTR_CREATE_CQ_SHADOW_BUF_UMEM,
+						 IRDMA_SHADOW_AREA_SIZE << 3,
+						 IB_ACCESS_LOCAL_WRITE);
+			if (IS_ERR(shadow_umem))
+				return PTR_ERR(shadow_umem);
+
+			iwcq->iwpbl_shadow =
+				irdma_setup_q_pbl_from_umem(iwdev, shadow_umem, NULL,
+							    IRDMA_MEMREG_TYPE_CQ,
+							    &shadow_req);
+			if (IS_ERR(iwcq->iwpbl_shadow)) {
+				err_code = PTR_ERR(iwcq->iwpbl_shadow);
+				iwcq->iwpbl_shadow = NULL;
+				ib_umem_release(shadow_umem);
+				return err_code;
+			}
+		} else {
+			if (!req.user_shadow_area)
+				return -EINVAL;
 
-		if (!iwcq->iwpbl_shadow)
-			return -EPROTO;
+			spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
+			iwcq->iwpbl_shadow =
+				irdma_get_pbl((unsigned long)req.user_shadow_area,
+					      &ucontext->cq_reg_mem_list);
+			spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
 
+			if (!iwcq->iwpbl_shadow)
+				return -EPROTO;
+		}
 		cqmr_shadow = &iwcq->iwpbl_shadow->cq_mr;
 		info->shadow_area_pa = cqmr_shadow->cq_pbl.addr;
 	} else {
@@ -2872,6 +2959,9 @@ static int irdma_create_user_cq(struct ib_cq *ibcq,
 	if (err_code)
 		return err_code;
 
+	if (attr->cqe > rf->max_cqe * 2)
+		return -EINVAL;
+
 	if (udata->outlen < IRDMA_CREATE_CQ_MIN_RESP_LEN)
 		return -EINVAL;
 
-- 
2.56.0.317.g454f8302e1-goog

