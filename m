Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E9606A31B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=wSPCOxbB;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUPFHXye
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1EB040651;
	Mon, 26 Oct 2026 13:30:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eUyenlbMlURh; Mon, 26 Oct 2026 13:30:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A98A140661
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793021408;
	b=mvoJowIfxvi7SC3eUd7XFTeRuzjOjbogEKBrOgVvvXW1YCcuRhQHpHtkXVeQN2qTGmt3
	 vnB84wE+LFop5zTWdq54lg3No++8q8aTDxfUTh/zlBwsxWcaorHhRffwHRI7wB1cqz3k2
	 cmvuQ/S883zS+bhKwMXfxPRLqDiG2o6oB3/YBOJ16HQjRiITYM+nRrapUurRyRCOIcwFK
	 NfAeUJnRcgqQEmLqD3DSlwYYBO2CtTosU5UWBip48b0nWXNb+BlInlwkFoxPWJPYWX1KX
	 iEinwwJPRcKkq30ZjdEivVcgfLqhznKM2OdhTniO9BrCHLxQPDKcm1yJBuplOrOxtwQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793021408;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=zVxPNy/HRD3ex4hlOHgqAV8fJOoM7V3hV6C4OtP7Qa4=;
	b=gAd4QhuD0yeIEsj5qrJfecyEVn3GCSYPoGfpLnNsORHPxg5QUOQBvQ6Fuf17GkGKhM/A
	 oawV3wLa/ce6B9MpiNMjmON3YLWtAbPnO0dhIFC+Ay2ypnQsmZNHhX6gmcnNlEXXL9hhk
	 E2fBr/sLJNH4kkoi6/5KGYWf/KdVjf57MYvGTp+bjFC01Ntm6xzg2Im/XEbc5Go0+IBi1
	 n963C/m9MTyQiLfqc11a2BYsT2xe21VDGRo0+jTlDQpL6HAC6b0JDhAGqyv2kw+N6XIoQ
	 2cR4cqOUWFC3o/B2NSUkLwX8BiwswSB1i4yFJOqfr3JILdNufB/UWr3LyYMihTF+1rg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793021408;
	bh=zVxPNy/HRD3ex4hlOHgqAV8fJOoM7V3hV6C4OtP7Qa4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=wSPCOxbBXZ6KI+L5Ta39+3/75rbqkudW27BUzSmReDl9cZxgpgeKP6GMIXBDXYM9Y
	 ctUrE3W6V0L/3K8W84BVcjEtLCdRFiYqf1j/vsuBuY+nM/okaz6HJ02DOgcnLe5F8G
	 Nk09NYWAU22BC6LZ4J72ReuF3S36fM/rROWNn/ArLM/lmD0U3+sVe0lLkmlRTOepRX
	 KVLcbpK/t82BYQx/NkQP2Efoov4Lsnya5JeZzXVOW1/9cUELs/vtKIpSzqhUJNfbRM
	 xFUbZrbCJzz8DwyjhHuMiGPujydSR+bE9W+93b3LKNuhmgTjFRRS0W9+E4yM37vYfj
	 whRc54l54512g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A98A140661;
	Mon, 26 Oct 2026 13:30:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E7D81279
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 13:30:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CDDBC400F6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 13:30:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f0xZdvzegV2h for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 13:30:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 56F0C40062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793021406;
 b=SSeDW0wYiE9aP/uAP1d5IUNIB35sZfHId7YuyLi7MA0BzG1qcqlQ9Ip1xZ27xtpfrP0B
 NVI+3t/I6FgLucoTTt5PQN/A88io1b5hmvWlfoWiqPS4Bhw6Kg6pMUgznIAJc3KZJ8rc2
 5Jd0bVAnoflYUjaMm+0sIBbrUGiRb9ZAxV/XvIxt7m54lhn5c3eZdxzYzB4I6Wios745X
 32qO26WYUTJsMA7F+HuC7IiuMP8uL8q3uwuLu2c1pavIWiSbmbTkBXD2//1d8gS02qgyb
 kvlolH9TXGliKvRRd+DQTiu3mROTDYweM9tNIAbeBt8sAyS5eyLvChAnbtqCvsuqDrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793021406;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=zVxPNy/HRD3ex4hlOHgqAV8fJOoM7V3hV6C4OtP7Qa4=;
 b=QyibkXnGTuUg0V/yQRZ37QNdocsujh8DmtusnVB/3czlx09PAj8CuqE5q/Ga8BbQ4xOR
 roLadlWohQlM6wbSHUzbpPQfivu/e7LHOVQXRHlm/8x5iyGLoBACNVHTN7kIOjb3JFtdJ
 cqA2YhmrJGk7VEhryOU5rYoli+0vRGnf8SDw9sK/OmmRBRLfI3nZgAVyFGrdrqe4b+hqJ
 T+3WkFyfDUKaHYkB4t36GTofNzNZoHspdWqbmbOGMZTFbbMpviV/7ytBvyvQeDVclub4I
 F8qnWeuIERrET53MMc2CP/TXJnzKIDC0G8SEMeNnqabadlsKG9S9BDB4iKD+nRqLVUg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OUPFHXye; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+choiniere.vincent.hydroquebec.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OUPFHXye
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56F0C40062
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 13:30:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 791B2601FE;
 Mon, 26 Oct 2026 13:30:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793021403;
 b=NwUkvWlvlJAm8TWmWKWUM/qh3QRNleLj73VNVNDb6DH6/cnm/CFNMoPKuoqB20caJrPj
 YVmGkIKnI8jKdhZPDR9IrmtffMQRsEkDbDCBYRUf3ioYThe0TR/NQE8rFPCH8/Xgj0+GJ
 k/XDDBQ8m0F8uhy9uV85Pwd85jDwiud7FdUE8UBX9TWIDSq/kixUR83+WzqdINLoVZ+D5
 9hA5qsEMMx5KGY8rTugvg4hYZld1iuF+t2+zx9CcTVMNWmF1t6hw56lPDXQF6uWlFJE/u
 Iou89tmwWx5FF6HwQq6UDIZOSXSJKIy0t3Tefsmzg7n6ss4HbohvNZhjhJ2EaZKmJqw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793021403;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=zVxPNy/HRD3ex4hlOHgqAV8fJOoM7V3hV6C4OtP7Qa4=;
 b=Mlzew+tctid/wmKKmf4J+cCkS1mYH9PGbrh8m/60iAchn2VvF5JqrQqt4erYGBgUf1Ul
 2uX+SZuLXJA28CflezpJC3MHpS7mI9X16wFMdV+3F3dXHmnlUsSpYtEa1FElZa6riAgvW
 0efWRgm/7S1RUSZ113iATp9Ps9Bm9FA0akTIY/4CIPYXX5CPQzDneB89MI/sZF/XiSD2f
 J75SErFrQFxtvXN4lfbV7ob8aI2bgu0WfxHq/haVF2fz1zEzRHfsrQbUWnspeMcJv3mnc
 oWLqLy17wI4nsuYL4th9Mdd9yI7IbzaoRisPw6/CMLH8G3MEBX+QL1veswVvCGRApwA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id C56021F031E3;
 Mon, 26 Oct 2026 13:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793021403;
 bh=zVxPNy/HRD3ex4hlOHgqAV8fJOoM7V3hV6C4OtP7Qa4=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=OUPFHXye7iehfypmUCTdy3xAShReDaspmIhFKKDG7G1WpzWIEdKfb0MtLttGmwhX3
 4wxkmD/KayWRqTbvsxjP3UB6r7YED/jZjyN+riGTbVkGuqcMVPeEm7SMe0Li84/u3Z
 P0+HokofsHnw9pw1TzRYFIKXF/lADrQh0OhY+gdALDHRDNqA08MtjUgaWt6zKUVvWE
 x+p+Le3ZEMMPP4x9mrkHgxc1gUxLqNWr131MIOXwOEUDRW99n2p/wt8nfE6vuUP1qS
 xF5su2ilmouANk/XuB2lyPxHul9C+vKYooNnk/Ec04RgzckKajAKk376sQdO2W3tp/
 K3CZmZN0J06Dg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 3A11544D1D;
 Mon, 26 Oct 2026 13:30:00 +0000 (UTC)
