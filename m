Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498DB606A331
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=GNs9VLoA;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pLoKd4r7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AD7160725;
	Tue, 27 Oct 2026 19:57:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wjaK86qrBnad; Tue, 27 Oct 2026 19:57:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 86465607AE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793131051;
	b=fvgJ9RbOclUKJEVkUHZq2EA4u2Q9osgy/3SuW+OfamBmJIWjd32Kh7Kt4YBrDP0JubQI
	 Q3bzd5rjpV8mpIRMVJEreyWRQmq5KYjwX34oa5iOxt6k0zI5pq0kTGNVDKAHJqs6KGpvp
	 uLSMUypfcT9Y6aomVvgzTF5kx+Lc+KpKi/1OMs3OR4tYEII3ocYbYNsT8OFFrJ2lcawIY
	 NKj8Xl9eP1x7GivceKPlIwmZ136vUF1WtVEeC3Fo7s5U8lrRRJsSJGEZKXhjBY9IHUMHE
	 NPgsWUbZS13+N4s1SGe3IWMP5LXWRwzoj7h3SWV8mNLyY5FeLxLlpHvLlQUVlA9jMNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793131051;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LKl9wz07od1KtnGqk5r36fEXu2WKt0H3YytCVeKpeLc=;
	b=QWj0VKKuJf+oxk8YahS/isztiEbdFk7fSqPMaOjMAi99bsVUnAbgczuRLVu46uG12Pe0
	 Mlg2FCpirGjWe883IQE66rLybpaBlAUzGvIAVP3M3X4lHuRon3UlEMZnDfAr1rKHlfUD2
	 rlV0+V/g3RyrUHPX916+2qzBXzvYaIb5s/wQgm7b/JZ0PMrTXCHpaPSGrzdM8z4ML2+2i
	 dMXUNaIAPHIn52bzMCRqWPZoLVVcf6lcZMWF+KXo4RspGcuRm9TVDsvusvrbbSqdO+exw
	 H/hLsknYfATlNyaThy0Yrs2VF+4W8D9geuw6v30OISV12JKQxtfjUqK1oeBsajGJeRA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793131051;
	bh=LKl9wz07od1KtnGqk5r36fEXu2WKt0H3YytCVeKpeLc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GNs9VLoA0YSQXvAEPD7OHxqIeJ/WzCP6kuXBkeA5rhrQFlkPGXmno912Se5nuKWUW
	 keejMKBCRe3Yo++0ZJLugf5+NSJQEzE4VY3jEt4ctZQr0xgk95U3ikWXjKgv9cIId+
	 exWF8qX8/0U+7gArWtzd+SQ/6qFpwuo9NBCjUNhT5s4UNPKjCX4wdEKKIievD71XtJ
	 Q0Y8/HHkCxRh7/svGl+SrHDfrKPRSNO/Rx5OMiX+cYCSLaqnv5C8jwvtmVuYfk7iKk
	 GTf+GhqzwQ65qskZK9YFm1MP/k3vY4h89ByknOgauLoaUx60xpB25+ZKRITildKkSw
	 uEpC0SdsDjJ2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86465607AE;
	Tue, 27 Oct 2026 19:57:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4446F380
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Oct 2026 01:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3609240063
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Oct 2026 01:47:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qtm_XBEse5tu for <intel-wired-lan@lists.osuosl.org>;
 Sun, 25 Oct 2026 01:47:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4E80B40072
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::933"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792892852;
 b=kD94sXQRV6GK/9Z+P/7Dx2ljsrth7f/WbGT0GclyogwCt6P6p1CjrHjLZBVIt8W2QmWY
 f7tqFcUrtA8+GHea0+OUypLk9Ik74NpEoyRreQIpUBhU+7G9+8CRatbTT4dLW5LLT/nWc
 6DyAABkeBDPTvB1F0/qS08eI6upHPNiEim4RR/jHxaJjzXcIrw6bu0PfiHUnXuMsX8BLh
 siMtU69LXmgb1imPhWigU8SP5wgOtWu91m0kWjNcbfI5kBMdUXhknph/89rtigu/WMDAm
 TlZRTAvdJmKYtD4HrOT+fMyXNS6gagKVouI2uXpSfCb0poNd5YoRAIvdfa38f6rcH2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792892852;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=LKl9wz07od1KtnGqk5r36fEXu2WKt0H3YytCVeKpeLc=;
 b=o205E5yMrjRfm4swGwcXkIoTvmtqIhvUQU6nJU1AkJE4cMG/xV7mqdVXljSSJtFEmKCQ
 C4TutdNlHcdfT/HpU4YpPqMbhzGPjiprr6JbBAYtDYabeOhaLmCwAH4xzcrFSMRGbM64+
 wh7QmqmQErntXyTLB2/wwDXSS7h+lJ5KIR4QMt8WIv2SG2vldpyhLC2ilO5l1yaHaYwav
 SYeBSDyrKA693lRop7W+pCrX2LEWg6FmpU9sTAcPIZkZv2EdMhOq+QNRtooUMYQEeiLwU
 x0AmlVbgGRQNa6ZjGgCqeghfS6WkvLwGJgHI+s54tdIaaeIbV9NyK/+OqiQyJT+kDvQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pLoKd4r7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::933"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::933; helo=mail-ua1-x933.google.com;
 envelope-from=joasantonio108@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pLoKd4r7
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E80B40072
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Oct 2026 01:47:31 +0000 (UTC)
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-98ff53fb739so1255650241.3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 18:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792892851; x=1793497651; darn=lists.osuosl.org;
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LKl9wz07od1KtnGqk5r36fEXu2WKt0H3YytCVeKpeLc=;
 b=pLoKd4r7hII7N4x1Qgz/Ran/k6b+thEJZ6uRpr9hy1ptTXUod0GIhqZ6m5ilwnS+Rb
 V6Ydy3fnW1SZ1rlISPBxn2hagY7DEDCG0XksYWeJnns1I/mlt7qDG7S7WtNapEFU+KBp
 2dXgoHPq1aQwlsSRsDXWiYhwgJzdYqva+6uI1vaRYUjjE/MxLeQ2INRaizCkUwqTh4HL
 vcQNbOAOuD08UOD5wTai4YAZ33gmPzcIXR2T1tgw/aA03LC5WZoHamIdPUZjSOqEp443
 RB10UYn+mGKulVpR0pGhI+spsfJSTdCU/55wj2NcpokYCF5PIzrpHPvtPkZix3meYQ80
 RCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792892851; x=1793497651;
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LKl9wz07od1KtnGqk5r36fEXu2WKt0H3YytCVeKpeLc=;
 b=jelA81ulrQ6B9iR4oc699kc3VhdNzCwWxEBs/YhvfRkEazbmQvrCZPw5eBxPBOIVgD
 UfovcSBqgZqSz8TGUozdttigByMX+80exeRkBFeTtinVtNhea7SFBcTTCX2AiSOlmtp5
 zV7NYH/0e4a64UD5pdElvmC8KBb3VWnpx3K3FtvEvZxrLOu5bA8BIKchJO9hg2A6J/H8
 9uU/0mWWcN/vuXzaJrWfeWtOklHqZ/P+52Prf9odKknaiH792RkAzYldq41uRxSOT7N6
 WwlnmcdbV0dIhMedI4xgsnNoB9mRYVFaaV2BUWgwQ8AAS2CEHodywYxf6zhXslqTBzML
 OyPA==
