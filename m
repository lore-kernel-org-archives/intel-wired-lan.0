Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95665606A31D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=bRi2W1rp;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGsH0ak3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72C6640557;
	Wed, 28 Oct 2026 17:02:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6D2rLP-u-Mor; Wed, 28 Oct 2026 17:02:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6C5040561
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793206978;
	b=mBNrfLk1o+OLx6FR23OYzyJjUm7XcLJn9lb3e2M3ArlakRsaHz5c8V5neWUyC8AwKjEx
	 yhf3bAsYWQKYifcn71/B59s7yww5ApnGbw6Cs0JAlxrK5IccjrNwj8Dbhw9GVm2b3Nw98
	 NF2dqZrHuifYekM3Xma+QiGJ6OhP88tbW3+BjxInr2RFdeaqDJYdxMqzvX567c4tPljMg
	 ldCDoKnCFU3vb5w6xLOVkh1xqcIe6NNHTbCQY912V9Do6SXE3H5EmsqmQ9xh1n/nGcwA7
	 Ruqniyk/U2LEMaPpXPqUAyczngm138J69L24K8X/IXk78mu5BEiB7IueWuDmX0oE5uQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793206978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3bql0FxgRhTkxJPynD2apVSsrpSHYvtugf0PDLfBkGw=;
	b=dze3H4AatZt4gZHNTAFjqStGqPBCPB3UtZebH9Gr7WanrZZVX0TM8mdI+Zye6LAN5Pxq
	 p6TVXoVg+pqsgA/uAtyFxoasb/tHabraBoY643j3HY6XFwr3D2iQlWL6EpXEgoYI3qyMb
	 y72K8mzb2CLIey/9yUimZLMHnEtLMMWK7N1WstemiTbE2Rs0mMfOiBU/ia1tyF5YyzXUJ
	 ZHp49MTh76LTzaSIlThYp4GRPaVJ2laC92oV87SdYpzXwuwf5vI3HKeqi+3dFwQmNG4BO
	 IZdaX/+Je+djP2AOXxnowMKbr21NxnlphVZWoCi8SsJUREU2eG96pCBrwD57F9kI/TA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793206978;
	bh=3bql0FxgRhTkxJPynD2apVSsrpSHYvtugf0PDLfBkGw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bRi2W1rpwQcF95+rQnBGgCcUZ5awfa4Vs/xgs4n9BwyLNnX773mjhT2r3BXQpf5AY
	 jU3ajWHwql0lct7S+FB6KDrdvyKQlaSnBptr/RUL2M40QyQAY1M+imrIXOMfX7aek8
	 TEgvmwd/tGSNSpdM+5odL83uEonvSbthxPAI+bnw5r+tsI0LpfwO9Pq7PhEZ5efKX+
	 VbEARneTDYE6iX5UYCLR+GaVYHUx1Hyu41pMpkInSUb6gI1Oj6zJ5k4oMSXhVk3E4x
	 rIjyeBHC/l+cvpkdQynkBZw2a2+UdVSNXZHu6PXXX+2BoEyP7PeVSGbqMXKawZXtPH
	 BtoSHv/VV54mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6C5040561;
	Wed, 28 Oct 2026 17:02:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 028E49F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 17:02:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E87C940099
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 17:02:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zYoO_KqGoohH for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 17:02:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2545840071
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793206977;
 b=Dl7IExRSHh1pXAropCJyDt0PGbrdzToz41SSoyodjYBqaAO4hCRrWgtc5laW9Ak32/4L
 H4GsIoHfPThW49ZYZT8gFUjCOzOU7xxw331jFOThZ4MNasZxvoPJo/Yi7BlMEkWqBpSMP
 XB80nX+gZF0h1znLwJF7hcnvGKtGAstJ82mawCJ+b7FuzEbGSQYE/Qms9J1FNoeRYGZ1A
 awQ/kCAiVtFyfQZaLWLthnArYJhuFP8K4D2unxj9nAuU4bRaeFxpgXLh53YYGUuSrK2Jy
 6F3e0FMFR1gCOAFuJZSHpzJ/BpxEbqgGdofiO0jlIdXzVUupk3KpOBGMTIIWiZHbUdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793206977;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=3bql0FxgRhTkxJPynD2apVSsrpSHYvtugf0PDLfBkGw=;
 b=TCqr4zFFb6U7FmLaLDGvKorgyV4/Ob0MBqVsj455jUpt3KUsxUxwkFO9pt4/C4gq4IqO
 GayYwD5qLkoeO6UZviKHrlSXRz3v0C+ceCylIg7tD4Ky6z8Mx16trcv6qcZqo2O1cSxAg
 bxHYf4+Qr3n7dxnInntDMU5puvpTsr6RlQrw5oZyXQnz4nj6VnWgP8W86WP02AWukxndK
 KOIkbduLc3qb9RO5cux9ccZlUWDMEroFBrDu0J0BTrl35ky59OaoPHLDMA1UHUcPZi+N9
 jRsuLhRFkCRzzU4g3KUXvUDOGMYntn2WBZlMthTjYIQuUCKXPKQyBNvkHlgBm2Yefvw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=yGsH0ak3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=yGsH0ak3
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com
 [IPv6:2607:f8b0:4864:20::122a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2545840071
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 17:02:56 +0000 (UTC)
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-1438d9363fbso1022662c88.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793206975; x=1793811775; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3bql0FxgRhTkxJPynD2apVSsrpSHYvtugf0PDLfBkGw=;
 b=yGsH0ak33Ftok/44Mo2gO2jgu+5oyrZIdUYe9EEMTT6ET1ukbW7HktOWSyJD7hFRgg
 dE4l9yY/ETbtH5mUYEhAK+d1GL1flL0auVyZU5sqaPPXr5lzvyoICn+9FURrb9KDt4kb
 +uFUcuLFviv0gqdj+YkoAfNBeCjW0H8yjyzac8m9oNPUj3Kf7oEaKvo+4BH0aUTHcF12
 B7vtpznOiDsxqB15w5kay5nhrKnPD8f9mBJnNRTqsBSLVfc7vIR6TCyEaFJtY6p1BlNI
 XhLNun//pWfltOzPJz5MNZvaQUwpmY8oTA/i2qMub4nSzsjdU52ffq97vHESum/Pp280
 k8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793206975; x=1793811775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3bql0FxgRhTkxJPynD2apVSsrpSHYvtugf0PDLfBkGw=;
 b=B76Aax7R8HGwHe8PI17KV9EnDMOfehA1AGZ2eQFOWbNx0nnTfEKxjstUx8tB+hCYh+
 pbl35cqI0FmK5qn9yxaTSERVRMeJxmu8mJSpxrLQ9jCZqnuhsmQVugSOHH/kYWnfxyLp
 SM4l2RLzdP5XwnpWdHPSyHZdx0Y47Ng3GT1R1ZrNcNQ/3fQHxwLIrh/iA25zp26QVBOW
 lIXcFBnvAiHzEyNSLrcae9weLK4UT6VsuZE4cwdLMygRTc68YzE/7hn5GBUY8qHjYxez
 5Ui9BdHYnXdw/AUNxlUtB2b2+s4VyhAsqS1sspuQrxH6Mwm/S3cwWjuH72fHaPakYKjB
 NleQ==
X-Gm-Message-State: AFq9FYJsepNJsA9vR11HiG9xhs4I2J46vSumt7XC9I06cpFrdPdJyrqZ
 E5u0MeG36Tt2lZcysZohV6dE9ORnjVWvXBzLe4nEQYwE5HCyf2KN8NXKi5Ga++fS
X-Gm-Gg: AYBFou0X6A2ymkA14HnxG8liWs9Czcs2eDY51rzFRqCRPqeqbx6wlX5X3xYT2e0tS05
 1ErKPo4XF5NH53iuPc0k3oNqLw+TOD7jODWw69/QCYN9u6K8TibInOJgaOxpIL30OyH0pxZD92I
 vDX7peFHBjPRjLDrRBqSd6vEefArTK86WSL8NgfRVz0MoQW/BYgpneTcYPuRJwFt1236w8xPSyc
 oTVuL5HAg5zXnpNPdzAqMAyl8WrcHF2+07HaQBsYB7NdfzUfnEJJWMdY8BMit+x7hBvuVOj02Gv
 qaANtM7nEiyCODIhye9+NM1jRWHmmMWLbOT6QKn+YDB8IWJb6gMY0g+7+xqz554GFfdUJdUZbvr
 YkglA2A4hjxKKmy48J3DUDlvEJNVYtF1ZbyeWx6oNrc4WlFjvQtrLBPCC2ctzj5+7DcGEijiLr0
 oqiR127NWP/VS9QxmNAg96T06DUKdOFRt48PQSafWZmqpujrhQ2m1qKoBW3YlbSn2o1oGLAdWCx
 w1S/K4N1kgYLIhiLGtIeavT+1UkpvsSoIugAdKQNrpKnqjdwVO8jQE8GpC5XZLhGIBEM31b5JGX
 HkfAu5xh0aRxSJAWvDJ/Gr8Jm82NBJUyW8uBSpX4jGHj+5ZksHo=
X-Received: by 2002:a05:701b:4514:20b0:181:6b8:31f1 with SMTP id
 a92af1059eb24-1a9494d8c4amr124363c88.10.1793206975189; 
 Wed, 28 Oct 2026 10:02:55 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316:67c4:cda1:9c81:43af])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75ef5b2b2sm6832139c88.15.2026.10.28.10.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:02:53 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andre Brait <andrebrait@gmail.com>,
 Matt Vollrath <tactii@gmail.com>, stable@vger.kernel.org
