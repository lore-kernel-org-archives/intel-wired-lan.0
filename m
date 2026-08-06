Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC401C5AC7A
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 23:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C64180F89;
	Thu,  6 Aug 2026 23:29:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cuPSIlnpz7G0; Thu,  6 Aug 2026 23:29:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8F1680E51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786058965;
	bh=Lhh70WyOc/d5qzjw6H29xHEqh1T/3dX0IfBg7BkrsEA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yWt8ZXjB1x39uV7ofGrW9znr3s0xgC/y6p4Ily+bj8mNEMBId5bzEcxiixPQJDdVZ
	 LCOVI8ZWioI008Zvymmtmk6PUXbVS6ltsvGk+laHMBAh0HWAZ2rDPcGFjSgvAIcoDd
	 2qkSeCD/Ba1mCZCyOjrduLop67tNkuIfrbPm3WWJjAcJ6RaG46e8BUeKwYX8OwdPpt
	 1jRbAK4w+evYy+zYGJmjjw8DFrtotVUx+6sjoA3caNqLWJhhx8He/rToLfds1c1wwC
	 dI/4I7Q6jDVxCNWOxtkwQxTgoEgAMS84GswW/RLCF9qHJEt3h/ta5B4Or9XWI55TDn
	 shmEbIXJ2PLUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8F1680E51;
	Thu,  6 Aug 2026 23:29:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D80A5392
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE131408F4
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wFAUur8v-WGb for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 23:29:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C1D5A408AB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C1D5A408AB
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1D5A408AB
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:22 +0000 (UTC)
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-667971437d6so3774981d50.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 06 Aug 2026 16:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786058961; x=1786663761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lhh70WyOc/d5qzjw6H29xHEqh1T/3dX0IfBg7BkrsEA=;
 b=YR0CZ04pjZkV6StnjTrpW1tdtNFdmhP4jEyHdibML6u1qCSFQRVBJx4ku/ThcHakvn
 b6HparQcCSruVsX9/Ym78a1ueDYF9gOQSNKZ6u8B4ywuzdTT6XTTr+KhvDgLyv7SzxrP
 B1RYkkOL2AWVSf2/gdQhgXT4VLZ7nL6f/xNKdEI1HVXX+CJWlgFbCMAZNHZAQaaK4TuT
 nHp/D0rZklCgmY+1gE3mC8h+vrxZOPVHakMcqvucl+vObLWUwdxkSkldZpxv2nayIkl/
 e7CkVPsMK9QOUWAocZXfGgO4ryFnYg/nh7yck3/cbmxOYt5kl/pDYdtRIAZsDmOeNpFz
 J6Fg==
X-Gm-Message-State: AOJu0YysyyMPJtn7VoQawRg6ruojknE4XQgcd0ty2K04RTBlxYExYMwE
 Rh+dRoaC67AUh4BL4b3TKSMXP22P5Df9+jowIf2ElkS8OaNrGpGDc1vD
X-Gm-Gg: AR+sD11l3UU9n46nvGirKjPeqSnQU3O9UKaDhJEr/jqG0ByGWjrSkLV27LedNSvdYPr
 9dQk8rNmIH72XqCsQ5o3BRWlJ3JS5/dXvSPURkrru8+UuFLV/dniXI4I/IqR34X3eMCYkoXy18x
 gL8642GyhlvciVUmTcUPuiCWIYkszz89SYwxBKv9mt0c2ZxamhkgnNZ4BP+is4UzRqsXq59/AzK
 +uQpeQ5nbvDkduZWD5ESQF+B+DFTt/hXOqCgPbdUqe41h/ugk3wONgqymaOusMIeVzYiKkL7VVK
 3uNd2K/q2Nq+42kR6Fei1u4R45T0fr6rD6d3yt2i4l4IAkNTmoyCx56HepbVcQbRHREEMGvcX4H
 VLLURJEZdK8++8a6ibuGz8fyvK3oaKYQ7V5ViOvIwNr17SeaBiUkv0zxkWMNVnizSJgYFFJ/B8G
 +kFvS1QepDkm/z4kENCg7aHpx59FXgRAg2SKlDqYrH6ftSM9tc96Cx/yNzn6xV7d5yoiV7FR8zi
 7C9vI0myMefxsETWNRep6sDS3BhPtNAWzcMfGaLiWf5JTGntPH702TLRzNbyL42UG5CYtI=
