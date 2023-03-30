Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536B5C77B62
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Mar 2023 18:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF9E341FAC;
	Thu, 30 Mar 2023 18:35:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF9E341FAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680201345;
	bh=aGM4NH4qhVGDrx2AybbrVNxWCfj/rFvUwdogpWpDAB8=;
	h=Date:In-Reply-To:References:From:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8CjZqrRJle4AWN0N5Z9DthJYdt4gAVP1sIWyrFwx36ao9her9J60zNVnaC37dJR+1
	 brzrYwuvlv6MsCbT6gZwpzmt5zyF8LDBn28TfNrJF5m+WYvS4992NIV2N6Xdl3ow6J
	 2pTB4t+61VKa/638cxArB5APgn0/W/Y+HVFSI79KeRDF92DQGj4fRS+Qs4vR6Dax/F
	 rjPP0SEmRcKb+bmYAbg5YoecLgo/fvK/0S/iofHLwemLitTA8RNpe3TAs+E7Dx3snu
	 Hj2FS4jZ1xFDSwSetE3/3Q1YDGVVoEy4sSzgrJL4320HRZxqp4fEoQUuqzLnOVyYdy
	 E4zzddWqgEU3w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9sNa-Hl14L8i; Thu, 30 Mar 2023 18:35:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F09941FB0;
	Thu, 30 Mar 2023 18:35:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F09941FB0
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 57D211BF2AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 18:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2DBC541FB0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 18:35:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DBC541FB0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0S-BLh9PizmP for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Mar 2023 18:35:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02BD141FAC
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02BD141FAC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 18:35:40 +0000 (UTC)
Received: by mail-pg1-x549.google.com with SMTP id
 q30-20020a631f5e000000b0050760997f4dso5660130pgm.6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 11:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680201340;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tJ8KMmzZMobHnGFo0ko1eaVfakeUKqQliIoetDZ8YRE=;
 b=SLWzG3BJMSp9/XiVpwuHmxhw7NFvUx/qw+zoPbPQJyT9RW/4nVOJgaw//hrvjFFZ22
 MIjtLjLGMv47o6clizOw0TRefRR/kYqSGrevU889qVCHGW9fnLZlmX4I3hOCDvKYencJ
 yCZipT1Qlx9l/hqCgWFJtFQMGv2QCN7b4gKF2Z7jKOT4rI21/vnJ+ib944yEz8uRUWeI
 hdfIPvUmrlT0aj8KQaF4FYyBeoCCyqqQlZAu4+J3+NODRNeoovNtmN8gqx5/fYj51x68
 xzFwK5f9uOIuStkoOpjnyDZri8W26nNeOSiwA8YSZ9G3dmoQpdMf/GkgKu50Zdnb3UEZ
 LK9w==
X-Gm-Message-State: AAQBX9e2ETViZxHpOSXfkRrJ5dFkckAUUSPTSx3nQoagSiBSkn68vE5h
 6Oo0fnpyoZ6tPfrnhtbhtyf0ewY=
X-Google-Smtp-Source: AKy350YQ6/8gUx3E8iyg+pu8q3ARXIx8GYJQPh6U8FgTFFppyvYT8YPMwoiIG8aW+ins6SCLDnqLojs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:1c3:0:b0:513:5162:a692 with SMTP id
 186-20020a6301c3000000b005135162a692mr2124246pgb.5.1680201340149; Thu, 30 Mar
 2023 11:35:40 -0700 (PDT)
Date: Thu, 30 Mar 2023 11:35:38 -0700
In-Reply-To: <168019606574.3557870.15629824904085210321.stgit@firesoul>
Mime-Version: 1.0
References: <168019602958.3557870.9960387532660882277.stgit@firesoul>
 <168019606574.3557870.15629824904085210321.stgit@firesoul>
Message-ID: <ZCXWerysZL1XwVfX@google.com>
From: Stanislav Fomichev <sdf@google.com>
To: Jesper Dangaard Brouer <brouer@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1680201340;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=tJ8KMmzZMobHnGFo0ko1eaVfakeUKqQliIoetDZ8YRE=;
 b=WgMZHweAIlvltzKw/+MMymuPl6RB4LL5CZYBxU4/ZD0skm5UDSzptayGoOpbfYINCi
 F4omkDCzLPbqgAxfokotNM3r7etG66+xL/trzKuF6wsdjRVxXvTOuCuM6HhhGSsnOX6G
 5ho/ZaMQNij5T/GjQVITrS6W+5MrPFgc5nEF4CILv5rSuqDvL/mEXWQ8D34L2uM3pXd/
 61qag+QhuH6AGSM11jyqfbr3pBmzCG80rt7SezTrXXpK5aPMpBSJ53baGNSu/GZME5QO
 sXSvq/ZUXH/umvLjnwiaghxQyglWLWHB4dvypDqXOseKdcjIAfmHat3cckTmOmQg9aPy
 MK/w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=WgMZHweA
