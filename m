Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7907C79F82
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 15:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AE4A403B4;
	Fri,  4 Sep 2026 15:39:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pKLoY4stUEaB; Fri,  4 Sep 2026 15:39:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C751E40BFB
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788536366;
	b=gmqm8kXNrrjy+pLVNOqUn5J8/rNM1pSUId4ykgjoSiXDd77H0fBlAU6kOEDIWSNc+HTY
	 qFUVy+x2OGToM/a4SGB7q0Mu+NCZ3Mv+T8hBJ6ttaO9QZ37MuZdNgwYQWQ09OqApH2jnQ
	 7Rhsa1R3FR1c7Hwz5JUGngXpAb5vfVhmkEpmQT/Ph4tNyzcGrBWJcVOaZSh2tgtrt89iw
	 QIqBd+qfzvAW3EeCaxIOKmqrDvMFpnHGH+R4mAQTZCHZCKq/LmKB1GeCD1KknNoprZF5f
	 lhZp40cAWu+tiNYIIOVtWviKVbhWNKxoN6TZZ98nrVrh2OdrLQuT1NwauYpd11V+llA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788536366;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-UUID:X-CID-CACHE:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XePG7DlC6Yr6UhVch6vd1y5C2io9G7eRSfxVLvoNR70=;
	b=Ad/AvS815DC67izeHtgshoa4BXYvQRvSMCgxBo3Y2iSRUKe4Al7D1Hz8xAkQeWPYgfHm
	 uVnBMgdYvC5jV7O/et2lwIEhY/xP+w34vJtyat4CPapX6OLs0T7t6bRS11pTnQA5+hWGo
	 +RpLSbpdM9y7MDkTy+yyfF8xw8EO4DOt/ybzDnZhvR+dLxgI27IUXlZqGDwWpng66UssT
	 mAtReuedGnoDLQ1djhCDe8B9Zy6E0MfGXxD1OYUhxcFluk1lyp1s0gLhXclWPp2sx1hMd
	 ip1hTPGjUhMyjINMKWJLWGfMe6slfaqKVWgBjbdih5nKOKCMb+zNN1pplftpvyeHu8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788536366;
	bh=XePG7DlC6Yr6UhVch6vd1y5C2io9G7eRSfxVLvoNR70=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Pefwr2+EOywSos/qvc0N5yPdXEOEDcc94VQcWwwzqoK/EPww3ojf2JFM/oT1kFulo
	 6kuWC9TMWURT0pyCzPMJPsz8d+uSf70aK4qxFbiKpHtvUlsKwlexm8M330TEKkozou
	 3NTPlZWAoHUB4lib5plfYxeWD8vW7TF1DXFhtNtrw9lq67qlMa6bi31insz44PSaQl
	 /6V+pWAVDgVYJNrtBgIbzbp6ETmkoY83T1PkWbZL06yAzYGHFR6tQdAv3WYhod8KES
	 5EyhI1GVoWhYXXxVbHHT+M5vfAtfW/oEJUKi8rkpsNhhsIk0xenelP84aILgwEj/RL
	 KWdXwHn2RZmKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C751E40BFB;
	Fri,  4 Sep 2026 15:39:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BF3952FC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 09:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1472810E2
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 09:23:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IkVDVfPQvCen for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 09:23:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BBEBF81109
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788513829;
 b=q5//2naHOGDPKoSRevmKdaLjzAHGnHDdneYk2s6pm0qZwz5PUJIiKZ9jdc4X5Zgev4rR
 Fd4n5HQoPiUZY0wTUw8cEhDjJ0TfoEgzirCXFFyBK+euziQzT0xrKIf8Ehbe+I4/LKDtN
 FbR3m6FFbEhgBmC3MOcAcirPvEk4g14+6q454IIk3R6XQt5uDtsmnb4uoT7xXR75Ue6EO
 OEFXjYBXuvcKH1xgT0ffhO0bF86B+P71PYfjV8K9RgHGTnFx69VQCqizmRH9sqBQZsl9k
 HHTVtwrG/P/wrBfMAvQhK6LEn6J4w7saR5R6rjj5alVIo+g5plNjwKZdNGzK3LNK3XQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788513829;
 h=X-Greylist:Received-SPF:X-UUID:X-CID-CACHE:X-CID-P-RULE:X-CID-O-INFO:
 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=XePG7DlC6Yr6UhVch6vd1y5C2io9G7eRSfxVLvoNR70=;
 b=cfngnNY63QY9AcWXzoWEuZPjyp2YtJXOfjz8lnjR+2ejB0V8jPTCkbfjbZLp/rdrGmpo
 Pxln5PFL2sWyETTq6PTRQsffd1lL9e1h5/9tlkzkluBTHzu1BveSJC7IJkbz5Y3K5ajVZ
 6Pvlf29kJIW4zxXsIFi+gXwNk9rqFJQmxie5P5h21Shm6fNXmldu0q+0ycNJrVAiY5n2K
 SlwdfXAWTIRZPZc5UG9IeTwJLf8VD7pLkF0zwV96EaXjWqYayE7iissbft15Fn7dtJ6jM
 Egd6JQGjc7Frmd2LiJf2tfY1X1lhw8NWbv1thT1CUfKAdtTz/rj7h3Kkk7dBy+OwaEw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=kylinos.cn; 
 arc=none smtp.remote-ip=124.126.103.232
