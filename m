Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443981077608
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Mar 2026 18:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED8124170B;
	Wed, 18 Mar 2026 18:56:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ez_PAOxbWovq; Wed, 18 Mar 2026 18:56:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12E8340BDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773860202;
	bh=PfderLH1PeQJs9EdZnKIFcadn6yQyUif1ZtSb/oqtWI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hqwU4oex6fqcDwf8v4QGN/l7R/YaeHVUNhuPzg9oAakFwzNl61u2YYGSCbJggLnfE
	 DWXIhNvfZ/WsmvrxrD7uVgLfMyigNb0D+nVgRaVw5hGvTXwtyRBc/cHML2F4URgu49
	 oBWmn/bPgr9nyvGqt33A308EzVoj7kJvHZvJcbqW9FqYTShKmYRDb1U+9MvUqH/nxv
	 Oyi5WHSHE6hFt9TZ2McLEhFPdtm/ZoeBe9gOhcmN6jrRRw06/Sdx9CU8IOYGwVcNt5
	 vm0NRG55LGfBmXz7CVQ9CiHoPGhj/ibwNqEKQHqeeKD9g5eUxNBRemWNh4dnkX7BOr
	 YM7w6/vqBkPuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12E8340BDB;
	Wed, 18 Mar 2026 18:56:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D0371B6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 18:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 724EA404AC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 18:56:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oE2YFxewWwbO for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Mar 2026 18:56:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1EC4B40494
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1EC4B40494
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1EC4B40494
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 18:56:39 +0000 (UTC)
Received: from x1 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62IIuJEi017320
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 19 Mar 2026 03:56:20 +0900 (JST) (envelope-from kohei@enjuk.jp)
Date: Thu, 19 Mar 2026 03:56:19 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <abrzq5_S7p-YjqhE@x1>
References: <20260318163505.31765-1-aleksander.lobakin@intel.com>
 <20260318163505.31765-4-aleksander.lobakin@intel.com>
 <abripOPt4oVu-Ksb@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abripOPt4oVu-Ksb@x1>
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=PfderLH1PeQJs9EdZnKIFcadn6yQyUif1ZtSb/oqtWI=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1773860181; v=1;
 b=K0asMe8Bso9Ms0gHC0knLQXE0V905i2fkm+90GcE7+0yepNdl+XmgToKCnGULFcJ
 ng37HOG9o0RqNOvcPHe6FxthSU0ruaSbaOjTjMWc6jrup+ZIuI5+P+nyICZdi8sC
 8uZnLzl58iIgVwVI66oBM6DRvEZrr2hhYnj5fQgAwphdIhNwZT14odCzsFkCLInS
 oZI+yZOjHQqgoWPmT/GG44VKldi9ne0pvv5vaH7TjZZXOhAGgQhE7Wr0QL7Gz4Ov
 XOkoPceBg7+z2T0C/ooHjZexfYMZyTVdZxMDVKuuq9eDwpI/YPqpjGg3cYxrx43k
 V7HbXxXEhU9UckYddlT9eQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=K0asMe8B
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 3/5] ice: migrate to
 netdev ops lock
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

On 03/19 02:55, Kohei Enju wrote:
> On 03/18 17:35, Alexander Lobakin wrote:
> > Queue management ops unconditionally enable netdev locking. The same
> > lock is taken by default by several NAPI configuration functions,
> > such as napi_enable() and netif_napi_set_irq().
> > Request ops locking in advance and make sure we use the _locked
> > counterparts of those functions to avoid deadlocks, taking the lock
> > manually where needed (suspend/resume, queue rebuild and resets).
> 
> Hi Alexander,
> After applying this patch (3/5) along with the preceding ones on top of
> net-next, I got some WARNING splats when changing the admin state
> (up/down) using the ip link command. [1, 2]
> 
> Since I haven't looked into this series in detail, I'm reporting the
> splats anyway. 
> I'm wondering why I haven't seen anyone report this type of issue up to
> v3. Maybe there is something wrong with my setup or devices?
> 
> Device: Intel Corporation Ethernet Controller E810-XXV for SFP (rev 02)

Ah, I think I figured out the reason. My adapter accidentally fell into
safe mode. When the adapter is in the safe mode, netdev->queue_mgmt_ops
== NULL and netdev->request_ops_lock == false, so
netdev_assert_locked_or_invisible() complains about not holding the
netdev lock.

Setting netdev->request_ops_lock = true in the safe mode path also
worked fine for me.

---
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9ef258d5ab48..3477c53316ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3519,6 +3519,7 @@ static void ice_set_ops(struct ice_vsi *vsi)

        if (ice_is_safe_mode(pf)) {
                netdev->netdev_ops = &ice_netdev_safe_mode_ops;
+               netdev->request_ops_lock = true;
                ice_set_ethtool_safe_mode_ops(netdev);
                return;
        }
