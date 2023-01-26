Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0286BC61DA3
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Jan 2023 18:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8076881DE2;
	Thu, 26 Jan 2023 18:28:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8076881DE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674757688;
	bh=4pyhyHuVNQi4z53PTAx6VcPlqWbukgsuhnF43kNDHZ4=;
	h=Date:In-Reply-To:References:From:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=B/H9oWMqykiPdeLxFW5YeS4gkRSQxU5N0x0nbiyz7FckNh0PMPKcf4csGVrAwYxBZ
	 XORjAg67/AcoE3BDuO5RT11oySvM90B8pF6RVeFgan/VliAY3RB9sEu+yE4eQoSeMN
	 WfoEiX6InsSpGWu78PDBkiLZc/C2s3dFKJ5+kXt/xKC3hrcaw+havF199CZkwy8fvR
	 eVNickn24o9Yb98Ufjx1E4Xa4VkrfP83eMdnLDqqyoXONgG4+1op3yzZfipmKIZNWu
	 7n/Qx9+Q5FPN5kF+vIuApYQq85pozPwdBBPgw8UxCdoLsR1Bdlk5TlO+HzUMX3P1lt
	 SwtOxHz/qx4bw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ws7FdwMqHW1V; Thu, 26 Jan 2023 18:28:07 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72D1C82348;
	Thu, 26 Jan 2023 18:28:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72D1C82348
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 427281BF487
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Jan 2023 18:28:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C11241690
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Jan 2023 18:28:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C11241690
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IQIbEoonDChi for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Jan 2023 18:28:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6280240A81
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6280240A81
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Jan 2023 18:28:04 +0000 (UTC)
Received: by mail-pl1-x64a.google.com with SMTP id
 t12-20020a170902b20c00b00192e3d10c5bso1491529plr.4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Jan 2023 10:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ld20xsyiZsj/yGK6ZQBfBsop69pskhzagkZqynpGOQA=;
 b=gZb0/0fJytJ7vQwYu3DFtBzOGypsrELh2HvcYUBH2LEHn0/KqJydnOPdAxHVZFWjS2
 gR8I0dXouILwGlABbQ4CkRfSg8YFhihgQ6Rby1gKl6FPiQ5coFRl9y3btiSwZDk2W3Yc
 P3RFP4cKRFWiigaDz/s2lt7PrM+mA1dqqF0Bg5JwemJWzCfkYAXKc2BgHLsSSjxJ64nb
 hvzfvxwyck4kQRgAlpvFtmKV0CM/3uJqzUkZZt4lvY+df6nOcKhBRjbFqOvYLGx0roiF
 yMoBhJN0XnAcb3jHYPszFTLze7gmjkK8RP3CE11PqMPbbofLltpuzRFGvTacRhe0wZ1J
 aQvA==
X-Gm-Message-State: AFqh2kpziEsdqiNM1oYJ382DnbxFV0ld24XtrI5FW6/CG/wIqapkixPO
 96cKfpurab7oM+iB4ISbiq4AZ8A=
X-Google-Smtp-Source: AMrXdXunEGBjDJiFy8IxYeVUll+D1mOg1FfSCwgIObDvYJ4+F7/NWy7UM9q0o00RTcibjLte1wl9kn0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:e8d1:b0:195:8b77:6643 with SMTP id
 v17-20020a170902e8d100b001958b776643mr2724060plg.21.1674757683690; Thu, 26
 Jan 2023 10:28:03 -0800 (PST)
Date: Thu, 26 Jan 2023 10:28:02 -0800
In-Reply-To: <7c403a3a043554df3ebe4b4a94b8e0d97414cb7e.1674737592.git.lorenzo@kernel.org>
Mime-Version: 1.0
References: <cover.1674737592.git.lorenzo@kernel.org>
 <7c403a3a043554df3ebe4b4a94b8e0d97414cb7e.1674737592.git.lorenzo@kernel.org>
Message-ID: <Y9LGMha3+jPLBXsb@google.com>
From: sdf@google.com
To: Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ld20xsyiZsj/yGK6ZQBfBsop69pskhzagkZqynpGOQA=;
 b=GtQlPly1uVqV0wcw/g6KN62470vt5yZirA4UyYqnFORo4FwcD6ZPOLYNaI26yMilnf
 bEpTSPcloCvGLbhO/lmxCJMImyzManV6aTG9gNsk7xZnWEioE3td7qFW0iOoMY1GZrBo
 8MQjLQak0JdvkyVTXdYzOnD6gHJbk98/3p/RLCURVpI2Q3g0seVoaTxOxZg+GHTGsfrD
 d1/sSbBe3wq1D/uqE/0SufWxcvcNNPTRvxr1U2VUVJCEWgKGtgA7th6tCz4Us6LOgBVE
 L8wEIZBVW0wb86Owr66E9/gkaZifAvM3s6E8JSaYotDkJzkD/tnGDyqGMbRF3H5cEyjO
 1Oaw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=GtQlPly1
