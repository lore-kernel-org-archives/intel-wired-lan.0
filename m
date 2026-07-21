Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C19C4452D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Jul 2026 23:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3FB1180E3F;
	Tue, 21 Jul 2026 23:16:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XwFAB6Ws3YZh; Tue, 21 Jul 2026 23:16:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 499F680C66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784675772;
	bh=LTrgY5zF2M3nMKJvPh+FFXaA1E6Ck1f9mjx2//PbJRo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0nZrj3D9pf76jltanz/0QZNPwEo2IDAOs5OBzGOo1D/UAds7AYFQSg0obgw5U9DDt
	 EAbuMH6Laeh9vRJZ2Bwt/CSPo0/cm3Sk5LAmcZKN+2PHk19ROi7YeQNUrWap14L/CA
	 XndDZXEDHKyW+VkzZuju4AMlqlRPHT725ur2VmTKgfkZdjX2A1Y5w6kUt39SNad7PT
	 bBV0ZluORolPSNJAIOnuBFt4dNXL0U3J2tGNJHEWsXeh/F70HBg/uFM3/DWnImrMrG
	 MzrX8TshfY/fJ436it3P0sMArlWqlrcs6Y2sFg41LrWxAlWda7fyM+LnMsolXM3S6a
	 IrdGtFylav45Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 499F680C66;
	Tue, 21 Jul 2026 23:16:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FFA9313
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 23:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2CCDD60714
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 23:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8TcwZYBQUvf9 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Jul 2026 23:16:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com;
 envelope-from=kerneljasonxing@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C22C160711
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C22C160711
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C22C160711
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 23:16:08 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-39eb257e9fbso34201961fa.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 16:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784675766; cv=none;
 d=google.com; s=arc-20260327;
 b=oRQ0xkcJcb7rzGcbV4jSzx/594aVZQiAvgo4SosTfMgB+g36QEKCxY1ZIXDVRAtet2
 1l9dzv3E4JLKzAZ+hg1f5hUM0qTHNHrlANfoaADDrRzQcsqMsv6fmytafu6vYXCAlZZT
 Vbri3JfLXsEPW+YDsHCo32RU3O362EGuyxxPRw+VHSsTmoFPEFgg809mTvH0ilrCr9b8
 gGVaKRtUhR72c7auSvSb2PVKN1EGEWrtgary/wKJsMChKMjw9v/vhcxNZTppaD+qzRY7
 /SXpGLKnu5EaBxT/wYuuP5LNYeVKMxdkfKcDay6J8Dli/vBkTDnkHR6ANHNQYgPrtCS1
 O7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LTrgY5zF2M3nMKJvPh+FFXaA1E6Ck1f9mjx2//PbJRo=;
 fh=mLnsX7XZVEKAbwS7YBUkBxjGHy85apsSviJ9s8WVoAs=;
 b=LeN3RCjpcs/Q2q/ngZ+tBbV3TK8rvHi/iujqbG9d3RgWnGSL1oAif1GWju37IjlSjb
 0Bh0wW5wKhZUW0Cb9F7yKNB3wCmIuL2Sh3CdZzaIofu0Ej2ARIcoxEQYsVG6RSfiCAS6
 PzA6G11UiskcqgZMI48+MO70/b1lQIaosMKZLLCKzEXCaFdVuuWOB8a9DH/Z7ybcCIS2
 KO1oJssNiVBimmADSgvz5gdo+vxjHDtsYL0ep7GwE55v7gJ8WuygSo6SbI4banhYX7kN
 2TE0c37ss2VLwhMYVNRQ2rDkl7hvswP3TUnuQl4s1GZOvv5+KRwA2xlzDBvo45iT4Mjj
 4nOQ==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784675766; x=1785280566;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LTrgY5zF2M3nMKJvPh+FFXaA1E6Ck1f9mjx2//PbJRo=;
 b=Rhv2PMUT+U/jOfn6anWSGLiTbR9tB/kT1YHNTnuyCytG8gckcB1IVx3pvLTbQaL3zp
 grFngP/LpQrEkiPVnKVkAwPhz3NXfFtRa9uPujCnDjCJ11x5G7j6Pafs6XXMDYW0/yYQ
 Itv448sSUpssFzwcPcyniLNU0BWRzkgGZb4HIUnN18sJFAcrpb6JX7iooMTFtbyKg7LZ
 Is566T42y221MgWFZO/asMddJ7Nzw8fQVqMhl2b/qkuckQZAOFE0XxDNCbSVITKkoc8z
 aPos3dBbra/viqUi4pfu7KpNMYiYCYY/Za8QbvJses70+I2qKSGRhBLlJ6zjcWEy/zDm
 1nog==
