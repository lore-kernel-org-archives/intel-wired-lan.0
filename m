Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5A7C79FB9
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Sep 2026 11:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B07380BDB;
	Wed,  9 Sep 2026 11:24:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nRIlPlZOi_sb; Wed,  9 Sep 2026 11:24:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 69BD480D3C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788953070;
	b=A4K5Tr82g1pSdNEp9q6A8G/ghzir89+FwDIzxCyNSVdOis0hjQiJ41OFNnDF28dOGzu6
	 47vj9WjnhAP3XEaGUHQp5P1EsThwPMTRN7COcL6Uit14equpLlT83G6QhE9xqAxR+ivol
	 TQ0tTyeRT+EJ9Ua5nQSah2gZC80jop1b3N7iN/qD1NPtciGlIyFXqDQSjw1mGJgi4B2CJ
	 kpV27wkCMr/VHSB9c/K3uF4qVJtgIX8y7wueMGdW7N3rh1BxZju70+6h/VAH6SO4UY21y
	 0pB6tDDOIVUlbOIfbxv1N6mHZUZxbJ/sAVClWfYAD3mZSLBQzh6qlxnc3rWHzgGAlEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788953070;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 dkim-signature:Received:dkim-signature:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sm5hZKlRG1kdRKEeS9E+CM4U4vHBPHrbqoe03Kq/6mc=;
	b=sHNf5s8i5wxZL0BeIGFewAEnI9Hf6kiqXMs5Dq1Rbu5FOs39DppSeuI/8rM/k3agvHGr
	 uOtnCU2BgoqH3uI3dDoGAE9aGg4u2krxvpW5DKcb4HyISdyx2iJiehijok/ki7Y2PCzra
	 Ujs/totvJ2y6pyrBFttuDn6ym4VcCLp3uJNb6/xFzhoU318wzmMjaz5qti9ROIrP/tT1N
	 yswYKdSzj/iQAQfaMq9XS5Ge0xeSZH4uGx4mLX/qWay7EuoWNleabafmodY3rVmnnNJgF
	 04WWTA+7Rb1sEHd75ZyD7H07B8+TiQp8OIqk7307yMGVwVMRkAdSUhhZXQalrqocyPA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788953070;
	bh=sm5hZKlRG1kdRKEeS9E+CM4U4vHBPHrbqoe03Kq/6mc=;
	h=Date:CC:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D8c0QjrPg3rIR6r4cT0DN4LEU6X1fJHMfZgX1kkWGe6dj1/JOlYJGFOHY57jRl5em
	 feg0J0yIZAl2sCmtjp00dSTVid5eTekau5nWygXOfwZhLpWOZOR8MYSMtVtdRJ1Efx
	 J+6qQOO0kf1PIIlGNyZkAdHeM4a7U6IjrJJss8f3ZlhxJ9ecDjDaz+KjEmAXSmaRgw
	 VmKSI1MwspR1SWo5/mSEjySdfom5e5u2tsmUDqF9Wzg2L4VzVTAiZGBvcDtlDxFWme
	 RTeouzAy1YCX0z6aWHzSK04SdQcNwAuPPEmzA+/kiWjWYBA/Z7j8/Jbwim3KqYaTvH
	 IkGop2aOtTpdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69BD480D3C;
	Wed,  9 Sep 2026 11:24:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 536BA49D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 11:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39454406E7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 11:24:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klwRGqCYLiRl for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Sep 2026 11:24:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AD274406E3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788953067;
 b=XPn3gliXWC/oUDH7QbithbLe2agvbbBYx5hJgK0xWZyVXnoVZSUyf78Jz8hkR18/M2IM
 vZwm6+yoAepw7OhlY3kS437f3muHmvnK8Lc+N+iTD76vGSwpNiYDSLyp4hOTtnaSi5XR/
 oBs5cIfEDnY8L+FtHUuae1MAeM+d/swfBiFkds/qzZbAM/TmmFVU5wN0Ufj2dTrT+Ydc0
 D6PXCxWLmqgQJLIJMwH5uIlPZ/QozjsZIfOMY3ZJaFPUtsequodM0bYSwbV+jFmptMEuT
 GEriwHYYgQ1x+gV2o+O7jcJbTxdxP73puCDifahGmQPlONgaZ7IZrdZJfz0178CwzSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788953067;
 h=X-Greylist:Received-SPF:dkim-signature:Received:dkim-signature:
 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:CC:
 Subject:To:References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 bh=sm5hZKlRG1kdRKEeS9E+CM4U4vHBPHrbqoe03Kq/6mc=;
 b=rOcVkRShJEoYKSRQfpt49Ekc5OyOQjndtdturcjbK+SAexKLkRskS/Sk1XO+uWJC4RFE
 zV9gT28SWm9kyClVLpafXDqAljCu+LM0SCol4/C9yPAXlLO7PKhcOdOGikzQbiMg4Cx4I
 MF0CpqfyaVDLHDkuTNQnuLVBAphHABQKK00eRACe3kLZUWs5rBT3SJ3hU+uIFsx4JfY0o
 D5rhRVUziL2chg9ZfIHV3irK+pnn8egbOdX6vQiJ31yUCXUjcnSBV8P7cCUbACXM9Rqru
 5OCSPjRw9hBiUHcrRS+rOKm8gDVFA2QcaHUQiX0bBVuHmixAK0q1140xwzqdJO60QnQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=huawei.com; 
 dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256
 header.s=dkim header.b=jR8fGYTA; 
 dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256
 header.s=dkim header.b=jR8fGYTA; 
 arc=none smtp.remote-ip=45.249.212.190
