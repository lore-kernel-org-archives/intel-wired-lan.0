Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D523C88E78
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 15:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38E7F404A8;
	Mon, 14 Sep 2026 15:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ijum2FSrnY_a; Mon, 14 Sep 2026 15:25:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0DEB9405F3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789399546;
	b=ASJqJIM+R80c12uj5nfkeurL5Eryd4V042hDmD51Odj5AY+WqenrZt5+fwlw6eh5z7Mw
	 HvVigX0e31bbIfw7EfJdxZTLM5+Kbidg1MWYP9E+gEDvQi48PLcm8X0uXwlMCTQW5Ykv6
	 rMoPI6sqrAN+9wl5/rPnaiNFR1zBTS6hfx8Hxb2MOa/qIsaTJNAQLOgx309WMuN19LidX
	 zarZIhAuu31/tQ5vF7W5NtizQxP74ApUnVa6QPJf+jWJODsDfDb9CCAJGttfJ44yIMlm5
	 WkAou84vJ8BosNWQt+3lEkbQf+FpRufBMew78jrdt/EUEsQwGZJLuRTljkra4AewXmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789399546;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y5bfO3aVxyQqkN/+edIPBHMp3Bhz/WilPPvcS2a/7bI=;
	b=d4DB75ENJNLbekPctkGCwdjpa5tIivTVJRMDXBgnF54jnrgP6o9CjW8ncn5k1Mbz4ytF
	 5AhfODb7+I5bHqJMfQRRO/VACYla0k6257vpaO/GUutui76NMhhgzs4g/jz6LJe53of3N
	 h7Dbzv5T1Z/nKgCK1luD3r1uVnO7chViLb8vDNJ+HBJ1YjECMA6JY2GQ6Z2RMBF9TMVP6
	 0FpTNuylofW10we3oRMxQP5+Kl8IncSPPtpO7HvxOZQYTT3LrbGc4dKjpjObqMXJQyxXF
	 CiYSRIsRoXyyL4l5JQCFRF0y86GjQmg7OjosrRyx+/u5ZLRNJ97vUROtHepVZBC9Zug==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789399546;
	bh=y5bfO3aVxyQqkN/+edIPBHMp3Bhz/WilPPvcS2a/7bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j5EmmAj7nUrRk6cWBNalVse1WRI4SYWLY5oA1Ea8K/fcWubRDA3pWCIc1KypyzIdn
	 Sh0PbnOq3tFzoJS95aI+JnhHkOX6EFluJoyOkfsJ6bpT/kM7jvYqQeTwEz8ehzYl7n
	 xkPz/tIPH4Li4hk9i9AL5Ube6eg+jCR6BJLs0d6UmH+aeQIAYZXcVcNNh8XX5o/gNz
	 tMqs33nMRTV3aIMCo4MC3tf5I07r4pkydlcFPpAllL2VyYvHF75QZ/Ft1DwIQapX3/
	 JKsWXGdsW6HnosTRRDB5fbFPOG6Sphx7AcrTPTCqyd3mWen4m7RaTKmfY0Oy25V8IF
	 ui44X+ug/LpDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DEB9405F3;
	Mon, 14 Sep 2026 15:25:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 41DEDEB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 13:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2838A60614
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 13:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 23TsHTqXyvKd for <intel-wired-lan@lists.osuosl.org>;
 Sat, 12 Sep 2026 13:50:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9770860617
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:36::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789221040;
 b=Oa7JUsBeh9kefzvx3qISxJXW5vV3JFp9I2pS7nA0bil+P4FaksFxUez2HR2PpPg/Nigb
 kRmQ4n8t8CkNIPBZM20p3/jG+1O4LhCGLubtnwF4MRJm/VDwe0PC331Lw0H+hq0eLs1JB
 +lmswReMnxqAS77/s8aEr/Sms0rxEoxgdrJ0A7HWs9terBmg0NVzQoG2iduTgfkyDxNyQ
 Hi8pFab0MaCDkWOLR4KVe3mjp3Hin6rAHuIP0hxs+lORJ3HBqq3QAcpbcpcxNMUiwbPEa
 3oCiocfXa+6nECbByOEQnv+Zbg9/CKfiOQGcykVpwtIukkBskh082tS/2L2W/LSgfxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789221040;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=y5bfO3aVxyQqkN/+edIPBHMp3Bhz/WilPPvcS2a/7bI=;
 b=MdbXlYjOw3cDjQhnWGHQke3llvWUIx53f5lxWGtEF4BQ6d/zHtLyrfGPHsUswlJECUcd
 dHOIY3GV6ljiblI4nj0SHU/t3sFvtnX0XZESPMY14y7M2+pF2j9WPq3BHJ+A+EAhYTW9v
 hjj/mNPRJkTbqoNACwAsXw2xJ9EzFcUzz/PEkqIul0ygSzSvHE516A1ldHbWvobWajise
 FPGDFmbCbRZ0ldXt/DbE/krg/vI21ogwab7l/uKQGQI1cNDEuj+8ohe19V2ieD+lCx8eF
 2gM9mezT+fIBqmxD1LeJy39PrWan1NafqpZUj21VcdIDlg9zC6bL7IIvZ/npxy3U/Ug==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=H46CilkN; 
 arc=none smtp.remote-ip="2a00:1450:4864:36::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::10; helo=mail-lf2-x10.google.com;
 envelope-from=iprintercanon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=H46CilkN
