Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A67C88E77
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 15:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94DF0606E8;
	Mon, 14 Sep 2026 15:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TF3R9tyvO0K4; Mon, 14 Sep 2026 15:25:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EDCA560648
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789399547;
	b=IsaR6ew3DpM9jHxWSTAhnvMOZZ+j1vnE6InqP3BrbihBMy9vGhwlJt+hNmD9NtxEcBmy
	 f0HjM4Ilz+E+7AcN9VqolP5NW/eQfduweWFUm+hlFOWhm9gPVn8c1S/JJe5tXCgrpti/k
	 MgRGQkBiDpEwORp9xHST4oAaJsmjgGaHmwBnZTVzJFs/6/U2lfnZ6Zji1SZC2F0SQkFzY
	 jOgT7EAUOwYidwpUNL+ryxpn9MtHBA7NnO5ubuoSBiKkY86eXmCltMbBh19xB3jpop2yh
	 x4xnP+692eWsdjorKeqrJWDXMqvnN0PPXTG/iPnKq9dIQmjBegyNZ6vKXwCPjQQFPJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789399547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PkBUg+m8HfIyEOkPoB1jZJ5opS1mW8Hh1Xx4YggldGE=;
	b=P20wu//0VdSOmc7BQjbKpq0GWcKSs1Xr7oS5f5jISSisWTSEqXewx8Aq68vdqEr6tP6s
	 t2OL+jvNjTF+kGlOqp01XkIOgRuc5L9eXzwV4skobkjsgiCk/wsizB7PkmEX5Qx/fs0qT
	 TDojY6x+P+PhAJqtlCelfFHOoBM38eSLiaV3m640fLJYK1fyFszlCLK2lFLW2Y/eTvBXY
	 IM1GgbDiT2GkfmQgEJPQoXq4hlsPFyPY8uJs6UEapcyUTruiWzGgux+Twf43Njgm7+zOp
	 fCBTK48cZ6EsuM1e8Ur/aX/rwRsHtfepizuDOdaM2qCn7vBigDlON+KF//vWV6sn8iA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789399547;
	bh=PkBUg+m8HfIyEOkPoB1jZJ5opS1mW8Hh1Xx4YggldGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UWJERZ5wMuKBIdzpiN4ZrC3Vcu7pzkn0ulU12SqggI8QzMnnXXrqDqTSCP48USeR0
	 ftOVyUXc4JfAjx6AK1dPaJpn2P4K+TqNp/2BZUQHPfjWspuFPzARTqsDCsBeIEjc9L
	 xChw7gDvAzg1xcx7fQ45Ud9AhZ5m4pTpdsbhtHjZTNlhty3ZxsdX/RMBwRysLD2wy2
	 U82gXhU4/CAl3iId8AW2Ly980E0jakLWsmQ00GhaYg2D0H3eE7H7fiEyG2kNa7QabZ
	 opazRvYqb4DXVOb5yJOUZDSkkw4HnD7p1PUc1jKH+SJyygj7H7v0BVJUUZdRi4uvH2
	 M2QVlKCbzTGOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDCA560648;
	Mon, 14 Sep 2026 15:25:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FE61769
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 13:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DCE0400BA
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 13:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GCohlCYR38PF for <intel-wired-lan@lists.osuosl.org>;
 Sat, 12 Sep 2026 13:50:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3318040068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:36::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789221040;
 b=bWOw25YwfkNreJLtYR/0xtoPX3XNv8+A9u15UaTHnmK9f66IwuhqvnHFV6SFaBUGB/mf
 c3Dh6zoOgPuuQPdcUw8G9IfT1go5bjivef6xYQSi4JJ7luTYTyXYBn4QBBXqyCA52kFdW
 V2VtYOaU2E1dI+SfbjSUbgvqvZDpe020oHFxGZ8wIb9sLgNHBUtpZ1xx+NmKyw40UHXsJ
 hassS92YCySqIFG6LOYStPA23J36W3KuXOArh6SNkLZ7WuA+qDsYy45E3Uxug1BZ1d/Xc
 ypVssj+gY2kbkwDVtzoGOcdstOb2M9pIX/fZYhDtbK+2SmKpagZncltBponEZjqLcXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789221040;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=PkBUg+m8HfIyEOkPoB1jZJ5opS1mW8Hh1Xx4YggldGE=;
 b=QxVp7bfLonn0TOHCPJZG4fWa3T+MqofdGcMzR6F8QQObAA2tnUN1MKF0Lhs4Qe2YB/R2
 UeZCPze8v+eRbFWS/Y5xBMBq6bSYiaXOHWRDljIhGBgOs9/uROmHgTYuQb3HmYKJeGBq/
 6aq0ks8etmQFEW1DotMnWhnDHdQUyU0UctJgyjqbrT9dJaBqUpQlxO6vJq17ZoOXxAzeF
 ipvnJ8fsit5Zu5sjeCCKDIgSeSBKuh+sBp9IrgiR1TPGbBerzvx/wI6+LM1vM5AKqoMa/
 6PCA8A9G2gjDkW00vkDJTGtLpt3VSkx+VkJUNs1MBZ500uGMcLJ3C3Ax3JPjwTtvlfw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=acGiKMlx; 
 arc=none smtp.remote-ip="2a00:1450:4864:36::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::10; helo=mail-lf2-x10.google.com;
 envelope-from=iprintercanon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=acGiKMlx
