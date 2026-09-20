Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4733C982D0
	for <intel-wired-lan@archiver.kernel.org>; Sun, 20 Sep 2026 07:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 671AE6064E;
	Sun, 20 Sep 2026 07:08:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AWtnTDyCU0wW; Sun, 20 Sep 2026 07:08:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 572EF6064F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789888120;
	b=YPYoofiaVPyoB2aCOVaJXEycB9z9Bbz1y4kq+qj5b/YOwdTv6r78BDuc5UretWhsF1Zw
	 OQP2JHMw569LuAT/ltR42ZWvfVm9kZLqmTRNj5fvHd5swX5dy+wMtdtofv7TIPhE3sG1V
	 XDns38PFr+7HtZy9ZXCj9boRiJO/vFY08LmVD1QlZ3guAzMh3JAJAWKCFBjWV2bcAa5Ze
	 E2lfxngQWVwlgCsaNIP454k0m8xmW2689zkCLdpULDrs636wosJEk1gf9b+ZqLXTbYbvw
	 wRZ+x0UW7IgCk2haZeCxP+zVV/hvNG87I2tFl/vdtU9zGbQxxFej8zXPLIrpZtnyWJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789888120;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IWoOG7D8vztnIM1BP023M7H61wV5J54IgjjOh01M0Yk=;
	b=YZkJEGANg2jbjFQ8ATFuMa2z53WEnFZNKtH3yCBKFqnRE80cY+xOH+hBD+ISgrMVnwbT
	 JJ0OFxnUcba9khUhKYx27IvGKgfUh5lcTu/jJaJez5FcyUdQyC+QqoturKJ0DpcHIRJnf
	 PzZj5iWYhnwAu40+QGJJ7CAc5una5N18N1D9kOi6vwAzvzRAkqIqTkWd55jc5o4jI90ya
	 oKKe9q5RZoTeFAZmALew5m5PFzkh85OpbJxqr+QBS8Z63V+PpMv5D6SlPIWzFqyx/UPIJ
	 z10SqE+ae0DqbRw1pK2jqDZACM8WOop5Pau+Zh0RByu4jhqSHwFjmv9JyHc6uwLRebw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=YDRfdknd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789888120;
	bh=IWoOG7D8vztnIM1BP023M7H61wV5J54IgjjOh01M0Yk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cS7oKHlUQHz6Mrl9DSSApvOQ82WH2DPSu0SZ7Trvh4lWrc+S7pZLX2vea0vnA9ZG8
	 dNLr/Hn5WPFmLMNlJBgEjBJmLL7j9SZ9J7RJY9MwNEyuPCLWs1aOWR1OMekhkbAd9o
	 ZtRzxIG0l1BHymdHrwc+1T9Cea0eXDOdOUs/3cT3A13l8Hle+7Sb5YzM50ubUAYh2r
	 OsXnRoIFlNZERyq4fCjbOIaBnAuLKmiHUrcdoVBNqOAGMUaokd8dH/ZisreZLJIw1D
	 /ciMMj2KsmQbljJOJaQglFjM2RM1kwRGf8Tfek2/luBHgyaNhCizLTSWMPqlg6FZtr
	 aVB+TS0V2Sidg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 572EF6064F;
	Sun, 20 Sep 2026 07:08:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C8253FA
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 07:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E5D160650
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 07:08:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wvd40EXYmZLV for <intel-wired-lan@lists.osuosl.org>;
 Sun, 20 Sep 2026 07:08:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BE9226064E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::1d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789888118;
 b=o9ooXIdLjHw8j62CHqBfkNhriX9euyW39bwU7+Bgr2TJCHvO8Z4AZz2Yj5hP18GmLoe5
 G4IGCNf3XDKO3b5KmDzs+CZLcBAEZviH8CB7WVlpC7z/AjH2twXKvz4Twv4IlYJboTcoF
 4mTe7uyq680qotXS/xChsAtBxf2QqvuBwDcmZoT29NyPnPWDPIahxMEWCV7hDhvG8Qnga
 E6hSaPiTiJLCqC1CvLoWwBqASjJJdQV/X3bK8VD8zA2EDzgmagZc+AyJ1DFdTB4mfnx+5
 /KA/fW2hT7vvkiTZO1+8SOBzHXr1l0PS11fMof+84CM10aCe9IAQv4TQk5Mnahdv3CA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789888118;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
 Cc:References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=IWoOG7D8vztnIM1BP023M7H61wV5J54IgjjOh01M0Yk=;
 b=UrTEstIHvxv0LMe+RwKWiF8g0pJFsAGfCA42A9j+KmlzpILO2sj7RNLxu33R9V6vI41Y
 EhL7IUSPabnY1xYDKTSxinv5Mw/IG5tKF0qQM+Fx1XZ4CUx2v2XSyRz00xYYrJM1ITV/5
 MJkswiq1aUVsK4Vp9ybATflGQ1MoT08ZO1PtkW+JM7pK014SvOUk/5P89DP1rNVAvIwQw
 w63grTXpQpDJFcAlVQeEteCxYdDeoTIU57jPVUwtYqViQgpQw8UGY8DJborUJvjqzdlKF
 Vw8IDBboYwjo2ON/QftOLNSj4HBA5F/wQ/jJri4nZ+j+DyzZ0FR8z0DEBCgecjH+bzg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=blackwall.org; 
 dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256
 header.s=google header.b=YDRfdknd; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::1d"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::1d; helo=mail-wr2-x1d.google.com;
 envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=blackwall.org header.i=@blackwall.org
 header.a=rsa-sha256 header.s=google header.b=YDRfdknd
