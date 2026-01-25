Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581A4D19501
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Jan 2026 16:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18E1C815CA;
	Mon, 26 Jan 2026 16:30:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4X0-BG3FV0b7; Mon, 26 Jan 2026 16:30:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC29781567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769445049;
	bh=2mzwKobDfzzxE/liad/TFT+Aq3Oz06NV4T1E9rF19FU=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WNG67KOJJIMK8rTGAA2RjucfI7IWQFgBidu2gW3Ir3qznbMbr6hqV872JbHoLjhno
	 vb4xrqBn2GQkM+6a6ySmWnoGZxAEl85o+VS8CdfBLuoMx2UMGcxPmKej8Vj4Hs4rhk
	 tAGGpHQiUuVWVoUw1toO56Nj93qm51Hw68vNQOyMGnlagUE/4DRs9BLc+PgsEqfXgd
	 w9lq7mnQu9F+dfzyQ+d5TIHd/ToHwa1sGAH6v+d0QNzCPWfNoV7XYzatAwDa3huIdV
	 XnPWiYjeXG8fx3qeevkOp/+BsnpeG/dYECn18ef7S9HwYmuMq0FtiEZSurft3ozYh2
	 z3OPFyZDbsKhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC29781567;
	Mon, 26 Jan 2026 16:30:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AE6191CE
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Jan 2026 14:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A434E406C9
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Jan 2026 14:11:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iVUEl9J962ga for <intel-wired-lan@lists.osuosl.org>;
 Sun, 25 Jan 2026 14:11:45 +0000 (UTC)
X-Greylist: delayed 429 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 25 Jan 2026 14:11:43 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5DA73406C4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DA73406C4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.81;
 helo=cstnet.cn; envelope-from=lihaoxiang@isrc.iscas.ac.cn; receiver=<UNKNOWN> 
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DA73406C4
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Jan 2026 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [36.112.3.223])
 by APP-03 (Coremail) with SMTP id rQCowADH5t3oInZpYdesBg--.41622S2;
 Sun, 25 Jan 2026 22:04:24 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Date: Sun, 25 Jan 2026 22:04:23 +0800
Message-Id: <20260125140423.2077845-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADH5t3oInZpYdesBg--.41622S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr1fKF1ftrWUGryUWF1DGFg_yoW8Jr43pr
 4Y9398Cr18XrW5Ww4kXF4jgF13Ja1ftry8KFW3G3Z5uwn0qa17JF4xtFWYgry8ZrWxJanx
 JF4DAanxCF15J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
 kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
 67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
 CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
 MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
 VFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-Originating-IP: [36.112.3.223]
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiCQ8SE2l1qZiRMAACsJ
X-Mailman-Approved-At: Mon, 26 Jan 2026 16:30:48 +0000
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=isrc.iscas.ac.cn
Subject: [Intel-wired-lan] [PATCH] i40e: add an error handling path in
 i40e_xsk_pool_enable()
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

In i40e_xsk_pool_enable(), the memory allocated by
xsk_pool_dma_map() should be released if some error
occurs. Add an error handling path to do so.

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..92b853a75b28 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -108,23 +108,27 @@ static int i40e_xsk_pool_enable(struct i40e_vsi *vsi,
 	if (if_running) {
 		err = i40e_queue_pair_disable(vsi, qid);
 		if (err)
-			return err;
+			goto unmap;
 
 		err = i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], true);
 		if (err)
-			return err;
+			goto unmap;
 
 		err = i40e_queue_pair_enable(vsi, qid);
 		if (err)
-			return err;
+			goto unmap;
 
 		/* Kick start the NAPI context so that receiving will start */
 		err = i40e_xsk_wakeup(vsi->netdev, qid, XDP_WAKEUP_RX);
 		if (err)
-			return err;
+			goto unmap;
 	}
 
 	return 0;
+
+unmap:
+	xsk_pool_dma_unmap(pool, I40E_RX_DMA_ATTR);
+	return err;
 }
 
 /**
-- 
2.25.1

