Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FF5C79FAA
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 15:13:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62344405FF;
	Tue,  8 Sep 2026 15:13:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4j9E75YMLRC7; Tue,  8 Sep 2026 15:13:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AD42640606
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788880438;
	b=SnP3N8UozpQnk754TjZ7c7okTU+SlasYtUt+cx4+/vfCH66qcxUcHMnixmxu60wzavsw
	 HzyTMI3O3J3gfsNoOLqfviN3Jjc7wbM5wpxutlLv7naz/YsSrZyuOz7Oc4urL9Ic30UvS
	 oqyAs1JQqB4Qe2wv/bXRtTYGu7WNQThAHo1gdWjNdlTa2RkFZkRzUuQKn2Ku/9TUmA5iO
	 ifXHc0l3jaQCPxNIgFLoiEezdqWF8t7GeEOcJ5a2LXeMFWs+pRIF7LCI9hyujLniZd47F
	 hk+ff8tgsuzBQ3jlDcwJRaKdpzSI0VOLA8UfNEMjjLfKZIdgARht+hLnoWv+DxqTJVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788880438;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iRkujaorlRRownXMQ24CydTkW9kZUj9cAg9923H2gP4=;
	b=FI0AZn7layOfVz42obJ6umsVZVHo1Dc65ls/R/2ebaGbaCQ6WoKAy1cHi8TOsXUjJQaX
	 yjZYP+WdmNQYHi8jzEfis7v2MFCOOQB42MqVJfuhlWp2NzCVNXK0S5xPEw1f1sLZfed3B
	 eKHWYDW0LVPw97EF/ny2I/oz1zLvchVXVEz/i96SRl2H7/OovSg+hnypyOY/nbOoVqcIc
	 wF7SaJI9A7fGGZ8Py4EAw9QfNcQeWHND1CrBVSprVE6jl62d6QPOdi5Krv8aj3N+eDox5
	 YoK/+3OxBxU2k9HSGKJo7PCswJ0ByWN2lo2OLLB7rZrDnSEf94Q3H5y0Jz2AQCvy2Og==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788880438;
	bh=iRkujaorlRRownXMQ24CydTkW9kZUj9cAg9923H2gP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8eUuDitsIZQor39t6zO6k5WQvtq1+bdShDrmOW30CB+OnYtcYWSy3rNjgkM+pD7kO
	 q+Is8H53hPG+kIxKL0CjQ8JsXwKBC/rh1W+bNxjDBsjwZXxNvrPq3Z55ivjba6EI1+
	 wCyoXVBB7AcMfu0aNpBLT7MqS2HCbtHyyHBZS+emVkIC7N+spIRQFLDk9W+jNsAHQf
	 meCxPbQYjlF3M2pAFdN8IaN+dS1QeTkYULqBUB8Yf3b0HlvswyPWl+9zMFkzrSJKwB
	 xLbUTTQln/pol+g2k6/IwXQMwOs/FVfwVpc7y8z6AoiPF7QMq1MNuXXasv1Su9TFEV
	 7k31pGym4yBJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD42640606;
	Tue,  8 Sep 2026 15:13:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 61BE529B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 06:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4801F605DF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 06:45:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fjFK_4lDO3rj for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 06:45:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7EE1E605DA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788763547;
 b=IAJimAWa1KBFkQHXWKLqNxjdQJiScweqL5FYuPKUGjI17fpVsDLbvr8XAlnjQFD0ably
 yUp+oY0iE13/hiRqmBn2PHTiAV0U8/DLdE8t89JTMcJIesvJtx5l2QQeAKTlQrmSk2aWq
 950Xe1aQ5thNdiooP4fFpjpAZq7JeMktCyxaLe9eDyZcgCFj8+3VWBvNdS2SghjlmH924
 9ktd2l8yZQtSYYNaE3sGVl7E+TnHrXMeR8OhnoUrRQj/KUzLQsF2PQoO/z0GVQYitII07
 nRuND8uf1A9ChImpWWXWm8vOgzqzmnQZlE96vKjToI20uptfMC4WuYfy7S+By4uvnmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788763547;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=iRkujaorlRRownXMQ24CydTkW9kZUj9cAg9923H2gP4=;
 b=IevzK9hyM3jeC3XSyUBCNDObJ8fTC1bL8Xu6vPQ7oVi19odBdyN1AStMYW8H9MDsHIhG
 xgQ7nXeHNgvcKfF8hjVUgzSxSNzhfacuemj9JWd/bLVWD+fpupO9eNL/kescOh6/AIV1H
 7yPUIyGjLPzoWmxjwzJ+qAiTLQexaUcTkQZbWemG7fDsdvZw5D8runrjSd96GmrYMs1hU
 kbXjRYjXg2PYfhIFdQptkxVwBDr9e7aOogeatnGocNWP98Gfasg9UlbHfJIVHcyHvjfL7
 4ulvohj6tUwkSz7TV2kjv9Q1zuxYT/4DIAUXMzhjtVfsCrzG1IKgXKRQVS9jQ6zvVbA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=F4RB693x; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=hemanth.selam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=F4RB693x
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7EE1E605DA
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 06:45:47 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so2489933a91.2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 06 Sep 2026 23:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763547; x=1789368347; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iRkujaorlRRownXMQ24CydTkW9kZUj9cAg9923H2gP4=;
 b=F4RB693xx5KfN3W1g8DRC8H1t5GoZwkta/eonIKi/8BezqizswAEmlvB+KlTHTfHZE
 ZFDW/vOL5/mQFB1WSaHyVuAX/ILpT4tQ7MrjwO/hTdw7Ic5zakpI4VkWJp/yIpWaaQ2o
 3dNlPIwgbJwiNqRQZVXayKFuR5JtN5mTUmsm72FEhqOalrHUFCZ1OHd1ZWHDS63wqX1S
 pm5k9/i1qHme6PNal9n1G/PYBQORgNRkG3OPy/PN5TydsxRhvJM0Q/VovX+SEHg/1p0n
 rpRCvKPe8sDqoUBknlRRgUWMIq9k3X3ntNWSgILhPa+hcOkqWBjf3aZw45VYUi+/JxY9
 t2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763547; x=1789368347;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iRkujaorlRRownXMQ24CydTkW9kZUj9cAg9923H2gP4=;
 b=LEoa+lpKekQdl946Lb+1s3B0y3lpPu9IsZmqw3MGzVjVIsQe7anc/sevG96dkwwIW9
 BOfXnS8aOhtbDJRblz5y4VQiN6Wt9bDCM8TD+bI+6Tn8Ioi8IsIhOl0++lxd/hh2g+wV
 uq+XoIblNGxLjj1Bq24S6Qa9MEsMnGCRbAXJ8kChn9i7y7WHUnUusMqj22ZrBo/JDzA+
 AXsgLNO3PI3Nq1dH+mswzvwn6lHZJfdGCoEIgzcqWfh5uy+Fuks0XGnF/gcIauBvkztG
 zimPlN66Fl2aSrKlPXPbNVRI1Z/DNt51TDkMQIVAmxwsYfOgN3stCNypo5Mpl7NMqk8+
 ojiQ==
