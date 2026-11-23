Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA55606A327
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=1G3tzd1B;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=kQ9ePvJu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 937E4605F3;
	Mon, 23 Nov 2026 16:24:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 05QtHkPHjjul; Mon, 23 Nov 2026 16:24:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA35C60673
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795451068;
	b=YXB37vl3uj4EZsDR70YQHUx+pggtQ7ABw4bOiDTSDCZfzop/ftGUnB/PilHSe5aySM4a
	 sIlR0nldlduXc2jEhyFNUIIgSwCQmE3wmPVgWRKPRSf8h/eS8QOQNamMZ9AeyMI/nsmxw
	 /qgUIIn4DObk6BIf/6jx9QB53Jh/GjQLdofe94k8+aOcUdYMCbj0cv1TDYQOj+nTOLtOJ
	 Fc3QYGQ2ByKi2ApjNuuJTiR0FhhVmQD6zKLOr5LvhI+RyEErkKpOcd5Kz4CUgXAzKrlxk
	 NpznQFT5dR1tsipeglDdrMewFPt0NEvcFWaKuwt1DUgQGCzKERL/XJSnRjLTkJFef1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795451068;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kgQy8kI1WAfae3VeBA1HoTkyi/BnDiuRcwu0gm5ZbYo=;
	b=WLvqlxbpme6F4gJodFQ3Hsr7N9BT79NS1o5yq5w6CcO8QofqGlWuqzRijtwq2mCQWi3J
	 1Fwb4zhtgp4+e4lG2zE8gQQdrULRMwDLbfmyvExf4aKJvcuGkMyI4dFs+u/Y9mN51t0rR
	 XAgaAHNPDywSrXfO4rWGpfUr4gXJ4+ZeWb2cXMHWA50wZQUM4osZjHyntXy030yWjaLRu
	 c+1Pw3nqEMCIJD1tfUA3t/g+8Nv6gOUsQ1u+RZIs8I4qzPiHcJH9BKe7VNzAXoPdw3VB2
	 vpSVUoZWqFQA9ggDWFl0n6EJNcV645bvhVe7biyZJdhxbkssKg43YaJSCK9CceiJMUg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795451068;
	bh=kgQy8kI1WAfae3VeBA1HoTkyi/BnDiuRcwu0gm5ZbYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1G3tzd1BzSVeWnptle/dXWRN67h4WmAmh0PiOWztjiCmazLUkHK54MDwbICKEQs/3
	 4lMMed9yTlCMO+7Dnu834SbFMXrQKzGM85aisIjPKQmjGXzVx9fD7j1TDBP1TqdTNB
	 w+SO/Hl/BBfXQ8C7zwqYZLufb4+9RtWusszyCGcD1gGd6KzY5mQMaQCpPwXb9LZEgl
	 LQMPjGHDOIh61Pwcff+9qlplHg23Ax7aayAI9Ff7dW3u+1HkQj6UJKSGndzENM0uZS
	 0yeW3p4GpfwrPWo7BeIGzTQ1dMRINEG0EBuSpWJQqwPc6eCVZYnlPnDh/CVY1rFqms
	 hUBK4Z7DKVJtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA35C60673;
	Mon, 23 Nov 2026 16:24:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 873FC79D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78B7440654
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:01:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zkPJAdg1MjZf for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 10:01:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5F99640642
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
X-Greylist: delayed 330 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 23 Nov 2026 10:01:22 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=kQ9ePvJu
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F99640642
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 10:01:22 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jY1Xp4gJqzKnkf;
 Mon, 23 Nov 2026 10:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795427754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgQy8kI1WAfae3VeBA1HoTkyi/BnDiuRcwu0gm5ZbYo=;
 b=kQ9ePvJuOv4+8u5xfnd15Upcs/9of1EYYOnR1r4tnas5mGT01hAxFMWTnBxlS6vBsSNQhp
 0Jyvl3NpCfEXe+tzcwJqFFVTOGn+ZacG1x68wQWcFDCqWCZ2lK8s4MRqZCTgqw8HuZ8bzA
 Jc28baNLetkuXi7wMHh39xUvKOpQKfYbCeAjTQIB+FSY/lPJBwwC85kFxXDjgyjkgc2R3m
 Jvsfzol1NzL99UkwV3VuyaxkvJDbzc5618oFwqdyeBGgK23Thht/NK2ZxvwA9wosi2Wz0M
 0IeSnIBF4wd9aoJnDJXsxjgfSiO3L3pdwklSl+/1eiUvWVG6OjK8tpwUUhEx8A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Mon, 23 Nov 2026 10:55:19 +0100
Subject: [PATCH iwl-net 5/5] e1000: let dev_watchdog reset the adapter
 after a Tx hang
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-e1000e-tx-hang-v1-5-ecb4309942f1@beckhoff.com>
References: <20261123-e1000e-tx-hang-v1-0-ecb4309942f1@beckhoff.com>
In-Reply-To: <20261123-e1000e-tx-hang-v1-0-ecb4309942f1@beckhoff.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ertman <david.m.ertman@intel.com>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Helge Deller <deller@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795427747; l=1831;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=tAhjnxZ+dbvOeKDQs3b/TeBRTCKUgjX/tmh/fwujHm0=;
 b=jW9mhcUt1h/dP1vcV4WUmINwKwO6sAH882FpC4dHyMNKa8cwE9uOQtPQmQFNmu2rEmOPGKFAO
 uNn/aed9jA2BSYXXPHsn2AMHZl6nOp69jgYc6L9zzcxUYosANFLVNqe
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY1Xp4gJqzKnkf
X-Mailman-Approved-At: Mon, 23 Nov 2026 16:24:27 +0000
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

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Like e1000e, e1000 stops the queue on every Tx hang report and relies
on dev_watchdog() to reset the adapter. Its watchdog forces an
interrupt every two seconds, so the hang is reported every two seconds.
Since commit 95ecba62e2fd ("net: fix races in
netdev_tx_sent_queue()/dev_watchdog()") every stop also writes
trans_start, so the 5 s watchdog timeout never expires and the adapter
is never reset.

Stop the queue only if it isn't stopped yet.

Found by code inspection after the same problem in e1000e. Tested in
QEMU (e1000) with TCTL.EN cleared to stall Tx: without this change the
device never recovered, with it the watchdog reset it after about 10 s,
in 3 of 3 runs each. Not tested on hardware.

Fixes: 95ecba62e2fd ("net: fix races in netdev_tx_sent_queue()/dev_watchdog()")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7e279b739b8..4858c0a8c7b2 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3925,7 +3925,14 @@ static bool e1000_clean_tx_irq(struct e1000_adapter *adapter,
 				jiffies,
 				eop_desc->upper.fields.status);
 			e1000_dump(adapter);
-			netif_stop_queue(netdev);
+
+			/* The hang is reported again on every watchdog run,
+			 * but stop the queue only once: stopping it again
+			 * would also restart the Tx timeout, so dev_watchdog()
+			 * would never reset the adapter.
+			 */
+			if (!netif_queue_stopped(netdev))
+				netif_stop_queue(netdev);
 		}
 	}
 	adapter->total_tx_bytes += total_tx_bytes;

-- 
2.56.1

