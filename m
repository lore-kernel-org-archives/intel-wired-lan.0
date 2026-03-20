Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6DC109879E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 15:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6502240AAA;
	Fri, 20 Mar 2026 15:42:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0a-Y4s4SiE39; Fri, 20 Mar 2026 15:42:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F97440AB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774021334;
	bh=Qhx7QtPFHsmhBqKEQ6XlDZutQ+YSTAHptMBIGgI83fw=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1NtfpSgB85ZKLm6bQNskec/EgwM1cm+IHDTxpVmeyj7lcK+H+cnfKmNquJVf/0ORl
	 0+dzQvthPov90GHPyTsVeCtQ27nNiJlSGpA7lwTW4tUgt0Tau0QqP7x+o9fNhbkZAa
	 +l/RRLPL5XxglVzFSk8uJWItVThkHrOdGbY2/8kwzX/SIsJuuDtSWdm3PBimcM2A3k
	 l3xkVjXatYUWODR+DvrZGhM9BIEWp63h+6QAOYwlmtaxl006xE175PubwX1QinJK3q
	 y/ClwGKlaGgE6qHB/3eWoe33qCok51bOMesj1A1eQENmLhS3DNzA4/a8X0dN6p0/lq
	 +PLv80KPmc9CQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F97440AB0;
	Fri, 20 Mar 2026 15:42:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D92CE1B6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 15:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BEF836087D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 15:42:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BD8TTDpk1kGy for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 15:42:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com;
 envelope-from=stfomichev@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D1BD660752
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1BD660752
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1BD660752
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 15:42:11 +0000 (UTC)
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2c107ef474fso230108eec.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 08:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021331; x=1774626131;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qhx7QtPFHsmhBqKEQ6XlDZutQ+YSTAHptMBIGgI83fw=;
 b=n/Uc/fnjZRqx++PthS4gRcEQg+TSXB3h3N3vrcInf/UgY4d0CjqVPsT14TyCR8SDjs
 kunXzC1pE2LA9LtAItux0xW5nuubEn/08AJRRy5PpvYOKA96kONVj50h0MDximTNSmEB
 /DrvhhPTnfq5yr4WsfnFVnRmKSxVUt1jqlUEJultbbDFST3ECLJFj/rI5qhLlsxYNq1E
 7/5LL9u7gjOS6WJ3p2QxiWH5lzBG+y9sMLXLQ0TyOenlRAHqt8FO3Eyj5gGUGJrpJKmw
 Jwz6rYt5RPjkAx6z47dCZaAWBeIBDm6aSl+TOMZDHFfajpC2Q/m1/QM2Z+81DK5ZbUfp
 iCVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxwo6KQwGkPrbR7or44P+Csmmr2FfPpTrVOR52L4vfPFUw0ZJzXHVFjz/IAp9Ex1QWk1VRTbYfsUVJ63uVikU=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yy7bF7HK3/9MiUWMs38015v9RJBSKa5hrygrV4osNpJxdQZZjZO
 M/81Gs00rcED/eLv9isJsKEtvgtgm7Szcu1AUB8p6IDwf8FJPJB26EM=
X-Gm-Gg: ATEYQzyHzVIEhJ7jOrw6nRVFPMNwd89/Irr1QoRHvy5wGTeG03PvFKQV77vRQr9LRwK
 bJUx+2g/aAirBWftHSyK3qzf/35yIjM7vGroXb4tpM9gXWEyWiB33q24bytU3Af9oR9+v6MxtxD
 Y2hM2C3nuGFUHyd5qRXNs1po/uAkmNCmK7cfNmJ34gqQh1xpDog/boGL0bQMs1fVzW/9MiZGbmp
 2whBIkrwmfwgMNbDqFYM2nzN0vjQOjiwEVF8alxrndu1g1+INeoRKgoWatcqU7ye2BX8HitK46T
 4y8T1CelM+S5hP6vLqFpx98pD5Sw0zHMrmnH01JC/3v8s/nvlGiuCyl3gRfPTaJtJ9cf+eVtBYu
 VFqbw4Bue8aeQ/P2dxUt74nL5zoL87WwAllQcVL3lyYIvb1Ua5VmPmJ+mqkB62K4BfAmspeekj0
 VG1bN5ipjhaJGDV80qHwjzN79/j0e9DVWdrKmp2T8gDi8eT/1WwcJd66YiPOTmpWshfH8eCRxpH
 1WvSMQDS6J6/94z6CZ4ci6QMjT2
X-Received: by 2002:a05:7300:5b88:b0:2b7:32a6:82d1 with SMTP id
 5a478bee46e88-2c10962a891mr1874265eec.13.1774021330366; 
 Fri, 20 Mar 2026 08:42:10 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14bac4sm4502825eec.4.2026.03.20.08.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:42:09 -0700 (PDT)
