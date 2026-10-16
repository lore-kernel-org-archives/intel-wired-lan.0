Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500FDCCA46C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Oct 2026 15:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 092F660AC3;
	Fri, 16 Oct 2026 15:43:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id olai7Axg_1sL; Fri, 16 Oct 2026 15:43:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1E9AA60AD7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792165428;
	b=EyONRotUQgUgEQ7/jv9vT27glecv89VMJT9kbwua4nZkpc7GbfasukV50M7f3D/+ocdK
	 KGA1rOG+GIY6jj6mspR5YAEWehtzUcB5fN1bEvdn+q4ILFZpAFTOuxA/xtaJz8wvH802N
	 I3GxJ7Y6DUrxwQYnXdZEJUKsjNJ8xPWx2S2P77+2GoqblbtBDiygDjM8L6A1BEIdoB01c
	 TLtHrJcTmR16pcADPlzuEHNcpwxB2o3GQGPr+BQXac0a3dYkSCHgH40tlp4Wl6BgsOpVU
	 wnlIde+Zvdb8PF2iY+gUxmyhwEp13LZpVkIWpYciw8Z5zmBdXJ5wuUBTBVj8W8dqf5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792165428;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=LiPKNagRdI0pnff8t3Ml726KenZ9IWsXjZ+hgXpicLY=;
	b=q8V+AZSP1qp4O+JRGYpNdUPsC9oGDESXsGed59Gc9Vy9iSZzzBqqrrgegYuAYy8YjwR4
	 iRZkaFZwNg+PlF1967VDMpab7SnoXOvUD9j7pgoMqDugnYOYuqd+/nD87hJ3aug16KX4c
	 RW8KNHx1B9Vw5MkEbVFkalEnHjb5+dCFardgr84dsUcjztH4uJlahJpqQeFCecp0izAMb
	 qnby+OOqZXaj1NM9FoK1ZWNJcjt7F6aRQKla4WDDEcFLfA3LBE+Lzs2ya/uZDHMsyzivR
	 kJvoiet4TkiKfKj2joChaRPIBLWceXYLD8KVml2z3XVeuZv/yyUW5LsvTnA0fJbsFDw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HhO4bKNA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792165428;
	bh=LiPKNagRdI0pnff8t3Ml726KenZ9IWsXjZ+hgXpicLY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=vgKlDBa02boRvhO1HlftT0UJxkpfYCVnKyS+zRK1DM2iLpqLSqe33sg0/eDvdKa7u
	 xa+97vHf/2lnSs40J30Xedz9F8ju2qzbSfALXZ4037k4w2Jf+GP8K8+GgKPdP4PiHQ
	 Tauo+QGIVOdVrqCP8EN26QtgUL4Xn/Fg6CPtfa2z592dpLBlf0gp0lWL3aFns1wYs9
	 c+VTpTk2dicywPXsG+BonZEf30vKXAaH25wR+FyBlFJncg4zSd/JyHau3J3c36Dmxe
	 D8/xojBjOrGV2EgBd92QwyqtxnP5BnlVaC83xDQ5CYf75lVhoauYRq4wZcSa4kMLUS
	 ggp/4H7HaO+0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E9AA60AD7;
	Fri, 16 Oct 2026 15:43:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 77D84255
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 13:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66ADB60801
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 13:08:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hEoeziVzcTMV for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Oct 2026 13:08:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 797B8607CE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792156087;
 b=WDg57R5hqaZm0xTJ2q/ntGNZaawUBdybRPROUSpDUjypSXW4g2ZyWU/LT6Wh5w5c9bMB
 ZhVHEE2DGkowzTlKzf9bkSdTnOhR7LZIzGRcdhGU2ujLj3xcWInRIH7lXzEjYS29hfj4x
 P5yyWYEANg/0ikwjpmBKJG+EmjZtpZ1Ee/j1rNg76eL22bnTVLj+ITptNY1wJMQSnRe2j
 XbfupG+Z56iDsfhGKa2waIermdyYz9Hs6uG042xANsx6krjotcSHcRYv13Cj031vaOJ3m
 svZWjRXGZYYJ/GHeRAJo7JsThKj122/vgcMoR5gvlNaHBpamEaSME2U8V61bVWhjabQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792156087;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=LiPKNagRdI0pnff8t3Ml726KenZ9IWsXjZ+hgXpicLY=;
 b=m2bR9qGfHxS2Ct41B5219o8M6WeATf9008mEGFOJpq0agFJlf5dIui0YlkBAfoL1JUbs
 UANjCEpDFi89xr8a2qP9nIop12BzjznuyUgqCmEJcuTS3MueJSfHjdbolQahRJqQvqkdK
 JvdZxiJC1iWRCwmwlTZswDKPCzHzOgW1Tb8nLGFLkGAWRJEYs4inA2gVOxvgLJpzZjqsf
 oX9x4NkL3pobxCOIoLHzBIf3FoOpxdyFG2U5zmBlz25M+Q3JIpzmokXoN6xNvAdvuIouk
 nPjqKyAdXLln+x3V8cyjSW/XiKH86VYblKxxwuuLpiAvOEW4ML589P9iGzxaswsN7QQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HhO4bKNA; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+choiniere.vincent.hydroquebec.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HhO4bKNA
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 797B8607CE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 13:08:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D07B42AA3;
 Fri, 16 Oct 2026 13:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34044C2BCFA;
 Fri, 16 Oct 2026 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792156086;
 bh=sYjJ0b0+DR9RbJ933aIA6Pe3CVrOOpnmRI/6zRSn1S0=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=HhO4bKNAtFPxYuifk1wT8CFwwmNJKF3TpdRmqlQs3pImRAfB5c0cVImkaM4r9zft9
 FciZAqMoQdyMeVg47531TiKv+OLE2f5eeWa1eSBeww7++4Ahsfodr/WrG8IKS4jzXb
 lVzflBrwwk8N+qVNE1MdCGDfDUU/KhqAIgUq9HMjtRKAC5T79U9wcYM3AylNqbnpEX
 Y8iUvAPH53LbaqKszpdSI/1KePPZ73VnQ5yUHJDg4lpgSWKJi6Jq9gwT8XgCy0lpll
 VbwEnwbzSohkWJ/ercfh1taYKwtu1dWY/bkoAKAwiOMuy1TRvIxHOpC762Z8cMNa6R
 c+G9PKqlHG5SA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEDFCC6B38;
 Fri, 16 Oct 2026 13:08:06 +0000 (UTC)
