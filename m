Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A663DC88E7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7607C6076D;
	Tue, 15 Sep 2026 17:18:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1waVW7yzVb_4; Tue, 15 Sep 2026 17:18:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D37BE60779
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492690;
	b=RzmSDFvXiv2uRR7lfe90H4lrWaL/OAXD6jgTDy3sXI3fryZNU2CuxLga1ouhSpFn//sf
	 WHpcUte5Ik50/33aGprB8mqgHAPdpAlHVhPCa3E+Mm5/Z0duBfzUuMoe1qC4Eq93vrb5A
	 EHWHU9xoSMJTUn9GHQzEDBORz62aO9zq+UoVi4zsTYU4w+kEMFwuRuL4nEMJSAEx/KbBJ
	 sqS9umpHKIJUG9yIO1y1gVobBKFQcDbKKNnRIy7W/nBfBCCWpNl5BzP9kllsyeRz7Vres
	 Y34IUn9saMKM9YGobw1pPrkSqt6+FyBWKxIz8ZlCQNA9997MPpe46y1knp16Y89+eKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492690;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u8PaP3KPXc1QUATAOA2VFUQ2Gy/Dv+8BB/twsZEIeAM=;
	b=BY8pQ+O7noVW8rKvZwQGkfToZ+TLkuP+hueGIj6xP/PcWh/oXkVMN6ocsMXsjTF9onGo
	 EmjrYoca9gXzCUMg1+7e0CtKJyoWJrtAwtKSRwKiNAl+vt8D5TEQHnN4GUg7ZJU/4r/nQ
	 S8KVHgCjMIbogYGxht/QrZ7xA5b04/xCMZdbvElmkbkCjOWP9tXhcMEXC7Hri/SMmY0ei
	 +Rd2sxcRQkHZcFIEsfzRsTA1KLtCTbkJzuEDeTWHKQkxHSUek7E2/q5j2J52DAh9Z6eEs
	 zzNmvQvnge9Ae/BfONZM/yEnC0jqYdhSQbs8ZcQtDXFvu0U18ASiYSe2lNCYOQ0QXFQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="GC/F7tjx";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492690;
	bh=u8PaP3KPXc1QUATAOA2VFUQ2Gy/Dv+8BB/twsZEIeAM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NMLqpb9tbiyJzYAfmK6gkFT4xw1ZZn7xYRtPpeYpS0lAlD72RRVd9djq0z8XN95pL
	 pPr3RDjlG8fBLZnyS4xwdmCkXD1TpJ5gXEi5/oiA1riJrCdlj9SidJJWJTOwEww0ps
	 fbqXF2xRqXWuGpE94d0EmZK0gkUZJJa6lvY1ywS8gM3U/2ISqisvsOXzTTJhhz9Nwg
	 NSHzdjkABa+HSgu5MKMDh0gVsJWKD0qs9j5+lVDI7Z0CO6uhmAgqK59+mw2KhXhWjV
	 57xUKEdgE8mzHe1oy5tsveUriloMqlkIa3kfUiWhiu8uC7kIM/4l2M/44muD/UKqYa
	 JzltzQgciPYcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D37BE60779;
	Tue, 15 Sep 2026 17:18:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D828493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:26:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3300F60760
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:26:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lfa0PxMJk9iA for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:26:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D5B2F605D7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789475215;
 b=LIXgoZ7cCk0Tnbh1Yw7COb2D5LVlVX1LBq2mFqg2fpurrhpuEKEI6iuwhThEKA6v72Oc
 yZwlYqIOLJnAFt4Fcp/Li7eOTGGAu1uQZzN25/SOey7H167pqjZ3lq0K9j+0meqiiLATs
 F4Niqik8pHOZNA63+6q0j0d5WvE7r6PZcY6NRIjhDuLjptc4LLXsVtLlhyVvcTDCGKsTJ
 SodYs/qQXZ7w1puK93NuRXgmcZqfVOOBhTRoesCpAUh3Rklih2FJxB45EAQ/tjnbeGFhp
 eSHB4XdWJMIVDpDV3Grljf/V06k2qZU53pXVPDnsOWZ4ttlWeeXC0FBHgXVmg+JwfEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789475215;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
 X-Mimecast-Originator:Content-Transfer-Encoding:content-type;
 bh=u8PaP3KPXc1QUATAOA2VFUQ2Gy/Dv+8BB/twsZEIeAM=;
 b=ATYOLU5I6T7f7kMQaq1C3FldMcuvYDPcVXy3EklTWNhG46HEKrDMn/PGzpYczawnVs8a
 GQ1hqtUAdJ22/R9n9baHS7DJuDpZjJj5lcilHQkUAgCvw4f4O+BelgIOm7spnNj6z8l3V
 BjAmEGEVdnZmZgpU7kIkbcscnOhDNG5+KrPRBIZaJ/HD2rO6jC1FhgyTzDvQmzaAyNuZ2
 p0Rk29lcCvvxq3BWUdPDXG0Hb286kMybXFFEskgqpL8O+vG3U6NjtNh/vItvRTpMflFof
 JTvcj/e6wBAWqfLK5DbGwJJo8r8xp6jX/KTQ6OFGTOYXMItS+bcJ9pMADjeqQj+fZkA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="GC/F7tjx"; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=fballuch@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GC/F7tjx
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5B2F605D7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789475212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u8PaP3KPXc1QUATAOA2VFUQ2Gy/Dv+8BB/twsZEIeAM=;
 b=GC/F7tjx55zRElXvZzHPyjcN+PLd3njcT+kkB4BEnPlqof8eDB8aFUbiJMP6ey3LiOav1k
 pN9hbMdXJsswIpL3ZHNB2+c0n5PTjd82bgzXho6gvT/eU8JQGxovmgpIqASHDPbFdpBLXl
 JXYhfw+G9o2cOWlVK6q1giRn0hN/GhU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-mnOb_VfGPnCqFbFRTKzerw-1; Tue,
 15 Sep 2026 08:26:47 -0400