X-Greylist: delayed 1071 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 09 Sep 2026 11:24:24 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=huawei.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com
 header.a=rsa-sha256 header.s=dkim header.b=jR8fGYTA; 
 dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com
 header.a=rsa-sha256 header.s=dkim header.b=jR8fGYTA
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190;
 helo=szxga04-in.huawei.com; envelope-from=shaojijie@huawei.com;
 receiver=<UNKNOWN> 
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD274406E3
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 11:24:24 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=sm5hZKlRG1kdRKEeS9E+CM4U4vHBPHrbqoe03Kq/6mc=;
 b=jR8fGYTA5LjNiB7N9ItZ9pJxW4LBxJ3N3Frsepxkpkhe28tWmq4rYbOr9sddAxn1bjyDvl001
 afuH0mFsR17hmPwenRdyx7RCX3hQTzW5vUEUjN5TfSaOLeAbr3R+NMux6obhhlXwjCtwUmkf7/T
 +xjJ4d3KSw1xejM4c16gk0k=
Received: from canpmsgout04.his.huawei.com (unknown [172.19.92.133])
 by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4hfyfb5Kjlz126MFZ
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 19:06:15 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=sm5hZKlRG1kdRKEeS9E+CM4U4vHBPHrbqoe03Kq/6mc=;
 b=jR8fGYTA5LjNiB7N9ItZ9pJxW4LBxJ3N3Frsepxkpkhe28tWmq4rYbOr9sddAxn1bjyDvl001
 afuH0mFsR17hmPwenRdyx7RCX3hQTzW5vUEUjN5TfSaOLeAbr3R+NMux6obhhlXwjCtwUmkf7/T
 +xjJ4d3KSw1xejM4c16gk0k=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hfyQ00gqSz1prMB;
 Wed,  9 Sep 2026 18:55:20 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 101954056E;
 Wed,  9 Sep 2026 19:06:16 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 9 Sep 2026 19:06:15 +0800
Message-ID: <9284cd9f-88fb-4067-be39-3e0025dee2c4@huawei.com>
Date: Wed, 9 Sep 2026 19:06:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Yury Norov <ynorov@nvidia.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/9] net: avoid copies before linkmode_and()
To: Yury Norov <yury.norov@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Raju
 Rangoju <Raju.Rangoju@amd.com>, Prashanth Kumar K R
 <PrashanthKumar.K.R@amd.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jian Shen
 <shenjian15@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <linux-usb@vger.kernel.org>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-7-ynorov@nvidia.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260907215439.409858-7-ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.192]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500018.china.huawei.com (7.202.195.199)
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


on 2026/9/8 5:54, Yury Norov wrote:
> Avoid separate linkmode_copy() calls by passing the original source
> bitmap directly to linkmode_and().
>
> In phy_ethtool_ksettings_set(), also use the return value of
> linkmode_and() when validating that the requested advertisement
> contains a supported link mode.

Please include "hns3" in the subject prefix (e.g., "net: hns3: ...")
so it's clear which driver this patch belongs to. I didn't immediately
find the hns3 driver modifications from the current title.

>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c | 5 ++---
>   drivers/net/phy/phy.c                                   | 7 +++----
>   2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
> index cf881108fa57..5801da6100b8 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
> @@ -205,7 +205,6 @@ int hclge_mac_connect_phy(struct hnae3_handle *handle)
>   	struct hclge_dev *hdev = vport->back;
>   	struct net_device *netdev = hdev->vport[0].nic.netdev;
>   	struct phy_device *phydev = hdev->hw.mac.phydev;
> -	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
>   	int ret;
>   
>   	if (!phydev)
> @@ -223,8 +222,8 @@ int hclge_mac_connect_phy(struct hnae3_handle *handle)
>   		return ret;
>   	}
>   
> -	linkmode_copy(mask, hdev->hw.mac.supported);
> -	linkmode_and(phydev->supported, phydev->supported, mask);
> +	linkmode_and(phydev->supported, phydev->supported,
> +		     hdev->hw.mac.supported);
>   	linkmode_copy(phydev->advertising, phydev->supported);
>   
>   	/* supported flag is Pause and Asym Pause, but default advertising
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index fce9bc7be330..cd71186cd842 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1160,6 +1160,7 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
>   			      const struct ethtool_link_ksettings *cmd)
>   {
>   	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
> +	bool has_advertising;
>   	u8 autoneg = cmd->base.autoneg;
>   	u8 duplex = cmd->base.duplex;
>   	u32 speed = cmd->base.speed;
> @@ -1167,17 +1168,15 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
>   	if (cmd->base.phy_address != phydev->mdio.addr)
>   		return -EINVAL;
>   
> -	linkmode_copy(advertising, cmd->link_modes.advertising);
> -
>   	/* We make sure that we don't pass unsupported values in to the PHY */
> -	linkmode_and(advertising, advertising, phydev->supported);
> +	has_advertising = linkmode_and(advertising, cmd->link_modes.advertising, phydev->supported);


To keep the file clean, could you please update this part to match thesurrounding code style?
Specifically, we order local variables fromlongest to shortest (reverse Christmas tree) and
enforce an 80-characterline limit.

Thanks,
Jijie Shao


>   
>   	/* Verify the settings we care about. */
>   	if (autoneg != AUTONEG_ENABLE && autoneg != AUTONEG_DISABLE)
>   		return -EINVAL;
>   
>   	if (autoneg == AUTONEG_ENABLE &&
> -	    (linkmode_empty(advertising) ||
> +	    (!has_advertising ||
>   	     !linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
>   				phydev->supported)))
>   		return -EINVAL;