Date: Fri, 20 Mar 2026 08:42:09 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "sdf@fomichev.me" <sdf@fomichev.me>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "bestswngs@gmail.com" <bestswngs@gmail.com>,
 "kernel-team@meta.com" <kernel-team@meta.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
 "willemb@google.com" <willemb@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "skhawaja@google.com" <skhawaja@google.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, "kees@kernel.org" <kees@kernel.org>,
 Jianbo Liu <jianbol@nvidia.com>,
 "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "leon@kernel.org" <leon@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
 Mark Bloch <mbloch@nvidia.com>, "sd@queasysnail.net" <sd@queasysnail.net>,
 Tariq Toukan <tariqt@nvidia.com>,
 "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "aleksandr.loktionov@intel.com" <aleksandr.loktionov@intel.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Message-ID: <ab1q0aEaGmocJogG@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
 Cosmin Ratiu <cratiu@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "sdf@fomichev.me" <sdf@fomichev.me>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "bestswngs@gmail.com" <bestswngs@gmail.com>,
 "kernel-team@meta.com" <kernel-team@meta.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
 "willemb@google.com" <willemb@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "skhawaja@google.com" <skhawaja@google.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 "kees@kernel.org" <kees@kernel.org>,
 Jianbo Liu <jianbol@nvidia.com>,
 "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "leon@kernel.org" <leon@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
 Mark Bloch <mbloch@nvidia.com>,
 "sd@queasysnail.net" <sd@queasysnail.net>,
 Tariq Toukan <tariqt@nvidia.com>,
 "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "aleksandr.loktionov@intel.com" <aleksandr.loktionov@intel.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-7-sdf@fomichev.me>
 <c0915086dc876f59e3c69886a8629efa3540d737.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0915086dc876f59e3c69886a8629efa3540d737.camel@nvidia.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774021331; x=1774626131; darn=lists.osuosl.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qhx7QtPFHsmhBqKEQ6XlDZutQ+YSTAHptMBIGgI83fw=;
 b=mlj8/2HtTbEzlZIXQC6mCrBfDO/a0u6Gk72F8i+Zc8zeTlk6tamubjE8ZLbeuALYr6
 LnuFH9aXkKyNw0G6+/rFdaByrvA4bIBUL+vsVVeHpW12qf9vziSl0pusXKp02RL1GIbx
 3F3XDmhUHlcKN1o8DR5JUVSWtGU0Sx39o2Sa27Ul1BeixFpgVIo697Ehjk55nd+T1Doh
 QRWusUPyLd0frBUcOk9CTEzRo7Tesz0Z0bELS18U6tAwF2Wgh44NFthzGLjhuTXKt2n/
 gxBPjwISY0Vg5OqgZ+gykclWaz0OHQXZj8hTcD+VlKBtRiDRdJx16YCv0etR/VKCfotl
 xV1g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=mlj8/2Ht
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 06/13] mlx5: convert to
 ndo_set_rx_mode_async
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

