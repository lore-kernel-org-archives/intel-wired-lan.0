Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CB6606A31F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=2xAliUNE;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=S6KcyBQN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 288A9607B0;
	Tue, 27 Oct 2026 19:57:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TiW4FxCMQIPp; Tue, 27 Oct 2026 19:57:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 72752607FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793131052;
	b=cxB1ya6Envn4zcXhvIusGn4aX9rCeFVs6hvlaNlyTrqYqnMNlP7WDM4cajaBpXv5n+32
	 +EC1T2rWOdVOBuoi2h9Djj9KVqF8YLnQGaIJAVnr7wBN2Oy5eBMVitjWUHF+376E0YlpX
	 f4q9X+4LSQT8Fb5ZWuN190VqwxIjo4iDkgWAioBCyJH0FguKvIr5uQg9nY0cju6B50ouW
	 TYMsBVDYrQg3T8Jr3t0q+7KYK7Nn3JFtz1ez+uStVYGrm2nvCBNk7oPfsG9AXtiqA6uA5
	 BNjcBtb5gqfvoKC0xYKCzZaEP/Uo6d5QXpnZVcwGLOsyd507eyAMtNC0ZMWZtRvKaBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793131052;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=W+cxyww2TucNEepNfRrQ0ekDRXr+LHAHYoofn3JixiI=;
	b=nza/WsCzyXORviRP50WG7k6q0UvJLl4N2xk6fYW2Co4+ng3uPzaTWSmZP78LtQHovixD
	 LmKH5gFhkoUDrbNW/BBvKNtaBUGm1xY2mcWAk444nG7Qz5qM/0rbnX45y1BVJPnTvA4FL
	 maUld0ziT+AXkkV5wdp6YyoENZw6SCqGXsCcepuFmSLbbVi2JYVegW9GpJgnbOSqW1w/H
	 9hSFTbeIAYRsH94SXlB1fOQywUJkmPDNYy73vxwOyYYjfxaWix1Hxzxjw0wvvgn48OGvo
	 w6yff4FAvBXNEldfczVXLs3deE3NqffLRmQxAEgq7f5CdcWVo3M68+oholOz7Ej0vUg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793131052;
	bh=W+cxyww2TucNEepNfRrQ0ekDRXr+LHAHYoofn3JixiI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2xAliUNE7osdUsOeZtjwXiUNOADpKOUiXmyXlTmLUi6TA+H0xsdSX8cFmHhM0mTr6
	 NPSuMa9fqjAv9clHnqxzAZ3ONXPOPZ1Qt/BY46r36W3zNadGMld8xuK3gpk9K5LlEq
	 VyI1qJTo6hrKRlU+nrrC6P9VJKkJlgNk+w+5vZMN9PUmgW00I6/hrQtLgMhB8EayL+
	 I86NQ5g8iXFqKkAM2Wboi/ebNtd6/R/Zn7Btc0z+LLGOzoRetSSp3fHU3j2E4UozEf
	 qq8uZIeKe756obsrBfZTGdA06a01wM1MCjTDgBhcnuDiyo9u1x8gBeD+CJ1YzhTL0J
	 avKdXSTWcyqCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72752607FF;
	Tue, 27 Oct 2026 19:57:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 573B02C7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 07:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54E6A40291
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 07:33:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RZOkDMk8lckH for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 07:33:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 03E314024B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793000026;
 b=LvQF4gARCbyJSkLBcOAMV3cBokjbTqjEoyKhqRGyIEBqBFLmaF66TzPBc8TweAGIQ7/y
 RrADX8aBZgGaxb+i27MrlXGSR+YBPaVvdGFxPYaociPVhRIxUHZ2ENdum1B8l5X7rLVBN
 xlFTKjQMLJcrX0V6u/J8DRHdFIgyIU6nC2sWq/Zqz4wgLQjB4aYufWaVHPuw1666OZmRe
 Ris9P0AL8t8cx8TR5TCCDy65neX2iZWuw8YopJflM+Y0jeFWoVAFxU6oPfbatpPXODscp
 aW/2EUOmP5gZZRie/HP8HU8mBioehmwKoQXywTnJbiHJ5nrEBnWWZ6qqwJpMQp99mkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793000026;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=W+cxyww2TucNEepNfRrQ0ekDRXr+LHAHYoofn3JixiI=;
 b=qVqBmAyMFLKaHsI95bJ8kP7EQUKx9DQk5aplDnKJkgFWQtew8adcRnXvm/+nFPTjIq1B
 hGi3FD6c6dl8b+QtCsCXKiaUOYzyrCUk+XOAB/WYgEY/mpEQvVDhVF3Tpx95YwUJ+AUim
 ETTnUopmcsc/HqLts6R3ubbFdYZnFxAen3+pqkzw44ioAVKlJGdTRDlaLoP3RXB8kY8sh
 shjqSo3QJhzviJSZlBohdDUsCh1Fs4d3nSfUJnEs+r6SqB3J1wHfyBy9yiS6nXbPwlTG0
 ozVKUOiocs4ofK0kBJY9AQYhVX+OAkDXGoIKn7x4ypPdyQgAx6h5DuAcVwJQAANndtA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=S6KcyBQN; 
 arc=none smtp.remote-ip=68.232.153.233
