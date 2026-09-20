Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B64C982CC
	for <intel-wired-lan@archiver.kernel.org>; Sun, 20 Sep 2026 07:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 442FC6064E;
	Sun, 20 Sep 2026 07:06:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RwvnH-jTH0Ig; Sun, 20 Sep 2026 07:06:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8C40C6064F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789888001;
	b=JagORxLkDSXp09uX8VZCk7xhhV1aQyM57nHP4LkQYaK9qK7V/eaOxouOEwaf2LddMjxF
	 ldM3z/PAavfoFy2kl9urLoRasdvv2hY0MZRlc1933Yh2PIe+Wqfq7Z7H9arr4LIAAKzyO
	 ygqH/j3uOEN6C/F4mP9U5g0YqjhTLvewStMVYV5V5dLGFLzCNKJm7l/kEfJ+b7qStJiW5
	 u40dvHtfJDOfcqjvXU9tURdy/SDe+bRtcGQuZs3O2xzJVOtB45kpkszra/QbYOfGVcozg
	 TJ1v5AUzJB224CKiYzChQaXXm/rV9KWEMbKe6jTZsaStTb9XNX4sheyv6auTOrVfHBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789888001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sCbcg84Wkufy21atUPqDKKDB5cQsptTtPpZ9zNWHEmU=;
	b=nUpzMWGw+WLYt5FGaOvD7u3cNufn/gGSCcx0HvqY4xQu3gbzs/1gNzKwaTjhToJusIrV
	 xrQYrM1Kbh7SKnxBGtBBQ09W/4mR2ooqNsirWC/ARpIgvrSvhiCMWmH0+mFSK1gIDS/T7
	 XGag39xv8LV63C1cmWDd0bu9DE6T/b/qTWI0szOpWJdM+PHjIxCCuSwRf385Y6VC4GFKF
	 sPeRhWUlJ6l703vyKLPTBeebRn2dzkL89Zq6F2xYXIAiEkz0i95aBgyUJCIAnflIbnMsd
	 pzGTfIE2cp/3RuBsxjune2073UwbO7HfbTKRkPozuLMmxqXNy/oQQoZmWTPTG5zbdYg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789888001;
	bh=sCbcg84Wkufy21atUPqDKKDB5cQsptTtPpZ9zNWHEmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tbWnfrEQBtF3K7eWAQPe/xU0S1isK+JH+RHtRae/cyfV7OwEqashJC4MftMcTGFaM
	 TDZUGXyvg39zJLsnRVlI0Yk1+AHAQcboKef6mEiuX0ciXKBx+x3x2bASnL5op8YttX
	 eAY5oeBdq30dmU5YBqBypshuNadBJiQkN9JiuyLb9JvHiXtFyJ+bLTe668kzlvFSWH
	 7d4XirwouKYOeDr9k83PkUBulOFg6CBlD8IRpKMDK/0j+kGIAkmH9FcQg4nySiPErw
	 XV+zl0pBNjt8J/O+qPrwxtN7wys+cnt7N+URmgqG3KMXyx7aMDnevU+yoQ46LEIjqF
	 8qoqZo8ksNfbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C40C6064F;
	Sun, 20 Sep 2026 07:06:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F5B213D
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 07:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D7FA400F5
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 07:06:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JGYqauZT5FEY for <intel-wired-lan@lists.osuosl.org>;
 Sun, 20 Sep 2026 07:06:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5FB2840062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789887998;
 b=ixa/c4P4tN9e9FsfbuRpmopW9/2IKSPsKswZhZ8UljqxUM90o5UsUHKoSO5N8jzH+H+U
 iJmRMUh/AfQABFqpWWRGSkRMM9sy9F0svYUyalR8QzLAoUstnPySYiYy5Z+N2pQ8Tglzo
 sqJtJ3ioSyXh2j0ntVd6/vEXgCtbZsfc4EinY3wdh4iDpFev4IBT4R5XSftX48k6Phwkf
 d74SZ2Q5gK54g0WlKHxZRKVBDaNnIGvfYjgehTsEbnr+gOjGxLlyv/i/Lz8mdf4PFiEHE
 zWqyXlHcNc+diNQdEzkB8u8r3FK4ruBp4fSqe/bOHkstxGiWIUe8PhI5GrebgsZLf0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789887998;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
 Cc:References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=sCbcg84Wkufy21atUPqDKKDB5cQsptTtPpZ9zNWHEmU=;
 b=nCSib8b8Xa90Rqm/0Z0XGEzdFWJENyoklg4KjGinbKWD4ei9/Ox696HxsWPbmbUqhume
 Fc2dx0MUrjX3m3m1ZyKbsrPE7VdqDw4VEZwWIJP6V8fwM2WWCC2n4U9VBZoz70I7IuewZ
 3Zkca3kiiR0YIFXTAuY3pHqmXxAe7qkK+7Kn56yQ1Rcc8S9NFR+IU5YQc6D96KnVnS3TT
 CSI9uWKF2wJHkClxoqA1eyP89ctc5kPpUIS2+/pT8cdNOakm6kiXs7+sYbYaEHlcZGwS0
 cBA80zSgraytV3zhN/w1ahtYZoid00IxW08VK/XVlGZqXqtqCQjXTnHtiEaJbyVD2ZQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=blackwall.org; 
 dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256
 header.s=google header.b=A8IW89BA; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=blackwall.org header.i=@blackwall.org
 header.a=rsa-sha256 header.s=google header.b=A8IW89BA
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FB2840062
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 07:06:37 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso26452045e9.2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall.org; s=google; t=1789887995; x=1790492795; darn=lists.osuosl.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sCbcg84Wkufy21atUPqDKKDB5cQsptTtPpZ9zNWHEmU=;
 b=A8IW89BAw+tzcD/qqTppOYQTGZvdbMKaGhbyETI1gKIuGMSCeQywk0ua/hmZ+wBQXg
 U/OMoL3hMg65Q5SyVP99D1jlGKqQ2DunDShpHADN/T4DOuvvsmY+2t/bj9RPJ3GMgzpL
 70g7SH3/6j0VTCQmb8yGBF6mVyhHBCiRP01yEMXzvq37fWpeIG2bFAhw2Fy575trnQQV
 IqcpzDHnN1oDPUyOMwjVsEtfCdlk6CquDY+xsFQ3nmBoTPzQrOWXXzyKY5HwuyEe5au0
 c61+S7pgk+odqmnzHVj8O6eAQsWuOLHVIUb/BzzH9X6Is4nR2ZNloF+eUf4MRtekhegO
 LV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789887995; x=1790492795;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sCbcg84Wkufy21atUPqDKKDB5cQsptTtPpZ9zNWHEmU=;
 b=sClab0ope0Tk0G5d3oEy/090vxItfGUPL9vH4UsUkE0UsQfaucTTqPEUJuv5PkfCjw
 yH8u8lcU1AG9kgBa6T+eoj8ypb1rW34UZXWWz/GpfCzETklR+1mBucsfeYqnO/PbjvAM
 ybjNG0rGFYQWew9XShYef5SJT75hMR2pIWZVslazrN0mmamg7TWmqca40QjCC+kUMbtZ
 E2DtP67U3GzPNf5pwANXsDBM8orw4mtNg2uUyzVoEZ1EIBkGXmoNqSwqMXN3rrWWAe8D
 g4trU5ry0/IPT733c4okohT5ADu6RMMOtJBA446/S+m82GUQLiK5XGhXP5M56PkAZMyD
 7w7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFvz1SFZmlxYDnBtuiS/jJMu5iK1AvDkplibFHs42gcFnZBvUKsNS+v5PM+5QeOl9YLVKEN3u7jxbHcSfBvXw=@lists.osuosl.org
