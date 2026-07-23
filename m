Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D707C531C7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 08:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 999DF60799;
	Thu, 23 Jul 2026 08:00:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id McQiD5Pemtyh; Thu, 23 Jul 2026 08:00:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C557606A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784793632;
	bh=yDSw7cLGMZBEj6tDvGzyv6D8i/WyEhVowI6BcRy6/cs=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BsA4VT0EoyiKp1U5ddaKPNJkGNY248QizarNDHbQ2uVJQs4wqsYD0ZewKMc+vWgIi
	 wkJxn2Plyn4rL39+SK/LQb4/bApTZ/6GO74IUT8vTki1Z139T3lyr2NCHAfGvdrFj6
	 /NNEox+bkllYynWpljnz/NdqeLrKerfbnj5/gt0lzYocLGAx1jYYW4C6rkPso8aHRM
	 h/nabDpCjKKYVzBY3CdBaRZjLGNLOJCr5qvwCqNwvis/ElSobrxbB0MEA3PW1UqbT/
	 KuY4AuNvN1AdO9/3a4ZNKxXYdoJwp2O8pSK0w4Mp91sphQqVM8GfK7QSUeFvoMmcB3
	 XNhV/jT9lj8nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C557606A7;
	Thu, 23 Jul 2026 08:00:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 55FE442A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 08:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 483A140804
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 08:00:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r6ct6r7QKqWk for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 08:00:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::130; helo=mail-lf1-x130.google.com;
 envelope-from=kerneljasonxing@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0C074407F0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C074407F0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C074407F0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 08:00:24 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5b00d083818so140528e87.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 01:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784793622; cv=none;
 d=google.com; s=arc-20260327;
 b=Tb9BZ1915pTvSP3PwDhlwlMTbbn+p77OScnPvz2qOuHu9BZzCIabVc4vHOthNNV64E
 1tsD6gLiSBEFv2naQ1S/S+uufb6KSIYMd8AAsIq8QP+fKkst0oAhsIwPw2yZWaAq8aQO
 gI3nfP3zmaQGBYA210+1fclu2D1CpBHKL33lIDwWFqDe8zmDuGoB4hZM01L9tH9vJE+U
 ZyRXkoxWbPcgq2WDeTciAsILdfed+8aRZsdnmVBYTPgKLq22NqTpqxI0uY/kCuEskrui
 NZxaAIaUuVwx93I4KJYKKREPIsCUq7TOmYQUobULxC/uYWYHZrJfaWcy6HQ115SnYnuz
 k/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yDSw7cLGMZBEj6tDvGzyv6D8i/WyEhVowI6BcRy6/cs=;
 fh=k77mJKfMlwJ8ApO7cC9/TCry825xK0JrwlCQfZ0uMAw=;
 b=G9msrP3lagB3K+ftdtJMDGpLvSSAe0IURfUuHniv2Uh0LX6sIxshdyi3WOtFGiPCAo
 RDrTZE+9DLFqBuxaqjG8A3EoXwqutWgx5UpENF38/ukFcsM1lSHAa//Q4LGznZDQ08Lc
 5gv5UfUypaw+COZ3PdZ5N35d8pJWf7B6/f18ioA8dzU4eJJbjoINKNDQL+UhZRRcyUqK
 mT8mCZ29DL9jvJCjYdePr4zgm5BiFMZ59eOJk7jF71TH+Qd5EcPJdq5fhhtdFc2yWcFF
 AdxcylWojKjWbAFT3yVDjMErOj4/YzUuXA32GCWjpI5bpkIVuRWK6oMBrCNe11ych0M3
 kHog==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784793622; x=1785398422;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yDSw7cLGMZBEj6tDvGzyv6D8i/WyEhVowI6BcRy6/cs=;
 b=pVLypuES8X7hW1PTrh3uWwMneyrsy477A0UsK4W8hT+9LHuL7zpwcunh50hJxMgmWe
 7WZkWNK7s1lyOXDjTSq6k5plPIkaIbFr9TdIxpY/3F3re2DrJBhIjV+nyw51aUezgy1T
 Ws0VLGvBG5Z0N1nPnik1fMWph1rgqbH/5hBDN2Qni6Ev+Fn0fOyABTd0u5uiV2jLpxK1
 ZAHZWd8pvJa8TwiJ8w6NfDFq+T6juO4pt1GM7yrJmi/U2hRiWis5yuAK7s6j2JhiJa+W
 bJSTQ4tgmcS/xIKtBY7ih9LmuT6mlFxFVrGW/LmUoJqlooDjAa2M4M74WniCV/XOcJ3G
 HQBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBGA+3eU3Pns8JR8U90eg42nR8hxX9kCeTOwBnoloZcUThvVSLq6j1D++H0DAgPyGc7o503IwEJJwfhNnadxc=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxdWa2/m4HI3TxusocHxEN/5rO0Pqy44x6DVarEDd+lmaN98imf
 VS85qO1Kd4ALTF35VsA29JALReyvhuAAlRXppNs0JMm6lw4sbdIRp+F45H8Hbjpb/hiYOJQp3Rh
 WpSsjoxR7n8IS6jKgdHwUXF2i0H3JWqI=