From: Vincent Choiniere via B4 Relay
 <devnull+choiniere.vincent.hydroquebec.com@kernel.org>
Date: Mon, 26 Oct 2026 09:30:00 -0400
Subject: [PATCH net v2] ice: fix Tx hang dump using stale tx_buf[0].skb
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-ice-tx-hang-dump-v2-1-e2136ef2c5dc@hydroquebec.com>
X-B4-Tracking: v=1; b=H4sIANdV32oC/3WNwQ6CMBBEf4Xs2TW0QBVO/ofhAO0iawLFthAI4
 d8FPHucmTczK3hyTB6KaAVHE3u2/S7kJQLdVv2LkM2uQcZSiVgoZE0YZjwyNGM3IKWqTsmk98Q
 o2GuDo4bnc/IJPQUof6Yf6zfpcIwdWMs+WLecx5M44f8fk0CBiWniJstveZWJR7sYZz8j1aSv2
 nZQbtv2BSpF3KnNAAAA
X-Change-ID: 20261016-ice-tx-hang-dump-e46b4ed483d6
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Wojciech Drewek <wojciech.drewek@intel.com>, 
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Vincent Choiniere <choiniere.vincent@hydroquebec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793021400; l=12328;
 i=choiniere.vincent@hydroquebec.com; s=20261016;
 h=from:subject:message-id;
 bh=I7GEHSOCewXkNOi9K97E16dk0vuMi2DEXOuTLKY6QgQ=;
 b=5DIjrp3LvUGrWXTnHDk10SqGvffs7ztbkvNi/EHheO70a/aSX2gabthGubzjoyT2XTYVDvK0A
 5quIkv6iadMC2lqQ97SyIDiInQbqC6sZ3NfuowgnlUDDbh60oVuBEXX
