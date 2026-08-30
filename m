Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D70C61DE2
	for <intel-wired-lan@archiver.kernel.org>; Sun, 30 Aug 2026 23:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95A4B80C66;
	Sun, 30 Aug 2026 23:22:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uxJdlDchTkZa; Sun, 30 Aug 2026 23:22:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788132142;
	bh=V0uXGJNgPYreSiDYBBxdQJQqH0DPau7askhrNGDyNQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=61xMfSN81GRbLBWiU6jQK4/5XCZtUCVIsfTbKOIbbC3FnIeuEasN2qDkU4Vcrz6G6
	 DU9cS7kjAh0139ATHJ2pwqoUA5xRMlWqUhR8cZYwpEHUMI9PGlzc9nXZFYvNiwkUSB
	 Jzpfp4NDupcHN8AmXqZ52umvF1j4AJPvx02vRaUJPGvDRy1JWECEBnUU/fEsNaaB8E
	 Cnwh6fyo1vh1IqHmt4XmnxpYxbG5CETrt81RWCxvq6tyP0aw9G1Bp29BeoFzc6/G+V
	 n9Iyu6+Y3DgiW65ntjKAwoKQ+VrrzBdO3BweUXtHgeXUJ7Rmjc7Xv8MTY0Y77U02tg
	 T28PI6+E4/OPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EB4880C49;
	Sun, 30 Aug 2026 23:22:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BC032AA
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12CBB40056
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i7781VVtSqdY for <intel-wired-lan@lists.osuosl.org>;
 Sun, 30 Aug 2026 23:22:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=nrOi/XXu
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54AA240050
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:20 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-81ecf499af9so33115197b3.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 16:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788132139; x=1788736939; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V0uXGJNgPYreSiDYBBxdQJQqH0DPau7askhrNGDyNQM=;
 b=nrOi/XXubKZo8OOVx8ByYrw90WSXBK94nziTQupWj7znVCrR3HDI5sSMFGoqqumB9N
 Exgb9u3X1TWHx2mYSVbirqRt5gZouNAaNK+CLixonrJjOZ3qPDr4qwtlS2zZ1oEsHk+y
 sJvqYuEtGUTn87fSAXl8OKTlrWr7iBMbCd7JebCatNeBdvR0IBE4Qd8CPdMyIsqzCCYs
 Gwjh0qRfjOEo0zxB1rjS0zFkR65M7q7cmbOaVoiNrmRqeQRv7v98kCrGHWTODN75jFSk
 Wu6TVBQ07n2OWtpMOaziZzunVFI3CG1s2Kn9n5FyTsmgVl0JpdHreByUxaryMwL19H85
 suFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788132139; x=1788736939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V0uXGJNgPYreSiDYBBxdQJQqH0DPau7askhrNGDyNQM=;
 b=FwtnM2CDqMrk2/O87rBkYhProiqB2RPGeABnqVJD/cVlJpihAj/XqNpPIRznxzALNp
 PQ1WcUjM1pEt8IDBjbCOGk6Z7uiVT+eGyAgs/ruxxQjL6n1nmA527mkMSlk/V8N1yIkP
 YdzRuAxyIJD4N6TZ1+8JSa0iyOv718+It4szjcuBoY9yAYXu7gtM/jHRD7vMzeZj4hd7
 P0rZXPUPuHSy+BDyrGYwCUwt9CWjZzqckqM1Kj+dPsZshh2LrSkn1xvOFzQuJy62NZ+t
 VVUgKnjxURGtSICpGox8Lk+felHUwFjmp56VNVGwP+zTbhl+GWI8Ov9ORGyOlI/nvbS6
 JjhQ==
X-Gm-Message-State: AFuF++n7kNnAKLRqqz+4xrIK+rT12DfGXyPOAeorGIVfI2KeXn531Hot
 n3hDQlcl4sCG2LSwmv/xk04ynNxi8LA6MIj1EGEVAn34ogxkFkMgQSatcOqAvE2gMfI=
X-Gm-Gg: AYBFou2HdzxHjdySr1vam+q6YoxZeZnUzMtH7VT8LQDcHDN/E9ezWfY6eMFsHtvvApg
 iC/MNzU6H3uyBO+v6zuUpE4k+PBIyEa0WTWZWgeNw7as+Zqfq7dkknQ+ba59yIvJZ7xubR7KHXO
 uUH+maZrDdhHYqVvAoFJF1nU5zQUCNVjgW28tgy6FLMCl8FurvFBLVPmCILV6iWWBNYuK/NUGnU
 /PYoUyg497AK3oF/PaPv55bi6ZOSO1Ka4gNVLZY3tz61XBqsl9T/fWX9GS8FsMSvgAH2jGRovCR
 mRt5BWtxdiO7J1Fx+3dhLDhLMQR96TyragxE4CshL6xCW2RrQ0lRjqT1h7WSskFkUzQdGFM2C/N
 yjgUXoZ2w2EHucA6+3iJjiqYqUv72RRaQHH+rJvepwlMIYKPTpKAvckNNJI4sVdBE42/sSQ/z7P
 YpJgJE/sE/Fv/VWOngc5ntmKTRWyrUSBbuy+FJ46Mu
X-Received: by 2002:a05:690c:6912:b0:858:d6fb:2b9f with SMTP id
 00721157ae682-85d660db315mr76627717b3.5.1788132138950; 
 Sun, 30 Aug 2026 16:22:18 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-85e677606aesm39025937b3.45.2026.08.30.16.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 16:22:18 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-next 1/8] e1000e: add jumbo Rx CRC stripping
Date: Sun, 30 Aug 2026 19:21:39 -0400
Message-ID: <20260830232146.36948-2-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830232146.36948-1-tactii@gmail.com>
References: <20260830232146.36948-1-tactii@gmail.com>
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

When the hardware is configured to not strip the FCS (CrcStripping=0),
the jumbo Rx path would deliver frames with the FCS still attached.
Follow the standard path's convention by stripping the FCS at EOP and
leaving it out of the byte count.

The jumbo path was omitted when the CrcStripping feature was added.
Since v3.3[1], the jumbo path has only been used where the page size is
over 16K, which practically rules out LOMs, BMC sideband, and the need
to leave FCS on frames. The bug is only reachable only by setting
CrcStripping=0 on a platform with nothing that needs it.

This change prepares for convergence of Rx onto the jumbo path in
following patches. The set of h/w routed through this path will expand
to include LOMs.

[1] Commit 79d4e9087a6e ("e1000e: disable Early Receive DMA on ICH LOMs")

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Fixes: eb7c3adb1ca9 ("e1000e: fix IPMI traffic")
Assisted-by: Claude:claude-5-fable
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..599600ad695c 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1631,13 +1631,23 @@ static bool e1000_clean_jumbo_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 			}
 		}
 
+		/* strip the Ethernet CRC; it may span fragments */
+		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
+		    !(netdev->features & NETIF_F_RXFCS))
+			pskb_trim(skb, skb->len - 4);
+
 		/* Receive Checksum Offload */
 		e1000_rx_checksum(adapter, staterr, skb);
 
 		e1000_rx_hash(netdev, rx_desc->wb.lower.hi_dword.rss, skb);
 
-		/* probably a little skewed due to removing CRC */
 		total_rx_bytes += skb->len;
+		/* If configured to store CRC, keep the FCS bytes out of the
+		 * total_rx_bytes counter
+		 */
+		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
+		    (netdev->features & NETIF_F_RXFCS))
+			total_rx_bytes -= 4;
 		total_rx_packets++;
 
 		/* eth type trans needs skb->data to point to something */
-- 
2.43.0