X-Forwarded-Encrypted: i=1;
 AHgh+RrF4adFJFQoZmtN5Y9o9FPR7XRYYRyLH0JTVPitiJEh8ZYJJv2G0BsvB0dCwfqQA6RxIJiHb2GtMVj+Nhs/HKo=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwHRviZ43FrwpRTeK0wpBk1lpYgpNlNxseItJq+7EGu4v1Kmac5
 t8kzpaRTia+lVYsku/ISH5/2IJ1S9M74YioIaWcn4sOHYsmgMJ83uCz7SUqojWNmW+E9Qva9qJJ
 U8cJTm0Xi5GrzLC8RwV6uu5RxaxBKNhM=
X-Gm-Gg: AR+sD12CIA8mapaZovkQaXIRe8l/vHev8eUmilKwfLQCGQiyxtTV3pBusdR5+JQwBFr
 vCynWdNm++tz3I42vpXytuRTMHQu9uMADnYEsL8sgdwWGKkJ/79+27+PiwzriHK24mdJS5SvTCw
 vimqW2pOk/51H3Tm3scfrKSYAIMUjALnxcInmgV51SB9a7X4wka6a6P9NX30TbjVNCYPRUQrytX
 yL0/2e9a5sZ9SXEIU4YdGIKAHmnH1KQ//lZa5zAcS4xwk+qAZ0h57L4Z5EwKm1PsLmiAIxbsh5N
 WvO8Px5yMRgy9HedZkZjTrBtYVzz4HKrzMPie7pV+2xBznw0ZYD6wUQh7IT1uMXhYCOfJxqsG+Q
 =
X-Received: by 2002:a05:6512:3d0d:b0:5ae:b86b:71ee with SMTP id
 2adb3069b0e04-5b28f998d25mr4200656e87.38.1784675766155; Tue, 21 Jul 2026
 16:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260717012416.168107-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260717012416.168107-1-chenguang.zhao@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 22 Jul 2026 07:15:28 +0800
X-Gm-Features: AUfX_mxQea9F49gwqUrjVFazKRlYsxiuTSbn67aBB0jdhefEUWVCROGSEtHMdSE
Message-ID: <CAL+tcoCdbjC4cHjm5C9mDTc05biiJfCRB=e0r0Ssp1qTwdxeJQ@mail.gmail.com>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784675766; x=1785280566; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LTrgY5zF2M3nMKJvPh+FFXaA1E6Ck1f9mjx2//PbJRo=;
 b=JAY1rp8I7KVgwraopj/1AeasbY6G1bNznRCbVJG+ny2CqLgc5Cywm+TFdZLqVFfybc
 3pfxiBG9aEXlJmE89YmNivRXYBMEK42JRYWxn3EUfy9oXx8d2i5v3AgZnLkkU/VklnkO
 X14rVL0PWR35YOSYClqkTWGRVXLeQAxObask/4de8TxzggIIpz3osgF6mqeoRdiq6xFL
 aEBms3oZgXawJkQ1/XvOO8BbmhnAPIDjzwlHwfxLP7MLbC+7rlisT/5A2QEihSTYIY3t
 Oq1ZzaNb/uhRPkO5QIS9a534mncbdHX/LVFPxVYLvHD6E7JU5qjUOlgEZbb/6FHTZpYR
 KKtg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JAY1rp8I
Subject: Re: [Intel-wired-lan] [PATCH net v2] i40e: xsk: fix multi-buffer
 XDP_PASS skb construction
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

On Fri, Jul 17, 2026 at 9:24=E2=80=AFAM Chenguang Zhao <chenguang.zhao@linu=
x.dev> wrote:
>
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>
> When AF_XDP ZC receives a multi-buffer frame and XDP returns XDP_PASS,
> i40e_construct_skb_zc() copied frags incorrectly: memcpy used
> skb_frag_page() (page metadata) and __skb_fill_page_desc_noacc() was
> given a virtual address instead of a struct page *.
>
> Drop the custom helper and use xdp_build_skb_from_zc() instead. On
> failure, free the xdp buff in the caller. Push the Ethernet header
> back before eth_skb_pad()/i40e_process_skb_fields() because
> xdp_build_skb_from_zc() already called eth_type_trans().
>
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> Revised as suggested by Maciej:
>  - Replace i40e_construct_skb_zc() with xdp_build_skb_from_zc()

