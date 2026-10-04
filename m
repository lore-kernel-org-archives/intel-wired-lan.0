Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B1FCA5FFF
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 15:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BFD9406E5;
	Mon,  5 Oct 2026 15:26:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cyNDtvrwmqB5; Mon,  5 Oct 2026 15:26:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4DC75406D9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791214003;
	b=V3ktCTU75hDyLskiWPaFUup096/wAFH29G/gftVByHRnkqp2VXWtf340kPAdJT9DowWN
	 pBZ1qlR47LvKtjGNVBTAPKh47dj2dVNsiQF7eiOI+OHpi6n6f7x3tKQAz+uhV0mnwnpxa
	 SkhwqQb1S7Y9epb7ccwkHlvFOBuGiiB8cNLh8x4TMMux8AGZ/jjSYMlGvWZXfBtDI1YbP
	 9a9xaEf0Q5RnX75yEtVmAjvNJA5RCgNFc886k2PcFhIAcqbOBVwMpzIzBEwklMbmSojmQ
	 tghBUZPNxiG1J/ajLtoocUoaJaSFGvuPq+Jm27jnFj0pJwrgdjvpr5YIb2ajeRWThbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791214003;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Bm-Milter-Handled:
	 X-Bm-Transport-Timestamp:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HSJmcL/8TwOYwYMibh267IG/qYmKIxLIV7KfoNTtMTk=;
	b=YrpmLXV5tv4a+PemocZZU1k4DsUaG5qOAppiChnTR2UfmzKryzIe98LwYI/5zlqmENEc
	 z/8jvZGAKR1x8dObCbXBtpzrmYmEsLfBg5I3gGuxOJRzhciztgcI6tR3YL/SkA9IzUioH
	 UHtb31rK5Tr1ZeLnU2D9Bvl2N8iGj8cFJhJGWICDtKszOJEjP7OKqRIyHy2uDbVS+rrMt
	 yfb6qAWIgYtZZ9iH6dvGccKrzLWfYSbMHMm9NYYI89CWbjrvpDELlAjGfAlqzbr3kdvrK
	 6ddjgK3+jwJbyJuhIM0Pl0uHDNOx1FoO7t289mM6iQa2ohQHcGQYyo/eUpYG9rBEYvw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=proxmox.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791214003;
	bh=HSJmcL/8TwOYwYMibh267IG/qYmKIxLIV7KfoNTtMTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cZ+V6UyRc5orlJAuXXJ27Vrgxy89NEgIys7m7N/USZ6RXYbAn3OhKGujy5TNV7fQI
	 mZKV6WGBxzMvd8QlB79LjmgGqJYtqR7NeOFmwzMohQNWkfRFJkzZUGCw2CXMJb+pTh
	 3aIsMlypxcjZsoEnscKznXYWsrW4Rr+kOJ2Y4XE60r6rV0c9NA9TPAwP++JVzL5i4N
	 CSJ023G8oeLGoo1aNF6E2w0vNxugXFsleIyz6DdzXlGt7QGGqT73CAoy07GcOcsANO
	 0XQ7VYNwFkh2ON9i2QYiOhMdAbDtoCSxM25nFqvfoQ6iZbB6IIjPPrKESZlsVlEjcI
	 /4KK6kGwrlNZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DC75406D9;
	Mon,  5 Oct 2026 15:26:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DF2D1498
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 19:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C52D7406C4
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 19:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B9JigcMwWyey for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Oct 2026 19:50:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 373A3406C3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791143458;
 b=stIti2qUhXKWc7jSE0MApnPnA22e9IxNsC3UpPYg3k1iCcGNBM2DFOgDygE4krGkifPc
 8aPCYZwl4UeRckcE4d2RfX9FDBD1YRpWAmroR3iyfrm6s2RFSgxCjsNCg0fALGVp+ijH2
 aGyF6YRBKmtpD3Tppbaw7O/tqVDAFTEPBqR4RNWJGBihEhd+Erp05EbH69gMK7BKSNfZO
 s1PsF7g3B9VCeCHGcGmAUMxSj+2Dx+KUdr3zaFPf+KLswV22PrVojoAcDBHzEVBK1HP05
 7nHEgNml7hAltfOXTlpRKHWbXcNTKJ5/e1ikjqcN1aHCkvq7zgDUMJtcmT2rTVhnPPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791143458;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
 bh=HSJmcL/8TwOYwYMibh267IG/qYmKIxLIV7KfoNTtMTk=;
 b=A43IalXM6EIPBuuQrmtm1UDPNG54fwoJTg0QvKUW6EVk/w5EWuBRbP4V0XEK26izukNj
 pEgV6wXAKBXA/y6amc/9I6Vh1R5ZpF/1YVFpr0SQHC92gssSkPArVIC0fp3J5TEDOC5DD
 X88aQmPY7lLn5qE1BuyqtJ/G3QlcviAJ4s88TgVUYCA2h2tr0IPqFzDLZCF2ZGa4PEdPL
 sFrPuaZ5jvrUghXTtH6KEaVNV4uB98Tl/g4yc0JWjAQpQ/6KtQqLQFgFNjxFAUl9HoIcu
 +CYlOVbbo964NA48sZ13Tle0rW/AR1w685hEJ35z40lYAQBtqyM6hwHXq9ifp0NR2bA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=proxmox.com; 
 arc=none smtp.remote-ip=94.136.29.106
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=94.136.29.106;
 helo=proxmox-new.maurer-it.com; envelope-from=t.lamprecht@proxmox.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=proxmox.com
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com
 [94.136.29.106])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 373A3406C3
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 19:50:56 +0000 (UTC)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9666347984;
 Sun, 04 Oct 2026 21:44:01 +0200 (CEST)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Don Skidmore <donald.c.skidmore@intel.com>,
 Radoslaw Tyl <radoslawx.tyl@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Viacheslav Tyryshkin <s@tyryshkin.me>,
 Melissa Romanus <melissa.romanus@proton.me>