On 03/20, Cosmin Ratiu wrote:
> On Thu, 2026-03-19 at 18:24 -0700, Stanislav Fomichev wrote:
> > Convert mlx5 from ndo_set_rx_mode to ndo_set_rx_mode_async. The
> > driver's mlx5e_set_rx_mode now receives uc/mc snapshots and calls
> > mlx5e_fs_set_rx_mode_work directly instead of queueing work.
> > 
> > mlx5e_sync_netdev_addr and mlx5e_handle_netdev_addr now take
> > explicit uc/mc list parameters and iterate with
> > netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.
> > 
> > Fallback to netdev's uc/mc in a few places and grab addr lock.
> > 
> > Cc: Saeed Mahameed <saeedm@nvidia.com>
> > Cc: Tariq Toukan <tariqt@nvidia.com>
> > Cc: Cosmin Ratiu <cratiu@nvidia.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  .../net/ethernet/mellanox/mlx5/core/en/fs.h   |  5 +++-
> >  .../net/ethernet/mellanox/mlx5/core/en_fs.c   | 30 ++++++++++++-----
> > --
> >  .../net/ethernet/mellanox/mlx5/core/en_main.c | 16 +++++++---
> >  3 files changed, 36 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
> > b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
> > index c3408b3f7010..091b80a67189 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
> > @@ -201,7 +201,10 @@ int mlx5e_add_vlan_trap(struct
> > mlx5e_flow_steering *fs, int  trap_id, int tir_nu
> >  void mlx5e_remove_vlan_trap(struct mlx5e_flow_steering *fs);
> >  int mlx5e_add_mac_trap(struct mlx5e_flow_steering *fs, int  trap_id,
> > int tir_num);
> >  void mlx5e_remove_mac_trap(struct mlx5e_flow_steering *fs);
> > -void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
> > struct net_device *netdev);
> > +void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
> > +			       struct net_device *netdev,
> > +			       struct netdev_hw_addr_list *uc,
> > +			       struct netdev_hw_addr_list *mc);
> >  int mlx5e_fs_vlan_rx_add_vid(struct mlx5e_flow_steering *fs,
> >  			     struct net_device *netdev,
> >  			     __be16 proto, u16 vid);
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > index 55255fe6e415..a9daefbd8f8f 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > @@ -609,20 +609,26 @@ static void mlx5e_execute_l2_action(struct
> > mlx5e_flow_steering *fs,
> >  }
> >  
> >  static void mlx5e_sync_netdev_addr(struct mlx5e_flow_steering *fs,
> > -				   struct net_device *netdev)
> > +				   struct net_device *netdev,
> > +				   struct netdev_hw_addr_list *uc,
> > +				   struct netdev_hw_addr_list *mc)
> >  {
> >  	struct netdev_hw_addr *ha;
> >  
> > -	netif_addr_lock_bh(netdev);
> > +	if (!uc || !mc) {
> > +		netif_addr_lock_bh(netdev);
> > +		mlx5e_sync_netdev_addr(fs, netdev, &netdev->uc,
> > &netdev->mc);
> > +		netif_addr_unlock_bh(netdev);
> > +		return;
> > +	}
> >  
> >  	mlx5e_add_l2_to_hash(fs->l2.netdev_uc, netdev->dev_addr);
> > -	netdev_for_each_uc_addr(ha, netdev)
> > +
> > +	netdev_hw_addr_list_for_each(ha, uc)
> >  		mlx5e_add_l2_to_hash(fs->l2.netdev_uc, ha->addr);
> >  
> > -	netdev_for_each_mc_addr(ha, netdev)
> > +	netdev_hw_addr_list_for_each(ha, mc)
> >  		mlx5e_add_l2_to_hash(fs->l2.netdev_mc, ha->addr);
> > -
> > -	netif_addr_unlock_bh(netdev);
> >  }
> >  
> >  static void mlx5e_fill_addr_array(struct mlx5e_flow_steering *fs,
> > int list_type,
> > @@ -724,7 +730,9 @@ static void mlx5e_apply_netdev_addr(struct
> > mlx5e_flow_steering *fs)
> >  }
> >  
> >  static void mlx5e_handle_netdev_addr(struct mlx5e_flow_steering *fs,
> > -				     struct net_device *netdev)
> > +				     struct net_device *netdev,
> > +				     struct netdev_hw_addr_list *uc,
> > +				     struct netdev_hw_addr_list *mc)
> >  {
> >  	struct mlx5e_l2_hash_node *hn;
> >  	struct hlist_node *tmp;
> > @@ -736,7 +744,7 @@ static void mlx5e_handle_netdev_addr(struct
> > mlx5e_flow_steering *fs,
> >  		hn->action = MLX5E_ACTION_DEL;
> >  
> >  	if (fs->state_destroy)
> > -		mlx5e_sync_netdev_addr(fs, netdev);
> > +		mlx5e_sync_netdev_addr(fs, netdev, uc, mc);
> >  
> >  	mlx5e_apply_netdev_addr(fs);
> >  }
> > @@ -820,7 +828,9 @@ static void mlx5e_destroy_promisc_table(struct
> > mlx5e_flow_steering *fs)
> >  }
> >  
> >  void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
> > -			       struct net_device *netdev)
> > +			       struct net_device *netdev,
> > +			       struct netdev_hw_addr_list *uc,
> > +			       struct netdev_hw_addr_list *mc)
> >  {
> >  	struct mlx5e_l2_table *ea = &fs->l2;
> >  
> > @@ -850,7 +860,7 @@ void mlx5e_fs_set_rx_mode_work(struct
> > mlx5e_flow_steering *fs,
> >  	if (enable_broadcast)
> >  		mlx5e_add_l2_flow_rule(fs, &ea->broadcast,
> > MLX5E_FULLMATCH);
> >  
> > -	mlx5e_handle_netdev_addr(fs, netdev);
> > +	mlx5e_handle_netdev_addr(fs, netdev, uc, mc);
> >  
> >  	if (disable_broadcast)
> >  		mlx5e_del_l2_flow_rule(fs, &ea->broadcast);
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > index f7009da94f0b..e86cf1ee108d 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > @@ -4108,11 +4108,16 @@ static void mlx5e_nic_set_rx_mode(struct
> > mlx5e_priv *priv)
> >  	queue_work(priv->wq, &priv->set_rx_mode_work);
> >  }
> >  
> > -static void mlx5e_set_rx_mode(struct net_device *dev)
> > +static void mlx5e_set_rx_mode(struct net_device *dev,
> > +			      struct netdev_hw_addr_list *uc,
> > +			      struct netdev_hw_addr_list *mc)
> >  {
> >  	struct mlx5e_priv *priv = netdev_priv(dev);
> >  
> > -	mlx5e_nic_set_rx_mode(priv);
> > +	if (mlx5e_is_uplink_rep(priv))
> > +		return; /* no rx mode for uplink rep */
> > +
> > +	mlx5e_fs_set_rx_mode_work(priv->fs, dev, uc, mc);
> 
> While this chunk is correct, I think there's a logical conflict waiting
> to happen with Saeed's pending patch touching this area ([1]).
> 
> You have inlined mlx5e_nic_set_rx_mode here, but after Saeed's patch
> the mlx5e_is_uplink_rep condition added here should be dropped.
> 
> Not sure the automatic merge will do that.
> 
> [1]
> https://lore.kernel.org/netdev/20260319005456.82745-1-saeed@kernel.org/T/#u

Thanks for the heads up, will try to wait for this to be pulled before
reposting!
