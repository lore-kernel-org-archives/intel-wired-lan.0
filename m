Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01144CD5BB1
	for <intel-wired-lan@archiver.kernel.org>; Sat, 23 May 2026 06:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B134640E3D;
	Sat, 23 May 2026 06:23:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SF5giPlyReSh; Sat, 23 May 2026 06:23:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 960DC40E21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779517380;
	bh=hZxyXWmAPqKETQ9Pxse7c7KTUmJuXZ6q1hA+scXEGkw=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=jZ3e9QTSDY8LPJnsiCMe8fgyl43lQaW4vcj5lL/Upz5dM/bgnfs9UUSaLDl+4YP3B
	 udfgGWe19L9aLCIMwzB6v8QULg6Q00b18XTUkNAFgYzaOiT0WMI0RZ9Rg/QO11N8mB
	 7N3Q8tL+ylo3XvA5kE6Z+opllQbxXR/1yHV0Bk+cJVsjWKZNPIWeVzYH9om9asLN45
	 pdtD6xI601Mo10UjWZpDicvhhfKfVbXf0vHZ7vIlevxfS+NJgSWhZUe067vA3ZG9Sx
	 6VZfFxY5vC/VSSHAmyikoWZfH5UOdP+J8ZQbOw9M+LEG9JTXL7kq+XEma4OhcFM0C0
	 UmEwjUVnG3qaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 960DC40E21;
	Sat, 23 May 2026 06:23:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F3063265
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 May 2026 06:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D589D80F39
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 May 2026 06:22:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0tEoef4JkCwB for <intel-wired-lan@lists.osuosl.org>;
 Sat, 23 May 2026 06:22:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=103.117.158.93;
 helo=sender-pp-o93.zoho.in; envelope-from=linuxuser509@zohomail.in;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 69E1780F36
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69E1780F36
Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69E1780F36
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 May 2026 06:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779517336; cv=none; d=zohomail.in; s=zohoarc; 
 b=cLmloSO7/9qaf/EIqs3nwo4r9PBVjT6cm0F9/5BNP4Wr0fQyIY58I8lhNFB7uld86kBe7l5NXGfQbgJfjXQKwigaXw5xJo6WfuEdKYRSL5PRSfFwSOXEEswTKj9XKpbIsGVCcSKjeTku8ykBK8kCqME7gtzjVjSEcj9j4cNnsPw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in;
 s=zohoarc; t=1779517336;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hZxyXWmAPqKETQ9Pxse7c7KTUmJuXZ6q1hA+scXEGkw=; 
 b=YaCN5S5VnxnsSytg1KXsfqKkocJz1HpdQOeePPuJyu97pqm7hCkTtriE0VhMkWt8MlhaHJrsrBjpEe5/p8VnoXtNTHX4qbPbLyRbbCbbfjuBZKHPLPJeKmqDEaj0/440zev+q37+KoW7Aiqg/DEFC3gpqL+au0yxwZXpow49mxc=
ARC-Authentication-Results: i=1; mx.zohomail.in;
 dkim=pass  header.i=zohomail.in;
 spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
 dmarc=pass header.from=<linuxuser509@zohomail.in>
Received: from mail.zoho.in by mx.zoho.in
 with SMTP id 1779517334906443.1321783571458;
 Sat, 23 May 2026 11:52:14 +0530 (IST)
Received: from  [106.219.3.73] by mail.zoho.in
 with HTTP;Sat, 23 May 2026 11:52:14 +0530 (IST)
Date: Sat, 23 May 2026 11:52:14 +0530
To: "anthonylnguyen" <anthony.l.nguyen@intel.com>,
 "anthony.l.nguyen@intel.com" <przemyslaw.kitszel@intel.com>,
 "andrewnetdev" <andrew+netdev@lunn.ch>,
 "davem" <davem@davemloft.net>, "edumazet" <edumazet@google.com>,
 "kuba" <kuba@kernel.org>, "pabeni" <pabeni@redhat.com>
Cc: "intel-wired-lan" <intel-wired-lan@lists.osuosl.org>,
 "netdev" <netdev@vger.kernel.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19e537fa55c.56218d6244367.1765806925055659075@zohomail.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1779517336; 
 s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=hZxyXWmAPqKETQ9Pxse7c7KTUmJuXZ6q1hA+scXEGkw=;
 b=BqDN+IG7zKiXQ4cUFfzhoIPlpKxh6QAhbw7W2nhzJUSekkPyfmNXGip/TyeLi7oA
 ZdqStJw38bcV9Ks7UwiaQ/VqY8ScL0NCpr8a2FW8AOY0BGqlZdmQZ10gHN2mEDpshW9
 xbyUH6iW84cEZRD/m4qs9nLc1LvGz15JNcQmISps=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.in
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.in header.i=linuxuser509@zohomail.in
 header.a=rsa-sha256 header.s=zoho header.b=BqDN+IG7
Subject: [Intel-wired-lan] [PATCH net-next] e1000e: fix memory leak of
 msix_entries on MSI-X failure
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
From: Ashwin Gundarapu via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Ashwin Gundarapu <linuxuser509@zohomail.in>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Sat, 23 May 2026 11:49:40 +0530
Subject: [PATCH] e1000e: fix memory leak of msix_entries on MSI-X failure

When MSI-X initialization fails, the driver falls through to try
MSI or legacy interrupts. However, the msix_entries array allocated
earlier is not freed, causing a memory leak. Free it and set to
NULL before falling through to the MSI fallback path.

Found by code inspection.

Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 7ce0cc8ab8f4..1526069d7fc1 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2065,10 +2065,12 @@ void e1000e_set_interrupt_capability(struct e1000_adapter *adapter)
 							    a->num_vectors);
 				if (err > 0)
 					return;
-			}
-			/* MSI-X failed, so fall through and try MSI */
-			e_err("Failed to initialize MSI-X interrupts.  Falling back to MSI interrupts.\n");
-			e1000e_reset_interrupt_capability(adapter);
+                        }
+                        /* MSI-X failed, so fall through and try MSI */
+                        e_err("Failed to initialize MSI-X interrupts.  Falling back to MSI interrupts.\n");
+                        kfree(adapter->msix_entries);
+                        adapter->msix_entries = NULL;
+                        e1000e_reset_interrupt_capability(adapter);
 		}
 		adapter->int_mode = E1000E_INT_MODE_MSI;
 		fallthrough;
--
2.43.0