X-MC-Unique: mnOb_VfGPnCqFbFRTKzerw-1
X-Mimecast-MFC-AGG-ID: mnOb_VfGPnCqFbFRTKzerw_1789475205
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D267195398D; Tue, 15 Sep 2026 12:26:45 +0000 (UTC)
Received: from fballuch-thinkpadx1carbongen13.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5879C3003EEE; Tue, 15 Sep 2026 12:26:42 +0000 (UTC)
From: Filip Balluch <fballuch@redhat.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Filip Balluch <fballuch@redhat.com>
Subject: [PATCH] e1000e: rename init/exit module functions to avoid confusion
 with e1000
Date: Tue, 15 Sep 2026 14:26:38 +0200
Message-ID: <20260915122639.64936-1-fballuch@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 3ldjGK03UL8Mq7uRZiIhiLqqvyycaefHUMcKoOVJT5g_1789475205
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Tue, 15 Sep 2026 17:17:36 +0000
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

The e1000e driver uses e1000_init_module and e1000_exit_module as its
module init/exit function names, which are identical to those used by the
older e1000 driver. Rename them to e1000e_init_module and
e1000e_exit_module to clearly distinguish e1000e from the legacy e1000
driver.

Signed-off-by: Filip Balluch <fballuch@redhat.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..2a4cf75bce34 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -8203,31 +8203,31 @@ static struct pci_driver e1000_driver = {
 };
 
 /**
- * e1000_init_module - Driver Registration Routine
+ * e1000e_init_module - Driver Registration Routine
  *
- * e1000_init_module is the first routine called when the driver is
+ * e1000e_init_module is the first routine called when the driver is
  * loaded. All it does is register with the PCI subsystem.
  **/
-static int __init e1000_init_module(void)
+static int __init e1000e_init_module(void)
 {
 	pr_info("Intel(R) PRO/1000 Network Driver\n");
 	pr_info("Copyright(c) 1999 - 2015 Intel Corporation.\n");
 
 	return pci_register_driver(&e1000_driver);
 }
-module_init(e1000_init_module);
+module_init(e1000e_init_module);
 
 /**
- * e1000_exit_module - Driver Exit Cleanup Routine
+ * e1000e_exit_module - Driver Exit Cleanup Routine
  *
- * e1000_exit_module is called just before the driver is removed
+ * e1000e_exit_module is called just before the driver is removed
  * from memory.
  **/
-static void __exit e1000_exit_module(void)
+static void __exit e1000e_exit_module(void)
 {
 	pci_unregister_driver(&e1000_driver);
 }
-module_exit(e1000_exit_module);
+module_exit(e1000e_exit_module);
 
 MODULE_DESCRIPTION("Intel(R) PRO/1000 Network Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.55.0

