Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269C9C61DB3
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Jan 2023 23:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A54574026F;
	Fri, 27 Jan 2023 23:39:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A54574026F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674862751;
	bh=Qrh05MEgYER6AuI+HbF9yAsfxQ+qxNr2ig3MgcSOIrE=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=S6EzQuBzK/gR8V0t+1/HdkE8zYl+IZOw0ulWd2jP6HdG2nQ6dsUNEN13AcTo1I8UD
	 urCBLulYcAE9Jj4TQuy7CrUbIw50D3uPe/LE0cE5XgfxtUJW2itq0DdsE3BNIkskmF
	 Ag37MINGqRBRQv36Jy0KJ3upnhJfk/GxNAYemnCVCPlgdJg3RE8cEQvBQr6QoVOLMB
	 eWXSSO9dLm7Xqz0EKnPvnIPq5oe2YPHcCgCoxlM4GyFCecCfQKhTUyfl8y7cVZuywL
	 vExbD8W2jAmSvJuCVDVIzFjxqbmSkUt+QhtKYNaUqt5e32t2sPwluW5TsFnFK19KFT
	 DrxXhR28BUJYw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6hV_F4xWZ2QV; Fri, 27 Jan 2023 23:39:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E512404C0;
	Fri, 27 Jan 2023 23:39:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E512404C0
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 3689A1BF34B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Jan 2023 23:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B53A4198E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Jan 2023 23:39:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B53A4198E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wyDFWSl2N5P2 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Jan 2023 23:39:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93DAA418CB
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 93DAA418CB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Jan 2023 23:39:07 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id ud5so17762207ejc.4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Jan 2023 15:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OS57Cl1v1ND4yDvQPK9DGvNY074irrM+XZQ4x1tyrxo=;
 b=QLyVvpPHxY0JTMCoe+wTNhQkVr5/7lZp0rAmMBX/7gfIYVFLAQzf9uK2lHOl0VEvVh
 msuulBOQehm4YqF8AFSxuY+2llVSoOu1k2HKDi5ngjaJNSp4xblnZeB2OM9WkZfY1YOR
 tFjWZi+BELMhsqKic35Wo4GclynenYLtsAMoFctZ1hbqJc0wpV24yuK11gaudtTAAPAz
 4FYaoRkqEIaFnHzh9hltT9PP9Cm1RGo6jr8v+7JF1xgJSBxsyPmwGJgyGv2DNrCcQMdT
 Cm8v+EwVQRg2J/s68JMDZ7DXXg1eMCSFSwT+jhnM+O0Z3SmBWo9lQZISdLimMkA7UVu5
 a/gQ==
X-Gm-Message-State: AO0yUKXvQ4qKQZFGef9ymNbnw4/YrN898zUE9QxRMXwh2tocadBnumsW
 kA1dXeHZfYyPe130IJ0wbuXUs73PgpLt/pmLBnE=
X-Google-Smtp-Source: AK7set+iEOmdxvTUlQMzh35XvojPOvTvkl59ca5GGONndB4m9IrJ3m0aYFDTDyHV0cQzXOSCTF41x8omq/wDY1VaSqo=
X-Received: by 2002:a17:906:ce23:b0:882:665:5135 with SMTP id
 sd3-20020a170906ce2300b0088206655135mr94283ejb.265.1674862745558; Fri, 27 Jan
 2023 15:39:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674737592.git.lorenzo@kernel.org>
 <a7e6e8da5b2ba24f44f0d5b44a234e2bf90220fd.1674737592.git.lorenzo@kernel.org>
In-Reply-To: <a7e6e8da5b2ba24f44f0d5b44a234e2bf90220fd.1674737592.git.lorenzo@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Jan 2023 15:38:53 -0800
Message-ID: <CAEf4BzYjt3J5_ESMKjRFRh6ROg-CN=QazAZpKd9wnaSxjjKbAg@mail.gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OS57Cl1v1ND4yDvQPK9DGvNY074irrM+XZQ4x1tyrxo=;
 b=lRU2TkbyI3bAuFYzYtDuQtseBVDPNqjLBq6bMmSGyNdOdsBLmiLwa2nst7N2MR0RjD
 azJY8SpV2g3zLKVc6gfNmaVd00W4rqVJaczLYnrYL3MFy/WUH5QZwX339HqUY5muok4V
 6ojLt+xHEP2UJI8eM0HJsXZVt5LcIMNMc2pYQhvOXajwW1Ah/PV99LBp4NCGOhMrmsKc
 IWyEdM8wNw6FgPBQK7YzeVw/klCYW+IZfBp3mcha5SroP4pvnqLMvKUGJKa8TTMYlmdm
 NYuIulojrRyQ12/3c3WCynoGyiS0xJEDgw7Gn4MSLc7zpB1v2LiDyKezKcBUYms5G6aU
 +hKA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=lRU2Tkby