X-Developer-Key: i=choiniere.vincent@hydroquebec.com; a=ed25519;
 pk=MctQE067DucsZOaNqb+sjY7aQ+urhztuURanagEW3+8=
X-Endpoint-Received: by B4 Relay for
 choiniere.vincent@hydroquebec.com/20261016 with auth_id=1210
X-Original-From: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: choiniere.vincent@hydroquebec.com
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vincent Choiniere <choiniere.vincent@hydroquebec.com>

ice_tx_hang_reporter_dump() always reads tx_ring->tx_buf[0].skb,
regardless of next_to_clean. The Tx cleanup path frees the skb and
marks the buffer empty without clearing the skb pointer, so slot 0 can
hold a stale pointer. A NULL check alone does not cover this, and
devlink_fmsg_dump_skb() can fault on the freed skb.

Using tx_buf[next_to_clean] alone does not fix the lifetime issues.
The dump runs from the service task without synchronization with Tx
cleanup or ring replacement:

- ice_clean_tx_irq() can free the skb at next_to_clean while the
  report is being prepared. It calls napi_consume_skb() before
  marking the buffer empty.
- The ring saved by ice_tx_timeout() can be replaced or freed before
  the service task runs. ethtool -G replaces the ring contents and
  frees tx_buf and desc, while ethtool -L can free whole rings.

Record the queue index, next_to_clean and next_to_use at timeout time.
Before reporting, take RTNL and check that the saved ring is still
one of the PF VSI Tx rings and that the VSI is up. Copy the
descriptors and IRQ name while the ring storage is protected against
replacement. If the ring cannot be used or the copy cannot be made,
report only the values recorded at timeout time.

Tx cleanup can still run while the ring state is copied, so do not
dereference the skb. Retain only its pointer value in the dump and
remove the skb contents.