Received: from mail-lf2-x10.google.com (mail-lf2-x10.google.com
 [IPv6:2a00:1450:4864:36::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3318040068
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 13:50:39 +0000 (UTC)
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b5e4f13d76so551514e87.3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789221037; x=1789825837; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PkBUg+m8HfIyEOkPoB1jZJ5opS1mW8Hh1Xx4YggldGE=;
 b=acGiKMlxoQrGsH9S0E7OoiBmiYajJol9+MXD4ztyEpOUYobGWlbKLaZPDobal0tKer
 zbJA3gQWpAQjMvet5lVgvK1db3pwHcyIXKFEsvFMQaDwVeOgajcY1Porj1fO+z1r144J
 2eNIdZZRPfnI/4Oar/Rzp15jdyqhxmuZdyFm0CYjkMFOkqXMIhboHXct2kQTzOsKjQH/
 MetH0/LVH2WJwA3IcnGeQgPnMcd0WfjpbDnXC2UM+UuDpbOrlsQmd88UuVvZiFm2zb4+
 agSzZ3ILRe7H04UwM0k5MTolKAZgiGOq7bkzwe29tXdsRahBmS0Q7GGqNQKHuegmUXUg
 /Gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789221037; x=1789825837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PkBUg+m8HfIyEOkPoB1jZJ5opS1mW8Hh1Xx4YggldGE=;
 b=o7MRxD+dnbtjqDe4FDYUURlbj7NJ/pPeXl+QT0nWBSNAxr846jd6rEhwjdpOweepmz
 Gf6e/t6qpi1h8t74U94mrFTY063fCS+expApaZ9yCSroK1ZOCYzLGe8oJuVMO2iMW915
 kAtMBYxHcV652AbZdueQF66Ib/VVXtpzFuGNjfO29ORk4nLBI6FO+D1dt4oGo/WMpNV+
 9/SDwH3ShMI1dlKK8ugbQRMWrJHZVkOSMxiXoF3de+uEndwYi4XRwUB2vm0xAll+efLa
 2Dv23aLq8Sbt2tGnXQUt0zkahynooBN9Lm6iq76+WbRPoUEVLwD34jN0shTAblwsi2Sw
 Ohgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwetonjJvZjfiNeq5l2viQN9MDC9X4MgjfVlZkpsAPQJA3zqlH8wlBrQoX43rYGMs/AI47/AnlHcBGfcFZ1uxY=@lists.osuosl.org
X-Gm-Message-State: AFuF++mt09rv/e3GNqcnElsdPNbLC9e69/ukpN4Jrv0wY2HlFQvwycUr
 mzrhHu8y9UOBQGgBklLZlokGyh9VnNBsQPLj0b+ZYC9MZ7RWYCbMtJto
X-Gm-Gg: AYBFou0OdNSqeUkdjPVkAinLcAR40w6G0jt7NEIfkfoqQ+iNkqv2wwubtQ4cSPf5fVd
 skRy60+HaseF7W642lhRWBPEyildHyClTTcmRZ/53zgJrGKkasp72XfjQsPQMGu1cB+9Sr3waVQ
 t8Abs2k0/6QcuFyojMcydRMjI5FeSRmXGOfcYURvgWxjt8iyYOXf2Llao1RHrudj2EEdMFX/Qoc
 pTFMjygGzqfwYceo4KSqMy+P/3Cq3H9lrNYyFT7XJptRprnphtHf95e92BFB0SYGnYgHkqT182K
 NlJAFY2XJKZRiJ+4Gh+TyG+q94VYxCpC7Do1YO3rvn2xRPXrwBIYbFCKbloBQez+0LE0L3PgJQc
 wk3WsR1z/j+w4edecpKD6pGTNQbUqdYUq5TuA7IXkc5JO9NF9HFv4U9yKip4qPFSU7gcAxT9itW
 DE4q5uvAc2uXPjRTNlKUWBYzeXyjy5juNwxBUPE/EiDUcFq4c9lJAciMLRxBAnsCwT08kN11xBp
 jGK+8QTUK6ZvoWQ8Vz4/MMOh+6YG3LnzGntf8mJuCf6IxTfFjTY/fZLiWxXUY2f6HMQ
X-Received: by 2002:a05:6512:1594:b0:5b0:eda:de1c with SMTP id
 2adb3069b0e04-5b8a8ea0818mr465882e87.5.1789221037446; 
 Sat, 12 Sep 2026 06:50:37 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru.
 [46.138.187.224]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0457246sm1257770e87.23.2026.09.12.06.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 06:50:37 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] net: bridge: fail link info that does not fit
 the IFLA_AF_SPEC nest
Date: Sat, 12 Sep 2026 16:50:22 +0300
Message-ID: <20260912135022.1701-3-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912135022.1701-1-iprintercanon@gmail.com>
References: <20260912135022.1701-1-iprintercanon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 15:25:43 +0000
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

br_fill_ifinfo() puts all of a port's VLAN, tunnel and MST entries into
one nest, and nla_len is a u16, so a large enough port produces a nest
whose length wraps and userspace reads garbage.

Cancel the message and return -E2BIG with an extack pointing at
RTM_GETVLAN instead. The dump retries the port with an empty skb and
the error goes to userspace; notifications reach rtnl_set_sk_err() and
listeners resync. Not -EMSGSIZE, since no bigger buffer would help.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 net/bridge/br_netlink.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 855a46aec3a89..53676df9e4d11 100644
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
@@ -613,6 +613,12 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 
 done:
 	if (af) {
+		if (skb_tail_pointer(skb) - (unsigned char *)af > U16_MAX) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "VLAN information does not fit in one message, use RTM_GETVLAN");
+			nlmsg_cancel(skb, nlh);
+			return -E2BIG;
+		}
 		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
 			nla_nest_end(skb, af);
 		else
@@ -654,7 +660,8 @@ void br_info_notify(int event, const struct net_bridge *br,
 	if (skb == NULL)
 		goto errout;
 
-	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
+	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false,
+			     NULL);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
@@ -693,7 +700,7 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 		return 0;
 
 	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
-			      filter_mask, dev, true);
+			      filter_mask, dev, true, extack);
 }
 
 static int br_vlan_info(struct net_bridge *br, struct net_bridge_port *p,
-- 
2.43.0