X-Greylist: delayed 66 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 26 Oct 2026 07:33:46 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=S6KcyBQN
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=752f52007=daniel.machon@microchip.com; receiver=<UNKNOWN> 
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03E314024B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 07:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1793000026; x=1824536026;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7xCx4d3ZGL9TKpbq2riWZWJdYVevoxdH+V0DwFIpJy0=;
 b=S6KcyBQNgY6Dgy9nDR6QgUfbhpuLnJov5kNvfMmZEuxTgN2opvIIxMxC
 XCeFS+smU8XLg9WuuWisCwePBC/wtiSaRHGNFlbwriyhgo+vF/pUiMHFS
 S8HeBuOwxh0CZAnHALcmgQJumNVmiSjROzXUno9xc7Z47rdKG+uYgjuDi
 +FDe6jk1xSwEX8x5adaRpVrysjposqKkohSPd2K+m1g/w78JRQ3dvOMoN
 76ATAB/rIpj9KAh7qWt+i3usPJizkkJcoJv4yFqIk81tlSsFKpTWnFJ4a
 PNNIkkSTpwrn4FxdL2QBCBLPf9IToAiFPWQlx7lSQzNhHxiZGKyV09vQs Q==;
X-CSE-ConnectionGUID: lx7BMXXCT0Kk/SReMKYRFA==
X-CSE-MsgGUID: z6QjRkdEQLmY3DY7Pm5BNg==
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; d="scan'208";a="296974928"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Oct 2026 00:32:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 26 Oct 2026 00:32:38 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 26 Oct 2026 00:32:36 -0700
Date: Mon, 26 Oct 2026 08:32:35 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: dcb: initialize PFC value before calling
 getpfccfg
Message-ID: <20261026073235.3huvz6o5h6psyv76@DEN-DL-M70577>
References: <179289284460.50470.572724041164324949@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <179289284460.50470.572724041164324949@gmail.com>
X-Mailman-Approved-At: Tue, 27 Oct 2026 19:57:25 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> dcbnl_getpfccfg() and dcbnl_cee_fill() pass the address of an
> uninitialized stack u8 to the driver's getpfccfg() op and then put it
> into the netlink reply unconditionally.  The op returns void, so the
> core cannot tell whether the driver wrote the value.
> 
> i40e_dcbnl_get_pfc_cfg() and ice_dcbnl_get_pfc_cfg() return without
> writing *setting unless the DCBX agent is host managed and in CEE mode.
> Both drivers normally run with firmware managed DCBX
> (DCB_CAP_DCBX_LLD_MANAGED), and i40e with FW LLDP disabled runs host
> managed in IEEE mode, so on a DCB capable i40e/ice port the PFC values
> in DCB_CMD_PFC_GCFG and DCB_CMD_CEE_GET replies, and in the CEE part of
> RTNLGRP_DCB notifications, come from uninitialized stack.  The same u8
> is reused for all eight priorities, so this is one byte per reply.
> 
> dcb_doit() only requires CAP_NET_ADMIN for RTM_SETDCB, so the GET
> commands are available to unprivileged users.
> 
> Set the value to 0 before each call, like the PG config path already
> presets its outputs to DCB_ATTR_VALUE_UNDEFINED.  0 is also what the
> reply contains today on kernels built with CONFIG_INIT_STACK_ALL_ZERO,
> so nothing changes for those.
> 
> Fixes: b94b013eb626 ("ice: Implement DCBNL support")
> Fixes: 5effa78e7c94 ("i40e: Add netlink callbacks support for software based DCB")

I am not entirely sure, but should this patch add a fixes tag for a driver, when
the change is only in the API?

Also, if this dates back to the introduction of DCBNL then I guess its not a
regression and maybe a fix for net-next?

> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
> ---
> Found by code inspection, compile-tested only (W=1).  I don't have
> i40e/ice hardware to check the reply.  On kernels built with
> CONFIG_INIT_STACK_ALL_ZERO the byte is already zero, so in practice
> it only leaks on builds without stack auto-initialization.
> 
>  net/dcb/dcbnl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
> index ab71f53128..ad0aebe0ad 100644
> --- a/net/dcb/dcbnl.c
> +++ b/net/dcb/dcbnl.c
> @@ -281,6 +281,7 @@ static int dcbnl_getpfccfg(struct net_device *netdev, struct nlmsghdr *nlh,
>  		if (!getall && !data[i])
>  			continue;
>  
> +		value = 0;

Why noy initialize this at the declaration, like getall is?

>  		netdev->dcbnl_ops->getpfccfg(netdev, i - DCB_PFC_UP_ATTR_0,
>  		                             &value);
>  		ret = nla_put_u8(skb, i, value);
> @@ -1395,6 +1396,7 @@ static int dcbnl_cee_fill(struct sk_buff *skb, struct net_device *netdev)
>  			goto nla_put_failure;
>  
>  		for (i = DCB_PFC_UP_ATTR_0; i <= DCB_PFC_UP_ATTR_7; i++) {
> +			value = 0;

Same.

>  			ops->getpfccfg(netdev, i - DCB_PFC_UP_ATTR_0, &value);
>  			if (nla_put_u8(skb, i, value))
>  				goto nla_put_failure;

/Daniel