Release RTNL before calling devlink_health_report(), which takes the
devlink instance lock. Build the dump from the copied data and free
the descriptor copy after reporting.

Observed on an E810 PF passed through to a KVM guest with Ubuntu
kernel 7.0.0-14 (PREEMPT_RT and a local scheduler patch): a delayed
queue IRQ led to a Tx timeout and a page fault in
devlink_fmsg_dump_skb():

 BUG: unable to handle page fault for address: 0000000004cd0c11
 Workqueue: ice ice_service_task [ice]
 RIP: devlink_fmsg_dump_skb+0x2d8/0x5d0
 Call Trace:
  ice_tx_hang_reporter_dump+0x1ce/0x210 [ice]
  devlink_health_do_dump+0xcc/0x190
  devlink_health_report+0x1d7/0x260
  ice_report_tx_hang+0x7d/0xa0 [ice]

Fixes: 2a82874a3b7b ("ice: add Tx hang devlink health reporter")
Link: https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
---
Changes in v2:
- Validate the saved ring under RTNL before dereferencing it from
  the service task, and restrict snapshots to the PF VSI while it
  is up (Sashiko).
- Check next_to_clean against count before indexing tx_buf, and
  copy the descriptors and IRQ name while ring replacement is
  excluded (Sashiko).
- Stop dereferencing the skb and remove its contents from the dump.
  Keep only its pointer value (Sashiko).
- Release RTNL before reporting to preserve the devlink instance
  lock ordering.
- Record the queue index and ring indices at timeout time as a
  fallback when a snapshot cannot be made.
- Drop Paul's Reviewed-by because the patch changed substantially.

v1:
https://lore.kernel.org/netdev/20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com/

Testing:
- Built ice.ko with x86_64 defconfig, CONFIG_ICE=m, GCC 12.2 and W=1.
  Ran sparse with C=2 (sparse git c464045). Neither reported warnings
  in the changed files.
- checkpatch --strict reported only an unknown Fixes commit because
  the local tree is a shallow clone.
- Runtime testing used an E810 PF passed through to a KVM guest with
  Ubuntu kernel 7.0.0-38 (PREEMPT_RT), KASAN, PROVE_LOCKING and
  DEBUG_ATOMIC_SLEEP.
- Forced Tx timeouts by starving one queue's IRQ thread. The watchdog
  fired after five seconds, the PF recovered, and the dump retained
  the v1 fields except for the skb contents.
- Used a test-only kernel patch to insert configurable delays before
  ice_report_tx_hang() or the dump callback. Racing ethtool commands
  were started when the instrumentation logged the delay.
- With v1 and the same instrumentation, shrinking the ring with
  ethtool -G tx 64 while next_to_clean was above 64 triggered a KASAN
  slab-out-of-bounds report. This was also reproduced on a non-RT
  kernel built from net. Racing ethtool -L combined 1 triggered a
  use-after-free followed by a general protection fault.
- With v2, ran 168 forced Tx timeouts, including 149 with concurrent
  ethtool -G (tx 64, 128 or 512) or ethtool -L combined 1, before and
  after the ring state was copied. No KASAN, lockdep or
  sleeping-in-atomic reports were observed. When the saved ring was
  no longer present, the dump contained only the timeout-time values.

Limitations:
- The same stress testing was not completed on a non-RT kernel,
  where Tx timeouts could not be forced reliably.
- Subfunction VSIs and XDP were not tested. Subfunction VSI rings
  are excluded from the snapshot because ice_sf_dev_remove() frees
  them without RTNL.
- This patch does not synchronize publication and consumption of
  tx_hang_buf between ice_tx_timeout() and the service task. A newer
  timeout may still be dropped or its fields mixed with an older
  event.

