Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDC2C54E58
	for <intel-wired-lan@archiver.kernel.org>; Mon, 18 Mar 2024 07:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD75F40547;
	Mon, 18 Mar 2024 07:58:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BF-EuyfNbkmk; Mon, 18 Mar 2024 07:58:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1A524055E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1710748716;
	bh=GwzYgLHWUfhc1x+WR7je+vcMavz3AUg10dsKbhVc4bM=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=KjZYgB/kcRqnUZpYOOg819BGoqdkAseqFRkhcm1WBlF7j1Y1dDbcr7FisROamuuIz
	 HaHCml+bIr2KpKVLv2FdU920aHv2mNGTcWhUBuVTVeLZ/UyzFVLLmLN8cA0cU9t2a9
	 1SIFwFcs89Q+4QR7MjP1iMuH1sGUpn8WoSAhZgVGNBk3nzIQo2tqntDeXP3n136+5D
	 WuRD+Jab6B7eQ0tFVlSKslMA5SWvLjtntjbwwThiZ0SIl+HrqdEPWmgUwaFb30aohQ
	 C+QiMlVNOVDvSLwQd+45jRNwX9LaCuMNRT5WVSFADXCRgaIBSH7gRD0lB/5o1q48kA
	 nZq3hmdT/d8ZQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1A524055E;
	Mon, 18 Mar 2024 07:58:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id AF6C51BF3D8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Mar 2024 07:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A8B9605BE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Mar 2024 07:58:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13QKCr52APSb for <intel-wired-lan@lists.osuosl.org>;
 Mon, 18 Mar 2024 07:58:33 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D3C17605BA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3C17605BA
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3C17605BA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Mar 2024 07:58:30 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4140efa16caso5709865e9.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Mar 2024 00:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710748709; x=1711353509;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwzYgLHWUfhc1x+WR7je+vcMavz3AUg10dsKbhVc4bM=;
 b=IdmBCPe/IC40st40WtdTFoOsH+wr15hNa1+eJbxPbS5pPnxDBv0l8bj7z9igrMuRyV
 ED7VweUNPnW/XPGkvrIMUm3z8lLm7kKdroCFp+ZwK5jltkwuATr7Cj+tXQdgfWDrA9w+
 vP261N8MnX9RsICEEdGCqGxBHHvuH/uniRhZu7Hmkc5osHAegpHG7CWIYbwdC6kDKb4Z
 1Ldt9jwpPw/s5Qest0C/zxsIn/bGHmL4EZhUt+B1wnJt4GFV7Xyq+aVTcFdozGsoQyyG
 s3g49176tKkSWakpZNUSaZt1pDrPrE4Ti8SerINM00pSwBVnLUonunbyWK2jE+Sd3dUG
 GCYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVetXAPmYBkdrMFBdckpBT5GNpZGZK9JoqYB1PoSK7i2QczB+KP0H9w7BbnZFHIntlcAz2uZ1CgdtwRbFylSDaSfNdw+ZkLsnMGiHNWus7KXg==
X-Gm-Message-State: AOJu0YxVQnHq2KY2LTeqa4v9xsYgSXCdbarId5LiQiLiyluaXc2Hvd3+
 qx27ilF6sHiiIjBLL+KywrUSSMTcW4jFCQ+Lq6hl7lrlnrWHVUdnnzNhuBpcVjg=
X-Google-Smtp-Source: AGHT+IGP63gK84RwsrLYUjc1GyJx9V566JyM8XZbpPWkA0VR1WtYdjl0H6jWrjiu2X2wyPbyn8sBsQ==
X-Received: by 2002:a05:600c:19c7:b0:413:f034:a4ae with SMTP id
 u7-20020a05600c19c700b00413f034a4aemr9076763wmq.4.1710748708639; 
 Mon, 18 Mar 2024 00:58:28 -0700 (PDT)
Received: from localhost ([193.47.165.251]) by smtp.gmail.com with ESMTPSA id
 g18-20020a05600c4ed200b00413f3b16a26sm13358369wmq.35.2024.03.18.00.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 00:58:28 -0700 (PDT)
Date: Mon, 18 Mar 2024 08:58:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <Zff0IO6nqpMiGXl5@nanopsycho>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710748709; x=1711353509;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GwzYgLHWUfhc1x+WR7je+vcMavz3AUg10dsKbhVc4bM=;
 b=T06vdoiqWxyvMmEsdbsniOC83Vu8/9q7v+LqhMIoAxwRLrIlxioKGr3K5ULaN5VKLz
 JqZx/FSmi8dVxr727EywIwJpWCTf2XYGtH4N0ONRQvk4a12yVZyrdeHTS8h3Q7dH2840
 yaTguTlN0BnSqDmKkx8WIWLEzWdI7DAX7WHRsNjL4lK5saVCqYs8Sstoh0ejXpyhlBNM
 055YpTeVCF5MM03KXXIi++m5potNS6gOizXQkjN8BXzn0sel5rd/+EJZIlyaXTsJ6Dfk
 zxurDnca4YZU81Zv3hqCaqmf/o/joWXsudfu9CFdN/gyqkd7IvpJxKEtC/8O+7Qw60nj
 w/mQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=resnulli.us
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=resnulli-us.20230601.gappssmtp.com
 header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=T06vdoiq
Subject: Re: [Intel-wired-lan] [PATCH net] ice: Fix freeing uninitialized
 pointers
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Sat, Mar 16, 2024 at 10:44:40AM CET, dan.carpenter@linaro.org wrote:
>Automatically cleaned up pointers need to be initialized before exiting
>their scope.  In this case, they need to be initialized to NULL before
>any return statement.
>
>Fixes: 90f821d72e11 ("ice: avoid unnecessary devm_ usage")
>Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>---
> drivers/net/ethernet/intel/ice/ice_common.c  | 4 ++--
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
>index 4d8111aeb0ff..4b27d2bc2912 100644
>--- a/drivers/net/ethernet/intel/ice/ice_common.c
>+++ b/drivers/net/ethernet/intel/ice/ice_common.c
>@@ -1002,8 +1002,8 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
>  */
> int ice_init_hw(struct ice_hw *hw)
> {
>-	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
>-	void *mac_buf __free(kfree);
>+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
>+	void *mac_buf __free(kfree) = NULL;
> 	u16 mac_buf_len;
> 	int status;
> 

How about similar issues in:
ice_set_fc()
ice_cfg_phy_fec()
?


>diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>index 255a9c8151b4..78b833b3e1d7 100644
>--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
>+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>@@ -941,11 +941,11 @@ static u64 ice_loopback_test(struct net_device *netdev)
> 	struct ice_netdev_priv *np = netdev_priv(netdev);
> 	struct ice_vsi *orig_vsi = np->vsi, *test_vsi;
> 	struct ice_pf *pf = orig_vsi->back;
>+	u8 *tx_frame __free(kfree) = NULL;
> 	u8 broadcast[ETH_ALEN], ret = 0;
> 	int num_frames, valid_frames;
> 	struct ice_tx_ring *tx_ring;
> 	struct ice_rx_ring *rx_ring;
>-	u8 *tx_frame __free(kfree);
> 	int i;
> 
> 	netdev_info(netdev, "loopback test\n");
>-- 
>2.43.0
>
>
