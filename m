Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC61C606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Z20TSzkv;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=RuW/mxp0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC3FC811F8;
	Tue, 10 Nov 2026 16:51:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YOa2-aTsWF1y; Tue, 10 Nov 2026 16:51:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D6CD0812AA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329482;
	b=g6RWD9zVd39WmRT6Q1YxGS0mtPy7AGgCCMT9CIOeTD2QDabN9An0YJgjs52a/etv8eUS
	 QZ6j4tzI1TQWU5IX63U9Na1Psyu3CcAQrYwepj32sQf0t7LxXJghD9EoE2foGeAs3Bymw
	 Lfy6RN1L9yd8UA5bPw+Kp+QYMfJBjoBw0iAojrKixFbEQmq0eNrGYL/u3Bs1o7hgqYwBH
	 6ARJnNnBjgigLVKhbDLmL7hvk2TBak/mdY/PZmQ1AxKo7KjoUScpBOfW3Z6BgXEeTGegW
	 F2Kp1sGun8TxcFXlVu8/MOqEuCvPy+dAPmYgiwvy4pgm9qO3yfuypmngQI8JFFywmWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329482;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ROinplkTxqEpdG8wQz+UQs4W74CbHVLhLR8dpDiNGwY=;
	b=YgU0VJVoEeSaJ5PhVyJpGMNYQLoC12n/rnrwjtFRyBVI5lBZALlRfw49DH6XS7twFFg8
	 xObzqq3DtKB9VtmVCV0tUYXx0rIGnyQX0p0PiaGN4ZcAQK8xt+V1kk8m6U877syz2+dw9
	 xZghVhiO9bI9obifq8gM8AZwyDUZMN+UzsNZBpX7n3Dj6ykQdxS70pajcmn48sag9lXRd
	 uN4weUDZYvFCKlE4hh1jKPiUlXhTh6LarUMeXLPq4dynP9PfmHZ3ZKRXmboE+Aa+8w/zw
	 EONzpN6H8yZQwlLPS8CVvQ9+1pICScx1g5SOE3nnSUS36k0PENOzLjSQT7AiHQl3BsQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="RuW/mxp0";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794329482;
	bh=ROinplkTxqEpdG8wQz+UQs4W74CbHVLhLR8dpDiNGwY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z20TSzkvOE7NDhJxBCRefGbcsgHDSEcOmWVd1cU+rshqy25yvn48kcquIOi62qmhL
	 DL8lKNCotF0p2pkM6BV2C0n5v4QPNDzKD3J82Gl43Y2C3zfvoemC4O7sVKQmXu2989
	 61+PvSVyIVD5WV8gEVUAOzTucpsl8Q4sGwkeNQb5h5woSAVTiMgdsiJ2yKIjzJRqsu
	 T8wk5A4NM7Nmm2NxqA8Gro+n4iKL86xs74BX/dNyljUZSXpVGO53R25leojFhC9neU
	 UjhDuU51eIgGnvtzF4DHyydNUjQ1L2dOU6JXj4z6IEt289JFTx4959HxKutAe7iiEM
	 vO6+9u0+luvmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6CD0812AA;
	Tue, 10 Nov 2026 16:51:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 410BD31F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3298F80D1C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:42:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ESq4irE8Xmis for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 04:42:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB5B280C75
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=RuW/mxp0
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB5B280C75
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:42:15 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-714d57774d8so988129eaf.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 20:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794285734; x=1794890534;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ROinplkTxqEpdG8wQz+UQs4W74CbHVLhLR8dpDiNGwY=;
 b=RuW/mxp0gv4aapHLSKPSH6t4LObbL1fQ8lAo58zECCeTjxoq86yPpMuzszgioL3fH3
 9kvWuTaV9+nUDLzr9T+HVOYnqgdWN0CMb2ZCSaSH4xjCXCD2mhhsCz14MfPz0cVBSX+W
 DWgfzAeOxmS99n/rpWRPNj7X14URIksT6+tCd5Iye0dR3vSPOWtU0tA/cqdQ6beDo5Tn
 66sJ8dntTcA70yEajOObiBuAJdctFSEGUQRB5STGqAICMqeujNKCA4l9zBllqohoB+qq
 uJlrvyP1Ibu1we0tQIzjbwL2V13CH/H0625Ni30K/dmj0n+zIYDwxQgmelUaGqLiWpIZ
 gOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794285734; x=1794890534;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ROinplkTxqEpdG8wQz+UQs4W74CbHVLhLR8dpDiNGwY=;
 b=NW2a4KP23BpAilk9qyUiER9Cs4N4yUFxaBbniadca78V0xqC38O6vKlClHbYZwvEp4
 4bHPHd8+56cHU2C6CXBWyuoK1zqkPS3vGFlFRT0KlgVQnGGwahAbkAzkjyYhNEVHS0zB
 Y3ZjWO6vfTMKvuoCIpKbAj3OzDDPUlr42JDUJUVy89IWZdetaG4p7zBiT4Ep3Ck/zKiX
 0ZTX2te2EamienVUhh5lmpoeCDC9JmeVVf9N+4lSWn2tFAkHlzAGytvqfvZHbS8uZZjY
 pHGW09R9+3YHEjfBR/GC6mz+oU1aoUJ0vk1fnhbQZZ/JQOgFYhlqwODyTKPzLETQmDZv
 /cUg==
