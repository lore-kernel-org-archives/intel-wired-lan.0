Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F09606A31A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=eHACNqEy;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mgbdz0Q0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66EA5605F9;
	Tue, 27 Oct 2026 01:30:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h52XLFLQt-oh; Tue, 27 Oct 2026 01:30:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C2DB660603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793064618;
	b=IoFhRT5u8ovv5dLCsrQ0rEmwy3SOVuVWp0YRn31wfEs7eSRL3JEZnDB/7g7hdyhLbXGk
	 XfszvhOIL2uqNwnlsks0gmRjw3MkYA4HtNkRrliysNrQLiLdqk+i0n+N5Yp6KwHVskbfM
	 +LcmgDA4YPmhoUJ3o7sA4aHoy2Pmc3uT+ndvbSicgKJYmHl8OK5tcs4k7oZ+UBbzUy6Su
	 rwynfNh3or97dDVu+9dcXEqWVsc7J6yi09GEJ9rMSmt0e/uGBw/UIOzu4nBS2I78QCpWn
	 xqVA5rPEl2wXKIZuJe8YutvgqLKfxA75owtgI+CHSe5hfgrW0c+CU/up9N8vSSUKoCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793064618;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5P6pJaS3sf4qIyhJ1YvqUZQqKBNJAufXI+ipbcohBqo=;
	b=mbzxKF9p3aCLzP45kfyMgsIPkR7xpxyT1D2bBErIFmo4iJ28qY1SrpIzj4RN2yLuU7T9
	 /3XUO1hWt70+Hr/TF5lwM6+PF/TuwmF/QHwweij5LKIoAzvwF2NtTgEyE/wg0z9NIAQ6t
	 DwPeOjXhoQ75AmwRYKqx61IF2LcE0Q4OF8hOIjRUY3mR3u8l899O75wsnIr9x5jGfCKKF
	 yc243Poyy73XpDjbE3ptciRaur9HOBtJHYGw4dyYBumMbN1E7pUgUD/KFbApOnsIJEYKW
	 ZiIxd8lZifX/ngup252C+HDUztZMAyh83b3l9rF2vZGkmORXi7FSOOqwcl85OL0VtKA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793064618;
	bh=5P6pJaS3sf4qIyhJ1YvqUZQqKBNJAufXI+ipbcohBqo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eHACNqEyjAg1o9u5aabEfgPLabRtDY80vqc+DGBxRZrFDgBBQrO5nP/g7a1QnczOr
	 yuELb6R6xMlIYUxCkHG9ubhd9NWcGr/0u2aerVbldeyae6O0gl3ZvCpwFUBeQBYnFn
	 /IhRuoCGp2MCyHWxndq979iLjzLUTc0pgOKv8dePu6ZAC8Rw21VXDxAuJ8T0CrroaX
	 +n2evRaEwjTXKAqSwJLiluNbNHoZQeY+BXEwfkfmi1Qhr5v/DRQEDvA6YgPMVFfmLF
	 65SkvPb+CaR2JeaQSvekn3PVcZDn8t55HZLyNxoV3l2KkW/lU17qLp3Gurof2cg+TJ
	 k2oReC3ZbDywQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2DB660603;
	Tue, 27 Oct 2026 01:30:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3079B235
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 01:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 228A24052A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 01:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wRPpolI1PiFX for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 01:30:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F64A40528
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793064616;
 b=QQUUOeflns/QwEn0l9QJKssJjcMN9dUj0CQ/D+YYK5KZwid4Om3eoK63yrKFvWSzuibx
 4XF50gFvlrvcZ8h8kvyTlY6m6hx1KwLr/dzbOVw7gpSQYl0oLu5beK1xelZIPnXG1wbii
 ghs9wl0M3cdd3ONOzG999okR+7ko76DzoYauQKO5ES79bdwEJsYf5GEmDQRjx++5Rj4nt
 zGxYVjckvFbCTbbUO191pFalx8yRW3wbbR79Ypt+yRpV2KTEL3QLRpKiOYANof6YkszbL
 iW6d9iT8EYkrcpAs2GRDzD+xetRAGs4l9D2DcSDXgSg7EIbzUeTP5O8STooAltK8KJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793064616;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=5P6pJaS3sf4qIyhJ1YvqUZQqKBNJAufXI+ipbcohBqo=;
 b=pY7dbKWewd47FseVIEpbvMJ7OC1I0SVpzxZuG7/gbVpEhcEmIxTMuwxkH/GYs8UyW3TE
 RBB37cd3DKSR5huHEDi3yHu9uyGw7wapdsnYL+taYTg8hGMGswY16j92w1ZTaY7YZw3JR
 sla4LVV5l8vjOjybXAjl6jJRMu5DORsamn9YkXOH8ksOD0yrGEA0EV5AS28tVggbjfmew
 EpWgX2aFytJ/Sjey4USz0Tio/hA+yo3jzSUtNh6kAbA+22mDKWMPoi96nF3/6L/dob2Ss
 lQcdJrHgarcg8iSOVr2NIZZ3gE2hqGCa3OctQJIkp7CycnJnRvxAzYmDaYu6tlgNHpw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mgbdz0Q0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mgbdz0Q0
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F64A40528
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 01:30:15 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b0dba37a7fso30320127b3.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 18:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793064615; x=1793669415; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5P6pJaS3sf4qIyhJ1YvqUZQqKBNJAufXI+ipbcohBqo=;
 b=mgbdz0Q03fPp8CBrkx0uujiDcSTBuJKG8vp7H8fA/EL44IJuUhx7GIGyKBfimWeG62
 BFzbupdngsH4u5jaTHAPd/B1jUDROXbo+g+97g4ioS6cAwPLoRXZbDUabt24YgfZIaVl
 GqnOTqensVeKVbqW2gy5uiFojjr02d6OJou8dx1sOGq307vNqHXJ5WyZ/5/S+NpYLUT8
 10uI+cwdzJUXULPLzCH9YXWyKP3Qw1Xx9qONVwPo5AlegnBEyA+5u3swfspMDj24n9yt
 0OZFuoRLAxcZGumU18TzIV1Hbond7KTxlxr4yVrGpeg+W8wSW/uJS80dh3A87rsbivFw
 3zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793064615; x=1793669415;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5P6pJaS3sf4qIyhJ1YvqUZQqKBNJAufXI+ipbcohBqo=;
 b=e2Fy7PeMT6wSN5MV/luO1OTvDGRT4nwpyCDLeYZLRHmZvgp2LDh0OUxoQ/8wJqaxv1
 5iqIAnmQ+ErDWioa9zg4llWykFwuyjDP/9cCi94I122JOCRh5gInWuqX9yq8r9fKKD+Q
 DPo8qMrMrRCX9JRwuyxFV7UT424XPTGRGh8LboyHzIe8D291FOtqW2cgcboEepc0GfT0
 y3g3IpPxJKPclbyOKBwtJ5SU53zsCpzPIkwCHhc9GYCvQyecVMbCBk7lmsY3EZ3ajRvp
 vgmpIo+V6Po2c9oIcX3H+Zi7SqMfwLU75fC86cguR7IqeYNlTDe214isEDt/zLhhqRX0
 hLNA==
