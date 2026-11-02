Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727A606A324
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VQhA8smH;
	dkim=pass (2048-bit key, unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google header.b=mP0tyFUT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A3BB40508;
	Mon,  2 Nov 2026 22:32:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vYgdBRfpF_oN; Mon,  2 Nov 2026 22:32:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 213CB40509
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658776;
	b=eJRFbA0JQNoUXiSVOI95pHnWFnF780pq6sUJUbnMHC0FXHDWdgPqAURrclWKPdTJGkMI
	 7eoCCQ8swzmbaFsK6bk7vLm+ibkwRkuelhHJio0Eetyx08HmDnHg1aytZ6X2/rqxSkvRn
	 HzDH6UIjmO3S2W62WWFVdx7Z21Z2J7zfJx3lwxacaTbo9K4ivO1nXsL1uzuXaYrcC7+67
	 nuvWNYLNWVslp4pQXW+OffjpVXJcbB6MMXi8S+n9X6J2Oq7CFdU4P7nZ8cK9JDxtJIwKt
	 M2XdF4ToefMpeO6CrOKjbQdYk7h8qvoAOvBBxzcyaNa5IZhuT1MCRlC3QfLus1S6+uA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658776;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=05WhMxae0rz15h1TGq0mYQ3vTYNApMzOi4Y++NBdM+w=;
	b=JcOGO72Xh7Gx4CnHL+49kYLvBy2ffTLsZZjL72nvmPJxarVkfY72H380ZLJEnGnCZzxO
	 eVyaOkHq5a0ZzTmEskx5aZuJb4z3vkylId4T5D/pUZ7bbSk9dox2Rt+R/MN5kRmk7Geiy
	 Az3r4+VH0nvF3Qdt9WoBM39n3DKAAVQwalsbaxDJAVCFS03vYAZJbX4JlkBEVvv4uqRA1
	 MsOrvzouPgO3emX0g98Pshs2bkLVbwgbmQpNFGIRUKDFin4A1wVXtDNNPvf2D1nnQz5ae
	 mB9Z0FH51q+PSqLzp06nk4DxTzF+Q0QIO2VcQ0xnlDU0mC6McWouVrBitJ+peRr8y3Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=none header.from=x6u.co;
	dkim=pass header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google header.b=mP0tyFUT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793658776;
	bh=05WhMxae0rz15h1TGq0mYQ3vTYNApMzOi4Y++NBdM+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VQhA8smHnFR8tR6Fcv9XFMaYUUU37cTdpmFITXAbSEyFlxBVuax3J782u2HG9oT04
	 p0T5oHj8NIXO5Q4/pDq4hu7Hykxc49iuVMlzulHo1IWV+KTV0gHq13h7BHwPYaJsfp
	 dxvJIpZTLWHtITQxG9xCRwsRf0zzRybISWR34ip4odr1qHoRGSB4krPQ7PQHJ0e8wL
	 jZO4K9pBHDgrs8TfYbaauEfZSF6r4N3gbau1OzJp9lHW8z+zZo5j7Bl7f9NdgD2wEL
	 ZwAcY5iTWpeUQxLOZ958MKjhg32qwPKCnlLDkBIM/tG59Lnr8VVCV/7pGppFYtz/aU
	 2fkDVqiWdpEdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 213CB40509;
	Mon,  2 Nov 2026 22:32:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 040EF4BC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 21:28:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9C8140539
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 21:28:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pPSJQr7_GzMB for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 21:28:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DAC7A40525
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793654897;
 b=LIn8NGb0C0tn7E8ZS5IJ+9Ri7Hm0enqd7k18bgMTh/9obXsnAT/JXwRsvSED50Fe6Z6j
 HUo4kFUUKeiXBX/yLzpGdg2QXwiJ/g8+snrWe0YfOteVlD0O+Rs8FcNZWKcvLheTnURfV
 qiQbpHorsgoshM7+vBzjMPe77+8OAn21Gr2g1k5byB/MGPzuW0qN6Pc+80YIrPZfq8vs8
 4lECyMtlpce3kEwaj7JrZ+R0Y59JsSuP7fJOQ81cUesrIKK8ArIt7QkW4dmWGkOdwF+5w
 UqzMSgHFc9AUvtOWj6kr1P+0HUWpS92FbWPhXHhsDCLIpGCyCMcTgbvY1cFllr6Wp1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793654897;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=05WhMxae0rz15h1TGq0mYQ3vTYNApMzOi4Y++NBdM+w=;
 b=IIRWlfqoWqTmV1WyxJxbQw/OS+73GVMaIgFsfkxkaFKphZ+nL76FoGO1wNg2D7GDWQTT
 8Pw/a/O+6RHhg3WwlOzaJd1v77DSEnD/mRceBiLQDzbQPfJ68lvOXjvV26PW93E+6CaJN
 WiRgykDjoB+rhigMXDCpVB/nTfIl9M01R0uTLCgCABnlhU/qMfBtxcNq6/uARoldtORT1
 TU4qTlEGjUFNpJd3r6XWwZZrrym+ST/aLHTZyoCQmBevEQzsCGZHNbYwiPfo/tWdq/Na9
 z6ggGTHaCT0fxgK3w5fEU5qSb+6wtGYX+cv71prdu8zLxagD/r4KbCqP8fybEoAYsag==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=none header.from=x6u.co;
 dkim=pass header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256 header.s=google
 header.b=mP0tyFUT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::132c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com;
 envelope-from=dhu@x6u.co; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=x6u.co header.i=@x6u.co header.a=rsa-sha256
 header.s=google header.b=mP0tyFUT
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com
 [IPv6:2607:f8b0:4864:20::132c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DAC7A40525
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 21:28:16 +0000 (UTC)
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-36a18fc7a38so6409975eec.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 02 Nov 2026 13:28:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793654895; cv=none;
 d=google.com; s=arc-20260327;
 b=mI66axJkaK5Wk1gN963c/IVBfVgzJm3IWmpaDGjYTQApBuyBq4xAsnzGVGelkpByIm
 Fr8/dSrFrvwrUwww31f2P7635op4a/IRBGnRsZeNZtVGmf4cPQVqQuoqwfNoTD1z6EZe
 zkkEvxF/hXpGYW++S7kgGDvgSqIBYPqdslPHWcu8cxPS4wm5XJ9MxfR3ZqfRetGAp2Wy
 8KZP7LuuR1K7tXkfWVhflincyfwX1A9d8m1VPhYCBmLkPIMqdsr/mk3rHMljZIaHIigd
 FFT34Llj5RI/zaZAVDBh7WKB4KvyV5cbk3j4hE7aQ+9ohirYkmCzvvK9/ggK1XhGJnhD
 9OvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=05WhMxae0rz15h1TGq0mYQ3vTYNApMzOi4Y++NBdM+w=;
 fh=/qU+yrYvr4MDoF1NVWDDCongjaKy85ReHk7GnUSfThw=;
 b=fNj392wUFaRMiTPiammq6qeSA/aDqkTl9h7qizyLiaoEwIsL92+AjCUHJ2ERMAd5tG
 O8+m9hTx9D9pfapxRgaQkiGgRq49+Z3x1/poK6fyljiPbcsB6u3/wwD+gUW0Ovz5hUdV
 4EUq4Oy0rRHboh7jIDObgRttiZrdbEmihQ/K6RNmMUdta2iXvxKOzSL7NTl4qn0FCRz+
 Vd6yVFF/up+Ba2Z4fcmnNkI8WYDIR/ueamPQ2MBzMYDEAYWzPyRom8faCUrLgtsltO6Q
 ZDtRCPcwxboffUxC2nFZog8+bbNlMbNtb1UaE1QXDE3MltQA20tFe4F1gufGjTzMLl7A
 xtaw==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=x6u.co; s=google; t=1793654895; x=1794259695; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=05WhMxae0rz15h1TGq0mYQ3vTYNApMzOi4Y++NBdM+w=;
 b=mP0tyFUTe3uS08idfCjxzc3M17GPrMsOrYiqeBPD97OUd56GuX+GIvqQadAGQgPIGC
 9KYb1HQvadoeidk32KepUG7MA6+DdlSUorb5wkR3VQ16DOv6DHwgq+AxkSQBd3vgavHY
 0r1SN+NUg7F6ODshscNpYol4nXyt30hwQZ++/3l8nCj+ytcBLn2LfJ2AbH6Qp6fTMLJD
 CSoqKtahoFxEWRYwK0vbJlWG67YACmbTL+nlu/T7oaGsf40QpXbOjcMHg7FuINTmsgAP
 /mDRARVAsVxF4GemExb/Bga0NXzs7p6/W6py4Qfg5cfOzFr3iUyHn+yRQ1liDq2H4FCr
 aIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793654895; x=1794259695;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=05WhMxae0rz15h1TGq0mYQ3vTYNApMzOi4Y++NBdM+w=;
 b=HMfFPRY4P0W/930mtXQ8TrkYs1osD3d4h+xgVGiEh2en/K8HrtsMKylq9n85G/L5Q2
 AzqFmEfSLU4vGQqIQwAM53Et+FX1RRkyCTZPaC5HdEsNJnmrviOsDTlSW37AGVTnxgod
 Kw7SfWi1iTqkfBe9mlpnyVGPZLddhudpcAY9sw1XxUhoFDZWaQD/jtyrLUT06dP2Nj8Y
 /ODYMwzTsx0rAL1hMEpeeRCjZRalLbq3acjDvXcgYnd94a+0/CP33LbHT97JyGR49oWg
 I8Huk5ciDltGekAqiBjg8JQcW4R1I22GmDghCTZymDH2GO0qiIqN1ybbEsBexrQbGO62
 r8Lw==
X-Gm-Message-State: APuU4Z/As6fXva1HE5ZEUxmQMj5Wmt86WTVzFDOHM4aE06BvQ3UGEgR+
 auzZh39tROOzF+YTZsY7ULiNZ75XGd1fEEW5EWeOWiEfZDH6OlMSoFJ5fvT5Va1ObsNG9hEOjAJ
 7JjDWSSasOgTvcQd8Jn3nBZspOALM9pX5SoVE2fO8AWk=
X-Gm-Gg: AYBFou1bvQpkaw3p6K4iP2us2atyFNeerTK6L2PGdPDtxbeVHGlyXhFIv+gP9FuMHFN
 Mjz9cCy0lGULYaOjPWHMUSpY88nuMF0s912H3DBk/OSp2pJJDqJ1JpuvvI1TM93C8xrc07Zb2hR
 FQbEBxGigh7TGZpvB/wIIzQoBHpA9yJYL0HnsifcCERrtxfH0DVoAKtx0s5OeaZXsh4TkOzZGrn
 N53amWxHVA1zlULru9k5Jl1MV12Cdz7Fv3/VhjDTARBSIAvHxYZ6dJGOcL+oybtC5ZKZWhtFOkC
 nN5g3T7QxotdiXo3q2GOcv8bosaGhdDhgSjUrYn/WUMpwB+CkCd1zv4LGhCuiyfk24zCL/aDmab
 t3VIb0hhS9yL9tWgr3Ad7uDNOv4m+BJBvtrzVOwxggZm2TwMRom5WU0R9NofetYhNDZzxkONDYc
 +bh1Pvm0x7zTawcQ/c71LWa91p+EgTCz8//ymbwbKoX7zC
X-Received: by 2002:a05:7300:a9f:b0:369:fb01:2eb7 with SMTP id
 5a478bee46e88-36a4235f45emr16292049eec.13.1793654895131; Mon, 02 Nov 2026
 13:28:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030181512.2056056-1-dhu@x6u.co>
 <20261030181512.2056056-6-dhu@x6u.co>
 <sashiko-outbox-191412@kernel.org>
In-Reply-To: <sashiko-outbox-191412@kernel.org>
From: David Hu <dhu@x6u.co>
Date: Mon, 2 Nov 2026 16:28:04 -0500
X-Gm-Features: AclHuK_7wNCsAnLumnQoSsGTieVm4sqRwJoszEVTk588c59ZDICEF5LaB7IXra8
Message-ID: <CABdL-LQPkSO74Fn+Cv1XxCmESq+7cNFG1-Km6FwqKYh_hQ+3AQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next v4 5/6] RDMA/irdma: Support UMEM attribute for
 CQ creation
To: sashiko-reviews@lists.linux.dev
Cc: intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 02 Nov 2026 22:32:42 +0000
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 2:33=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] RDMA/irdma: wrong DMA direction in irdma_setup_umode_cq() via =
ib_umem_get_cq_buf()
> --
>
> commit 8981c5869a8245f4b87a31412a16b517815f3a39
> Author: David Hu <xuehaohu@google.com>
>
> RDMA/irdma: Support UMEM attribute for CQ creation
>
> This commit adds support for one-step user-mode CQ buffer creation using
> UVERBS_ATTR_CREATE_CQ_BUF_UMEM and IRDMA_IB_ATTR_CREATE_CQ_SHADOW_BUF_UME=
M,
> sets up hardware PBLEs directly from the pinned UMEMs, and adds UMEM and =
PBLE
> cleanup in irdma_cq_free_rsrc() and irdma_resize_cq().
>
> > diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/h=
w/irdma/verbs.c
> > index 9f4905fdb791a..41e56ab8aa6df 100644
> > --- a/drivers/infiniband/hw/irdma/verbs.c
> > +++ b/drivers/infiniband/hw/irdma/verbs.c
>
> [ ... ]
>
> > @@ -2767,26 +2793,87 @@ static int irdma_setup_umode_cq(struct irdma_de=
vice *iwdev,
> >       if (err_code)
> >               return err_code;
> >
> > -     spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
> > -     iwcq->iwpbl =3D irdma_get_pbl((unsigned long)req.user_cq_buf,
> > -                                 &ucontext->cq_reg_mem_list);
> > -     spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
> > -     if (!iwcq->iwpbl)
> > -             return -EPROTO;
> > +     cqe_64byte_ena =3D dev->hw_attrs.uk_attrs.feature_flags & IRDMA_F=
EATURE_64_BYTE_CQE ?
> > +                      true : false;
> > +     cqe_size =3D cqe_64byte_ena ? 64 : 32;
> > +
> > +     if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUF_UMEM)) =
{
> > +             struct ib_umem *umem;
> > +             struct irdma_mem_reg_req cq_req =3D {};
> > +             u8 shadow_pgcnt =3D (rf->sc_dev.hw_attrs.uk_attrs.feature=
_flags &
> > +                                IRDMA_FEATURE_CQ_RESIZE) ? 0 : IRDMA_S=
HADOW_PGCNT;
> > +             u32 min_size;
> > +
> > +             cq_req.cq_pages =3D DIV_ROUND_UP(ukinfo->cq_size * cqe_si=
ze,
> > +                                            IRDMA_HW_PAGE_SIZE);
> > +             min_size =3D (cq_req.cq_pages + shadow_pgcnt) << IRDMA_HW=
_PAGE_SHIFT;
> > +
> > +             umem =3D ib_umem_get_cq_buf(&iwdev->ibdev, attrs, min_siz=
e,
> > +                                       IB_ACCESS_LOCAL_WRITE);
>
> [Severity: Medium]
> When IRDMA_FEATURE_CQ_RESIZE is not set in
> rf->sc_dev.hw_attrs.uk_attrs.feature_flags, the UMEM passed via
> UVERBS_ATTR_CREATE_CQ_BUF_UMEM backs both the CQ ring and the trailing sh=
adow
> area page (shadow_pgcnt is IRDMA_SHADOW_PGCNT, and irdma_setup_umode_cq()
> later sets info->shadow_area_pa =3D cqmr->shadow from that same UMEM).
>
> However, ib_umem_get_cq_buf() in drivers/infiniband/core/umem.c hardcodes
> DMA_FROM_DEVICE instead of deriving DMA_BIDIRECTIONAL from
> IB_ACCESS_LOCAL_WRITE:
>
> drivers/infiniband/core/umem.c:ib_umem_get_cq_buf() {
>         return ib_umem_get_from_attrs(device, attrs,
>                                       UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
>                                       uverbs_create_cq_get_buffer_desc,
>                                       size, access, DMA_FROM_DEVICE);
> }
>
> Since the CPU writes the CQ head index to the shadow area and hardware re=
ads
> shadow_area_pa via DMA, mapping this UMEM with DMA_FROM_DEVICE omits IOMM=
U
> read permissions (and skips CPU-to-device bounce buffer syncs).
>
> Should irdma_setup_umode_cq() use ib_umem_get_attr() with
> UVERBS_ATTR_CREATE_CQ_BUF_UMEM when IRDMA_FEATURE_CQ_RESIZE is not set (o=
r
> unconditionally, as noted in the commit message) so the buffer is mapped =
with
> DMA_BIDIRECTIONAL?

This finding is not practical.

The AI finding alludes to a very narrow scenario on older HW (Gen 1,
iWarp) without CQ resize. With iommu on, `DMA_FROM_DEVICE` leads to
lack of IOMMU_READ for NIC iommu group, and leads to iommu faults,
while NIC tries to fetch CQ consumer index from shadow area in dram.
This will only happen for VA, since dma-buf in iWarp is rejected.

However, `UVERBS_ATTR_CREATE_CQ_BUF_UMEM` will never land in kernel in
case of VA, since `fill_attr_in_buf_umem` (in ucreate_cq) skips VA.

Further, switching to `ib_umem_get_attr()` would also mean mapping
DMA_BIDIRECTIONAL for cq buf for Gen2, and Gen3 (when cq resize is
possible), defeating the standards established in ib core.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030181512.20=
56056-1-dhu@x6u.co?part=3D5