X-Forwarded-Encrypted: i=1;
 AL+hErHTS6VBYMa4Dog3bufAIhA/FXz1ISJhZj/AARcAdNECK1fyRG1BueDfm51UHbUSpHUtaXykIliEYxNBC2kDK0E=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9RfQBeOLrsvRDoc7Qckz730sHDbrCYcjQP+z9KH3wLCjqkLEcF
 VqhQ6MZI3E09Sjy8iSbV/nl+5f4opRk5C0wKLOVpslwl3Y1bOvA/BPCA+UA0hilg3tuAPxJNVkg
 1+XyU7ghK75Tnj9GZb2101sNu+EWo3X9j35/xG5xekg==
X-Gm-Gg: AYBFou1gmH2NNyr2GMd2yy+fnhDnLtc8Ary9gBq2B44uILq5GmS2Zo0k4VCYA0OEDyv
 ZOHoU+jVcgpEXi+c3agTtQoZsOclqluBRYsi+jDcKykili2AfaQQmiaSB3K5LZtezLOYCKwUAsu
 c1XRa5wNsZU+cj4hlv9xp7jAYRvpXlZgVNrxsA1jf77oBOgByC5Jmmwtr2LrJZTXNhQq7pTEQSJ
 pnCRALu8vQbx7kXThCl5m6yB+f+HBNvFIdEPIFdaMsFRmQFnKLXgCYCA/PZPI0lbYqHl+IX3EOr
 7S2BiF8SGUmzE1wQ6exDyg2W4KSx8ic4vWLMrudRUQQru64i4EhxQ6TsuA+5bSmcDBnfwGbBOpI
 81PAxmUlq+kfDcxAekw+L+Hum1k9OUlu9ybAUk3sA8tIOwoSikQCTS1jmMHFWkz3Iduokj1utAZ
 n0XKRxzIrTWw==
X-Received: by 2002:a05:6820:824:b0:715:2424:b6c7 with SMTP id
 006d021491bc7-718a25631ebmr744221eaf.2.1794285734188; Mon, 09 Nov 2026
 20:42:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <115997f55d63b507ce54fbe9e22900b59016f3c3.1794281983.git.tianyi@cloudflare.com>
 <sashiko-outbox-206183@kernel.org>
In-Reply-To: <sashiko-outbox-206183@kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Tue, 10 Nov 2026 04:42:03 +0000
X-Gm-Features: AclHuK8b0bXERRMbxB4h1nf7ja09xd60YTNUFZCGO3eGicEqv2ygIU4ZDyBl9Fw
Message-ID: <CAG4wq-f7LgXVUu_DpH_Nk1ab1ghistFijw1m2mTxHxN_0hBWxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/15] xdp: reserve an skb core extension area
 after the xdp_frame
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 10 Nov 2026 16:51:08 +0000
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Both comments follow the style around them in include/net/xdp.h.
Most block comments in this file start the text on the /* line.
I will keep them as they are.

Cheers,
Tianyi Gao

On Tue, Nov 10, 2026 at 4:18=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] xdp: multi-line comment style violation in include/net/xdp.h
> --
>
> commit c815cea2f0a60c677b6335d7bc98d4ff8c9346df
> Author: Tianyi Gao <tianyi@cloudflare.com>
>
> xdp: reserve an skb core extension area after the xdp_frame
>
> This commit reserves an skb core extension area in the XDP headroom after
> struct xdp_frame and updates XDP head, metadata, and pull-data helpers to
> preserve it.
>
> Link: https://lore.kernel.org/all/1d5521eb-84fc-4417-a3f5-6366694d160a@ke=
rnel.org/
>
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index 07231adfb5f82..c888353425d42 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -81,6 +81,9 @@ enum xdp_buff_flags {
> >        * XDP program is not attached.
> >        */
> >       XDP_FLAGS_FRAGS_UNREADABLE      =3D BIT(2),
> > +     XDP_FLAGS_HAS_SKB_EXT           =3D BIT(3), /* skb core extension=
 header
> > +                                                * is valid
> > +                                                */
> >  };
>
> [ ... ]
>
> > @@ -450,6 +464,37 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct=
 xdp_buff *xdp)
> >       return xdp_frame;
> >  }
> >
> > +/* skb core extensions: RX metadata that an XDP program stores in the
> > + * headroom right after the xdp_frame, for the skb that is built later=
.
> > + */
>
> [Severity: Low]
> This isn't a bug, but BPF coding style puts the opening /* of multi-line
> comments on its own line, with the comment text starting on the next line=
,
> for both XDP_FLAGS_HAS_SKB_EXT and the comment above enum xdp_skb_ext_id.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794281983.=
git.tianyi@cloudflare.com?part=3D1
