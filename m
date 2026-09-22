Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E95C98302
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 15:52:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1557040CA0;
	Tue, 22 Sep 2026 15:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wlSzuyb3qJmm; Tue, 22 Sep 2026 15:52:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 78E954052B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790092369;
	b=jft7jnmRbzZ10bEBk58BLqAKGKxTgVRSbddr0iWjVx2x6Kb8sW6yf+A39/vfo7Y794Ym
	 O9djyiwHXMQnzEezTLGoUpzbNo6k0MI18Dda3cecgR16S4Ux/D+TgOOL+cU9LI0cIHRbf
	 vm49sc3c3MbyxnR5ngwlCx/UGVyGX6vrUUOMhfRS6LrAS/+aUFEDDo3QJQU/o18h101O1
	 3hSvuX5KBrwjOwjhi0CRs+rd0KaS8r43fisROFzJK11nkOjly/5wcpUDgYDUWBzMflia6
	 ruXKi2/quzuTJbtAZEOJDlxMmBrXFlHM1gHydH3n2gLK+2WExKffshYXTqE1KNDshow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790092369;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nsDs23DcdYwkDSFn0tiJfOUbVshOv/zFLmietT3ibk8=;
	b=mI2vl+qyo/tJSNNd6vDvIS/yHQO6cAsn0kzaCaZ+Jgpq2EFjQOjlDPNDLQUXv7aKciH0
	 L4FdwsH8qlZ27yWXMm0gXjpGwpvPlqGb326A+jmfDrGHRO8rc5osgRtrLmtfHxHXTHhI7
	 ciDk9eePM3U2rjhXVuWmDVLgoZmb6UoLgceEyuSQispa907jWyIBrrR2Cg73IfjfGiroA
	 2eI1eBExF1v4J4e2UgTdDoeetc/b+fVTsw6NTXqIvqfLbxzLqJVdBcTRarNOhvAUzkQj/
	 uDBFG89Ayd6z4Pm0SrQGaGFGOhhdHNdO/8rjjxsXJhXgjdILVdyE7fEhEIGxKlQyXwg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790092369;
	bh=nsDs23DcdYwkDSFn0tiJfOUbVshOv/zFLmietT3ibk8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=z0/RLGy66QNgFX+QJWNT8ub2sAZYi3k2s/JswfZM8xjOpXDD9gRTeQQHyiq3NRrV8
	 fBf/ScWMsWIboumIwLbfKkPazv4X5poHoXvXErBdLwM92ui7V2fz6cWlbfhhjbEbAr
	 ikgX3Dvntn52LfRn079augMGKtkFIiEMVmrfNEYOFiK9Dv5GCEkg/orpZt2tq6jXLJ
	 uZyGnI2p6xPpeUzQog5Gj3FeDAHF7K46rFxWe66AHA3cVcMR/v1x8pOpVMu2Np8/ha
	 QHqU4YDzbY7TkptKWIk4tsshNDqebcPPP2MqVmI/Jy5Mk+y6bmdr5zDw8mVF+TicU9
	 yt/PYIypBnH2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78E954052B;
	Tue, 22 Sep 2026 15:52:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24A25352
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 15:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 167A380CF1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 15:52:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i5Xsijp6HnUq for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 15:52:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2D1EF80BCC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790092367;
 b=FbRvmNy8xSaa4tNng6DEqunEOiFtIKhmbgArBqiufhtgbhYQadL0gz6H0sWnx4VaK7EU
 vnnaiSqTqqMH+6/Jkg0e4pNvrI93Jti+eaJb8qj3errGEasaXsjUJ+NL1mtYJhV66AqYj
 3s1nAP9Fin5tOiVTUSRMKMySENfNNLBdQGsVegzos73oA9JsSIMJXdWlafDaqHjNJeVwe
 OQkqh1u+IWemrttWf/Aieb76UzLrnhKgdPeMYcXdLCKXkGEs7rejg3WXk4A9Fq5dKsUNk
 OyHCz7THXbcDcjmQjhZZsCEsYmlL8CK3OIya7rYpnR77esYwMzKi1Auy1W+975FC7GQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790092367;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=nsDs23DcdYwkDSFn0tiJfOUbVshOv/zFLmietT3ibk8=;
 b=ZVgb5Sj9ji2Axa74wreoj9XayRK1J8a6gsdP+bsWY61XLu33F4HKO+wxfIdnRF2dfQ4h
 qSu7c+Na0/RH46lHeZv7b8VDy0UkbK3Ap97/8LNkqjLjIyBNPPwYWOpfpPexzeJGdxX31
 +vEsIXVs177RX/uMxUm+WL15amFfumBpKHGqyPwhTBeJlMGUkxNmibNGpT9635HbRQl7k
 /EE6ekh5wsaLGA+seE3Q2n+Fia0CqoiAhQflJyrG4W0VonREGirCACpFVMA64ucd3Grty
 bfnMoERlObn25NRtSs/G6haT9XO26KPLIA9cZxd56gbKj1MfP4jhn/CY8Fl/4wlAIgw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="ZRbc/G/Q"; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=nsvatoslav515@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZRbc/G/Q
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D1EF80BCC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 15:52:45 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f55eff0so640071366b.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 08:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790092364; x=1790697164; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nsDs23DcdYwkDSFn0tiJfOUbVshOv/zFLmietT3ibk8=;
 b=ZRbc/G/QxZHRcBIzeYZw+N79NQ3dSGiW6KGRfmnfFdioRw+FNTzGH5v3b5qGwOa5qW
 xXU6sPsuFHfbQ2mq3/tAqb9Zr3SICMvUQh0zKEzzrGx0MtxF2miffdJqQnNjaQvH8MkY
 exwE2TywqDuhz5mjK1IzI11wZPnmDejYSAuanqnfjWEIw/uwkt6fSYF6ikWBCzHmi6BP
 48m5UB/dTe+a02I6p2WSp9RgnuKjap/1kwlAOmU/t/jbQDvdDOAy3ocp5gQUYeRhyBII
 j0xOFLq9kjNp2vMSmL+Uvllwlsizr4d/YdHxGbjF7Zs1R8EC0Lo9I7wuTOmAFoMVJqIh
 wAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790092364; x=1790697164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nsDs23DcdYwkDSFn0tiJfOUbVshOv/zFLmietT3ibk8=;
 b=Iey+KOInPImXGyidYMD1OiFTlNr94u2lZZ0cjRrpAyM+H/2lQSVhmQ5IktUPKDRJ5t
 EF4v6aTC25xtxltyWX5+5LJqc8WAIoCU727jNhoiAJ8Z2vniFraTWy+caIDnOjrtUbQ1
 IdXUA0fCjyodQ6d48a7PZPJIcmamCPlAXaOBMjAYCl/N2pdNvpUMHinsfHlTE4IzIBBT
 OV5DJdcYNjw6FfIwxBeB4dYvTX6Rhqjyqc6GJXSFCr5dkXceTlPjPKcrzBqzULEN1B1s
 v1afn0PyvHQ3A9XA+LxWPm2dz6w7m6pwlIl6lp5S579YKk9onzTcDllVpH8Ml8aMiAo2
 sXJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzF+dOiUwbXfCPtSwMyYt86aRWbYtyjX0jvYLI1Np2aBRkrtG41KIqQUyTlw0htkotfhkN1i76IJOumL7DCjzU=@lists.osuosl.org