Subject: Re: [Intel-wired-lan] [PATCH bpf RFC-V3 1/5] xdp: rss hash types
 representation
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
Cc: xdp-hints@xdp-project.net, martin.lau@kernel.org, daniel@iogearbox.net,
 larysa.zaremba@intel.com, netdev@vger.kernel.org, john.fastabend@gmail.com,
 ast@kernel.org, linux-kernel@vger.kernel.org, jesse.brandeburg@intel.com,
 edumazet@google.com, pabeni@redhat.com, yoong.siang.song@intel.com,
 kuba@kernel.org, boon.leong.ong@intel.com, anthony.l.nguyen@intel.com,
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, davem@davemloft.net,
 hawk@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 03/30, Jesper Dangaard Brouer wrote:
> The RSS hash type specifies what portion of packet data NIC hardware used
> when calculating RSS hash value. The RSS types are focused on Internet
> traffic protocols at OSI layers L3 and L4. L2 (e.g. ARP) often get hash
> value zero and no RSS type. For L3 focused on IPv4 vs. IPv6, and L4
> primarily TCP vs UDP, but some hardware supports SCTP.

> Hardware RSS types are differently encoded for each hardware NIC. Most
> hardware represent RSS hash type as a number. Determining L3 vs L4 often
> requires a mapping table as there often isn't a pattern or sorting
> according to ISO layer.

> The patch introduce a XDP RSS hash type (enum xdp_rss_hash_type) that
> contain combinations to be used by drivers, which gets build up with bits
> from enum xdp_rss_type_bits. Both enum xdp_rss_type_bits and
> xdp_rss_hash_type get exposed to BPF via BTF, and it is up to the
> BPF-programmer to match using these defines.

> This proposal change the kfunc API bpf_xdp_metadata_rx_hash() adding
> a pointer value argument for provide the RSS hash type.

> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>   include/linux/netdevice.h |    3 ++-
>   include/net/xdp.h         |   46  
> +++++++++++++++++++++++++++++++++++++++++++++
>   net/core/xdp.c            |   10 +++++++++-
>   3 files changed, 57 insertions(+), 2 deletions(-)

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 470085b121d3..c35f04f636f1 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1624,7 +1624,8 @@ struct net_device_ops {

>   struct xdp_metadata_ops {
>   	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
> -	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash);
> +	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
> +			       enum xdp_rss_hash_type *rss_type);
>   };

>   /**
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 41c57b8b1671..130091a55a6f 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -8,6 +8,7 @@

>   #include <linux/skbuff.h> /* skb_shared_info */
>   #include <uapi/linux/netdev.h>
> +#include <linux/bitfield.h>