From: Vincent Choiniere via B4 Relay
 <devnull+choiniere.vincent.hydroquebec.com@kernel.org>
Date: Fri, 16 Oct 2026 09:08:06 -0400
Subject: [PATCH net] ice: fix Tx hang dump using stale tx_buf[0].skb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com>
X-B4-Tracking: v=1; b=H4sIALUh0moC/yWMQQrCMBREr1Jm7YemhiBeRVzYZFq/YCxJWgqld
 zfV5ZvhvQ2ZSZlxbTYkLpr1EyuYUwP/fMSRoqEyurZzpjVO1FPKKscnYX5PQut6y2Av5+BQtSl
 x0PWXvCGy4P4f89y/6MsRw75/AVz2cXJ5AAAA
X-Change-ID: 20261016-ice-tx-hang-dump-e46b4ed483d6
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Vincent Choiniere <choiniere.vincent@hydroquebec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792156085; l=3665;
 i=choiniere.vincent@hydroquebec.com; s=20261016;
 h=from:subject:message-id;
 bh=kt4dx1VrvDe36KXprpuSVG48M5IH9Jew3kkpwsyl//I=;
 b=rpz6gaUYmlu/qQeArQzXjGbdt7hmwbh5F2PXicMHbyd04KAmR7m0AivdHwD8NF8xUWPxaCq66
 vusrlXo13J0B8Xt4KnPmLoDzQSufiqzXYtu2F+evb6a33g6/z8dzX7W