Subject: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
Date: Wed, 28 Oct 2026 13:02:39 -0400
Message-ID: <20261028170239.28606-1-tactii@gmail.com>
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
are sent to the card. If TSO is enabled, some header lengths will cause
the card to hang.

This was reproduced on an I218-V with an unprivileged Python script.

Fix it by disabling GSO and checksum offload when the header length (and
checksum offset) would exceed the field widths. Compensate for a
software-inserted VLAN tag.

Because of a quirk in the ordering of ndo_features_check, the skb's
transport_header field may be stale. If the skb carries
CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, there's
no reliable interface, so don't offload it.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 34 +++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6f85dab5c55c5..370776657d100 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_device *netdev,
 	return 1;
 }
 
+static netdev_features_t e1000_features_check(struct sk_buff *skb,
+					      struct net_device *netdev,
+					      netdev_features_t features)
+{
+	/* Do not offload packets whose header lengths exceed the u8 fields
+	 * in the descriptor.
+	 */
+	unsigned int hdr_len = 0;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		const struct tcphdr *th = (const void *)skb_checksum_start(skb);
+
+		hdr_len = skb_checksum_start_offset(skb);
+		if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
+			hdr_len += __tcp_hdrlen(th);
+		else
+			hdr_len += skb->csum_offset;
+	} else if (skb_is_gso(skb)) {
+		/* Work around untrustworthy header offsets in this case. */
+		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
+	}
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
@@ -7374,7 +7406,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
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

