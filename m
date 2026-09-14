Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EBCC88E64
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 08:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8ECB4056A;
	Mon, 14 Sep 2026 08:48:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wZNPje9MytoJ; Mon, 14 Sep 2026 08:48:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3786940603
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789375716;
	b=tQnrGKf20ZesED0fHMgV4mVUMgaYgJidEe4fg13JAQ0Jx5MBF9v7xmwZC8Pf3lYjP2H9
	 OoNQkBF0S/FKnDtC8/xo5I43fBS+TqGIyczdyeMGK1bg2lLT7c3AHdHPicPMVrknVAu4I
	 rf4xHoP2EeL+rTmixG5GHYDnZNGxQU7m5LLef5v7LS7mZYHsOTWd4dnPxMTtGMV8e1iod
	 WviKoid3mi6cw3ZX2/v+MdREUidT4xbgOhSXT6f61MwBEUituuTtPPwrnq2Mxep7oY2Ei
	 FvOqQcJr4qmqfrr5lpM/qQFZFBYTJdIzWWZC5opOX/3gllmcBBRYxnXsa155mWPEJcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789375716;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0kvizxDrpk0j6xDj6aqJhobOa++7+JeUcG4npstg5E8=;
	b=OmyVkFxAlQNkNKxgMpqzEQpB1X9VPUbMH2TD3CvUDcSmCpnc01Z5PyebilFZ1mjzGUf3
	 nBc3H4jH5NrpR6XBQ6tjQ4OcoZkuo4dhS5whYf20SGiBK8oohfsZcESPlHNTUIP0TWAip
	 OAr0SJb4UaSrXkTx3zEClOPcc8iTj9zSkh+7BzCPUcTI4QReOMsvxzcbAXc2SgfuID0cZ
	 8o/O/od5GlZCNQQjSffY9exDkHGuB8+YMsWtwL1sU4ftgPqSRg+VGdmeLvtM9LLDVzfZ5
	 4FsySpea1VEVZVU+RUYmSAroKEAlqrZHqW4lZceVRK33KK5uZo1FOJy0WmzG2zDRvgA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789375716;
	bh=0kvizxDrpk0j6xDj6aqJhobOa++7+JeUcG4npstg5E8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jwjxRkryECHoxb6d9+r0KsCtvNqBjrTH9JDzqRTWEKT7Z0U5FzK2EERNJkbfH/JDn
	 ja0oR3vH8vwPe9gHICZUpZEr2ycC/XJvfp1nufjzJ/tlFj/qUWtGNGKSWSjRpTzzYf
	 qu3azNz9uVNfB9W6KvjHqHFjhgg9qcpA/choWfioRD8SJi0rI+tnpJ2jDYemfSTFi2
	 x+7s4OISDKhAFLHC5rWn8rLmJw2YkXV0sqS+D2lZV+6yZkn6f9QyIbj65kQx3e0fPL
	 Brblg5vSEuahWcrTTJiNmgPil2M94yVMrtKmPKPpTq1sbRcN0rK5PYM5zZIADPPlNZ
	 V9I7nNuXJFVUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3786940603;
	Mon, 14 Sep 2026 08:48:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 73F633AF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 08:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70C9360677
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 08:48:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oB0c6sr1EPO9 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Sep 2026 08:48:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6279D605FC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789375713;
 b=gGFB/RC8RSU9VBe2HH50JM4mRuChrtFM9n0Zu6NdU64fYIdJLxAavR/FUxeVRMsZlhu3
 081UPCy+QKAl4l5gvnY3w6MKWo+iIrWO9OYs8E09zBkKbB24W9owpy5Br9SQSF7vlxPzZ
 N4rvR4kEBqeVV79YYrtmb6oQH6Lsc4JQ6HZm6m9hVwVZMBMhDkX/PQQk4m3YJLhbG4g4t
 UIRe79Ofjwa2FMGw2Vq+R6Q6lW4Sx6nMJhM0h0WLKADttVMELhOd7gsuaZ9AbqBwL+DGu
 VUCFZK65CrB0b8t4cWkCr3b22qL12eaZGTm/1OmFflDkFxTMZ56GqoQHsyvOJ35Cn7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789375713;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
 Cc:References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=0kvizxDrpk0j6xDj6aqJhobOa++7+JeUcG4npstg5E8=;
 b=dG/In/yQOCNNmYzC04jeHRPzPEDPH1wvOpmBpfR0u8uqcC2ggliIArmXJ9Zv5P061u7f
 KIwuWAbAp02JclCSoqOZPz5+XfKSE0zz/QXnw60ndy1+qfQqWAswxvphCsL/creo4BBFJ
 UpxJBngzkmtUShM/WXR/Fn9qK5Ffq84+12U5d28Y7Y15uJYVMPUpKGntr1T9asx8JZ2jq
 tFlI0NoM/HBuIzluVIeui7i8NWqJFadAZvsm4MU4orUMotsXh89nWja69ItlLlwkp0qcs
 Y+qiZbLy1DPxlss5PT/bIrzrvMtMlXiQFg3aV61cYB2d3iK7mr0Qp9B6Ge9WlzYGj6w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=blackwall.org; 
 dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256
 header.s=google header.b=W+CPTVne; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=blackwall.org header.i=@blackwall.org
 header.a=rsa-sha256 header.s=google header.b=W+CPTVne
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6279D605FC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 08:48:32 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350f91so850505f8f.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall.org; s=google; t=1789375711; x=1789980511; darn=lists.osuosl.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0kvizxDrpk0j6xDj6aqJhobOa++7+JeUcG4npstg5E8=;
 b=W+CPTVne9EzmjvdA49AnDPXM7RlX9silr9PdrYMb3oStViLMkGdY2lYbb2y1hiUoo/
 D1cmBM2111sNNL7ZfmS8NUKquPLerND4JyB/ftw/biJOebbwrE90uXQHkZheQGTTC4Bo
 BwUiQzjxu51pkY9AfEjHeNhryJUYSV2Wvw7JbP3+FqRiriUHvHSUlHyUZXNpesSQ211n
 hpmj1ih9y294GavQKCY44OqIt09NSeuZQgKVGh/aYnnR7HzakPgAf6dk0bPnlR5FJ7j1
 kT/RlBA/sYudJjAwbGN27M1qK4yrNZdW5+3jzKFZ74o5Z1bFatFOriP7msHFLjGCRfYz
 NNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789375711; x=1789980511;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0kvizxDrpk0j6xDj6aqJhobOa++7+JeUcG4npstg5E8=;
 b=UIDWXpkzh78xMueIoMMTooJMnXSkQp9wPoeks+3RdmkFa0BDqKk6Dab+OD7oVDEEnT
 FAkm7ie6aPuG8VB0OU3sQeK93lGn50Dezlpn2zOmIt9Sv3xbpfLJhEW/nKwUJv+1Lx0O
 jiaOzGmyH1Jk1oCJbT/b6WAPSm/DqZb+7m1jnma4uA7wkcRHrupQGYKk7j45sliDKyRQ
 rE5VN3CrfOyjitkbcn9V80HG7GRnG7f2PAgzvHDdL4VfdvXCCa+Xs8I5LN3QrZkAQY5Z
 +iD2vChp4e7Ui0k70+7KnDbiVJgRPp4fxIhzhazJUpC7X2zdwkPr0R70TeKY+65/IoUR
 uuLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGSYlStRLMh+r7KLHtUMCqGGLs0nhy4lxcxK27Dta7dPPeXHL5FBLmIN4Ui9HHtN2m/IYKoG26+p97wDNlV4E=@lists.osuosl.org