X-Gm-Message-State: AFuF++l06yX1AgUH4TEthwL1ADbBxH4N7gKF9let5UNyl9GlOY+P34nU
 BA64VY1C/HVzduR0T6eIv8tbcU2CBO1vFgDEOTTn3Bcb2EW7seKX6XXf
X-Gm-Gg: AYBFou0WRridfsCPsNJJc9pYa6rygtwPoeSvjG6cxO0oQ7GLrnDdK4aflg4k15Nz605
 ETw7zFMMVJZYv+OsUNubfsN/vTS+APIhHYO3/bf9rSWQI/wE/aTFqr8a6Zy2RHDIj79xaRWCuC8
 CeKwOvrx22SGhM1a3JI6BzovOJSRNBbkJonUTReig7ET9TYCpf8xBvF0te77h+21jMLJWg2dRBg
 MHFzGa3b9WmmWRBkr75Geb/xVFSROTn53i3UW7LPa7lDyZjYFo2xq6NzANZICajYIEjyp67Zl+T
 tlthtM7TygZ0bxMwnqlOrhMUNegkJmjDuZUfjCA3AeP5z6oDiLUO7KNmZLXRAfY2SLba+THCiPk
 ErH478OlntqPyOWhURg9fZSDkYBzZ/ouR40cGysxdtbtCI+YxXQaOWZ2/Z433ynNUbupWJynJd7
 VdPDn6qfdr/Ai3hB7Jk+24xfN/EoqifQ4oWVHHwSBPAaY+nwuVMrEljJ5+vz/JMrxdNoKv4mS35
 /FBOJCbx8MasOvH
X-Received: by 2002:a17:906:c14e:b0:c29:5af0:3b44 with SMTP id
 a640c23a62f3a-c2a157fc26emr1145456766b.41.1790092363539; 
 Tue, 22 Sep 2026 08:52:43 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a9c628056sm109308666b.54.2026.09.22.08.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:52:43 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, ffainelli@freebox.fr, auke-jan.h.kok@intel.com,
 jgarzik@redhat.com, joe@perches.com, aleksandr.loktionov@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com,
 Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
Subject: [PATCH net v2] net: e1000: fix warning in iounmap on probe failure
Date: Tue, 22 Sep 2026 18:52:38 +0300
Message-ID: <20260922155238.67445-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

During a probe failure, the e1000 driver error handling path calls
iounmap() on hw->ce4100_gbe_mdio_base_virt and hw->hw_addr without
checking if they were previously mapped. This triggers a kernel warning
(WARN) rather than a fatal crash when passed an uninitialized pointer.

This issue was found by Syzbot. The exact kernel configuration (.config)
and the C reproducer used to trigger this warning are available on the
Syzbot dashboard.

Fix this by adding NULL checks before calling iounmap().

Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Fixes: 13acde8fffc0a ("e1000: cleanup CE4100 MDIO registers access")
Fixes: 1dc329180fe22 ("e1000: Use hw, er32, and ew32")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
v2:
  - Expanded commit message to answer reviewer questions (reproduction details)
  - Added appropriate Fixes tags
  - Added Reviewed-by tag from Aleksandr Loktionov

 drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..156903089fa6 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-	iounmap(hw->ce4100_gbe_mdio_base_virt);
-	iounmap(hw->hw_addr);
+	if (hw->ce4100_gbe_mdio_base_virt)
+		iounmap(hw->ce4100_gbe_mdio_base_virt);
+	if (hw->hw_addr)
+		iounmap(hw->hw_addr);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
 	free_netdev(netdev);
-- 
2.47.3