I might have a different opinion on this patch: yes, it actually
belongs to -next material. The process should be like: 1) fix the
issues by v1, 2) refactor it by v2. The reason behind that is the
helper was introduced in 2024 while the home-grown part was in 2023,
which means it doesn't help for stable steam to cherry-pick the patch
in older kernels like 6.6[1].

[1]: https://www.kernel.org/

Thanks,
Jason

>
> v1:
>  https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@linux=
.dev/
>
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 73 +++-------------------
>  1 file changed, 8 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/eth=
ernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..1319a5c22625 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -3,6 +3,7 @@
>
>  #include <linux/bpf_trace.h>
>  #include <linux/unroll.h>
> +#include <net/xdp.h>
>  #include <net/xdp_sock_drv.h>
>  #include "i40e_txrx_common.h"
>  #include "i40e_xsk.h"
> @@ -277,70 +278,6 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_r=
ing, u16 count)
>         return count =3D=3D nb_buffs;
>  }
>
> -/**
> - * i40e_construct_skb_zc - Create skbuff from zero-copy Rx buffer
> - * @rx_ring: Rx ring
> - * @xdp: xdp_buff
> - *
> - * This functions allocates a new skb from a zero-copy Rx buffer.
> - *
> - * Returns the skb, or NULL on failure.
> - **/
> -static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
> -                                            struct xdp_buff *xdp)
> -{
> -       unsigned int totalsize =3D xdp->data_end - xdp->data_meta;
> -       unsigned int metasize =3D xdp->data - xdp->data_meta;
> -       struct skb_shared_info *sinfo =3D NULL;
> -       struct sk_buff *skb;
> -       u32 nr_frags =3D 0;
> -
> -       if (unlikely(xdp_buff_has_frags(xdp))) {
> -               sinfo =3D xdp_get_shared_info_from_buff(xdp);
> -               nr_frags =3D sinfo->nr_frags;
> -       }
> -       net_prefetch(xdp->data_meta);
> -
> -       /* allocate a skb to store the frags */
> -       skb =3D napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
> -       if (unlikely(!skb))
> -               goto out;
> -
> -       memcpy(__skb_put(skb, totalsize), xdp->data_meta,
> -              ALIGN(totalsize, sizeof(long)));
> -
> -       if (metasize) {
> -               skb_metadata_set(skb, metasize);
> -               __skb_pull(skb, metasize);
> -       }
> -
> -       if (likely(!xdp_buff_has_frags(xdp)))
> -               goto out;
> -
> -       for (int i =3D 0; i < nr_frags; i++) {
> -               struct skb_shared_info *skinfo =3D skb_shinfo(skb);
> -               skb_frag_t *frag =3D &sinfo->frags[i];
> -               struct page *page;
> -               void *addr;
> -
> -               page =3D dev_alloc_page();
> -               if (!page) {
> -                       dev_kfree_skb(skb);
> -                       return NULL;
> -               }
> -               addr =3D page_to_virt(page);
> -
> -               memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
> -
> -               __skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
> -                                          addr, 0, skb_frag_size(frag));
> -       }
> -
> -out:
> -       xsk_buff_free(xdp);
> -       return skb;
> -}
> -
>  static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>                                       struct xdp_buff *xdp_buff,
>                                       union i40e_rx_desc *rx_desc,
> @@ -372,14 +309,20 @@ static void i40e_handle_xdp_result_zc(struct i40e_r=
ing *rx_ring,
>                  * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
>                  * SBP is *not* set in PRT_SBPVSI (default not set).
>                  */
> -               skb =3D i40e_construct_skb_zc(rx_ring, xdp_buff);
> +               skb =3D xdp_build_skb_from_zc(xdp_buff);
>                 if (!skb) {
> +                       xsk_buff_free(xdp_buff);
>                         rx_ring->rx_stats.alloc_buff_failed++;
>                         *rx_packets =3D 0;
>                         *rx_bytes =3D 0;
>                         return;
>                 }
>
> +               /* xdp_build_skb_from_zc() already ran eth_type_trans();
> +                * restore the header for eth_skb_pad()/process_skb_field=
s().
> +                */
> +               __skb_push(skb, skb->data - skb_mac_header(skb));
> +
>                 if (eth_skb_pad(skb)) {
>                         *rx_packets =3D 0;
>                         *rx_bytes =3D 0;
> --
> 2.25.1
>
>
