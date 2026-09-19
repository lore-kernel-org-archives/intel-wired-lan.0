Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A095FC982CC
	for <intel-wired-lan@archiver.kernel.org>; Sat, 19 Sep 2026 13:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55AE7811CE;
	Sat, 19 Sep 2026 13:43:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mgrZOU0y4Hgh; Sat, 19 Sep 2026 13:43:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A078E8116C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789825436;
	b=YxiPKwgEd6n37Bkd1f3Lld1m5bwYVMIVYC1aHffGUk44KluDVOImL72Eg2q00ihklMls
	 mMMBEZUqkvep+kOruwicnVz7lhyyiBbUVyX9uBfeF4C7q0JjseW9/FLUKIjaeAxC0tmIC
	 J2wkq3Ww+7s+vAwjSqMdiUzKIpH8t9RhK+GheRSFgHx05wpsPLl+/GuqmF4RzGvcLzPrF
	 1BTyFmSR9FzkCtBwzSqb3NRt8FLrsfktkdKydUgf0nHBkswX/4uhvnikKpiqLGxHBTEXC
	 yE5LTeoZtxS98yYs94VYxg4lZgkilhHYwgStdQll1chIhRvMu/gyHT9AhGWTheys0VQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789825436;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3+J2l1gP5MhTi9oNQGHstmZ8ANZIuRJDXJgeWc7c7qg=;
	b=cCJ/FnWB5uZraCdoVclum4AttUxR5AKociW8hkiFP4agxfFBcJBdByw3Jb4kDmsREkhj
	 2AwwNJEM9Oh3h8SJixetBbh0jABRR4Felo61N5Zikd/nM/yzvvrWmiFqfRvGbDJ12u32N
	 2MMaMLlZ+9IsNqmIb67hWY/eaX10fbsSLYWoRrUe1XebITXiDAIknsFuzlXbYT55FlCyI
	 h4IIM+D9jlbFkyqCfwBNnp4h4AmI4XTP047VWhhTq9iqdp8XO7Z2WH9kCIFmqsgeK41o0
	 Cua4YjPTQrsE/dEV8kKsGdAjRrT9MfWJRkrDbWki3tw2wt53CsUWoIFCxlE4VgSwTNA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789825436;
	bh=3+J2l1gP5MhTi9oNQGHstmZ8ANZIuRJDXJgeWc7c7qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XFeyJcrUJro2DInrRvyC6nt2FzoNXEH4F6N5DuztTk/4wYP3yuDmj1Hj87IRyl8It
	 +mR6jkfwogskhdUY7HahhLECZj0JV5krNmpaEwKN4/fSiF1nsJQMhKSOx0Ozedwy9i
	 1pxT+VYfQlW9BjWbvbnDa0xjDKTdsryzT+iSOTIvHb8Ktj0Tj10exbPvw86HvO4+3W
	 VxvR6HlDSKiQr/TwzeEJ5QkdWgqmmPD1Mi1o7yt6VZaEMwjMlrA178ctayGBZUYSoM
	 7ylu9jrzq4WAcDtOQpcARlto+EKABjj0/zQevH8kpCtO597/GbeQKkR+v0jkRQ+5a7
	 otQyc7Rsvd0ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A078E8116C;
	Sat, 19 Sep 2026 13:43:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9669B333
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Sep 2026 13:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CD814060C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Sep 2026 13:43:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ew4y2tkwZYMP for <intel-wired-lan@lists.osuosl.org>;
 Sat, 19 Sep 2026 13:43:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6470F405F9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:38::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789825433;
 b=kTr/6sUSjfWHHsVUWfksIV1B1FSoxcKi0g6h2hxf21aj0oBPlNtn+LSWOrzLlbPWXvMj
 /BRQ+OZ98FmCBallrhMcJz7RGtVZdU6qLfrPSUcNjoiSmIS6NnoBTCZ1lErjH0Cee9Y3R
 YOSQbYGNw+QrDolkyi5hGoHGh53mI3LY0YvEjZSFA1aE7z3n8FVyyaZ2xZ8FhS7p9WLVn
 wxCxOm0uUinTheItpAMT+rwBa0SyybObkIuKNY6jfGez1hKnrw0mkCaSD5+HlikQPC1Yi
 wMjSNTHIoEdQDgAFUObvEhX5ks+NaaXpJMgdg+GrowJE8FpydasBcdpcexuE2ustwvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789825433;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=3+J2l1gP5MhTi9oNQGHstmZ8ANZIuRJDXJgeWc7c7qg=;
 b=DugIu5WwShrtXTL44WZAcH3ubPvmh1rsBkSFqmd0/jwQTZe5jj2iskuJ1t8f2eZ/bWLZ
 e6IeqdQjVDHk1AtBIivPtETAtol1pAIwbeZzOraeoJnQ+O8rRrHvJndBWms8aB0TKymEI
 x2m5tsTr+uWA6q/DyEtKiKHmJAa/O1rUB1/Kl13hHfnY3zEGkEEMgcuZeg//T+OEcyFTn
 58vMOjWL2I0QYPLRDf7f2TGjgHzQ6Nx5yWesp+V8eXww6y7pfl/WC06gU5yot4caBUm4C
 8ZLzt/OvEifEqo7SEhl6yKHgcs00JjfDax74X7W7PHiME/goHvgUD0jkfgC+ypHNobA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=knqkj520; 
 arc=none smtp.remote-ip="2a00:1450:4864:38::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:38::10; helo=mail-lr2-x10.google.com;
 envelope-from=iprintercanon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=knqkj520
