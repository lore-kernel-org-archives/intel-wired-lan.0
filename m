Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC8DCD98CF
	for <intel-wired-lan@archiver.kernel.org>; Fri, 12 Jun 2026 19:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AC1B6116D;
	Fri, 12 Jun 2026 19:40:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TkcjnTEAALKA; Fri, 12 Jun 2026 19:40:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B4ACD6116E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781293202;
	bh=hv2Ow1ld1FBUX1iqO/T7CKESCohHcY+IkpgYqfsRrnc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yG1za5kR1AYTtBJjpEsPSqRp4rESljGr+ojQHuF99Z4/VGHnz9K9HWb+zVQAqrKag
	 GZBAHe9+V+55CoQ93+x3eIvy7Hiq2t2a4H23RWOCW0buMi9lFAHHbSGa4qHKy55Wkv
	 bWAxMJeacUW6BaRv3oZD6UxadPB9Q13V7Np4tYmBx4l4Vw7TN95WTvl9lVAi+GCHs5
	 Uf/+cl4uowbL38wPvN1PUAl7UM/guGrh+X2PQY29hKATJ6HetFCAOQuXEgdOy2qgEB
	 4UuwHmE08VDPwqQct4k+HosaXOA7YZUf0GWQPTuQX3RNQYKS7jKfqTQpRPHO4FbB9n
	 rOqyjKhrdocDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4ACD6116E;
	Fri, 12 Jun 2026 19:40:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F1961E9D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 Jun 2026 19:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13DED61168
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 Jun 2026 19:40:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lX6RocWnpWig for <intel-wired-lan@lists.osuosl.org>;
 Fri, 12 Jun 2026 19:40:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8CEA561167
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CEA561167
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8CEA561167
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 Jun 2026 19:39:58 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1wY7jD-007NEZ-SH; Fri, 12 Jun 2026 21:39:43 +0200
Date: Fri, 12 Jun 2026 21:39:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rongguang Wei <clementwei90@163.com>
Cc: przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Rongguang Wei <weirongguang@kylinos.cn>
Message-ID: <1578c474-ffbf-46f7-b906-49da4ea48142@lunn.ch>
References: <20260612080331.120096-1-clementwei90@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612080331.120096-1-clementwei90@163.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=hv2Ow1ld1FBUX1iqO/T7CKESCohHcY+IkpgYqfsRrnc=; b=oLmilcZJHC5mGFs6JJJ0s6vrsu
 YB3UlQjW5U1FjMgov8M4nv45kbrx2hfZhqBBzyksSXOMmk+/Zk6Mc5k1Vhr/rjypTtmNSjiSdxBLN
 vvlWO++6qr9ZJVyfG7wzA18Q7wswivM42r1kjpPYtYFcUWvWxaMREB7AGEXPQxrU2Rxs=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=oLmilcZJ
Subject: Re: [Intel-wired-lan] [PATCH net-next v1] e1000: Initialize
 phy_data to avoid unexpected values
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

On Fri, Jun 12, 2026 at 04:03:31PM +0800, Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> The phy_data variable is not initialized. If e1000_read_phy_reg
> returns an error, phy_data will not point to a valid value from
> the PHY register, which may cause the regs_buff array to be populated
> with unexpected values.
> 
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> Change-Id: I46071b3b21a566f8da650168d38d6968251b077d

What does this Change-Id mean?

> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> index 4dcbeabb3ad2..f068108c5004 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> @@ -327,7 +327,7 @@ static void e1000_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
>  	struct e1000_adapter *adapter = netdev_priv(netdev);
>  	struct e1000_hw *hw = &adapter->hw;
>  	u32 *regs_buff = p;
> -	u16 phy_data;
> +	u16 phy_data = 0;

	if (hw->phy_type == e1000_phy_igp) {
		e1000_write_phy_reg(hw, IGP01E1000_PHY_PAGE_SELECT,
				    IGP01E1000_PHY_AGC_A);
		e1000_read_phy_reg(hw, IGP01E1000_PHY_AGC_A &
				   IGP01E1000_PHY_PAGE_SELECT, &phy_data);
		regs_buff[13] = (u32)phy_data; /* cable length */

Isn't a cable length of 0 also unexpected?

How does this patch actually make the situation better?

    
    Andrew

---
pw-bot: cr
