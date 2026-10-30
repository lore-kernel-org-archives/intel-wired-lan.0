Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2964D606A326
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=hBEedGEZ;
	dkim=pass (2048-bit key, unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google header.b=RYmslQaC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C97080A87;
	Mon,  2 Nov 2026 22:32:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u8qjyeYLOY4t; Mon,  2 Nov 2026 22:32:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6590780CED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658768;
	b=e4MC0bHs+GxtK+x1w8s8OX1yw1VGWPT2WofcKN4mBkwMozwV1W19tHdbHbuWAB8Y1vh9
	 2yTg1K7GKxvlV7mAZ2mqmw8OfHjz2o52dTXxmnQxkX69RW29RQos4Af4nh8UuJ4szXRig
	 bxrkR1EomSa7Rzo+iPsYPWak/pUreFTBfi/wQIyOkrpIfgkNd8aGLvP7I92hmN1r0l1vq
	 07FxNppmfwsQveffipcsJAzwSvl/a8SFxVMIHNSZ3NBicxc14f2AokHQWcuW0qcEXyHYF
	 vFS4Vai4QFy59fi6G/7OkwDHtbEx0Gupyo6THrof4haaIzqm9fsSoXNq+5s1U1laJDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658768;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yypjsQQLN14RvHd1ipvvq2CtwzVsovNmzy30kWecM9U=;
	b=Pte3nxZl/0HOM3RzGcyZYFb1LD5sgSjYgqJWVdSMdzPLqRpwxKoI5nI5iz4OlC1mb3yf
	 Eiwk+p3BtsU+7noK+JA7tWM7xUIkLBU/oM9pVPNs5N2vdM1kTbA4VommBihlL2UjjykNg
	 25MjgadqJAs8dzgzZiJD3/UMYFxky1tCfs7xLHIKrWUzSOWialZ/JKDK9NuTsGl8sOwll
	 c2Hvt6TKJnpYOHjb5CpuW9vIiNaVN8InEmQxnAusDpNejv/s2Y8FYaMGb5VmIZ9ATiHE5
	 ugQXAITqYeWZWZky8IN1cMwWAki1OIhfJvxtrSFE055IRxDNRx6XT7sfFx+NlnnP6qQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793658768;
	bh=yypjsQQLN14RvHd1ipvvq2CtwzVsovNmzy30kWecM9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hBEedGEZYg47A/yl4CT6diix0RqTDjjY9EWYgsvAE6+8pTx/fFTBVcdpVxg7EJG0L
	 szHHaZhch06Zj/JxsrHSNVw9BLhkqyHlCO1TNaqFGpM1DtQnJgpMo4grHWqyw0Xlhz
	 ScGMFDQ0TVj8un9coWUir2KQLhDBK6JYx6rqcQQTIV+duk4IiKwBlv/CqajgN6e4DS
	 zngZox6X8Ch8mSSPnA8b4udYctTMapoifxI/fJLhQU2wHJ6U7zEgnbznCe9O2E/fkR
	 dLoaLkuVwhlEYN4QPVe4Uyuk5TIJk5Izu9BqRwn8OTTP3tvx6QUcxxjLW5pDU2C6v2
	 YJEcOvUIIpAnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6590780CED;
	Mon,  2 Nov 2026 22:32:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ADCD3235
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A04DE400B3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8YjAz0WZsRdP for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 18:15:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D600E40083
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793384149;
 b=JjyeFiOybjJ+EeIynviLNrNEqVNcqQJNiH+xHcp6aeJLMOcJM+qQDD6YYX6fi4D71Nme
 3AP8PsI3v5VmbKlcRP+SFowJuJlao4pf6CSHbfw1CvojWG3DAlyNUrndn2iRCeJp1i2pK
 e+WLt9hHuuzZAoJifm52NUv0MlOYo5ADTvogiKM/dZnlwbIophWilNWfbQGKgXGtn96Up
 Izj52wd4j4lLIQOHcPxPauWNWx0bTSV0RqnsTj0dSKZokLNuTHZCztACn6TM2mhe/Gk6c
 eyUktdW9mIZP+e1FpUsLGLWH4DDspK7ZuMVUNv1yDaTek5ECTAbF0Z2wcZXDNSd+KAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793384149;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=yypjsQQLN14RvHd1ipvvq2CtwzVsovNmzy30kWecM9U=;
 b=rZG57jae233t9WHq56aRSOtga8dopZxlcyDuARJquevrTYRt5TPE6Zudgt5BYbKRBSJZ
 sNDV84CedcMKyfoE+jeavCxGWwgQv/ooYS+TKXuQmmI0PwhtYfR0YCfeMJXRVuSxbV/DG
 c1TYeEOhk/pQZfOWdjmJgbNlO3EfX1UT/27XEwbNX8FVeFXCrrCebRyepidwJonl1r6Bv
 tfs6po7dcX63tW9pt3bEEsuF31hHOek4YCeH4rUh5NCsteHZ2MY/Ay8kkh/iAFTAs02v9
 6+9ElUFEsMHwOvSItgx3uUagsrnVuenPL2tSQxiCL3FXa1hUOLX3LRf5fPnYZUNYZVg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=x6u.co;
 dkim=pass header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google
 header.b=RYmslQaC; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2b; helo=mail-vk1-xa2b.google.com;
 envelope-from=dhu@x6u.co; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256
 header.s=google header.b=RYmslQaC
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D600E40083
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:15:48 +0000 (UTC)
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5eac6c5f927so385296e0c.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1793384147; x=1793988947; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yypjsQQLN14RvHd1ipvvq2CtwzVsovNmzy30kWecM9U=;
 b=RYmslQaC81G2kYDTwEgn8vje0ITg0nhWDmoLT3tY8lsxUWYS0mwRNTk0YDdcS5O0ql
 txqUDQMIKsWbuzGQQzpqwIZUGVgxDDu+aoYKKQiDG/nPijunoo6jwRPitWXP75D1mQoC
 RiP4Fbc3wc+iyvPDp73j1/9DBiWSQEwtrTKKvCDWOLSnX1Kj7KvtZmd4AwWVRuZrGkfN
 3UBCgD/C7vHml2EaAQ2VRgfT9aIA8QaL2xGA0qXucqC7H1hhEPyHyWlK6K+J2giM2Mps
 TvSnMuFNAfamjoAO2D6gbAFZS1tjxaPC4aLTkd8eOeoFDvfZtIifmHOeN5ampK2+toQw
 qIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384147; x=1793988947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yypjsQQLN14RvHd1ipvvq2CtwzVsovNmzy30kWecM9U=;
 b=bjNPA/N6c6pCEUOsO9owpEJ8N2szQMEo6yzUf2c3ezOu9qMtJWvnnDHkYOGcydOovB
 moqI0eU4gKRZ706hGjTgddVqo3Km0Q4aycYSYDDsknK4b2Qk2mjX6NZStOpkx5eHBtTt
 T4alhL+0K/itHFpaGESBFmFTW2AukrKiAkg1C/MQwnpSTw+Hp5rPOQkENHQvHN1HtJ5p
 OHtMsv4WX1PndMyrfTKmzazP2DVJWGtsOP7NDQduilmG4qCPWmBHD1JVxa9jsPhSErsb
 OC0bMwuR/manjk3LkSDOyNirqP0fhhHL/BtdzJ/hY9+C4ypGk3ZRKXvLePhN2M1Yj8In
 ANdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcl0XC6pnZY3AhwuhYRnsTIbDCKwZDgLPVodXCp4BxRVjYYCHWnapzphybslQVXfpjrgxWfDUsyriLLoOhWHg=@lists.osuosl.org
X-Gm-Message-State: AFq9FYJ+NShP5DOvzW1F5jZni7GuH8JiaYjXXZ5rJEgE/LFYmXjrjO8z
 484cWS/VTJKq0yxCfMQTe8QC2GBSiHBMVo7+8VAo3jZo6wwhjCAdr/6XJ63lXQi4Ewq0
X-Gm-Gg: AYBFou02aGSr8A6tN7bBsEjABvITMkORp7+aKfCc8mW6YanrOJXpIKxgDu8mg8NAewJ
 B5lDxBD8ezcl36mHCmokyYHomok17fyAa7bvs1xnNWL79aHKth7++Ln0DsFGp97bxfWGCRYSD9c
 h4uoLh3T23btA2SFqQd7T2jyhfsQHeKTePzGvR2L869BgbVwKyNJnS4ZolAJFi4c+SQDX8MDgcC
 4wJiQJAo3Sn+SlhvUpud7+C+2WZXv/gd6Y0SQYMsaEljBHP31YL0N4OF+xg+3X3gTGfBPJROxhz
 HN3EKJV+CgvML4L1fmHHjm1E67PctWjZwaKWUVUkfbFR50AQVq1TlylPThVpw6BW3gc69aGF6BJ
 247AEk+7IDMjLH1Ct5h2AH3uGpEKbep6DNWaSbE4hoRjVFOPAxMcMgyaeGQ/RqMsSKuA52Xib7u
 5O3gOqsQC9u4hp9Z8v+3M8CQSvLgXVf+iMZzQwvKGExiX14IdiQevuFSr7wSg/KMrBD9B1OCz3k
 ciz+qOZWFxiAhjkL+uIpM2Dxau0Fp+wTlEZU5BlmyWaRInKGNmKvKTu7S/AvJchzP+mT5ZIziQ1
 5lVWEIcJ82Ki7XaDFHh/05yE4lecp+TgLUyepSE5GkFr65Te50dTw9PE/OXtf1Et7Q2ZzWzdu3s
 lH0vfkVDtrxCO5R/2+Vyg9ZL6jcwERgBDF1fmX+U5QDroyS0bfT7ludTWy6S+wPdX
X-Received: by 2002:a05:6102:5126:b0:7d0:6db8:dc33 with SMTP id
 ada2fe7eead31-7d0727ada6emr1650413137.2.1793384146946; 
 Fri, 30 Oct 2026 11:15:46 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com
 (109.243.150.34.bc.googleusercontent.com. [34.150.243.109])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d07754c1c6sm3077931137.3.2026.10.30.11.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:15:46 -0700 (PDT)
From: David Hu <dhu@x6u.co>
To: Mustafa Ismail <mustafa.ismail@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Moroni <jmoroni@google.com>, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Hu <xuehaohu@google.com>
Subject: [PATCH rdma-next v4 2/6] RDMA/irdma: Register irdma UVERBS ioctl
 namespace
Date: Fri, 30 Oct 2026 18:15:08 +0000
Message-ID: <20261030181512.2056056-3-dhu@x6u.co>
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

An irdma UVERBS module is now created. An irdma specific shadow buf is
defined for CQ, while QP and SRQ reuses core's uapi definitions. This
works since core builds shared core ioctl parsing tree first, before adding
driver specific `uapi_definition`.

Destroy paths are automatically handled by core dispatchers, as objects
are now registered in the parsing tree and no additional driver specifics
are needed in destroy ioctls. Resize, Query, and Modify continue to go
through write() cmds.

Signed-off-by: David Hu <xuehaohu@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 18 ++++++++++++++++++
 include/uapi/rdma/irdma-abi.h       |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 811b1d532599..dd824720671c 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1,6 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "main.h"
+#include <rdma/uverbs_ioctl.h>
+#define UVERBS_MODULE_NAME irdma
+#include <rdma/uverbs_named_ioctl.h>
+#include <rdma/ib_user_ioctl_cmds.h>
+
+ADD_UVERBS_ATTRIBUTES_SIMPLE(
+	irdma_cq_attrs,
+	UVERBS_OBJECT_CQ,
+	UVERBS_METHOD_CQ_CREATE,
+	UVERBS_ATTR_UMEM(IRDMA_IB_ATTR_CREATE_CQ_SHADOW_BUF_UMEM, UA_OPTIONAL)
+);
+
+static const struct uapi_definition irdma_uapi_defs[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_CQ, &irdma_cq_attrs),
+	{}
+};
 
 /**
  * irdma_query_device - get device attributes
@@ -5602,6 +5618,8 @@ static void irdma_init_rdma_device(struct irdma_device *iwdev)
 	iwdev->ibdev.phys_port_cnt = 1;
 	iwdev->ibdev.num_comp_vectors = iwdev->rf->ceqs_count;
 	iwdev->ibdev.dev.parent = &pcidev->dev;
+	if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
+		iwdev->ibdev.driver_def = irdma_uapi_defs;
 	ib_set_device_ops(&iwdev->ibdev, &irdma_dev_ops);
 	if (iwdev->rf->rdma_ver == IRDMA_GEN_1)
 		ib_set_device_ops(&iwdev->ibdev, &irdma_gen1_dev_ops);
diff --git a/include/uapi/rdma/irdma-abi.h b/include/uapi/rdma/irdma-abi.h
index 38155affc8b4..a1a26529aa85 100644
--- a/include/uapi/rdma/irdma-abi.h
+++ b/include/uapi/rdma/irdma-abi.h
@@ -10,6 +10,7 @@
 #define IRDMA_ABI_H
 
 #include <linux/types.h>
+#include <rdma/ib_user_ioctl_cmds.h>
 
 /* irdma must support legacy GEN_1 i40iw kernel
  * and user-space whose last ABI ver is 5
@@ -23,6 +24,10 @@ enum irdma_memreg_type {
 	IRDMA_MEMREG_TYPE_SRQ  = 3,
 };
 
+enum irdma_ib_create_cq_attrs {
+	IRDMA_IB_ATTR_CREATE_CQ_SHADOW_BUF_UMEM = UVERBS_ID_DRIVER_NS_WITH_UHW,
+};
+
 enum {
 	IRDMA_ALLOC_UCTX_USE_RAW_ATTR = 1 << 0,
 	IRDMA_ALLOC_UCTX_MIN_HW_WQ_SIZE = 1 << 1,
-- 
2.56.0.317.g454f8302e1-goog

