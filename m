Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E8606A694
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=3Ezpdc+C;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=hbyl4NuB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD87460778;
	Fri, 20 Nov 2026 21:01:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id alygYEj0CcJz; Fri, 20 Nov 2026 21:01:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AFD32607BC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795208513;
	b=KqYsmHMkzxuj+l1IJm8UeriodbiCafhg7pbl2W/fhcQ/6Hq/5DcHsM+hslj9sX8fEhFF
	 l3m+h5x6V4q36/9haZ7QumCsfm68SDjAA0hj2dNeJCxYYhTMM4ubtbxQ+I0uLIn0o7AU6
	 iMQoAWTvCcBNSBlYz8B7cFNc8KoEzXpdwJZWE6yK+AIc1xYHfMDmWfGub5zkiVNT9q7lM
	 W8wf34gFumWkaEz3VJqeSovlny17ztDSlrrG3XZC5FH3Kp7kSnvRyLgtq6SeY7+zeZudp
	 DpendDYcfJd5eukIZvmIlk19jtaqm5nr6DbS4uddrY7+trQNPMVXVTcSFWWV9fD0aIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795208513;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3blRyucdn1/HRvUCne6T2JCoz9R9O6w1N7Z8V5yWf70=;
	b=mofALTFNMi8wiZ5WvoTJZCkPod/cnfX0oUJ+Nk1TuN/EU5zh2RnrRbSgv8uq+Jq/g1bc
	 4A/CU3ZL1ptjRK/e05SKGY+Nkf4T74Vw/zDWVUmUvvraU/XT5NkmsA4LRQmDUoCNkbURa
	 tKdKEprs1/gwx57xGDuFdBqApxEzeLW2ftMCqp3wTQpOWJBxNiKP6SrRHd+GZQ4xZqeCd
	 bP7HD910O4ogxkoyy2/xEzCRhpo1KoaGGoPBa+SVLxHaQV7XT2AcXR7kdLJ4zG0g/j12r
	 ki/1sxymHrn3DAhRJ0qJO/FY5Ja33p3VBovP55dqpA3DwJmVST4RrWYlbzI8BjnbgCQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795208513;
	bh=3blRyucdn1/HRvUCne6T2JCoz9R9O6w1N7Z8V5yWf70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3Ezpdc+ChEoPRkzn/R0eIUXSqlmX9p7RUISqEJGOrUdk9YzyhEETVd5CJ6DIEtGkt
	 /8PlM1jT0LND9VcYHbYWuf8OPYgbogfi2c8FBLIy8vUk0H6c2FGWJ+Kjv4vXtzW/X8
	 BbmqH/IG7WwPTA12WYWMSzbL6d1A00G8u6HyBJYwOV5KcoXgMvD2Ps3dxudJSxAfBR
	 9hq50dD2va+HEVfXGvTRxZ0lLRdcGArpNnjmZXdaIaCTiVJdvd3CbYjAQPUJu76Blg
	 rzDdLHoBwU1xcDGGBSe7GnovpFuwAaMoUJPC7zwFaZyYLdPJTuSueN8lYsdZJV8Uow
	 nILeQ5zapn7hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFD32607BC;
	Fri, 20 Nov 2026 21:01:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C21E69CF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 21:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BBCA740AB0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 21:01:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0iY_t-BpFZQB for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 21:01:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9762740AE3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::206"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::206; helo=mout-b-206.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=hbyl4NuB
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org
 [IPv6:2001:67c:2050:102:465::206])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9762740AE3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 21:01:48 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jWSSS1GrVzXK;
 Fri, 20 Nov 2026 22:01:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795208504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3blRyucdn1/HRvUCne6T2JCoz9R9O6w1N7Z8V5yWf70=;
 b=hbyl4NuBeC/sXNsuHFvwgcsYPghc4rQfFuhyOsHbIE4VRR9+XQODpqa+3BUoa7byatJ6O9
 WOmmXEfD57jm2SNkY0T2XE0tcEdtu9CQn16rSIyyP1/T0SN50dAv5iJrhP0qdgg7c6pYyz
 IUscaQJPYMNohy67p/7B8LOCJhqgUXlkyZSEq3QJxzsz0VSdjgI/rZL0Pa2qOrSV1hCos4
 2L99d//zoFtAaNYad+WsdM4Nqf+L02/LxcndT1kaKrGmgOVRxxn1j2V0woVSHLpJfUoHft
 Wvqs7zU0vRAiU2N+PMN2llAGm92/psoS5rzEyBd/dScwrWm3fS5mudZmtjz49Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Janis Edvarts Lacis <janislacis06@gmail.com>,
 Kurt Kanzenbach <kurt@linutronix.de>, Joe Damato <joe@dama.to>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH net v4 3/4] igb: link queues to NAPIs under RTNL after runtime
 resume
Date: Fri, 20 Nov 2026 22:01:31 +0100
Message-ID: <20261120210134.133238-4-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120210134.133238-1-antonio@mandelbit.com>
References: <20261120210134.133238-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jWSSS1GrVzXK
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

__igb_open() links queues to NAPIs with netif_queue_set_napi(), which
requires RTNL, but RTNL isn't held when resuming from runtime suspend:
this triggers "RTNL: assertion failed".

Link them in __igb_open() only when RTNL is held, and from the work
item that sets the real queue counts on runtime resume. The links can't
be kept across a suspend, because __igb_shutdown() frees the q_vectors.
These are only freed while __IGB_DOWN is set, which is cleared once
they are allocated again, so the work item checks __IGB_DOWN under RTNL.

Tested with the 82576 emulated by QEMU.

Fixes: b75a1dea500f ("igb: Link queues to NAPI instances")
Cc: stable@vger.kernel.org # 6.16+
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v4: no changes
v3: link the NAPIs from the work item added by the previous patch, and
in __igb_open() whenever RTNL is held (also on system sleep resume);
dropped Joe's Reviewed-by, as the patch changed
v2: no code changes; mention the tested hardware

Note: igc has the same issue: __igc_open() also links queues to NAPIs
(igc_set_queue_napi()) on the RTNL-less runtime resume path. A fix will
follow separately once it has been tested on igc hardware.

 drivers/net/ethernet/intel/igb/igb_main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 2f51edc..6196d7a 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4126,8 +4126,18 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	return 0;
 }
 
+static void igb_link_queue_napis(struct igb_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_q_vectors; i++)
+		igb_set_queue_napi(adapter, i, &adapter->q_vector[i]->napi);
+}
+
 /* Some settings need RTNL, which isn't held when resuming from runtime
- * suspend: apply them from here instead, if the device is still up.
+ * suspend: apply them from here instead, if the device is still up. The
+ * q_vectors are only freed while __IGB_DOWN is set, which is cleared once
+ * they are allocated again, so checking it under RTNL is safe.
  */
 static void igb_rtnl_resume_task(struct work_struct *work)
 {
@@ -4142,6 +4152,7 @@ static void igb_rtnl_resume_task(struct work_struct *work)
 					      adapter->num_rx_queues))
 			netdev_err(adapter->netdev,
 				   "error setting real queue count\n");
+		igb_link_queue_napis(adapter);
 	}
 	rtnl_unlock();
 }
@@ -4220,7 +4231,8 @@ static int __igb_open(struct net_device *netdev, bool resuming,
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		napi = &adapter->q_vector[i]->napi;
 		napi_enable(napi);
-		igb_set_queue_napi(adapter, i, napi);
+		if (rtnl_held)
+			igb_set_queue_napi(adapter, i, napi);
 	}
 
 	/* Clear any pending interrupts. */
-- 
2.56.1

