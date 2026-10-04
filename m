Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B293BCA5FF0
	for <intel-wired-lan@archiver.kernel.org>; Sun,  4 Oct 2026 15:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 690E860607;
	Sun,  4 Oct 2026 15:29:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O3ZZq3EQcLFz; Sun,  4 Oct 2026 15:29:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B43656060C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791127750;
	b=ZbhI2NDcuk8iHL8kLZEtfQdI5NH10gyJQZvwBPYg3XSevHO93WhWJnt7fSEsoTykFp9Y
	 7G5IjhPkizAk08PPI1cM7Axp1dUhVIXhxjfWBdfNg4tApXC9NhLhl+p2a60RYo8aoMOBS
	 Gf8TJLVP6+UUFRvFywCPcZYpGAhCDW30ALEP4+HT1q9GX5BTuVDax1lmjYcbcAwhBFxaC
	 YoGytQANuceqoq9bkTY5sAThfWFAM08b8+Nplt/A7nE03gOYvYSxPCg5Wte8OHibLxxj/
	 +lMbIa16ZKiapMzjGXHkjV6Y29Svw6dBC2F2cgIEnbqqAdFlic54Gkf9jCbakqaK57A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791127750;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CjuVkIYnaqcKfLZ8gNPpy7PzsEJhC75OnnV9vKlbU3I=;
	b=KqDguY8a5A8c7h2qz5Gv9xjpXuISvgGgD6TOcCFPCq/iCtroBGfemVVPBl5TafAU/W/L
	 vNMNjvVosg8Zn16xe0jN5XJOVREA8vdJcNEE+miI6TP0MdsHdui5faRk50rcX6m7YSm2X
	 6it9bwPfHIwPiyFP2r4l8drVNBvHVn4o9DLDsvSuHux5WnlBhwAyjgZWOegVGFLipzsJC
	 cNKKQVbRclZZw4qX3V+8JXhYRW61WMWygJ+oqTwpjalOU3JSgnonCCvS8weo8b2vcO3B9
	 rppIuvaw74xWQ/euhIqkkZYR0lSpNhVW8HLG++D68tit3ki6ylO5Wrv/rUliXmkbatQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791127750;
	bh=CjuVkIYnaqcKfLZ8gNPpy7PzsEJhC75OnnV9vKlbU3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JvxaU3EiPYK/aVF1mjXbE0lsMg74qKv76VO47Edjio9RWCizX79Whoqml7Ivm7+1Z
	 79RMItWxGz71jzUtylDsBJ9SNiLVntDiZR7IAnW4IdcQvFqO9P0Ay+5azJCVCgRgpQ
	 rR4gOC3JTcFfAmCiKiIwf7hNGpcRD2Ov1QksDiXrxKFZ8gTZ9K2tDcsjzCRaBXgCS4
	 fHk013XIe2ivnQGqVH1GMI/faKH+9N4cYPgiVdLgYGqMhSwms07ixALAB4KfhS+CU+
	 lzSui93IHaCSoG38J7fKTf6VzvUI+zYIOwcwcNI8loYQ0X3j7NLzNuicv2CSF208wy
	 es3FPvI7YzMmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B43656060C;
	Sun,  4 Oct 2026 15:29:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B75D263
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 15:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 315E44007E
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 15:29:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZS-yD2vJKKem for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Oct 2026 15:29:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4087240049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791127748;
 b=Md7F1fECAP4D4QurWBflym0CYqE6HYa98bdTzPN9KHKZehcqx217n9cTbS9Xe8wnVSL3
 kIqd9F6QdlgYsqPTGsQ2AMfZDT5E48M9TaM55TkIRaKRAIt21NcV3lI+LILcvTlT0MixK
 jiZo60JKeJoVVe7VYMpN73WAFL1pOpMrRdZM9rsO7POu+9bcQAdXRbXMb8eWqaOf//jNf
 aVpYE1ordN4FUkRHmiUEIkG0bsWyg5l8NGrOX5MQv6vLinM+2SBk34wTuVU65DiVzsXWs
 RMckMLek6QT5NPLQ1P8TzCsmSExgPwIzJvMI7PWALG+7+olMbqr/V8TS5npLFampzHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791127748;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=CjuVkIYnaqcKfLZ8gNPpy7PzsEJhC75OnnV9vKlbU3I=;
 b=QvjWr6/YXF8I2OZqdA8/7gN9XGV4fMNXeFWBfhEgS1WpPEu//yRnDFa3lQb3fS6cKQco
 ijbr2qKM0+eDkyBUt0xV6mLPWeu1fhu2v7frdNfYZBH312bCv1YVSkd4O9lMS0VKB590l
 ss3L8jxdSQ6bS69dpl7b3vFEwLZ0LPsC+PbELoQI7cDRp113B/X7iC1oyqq+hekBFilln
 4GxVCCtWaUpEAlOeZ/SpQEoujRzUv1HAOX/2suOqxLqp9cD7fCFnLPxvsORpuZXTxgLUj
 OZ8Q1hOVeBlpwH3ETlv+820wFLdGpwrTaTRJekzRqwdmiBTzIKYzVLu1n/SBhPa2GYw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="NPEYS/CM"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=b2rancourt@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NPEYS/CM
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4087240049
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 15:29:07 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so7052275e9.2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 04 Oct 2026 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791127746; x=1791732546; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CjuVkIYnaqcKfLZ8gNPpy7PzsEJhC75OnnV9vKlbU3I=;
 b=NPEYS/CMljD8z1cOgTRSANLYFFh+pjU303nh/ti7FC/CewvPEZ4FrZEGy8ikBzcdiq
 IfuxvF5jC0NXC9uj3TFrOoRBAt5HALmryN6u+2YE5BXg7EYfP5Bh1vfobjy3uV6isgi2
 ub0wBjiHVOrfYhRjRE/e6f8g+Hos37umz1SH8w2YjQ/DTqajBE4i6JR+1OEXXmT0RZ8v
 Ji0GB7unN8fkG+pihnciC9+J/1S1ghSKqgWLET0F/LQSEldCzA2YCgKLKQNmWnI+kV8P
 mpiEavzY/ii0WILvXBGs4U4ejwi34gKnRb8/NXmniomnYFvaQbLB6xaqCMzonCMc7V2m
 YOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791127746; x=1791732546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CjuVkIYnaqcKfLZ8gNPpy7PzsEJhC75OnnV9vKlbU3I=;
 b=YdfwIY8wjvAp2HdMt2qRr3nuWAoKJucU6mDtp+pYgD/vpnrfg91379hoAjNSOGULJK
 oWk4n30734sUAkysj9H/XZ2sR5qPy04V5lOtLeCNDiXFX5HygtAXbDYb/ndSOyeyHGnG
 leeqO54gn56ssR2/MtrELe1YZV5bj5zGLiXLFDyaAOLP/sV1Vk52iFnY8x5rHQMRng+N
 v/ipDl2FO5WgzxkYhhQBNQCIW1J2lEfxSzwgq23lPWoGzo4LhkRr8iGXsNPFlpZ231et
 BcAaOWUeSz2QEejx5L1cHdNy6NS1Bi76yir8Lt+EGThMZU1xPBO6UHalZe6YS3Uio6xr
 UB8A==
