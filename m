Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF46CC982E6
	for <intel-wired-lan@archiver.kernel.org>; Sat, 19 Sep 2026 13:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AD336066D;
	Sat, 19 Sep 2026 13:43:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JH0D2gknedRe; Sat, 19 Sep 2026 13:43:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9B24E6066E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789825437;
	b=TO/ervKJU9CIf73qKiEzv9lBgK+rYITysZDy65WPcPz6QfIPdaVd/a0FvcGxvyZTSWJa
	 21odpp2O/tluUN1+AtOwUE9Ryf47JnqGHy9Apx3EjdLm7/8We97ktqP1rDi9eZ+78GjRQ
	 vvvs7K11NiWR5R5P6bhn09DqFT+sMwtcZ2wv3GjFU3Et4q9v97HpN+ShIq0UluMb6DqLV
	 5j4a8P8629BYqYjq00D7q0paNjPYjxBbxDPSKJN0+My7Y/bRAs08878YkUa2kICaJF++h
	 wr4mWnxj48SGyGkiTYR8/Ut3At3ggsnLbrewdxNV6jMxv8igVVVE0fK/Zy0AYc3e1ZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789825437;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fQI3S0LyGyRRUcXsOa75Z3ymY28haXHCQF4fW8+TIHQ=;
	b=olqk2wE8oEqgFm+kEHDJhuQo4sLHdeC0RsXOct7uTC26hcPFpmf73XQZMRoNaBlpwmxa
	 JQ/rZl4xHvj7RDz1r+wyV1RhJjAl7zI88eXM1c4DAM5Z47pHEdTiEA6/WYZhUYp03t0Vk
	 Uzgzy/cWHQL5P8RrH6e/Ki7orII/17NJ7sTPTY+ByFWkNoQnOyhdt2f/YyPKq5GRN/YnK
	 q5J2tR6NSunk8zgqKZI/mnzGhCKTTYE6vIbPqvm+W2WRj85CBnZx0PhJ9rg7iRSs/vwvO
	 hNoVubjWsyORVB6uin7IAJl8AiGke+8doWuMZvJR8IsXEV0iPEQJothcQL+dPrEaoUw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789825437;
	bh=fQI3S0LyGyRRUcXsOa75Z3ymY28haXHCQF4fW8+TIHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x46HCXlh7pBTAUlMSGl5iI4cJ+M6KxWR/JFKMq5iEXFw+BOh5xDpX9MV2WN+2KTbq
	 HJVgijd6WuyzeDgtexbfHU4mKSBJvC4dDoj/7WhiRRfIvNtVSnwVKGAZfogXvsl8CK
	 ElrGgbRPv6puZuE4PLAAnM8+y7dvExTkcw9PTmFRDvWsapABFmkkX+BrJj+i1LM4jI
	 ISnQs7vTGgs26Lf+8WREQekhubzbPQuMD7EPjbhTgHJYwc2hvIp7FJv/HOPsaglT9Z
	 8GmOyPQgRBgP9zT1AH6oqHfwNumasDu1RsTKGfg5PjfzptxlvKhHt0aAqHKc80cfzM
	 ezOjdF9zfEwtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B24E6066E;
	Sat, 19 Sep 2026 13:43:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E1EB5333
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Sep 2026 13:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C6C66811C9
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Sep 2026 13:43:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QKZcjhAF2R_I for <intel-wired-lan@lists.osuosl.org>;
 Sat, 19 Sep 2026 13:43:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A6C6681157
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:38::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789825433;
 b=d+ABK6ZuX7eDKOUhcJfJKwDhaqLUzN/M/6xlO5mez7itz5JfEQLa6tlmmWJ62nWAOrIv
 Ek31agTS9EmbjKm1XkGMIcNm1DjFDAqLQz9KqS/7SP+6KT8OjqLmHijzsmf2iBPuSM0qq
 zfVie7G6sBugl5E9v50jK1vGGQ1uyvNZBco/p8b2BvgeWcyeMxNHWqjv5mOA2NKkUNOdG
 sKSJMcWx7SEzKv6LQuvQs1koD8t/78wHjsSbiAHJJPSre7GOlKYI8S/vHD1buIU7Xsc4I
 MG7ekfXLeVhToGgNsXmoSjfPXiX7g1IVJ1pzv2Wt0AoSX9zSPe6haqX346YVtxIQ5Lg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789825433;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=fQI3S0LyGyRRUcXsOa75Z3ymY28haXHCQF4fW8+TIHQ=;
 b=alK8EqHBcl8ClUfVplG/UAMo1VXfe72QIZHT8bGmAGvcTe+jwJzKT+ImB2xKeBFuHHUO
 Gki/rbRb6f9PsAzDHdH3d4WvjBO1oWG0dsWzeKraP3xmXMAAUJZtkpoKq0L9nNkmgomJi
 uqST1sRyZPLUnX30Yl1CcHNASdZkfWL0ND44HKhS73VNu8XomEYF9izJb8JajuKDX+aeh
 D4IKXIXolyx5bNICcceEshJ2OSXEHle+KwExJg9TMaLFYPC3LpRApTlDupw+VlzlbJ4O5
 WnlPP3MrZNByyYJbyO+Yt9GfotrfpJsyf94tuAiTdtKnrp7RwIHDrQSCA/fbVRDldBQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MJ+R4quP; 
 arc=none smtp.remote-ip="2a00:1450:4864:38::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:38::10; helo=mail-lr2-x10.google.com;
 envelope-from=iprintercanon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MJ+R4quP