Received: from mail-lf2-x10.google.com (mail-lf2-x10.google.com
 [IPv6:2a00:1450:4864:36::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9770860617
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 13:50:39 +0000 (UTC)
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b5e4f16f12so888928e87.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789221037; x=1789825837; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y5bfO3aVxyQqkN/+edIPBHMp3Bhz/WilPPvcS2a/7bI=;
 b=H46CilkNTYZOgBIJCpwFBSeLOzuwo76I13jNQTV4h1AF6lvOjafqVrWeVH09wE1vIg
 fgK3MyIEcFEjQY5uDv3Cn4J+xHY5ufUGXkUZfYFGPkPxz2Wm35FzHYvc6f2mqG/2q2fv
 N/+Gu/2m6Ek41953UWUKcYVglxPGFegpXS7lS6emb3JRyrUiRf1l6/3zoSiQrIfKNwXD
 ej0AYqPCAQhMtlIGjC7V9jV+A6lDbT66fafIdh6WO1yLK++S1CCB1jGNCjj3fasY+Oqs
 YsqaxULGs2adGAvy3vT4mrdPQ8BrwpB659XPLFIji15gfQh6A5XWSh32s0+gvAGVQGfN
 +Xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789221037; x=1789825837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y5bfO3aVxyQqkN/+edIPBHMp3Bhz/WilPPvcS2a/7bI=;
 b=b9Tcvx0p48iPpxD2mW+NX22KW0x8QWWjh7SdlZxrbDoPfZROUVz2Z53xMsQxmh5irc
 WcVUA+twikyJOgq8ad9BMWLR+aFoRABee6u5VzHQBj4OL56elJjre8QAKzzw/kFC890y
 iPMTryjonlL0L8xtWFR4r4qP57+0O8ygy9EDLrgNET8n7/nbC5Y6P1ZZi8sC89k6QAEq
 bpo/e/hlaxlck1sSPoLwT6skTZozpb3/BJTlQxQb7PHEUqDVLaTlnoh6TZS0L9l6OkRu
 8SOFmTucWhQDI5OW44ZYecX3A/l/a5JwNVeled6wjUKeBPFLuKx6R8toe+mmFLtFtgQZ
 ZqYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUlkXdk3In0pgF+tu8lef2QTkMwF3i84Q+BP8p+xVmCi5l+9xArTm7XFdS6HfV9rjXQG6rtwr/3A/xihy4wTs=@lists.osuosl.org
X-Gm-Message-State: AFuF++lH1ntWPWYAQA3twOCSO6ySrL3qcA5HYwVST2NficXxw1Rmav2w
 NRUhwGTFW3yOpzFynmVYI83RLap5JmX5tn72EgQ/IkovbQGul9D4x5l9
X-Gm-Gg: AYBFou3JiAq/RCpYYXAhX9LyhgaUl3/hR4WqS34bw7f9Mm+L+WB7ATD/s1UCcM2mfOy
 i0lnqY79bUVQXO5L6gYhwoOgFKVGxQB3C2xeFbF+JFmVIjca3Kyi1fT3wcEYzXjnwXIc1YJdJPx
 GyV2l7o0fJ9t4t0h3a4mVPvG+sOAc7hlwxSchXX0eSEAtuS/rztNNQZt9XDMXfvhqFsNEiag1L9
 UGL1tPnspC0U3gBmnGazDo2TBkf9ePxvsfc3m4p0Rb7+4izeNBN7O9s5IHa6gd0GfqRHsZL/+xJ
 GYQW5bG42GK7rqGN34J9Lj6nHlwgQnHpjWgWg/e8RY9yqNPl56sikCil5iqmo48ZmtWUA8MCmY9
 WEMbyoVdC/Fei7CghhTe719/rE24oNOyS8bgFg6Xm7JQ5izgi+FYX5Tw4Fa2dDdPymM5JspVqaj
 pWQkxLxu8G2tsiUGwTXCZzC0owNnOorXYCdlx3q+KfptbzfS3rFDp2AuPp+eQFrwgpJdPXkRFpP
 WQbjBHQGkgOJryFcxUj13TZQ5s0GfVzSWiiERkGb+Dg+QZw0MTR5CerWiyVdwtP00pW
X-Received: by 2002:a05:6512:3f23:b0:5b6:6af:4e0e with SMTP id
 2adb3069b0e04-5b8a02dccabmr3745340e87.3.1789221036430; 
 Sat, 12 Sep 2026 06:50:36 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru.
 [46.138.187.224]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0457246sm1257770e87.23.2026.09.12.06.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 06:50:36 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] rtnetlink: pass extack to ndo_bridge_getlink()
Date: Sat, 12 Sep 2026 16:50:21 +0300
Message-ID: <20260912135022.1701-2-iprintercanon@gmail.com>
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

Let the bridge report why it could not fill in the link info for a
port. rtnl_bridge_getlink() passes the dump extack, rtnl_bridge_notify()
gets one from its setlink and dellink callers.

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
index fe47ec0ba8094..038ce1fe5bfe5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8086,12 +8086,14 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
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
@@ -8099,7 +8101,7 @@ ice_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
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
index 707b2e51c2b97..18a03f0f6f113 100644
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
index be9d1625bac31..967b587ef6648 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5398,7 +5398,8 @@ int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 			    u32 filter_mask,
 			    int (*vlan_fill)(struct sk_buff *skb,
 					     struct net_device *dev,
-					     u32 filter_mask))
+					     u32 filter_mask),
+			    struct netlink_ext_ack *extack)
 {
 	struct nlmsghdr *nlh;
 	struct ifinfomsg *ifm;
@@ -5574,7 +5575,8 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
 			if (idx >= cb->args[0]) {
 				err = br_dev->netdev_ops->ndo_bridge_getlink(
 						skb, portid, seq, dev,
-						filter_mask, NLM_F_MULTI);
+						filter_mask, NLM_F_MULTI,
+						cb->extack);
 				if (err < 0 && err != -EOPNOTSUPP) {
 					if (likely(skb->len))
 						break;
@@ -5590,7 +5592,8 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
 				err = ops->ndo_bridge_getlink(skb, portid,
 							      seq, dev,
 							      filter_mask,
-							      NLM_F_MULTI);
+							      NLM_F_MULTI,
+							      cb->extack);
 				if (err < 0 && err != -EOPNOTSUPP) {
 					if (likely(skb->len))
 						break;
@@ -5624,7 +5627,8 @@ static inline size_t bridge_nlmsg_size(void)
 		+ nla_total_size(sizeof(u16));	/* IFLA_BRIDGE_MODE */
 }
 
-static int rtnl_bridge_notify(struct net_device *dev)
+static int rtnl_bridge_notify(struct net_device *dev,
+			      struct netlink_ext_ack *extack)
 {
 	struct net *net = dev_net(dev);
 	struct sk_buff *skb;
@@ -5639,7 +5643,7 @@ static int rtnl_bridge_notify(struct net_device *dev)
 		goto errout;
 	}
 
-	err = dev->netdev_ops->ndo_bridge_getlink(skb, 0, 0, dev, 0, 0);
+	err = dev->netdev_ops->ndo_bridge_getlink(skb, 0, 0, dev, 0, 0, extack);
 	if (err < 0)
 		goto errout;
 
@@ -5730,7 +5734,7 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			/* Generate event to notify upper layer of bridge
 			 * change
 			 */
-			err = rtnl_bridge_notify(dev);
+			err = rtnl_bridge_notify(dev, extack);
 		}
 	}
 
@@ -5805,7 +5809,7 @@ static int rtnl_bridge_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			/* Generate event to notify upper layer of bridge
 			 * change
 			 */
-			err = rtnl_bridge_notify(dev);
+			err = rtnl_bridge_notify(dev, extack);
 		}
 	}
 
-- 
2.43.0