X-Gm-Message-State: AFuF++kNi+/HWfyya2FUEKnoI7e0Qw0XvHlfqJWYjl6HKBxESlQi4YNN
 XRxzeF7vF1Qs0r58ADQ4u1Kx8TMN438Dus9MGMr/F34Vq1VffciMJ2RXgDPulvdbClg=
X-Gm-Gg: AYBFou1JeVnsSd8V6/YxrvecpE+gVimo92ynDkhuI5bzNb2cTD+9VJeJqiz9Lg65f2i
 eS7GmbZKrN2axcQLMf7R9LYKPobM/rUQKBOiZ/O9SyiJJLn+XLUw9Eo5eoCN65fdR4AQC6hy3g+
 vIaknbFe2oaFzv/ru8LDPFUPQ2eW1GcDYvlcQurEjYAH//PGhpGeeCL5s3sK76HEXRcWWmVO+4k
 H0w8BlxeBW1jcnvY1buE0osRWeqb4PH5K5p/CCX/M9K5iqsxYAUIQK1XQbdFTwC36dZVcR09fWO
 /DDqsO/qVLdq/ahcmoRJhWsPkG79jvukBuUnI3sMZhTIvbwNHq4VSNmcHYzoQeOMh8WnifIPlc8
 +y369ic9XwgpTOzpDoz05pVSaPWTfc6lTHkuEgEwIfyNQyiPMgYvTO7zLmiptnF038EtNYvjUEz
 z0YEwYqafRf6N7dvo7QXc5Nz9KiGRPBuGTJ479tDu7qZNNh5eO6xkYpj4u1x3yg41fxPTevOzXD
 2gbI4bWsrPTS/BBPFAC7Cj4CcVDqw==