The original devlink_fmsg_dump_skb() crash was reproduced on Ubuntu
kernel 7.0.0-14 with PREEMPT_RT and a local scheduler patch. The
additional race reproductions above used test-only instrumentation.
The affected reporter code is also present in upstream net at
191aa4154.
---
 drivers/net/ethernet/intel/ice/devlink/health.c | 117 ++++++++++++++++++++----
 drivers/net/ethernet/intel/ice/devlink/health.h |   6 ++
 2 files changed, 107 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index 8e9a8a817..b9493ab47 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -382,7 +382,13 @@ struct ice_tx_hang_event {
 	u16 queue;
 	u16 next_to_clean;
 	u16 next_to_use;
-	struct ice_tx_ring *tx_ring;
+	/* the fields below are only valid if @desc is set */
+	char irq_name[ICE_INT_NAME_STR_LEN];
+	void *desc_ptr;
+	dma_addr_t dma;
+	void *desc;
+	u32 desc_size;
+	void *skb_ptr;	/* pointer value only, never dereferenced */
 };
 
 static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
@@ -390,12 +396,10 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 				     struct netlink_ext_ack *extack)
 {
 	struct ice_tx_hang_event *event = priv_ctx;
-	struct sk_buff *skb;
 
 	if (!event)
 		return 0;
 
-	skb = event->tx_ring->tx_buf->skb;
 	devlink_fmsg_obj_nest_start(fmsg);
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, head);
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, intr);
@@ -403,13 +407,14 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, queue);
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, next_to_clean);
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, next_to_use);
-	devlink_fmsg_put(fmsg, "irq-mapping", event->tx_ring->q_vector->name);
-	ice_fmsg_put_ptr(fmsg, "desc-ptr", event->tx_ring->desc);
-	ice_fmsg_put_ptr(fmsg, "dma-ptr", (void *)(long)event->tx_ring->dma);
-	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
-	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
-				     event->tx_ring->count * sizeof(struct ice_tx_desc));
-	devlink_fmsg_dump_skb(fmsg, skb);
+	if (event->desc) {
+		devlink_fmsg_put(fmsg, "irq-mapping", event->irq_name);
+		ice_fmsg_put_ptr(fmsg, "desc-ptr", event->desc_ptr);
+		ice_fmsg_put_ptr(fmsg, "dma-ptr", (void *)(long)event->dma);
+		ice_fmsg_put_ptr(fmsg, "skb-ptr", event->skb_ptr);
+		devlink_fmsg_binary_pair_put(fmsg, "desc", event->desc,
+					     event->desc_size);
+	}
 	devlink_fmsg_obj_nest_end(fmsg);
 
 	return 0;