X-Gm-Gg: AR+sD13SmqZLMKNWq7RbS4cqeRdUHftjd+RPLCDcALlEcGSJx30bTlQfujnGiq7lqHU
 /b8+JucJhTM5fm7Ffl5Np7VvmWt5eJ8eWcss7Q0RmdJzfcEpLwrTevfAammDsYng758nxODbRnt
 GMvyo/WNLAHHBm3jCVGwv92xC7mVRt/YNwpBj/eUbMLIR802WlmXQMmdaOBfQt0i8nPlzodfe8U
 3lUoixX6eiCXelTkrlCdE8ZzIHWH9z3Y0iT6fuLiFZDzmX4O+dbPM6PeDyrqgnlm2MDDNxfddH7
 DpiFUUB5jpRtmwuC5exFAvQu8Vzwnbb0hCB/Glal6bUW67Pu+VZZL0j1+GsK0HMvRz+uwpy/R2B
 N
X-Received: by 2002:a05:6512:ac2:b0:5b2:aa73:ea6a with SMTP id
 2adb3069b0e04-5b2b33252ebmr335065e87.10.1784793621839; Thu, 23 Jul 2026
 01:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260717012416.168107-1-chenguang.zhao@linux.dev>
 <CAL+tcoCdbjC4cHjm5C9mDTc05biiJfCRB=e0r0Ssp1qTwdxeJQ@mail.gmail.com>
 <20f83ab8-d99f-4b10-bab1-cd5c6202937c@linux.dev>
In-Reply-To: <20f83ab8-d99f-4b10-bab1-cd5c6202937c@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 Jul 2026 15:59:44 +0800
X-Gm-Features: AUfX_mxXF6M7l6Naj0d5crzlE02rgEJLqmAQ0OCht2o3jghL2yAtSls3tXpbhGo
Message-ID: <CAL+tcoAtn_eg0qwGf+6BJJGvKztNAgBm7tjY44H183=ZOw7zbA@mail.gmail.com>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784793622; x=1785398422; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yDSw7cLGMZBEj6tDvGzyv6D8i/WyEhVowI6BcRy6/cs=;
 b=DvAwQBWIO5KzTOeZG5U4K49YTPopswEFlNTiLE0pcXqHVEUUF8lMdcKGXTdAruGmsA
 3pofqRPCYXpuxxgBCPcoHDEiFk4OcIo0Pi4AdZKaP0binz78ALBQ7tkYGEr9pHtPLSw5
 0TAKfJNhlvfzU4N94B6fbPHwr9G6vhpRZVDws5a3eF03oRcc96xyjOHYyfy8rdllrvBW
 sx7XrlcCkJSv1E1oLYlFuGejxlGaYLf5f4pThIjjrFhARMFFSoLPgU5Uy3HV4kinfblX
 HiexLQamyeGtFRt9qtvvC6A6tF97lmb29qP81nseTaZL6sizdi/bvCvd71ZEV/0EkClP
 tmvA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DvAwQBWI
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