X-Greylist: delayed 306 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 04 Sep 2026 09:23:48 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kylinos.cn
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=124.126.103.232;
 helo=mailgw.kylinos.cn; envelope-from=zhangyunfei1@kylinos.cn;
 receiver=<UNKNOWN> 
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BBEBF81109
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 09:23:45 +0000 (UTC)
X-UUID: 986b2f36a84111f19a56ed5b684f684d-20260904
X-CID-CACHE: Type:Local,Time:202609041652+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:b423684e-fd62-4efe-b204-c4557f2ee3f3, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:b6ab868a27b7a9a21e041c51ec84c36b,
 BulkI
 D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
 5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
 A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 986b2f36a84111f19a56ed5b684f684d-20260904
X-User: zhangyunfei1@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zhangyunfei1@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1503395201; Fri, 04 Sep 2026 17:18:30 +0800
From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH iwl-net] idpf: fix NULL pointer dereference and memory leak in
 interrupt request
Date: Fri,  4 Sep 2026 17:18:27 +0800
Message-Id: <20260904091827.911123-1-zhangyunfei1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Sep 2026 15:39:23 +0000
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

The kasprintf() call in idpf_vport_intr_req_irq() can return NULL on
memory pressure, but the result is passed directly to request_irq()
without a NULL check. The IRQ core then stores this pointer as
action->name and dereferences it later from /proc/interrupts and
procfs, leading to a NULL pointer dereference.

Add a NULL check after kasprintf() and bail out with -ENOMEM.

Additionally, when request_irq() fails, request_threaded_irq() frees
the irqaction itself without taking ownership of the name string, so
the caller-allocated name is leaked. Free it on the error path only.
On the success path the name is owned by the irq action and released
later via kfree(free_irq(...)) in the cleanup loop, so it must not be
freed here.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Cc: stable@vger.kernel.org # 6.7
Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 24b91be25676..86dedf5c1c09 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4063,12 +4063,17 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 
 		name = kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name, if_name,
 				 vec_name, vector);
+		if (!name) {
+			err = -ENOMEM;
+			goto free_q_irqs;
+		}
 
 		err = request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
 				  name, q_vector);
 		if (err) {
 			netdev_err(vport->netdev,
 				   "Request_irq failed, error: %d\n", err);
+			kfree(name);
 			goto free_q_irqs;
 		}
 
-- 
2.25.1