X-Forwarded-Encrypted: i=1;
 AKwUvByMkjk4DatSX8ln591tbaL8OLY8k10QwAoUFJye0bYITBn+/5KOkWQ2TntOi8DYNcFgH3pJU+Gap57zzEOoc3g=@lists.osuosl.org
X-Gm-Message-State: AFuF++m3qk3e2dqw+QeAhgE+UAYkqvYSPvH87iuQlSMw1ei4Uy0j5A55
 uonT3xM3nVeJM8ZiYePN9nrOW3RIf8gwvH/3oAjYJy7zfN5fiG4TdCdg
X-Gm-Gg: AYBFou1TiVWxgb5RiQzIFzxVLc4LUB7zrbT1PmolK+ynE5TSJBUS2AyU9r76A5J86GE
 B7qp4PZGQ2Qaw5dYNM+CGRwaE0QXwmDU1LC3hPfu72dEHRLw4Rz6YcWkD1oDxGk0RWQCPgpRI9z
 rWRWgzfKxZw9A0pv0ODftMmuSiipKd9SmB6ASrPGzTDR7EOT8zX1B4kqNQAQ6KGBz4FYi8/sB7G
 /J12pBIrx6iUfvCTGEpsvkqqmwNXCgWCH/U7Zox19ZCZl81YrRX5mJ0fipgJuiSHmm619umgHZh
 2OrLkWSEd5zaf0pQt4m1wdKIC468RNEngFPuQsn75rfUtJ/bpP+xVyuU3U5NoH967jEYi+w0epT
 E7bKLqLa4PJmuarEALreLUd33sRt6TO5NUet/+zqtbveIAajIBdWYCq/qmell6G2NiR+CZZDMZr
 AMCD0eraALgGXSUE8JklJU13m+o1q0ZM6HyOHHufD/gycdIFdjD9n15VakYyEHL/jVSncOU3SHI
 is8pdaXC3/aEZQrkpToYu7dqch/BGpGa9XIJ+Tr0bOShI8HfleMrqL9JIsuyYhczVvld/wYmzV0
 bf8ekNfEFw==