Received: from mail-lr2-x10.google.com (mail-lr2-x10.google.com
 [IPv6:2a00:1450:4864:38::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6470F405F9
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Sep 2026 13:43:53 +0000 (UTC)
Received: by mail-lr2-x10.google.com with SMTP id
 38308e7fff4ca-3a5d4688decso16488371fa.2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Sep 2026 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789825430; x=1790430230; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3+J2l1gP5MhTi9oNQGHstmZ8ANZIuRJDXJgeWc7c7qg=;
 b=knqkj520PsxuSvO4D7wu9S27SGa+q80UYcpv6lqPBWtMQCMvr6/D3Tbj+BmTYO1egC
 rBdB5nwldc9x17MiOEqH22xnFcdPquKwcpltLNgy2AqQ5t24VajzBlmguAPgf+B//43j
 ogZ2BqZ6YjXD8zp2Kq9J8ob1507tIp8sjhM7sbqZyAXV2jss0GW+nX2J9Lvd/ItiPGPi
 pKp3ODOj3rmWFSu3nXjpOr/ODiuLcn3V/fk7d2NGEzmyUjs1A+nJTfa1ntlK9/u+TLGN
 b1iZxPczzh/xqoOyuwo/CHaSKqry4puVlCj2pGmfqX9p6QTits+hVlBUyBnlYKKY8Su/
 ir9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789825430; x=1790430230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3+J2l1gP5MhTi9oNQGHstmZ8ANZIuRJDXJgeWc7c7qg=;
 b=lxQJkCIBnggzL1LKm86FqzRrtMjZ+DG1DnQNNJYrE6OzxGPR5uzu4FIIg/O9QI3Lxs
 MWuuXlv1Cn7lRqt8akjVn9CZ4hPL3SQMiHHqNULpEJzvAt352ksV34aEMwZGTSyQzE4Z
 81HCrZurlsGVlAmoDdBprPXxkdML59Lvx0tOtZ5L2g5Rw0gzWF6shMdTJjozHz4hl04K
 EAO9E1Kip66CL2gmyR/XM7/HSKWrV5zcE5jru0zIbbiy37pPL23jn5Uy7X5mckYaQJFX
 iwxpWSvKQz9QMiUhqbPjyqxUUIj+vBgAlMG2Zz7y7+FAoLqkWJ+TCAEhPOFN91kpLJX/
 hbzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiCrvqPJI6ZxZS8CInH++3Na1CO8RDMqn6uNl+F+0/jJ2fy5wXCltjbUa/eKeG5qAYweDwkwg8jmrvh1TWLTs=@lists.osuosl.org
X-Gm-Message-State: AFuF++nm8EUx5ey5jWMeL63SymbKwvoPWRZjfoXQzbsbqgusz7jadx/X
 1e/DAbSIf+C8qYbVA98ZWRqhWFF3AfZ/DI30m0hcbkgCSSea8mKI4tyO
X-Gm-Gg: AYBFou1RBu2WyqEN1GmGKEIctF0SbJQ+Jucsg5WrMhpDxQkGxkc9mWlN1z3MkYQdMVI
 mysN3KQZHpyhT6XMYDmHVxsfI18MA0XcZqj3pZl5cEl9JBCQ8rywfp2AQYKu+7bOI7J4e1rAo/P
 B7Ak+pIluA67KRmBKmxxxPEzMqa7OwaHdpHolgw5RrBqr5yLGE3Qqh2JPILr92aGRC7Oki/pOtS
 7h3VMUwMTvzvGojHA1DHY3JmkY+6keacaoZfHtA0GAahnGN+9hEGbbvpXcyuU3Yw2yJRrEsceyG
 yJxUjv+s2iCWDTxOVBNJY41ewxKyDNDyNmmlfPoqdUKLX+XXkKq6zIeYY0nofHTmuKodDeOnjMR
 N1jp2e7Y2KcoFQxfa7nsvvKLXmBMDdB3pmFOFiz4lgJM7cVGkleAme+JhYf2MUbe8xGOFq8uCur
 olmJKRQQmW9aieK6WwdHUmBDTraBWaJoKsNxH6UXjBzP2IsrcTN+9wwNyjnSWz0Gumz79F7S0vo
 sARluTFH6gTt+jnQZzOENBNDN/M0LpimC82Hl/nhfrRp+Aepbk5cAKFvnHjsKDcSJzc
X-Received: by 2002:a2e:a803:0:b0:3a3:361e:6f1a with SMTP id
 38308e7fff4ca-3a5fbf5e287mr11840091fa.12.1789825430463; 
 Sat, 19 Sep 2026 06:43:50 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru.
 [46.138.187.224]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a60767aa6asm6220941fa.40.2026.09.19.06.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 06:43:50 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, razor@blackwall.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 kuniyu@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, oss-drivers@corigine.com, wintera@linux.ibm.com,
 aswin@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH net-next v3 2/2] net: bridge: fail link info that does not fit
 in a netlink attribute
Date: Sat, 19 Sep 2026 16:43:33 +0300
Message-ID: <20260919134333.49379-3-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919134333.49379-1-iprintercanon@gmail.com>
References: <20260919134333.49379-1-iprintercanon@gmail.com>
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

nla_len is a u16, and a port with enough VLANs, tunnels or MST entries
makes the IFLA_AF_SPEC nest wrap, so userspace reads garbage. Same for
the inner MST and CFM nests.

Use nla_nest_end_safe() for all three and return -E2BIG with an extack
on overflow. Dumps end with that error, notifications go through
rtnl_set_sk_err() so listeners resync.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 net/bridge/br_netlink.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 855a46aec3a89..fbd91b86d4268 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -459,7 +459,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 			  const struct net_bridge_port *port,
 			  u32 pid, u32 seq, int event, unsigned int flags,
 			  u32 filter_mask, const struct net_device *dev,
-			  bool getlink)
+			  bool getlink, struct netlink_ext_ack *extack)
 {
 	u8 operstate = netif_running(dev) ? READ_ONCE(dev->operstate) :
 					    IF_OPER_DOWN;
@@ -588,7 +588,8 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 				goto nla_put_failure;
 		}
 