Received: from mail-lr2-x10.google.com (mail-lr2-x10.google.com
 [IPv6:2a00:1450:4864:38::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A6C6681157
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Sep 2026 13:43:51 +0000 (UTC)
Received: by mail-lr2-x10.google.com with SMTP id
 38308e7fff4ca-3a2ff00b8d8so13882811fa.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Sep 2026 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789825429; x=1790430229; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fQI3S0LyGyRRUcXsOa75Z3ymY28haXHCQF4fW8+TIHQ=;
 b=MJ+R4quPNEvtHWPj8v7tYR9YYcUzaeUpEr5tTFcF7LmmmRTuYcZ4i03fs4VZCOO02x
 jFHls0q2PVhF/pbOE8CAifSyo0o1iwBQWaQgaG4PLkiozTFGcWwy2BzlNvz4635MkT+Z
 C1CCOOqEjKsWRVrd/dQOVJkdp8IWfjS6U6oVcf0NEJgL5OXOXehhipl1nuBY5IJvFheY
 70zRF/pfSKPf1nC+F6mzA3x8wgttxyBFmB7b/Y4RuoLj7RXfSVAi9y0s47aPAj0qJ0kU
 fcuTzkbwf5t7+VO6PHFqBf/sSyTuYjHyeAJqIWzkzX3S7c0r4sEFIBahB53QTYuPkMfJ
 6FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789825429; x=1790430229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fQI3S0LyGyRRUcXsOa75Z3ymY28haXHCQF4fW8+TIHQ=;
 b=AS92onLDeHjvtKGdc5byRqhjOP8sfvKGcBwpC+I+lmy8asZVfN3Ub4TjgiNZRPoljt
 Sm16K2xNyMxAJQa81f3AD/Mn7F8dlKGduxbAKtyAt2Ha0qlM/zIeEtHRz1EFanI5HpBq
 LIPp7KZ3rRxt1rOdkBm0mJQudLn74c1NKbF0WuYEB+iL+R1ZhWWGaKjieoT1CUn0q0wy
 oEgyLtcZz7N3NPhmp/KfDy+qGAz5KuCC+Gme3GXpruMADvBimNDQ4Ug1gs6NPoxibFQ7
 veAfdf2R+6CvOBVnt6AN//ujT/9PEjZd5IlxdsDV9qVVdx+91CBOdQ73yhTe7V/JZ8YM
 95SQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxX0FKVIutVspyIFZTNf1FQ8sA1H9GDMQ6q+hvHArFPe1AqybxlGoY4S2PDFTxce4ZE6YtBwWO6jalHdYzrR8w=@lists.osuosl.org
X-Gm-Message-State: AFuF++nhYO6YizgLONQdB3fMOpKNW8XPEKQ4sSzGyYwl2jIq91rZhWoa
 /OuCgi1CfZ38U0HwydfhsegKk1Y3GVfg+xtBhPiX4aHviiwCay6QcxJL
X-Gm-Gg: AYBFou15bOt5Xz1yG0jkbQjTA4H7XT6BLcu+/FbA2MXFxocbf9ZNcblxWxsnAO8opjQ
 23vjSJHkY5s/oZsIgoto9Nb2aHoegEYMUQHG2H0897d4HG1tD1sUREEeZhpMC5O+yMSpZxrq570
 TdJ4cRHv+Tl5zziXmvWm3g05plt+LtXYr9C9VXnDU4voiBjYo0DlyoF3mZbmEZUx0EEKq157R3e
 AK2cJtNS+ffjhGRhh+goMY2Ue94hQIa6gc/6OVAzJmrJTvNiv5PflL0IDmeK/BNdqtK9IM9cPND
 pG9DvXt9bT3nJxTyhXs7LXOwNJuXiwvN/Txjn1n0SaA/1THQ9ik0oBu0veKrureDsEDiG3+4pCd
 +TlrCa8lXMwBZTHMlDfGJ4y7wlQ2irie8nqjvJIFp1i7oepxmSh0AAeSptr6cEOQSS5xxC8ohbz
 uTvqPa+VBxaDC04PwHXhRkKN/tyXs12HOs7taZ4fSmv9auYr7mD4KSLzwVaNRFLx0nJJcpzJWPs
 TKvhzmpvJITEkxUlAtMoDD0WsUxMLnNvY9qKE2PjTB7Jxw9kldQU9sTzOLiTxGVOD8Xmq/XZpu9
 D8M=
X-Received: by 2002:a05:651c:509:b0:3a3:7682:49a0 with SMTP id
 38308e7fff4ca-3a5fc0a87b3mr11118821fa.21.1789825429162; 
 Sat, 19 Sep 2026 06:43:49 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru.
 [46.138.187.224]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a60767aa6asm6220941fa.40.2026.09.19.06.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 06:43:48 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/2] rtnetlink: pass extack to ndo_bridge_getlink()
Date: Sat, 19 Sep 2026 16:43:32 +0300
Message-ID: <20260919134333.49379-2-iprintercanon@gmail.com>
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

So the bridge can say why filling the link info failed.
No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c      |  4 ++--
 drivers/net/ethernet/emulex/benet/be_main.c    |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  6 ++++--
 drivers/net/ethernet/intel/ice/ice_main.c      |  6 ++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  5 +++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c  |  4 ++--
 .../ethernet/netronome/nfp/nfp_net_common.c    |  4 ++--
 drivers/s390/net/qeth_l2_main.c                |  4 ++--
 include/linux/netdevice.h                      |  5 +++--
 include/linux/rtnetlink.h                      |  3 ++-
 net/bridge/br_netlink.c                        |  3 ++-
 net/bridge/br_private.h                        |  2 +-
 net/core/rtnetlink.c                           | 18 +++++++++++-------
 13 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ca99f4b1a63c3..a752e66bf6368 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16154,12 +16154,12 @@ static const struct udp_tunnel_nic_info bnxt_udp_tunnels = {
 
 static int bnxt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 			       struct net_device *dev, u32 filter_mask,
-			       int nlflags)
+			       int nlflags, struct netlink_ext_ack *extack)
 {
 	struct bnxt *bp = netdev_priv(dev);
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, bp->br_mode, 0, 0,
-				       nlflags, filter_mask, NULL);
+				       nlflags, filter_mask, NULL, extack);
 }
 
 static int bnxt_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index ed302f5ec4768..cc9c87539a429 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -5011,7 +5011,7 @@ static int be_ndo_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 
 static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				 struct net_device *dev, u32 filter_mask,
