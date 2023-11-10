Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7348CC4332F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Nov 2023 08:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1A96F40182;
	Fri, 10 Nov 2023 08:12:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A96F40182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1699603941;
	bh=PVpgDXaxwKYmCaGQ+piIkSGhUZF2oPQoLHg6YoGsnrw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=wSMgioDOeMtcttV5LJ5uqTK9NcYBCA88g33AGfj/hMcCnKP32SCDMrEwctQRTZBC/
	 2nXD9yZ2QL90PqtQxGLXDBg9T1yCEaCVMPb0aggHsheVxaO620ROecCUnk3Noazu1Y
	 qGFS1E2eDvJzZPk8DGpskrUyjCGjRnlRgiSr7U9QsWPHry4ggi4by6yzoVpDWJTUPU
	 +qLoMC3rxh+Evrt/xqMwppgZzx49lYoo2SMXVwHGOjtbJ9MU5EnAV52k1AOQCBqKHX
	 6Am41CyfqpmEz/NhGeLdzPfUrxZrfkI8AI9DUG8K9Nk2jJZfD9FfOuEp8jb9MgRVRd
	 +OtJVMviOf5bg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DWTVSaCdfEc0; Fri, 10 Nov 2023 08:12:20 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id D5E8A403C9;
	Fri, 10 Nov 2023 08:12:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5E8A403C9
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 19DF11BF2FF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Nov 2023 08:12:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4AF841E2C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Nov 2023 08:12:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4AF841E2C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SSlRcQyXSaYi for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Nov 2023 08:12:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 337FD41DAA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Nov 2023 08:12:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 337FD41DAA
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-HYGfeWpsPHG_pxfz21skTg-1; Fri,
 10 Nov 2023 03:12:12 -0500
X-MC-Unique: HYGfeWpsPHG_pxfz21skTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D28111C06500;
 Fri, 10 Nov 2023 08:12:11 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0596F40C6EB9;
 Fri, 10 Nov 2023 08:12:09 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 10 Nov 2023 09:12:09 +0100
Message-ID: <20231110081209.189481-1-ivecera@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1699603936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3nK/HAcjQd19QuF6/CNQqVs85Tk5g0Fx2VwPP5v9z+I=;
 b=Tf6L/4/t/nRkNhVBaZrChz0F4astS8ysSu8U6H7/fqRNY96xyZEOGn67Ub3RzkeLfYXqvg
 hCA9VOPM8EwYvTsasyy4k3yGkt3SWqVpR16OLM4S52pvEjsG5a39V0eWtS9gth+YHDi5xR
 xmZiX9PqpHjwD+B0f3K5qMNaEblCi20=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tf6L/4/t
Subject: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix unexpected MFS warning
 message
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 open list <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Todd Fujinaka <todd.fujinaka@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set") added
a warning message that reports unexpected size of port's MFS (max
frame size) value. This message use for the port number local
variable 'i' that is wrong.
In i40e_probe() this 'i' variable is used only to iterate VSIs
to find FDIR VSI:

<code>
...
/* if FDIR VSI was set up, start it now */
        for (i = 0; i < pf->num_alloc_vsi; i++) {
                if (pf->vsi[i] && pf->vsi[i]->type == I40E_VSI_FDIR) {
                        i40e_vsi_open(pf->vsi[i]);
                        break;
                }
        }
...
</code>

So the warning message use for the port number indext of FDIR VSI
if this exists or pf->num_alloc_vsi if not.

Fix the message by using 'pf->hw.port' for the port number.

Fixes: 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e870afa0e401..c36535145a41 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16225,7 +16225,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	       I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
 	if (val < MAX_FRAME_SIZE_DEFAULT)
 		dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n",
-			 i, val);
+			 pf->hw.port, val);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
-- 
2.41.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