X-Gm-Message-State: AFuF++mje/JKcR8iJaSB6kqw6RD52SQ4XST1iaoPFGuAxqHsBpUsh+Gx
 bmMX5Hrz2gTd/w243fthvyXu/q4OxFSnGvqz9xvbjCc3BgdNqm88kM6z
X-Gm-Gg: AYBFou1g57POL5P6SR3GN2JXTrKE3YL8KNSkySX+DcI46UmYeR50aJ3L8mU5Mm1nM8J
 SzIWrTr9uQSaSC9PzklTMvkaK7AUXXkkILOWLzvbYrAT3YeiAARTqwnzcmoFhMbq66Q5joGP/aP
 TnIbJwTlFff8nxJsSbeHBTpnst3snxctc+rKtu77whQyMRuzRlnwPxY9xUevPkb0nUUPN8x/LYk
 jyH2tvpde2zruhSmVwgwg+m9YuWqBTH4ua79B3Y0BJr7NQpjLv0cTc9aIDXMAgFAoe90zCgM99L
 yOttYSNfVMNfr9G7R1JSQyewlKDp6Gmm9O+c3k8H8XkcpZPCwNwNurUDxIKGQxYA1A8gZ0Hx/zE
 WEXUKwGffrCuro6etAoFMGfblN9Xlabig3DxwIfszrnsb9gXgD2R8sFHHEDI8CB1yL8lWr0Bub+
 C6n+f6YND9YPP1Mzk1HKWg5vivcwGsxmtah5jOydG/tJQGAle4f/EJG8t2U+o9tAzNt0gW8ojcr
 8fkMlrpYO+BzQ==
X-Received: by 2002:a17:90b:4d06:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-39b2614df74mr30463582a91.1.1788763546458; 
 Sun, 06 Sep 2026 23:45:46 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14332405e92sm17209594c88.8.2026.09.06.23.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:45:46 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 2/2] Documentation/networking: fix repeated words in comments
Date: Mon,  7 Sep 2026 12:15:28 +0530
Message-ID: <20260907064528.6602-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064528.6602-1-hemanth.selam@gmail.com>
References: <20260907064528.6602-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 15:13:56 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org

Drop words accidentally written twice, reported by checkpatch.pl as a
possible repeated word.  Only touches comments, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 Documentation/networking/device_drivers/ethernet/intel/i40e.rst | 2 +-
 Documentation/networking/device_drivers/ethernet/intel/iavf.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
index 53d9d5829d69..e01f0adda3f6 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
@@ -692,7 +692,7 @@ queues: for each tc, <num queues>@<offset> (e.g. queues 16@0 16@16 assigns
 16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
 number of queues for all tcs is 64 or number of cores, whichever is lower.)
 
-hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new new hardware
+hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new hardware
 offload mode in mqprio that makes full use of the mqprio options, the
 TCs, the queue configurations, and the QoS parameters.
 
diff --git a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
index eb926c3bd4cd..5840569917f5 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
@@ -171,7 +171,7 @@ queues: for each tc, <num queues>@<offset> (e.g. queues 16@0 16@16 assigns
 16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
 number of queues for all tcs is 64 or number of cores, whichever is lower.)
 
-hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new new hardware
+hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new hardware
 offload mode in mqprio that makes full use of the mqprio options, the
 TCs, the queue configurations, and the QoS parameters.
 
-- 
2.48.1