-		nla_nest_end(skb, cfm_nest);
+		if (nla_nest_end_safe(skb, cfm_nest) < 0)
+			goto nla_nest_too_large;
 	}
 
 	if ((filter_mask & RTEXT_FILTER_MST) &&
@@ -608,20 +609,27 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		if (err)
 			goto nla_put_failure;
 
-		nla_nest_end(skb, mst_nest);
+		if (nla_nest_end_safe(skb, mst_nest) < 0)
+			goto nla_nest_too_large;
 	}
 
 done:
 	if (af) {
-		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
-			nla_nest_end(skb, af);
-		else
+		if (nla_nest_end_safe(skb, af) < 0)
+			goto nla_nest_too_large;
+		if (!nla_len(af))
 			nla_nest_cancel(skb, af);
 	}
 
 	nlmsg_end(skb, nlh);
 	return 0;
 
+nla_nest_too_large:
+	NL_SET_ERR_MSG_MOD(extack,
+			   "AF_SPEC info too large, use per-object dumps (e.g. RTM_GETVLAN)");
+	nlmsg_cancel(skb, nlh);
+	return -E2BIG;
+
 nla_put_failure:
 	nlmsg_cancel(skb, nlh);
 	return -EMSGSIZE;
@@ -654,7 +662,8 @@ void br_info_notify(int event, const struct net_bridge *br,
 	if (skb == NULL)
 		goto errout;
 
-	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
+	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false,
+			     NULL);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
@@ -693,7 +702,7 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 		return 0;
 
 	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
-			      filter_mask, dev, true);
+			      filter_mask, dev, true, extack);
 }
 
 static int br_vlan_info(struct net_bridge *br, struct net_bridge_port *p,
-- 
2.43.0