X-Forwarded-Encrypted: i=1;
 AKwUvByHoQEcmqr4mGQoqUgSdUHLDmu0XMYBhkLDc/ioLM208hgVWM6cPwKPKVud4FI3jiMvXGJOVdnEqkMOWLSUZ9Y=@lists.osuosl.org
X-Gm-Message-State: AFq9FYI7jUDv2c06HL/d1s357ETq6F4uuvGbj0kSGlGVA5PNX/LqAKdI
 XJGgoSd94ced9bQrQCA1LqaAHM2aQ2f6yrhYO7hobw2ihewCigctikOE
X-Gm-Gg: AYBFou1BV87zwrHa6Imk8b8XaIfiKewVmeqTh3TyvBhyLJuwumExfkAHzkK9ClggBUH
 u3PQppqgmWpo6uNs7qBJptwL0hIQG+bRk0HwxVfbVxk2YzFDjnmCh7kX9peclPgaAhY6roqdXiU
 Q6mbMvv3ca9fY4l41OSX28DndXTqcwPXqfS7V5im+okqD7MFynewtcqKutRmIrJcAMPj2uTkqaP
 U+ao0kuFOXFs9sp/rxxLrDMM0QuKSOGAMZSaEI66qWeN/3b4DpsUyg02il2YNwE63f1oQcXvgCs
 1weCaTEjbAHBiwGdCclqGx8g0ubNFvVhBE+jaXkvTpHUsk7j351hsWeB6KDPBNisc+W1S/w1Uw1
 H97bhghmSJxoQSAC0WWf+7v6F5L4xr0aHzl6ab7I8XEUF3VKjkBLRmpBShdKHBX3L7BXCCKXRx2
 4uJkQzMEwSGYaS1bZ1uMDbstIOttYFLBrucZYK3a1v4SDDU6AeN7AFSziDb6fYaOP2VB4tYxi7L
 /1ytzIj66nkM+Lz5B89pVfwX/esH0jnzGBv93Im8N+3L+kNqRWSEPKE95hBNZc69r3I5syF1qDS
 YJjwYl3yn/ZuBacVUp64z1008DOtozT426TYJdsI/qRjItHvs0E=