X-Gm-Message-State: AFuF++nMX5TFYRqMTjV76jJKDg14/KjtRPf49dMHGupv8GMopEUfUMw2
 CwPjBILMOS1QvQIJ1wmYinKf9gPhSZSL71Nwbu6xqWo5EQmr6cc1NR1FeRA8fIpZwj0=
X-Gm-Gg: AYBFou2fKWDhtBXL4Dl9C/8FlHgkuOabAwagIeSvGF6UbFrdrGSIlwoDBAGthh7F2Rt
 2lwoHbUmuI4zM1HoDjs00TG1gKMvw3KfGLk4GLLOzh/E+pJtc6wGrBzo1zdRgZrBR0ZrM8/wrQw
 +nNbBw5+91E+6wU+u7UqqYf/izdmmzVdS/Np7WLYLmNrpbWCmHTtswYNHFWNp+QYOpzRBlgqK5p
 zCJiT7eJCTu05q0k0hu6U3FyeABitRNVEAgqEdWIcWOjQ5S6sjSFsnVnRqEAsf3KMxwVyd6SKud
 RQV5+u4kO76VI6eYQ83flHjY13TeNYeHtSwki1wYrDuf1iC2ERSgwNUcVpdydMJdr9qczvBgr01
 C/RCy9MyOkhirmiPbdmqqNfOkxHDT1pgb0TAkNoFM3ssZeyAnDZJZCY8yZQdtHLsxWhvTvvKvQF
 /f65bdgZXbl7MXBtCr8treeU59/7emRvHGfMIAsLPdO6w1vFHOA5pzNPo+iZYkrhUYa7scB0n3w
 tuCs8NJZTtrGg9euNt9NR21x9whLg==