Received: from mail-wr2-x1d.google.com (mail-wr2-x1d.google.com
 [IPv6:2a00:1450:4864:30::1d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE9226064E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 07:08:37 +0000 (UTC)
Received: by mail-wr2-x1d.google.com with SMTP id
 ffacd0b85a97d-484366874b0so1104246f8f.2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 00:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall.org; s=google; t=1789888115; x=1790492915; darn=lists.osuosl.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IWoOG7D8vztnIM1BP023M7H61wV5J54IgjjOh01M0Yk=;
 b=YDRfdkndpX1iczEq7nW19JhxSfbSFEtRZ7BiyjOttYarb1QC5h23FGM9nOoM4kjmG9
 P4YpV6T3w6aTui4At+Zil13LZ5PK0J6uqCPMrqzGobiDM8qsuRrGLI5sB2K46v18MfhJ
 wk0Fxb8WW8nQIbxmdh/FwR/3m7j1uSdxufIyddMhc3bQ5AC6uBi31tgbvWEnWe5iOe2s
 LZipuRRUKbUvcBfInDJsuvM8Jb/A20sXRBBgQfFvDRjNb8H1HywVLoPsMLiiqLmhHsFB
 KeTW5YqMRW5BUwFlQw6+tqtWPR68D5rohAvp+Zs9b4/tZ/5IvCZZXDc5y4b9hkMWdQvh
 SnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789888115; x=1790492915;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IWoOG7D8vztnIM1BP023M7H61wV5J54IgjjOh01M0Yk=;
 b=ye3SXPpKpkUhdayvMz6ohw0I/l1N66O5w+fyKVWBESbkYlwsO5N+7pIepT4KSvYn8J
 o/rDYPU1pEdPqRsO9yfB2bJo0o03fLpJgwT9wqpGvIUYkainPgSiVwG6V/UD2Dm2yloc
 CZzXPUGDEfgVstdfTns3auJ84nec36IIhyBo3NJlZ4u8t3xvoOb8fNNqPzvXnixvZALF
 716gM/aS7CklUm3RjkOMfCYukQ2NxioLHgJOtNVsD2SjTTbXJX52nZ8dHJua9xSYwTVI
 oSvw79292I3QdnArUCvE5uqVFxUJGhCEifQiAis4OWmaqj3ONUANcb/eiwUMW/zSDCBg
 5AVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLsXmwYiZ22l7lZ1mqkofo7J/a+lzcTi7CiHJuNsPMq0RXnJP/4B812nzDjpGtudPuv38+yYJ4d1japnuqHNE=@lists.osuosl.org
X-Gm-Message-State: AFuF++lpqX4fEy/GJ4KguummrEcI24AriTzGkJpPJ0RwNpH0J7m7MKO0
 PDIPEf3sCrC44bO5v0ny6DFp/wYorzdkrrs9zf5d6rIZbJkc+nkS5ZWCFmv14kv4Tag=
X-Gm-Gg: AYBFou0WM4A8qaAksk9EOL2fgAn2NGHA+Srk2bKaGZskSnWBILPKH+gATUkQXqgi4yJ
 7mMvteuv8u7SYe8F/oa1dut8fEvNo1SeBBGEfcOENHF5Zi9XrwSEbI7OA+qfBu9CyU1E9FBL5Ri
 3JzsVIImvLt2PSUOSSEPkdj1hdtC+W0Is0xntnbZ/wavnrXqUCONDh6sAautu/WvGX9KswL0EdG
 Q/gWuhg7kt6AcX7Y7fiwQFG0vs0Nf61albPjhC6vhbwCk4hzHjWA0pKB6vi+FAqceTjYz5V6QSs
 Jqn4Wso3BrGsuitY7rZClCvJXsqU+cCrPDDniz87aOUQLQsxLrsnQilybyXkk1WXVmEjuVcaZ7v
 jKCLvAD1ZXyzW6b3hK8qFMHOFjqPbo4Q5L3XxhC/IQOMtvEsJI//7ucHy0AGQ/j+HBK81bX2asE
 WVSNqRMNDS2uuMseNAYRBkG/C28+b0WQj3n0Q2UjHQ21Ot5KzGNOJmqCe1YgGBh6QYUD1TyT9U+
 iJfSgEir+b/CFq/n8dLaFrvWmKUoA==
X-Received: by 2002:adf:e001:0:20b0:487:21a4:f617 with SMTP id
 ffacd0b85a97d-48721a4f785mr9429604f8f.19.1789888115117; 
 Sun, 20 Sep 2026 00:08:35 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724583250sm12547870f8f.22.2026.09.20.00.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 00:08:33 -0700 (PDT)
Message-ID: <7264d59b-45d1-4235-9079-dfb8e800dd83@blackwall.org>
Date: Sun, 20 Sep 2026 10:08:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] rtnetlink: pass extack to
 ndo_bridge_getlink()
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
 <20260919134333.49379-2-iprintercanon@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260919134333.49379-2-iprintercanon@gmail.com>
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
> So the bridge can say why filling the link info failed.
> No functional change.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c      |  4 ++--
>   drivers/net/ethernet/emulex/benet/be_main.c    |  4 ++--
>   drivers/net/ethernet/intel/i40e/i40e_main.c    |  6 ++++--
>   drivers/net/ethernet/intel/ice/ice_main.c      |  6 ++++--
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  5 +++--
>   .../net/ethernet/mellanox/mlx5/core/en_main.c  |  4 ++--
>   .../ethernet/netronome/nfp/nfp_net_common.c    |  4 ++--
>   drivers/s390/net/qeth_l2_main.c                |  4 ++--
>   include/linux/netdevice.h                      |  5 +++--
>   include/linux/rtnetlink.h                      |  3 ++-
>   net/bridge/br_netlink.c                        |  3 ++-
>   net/bridge/br_private.h                        |  2 +-
>   net/core/rtnetlink.c                           | 18 +++++++++++-------
>   13 files changed, 40 insertions(+), 28 deletions(-)
> 

Why do you add extack to ndo_dflt_bridge_getlink() at all? It doesn't use it and
just causes unnecessary churn in drivers.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index ca99f4b1a63c3..a752e66bf6368 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16154,12 +16154,12 @@ static const struct udp_tunnel_nic_info bnxt_udp_tunnels = {
>   
>   static int bnxt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   			       struct net_device *dev, u32 filter_mask,
> -			       int nlflags)
> +			       int nlflags, struct netlink_ext_ack *extack)
>   {
>   	struct bnxt *bp = netdev_priv(dev);
>   
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, bp->br_mode, 0, 0,
> -				       nlflags, filter_mask, NULL);
> +				       nlflags, filter_mask, NULL, extack);
>   }
>   
>   static int bnxt_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
> diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
> index ed302f5ec4768..cc9c87539a429 100644
> --- a/drivers/net/ethernet/emulex/benet/be_main.c
> +++ b/drivers/net/ethernet/emulex/benet/be_main.c
> @@ -5011,7 +5011,7 @@ static int be_ndo_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
>   
>   static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   				 struct net_device *dev, u32 filter_mask,
> -				 int nlflags)
> +				 int nlflags, struct netlink_ext_ack *extack)
>   {
>   	struct be_adapter *adapter = netdev_priv(dev);
>   	int status = 0;
> @@ -5037,7 +5037,7 @@ static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
>   				       hsw_mode == PORT_FWD_TYPE_VEPA ?
>   				       BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB,
> -				       0, 0, nlflags, filter_mask, NULL);
> +				       0, 0, nlflags, filter_mask, NULL, extack);
>   }
>   
>   static struct be_cmd_work *be_alloc_work(struct be_adapter *adapter,
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index abbc71e815ae3..52c2b393aacd2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -13151,6 +13151,7 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
>    * @dev: the netdev being configured
>    * @filter_mask: unused
>    * @nlflags: netlink flags passed in
> + * @extack: netlink extended ack
>    *
>    * Return the mode in which the hardware bridge is operating in
>    * i.e VEB or VEPA.
> @@ -13158,7 +13159,8 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
>   static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   				   struct net_device *dev,
>   				   u32 __always_unused filter_mask,
> -				   int nlflags)
> +				   int nlflags,
> +				   struct netlink_ext_ack *extack)
>   {
>   	struct i40e_netdev_priv *np = netdev_priv(dev);
>   	struct i40e_vsi *vsi = np->vsi;
> @@ -13175,7 +13177,7 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   		return 0;
>   
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, veb->bridge_mode,
> -				       0, 0, nlflags, filter_mask, NULL);
> +				       0, 0, nlflags, filter_mask, NULL, extack);
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 707c7431b91a6..f98295438df78 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -8095,12 +8095,14 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
>    * @dev: the netdev being configured
>    * @filter_mask: filter mask passed in
>    * @nlflags: netlink flags passed in
> + * @extack: netlink extended ack
>    *
>    * Return the bridge mode (VEB/VEPA)
>    */
>   static int
>   ice_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
> -		   struct net_device *dev, u32 filter_mask, int nlflags)
> +		   struct net_device *dev, u32 filter_mask, int nlflags,
> +		   struct netlink_ext_ack *extack)
>   {
>   	struct ice_pf *pf = ice_netdev_to_pf(dev);
>   	u16 bmode;
> @@ -8108,7 +8110,7 @@ ice_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   	bmode = pf->first_sw->bridge_mode;
>   
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, bmode, 0, 0, nlflags,
> -				       filter_mask, NULL);
> +				       filter_mask, NULL, extack);
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index f91856498eb2d..77dfd80a6e368 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -10726,7 +10726,8 @@ static int ixgbe_ndo_bridge_setlink(struct net_device *dev,
>   
>   static int ixgbe_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   				    struct net_device *dev,
> -				    u32 filter_mask, int nlflags)
> +				    u32 filter_mask, int nlflags,
> +				    struct netlink_ext_ack *extack)
>   {
>   	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
>   
> @@ -10735,7 +10736,7 @@ static int ixgbe_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
>   				       adapter->bridge_mode, 0, 0, nlflags,
> -				       filter_mask, NULL);
> +				       filter_mask, NULL, extack);
>   }
>   
>   static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index fc110a7d16e8d..53bf79dbe08de 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5277,7 +5277,7 @@ static int mlx5e_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>   #ifdef CONFIG_MLX5_ESWITCH
>   static int mlx5e_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   				struct net_device *dev, u32 filter_mask,
> -				int nlflags)
> +				int nlflags, struct netlink_ext_ack *extack)
>   {
>   	struct mlx5e_priv *priv = netdev_priv(dev);
>   	struct mlx5_core_dev *mdev = priv->mdev;
> @@ -5288,7 +5288,7 @@ static int mlx5e_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   	mode = setting ? BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB;
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
>   				       mode,
> -				       0, 0, nlflags, filter_mask, NULL);
> +				       0, 0, nlflags, filter_mask, NULL, extack);
>   }
>   
>   static int mlx5e_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> index 7928e76da723e..cb751dddb6887 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> @@ -2257,7 +2257,7 @@ static int nfp_net_set_mac_address(struct net_device *netdev, void *addr)
>   
>   static int nfp_net_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   				  struct net_device *dev, u32 filter_mask,
> -				  int nlflags)
> +				  int nlflags, struct netlink_ext_ack *extack)
>   {
>   	struct nfp_net *nn = netdev_priv(dev);
>   	u16 mode;
> @@ -2269,7 +2269,7 @@ static int nfp_net_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   	       BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB;
>   
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, mode, 0, 0,
> -				       nlflags, filter_mask, NULL);
> +				       nlflags, filter_mask, NULL, extack);
>   }
>   
>   static int nfp_net_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
> diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
> index 2935c2ecc314b..f960cf5a97a29 100644
> --- a/drivers/s390/net/qeth_l2_main.c
> +++ b/drivers/s390/net/qeth_l2_main.c
> @@ -935,7 +935,7 @@ static void qeth_l2_br2dev_put(void)
>   
>   static int qeth_l2_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   				  struct net_device *dev, u32 filter_mask,
> -				  int nlflags)
> +				  int nlflags, struct netlink_ext_ack *extack)
>   {
>   	struct qeth_priv *priv = netdev_priv(dev);
>   	struct qeth_card *card = dev->ml_priv;
> @@ -949,7 +949,7 @@ static int qeth_l2_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
>   				       mode, priv->brport_features,
>   				       priv->brport_hw_features,
> -				       nlflags, filter_mask, NULL);
> +				       nlflags, filter_mask, NULL, extack);
>   }
>   
>   static const struct nla_policy qeth_brport_policy[IFLA_BRPORT_MAX + 1] = {
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 1f0710eef185b..02238b1e33453 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1360,7 +1360,7 @@ struct netdev_net_notifier {
>    *			     u16 flags, struct netlink_ext_ack *extack)
>    * int (*ndo_bridge_getlink)(struct sk_buff *skb, u32 pid, u32 seq,
>    *			     struct net_device *dev, u32 filter_mask,
> - *			     int nlflags)
> + *			     int nlflags, struct netlink_ext_ack *extack)
>    * int (*ndo_bridge_dellink)(struct net_device *dev, struct nlmsghdr *nlh,
>    *			     u16 flags);
>    *
> @@ -1659,7 +1659,8 @@ struct net_device_ops {
>   						      u32 pid, u32 seq,
>   						      struct net_device *dev,
>   						      u32 filter_mask,
> -						      int nlflags);
> +						      int nlflags,
> +						      struct netlink_ext_ack *extack);
>   	int			(*ndo_bridge_dellink)(struct net_device *dev,
>   						      struct nlmsghdr *nlh,
>   						      u16 flags);
> diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
> index 95729339e7a54..a408c36a7b558 100644
> --- a/include/linux/rtnetlink.h
> +++ b/include/linux/rtnetlink.h
> @@ -222,7 +222,8 @@ extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   				   u32 filter_mask,
>   				   int (*vlan_fill)(struct sk_buff *skb,
>   						    struct net_device *dev,
> -						    u32 filter_mask));
> +						    u32 filter_mask),
> +				   struct netlink_ext_ack *extack);
>   
>   extern void rtnl_offload_xstats_notify(struct net_device *dev);
>   
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index ae76df0de05a0..855a46aec3a89 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -680,7 +680,8 @@ void br_ifinfo_notify(int event, const struct net_bridge *br,
>    * Dump information about all ports, in response to GETLINK
>    */
>   int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
> -	       struct net_device *dev, u32 filter_mask, int nlflags)
> +	       struct net_device *dev, u32 filter_mask, int nlflags,
> +	       struct netlink_ext_ack *extack)
>   {
>   	struct net_bridge_port *port = br_port_get_rtnl(dev);
>   
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 09c397e303307..edbe7a1f57363 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -2179,7 +2179,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags,
>   	       struct netlink_ext_ack *extack);
>   int br_dellink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags);
>   int br_getlink(struct sk_buff *skb, u32 pid, u32 seq, struct net_device *dev,
> -	       u32 filter_mask, int nlflags);
> +	       u32 filter_mask, int nlflags, struct netlink_ext_ack *extack);
>   int br_process_vlan_info(struct net_bridge *br,
>   			 struct net_bridge_port *p, int cmd,
>   			 struct bridge_vlan_info *vinfo_curr,
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index e3444fd240615..a341e06f47d31 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -5420,7 +5420,8 @@ int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   			    u32 filter_mask,
>   			    int (*vlan_fill)(struct sk_buff *skb,
>   					     struct net_device *dev,
> -					     u32 filter_mask))
> +					     u32 filter_mask),
> +			    struct netlink_ext_ack *extack)
>   {
>   	struct nlmsghdr *nlh;
>   	struct ifinfomsg *ifm;
> @@ -5596,7 +5597,8 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
>   			if (idx >= cb->args[0]) {
>   				err = br_dev->netdev_ops->ndo_bridge_getlink(
>   						skb, portid, seq, dev,
> -						filter_mask, NLM_F_MULTI);
> +						filter_mask, NLM_F_MULTI,
> +						cb->extack);
>   				if (err < 0 && err != -EOPNOTSUPP) {
>   					if (likely(skb->len))
>   						break;
> @@ -5612,7 +5614,8 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
>   				err = ops->ndo_bridge_getlink(skb, portid,
>   							      seq, dev,
>   							      filter_mask,
> -							      NLM_F_MULTI);
> +							      NLM_F_MULTI,
> +							      cb->extack);
>   				if (err < 0 && err != -EOPNOTSUPP) {
>   					if (likely(skb->len))
>   						break;
> @@ -5646,7 +5649,8 @@ static inline size_t bridge_nlmsg_size(void)
>   		+ nla_total_size(sizeof(u16));	/* IFLA_BRIDGE_MODE */
>   }
>   
> -static int rtnl_bridge_notify(struct net_device *dev)
> +static int rtnl_bridge_notify(struct net_device *dev,
> +			      struct netlink_ext_ack *extack)
>   {
>   	struct net *net = dev_net(dev);
>   	struct sk_buff *skb;
> @@ -5661,7 +5665,7 @@ static int rtnl_bridge_notify(struct net_device *dev)
>   		goto errout;
>   	}
>   
> -	err = dev->netdev_ops->ndo_bridge_getlink(skb, 0, 0, dev, 0, 0);
> +	err = dev->netdev_ops->ndo_bridge_getlink(skb, 0, 0, dev, 0, 0, extack);
>   	if (err < 0)
>   		goto errout;
>   
> @@ -5752,7 +5756,7 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   			/* Generate event to notify upper layer of bridge
>   			 * change
>   			 */
> -			err = rtnl_bridge_notify(dev);
> +			err = rtnl_bridge_notify(dev, extack);
>   		}
>   	}
>   
> @@ -5827,7 +5831,7 @@ static int rtnl_bridge_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   			/* Generate event to notify upper layer of bridge
>   			 * change
>   			 */
> -			err = rtnl_bridge_notify(dev);
> +			err = rtnl_bridge_notify(dev, extack);
>   		}
>   	}
>   