-				 int nlflags)
+				 int nlflags, struct netlink_ext_ack *extack)
 {
 	struct be_adapter *adapter = netdev_priv(dev);
 	int status = 0;
@@ -5037,7 +5037,7 @@ static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
 				       hsw_mode == PORT_FWD_TYPE_VEPA ?
 				       BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB,
-				       0, 0, nlflags, filter_mask, NULL);
+				       0, 0, nlflags, filter_mask, NULL, extack);
 }
 
 static struct be_cmd_work *be_alloc_work(struct be_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index abbc71e815ae3..52c2b393aacd2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13151,6 +13151,7 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
  * @dev: the netdev being configured
  * @filter_mask: unused
  * @nlflags: netlink flags passed in
+ * @extack: netlink extended ack
  *
  * Return the mode in which the hardware bridge is operating in
  * i.e VEB or VEPA.
@@ -13158,7 +13159,8 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
 static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				   struct net_device *dev,
 				   u32 __always_unused filter_mask,
-				   int nlflags)
+				   int nlflags,
+				   struct netlink_ext_ack *extack)
 {
 	struct i40e_netdev_priv *np = netdev_priv(dev);
 	struct i40e_vsi *vsi = np->vsi;
@@ -13175,7 +13177,7 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 		return 0;
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, veb->bridge_mode,
-				       0, 0, nlflags, filter_mask, NULL);
+				       0, 0, nlflags, filter_mask, NULL, extack);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 707c7431b91a6..f98295438df78 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8095,12 +8095,14 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
  * @dev: the netdev being configured
  * @filter_mask: filter mask passed in
  * @nlflags: netlink flags passed in