X-Gm-Message-State: AFq9FYLPafJnYHZdE3G9Di0iEAv2XNArrAY69u7jPnosAd8Kocr1qV0C
 gWXJKWldosbkxTdokXWlUK7l2wBDJonjTvYhpwrWwEMUPnvEyYYwA3WsJVEnTjWZ
X-Gm-Gg: AYBFou3iP4jeWDcUTwK3xfZFjaOdzoPADwxbgThCkCnXWeoe02leWTgr5vDIzabHb7u
 5X4ctH33vF3Fxj3Y+Af65Qu/aJ7IW1LvOkYXrPGxy15l6t+tL8TDKjetQ2M1AP/Yo5ldcrLzoZw
 2K3lZB0AuCNV9saIy4O7FILQvU85ZV/I8sA0s/kxvACcSD8OPzl6ctkhbIh8291tMpSXcpzQZ8K
 Spw2OhKf0RxGMJKeYfZ5gMTnbKO69V0GAKSp0VI4kKy0BVjK8DR+msiBZcC/bTxVprWzzsJ/Sxm
 T4kXmmG/c07MXDuvLzRzG9jioSQ4SKm9jPt8tm8VLlG8OjZKgELMBq6+s8a4TMR4BehE5QT8il4
 +F4I7PawQqjicyqIwXgU+8nS2WNU7CoeqkCSxdMSsZT5TFZfaByOZkZW3CMp/jlkzndwziDDu7l
 4kPmrWMtwEelLIxMYp6Rmx44erruCjUufnb2o7KDi3bYG23T5g9jh6Zxe2OusUuUni8FeWjZbh0
 lAgpkacnOq4H75NMzOwKNC3d3udOT6zig41+ehdKPvUUFSkj079raUaqTP0UeO+2+RiLuixkV8L
 ew==
X-Received: by 2002:a05:690c:e085:b0:873:5bd1:98c9 with SMTP id
 00721157ae682-8b166c7b83dmr53834777b3.59.1793064614580; 
 Mon, 26 Oct 2026 18:30:14 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316:dbf6:fb98:d66b:7c65])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b19e65948bsm4557977b3.45.2026.10.26.18.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 18:30:13 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andre Brait <andrebrait@gmail.com>,
 Matt Vollrath <tactii@gmail.com>, stable@vger.kernel.org
Subject: [PATCH iwl-net] e1000e: fix Tx descriptor field wrapping
Date: Mon, 26 Oct 2026 21:29:58 -0400
Message-ID: <20261027012958.52524-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When an skb arrives at the driver and the header length exceeds the u8
hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
are sent to the card and it hangs.

This was reproduced on an I218-V with an unprivileged Python script.

Fix it by disabling GSO and checksum offload when the header length (and
checksum offset) would exceed the field widths. Compensate for a
software-inserted VLAN tag.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6f85dab5c55c5..11714032793ef 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7355,6 +7355,27 @@ static int e1000_set_features(struct net_device *netdev,
 	return 1;
 }
 
+static netdev_features_t e1000_features_check(struct sk_buff *skb,
+					      struct net_device *netdev,
+					      netdev_features_t features)
+{
+	unsigned int hdr_len = 0;
+
+	if (skb_is_gso_tcp(skb))
+		hdr_len = skb_tcp_all_headers(skb);
+	else if (skb->ip_summed == CHECKSUM_PARTIAL)
+		hdr_len = skb_checksum_start_offset(skb) + skb->csum_offset;
+
+	if (skb_vlan_tag_present(skb) &&
+	    !vlan_hw_offload_capable(features, skb->vlan_proto))
+		hdr_len += VLAN_HLEN;
+
+	if (hdr_len > U8_MAX)
+		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
+
+	return features;
+}
+
 static const struct net_device_ops e1000e_netdev_ops = {
 	.ndo_open		= e1000e_open,
 	.ndo_stop		= e1000e_close,
@@ -7374,7 +7395,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
 #endif
 	.ndo_set_features	= e1000_set_features,
 	.ndo_fix_features	= e1000_fix_features,
-	.ndo_features_check	= passthru_features_check,
+	.ndo_features_check	= e1000_features_check,
 	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
 	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
 };

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.43.0

