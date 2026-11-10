Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E060A382B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=5ULTH0CM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.a=rsa-sha256 header.s=dkim11 header.b=d1g97xJ3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 331CC8132D;
	Tue, 10 Nov 2026 20:25:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Au24UKjlSCVp; Tue, 10 Nov 2026 20:24:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 119538128A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794342298;
	b=B2RNIpu4NB4lDGMdbD5iRwBPEs1VYw736CiXdfHDoma80LRVlfbOemm/bEXlTDkSg0BO
	 XGUBklW/JNjuEgo6YIf4Vx5d/bEDer/Zc40kBD4xkQga+wcbaihGd8WlqerIwikw2Fl0D
	 bl9rmjNxwFn30j/RaJPGt6pArcYF19IeL2LBBHmy8OvvaUzOjeYUON3PmSADjQFaz9e0S
	 fpjY7cQy5+5+8SzBcvaVDY+F+DX+sFjNRffySspj4He2PDpQ7yhkdcnYFM4zi6JMqkRQo
	 boxrRPkAn9r6JwIXqy0w//11xKYVS3HqSkmlitx3v07oLj2YJjb4iKnka4giPVUjmrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794342298;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-AV-Do-Run:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Kb6tsHIuCpbK8Ynd/HxIwOkPQSLfGDHhz1xSOv1kM98=;
	b=kESbyG0v0wQnXWalHSchg7l/InBQW66w7dOAbhxrbKIPnHRGCAgKz0JiSxNjFDwf5JKe
	 +EasdxhMbGVVPZKWVYaHecNUDi7BBjXmg9SNITDSSxcGUc+VjzQNqnv3O5sTKm6ryOgeG
	 Hl+cbi2C3KZERs5ywwSrn9867eofh7QWPMsIRPDnEpUgTK5xDrZ2ClGlVsmahYxaXKeN6
	 YW8vxGSSvvbngm4ixmv6d8LsRWH4Xn7oLZc9uiCJtU5Zw5UAYo+8dgkK2wiIzY4kW0rv7
	 HEoNL8rJTiLsrM9oTBCcH7s0IFg9+aeDRbtgnS/vXFfH3bGuTfTTIGuvJwVyRsGefcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794342298;
	bh=Kb6tsHIuCpbK8Ynd/HxIwOkPQSLfGDHhz1xSOv1kM98=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5ULTH0CM+PUxzs2PmdNCYo6SqLZjsW0kj/avcN3MSyM71Zdt1xutR51B4mCctjs7k
	 LNAfUA2bk3eUBe1ySIO2VqmF/z0ONEjzgJY3vF903orvXlS3h7cBP/S/eA3y/e7Hpt
	 zI6kSefFUi75G7Qss0oC4NzPKtg4AmNcimmxBS5JeQ7YcWjy+TpG2W9jvkzNwTrJm4
	 OvTPrqZBCiA/90lWvOPqHapI9Wy4262pigaDWZufszMvj3quxCQe4ScIw+e+/ruS/A
	 rHaBABncCNTemmY9ideRDV+/JIUTLPHrAq2ZtAh8NjEgtqDr//tN+lH+jPIY3Tzt8+
	 EWFP7Qe6wBCAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 119538128A;
	Tue, 10 Nov 2026 20:24:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EDCFB9D1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 20:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DFE7F4032F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 20:24:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jWCKkbPhQ74J for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 20:24:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3FA3F402B0
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=81.19.149.116
X-Greylist: delayed 3098 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 10 Nov 2026 20:24:54 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=engleder-embedded.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=engleder-embedded.com header.i=@engleder-embedded.com
 header.a=rsa-sha256 header.s=dkim11 header.b=d1g97xJ3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=81.19.149.116;
 helo=mx06lb.world4you.com; envelope-from=gerhard@engleder-embedded.com;
 receiver=<UNKNOWN> 