X-Received: by 2002:a05:600c:1c20:b0:49f:bd3c:bc1c with SMTP id
 5b1f17b1804b1-49fc5739f3bmr106841865e9.23.1789887995037; 
 Sun, 20 Sep 2026 00:06:35 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd10273fsm129717115e9.7.2026.09.20.00.06.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 00:06:34 -0700 (PDT)
Message-ID: <ed1de95e-e112-4076-93f0-6f7668e657ad@blackwall.org>
Date: Sun, 20 Sep 2026 10:06:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: bridge: fail link info that does not
 fit in a netlink attribute
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
References: <20260919134333.49379-1-iprintercanon@gmail.com>
 <20260919134333.49379-3-iprintercanon@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260919134333.49379-3-iprintercanon@gmail.com>
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

On 19/09/2026 16:43, Artem Lytkin wrote:
> nla_len is a u16, and a port with enough VLANs, tunnels or MST entries
> makes the IFLA_AF_SPEC nest wrap, so userspace reads garbage. Same for
> the inner MST and CFM nests.
> 
> Use nla_nest_end_safe() for all three and return -E2BIG with an extack
> on overflow. Dumps end with that error, notifications go through
> rtnl_set_sk_err() so listeners resync.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
> ---
>   net/bridge/br_netlink.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 

You can add specific extack messages to the different dumping parts of br_fill_ifinfo
so the user can identify exactly which one doesn't fit and get a more accurate error.
More below...

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 855a46aec3a89..fbd91b86d4268 100644
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
> @@ -588,7 +588,8 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>   				goto nla_put_failure;
>   		}
>   

Before these you can call if (nla_nest_end_safe(skb, af) < 0) { }
in the vlan block and set a vlan-specific extack error message, in fact
you can do that after vlan info is dumped, then after vlan tunnels are dumped
and set specific messages depending on which one didn't fit.

nla_nest_end_safe updates nla_len but you can still append attributes
after it has been called

Then you have MRP, you can do the same there and so on.

> -		nla_nest_end(skb, cfm_nest);
> +		if (nla_nest_end_safe(skb, cfm_nest) < 0)
> +			goto nla_nest_too_large;

This can set its own extack err message, e.g.
CFM information exceeds the netlink attribute size limit

>   	}
>   
>   	if ((filter_mask & RTEXT_FILTER_MST) &&
> @@ -608,20 +609,27 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>   		if (err)
>   			goto nla_put_failure;
>   
> -		nla_nest_end(skb, mst_nest);
> +		if (nla_nest_end_safe(skb, mst_nest) < 0)
> +			goto nla_nest_too_large;

Same here but with MST

>   	}
>   
>   done:
>   	if (af) {
> -		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
> -			nla_nest_end(skb, af);
> -		else
> +		if (nla_nest_end_safe(skb, af) < 0)
> +			goto nla_nest_too_large;
> +		if (!nla_len(af))
>   			nla_nest_cancel(skb, af);
>   	}
>   
>   	nlmsg_end(skb, nlh);
>   	return 0;
>   
> +nla_nest_too_large:
> +	NL_SET_ERR_MSG_MOD(extack,
> +			   "AF_SPEC info too large, use per-object dumps (e.g. RTM_GETVLAN)");

Just make sure here to use NL_SET_ERR_MSG_WEAK_MOD() so extack doesn't get overwritten

> +	nlmsg_cancel(skb, nlh);
> +	return -E2BIG;
> +
>   nla_put_failure:
>   	nlmsg_cancel(skb, nlh);
>   	return -EMSGSIZE;
> @@ -654,7 +662,8 @@ void br_info_notify(int event, const struct net_bridge *br,
>   	if (skb == NULL)
>   		goto errout;
>   
> -	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
> +	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false,
> +			     NULL);
>   	if (err < 0) {
>   		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
>   		WARN_ON(err == -EMSGSIZE);
> @@ -693,7 +702,7 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   		return 0;
>   
>   	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
> -			      filter_mask, dev, true);
> +			      filter_mask, dev, true, extack);
>   }
>   
>   static int br_vlan_info(struct net_bridge *br, struct net_bridge_port *p,