@@ -424,24 +429,104 @@ void ice_prep_tx_hang_report(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
 	buf->vsi_num = vsi_num;
 	buf->head = head;
 	buf->intr = intr;
+	buf->queue = tx_ring->q_index;
+	buf->next_to_clean = tx_ring->next_to_clean;
+	buf->next_to_use = tx_ring->next_to_use;
+}
+
+/**
+ * ice_tx_hang_snapshot - copy the hung Tx ring state for the dump
+ * @pf: PF on which the Tx hang was detected
+ * @tx_ring: ring saved by ice_tx_timeout(), possibly stale
+ * @ev: event to fill in
+ *
+ * The saved ring may have been freed or replaced since the timeout (e.g. by
+ * ethtool -G or -L). Use it only if it is still one of the PF VSI Tx rings
+ * and the VSI is up: those rings are only replaced or freed under RTNL or
+ * from the service task, so with RTNL held every access below is to live
+ * memory. ice_clean_tx_irq() may still run and free the skb at
+ * next_to_clean at any time, so only the pointer value is recorded and the
+ * skb itself is never dereferenced.
+ */
+static void ice_tx_hang_snapshot(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
+				 struct ice_tx_hang_event *ev)
+{
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
+	struct ice_q_vector *q_vector;
+	struct ice_tx_buf *tx_buf;
+	unsigned int i;
+	u16 ntc, ntu;
+	void *desc;
+	u32 size;
+
+	ASSERT_RTNL();
+
+	if (!tx_ring || !vsi || !vsi->tx_rings ||
+	    test_bit(ICE_VSI_DOWN, vsi->state))
+		return;
+
+	ice_for_each_txq(vsi, i)
+		if (vsi->tx_rings[i] == tx_ring)
+			break;
+	if (i == vsi->num_txq)
+		return;
+
+	q_vector = tx_ring->q_vector;
+	if (!q_vector || !tx_ring->desc || !tx_ring->tx_buf || !tx_ring->count)
+		return;
+
+	size = tx_ring->count * sizeof(struct ice_tx_desc);
+	desc = kvmalloc(size, GFP_KERNEL);
+	if (!desc)
+		return;
+
+	ntc = READ_ONCE(tx_ring->next_to_clean);
+	ntu = READ_ONCE(tx_ring->next_to_use);
+
+	if (ntc < tx_ring->count) {
+		tx_buf = &tx_ring->tx_buf[ntc];
+		if (tx_buf->type == ICE_TX_BUF_SKB)
+			ev->skb_ptr = READ_ONCE(tx_buf->skb);
+
+		memcpy(desc, tx_ring->desc, size);
+		ev->next_to_clean = ntc;
+		ev->next_to_use = ntu;
+		strscpy(ev->irq_name, q_vector->name);
+		ev->desc_ptr = tx_ring->desc;
+		ev->dma = tx_ring->dma;
+		ev->desc_size = size;
+		ev->desc = desc;
+	}
+
+	if (!ev->desc)
+		kvfree(desc);
 }
 
 void ice_report_tx_hang(struct ice_pf *pf)
 {
 	struct ice_health_tx_hang_buf *buf = &pf->health_reporters.tx_hang_buf;
-	struct ice_tx_ring *tx_ring = buf->tx_ring;
-
 	struct ice_tx_hang_event ev = {
 		.head = buf->head,
 		.intr = buf->intr,
 		.vsi_num = buf->vsi_num,
-		.queue = tx_ring->q_index,
-		.next_to_clean = tx_ring->next_to_clean,
-		.next_to_use = tx_ring->next_to_use,
-		.tx_ring = tx_ring,
+		.queue = buf->queue,
+		.next_to_clean = buf->next_to_clean,
+		.next_to_use = buf->next_to_use,
 	};
 
+	if (!pf->health_reporters.tx_hang)
+		return;
+
+	rtnl_lock();
+	ice_tx_hang_snapshot(pf, buf->tx_ring, &ev);
+	rtnl_unlock();
+
+	/* devlink_health_report() takes the devlink instance lock, which nests
+	 * outside RTNL, so only report once RTNL has been released.
+	 */
 	ice_devlink_health_report(pf->health_reporters.tx_hang, "Tx hang", &ev);
+
+	kvfree(ev.desc);
 }
 
 static struct devlink_health_reporter *
diff --git a/drivers/net/ethernet/intel/ice/devlink/health.h b/drivers/net/ethernet/intel/ice/devlink/health.h
index 5edfc4d2a..508e4115d 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.h
+++ b/drivers/net/ethernet/intel/ice/devlink/health.h
@@ -37,6 +37,9 @@ enum ice_mdd_src {
  * @head: descriptor head
  * @intr: interrupt register value
  * @vsi_num: VSI owning the queue that the hang occurred on
+ * @queue: index of the queue that the hang occurred on
+ * @next_to_clean: next_to_clean of the ring when the hang was detected
+ * @next_to_use: next_to_use of the ring when the hang was detected
  * @fw_status: buffer for last received FW Status event
  * @port_status: buffer for last received Port Status event
  */
@@ -50,6 +53,9 @@ struct ice_health {
 		u32 head;
 		u32 intr;
 		u16 vsi_num;
+		u16 queue;
+		u16 next_to_clean;
+		u16 next_to_use;
 	);
 	struct ice_aqc_health_status_elem fw_status;
 	struct ice_aqc_health_status_elem port_status;

---
base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
change-id: 20261016-ice-tx-hang-dump-e46b4ed483d6