X-Received: by 2002:a05:6102:4b1b:b0:7c3:ac79:9b09 with SMTP id
 ada2fe7eead31-7ce5ce62789mr982785137.30.1792892850663; 
 Sat, 24 Oct 2026 18:47:30 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa
 ([2804:7f0:b101:277b:8118:1af6:d493:fe05])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ec233f4bfbsm3877257e0c.4.2026.10.24.18.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 18:47:29 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dcb: initialize PFC value before calling getpfccfg
Date: Sat, 24 Oct 2026 22:47:24 -0300
Message-ID: <179289284460.50470.572724041164324949@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 27 Oct 2026 19:57:25 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dcbnl_getpfccfg() and dcbnl_cee_fill() pass the address of an
uninitialized stack u8 to the driver's getpfccfg() op and then put it
into the netlink reply unconditionally.  The op returns void, so the
core cannot tell whether the driver wrote the value.

i40e_dcbnl_get_pfc_cfg() and ice_dcbnl_get_pfc_cfg() return without
writing *setting unless the DCBX agent is host managed and in CEE mode.
Both drivers normally run with firmware managed DCBX
(DCB_CAP_DCBX_LLD_MANAGED), and i40e with FW LLDP disabled runs host
managed in IEEE mode, so on a DCB capable i40e/ice port the PFC values
in DCB_CMD_PFC_GCFG and DCB_CMD_CEE_GET replies, and in the CEE part of
RTNLGRP_DCB notifications, come from uninitialized stack.  The same u8
is reused for all eight priorities, so this is one byte per reply.

dcb_doit() only requires CAP_NET_ADMIN for RTM_SETDCB, so the GET
commands are available to unprivileged users.

Set the value to 0 before each call, like the PG config path already
presets its outputs to DCB_ATTR_VALUE_UNDEFINED.  0 is also what the
reply contains today on kernels built with CONFIG_INIT_STACK_ALL_ZERO,
so nothing changes for those.

Fixes: b94b013eb626 ("ice: Implement DCBNL support")
Fixes: 5effa78e7c94 ("i40e: Add netlink callbacks support for software based DCB")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
Found by code inspection, compile-tested only (W=1).  I don't have
i40e/ice hardware to check the reply.  On kernels built with
CONFIG_INIT_STACK_ALL_ZERO the byte is already zero, so in practice
it only leaks on builds without stack auto-initialization.

 net/dcb/dcbnl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index ab71f53128..ad0aebe0ad 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -281,6 +281,7 @@ static int dcbnl_getpfccfg(struct net_device *netdev, struct nlmsghdr *nlh,
 		if (!getall && !data[i])
 			continue;
 
+		value = 0;
 		netdev->dcbnl_ops->getpfccfg(netdev, i - DCB_PFC_UP_ATTR_0,
 		                             &value);
 		ret = nla_put_u8(skb, i, value);
@@ -1395,6 +1396,7 @@ static int dcbnl_cee_fill(struct sk_buff *skb, struct net_device *netdev)
 			goto nla_put_failure;
 
 		for (i = DCB_PFC_UP_ATTR_0; i <= DCB_PFC_UP_ATTR_7; i++) {
+			value = 0;
 			ops->getpfccfg(netdev, i - DCB_PFC_UP_ATTR_0, &value);
 			if (nla_put_u8(skb, i, value))
 				goto nla_put_failure;
