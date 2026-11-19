Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F360A2629
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=lIAB8zuM;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=iGPKbueC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BF3640977;
	Thu, 19 Nov 2026 14:04:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eBenlYH_Xcmd; Thu, 19 Nov 2026 14:04:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C4F840659
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795097070;
	b=oIR2u3hXAPSh6tMdTjbFP3/beYs54i4K1SSOXs8oRJ16GVQ1aRIn6qP9Cjcs5n95f72b
	 50UDVh8wiqlItTNU6ZRlM1yb87d+6GhPA8SIwj3AZBfpSYfTdye535qpGP8um+O9pNWuN
	 oW88OdQfNOIKj9Wur+kXj2QI7A/7Q2VX/tzupphkbX0t7TEAmVzRMqtDEV1STbrIDB0MI
	 H31LzA2mhQae620O369Y5C5JQWbCJ+v4vmLE+UM/LelyCb7MhqTuhZ0OaCGEy2jBk1KIl
	 lqajk5vrSI1I4Jf7e/DZfi4HSqtlhSEX5BK7ZPpazfjncCHQYw0pxHbn6v/ZwJza3Tw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795097070;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=t1Kvdj1fq2FNjCpeV0l+yuj6IJcjFbmYA/wXT7o/wU0=;
	b=L/uK0auaiNLTOGnc2PZvNiivi02OeCbzwKedDmwbNBt1++DyBA7S/KHZX/fjFYgzP/dM
	 lZdeu+wbm6fj/uZg47j48QDSVmAw/AszxojG+lrqmdRgyFz3MHOQCus/+2a4E4AbNQb7A
	 lHTq/VUgBJTlcDdfVsKS+WFuhtMQaxpwRkfN4fEcVkW8VvS6BxMv7m+NDPQ28P7TeGEKW
	 500t5RK8h2w3q1EGvTNbpKUPmzuieBjRKvezH11OlMsTFNpGQ0yczODuzbCci0lw78DX6
	 tnJO3CxKO5ofL5dycXFG2aQBvjpoPqTdqAPmPmvMcguKa544XWsfj7qa5LV00G+R0GQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795097070;
	bh=t1Kvdj1fq2FNjCpeV0l+yuj6IJcjFbmYA/wXT7o/wU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lIAB8zuMyUwqyO3QghlCWi4lmlQ1IXB8fk+3/QSDWB++tjjqY8V7SZsIRXp/lKL4z
	 aoEUTZxLotfUK5Uh6Udn2nUkRVGjElanQ2kCt+CrgLnCNYM5i8AB1M2Fz1bSA8h4RZ
	 OfUtCk0f6xUNUB7CX8QZBIQf5tyAcB8rIUMmZSCzqKHFkdUD31yFtWUrh06XCNX5Xl
	 K5pjg3//8Gir2/K3+fWIHWNsjXlzeHYc0uc6OUcu8t7ohg+RJDBcCGMqrwZ6w3dsqu
	 QJPBf+oorFf4t6hb+DoG6WvqxFx4QkBR5cGR7Za25sP2tJhh2L/QvlUAD6zd7/iUKt
	 3MS9aS2ZvPC5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C4F840659;
	Thu, 19 Nov 2026 14:04:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 036481C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD8996066D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MkiSmCnq7LTm for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 14:04:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 574EC605D6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=195.10.208.61
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.10.208.61;
 helo=mout-b-201.mailbox.org; envelope-from=antonio@mandelbit.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=iGPKbueC
Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [195.10.208.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 574EC605D6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:04:25 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4jVgFK6K6PzLm1Z;
 Thu, 19 Nov 2026 15:04:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795097061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t1Kvdj1fq2FNjCpeV0l+yuj6IJcjFbmYA/wXT7o/wU0=;
 b=iGPKbueCjY2wxQLML5h/lx9tPcHjwk+EuYiOdXDCKGgpttfCFS25fUfz3rHORa8UB07CZf
 Y0THPNUDDNg2cchEX6Y2dIZnkRYyofh/m2LztNsMvtRjjtazFPVcWjIA7tzVCJISrKpI/h
 GDiCK6b6jAOlooQvA+gqSPWyq8M4TevaITcLfzoeDBmq8hhJc1kHjTRpD6ci6uCkf2N46j
 X5rjXckHidhcyFUFPALDCm5ItHDqMKx5FUuK6opbfFU7yEvfm6j6hr7/pmQHfzKJADGvzv
 bT2GHRIwlp09e8YlDB0ntsv8036+hkeyylfCN2NZ0OqBaIbTQphCNTvGhJbYgQ==
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
Subject: [PATCH net v3 3/4] igb: link queues to NAPIs under RTNL after runtime
 resume
Date: Thu, 19 Nov 2026 15:04:09 +0100
Message-ID: <20261119140412.163202-4-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119140412.163202-1-antonio@mandelbit.com>
References: <20261119140412.163202-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jVgFK6K6PzLm1Z
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

