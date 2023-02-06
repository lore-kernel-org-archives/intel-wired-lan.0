Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84ABC636D3
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Feb 2023 22:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FF6A408B4;
	Mon,  6 Feb 2023 22:42:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FF6A408B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675723367;
	bh=GYOVaA20OjFLqH767nzsFR5VYrGq+1z633JXHgyTVDw=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=awxZdMQm3/gN0TC89JHfDoH5MKmrdfvCSH1LprgdXg3F1UNOObhwiEREwTbSlbNsV
	 Rgdx9+lacVGkMVmU7DvrKHskc+nqwf8lgKB+zOCBgnN+nmvq4nDJIC/M9gghEzSSWJ
	 5dbWfbcT4xEMXI9De2CEc8MN5AVEhIFuO0FQ/MMozg1HhX63SR0ej+VK1uxS4jG2Ih
	 KK+x7bSKKqRC6et0sHVflR5CX5f83Z5qMOf5+KQpvDCocSGkJffrwvsLjgxZDBnwpu
	 DRt3uC24zb0zRD0Ap6naLx9J+M9pOt0vy+W3/oqOYMWYeXm+9AxdDTFjAa7Rqmuwb5
	 LQCmAPwbhIjVQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dTJwWBQzEfxg; Mon,  6 Feb 2023 22:42:46 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1CD0408BC;
	Mon,  6 Feb 2023 22:42:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1CD0408BC
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id BD4651BF422
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 22:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 925A840577
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 22:42:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 925A840577
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4-t98pNpU1t5 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Feb 2023 22:42:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C863A4016B
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C863A4016B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 22:42:43 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id q19so13234152edd.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 06 Feb 2023 14:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t644cczRQka2x/b5p0VZXCNIcITcyshiEjBHQAnHClY=;
 b=wwDGdyMgEGt0SD4trU+vk3gVwTTLw/EP2PXLyxO7+8fHqON/c6bPRRlzqA24we+uD2
 xlXidgR3P1oDxbunIWXY80SUWODCM1/K1BzEiwdG7FSJnRYERuPM7frCpt5G/niw78gE
 QwXEpOBncmy4X/oKOXIZANL/DmyjKGrLpPtm37hORYEUegnk53zsnWCsz5rLd0Fbv/9Q
 yJvaSV+/ccVDe+mvucf8Sa/I2cUVXlpJNI1XqmPEcA0Qk4mIsJLKLXFHwXe0nE3o0/2C
 q1qRM7USE9HVIEnbzyKD2oN692L41iZGGdN1MdN42XbK3IDNhjnYxYEK8Q/uLpWvmKwi
 8Qjg==
X-Gm-Message-State: AO0yUKXlTnvujYJEZRJsUTKgPRxX6ITbNJNTuiIP9l6Ee45j5lvdXC6U
 uKI0CgkcxYNJv/+iuR7tNFyQ6SeSS6Z2PUX5HOI=
X-Google-Smtp-Source: AK7set+Gk56V+eCjod1Ppqj4lbfZwfjYStQkNcusNNltlahiBgLVkLq2nOS35EReRjYadjf1zLOptLf353isaD3TtEQ=
X-Received: by 2002:a50:9fa8:0:b0:49d:ec5d:28af with SMTP id
 c37-20020a509fa8000000b0049dec5d28afmr33353edf.5.1675723361863; Mon, 06 Feb
 2023 14:42:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675245257.git.lorenzo@kernel.org>
 <a72609ef4f0de7fee5376c40dbf54ad7f13bfb8d.1675245258.git.lorenzo@kernel.org>
In-Reply-To: <a72609ef4f0de7fee5376c40dbf54ad7f13bfb8d.1675245258.git.lorenzo@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Feb 2023 14:42:29 -0800
Message-ID: <CAEf4BzZS-MSen_1q4eotMe3hdkXUXxpwnfbLqEENzU1ogejxUQ@mail.gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t644cczRQka2x/b5p0VZXCNIcITcyshiEjBHQAnHClY=;
 b=WKv7BijNQKh+zOOhJoiue4NWX7PXRW8jExmIM0aach4T8ONArc8iaqLMVGBECmhiDi
 Jcp8Tyt9jfet3vq3lDnEQwjADVhqXrxOYhcc7CI+TUIpq/hkJSdf/DBrY+aOZbP5FWnF
 0n5IqUDO/6AaoJ5w9tsItrgZmMSkJY1tTt5auZDPzc6NPYqQzOiRG8Rncjbem1OzMSKI
 HU0a2PyHQpp6khPO/CcTP1qEe5u+1NQ2qC3JDFo6qnOJj7lzrRLTpjAgOt3Ip4Co/wpF
 CqG3sY76kjOp8bX70HEbXSH2cU8ofh06afmkQXjCnRBG4MXBpSmPtzF1nkf9aOd8vtK/
 rO/A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=WKv7BijN
