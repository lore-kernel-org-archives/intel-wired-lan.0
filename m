Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465E2CA5FA2
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 15:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11F5280E57;
	Mon, 28 Sep 2026 15:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y95muG8Au6wd; Mon, 28 Sep 2026 15:13:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4230580F52
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608421;
	b=qN/TY+dn9gKMIZKV3Ad3tEmb6ewdAOyAtvTGeOoJS4Y6pk1D9aZ62/Qw+eJb6MVbZ0ta
	 I5Hos33lGbk4tmghnmRsaNwYiltMnE9OqDnfOuaUkvm9zZvEkCzxmYIqpPv0dDkMdm4Ch
	 K+OWZs5/uF/Ro9lPy07QLa2oTbyWJN9B2IB6V3IgvPFJY8waIPsI096QARV2URFBj26yA
	 Trs7GUCCwdTdhtFCUlH4uvHS2+Lwe0jsyXl8v0GdhBJihE4LAvlYh2bSNx1D3l8R7yAND
	 eegx7BE3bsdNn4vxwcA+i5lhuFcsx2TU9Tij45xrhhA/k6Yg+cpQQRAVncFAXSLt2Sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608421;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0HgIHPw9ARGoHTinz+bKOgaAgSveGSzCt2kWpBpCIbQ=;
	b=g7xFUGiKbU+q/9R81z/xHKK9c+0Q2fyiI2cIGueYnAMTdXJreGv7DqU07ghktbaUZk0n
	 by9fkvgaIFHuBOr5v2qm2iOFYo4pkfNQkKT7K/MzAF7SfMhMhqW8By6/PULa6rhJYB77U
	 7OyW8Ap67TJhCspXrWkfk5kHluPNHmDM0m/8BIyZn2tc/3adCJFmgvWxN97zl9dPVHsIb
	 RxEL2EIDDI7y2SR+hFhPfaM4/lFhGVCcIIT9t5VJsytWuHQPN4jqtv2kiP5WYykPoRE3Q
	 4iyTYjpthn9vUfBgFWhlae0FYs9Z13Pl5VrxSfUhal3HgnXAJRjKcHo5dHnou3RpqFw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790608421;
	bh=0HgIHPw9ARGoHTinz+bKOgaAgSveGSzCt2kWpBpCIbQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h8bn7NF5Lkjisz8gxNmfHpHd03q6Ucw4kI7lrMvr5E3zsxwWF/3EOIMouhxra5+Ye
	 1k7LsV6lAeU7a81uxEOFMYxJbTLCsIqiAiQDgzPfj2BM8ckj4xuOpjnpRwgJi/14hv
	 3HAPB3QnvWYCWuwRtCPWtbSVRKXSAKYyWy6TrYPWrpPu0V1yrGiqrhq/Ji9CE6vHRw
	 NoyavAx7FJk8kt02gtCdCY6i6NxRkHUidT0oCsZ4682SWKsDW4HOAOEZERIqEuVm62
	 xEtiAYaZeQgIPSZ03zjYr0SGrjImMtuC5AkHoJfAfw7ormGjKTlR4k9dJfsArO7ERG
	 DenminQ8rKYeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4230580F52;
	Mon, 28 Sep 2026 15:13:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CE3A3A0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 13:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 524A0401E9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 13:46:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 23YCNrGwLS62 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 13:46:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E6C76401C2
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790603200;
 b=FPE4DeiAKkpvH/kMc2eV4uiCSZVc6b+zLGaz5ZTtifarFfVgBfbZGUlPDJxmAKf5aKJQ
 RaESVkzo9VTVTq9hODJlvZCzytN3u3KXJ/Zk8kYVhwSwS8y4rTQPVeqGVVAyT+JIlBILy
 GLb5e5rByhldK+6xdFrKlSklCoWCJ9u+q+GZFMUWSgyab1tc7eE6cnJ+6pz0PmWWLpuAm
 ouThDQr5+Ux9kh57JF/UE2YfzZ6pgXFkq5k5QnW1383nlzFLBQ0jThVjSj+YE4nGh5vCp
 I1wo+804yYsvmLc2hp2RHP7bm7ROUm2swC27Qg6YvFEsOfUuEq8eooyiYOn9lGNW6ng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790603200;
 h=X-Greylist:Received-SPF:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
 X-HM-Spam-Status:DKIM-Signature;
 bh=0HgIHPw9ARGoHTinz+bKOgaAgSveGSzCt2kWpBpCIbQ=;
 b=Yb8CIpYG+qVzrkEPY42mINxpSXp4lomOASq9j/rlEByg7I3SdHFM2rQ8QfgI3PophXrT
 dWp6epl/KD0th/dYIGAJ1jYLEoK0LfD9v9PjsCGmkQEpf+2m5q1ZEo/0r0dQ79NYEMmPv
 P7yvbFxBORsFQuMFDhQ/46p2X0sncwQIxtO/b0dOCiVhQGuMVSe0krSMe1pTec6DnT9SU
 yxZLyMgYvsVz6yDR5xOwVvdmZcx8EJ3XFbcFVYGRa9KBSVGHF1aoDhz3j+DUvHjUhc1tj
 GLBf20Lq/jklN1Ty/5LZDXx/8BWqJkeE6735JPyfm6QXCl+h+ZDxoL0ZJvccXjGNl3g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=seu.edu.cn; 
 dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=gE7NhkHE; 
 arc=none smtp.remote-ip=45.254.49.198