+ * @extack: netlink extended ack
  *
  * Return the bridge mode (VEB/VEPA)
  */
 static int
 ice_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
-		   struct net_device *dev, u32 filter_mask, int nlflags)
+		   struct net_device *dev, u32 filter_mask, int nlflags,
+		   struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(dev);
 	u16 bmode;
@@ -8108,7 +8110,7 @@ ice_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	bmode = pf->first_sw->bridge_mode;
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, bmode, 0, 0, nlflags,
-				       filter_mask, NULL);
+				       filter_mask, NULL, extack);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f91856498eb2d..77dfd80a6e368 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10726,7 +10726,8 @@ static int ixgbe_ndo_bridge_setlink(struct net_device *dev,
 
 static int ixgbe_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				    struct net_device *dev,
-				    u32 filter_mask, int nlflags)
+				    u32 filter_mask, int nlflags,
+				    struct netlink_ext_ack *extack)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
 
@@ -10735,7 +10736,7 @@ static int ixgbe_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
 				       adapter->bridge_mode, 0, 0, nlflags,
-				       filter_mask, NULL);
+				       filter_mask, NULL, extack);
 }
 
 static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index fc110a7d16e8d..53bf79dbe08de 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5277,7 +5277,7 @@ static int mlx5e_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 #ifdef CONFIG_MLX5_ESWITCH
 static int mlx5e_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				struct net_device *dev, u32 filter_mask,
-				int nlflags)
+				int nlflags, struct netlink_ext_ack *extack)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_core_dev *mdev = priv->mdev;
@@ -5288,7 +5288,7 @@ static int mlx5e_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	mode = setting ? BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB;
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
 				       mode,
-				       0, 0, nlflags, filter_mask, NULL);
+				       0, 0, nlflags, filter_mask, NULL, extack);
 }
 
 static int mlx5e_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 7928e76da723e..cb751dddb6887 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2257,7 +2257,7 @@ static int nfp_net_set_mac_address(struct net_device *netdev, void *addr)
 
 static int nfp_net_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				  struct net_device *dev, u32 filter_mask,
-				  int nlflags)
+				  int nlflags, struct netlink_ext_ack *extack)
 {
 	struct nfp_net *nn = netdev_priv(dev);
 	u16 mode;
@@ -2269,7 +2269,7 @@ static int nfp_net_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	       BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB;
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, mode, 0, 0,
-				       nlflags, filter_mask, NULL);
+				       nlflags, filter_mask, NULL, extack);
 }
 
 static int nfp_net_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 2935c2ecc314b..f960cf5a97a29 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -935,7 +935,7 @@ static void qeth_l2_br2dev_put(void)
 
 static int qeth_l2_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				  struct net_device *dev, u32 filter_mask,
-				  int nlflags)
+				  int nlflags, struct netlink_ext_ack *extack)
 {
 	struct qeth_priv *priv = netdev_priv(dev);
 	struct qeth_card *card = dev->ml_priv;
@@ -949,7 +949,7 @@ static int qeth_l2_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
 				       mode, priv->brport_features,
 				       priv->brport_hw_features,
-				       nlflags, filter_mask, NULL);
+				       nlflags, filter_mask, NULL, extack);
 }
 
 static const struct nla_policy qeth_brport_policy[IFLA_BRPORT_MAX + 1] = {
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1f0710eef185b..02238b1e33453 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1360,7 +1360,7 @@ struct netdev_net_notifier {
  *			     u16 flags, struct netlink_ext_ack *extack)
  * int (*ndo_bridge_getlink)(struct sk_buff *skb, u32 pid, u32 seq,
  *			     struct net_device *dev, u32 filter_mask,
- *			     int nlflags)
+ *			     int nlflags, struct netlink_ext_ack *extack)
  * int (*ndo_bridge_dellink)(struct net_device *dev, struct nlmsghdr *nlh,
  *			     u16 flags);
  *