On Thu, Jul 23, 2026 at 3:02=E2=80=AFPM Chenguang Zhao <chenguang.zhao@linu=
x.dev> wrote:
>
> Thanks for the clarification.

Please do not top-post.

>
> I agree: the minimal bugfix belongs in -net for stable backportability, a=
nd the conversion to xdp_build_skb_from_zc() belongs in -next.

Right. That's what I meant. But I will let Maciej/Tony/Olek make the decisi=
on.

>
> Please apply the existing v1 bugfix to -net:
>
>      https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@l=
inux.dev/

If we eventually need this patch, then you will send a v3 patch
instead of asking maintainers to pick it up :)

And feel free to add:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

>
> It already has :
>
>     Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>
> I will drop v2 as a Fixes candidate.
>
> In parallel, I will send a separate net-next series (as v1) that replaces
>
> i40e_construct_skb_zc() with xdp_build_skb_from_zc(), based on
>
> net-next. That patch will not carry a Fixes tag.

As to this version, my tag still holds:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

>
>
> Thanks,
>
> Chenguang
>
>
> =E5=9C=A8 2026/7/22 07:15, Jason Xing =E5=86=99=E9=81=93:
> > On Fri, Jul 17, 2026 at 9:24=E2=80=AFAM Chenguang Zhao <chenguang.zhao@=
linux.dev> wrote:
> >> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> >>
> >> When AF_XDP ZC receives a multi-buffer frame and XDP returns XDP_PASS,
> >> i40e_construct_skb_zc() copied frags incorrectly: memcpy used
> >> skb_frag_page() (page metadata) and __skb_fill_page_desc_noacc() was
> >> given a virtual address instead of a struct page *.
> >>
> >> Drop the custom helper and use xdp_build_skb_from_zc() instead. On
> >> failure, free the xdp buff in the caller. Push the Ethernet header
> >> back before eth_skb_pad()/i40e_process_skb_fields() because
> >> xdp_build_skb_from_zc() already called eth_type_trans().
> >>
> >> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> >> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> >> ---
> >> Revised as suggested by Maciej:
> >>  - Replace i40e_construct_skb_zc() with xdp_build_skb_from_zc()
> > I might have a different opinion on this patch: yes, it actually
> > belongs to -next material. The process should be like: 1) fix the
> > issues by v1, 2) refactor it by v2. The reason behind that is the
> > helper was introduced in 2024 while the home-grown part was in 2023,
> > which means it doesn't help for stable steam to cherry-pick the patch
> > in older kernels like 6.6[1].
> >
> > [1]: https://www.kernel.org/
> >
> > Thanks,
> > Jason
> >
> >> v1:
> >>  https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@li=
nux.dev/
> >>
> >>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 73 +++------------------=
-
> >>  1 file changed, 8 insertions(+), 65 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/=
ethernet/intel/i40e/i40e_xsk.c
> >> index 9f47388eaba5..1319a5c22625 100644
> >> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> >> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> >> @@ -3,6 +3,7 @@
> >>
> >>  #include <linux/bpf_trace.h>
> >>  #include <linux/unroll.h>
> >> +#include <net/xdp.h>
> >>  #include <net/xdp_sock_drv.h>
> >>  #include "i40e_txrx_common.h"
> >>  #include "i40e_xsk.h"
> >> @@ -277,70 +278,6 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *r=
x_ring, u16 count)
> >>         return count =3D=3D nb_buffs;
> >>  }
> >>
> >> -/**
> >> - * i40e_construct_skb_zc - Create skbuff from zero-copy Rx buffer
> >> - * @rx_ring: Rx ring
> >> - * @xdp: xdp_buff
> >> - *
> >> - * This functions allocates a new skb from a zero-copy Rx buffer.
> >> - *
> >> - * Returns the skb, or NULL on failure.
> >> - **/
> >> -static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_rin=
g,
> >> -                                            struct xdp_buff *xdp)
> >> -{
> >> -       unsigned int totalsize =3D xdp->data_end - xdp->data_meta;
> >> -       unsigned int metasize =3D xdp->data - xdp->data_meta;
> >> -       struct skb_shared_info *sinfo =3D NULL;
> >> -       struct sk_buff *skb;
> >> -       u32 nr_frags =3D 0;
> >> -
> >> -       if (unlikely(xdp_buff_has_frags(xdp))) {
> >> -               sinfo =3D xdp_get_shared_info_from_buff(xdp);
> >> -               nr_frags =3D sinfo->nr_frags;
> >> -       }
> >> -       net_prefetch(xdp->data_meta);
> >> -
> >> -       /* allocate a skb to store the frags */
> >> -       skb =3D napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
> >> -       if (unlikely(!skb))
> >> -               goto out;
> >> -
> >> -       memcpy(__skb_put(skb, totalsize), xdp->data_meta,
> >> -              ALIGN(totalsize, sizeof(long)));
> >> -
> >> -       if (metasize) {
> >> -               skb_metadata_set(skb, metasize);
> >> -               __skb_pull(skb, metasize);
> >> -       }
> >> -
> >> -       if (likely(!xdp_buff_has_frags(xdp)))
> >> -               goto out;
> >> -
> >> -       for (int i =3D 0; i < nr_frags; i++) {
> >> -               struct skb_shared_info *skinfo =3D skb_shinfo(skb);
> >> -               skb_frag_t *frag =3D &sinfo->frags[i];
> >> -               struct page *page;
> >> -               void *addr;
> >> -
> >> -               page =3D dev_alloc_page();
> >> -               if (!page) {
> >> -                       dev_kfree_skb(skb);
> >> -                       return NULL;
> >> -               }
> >> -               addr =3D page_to_virt(page);
> >> -
> >> -               memcpy(addr, skb_frag_page(frag), skb_frag_size(frag))=
;
> >> -
> >> -               __skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
> >> -                                          addr, 0, skb_frag_size(frag=
));
> >> -       }
> >> -
> >> -out:
> >> -       xsk_buff_free(xdp);
> >> -       return skb;
> >> -}
> >> -
> >>  static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
> >>                                       struct xdp_buff *xdp_buff,
> >>                                       union i40e_rx_desc *rx_desc,
> >> @@ -372,14 +309,20 @@ static void i40e_handle_xdp_result_zc(struct i40=
e_ring *rx_ring,
> >>                  * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
> >>                  * SBP is *not* set in PRT_SBPVSI (default not set).
> >>                  */
> >> -               skb =3D i40e_construct_skb_zc(rx_ring, xdp_buff);
> >> +               skb =3D xdp_build_skb_from_zc(xdp_buff);
> >>                 if (!skb) {
> >> +                       xsk_buff_free(xdp_buff);
> >>                         rx_ring->rx_stats.alloc_buff_failed++;
> >>                         *rx_packets =3D 0;
> >>                         *rx_bytes =3D 0;
> >>                         return;
> >>                 }
> >>
> >> +               /* xdp_build_skb_from_zc() already ran eth_type_trans(=
);
> >> +                * restore the header for eth_skb_pad()/process_skb_fi=
elds().
> >> +                */
> >> +               __skb_push(skb, skb->data - skb_mac_header(skb));
> >> +
> >>                 if (eth_skb_pad(skb)) {
> >>                         *rx_packets =3D 0;
> >>                         *rx_bytes =3D 0;
> >> --
> >> 2.25.1
> >>
> >>