X-Received: by 2002:a05:6000:41eb:b0:484:42d5:e6d5 with SMTP id
 ffacd0b85a97d-48702a9a973mr1744558f8f.11.1789375710548; 
 Mon, 14 Sep 2026 01:48:30 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fd3bsm25823507f8f.19.2026.09.14.01.48.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 01:48:30 -0700 (PDT)
Message-ID: <2ce01033-a121-4d50-b629-f35e789a4743@blackwall.org>
Date: Mon, 14 Sep 2026 11:48:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: bridge: fail link info that does not
 fit the IFLA_AF_SPEC nest
Content-Language: en-US, bg
To: Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, kuniyu@google.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 oss-drivers@corigine.com, wintera@linux.ibm.com, aswin@linux.ibm.com,
 linux-s390@vger.kernel.org
References: <20260912135022.1701-1-iprintercanon@gmail.com>
 <20260912135022.1701-3-iprintercanon@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260912135022.1701-3-iprintercanon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/09/2026 16:50, Artem Lytkin wrote:
> br_fill_ifinfo() puts all of a port's VLAN, tunnel and MST entries into
> one nest, and nla_len is a u16, so a large enough port produces a nest
> whose length wraps and userspace reads garbage.
> 
> Cancel the message and return -E2BIG with an extack pointing at
> RTM_GETVLAN instead. The dump retries the port with an empty skb and
> the error goes to userspace; notifications reach rtnl_set_sk_err() and
> listeners resync. Not -EMSGSIZE, since no bigger buffer would help.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
> ---
>   net/bridge/br_netlink.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 

This patch seems incomplete, it doesn't fix the same problem for MST and CFM.
They both can use the same helper - nla_nest_end_safe().
More below...

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 855a46aec3a89..53676df9e4d11 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -459,7 +459,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>   			  const struct net_bridge_port *port,
>   			  u32 pid, u32 seq, int event, unsigned int flags,
>   			  u32 filter_mask, const struct net_device *dev,
> -			  bool getlink)
> +			  bool getlink, struct netlink_ext_ack *extack)
>   {
>   	u8 operstate = netif_running(dev) ? READ_ONCE(dev->operstate) :
>   					    IF_OPER_DOWN;
> @@ -613,6 +613,12 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>   
>   done:
>   	if (af) {
> +		if (skb_tail_pointer(skb) - (unsigned char *)af > U16_MAX) {

here you can use nla_nest_end_safe()

> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "VLAN information does not fit in one message, use RTM_GETVLAN");
> +			nlmsg_cancel(skb, nlh);
> +			return -E2BIG;
> +		}
>   		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))

while here you can just change this to if !nla_len(af) nla_nest_cancel()

Also add a common label and goto it from all errors e.g:
nla_nest_too_large:
   	nlmsg_cancel(skb, nlh);
   	return -E2BIG;
>   			nla_nest_end(skb, af);
>   		else
> @@ -654,7 +660,8 @@ void br_info_notify(int event, const struct net_bridge *br,
>   	if (skb == NULL)
>   		goto errout;
>   
> -	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
> +	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false,
> +			     NULL);
>   	if (err < 0) {
>   		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
>   		WARN_ON(err == -EMSGSIZE);
> @@ -693,7 +700,7 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   		return 0;
>   
>   	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
> -			      filter_mask, dev, true);
> +			      filter_mask, dev, true, extack);
>   }
>   
>   static int br_vlan_info(struct net_bridge *br, struct net_bridge_port *p,