Subject: Re: [Intel-wired-lan] [PATCH v5 bpf-next 5/8] libbpf: add API to
 get XDP/XSK supported features
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
 edumazet@google.com, anthony.l.nguyen@intel.com, sdf@google.com,
 gerhard@engleder-embedded.com, daniel@iogearbox.net, andrii@kernel.org,
 intel-wired-lan@lists.osuosl.org, simon.horman@corigine.com, kuba@kernel.org,
 pabeni@redhat.com, aelior@marvell.com, hawk@kernel.org,
 christophe.jaillet@wanadoo.fr, memxor@gmail.com, john@phrozen.org,
 bjorn@kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 leon@kernel.org, netdev@vger.kernel.org, toke@redhat.com, martin.lau@linux.dev,
 ecree.xilinx@gmail.com, alardam@gmail.com, gospo@broadcom.com,
 saeedm@nvidia.com, davem@davemloft.net, nbd@nbd.name
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Feb 1, 2023 at 2:25 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Extend bpf_xdp_query routine in order to get XDP/XSK supported features
> of netdev over route netlink interface.
> Extend libbpf netlink implementation in order to support netlink_generic
> protocol.
>
> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Co-developed-by: Marek Majtyka <alardam@gmail.com>
> Signed-off-by: Marek Majtyka <alardam@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  tools/lib/bpf/libbpf.h  |  3 +-
>  tools/lib/bpf/netlink.c | 96 +++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/nlattr.h  | 12 ++++++
>  3 files changed, 110 insertions(+), 1 deletion(-)
>

[...]

> @@ -366,6 +433,10 @@ int bpf_xdp_query(int ifindex, int xdp_flags, struct bpf_xdp_query_opts *opts)
>                 .ifinfo.ifi_family = AF_PACKET,
>         };
>         struct xdp_id_md xdp_id = {};
> +       struct xdp_features_md md = {
> +               .ifindex = ifindex,
> +       };
> +       __u16 id;
>         int err;
>
>         if (!OPTS_VALID(opts, bpf_xdp_query_opts))
> @@ -393,6 +464,31 @@ int bpf_xdp_query(int ifindex, int xdp_flags, struct bpf_xdp_query_opts *opts)
>         OPTS_SET(opts, skb_prog_id, xdp_id.info.skb_prog_id);
>         OPTS_SET(opts, attach_mode, xdp_id.info.attach_mode);
>
> +       if (!OPTS_HAS(opts, feature_flags))
> +               return 0;
> +
> +       err = libbpf_netlink_resolve_genl_family_id("netdev", sizeof("netdev"), &id);
> +       if (err < 0)
> +               return libbpf_err(err);
> +
> +       memset(&req, 0, sizeof(req));
> +       req.nh.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
> +       req.nh.nlmsg_flags = NLM_F_REQUEST;
> +       req.nh.nlmsg_type = id;
> +       req.gnl.cmd = NETDEV_CMD_DEV_GET;
> +       req.gnl.version = 2;
> +
> +       err = nlattr_add(&req, NETDEV_A_DEV_IFINDEX, &ifindex, sizeof(ifindex));
> +       if (err < 0)
> +               return err;

just noticed this, we need to use libbpf_err(err) here like in other
error cases to set errno properly. Can you please send a follow up?

> +
> +       err = libbpf_netlink_send_recv(&req, NETLINK_GENERIC,
> +                                      parse_xdp_features, NULL, &md);
> +       if (err)
> +               return libbpf_err(err);
> +
> +       opts->feature_flags = md.flags;
> +
>         return 0;
>  }
>

[...]
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