Subject: Re: [Intel-wired-lan] [PATCH v3 bpf-next 5/8] libbpf: add API to
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
 edumazet@google.com, anthony.l.nguyen@intel.com, daniel@iogearbox.net,
 andrii@kernel.org, intel-wired-lan@lists.osuosl.org, simon.horman@corigine.com,
 kuba@kernel.org, pabeni@redhat.com, aelior@marvell.com, hawk@kernel.org,
 christophe.jaillet@wanadoo.fr, memxor@gmail.com, john@phrozen.org,
 bjorn@kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 leon@kernel.org, netdev@vger.kernel.org, toke@redhat.com, martin.lau@linux.dev,
 ecree.xilinx@gmail.com, alardam@gmail.com, gospo@broadcom.com,
 saeedm@nvidia.com, davem@davemloft.net, nbd@nbd.name
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jan 26, 2023 at 4:59 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
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
>  tools/lib/bpf/netlink.c | 99 +++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/nlattr.h  | 12 +++++
>  3 files changed, 113 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 898db26e42e9..29cb7040fa77 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -982,9 +982,10 @@ struct bpf_xdp_query_opts {
>         __u32 hw_prog_id;       /* output */
>         __u32 skb_prog_id;      /* output */
>         __u8 attach_mode;       /* output */
> +       __u64 fflags;           /* output */
>         size_t :0;
>  };
> -#define bpf_xdp_query_opts__last_field attach_mode
> +#define bpf_xdp_query_opts__last_field fflags

is "fflags" an obvious name in this context? I'd expect
"feature_flags", especially that there are already "flags". Is saving
a few characters worth the confusion?


>
>  LIBBPF_API int bpf_xdp_attach(int ifindex, int prog_fd, __u32 flags,
>                               const struct bpf_xdp_attach_opts *opts);
> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
> index d2468a04a6c3..674e4d61e67e 100644
> --- a/tools/lib/bpf/netlink.c
> +++ b/tools/lib/bpf/netlink.c
> @@ -9,6 +9,7 @@
>  #include <linux/if_ether.h>
>  #include <linux/pkt_cls.h>
>  #include <linux/rtnetlink.h>
> +#include <linux/netdev.h>
>  #include <sys/socket.h>
>  #include <errno.h>
>  #include <time.h>
> @@ -39,6 +40,12 @@ struct xdp_id_md {
>         int ifindex;
>         __u32 flags;
>         struct xdp_link_info info;
> +       __u64 fflags;
> +};
> +
> +struct xdp_features_md {
> +       int ifindex;
> +       __u64 flags;
>  };
>
>  static int libbpf_netlink_open(__u32 *nl_pid, int proto)

[...]

>  int bpf_xdp_query(int ifindex, int xdp_flags, struct bpf_xdp_query_opts *opts)
>  {
>         struct libbpf_nla_req req = {
> @@ -393,6 +460,38 @@ int bpf_xdp_query(int ifindex, int xdp_flags, struct bpf_xdp_query_opts *opts)
>         OPTS_SET(opts, skb_prog_id, xdp_id.info.skb_prog_id);
>         OPTS_SET(opts, attach_mode, xdp_id.info.attach_mode);
>
> +       if (OPTS_HAS(opts, fflags)) {

maybe invert condition, return early, reduce nesting of the following code?

> +               struct xdp_features_md md = {
> +                       .ifindex = ifindex,
> +               };
> +               __u16 id;
> +
> +               err = libbpf_netlink_resolve_genl_family_id("netdev",
> +                                                           sizeof("netdev"),
> +                                                           &id);

nit: if it fits under 100 characters, let's leave it on a single line

> +               if (err < 0)
> +                       return libbpf_err(err);
> +
> +               memset(&req, 0, sizeof(req));
> +               req.nh.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
> +               req.nh.nlmsg_flags = NLM_F_REQUEST;
> +               req.nh.nlmsg_type = id;
> +               req.gnl.cmd = NETDEV_CMD_DEV_GET;
> +               req.gnl.version = 2;
> +
> +               err = nlattr_add(&req, NETDEV_A_DEV_IFINDEX, &ifindex,
> +                                sizeof(ifindex));
> +               if (err < 0)
> +                       return err;
> +
> +               err = libbpf_netlink_send_recv(&req, NETLINK_GENERIC,
> +                                              parse_xdp_features, NULL, &md);
> +               if (err)
> +                       return libbpf_err(err);
> +
> +               opts->fflags = md.flags;
> +       }
> +
>         return 0;
>  }
>

[...]
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