X-Greylist: delayed 306 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 28 Sep 2026 13:46:36 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=gE7NhkHE
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.254.49.198;
 helo=mail-m49198.qiye.163.com; envelope-from=getshell@seu.edu.cn;
 receiver=<UNKNOWN> 
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6C76401C2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 13:46:34 +0000 (UTC)
Received: from LAPTOP-99KJFSET (unknown [36.153.54.109])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4f5d6f42c;
 Mon, 28 Sep 2026 21:41:21 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH net] net: e100: cancel timeout work during removal
Date: Mon, 28 Sep 2026 21:41:21 +0800
Message-ID: <20260928134121.826-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0e83fa8f803a1kunmc9b1dcc72001a2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGkgZVhkYQkxIQk8aHx5PQ1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VSktCWVdZFhoPEhUdFFlBWU9LSFVKS0hKT0
 hMVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=gE7NhkHEkUjcitEgszq6ti/yUKYCEBZOVyFbgo2dhZp/CUKKSVuHYIZrfJAIVY7+3g4t8xlaLIGrsu4D0Xz/6BxYDxWR05vuoG5tp4XoH3842J5KWZyYjk4DP49t+42SkOkgcLwRq/IpH3sDVSwrGGXMq8c9iqbRzOKPxojJwvc=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=0HgIHPw9ARGoHTinz+bKOgaAgSveGSzCt2kWpBpCIbQ=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Mon, 28 Sep 2026 15:13:34 +0000
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

Transmit timeout and command submission paths can queue tx_timeout_task.
The worker accesses the MMIO mapping and netdev private state, but
device removal releases both without draining a pending instance.

Cancel the work after unregister_netdev(), when the network stack can no
longer publish it and after any RTNL serialization used by the worker
has completed.

Fixes: 2acdb1e05c1a ("[PATCH] e100: Execute tx_timeout task outside interrupt context")
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/net/ethernet/intel/e100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 29960762e64a..710c2c30d9ed 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2988,6 +2988,7 @@ static void e100_remove(struct pci_dev *pdev)
 	if (netdev) {
 		struct nic *nic = netdev_priv(netdev);
 		unregister_netdev(netdev);
+		cancel_work_sync(&nic->tx_timeout_task);
 		e100_free(nic);
 		pci_iounmap(pdev, nic->csr);
 		dma_pool_destroy(nic->cbs_pool);
-- 
2.50.1.windows.1