Subject: [PATCH iwl-net 1/2] ixgbe: fix NULL pointer dereference on MDD event
 without VFs
Date: Sun,  4 Oct 2026 21:36:59 +0200
Message-ID: <20261004193704.2895700-2-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261004193704.2895700-1-t.lamprecht@proxmox.com>
References: <20261004193704.2895700-1-t.lamprecht@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791143040562
X-Mailman-Approved-At: Mon, 05 Oct 2026 15:25:30 +0000
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

ixgbe_check_mdd_event() treats every flagged pool as a VF: it clears
adapter->vfinfo[pool].clear_to_send and pings the pool's mailbox. But
PF queues can be flagged too, and ixgbe_msg_task() calls it on every
mailbox interrupt, also with SR-IOV disabled, where vfinfo is NULL. An
MDD event on a PF queue then crashes the host in interrupt context:

  ixgbe 0000:01:00.0: Malicious event on VF 0 tx:80000 rx:1
  BUG: kernel NULL pointer dereference, address: 000000000000004c
  RIP: 0010:ixgbe_check_mdd_event+0x124/0x160 [ixgbe]

With SR-IOV enabled, the PF pools follow the VF pools, so an event on
one of them writes past the end of vfinfo instead.

Keep releasing the queues of every flagged pool, as PF queues would
otherwise stay blocked, but only notify VFs. Check num_vfs under
vfs_lock, like ixgbe_msg_task() does, as SR-IOV disable frees vfinfo
after clearing num_vfs under that lock.

Fixes: da3ab95f9b06 ("ixgbe: check for MDD events")
Reported-by: Melissa Romanus <melissa.romanus@proton.me>
Closes: https://lore.kernel.org/netdev/bqzPMb-F5iRWe7S2DWkQDhsK8u9ZoIaK34sF2pHpAjP6WHFb70Weq3pc8ZIVUoIx2EbPHd6HLBzz1HHd3xb5rxRZ9F3w1L6TQAd87S18CPQ=@proton.me/
Reported-by: Viacheslav Tyryshkin <s@tyryshkin.me>
Closes: https://lore.kernel.org/all/abc23ed3-f194-4546-bf99-7152464b93e2@intel.com/
Link: https://bugzilla.proxmox.com/show_bug.cgi?id=7874
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 431d77da15a5f..7edb84986a312 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1444,6 +1444,7 @@ bool ixgbe_check_mdd_event(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	DECLARE_BITMAP(vf_bitmap, 64);
+	unsigned long flags;
 	bool ret = false;
 	int i;
 
@@ -1466,11 +1467,16 @@ bool ixgbe_check_mdd_event(struct ixgbe_adapter *adapter)
 
 			hw->mac.ops.restore_mdd_vf(hw, i);
 
-			/* get the VF to rebuild its queues */
-			adapter->vfinfo[i].clear_to_send = 0;
-			ping = IXGBE_PF_CONTROL_MSG |
-			       IXGBE_VT_MSGTYPE_CTS;
-			ixgbe_write_mbx(hw, &ping, 1, i);
+			/* indexes >= num_vfs are PF queues, no VF to notify */
+			spin_lock_irqsave(&adapter->vfs_lock, flags);
+			if (i < adapter->num_vfs) {
+				/* get the VF to rebuild its queues */
+				adapter->vfinfo[i].clear_to_send = 0;
+				ping = IXGBE_PF_CONTROL_MSG |
+				       IXGBE_VT_MSGTYPE_CTS;
+				ixgbe_write_mbx(hw, &ping, 1, i);
+			}
+			spin_unlock_irqrestore(&adapter->vfs_lock, flags);
 		}
 
 		ret = true;
-- 
2.47.3