>   /**
>    * DOC: XDP RX-queue information
> @@ -425,6 +426,51 @@ XDP_METADATA_KFUNC_xxx
>   MAX_XDP_METADATA_KFUNC,
>   };

> +enum xdp_rss_type_bits {
> +	XDP_RSS_L3_IPV4		= BIT(0),
> +	XDP_RSS_L3_IPV6		= BIT(1),
> +
> +	/* The fixed (L3) IPv4 and IPv6 headers can both be followed by
> +	 * variable/dynamic headers, IPv4 called Options and IPv6 called
> +	 * Extension Headers. HW RSS type can contain this info.
> +	 */
> +	XDP_RSS_L3_DYNHDR	= BIT(2),
> +
> +	/* When RSS hash covers L4 then drivers MUST set XDP_RSS_L4 bit in
> +	 * addition to the protocol specific bit.  This ease interaction with
> +	 * SKBs and avoids reserving a fixed mask for future L4 protocol bits.
> +	 */
> +	XDP_RSS_L4		= BIT(3), /* L4 based hash, proto can be unknown */
> +	XDP_RSS_L4_TCP		= BIT(4),
> +	XDP_RSS_L4_UDP		= BIT(5),
> +	XDP_RSS_L4_SCTP		= BIT(6),
> +	XDP_RSS_L4_IPSEC	= BIT(7), /* L4 based hash include IPSEC SPI */
> +};
> +
> +/* RSS hash type combinations used for driver HW mapping */
> +enum xdp_rss_hash_type {
> +	XDP_RSS_TYPE_NONE            = 0,
> +	XDP_RSS_TYPE_L2              = XDP_RSS_TYPE_NONE,
> +
> +	XDP_RSS_TYPE_L3_IPV4         = XDP_RSS_L3_IPV4,
> +	XDP_RSS_TYPE_L3_IPV6         = XDP_RSS_L3_IPV6,
> +	XDP_RSS_TYPE_L3_IPV4_OPT     = XDP_RSS_L3_IPV4 | XDP_RSS_L3_DYNHDR,
> +	XDP_RSS_TYPE_L3_IPV6_EX      = XDP_RSS_L3_IPV6 | XDP_RSS_L3_DYNHDR,
> +
> +	XDP_RSS_TYPE_L4_ANY          = XDP_RSS_L4,
> +	XDP_RSS_TYPE_L4_IPV4_TCP     = XDP_RSS_L3_IPV4 | XDP_RSS_L4 |  
> XDP_RSS_L4_TCP,
> +	XDP_RSS_TYPE_L4_IPV4_UDP     = XDP_RSS_L3_IPV4 | XDP_RSS_L4 |  
> XDP_RSS_L4_UDP,
> +	XDP_RSS_TYPE_L4_IPV4_SCTP    = XDP_RSS_L3_IPV4 | XDP_RSS_L4 |  
> XDP_RSS_L4_SCTP,
> +
> +	XDP_RSS_TYPE_L4_IPV6_TCP     = XDP_RSS_L3_IPV6 | XDP_RSS_L4 |  
> XDP_RSS_L4_TCP,
> +	XDP_RSS_TYPE_L4_IPV6_UDP     = XDP_RSS_L3_IPV6 | XDP_RSS_L4 |  
> XDP_RSS_L4_UDP,
> +	XDP_RSS_TYPE_L4_IPV6_SCTP    = XDP_RSS_L3_IPV6 | XDP_RSS_L4 |  
> XDP_RSS_L4_SCTP,
> +
> +	XDP_RSS_TYPE_L4_IPV6_TCP_EX  = XDP_RSS_TYPE_L4_IPV6_TCP | 
> XDP_RSS_L3_DYNHDR,
> +	XDP_RSS_TYPE_L4_IPV6_UDP_EX  = XDP_RSS_TYPE_L4_IPV6_UDP | 
> XDP_RSS_L3_DYNHDR,
> +	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP| 
> XDP_RSS_L3_DYNHDR,
> +};
> +
>   #ifdef CONFIG_NET
>   u32 bpf_xdp_metadata_kfunc_id(int id);
>   bool bpf_dev_bound_kfunc_id(u32 btf_id);
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 528d4b37983d..38d2dee16b47 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -734,14 +734,22 @@ __bpf_kfunc int bpf_xdp_metadata_rx_timestamp(const  
> struct xdp_md *ctx, u64 *tim
>    * bpf_xdp_metadata_rx_hash - Read XDP frame RX hash.
>    * @ctx: XDP context pointer.
>    * @hash: Return value pointer.
> + * @rss_type: Return value pointer for RSS type.
> + *
> + * The RSS hash type (@rss_type) specifies what portion of packet  
> headers NIC
> + * hardware were used when calculating RSS hash value.  The type  
> combinations
> + * are defined via &enum xdp_rss_hash_type and individual bits can be  
> decoded
> + * via &enum xdp_rss_type_bits.
>    *
>    * Return:
>    * * Returns 0 on success or ``-errno`` on error.
>    * * ``-EOPNOTSUPP`` : means device driver doesn't implement kfunc
>    * * ``-ENODATA``    : means no RX-hash available for this frame
>    */
> -__bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32  
> *hash)
> +__bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32  
> *hash,
> +					 enum xdp_rss_hash_type *rss_type)
>   {

[..]

> +	BTF_TYPE_EMIT(enum xdp_rss_type_bits);

nit: Do we still need this with an extra argument?

>   	return -EOPNOTSUPP;
>   }



_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