Received: from mx06lb.world4you.com (mx06lb.world4you.com [81.19.149.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FA3F402B0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 20:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kb6tsHIuCpbK8Ynd/HxIwOkPQSLfGDHhz1xSOv1kM98=; b=d1g97xJ3xONMX6Y0uhEkV2nclq
 p94D0CK0/HqOVSFQN/q93V4n+JQcgogScPzbbhsf2EK7esCKzDxZEgkMgUB6sIh+omV2rTIjst7Z0
 1AaIrfpKHAAZNHW79ihGxgwuRF6OiZ6PY4zaH6ySBztj3AOjznbKEkNkN3gkr2+8BAaE=;
Received: from [80.121.72.134] (helo=[10.0.0.160])
 by mx06lb.world4you.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.97.1)
 (envelope-from <gerhard@engleder-embedded.com>)
 id 1xQraO-000000000Ux-3taX; Tue, 10 Nov 2026 20:32:53 +0100
Message-ID: <cb785718-02cd-442b-a236-c1bce6971d60@engleder-embedded.com>
Date: Tue, 10 Nov 2026 20:32:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
To: Ding Meng <meng.ding@siemens.com>, netdev@vger.kernel.org
Cc: florian.bezdeka@siemens.com, jan.kiszka@siemens.com, wq.wang@siemens.com, 
 p@1g4.org, Jason Xing <kerneljasonxing@gmail.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>
References: <20261105071706.7043-1-meng.ding@siemens.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20261105071706.7043-1-meng.ding@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
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
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 05.11.26 08:16, Ding Meng wrote:
> Commit 97dc7cd92ac6 ("ptp: Support late timestamp determination")
> added support for deferring RX timestamp conversion to
> ndo_get_tstamp(). When the timestamp is consumed, get_timestamp()
> uses the skb's NAPI ID to find the device that owns the timestamp
> cookie and invoke its callback.
> 
> Commit e68b6e50fa35 ("udp: enable busy polling for all sockets")
> gated NAPI ID bookkeeping with CONFIG_NET_RX_BUSY_POLL. As a result,
> when busy polling is disabled, the skb may not carry a usable NAPI ID.
> The device lookup then fails, so the driver callback is not invoked.
> get_timestamp() falls back to hwtstamp, which does not contain the
> converted timestamp, resulting in an incorrect RX hardware timestamp.
> 
> Record skb NAPI IDs independently of busy-poll support to support
> drivers that use deferred timestamp conversion and future driver
> features that need to look up a device by its NAPI ID.
> 
> Signed-off-by: Ding Meng <meng.ding@siemens.com>
> Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> In the discussion of the issue reported at
> https://lore.kernel.org/netdev/20260630112056.885071-1-meng.ding@siemens.com/
> this previous patch added an igc-specific fallback for configurations
> with CONFIG_NET_RX_BUSY_POLL disabled. It populated skb's hwtstamp
> field with a timestamp converted using the default hardware timer,
> allowing get_timestamp() to return it without invoking ndo_get_tstamp().
> But Jakub Kicinski noted that the proposed fix appeared to be a
> driver-specific workaround for a generic problem. The engleder driver
> would also be affected by the same issue.
> 
> This patch introduces a new configuration option to enable NAPI ID
> bookkeeping independently of busy polling. The option is enabled
> whenever busy polling is enabled, preserving the existing behavior.
> It is also selected by the igc and engleder drivers, ensuring that
> skbs carry a NAPI ID even when busy polling is disabled.
> 
> Another approach considered was to require drivers using deferred
> timestamp conversion, such as igc and engleder, to enable busy polling.
> However, this would introduce an unnecessary dependency between two
> independent features: hardware timestamp reporting should not require
> busy polling to be enabled.
> 
> Timestamping has been tested only with igc; it has not been tested
> with engleder.
> 
>   Documentation/networking/timestamping.rst | 11 ++++++++---
>   drivers/net/ethernet/engleder/Kconfig     |  1 +
>   drivers/net/ethernet/intel/Kconfig        |  1 +
>   include/linux/skbuff.h                    |  4 ++--
>   include/net/busy_poll.h                   |  2 +-
>   include/trace/events/net.h                |  2 +-
>   net/Kconfig                               |  4 ++++
>   net/core/filter.c                         |  2 +-
>   net/core/skbuff.c                         |  2 +-
>   9 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> index 2162c4f2b28a6..dbe40a1972639 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -278,9 +278,14 @@ SOF_TIMESTAMPING_OPT_PKTINFO:
>     packets with hardware timestamps. The message contains struct
>     scm_ts_pktinfo, which supplies the index of the real interface which
>     received the packet and its length at layer 2. A valid (non-zero)
> -  interface index will be returned only if CONFIG_NET_RX_BUSY_POLL is
> -  enabled and the driver is using NAPI. The struct contains also two
> -  other fields, but they are reserved and undefined.
> +  interface index will be returned only if CONFIG_SKB_MARK_NAPI_ID is
> +  enabled and the driver is using NAPI. This hidden configuration is
> +  selected automatically by busy-poll support and by drivers that need
> +  skb NAPI IDs to resolve deferred hardware timestamps. Drivers that
> +  use deferred timestamp conversion must select it so the networking
> +  stack can find the device and call its timestamp callback even when
> +  busy polling is disabled. The struct contains also two other fields,
> +  but they are reserved and undefined.
>   
>   SOF_TIMESTAMPING_OPT_TX_SWHW:
>     Request both hardware and software timestamps for outgoing packets
> diff --git a/drivers/net/ethernet/engleder/Kconfig b/drivers/net/ethernet/engleder/Kconfig
> index 3df6bf476ae7e..9700a243bea11 100644
> --- a/drivers/net/ethernet/engleder/Kconfig
> +++ b/drivers/net/ethernet/engleder/Kconfig
> @@ -22,6 +22,7 @@ config TSNEP
>   	depends on PTP_1588_CLOCK_OPTIONAL
>   	select PHYLIB
>   	select PAGE_POOL
> +	select SKB_MARK_NAPI_ID
>   	help
>   	  Support for the Engleder TSN endpoint Ethernet MAC IP Core.
>   
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index 780f113986ea8..7fb63f351fc20 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -376,6 +376,7 @@ config IGC
>   	depends on PCI
>   	depends on PTP_1588_CLOCK_OPTIONAL
>   	depends on ETHTOOL_NETLINK
> +	select SKB_MARK_NAPI_ID
>   	help
>   	  This driver supports Intel(R) Ethernet Controller I225-LM/I225-V
>   	  family of adapters.
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 6787fcf6ac3e4..164c862f7a403 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1059,7 +1059,7 @@ struct sk_buff {
>   			__u16	vlan_tci;
>   		};
>   	};
> -#if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
> +#if defined(CONFIG_SKB_MARK_NAPI_ID) || defined(CONFIG_XPS)
>   	union {
>   		unsigned int	napi_id;
>   		unsigned int	sender_cpu;
> @@ -1267,7 +1267,7 @@ static inline bool skb_pkt_type_ok(u32 ptype)
>    */
>   static inline unsigned int skb_napi_id(const struct sk_buff *skb)
>   {
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> +#ifdef CONFIG_SKB_MARK_NAPI_ID
>   	return skb->napi_id;
>   #else
>   	return 0;
> diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
> index 6e172d0f6ef5f..f7c0e62c6a7d7 100644
> --- a/include/net/busy_poll.h
> +++ b/include/net/busy_poll.h
> @@ -130,7 +130,7 @@ static inline void sk_busy_loop(struct sock *sk, int nonblock)
>   static inline void __skb_mark_napi_id(struct sk_buff *skb,
>   				      const struct gro_node *gro)
>   {
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> +#ifdef CONFIG_SKB_MARK_NAPI_ID
>   	/* If the skb was already marked with a valid NAPI ID, avoid overwriting
>   	 * it.
>   	 */
> diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> index dbc2c5598e35a..99ed7645242eb 100644
> --- a/include/trace/events/net.h
> +++ b/include/trace/events/net.h
> @@ -208,7 +208,7 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
>   
>   	TP_fast_assign(
>   		__assign_str(name);
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> +#ifdef CONFIG_SKB_MARK_NAPI_ID
>   		__entry->napi_id = napi_id_valid(skb->napi_id) ?
>   				   skb->napi_id : 0;
>   #else
> diff --git a/net/Kconfig b/net/Kconfig
> index 76ab44aa439a6..8fa7586dc08ca 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -346,9 +346,13 @@ config CGROUP_NET_CLASSID
>   	  Cgroup subsystem for use as general purpose socket classid marker that is
>   	  being used in cls_cgroup and for netfilter matching.
>   
> +config SKB_MARK_NAPI_ID
> +	bool
> +
>   config NET_RX_BUSY_POLL
>   	bool
>   	default y if !PREEMPT_RT || (PREEMPT_RT && !NETCONSOLE)
> +	select SKB_MARK_NAPI_ID
>   
>   config BQL
>   	bool
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b7ac145b68b1f..e2218c18622b8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10274,7 +10274,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
>   		break;
>   
>   	case offsetof(struct __sk_buff, napi_id):
> -#if defined(CONFIG_NET_RX_BUSY_POLL)
> +#if defined(CONFIG_SKB_MARK_NAPI_ID)
>   		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
>   				      bpf_target_off(struct sk_buff, napi_id, 4,
>   						     target_size));
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index eb9fcc4b1fd1a..386a32cdc0cc8 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1581,7 +1581,7 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
>   #ifdef CONFIG_NETWORK_SECMARK
>   	CHECK_SKB_FIELD(secmark);
>   #endif
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> +#ifdef CONFIG_SKB_MARK_NAPI_ID
>   	CHECK_SKB_FIELD(napi_id);
>   #endif
>   #ifdef CONFIG_XPS
> 
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