@@ -1659,7 +1659,8 @@ struct net_device_ops {
 						      u32 pid, u32 seq,
 						      struct net_device *dev,
 						      u32 filter_mask,
-						      int nlflags);
+						      int nlflags,
+						      struct netlink_ext_ack *extack);
 	int			(*ndo_bridge_dellink)(struct net_device *dev,
 						      struct nlmsghdr *nlh,
 						      u16 flags);
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 95729339e7a54..a408c36a7b558 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -222,7 +222,8 @@ extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				   u32 filter_mask,
 				   int (*vlan_fill)(struct sk_buff *skb,
 						    struct net_device *dev,
-						    u32 filter_mask));
+						    u32 filter_mask),
+				   struct netlink_ext_ack *extack);
 
 extern void rtnl_offload_xstats_notify(struct net_device *dev);
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index ae76df0de05a0..855a46aec3a89 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -680,7 +680,8 @@ void br_ifinfo_notify(int event, const struct net_bridge *br,
  * Dump information about all ports, in response to GETLINK
  */
 int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
-	       struct net_device *dev, u32 filter_mask, int nlflags)
+	       struct net_device *dev, u32 filter_mask, int nlflags,
+	       struct netlink_ext_ack *extack)
 {
 	struct net_bridge_port *port = br_port_get_rtnl(dev);
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 09c397e303307..edbe7a1f57363 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2179,7 +2179,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags,
 	       struct netlink_ext_ack *extack);
 int br_dellink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags);
 int br_getlink(struct sk_buff *skb, u32 pid, u32 seq, struct net_device *dev,
-	       u32 filter_mask, int nlflags);
+	       u32 filter_mask, int nlflags, struct netlink_ext_ack *extack);
 int br_process_vlan_info(struct net_bridge *br,
 			 struct net_bridge_port *p, int cmd,
 			 struct bridge_vlan_info *vinfo_curr,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e3444fd240615..a341e06f47d31 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5420,7 +5420,8 @@ int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 			    u32 filter_mask,
 			    int (*vlan_fill)(struct sk_buff *skb,
 					     struct net_device *dev,
-					     u32 filter_mask))
+					     u32 filter_mask),
+			    struct netlink_ext_ack *extack)
 {
 	struct nlmsghdr *nlh;
 	struct ifinfomsg *ifm;
@@ -5596,7 +5597,8 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
 			if (idx >= cb->args[0]) {
 				err = br_dev->netdev_ops->ndo_bridge_getlink(
 						skb, portid, seq, dev,
-						filter_mask, NLM_F_MULTI);
+						filter_mask, NLM_F_MULTI,
+						cb->extack);
 				if (err < 0 && err != -EOPNOTSUPP) {
 					if (likely(skb->len))
 						break;
@@ -5612,7 +5614,8 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
 				err = ops->ndo_bridge_getlink(skb, portid,
 							      seq, dev,
 							      filter_mask,
-							      NLM_F_MULTI);
+							      NLM_F_MULTI,
+							      cb->extack);
 				if (err < 0 && err != -EOPNOTSUPP) {
 					if (likely(skb->len))
 						break;
@@ -5646,7 +5649,8 @@ static inline size_t bridge_nlmsg_size(void)
 		+ nla_total_size(sizeof(u16));	/* IFLA_BRIDGE_MODE */
 }
 
-static int rtnl_bridge_notify(struct net_device *dev)
+static int rtnl_bridge_notify(struct net_device *dev,
+			      struct netlink_ext_ack *extack)
 {
 	struct net *net = dev_net(dev);
 	struct sk_buff *skb;
@@ -5661,7 +5665,7 @@ static int rtnl_bridge_notify(struct net_device *dev)
 		goto errout;
 	}
 
-	err = dev->netdev_ops->ndo_bridge_getlink(skb, 0, 0, dev, 0, 0);
+	err = dev->netdev_ops->ndo_bridge_getlink(skb, 0, 0, dev, 0, 0, extack);
 	if (err < 0)
 		goto errout;
 
@@ -5752,7 +5756,7 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			/* Generate event to notify upper layer of bridge
 			 * change
 			 */
-			err = rtnl_bridge_notify(dev);
+			err = rtnl_bridge_notify(dev, extack);
 		}
 	}
 
@@ -5827,7 +5831,7 @@ static int rtnl_bridge_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			/* Generate event to notify upper layer of bridge
 			 * change
 			 */
-			err = rtnl_bridge_notify(dev);
+			err = rtnl_bridge_notify(dev, extack);
 		}
 	}
 
-- 
2.43.0