X-Received: by 2002:a05:690e:5c4:b0:667:e80e:1b2f with SMTP id
 956f58d0204a3-6699aacc63cmr9316778d50.39.1786058961394; 
 Thu, 06 Aug 2026 16:29:21 -0700 (PDT)
Received: from willemb.c.googlers.com.com
 (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66acacdbdf2sm209273d50.4.2026.08.06.16.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 16:29:19 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 joshua.a.hay@intel.com, przemyslaw.kitszel@intel.com,
 Willem de Bruijn <willemb@google.com>
Date: Thu,  6 Aug 2026 19:25:58 -0400
Message-ID: <20260806232913.4020403-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786058961; x=1786663761; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lhh70WyOc/d5qzjw6H29xHEqh1T/3dX0IfBg7BkrsEA=;
 b=DA3XPBpldIrO/fO/vou2LB/YAxpZm9YoAEfRYqqBFL9OINhGwjpUE0qrVW5E2kQwcR
 AZks//6TIH7PobrF7/QjKehnwqnJGHLaWk0hC9Ut9ntS3B2j+xljGRhdNyLwSHHpC7hy
 E8hYXhDbi9av1aC1fwmLGR/DtBJlOQ7qrPttFKb+ZzTOeOEOcqteV8eJ53i4lzu7JVcF
 BPtk/zRV74JIW37oKK3Y6WGIIUjS/Vn3UAvw43JmyDQANcbSW0vm7gKm/6sx80gmM9Sl
 12mgBInJySFqzIXo0YFb2IeDPYxgKGGXWtuWtwiE1d8oE0elZ2ZajjqEX41MBET7H2q0
 wZ7Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DA3XPBpl
Subject: [Intel-wired-lan] [PATCH net-next v4 1/6] net: rtnetlink: add
 pacing_offload_horizon attribute to net_device
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Willem de Bruijn <willemb@google.com>

The 'max_pacing_offload_horizon' field of 'struct net_device' represents
the maximum pacing offload horizon supported by the device.

Add a new field 'pacing_offload_horizon' to store the active pacing
offload horizon.

The new attribute is initialized to 0 (disabled) and can be set from
userspace via RTM_SETLINK up to dev->max_pacing_offload_horizon. This
new default off behavior does not cause regressions, as no driver yet
advertises max_pacing_offload_horizon.

The equivalent RTM_NEWLINK is absent, as a value may need to be
compared to a device maximum, which may be negotiated with the device
firmware on init, as is the case for the idpf driver in this series.

Make both fields u32, to maintain net_device cacheline layout. This
expresses up to 4s of pacing offload, which is sufficient.

Update the YNL specification ('rt-link.yaml') to add the
'pacing-offload-horizon' attribute and include it in link-all-attrs.

Both fields can be read with

    python3 tools/net/ynl/pyynl/cli.py \
        --spec Documentation/netlink/specs/rt-link.yaml \
        --do getlink \
        --json '{"ifname": "eth0"}' | grep pacing

And the active horizon set with

    python3 tools/net/ynl/pyynl/cli.py \
        --spec Documentation/netlink/specs/rt-link.yaml \
        --do setlink \
        --json '{"ifname": "eth0", "pacing-offload-horizon": 50000000}'

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/netlink/specs/rt-link.yaml      |  6 ++++++
 .../networking/net_cachelines/net_device.rst  |  3 ++-
 include/linux/netdevice.h                     |  4 +++-
 include/uapi/linux/if_link.h                  |  1 +
 net/core/rtnetlink.c                          | 21 +++++++++++++++++++
 5 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 68c26a70bb64..a620135baba3 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1080,6 +1080,10 @@ attribute-sets:
       -
         name: tailroom
         type: u16
+      -
+        name: pacing-offload-horizon
+        type: uint
+        doc: EDT offload horizon setting for the device (in nsec).
   -
     name: prop-list-link-attrs
     subset-of: link-attrs
@@ -2548,6 +2552,8 @@ operations:
             - devlink-port
             - gso-ipv4-max-size
             - gro-ipv4-max-size
+            - max-pacing-offload-horizon
+            - pacing-offload-horizon
       dump:
         request:
           value: 18
diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 512f6d6fa3d8..90e257e815b1 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -183,7 +183,8 @@ struct devlink_port*                devlink_port
 struct dpll_pin*                    dpll_pin
 struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
-u64                                 max_pacing_offload_horizon
+u32                                 max_pacing_offload_horizon
+u32                                 pacing_offload_horizon
 struct_napi_config*                 napi_config
 unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 62cfad7e6b79..93d953caae94 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2131,6 +2131,7 @@ enum netdev_reg_state {
  *		   where the clock is recovered.
  *
  *	@max_pacing_offload_horizon: max EDT offload horizon in nsec.
+ *	@pacing_offload_horizon: EDT offload horizon setting in nsec.
  *	@napi_config: An array of napi_config structures containing per-NAPI
  *		      settings.
  *	@num_napi_configs:	number of allocated NAPI config structs,
@@ -2553,7 +2554,8 @@ struct net_device {
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
 
-	u64			max_pacing_offload_horizon;
+	u32			max_pacing_offload_horizon;
+	u32			pacing_offload_horizon;
 	struct napi_config	*napi_config;
 	u32			num_napi_configs;
 	u32			napi_defer_hard_irqs;
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 43cecca49f01..7c1d7754a670 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -381,6 +381,7 @@ enum {
 	IFLA_NETNS_IMMUTABLE,
 	IFLA_HEADROOM,
 	IFLA_TAILROOM,
+	IFLA_PACING_OFFLOAD_HORIZON,
 	__IFLA_MAX
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 31c65a545a10..b8c35f64d49f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1381,6 +1381,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + rtnl_devlink_port_size(dev)
 	       + rtnl_dpll_pin_size()
 	       + nla_total_size(8)  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
+	       + nla_total_size(8)  /* IFLA_PACING_OFFLOAD_HORIZON */
 	       + nla_total_size(2)  /* IFLA_HEADROOM */
 	       + nla_total_size(2)  /* IFLA_TAILROOM */
 	       + rtnl_dev_parent_size(dev)
@@ -2156,6 +2157,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 			READ_ONCE(dev->tso_max_segs)) ||
 	    nla_put_uint(skb, IFLA_MAX_PACING_OFFLOAD_HORIZON,
 			 READ_ONCE(dev->max_pacing_offload_horizon)) ||
+	    nla_put_uint(skb, IFLA_PACING_OFFLOAD_HORIZON,
+			 READ_ONCE(dev->pacing_offload_horizon)) ||
 #ifdef CONFIG_RPS
 	    nla_put_u32(skb, IFLA_NUM_RX_QUEUES,
 			READ_ONCE(dev->num_rx_queues)) ||
@@ -2324,9 +2327,11 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
 	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_MAX_PACING_OFFLOAD_HORIZON] = { .type = NLA_REJECT },
 	[IFLA_NETNS_IMMUTABLE]	= { .type = NLA_REJECT },
 	[IFLA_HEADROOM]		= { .type = NLA_REJECT },
 	[IFLA_TAILROOM]		= { .type = NLA_REJECT },
+	[IFLA_PACING_OFFLOAD_HORIZON] = { .type = NLA_UINT },
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
@@ -2800,6 +2805,13 @@ static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[],
 		return -EINVAL;
 	}
 
+	if (tb[IFLA_PACING_OFFLOAD_HORIZON] &&
+	    nla_get_uint(tb[IFLA_PACING_OFFLOAD_HORIZON]) >
+	    dev->max_pacing_offload_horizon) {
+		NL_SET_ERR_MSG(extack, "too big pacing_offload_horizon");
+		return -EINVAL;
+	}
+
 	if (tb[IFLA_AF_SPEC]) {
 		struct nlattr *af;
 		int rem, err;
@@ -3317,6 +3329,15 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
+	if (tb[IFLA_PACING_OFFLOAD_HORIZON]) {
+		u64 horizon = nla_get_uint(tb[IFLA_PACING_OFFLOAD_HORIZON]);
+
+		if (dev->pacing_offload_horizon ^ horizon) {
+			WRITE_ONCE(dev->pacing_offload_horizon, horizon);
+			status |= DO_SETLINK_MODIFIED;
+		}
+	}
+
 	if (tb[IFLA_OPERSTATE])
 		set_operstate(dev, nla_get_u8(tb[IFLA_OPERSTATE]));
 
-- 
2.55.0.679.g6767b8d81c-goog