X-Received: by 2002:a05:600d:82e6:b0:4a1:6c48:c789 with SMTP id
 5b1f17b1804b1-4a16c48c849mr62190295e9.2.1791127745884; 
 Sun, 04 Oct 2026 08:29:05 -0700 (PDT)
Received: from citron.bnl.ovh ([2001:861:44c1:870::1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1698f7910sm83819735e9.3.2026.10.04.08.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 08:29:05 -0700 (PDT)
From: Benoit DE RANCOURT <b2rancourt@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Sasha Neftin <sasha.neftin@intel.com>, linux-kernel@vger.kernel.org,
 Benoit DE RANCOURT <b2rancourt@gmail.com>
Subject: [PATCH iwl-net 2/2] igc: Flush pending Tx descriptors before
 returning NETDEV_TX_BUSY
Date: Sun,  4 Oct 2026 17:28:40 +0200
Message-ID: <20261004152840.61222-3-b2rancourt@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004152840.61222-1-b2rancourt@gmail.com>
References: <20261004152840.61222-1-b2rancourt@gmail.com>
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

When the stack sends a burst with xmit_more set, igc_tx_map() defers
the tail register write until the last skb of the burst or until the
queue is stopped. If igc_xmit_frame_ring() then refuses an skb with
NETDEV_TX_BUSY, it returns without flushing any pending tail write.
Descriptors of packets already accepted in the burst can therefore
remain unexposed to the hardware.

The queue is stopped at that point and igc_clean_tx_irq() only wakes
it once TX_WAKE_THRESHOLD descriptors are free. The hardware can only
complete what the tail exposes, so if the unsignalled descriptors keep
the free count below the threshold, the queue is never woken and the
Tx watchdog resets the adapter.

On an I226-V running 7.2.8, in all 25 Tx timeout episodes of the test
described in the previous patch, the stalled queue had pending
descriptors after a NETDEV_TX_BUSY return: the probes inferred at
least 214 of the 256 ring descriptors beyond the last tail write. For
that queue, the register dump showed TDH = TDT = the next_to_clean
value recorded by the probe: the hardware had completed everything it
had been given. For example, with queue 2 stopped, next_to_clean = 190
and next_to_use = 167:

  igc 0000:08:00.0 terra: NETDEV WATCHDOG: CPU: 1: transmit queue 2 timed out 5353 ms
  igc 0000:08:00.0 terra: TDH[0-3]        00000099 00000091 000000be 000000f5
  igc 0000:08:00.0 terra: TDT[0-3]        00000099 00000091 000000be 000000f5

Write the tail before returning NETDEV_TX_BUSY. The refused skb is
left untouched; only descriptors of already accepted packets are
exposed to the hardware. Those packets have already been accounted to
BQL, so flushing their descriptors lets completion processing
progress; the refused skb is neither mapped nor accounted here.

The previous patch makes this path rare again for common skbs, but it
remains reachable, for instance when the linear part or a fragment of
an skb exceeds IGC_MAX_DATA_PER_TXD.

With this change alone (without the previous patch), three runs of the
same test on 7.2.8 still produced 10751 NETDEV_TX_BUSY returns, but no
Tx timeout, against 25 on the unpatched kernel.

Fixes: 0507ef8a0372 ("igc: Add transmit and receive fastpath and interrupt handlers")
Cc: stable@vger.kernel.org
Assisted-by: LLM bpftrace
Signed-off-by: Benoit DE RANCOURT <b2rancourt@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index b94a08791102..16f2ca32f5f1 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1621,7 +1621,11 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 						&skb_shinfo(skb)->frags[f]));
 
 	if (igc_maybe_stop_tx(tx_ring, count + 5)) {
-		/* this is a hard error */
+		/* This is a hard error. Write the tail for packets deferred
+		 * by xmit_more before returning busy, otherwise the stopped
+		 * queue may never get enough completions to be woken.
+		 */
+		igc_flush_tx_descriptors(tx_ring);
 		return NETDEV_TX_BUSY;
 	}
 
-- 
2.55.0