X-Developer-Key: i=choiniere.vincent@hydroquebec.com; a=ed25519;
 pk=MctQE067DucsZOaNqb+sjY7aQ+urhztuURanagEW3+8=
X-Endpoint-Received: by B4 Relay for
 choiniere.vincent@hydroquebec.com/20261016 with auth_id=1210
X-Original-From: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
X-Mailman-Approved-At: Fri, 16 Oct 2026 15:43:47 +0000
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
Reply-To: choiniere.vincent@hydroquebec.com
Errors-To: intel-wired-lan-bounces@osuosl.org

From: Vincent Choiniere <choiniere.vincent@hydroquebec.com>

ice_tx_hang_reporter_dump() always reads tx_ring->tx_buf[0].skb,
regardless of next_to_clean. The Tx cleanup path frees the skb and
marks the buffer empty without clearing the skb pointer, so slot 0 can
hold a stale pointer. A NULL check alone does not cover this, and
devlink_fmsg_dump_skb() can fault on the freed skb.

Read tx_buf[next_to_clean] instead, use its skb only if the buffer type
is ICE_TX_BUF_SKB, and skip the skb dump otherwise.

Observed on an E810 PF passed through to a KVM guest (Ubuntu 7.0.0-14,
PREEMPT_RT, local scheduler patch): a delayed queue IRQ led to a Tx
timeout and a page fault in devlink_fmsg_dump_skb():

 BUG: unable to handle page fault for address: 0000000004cd0c11
 Workqueue: ice ice_service_task [ice]
 RIP: devlink_fmsg_dump_skb+0x2d8/0x5d0
 Call Trace:
  ice_tx_hang_reporter_dump+0x1ce/0x210 [ice]
  devlink_health_do_dump+0xcc/0x190
  devlink_health_report+0x1d7/0x260
  ice_report_tx_hang+0x7d/0xa0 [ice]

With this change and auto_dump enabled, starving a queue IRQ thread
reproduced the Tx timeout; the dump contained the test packet, no Oops
occurred and the PF recovered.

Fixes: 2a82874a3b7b ("ice: add Tx hang devlink health reporter")
Link: https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
---
This complements the NULL check in [1]. With only that check, a non-NULL
but stale tx_buf[0].skb is still dereferenced by devlink_fmsg_dump_skb().
I have only reproduced the crash on an Ubuntu 7.0.0-14 kernel with
PREEMPT_RT and a local scheduler patch, and the skb lifetime against
concurrent Tx cleanup still needs review. Feedback welcome.

In my case next_to_clean was 0xfc while the reporter read slot 0.
Upstream v7.0, v7.2 and current net main (191aa4154) all read
tx_buf[0].skb unconditionally. Before this change, recovery stayed
stuck until reboot.

[1] https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/
---
 drivers/net/ethernet/intel/ice/devlink/health.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index 8e9a8a817..059859c36 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -390,12 +390,15 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 				     struct netlink_ext_ack *extack)
 {
 	struct ice_tx_hang_event *event = priv_ctx;
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
+	struct ice_tx_buf *tx_buf;
 
 	if (!event)
 		return 0;
 
-	skb = event->tx_ring->tx_buf->skb;
+	tx_buf = &event->tx_ring->tx_buf[event->next_to_clean];
+	if (tx_buf->type == ICE_TX_BUF_SKB)
+		skb = tx_buf->skb;
 	devlink_fmsg_obj_nest_start(fmsg);
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, head);
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, intr);
@@ -409,7 +412,8 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
 	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
 				     event->tx_ring->count * sizeof(struct ice_tx_desc));
-	devlink_fmsg_dump_skb(fmsg, skb);
+	if (skb)
+		devlink_fmsg_dump_skb(fmsg, skb);
 	devlink_fmsg_obj_nest_end(fmsg);
 
 	return 0;

---
base-commit: 191aa41548b2d2b6af534a6d5cf84a552435c74c
change-id: 20261016-ice-tx-hang-dump-e46b4ed483d6

Best regards,
--  
Vincent Choiniere <choiniere.vincent@hydroquebec.com>