Subject: Re: [Intel-wired-lan] [PATCH v3 bpf-next 7/8] selftests/bpf: add
 test for bpf_xdp_query xdp-features support
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
Cc: mst@redhat.com, vladimir.oltean@nxp.com, ast@kernel.org,
 edumazet@google.com, anthony.l.nguyen@intel.com, daniel@iogearbox.net,
 andrii@kernel.org, intel-wired-lan@lists.osuosl.org, simon.horman@corigine.com,
 kuba@kernel.org, pabeni@redhat.com, aelior@marvell.com, hawk@kernel.org,
 christophe.jaillet@wanadoo.fr, memxor@gmail.com, john@phrozen.org,
 bjorn@kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 leon@kernel.org, netdev@vger.kernel.org, toke@redhat.com, martin.lau@linux.dev,
 ecree.xilinx@gmail.com, alardam@gmail.com, gospo@broadcom.com,
 saeedm@nvidia.com, davem@davemloft.net, nbd@nbd.name
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 01/26, Lorenzo Bianconi wrote:
> Introduce a self-test to verify libbpf bpf_xdp_query capability to dump
> the xdp-features supported by the device (lo and veth in this case).

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>   .../bpf/prog_tests/xdp_do_redirect.c          | 27 ++++++++++++++++++-
>   .../selftests/bpf/prog_tests/xdp_info.c       |  8 ++++++
>   2 files changed, 34 insertions(+), 1 deletion(-)

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c  
> b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
> index a50971c6cf4a..e15fb3f0306c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
> @@ -4,10 +4,12 @@
>   #include <net/if.h>
>   #include <linux/if_ether.h>
>   #include <linux/if_packet.h>
> +#include <linux/if_link.h>
>   #include <linux/ipv6.h>
>   #include <linux/in6.h>
>   #include <linux/udp.h>
>   #include <bpf/bpf_endian.h>
> +#include <uapi/linux/netdev.h>
>   #include "test_xdp_do_redirect.skel.h"

>   #define SYS(fmt, ...)						\
> @@ -92,7 +94,7 @@ void test_xdp_do_redirect(void)
>   	struct test_xdp_do_redirect *skel = NULL;
>   	struct nstoken *nstoken = NULL;
>   	struct bpf_link *link;
> -
> +	LIBBPF_OPTS(bpf_xdp_query_opts, query_opts);
>   	struct xdp_md ctx_in = { .data = sizeof(__u32),
>   				 .data_end = sizeof(data) };
>   	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> @@ -153,6 +155,29 @@ void test_xdp_do_redirect(void)
>   	    !ASSERT_NEQ(ifindex_dst, 0, "ifindex_dst"))
>   		goto out;

> +	/* Check xdp features supported by veth driver */
> +	err = bpf_xdp_query(ifindex_src, XDP_FLAGS_DRV_MODE, &query_opts);
> +	if (!ASSERT_OK(err, "veth_src bpf_xdp_query"))
> +		goto out;
> +
> +	if (!ASSERT_EQ(query_opts.fflags,
> +		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> +		       NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
> +		       NETDEV_XDP_ACT_NDO_XMIT_SG,
> +		       "veth_src query_opts.fflags"))
> +		goto out;
> +
> +	err = bpf_xdp_query(ifindex_dst, XDP_FLAGS_DRV_MODE, &query_opts);
> +	if (!ASSERT_OK(err, "veth_dst bpf_xdp_query"))
> +		goto out;
> +
> +	if (!ASSERT_EQ(query_opts.fflags,
> +		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> +		       NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
> +		       NETDEV_XDP_ACT_NDO_XMIT_SG,
> +		       "veth_dst query_opts.fflags"))
> +		goto out;
> +
>   	memcpy(skel->rodata->expect_dst, &pkt_udp.eth.h_dest, ETH_ALEN);
>   	skel->rodata->ifindex_out = ifindex_src; /* redirect back to the same  
> iface */
>   	skel->rodata->ifindex_in = ifindex_src;
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_info.c  
> b/tools/testing/selftests/bpf/prog_tests/xdp_info.c
> index cd3aa340e65e..8397468a9e74 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_info.c
> @@ -8,6 +8,7 @@ void serial_test_xdp_info(void)
>   {
>   	__u32 len = sizeof(struct bpf_prog_info), duration = 0, prog_id;
>   	const char *file = "./xdp_dummy.bpf.o";
> +	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
>   	struct bpf_prog_info info = {};
>   	struct bpf_object *obj;
>   	int err, prog_fd;
> @@ -61,6 +62,13 @@ void serial_test_xdp_info(void)
>   	if (CHECK(prog_id, "prog_id_drv", "unexpected prog_id=%u\n", prog_id))
>   		goto out;

> +	/* Check xdp features supported by lo device */
> +	opts.fflags = ~0;
> +	err = bpf_xdp_query(IFINDEX_LO, XDP_FLAGS_DRV_MODE, &opts);
> +	if (!ASSERT_OK(err, "bpf_xdp_query"))
> +		goto out;
> +
> +	ASSERT_EQ(opts.fflags, 0, "opts.fflags");
>   out:
>   	bpf_xdp_detach(IFINDEX_LO, 0, NULL);
>   out_close:
> --
> 2.39.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
