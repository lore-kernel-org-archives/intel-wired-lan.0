Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B65CA600C
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 20:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 101E76069C;
	Thu,  8 Oct 2026 20:43:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NQ0Ehz7XyT5X; Thu,  8 Oct 2026 20:43:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 26C8D6084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791492227;
	b=sW9wLWFr7jZka78+ZKYJUwm2zd1ulBA4QMsWDrcWtt89hpMf2xhOgdY0XWCiMxBlQFPz
	 pjx0cz/AZ6ms7Pqw/shqMN5vKhydoUxBh9LyrVndvG6DolCUXNG3vseUbzGPFhIbNOF0B
	 CTl3ukaJJpW8X6M/zUaG0cI4ZNmTVakIuWHjm7DL5Pa/LyiehRZxbrfrkufXECRQFcvdM
	 zH2UdAO6emNCZUY8Nzgda58oxAlVYJw0HtvP6XuqHxkcnJcy6UlqXb6ObhZ7JWeUVFMVY
	 ISb3y+mIg43nq3oLIt+By+XVA24lEpVfX4ERt6dHB0Jtvma8slEa+1AvEaTuW20C26Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791492227;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A/W/PUrtn/Cc72CQ/8yShHdG2SRzclcrVf4wdHjhRnM=;
	b=AAK2Eud40Lp3ispvWHSQ1a5FNArAuAMgNaw06G6iN5d5OdCazCn+q5y90/qSBeqO5MCX
	 g9DtACeL+SfY+D8c1b5GYg3aweaVGUyZF2MRxXv1DUZF8Agvyc4OpknJQQTiuVnm96QdW
	 TyIv1m5PfGdiltrRKdt7yaWroVAIvf/YNCbrc4pTjG/leqb95P+zAykYtXT+wK7QkpEdS
	 RapmDLwvkyHfyMdCwCdxRt0+JFPY6dTf4i07NhnuPa0F5obGT5TLMNhJSM7QbIfFCpc1U
	 U9K3GJIk1mzI2Qq98N9bIK04E8S4SuGxxjNTzzh/rE3G0RXQB2LwwlFNAAgIsODeY1Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791492227;
	bh=A/W/PUrtn/Cc72CQ/8yShHdG2SRzclcrVf4wdHjhRnM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fH7aDGZ4P3qiv6g/OpEPoRWL+LkR38S4F1z/YT88e4JxLGxt2ft5HzKE2iZwGrfE5
	 XgHqKbtVVsEGF/w8KWY7Lfdxk+hH78xH/1EAsNPObRLizLFerkBG1By4O7ZyUT4hGn
	 dmYEEerywiG+QNtByuvprMIf2XNiC42Is5pkbOErXQ0nFvnhyKXSr0/Z0z+cneHGk0
	 BKNmwonIbA/VWzn+hhT274ZC01WnCueAHrYlmoXIAMPjq94OunAstyQ1220kouppUk
	 H5knDOW7Kr93bDgnnm6EARDt+EJn6PZT804ME+l1ti+ZTUK6p+GabuLun/SW+Bk4eo
	 MbfpRKGMgDupQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26C8D6084A;
	Thu,  8 Oct 2026 20:43:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C8D634E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 20:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E41B403B5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 20:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rQY4OSyyQ7xl for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 20:43:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3BC144032E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::929"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791492224;
 b=AM/glRG/httb4itqQ2fTxntqe2PSiQE2S2swqWFfu5Y/VAmOzy5CMXPBtWF+aq/9UgoO
 sX5OntDi9N15bJJhX41q2mRK5hqDLYa/i/PzqI0eJFXqa8Diln/zMZS5xPPc5wpliOWNE
 68vNpYR6Y5Ush30YT2nJYFxE+1zJuF6wMEqKQge+hDhxtGpVGNuEziYbuZNSXZSodBZVn
 50I9dp4Tr0sk4jSUEbwvPMNK9rY1yhrWsiCsVAN924fb1utNnKAv8lr68SYaneINqk0d1
 PY22mJi5k0IYUr49IFB8JZWi9TS6PR0OfNyap1taP/7q+n7+Y/VQerILDozH6ifz4PA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791492224;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=A/W/PUrtn/Cc72CQ/8yShHdG2SRzclcrVf4wdHjhRnM=;
 b=Pd5QfrD1c1YlErIiJejQIEtQzIUpehWk8gfk6VftbZHEosqZ4pZMXUoXsrPX8Q+TFjmZ
 +DAPQRdAxZLqxTBP0VApYDSYUyYQNmfIJUdktsu8780qc3tkFl6/7K3CthNTvt3djTcE9
 lDa97yf9OqGy3GGwHnDcq7h7rxtqUpJzts8knen8fgnVyRCebrMJyHs3Pd7iz2ECfwjgK
 E5YnNwxT4/fm4T6zkOQhxmOOU+4cmKmWqWrbfBEqfDtlU7BuoeMK05xfrUjEfKhD+J2yo
 +7J/daF1748Ttqu8WVHVGOdNnsWQM1efs8WO0OJmsLeo1TlbIx9fGqd3Z7k2Hhm2HvQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b="lAp86VV/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::929"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::929; helo=mail-ua1-x929.google.com;
 envelope-from=brianvv@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=lAp86VV/
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3BC144032E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 20:43:43 +0000 (UTC)
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-98929bb8eb0so1108707241.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 13:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791492222; cv=none;
 d=google.com; s=arc-20260327;
 b=FITpsstlXdeyDz8kNnp+WDxNBsttGD+4dvYaqog7PLVVVedkUO8VtOP8E47r0q+sW9
 BCAdx2AT0ULyoOq/iTb5vCETuiuCd4rwvc/l9kA5Xk5H+dO/PFWjvjVVJLLN+YaOOQtp
 dF8AvbYJM4h2sXAQEw4NuV7qZE9FSVZs0kaq2KIuMI0WMBVCLYgbuX0UErZ26iYxMBsK
 qDuM4xKXKsswSUs3V0UeFPd6n46PFf3Z1k50VJfhCreMn2IEWKr7uTXQ1t7kOfOI/CUf
 s0KAJ3sigCDzw9YhkMW20WMJXMe2Jqoeqf5b97BJO0TofGZf2Lg733D+9V/4C78orxMi
 2FpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A/W/PUrtn/Cc72CQ/8yShHdG2SRzclcrVf4wdHjhRnM=;
 fh=jLO1X/Xjn/5E5Nlb+IU4H5yNAi2IeZ4EcAxujArt//4=;
 b=BM/MkIsbypwah3UEXKt1fEQ5Kod0CO193/ZTcXYQBi/An5Y/mmrWA2D6U/NYI1d3NO
 09bhwSa1az2J8/mX6guYjyVvVl/T5PnBYZhFqhdjWB93lxyLvg650+s9eJTuJ8gDryIz
 Q6T1P0StYk3JP3SHoiPm0a61G++yiK+L1Zio/GnZiWIAY42neZ2B+RDptckog520SQNY
 ea701QlGtK2+S97tXfBlRNx6UbE9ILvj3k3cmA51O6fKqWCjdmnAYiZhKJ6V3zD6st2n
 diXHsW4URQdZKNTDR/A4jY898Bm6mbab1dZXGKvrv5bBEhU2GutCAa2zqt2hpxrMl+Cz
 IEXQ==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791492222; x=1792097022; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A/W/PUrtn/Cc72CQ/8yShHdG2SRzclcrVf4wdHjhRnM=;
 b=lAp86VV//MmPhwYPZIEKkE79SpgTLG0IQ6FsXyytzLWnpl7QYSNSTM0Zm4VxqyIl5k
 mBjAYmVZkATaVjvZYLg2AOdB+pTm3FcwxZj1dIphj25dl+Nt4XyBsZucU8rNGxwZtNhv
 JZysqMZYi/f6sU5/qlmrEnWT6ZPwLmoIVDKWbdUpIiJ/HRKS7E5llA0r7AKAIcHYUZ+k
 +2mdLZmf6Er/Vy/qf+bdwWmwGUVVMzbWZzKlJq2/B/Zt4byoUcWLfV/vEJ8GoEZSl91+
 o0VtFYIxs7EBfdGrbokeYLUDq3STqSlUdAzpxMtwgCSmZWDoRy+LbXz76Yjv7rfUFeR+
 2iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791492222; x=1792097022;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A/W/PUrtn/Cc72CQ/8yShHdG2SRzclcrVf4wdHjhRnM=;
 b=bsSekiD8976vDDJfvsiW9YFPDcSNyrRzY6MwnUC69k11LAFjeNelINa7OolJFZJyJt
 vS0KWDmP6QnWF88VCyMnk9D5GRB9ErYRKnegic1LzwYEjo4E8bDXBB9odWA0619bG4mz
 AsLrqYgTkDdBVt8EmJv2eoZxiRar1uBrxcweLlKKMD0BG75GhH8CBjc6h9I911FwEKcJ
 lKEhgK9YNGjAa4+zAjvdquk8PkHp5ssIXUA+Dw1bcSWvU+JmnnPPmzI9V6MDlz6eI1qk
 y3N2vc9y48xpZO2qHKxfOs09sz5nULgBDD4uEkVp62Ebl+oEjiFfAs30etCNd7JiQgHj
 sUMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwopiR7HaZ+mPJ8aMHvxUUMfVDe9ZeT+vJqkK/KUhnRswn5tpY3/RYtEyoPadBIplwtZcRUSLS1IlXM+evm5OQ=@lists.osuosl.org
X-Gm-Message-State: AFq9FYLTRQUqeRRriFs7ARbajfGoGOH+gZWhCjsIzhfgkx1KP+4w87z+
 XhKuhp3bsFUCL6HlcQ4FqwvhAmsZwiRgfiObYy/RN+WfsJTZYTcnRIMPJecNlCNTziCWPoYXoBJ
 4402G2f4M4kBzRv1gpTCMj/t1dTly5PX2GI57P5j/
X-Gm-Gg: AYBFou3cOnwf69nmPg69M56iSTxbUWY2i/2khRJQ47yhxbgGZkJNIGqtFcRXk22prbF
 sbqxPMuKYSuCy3R9dvl9RIaf4IXTOduk2c5LKOP91UMZG0Lu2ym47JRTmqi/LOGtOabJ1xMALoL
 UqubHgznhqx+31YDP2BQfNZgKsSThLOps4FttCaCF0RmorFpJkysF/dRNrzF3WQQhpW/rEYbFzv
 r4vg6uf5l2zBYm0mKqfmkD6opgzknPUJVkK2g9CoE3eN018uHauTJ/6sqbt0PIMy7mvLUY3GB0p
 payHmIro0VQ1dxka9j+yXxEWbxQEmZ8uGluT1kIFIRHnGnruubEkn/TUQmW5VOw9+gKs8F9MQjn
 6LwflQEJD
X-Received: by 2002:a05:6102:5cca:b0:7ae:c2ca:8e1 with SMTP id
 ada2fe7eead31-7cb37282493mr11701137.11.1791492221308; Thu, 08 Oct 2026
 13:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20261008173334.2881475-1-brianvv@google.com>
 <07ee6c66-034d-4cea-bce9-91c63a1aea86@molgen.mpg.de>
In-Reply-To: <07ee6c66-034d-4cea-bce9-91c63a1aea86@molgen.mpg.de>
From: Brian Vazquez <brianvv@google.com>
Date: Thu, 8 Oct 2026 16:43:29 -0400
X-Gm-Features: AclHuK9aU2BVIj9HzCVTcUiFNvmt9s4B0i7YOub1a2UyUu9MFQ1Y8cPTxsttm2c
Message-ID: <CAMzD94QiYANH2e-jr2LDD3yv4ojcArterT69k0aMBP_iZxtzzA@mail.gmail.com>
Subject: Re: [iwl-net PATCH] idpf: wait for the reset completed state in
 idpf_check_reset_complete()
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 linux-kernel@vger.kernel.org, David Decotigny <decot@google.com>,
 Li Li <boolli@google.com>, Emil Tantilov <emil.s.tantilov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Thanks for the review, Paul.  I answered inline.

I will fold the spec reference, device and reproducer into v2 and
carry them forward.

the Reviewed-by tags.
On Thu, Oct 8, 2026 at 2:31=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> Dear Brian,
>
>
> Thank you for your patch.
>
> Am 08.10.26 um 19:33 schrieb Brian Vazquez:
> > PFGEN_RSTAT[1:0] / VFGEN_RSTAT[1:0] (PFR_STATE / VFR_STATE) encode the
> > function reset progress as a 2-bit state, not a flag:
> >
> >    00b - reset in progress
> >    01b - reset completed, written by the control plane
> >    10b - function active, written by the control plane once the functio=
n
> >          has completed VIRTCHNL2_OP_VERSION
> >    11b - reserved
>
> For me it=E2=80=99d be helpful if you mentioned the datasheet.

The state encoding is in the public IDPF specification, "PF Reset
Status - PFGEN_RSTAT" [1]:

[1] https://github.com/oasis-tcs/idpf-specification/blob/main/idpf_specific=
ation.md
>
> > idpf_check_reset_complete() tests (reg_val & rstat_m) as a boolean, wit=
h
> > rstat_m =3D GENMASK(1, 0), so any non-zero state is taken as "completed=
",
> > although only 01b carries that meaning.
> >
> > That only works if hardware moves the field to 00b as soon as the reset
> > is triggered. On the devices tested it does not: PFSWR transitions
> > PFR_STATE to 00b only when the field currently reads 01b. When the
> > function is active (10b) the field keeps its value until the control
> > plane finishes the reset and writes 01b, which takes a few hundred
> > milliseconds.
>
> Please mention the device, so it=E2=80=99s easier to reproduce. Also, the
> command to trigger the reset.

Intel IPU E2100, 8086:1452. An FLR on an active PF is enough:

  # echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset

  [  299.685030] idpf 0000:01:00.0: HW reset detected
  [  299.715710] idpf 0000:01:00.0: Device HW Reset initiated
  [  362.916087] idpf 0000:01:00.0: Device HW Reset initiated
  [  364.318246] eth0: (slave eth1): link status definitely up, ...

Nothing is logged during the 63 s; the VERSION timeout is silent on this pa=
th.

>
> > Consequently, on a hard reset of an active function
> > (IDPF_HR_FUNC_RESET) the first poll sees 10b, returns immediately, the
> > driver re-creates the mailbox and sends VIRTCHNL2_OP_VERSION while the
> > reset is still being processed. The control plane tears the mailbox
> > down underneath it, VERSION is never answered, and the driver sits in a
> > 60 second virtchnl timeout (-ETIME) before going through a second hard
> > reset which then succeeds.
> >
> > Make idpf_check_reset_complete() wait for the state to be exactly 01b.
> > This is the stricter reading of the register definition and it does not
> > depend on how the field got to its current value: functions that are
> > still in progress (00b) or active (10b) keep polling until the control
> > plane reports completion.
> >
> > Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
> > Signed-off-by: Brian Vazquez <brianvv@google.com>
> > ---
> >   drivers/net/ethernet/intel/idpf/idpf.h     | 2 ++
> >   drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 ++-
> >   2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ether=
net/intel/idpf/idpf.h
> > index 470bc23c844c..ce8a1bd0ec8b 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf.h
> > +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> > @@ -166,6 +166,8 @@ struct idpf_netdev_priv {
> >       spinlock_t stats_lock;
> >   };
> >
> > +#define IDPF_RSTAT_COMPLETE          0x01
> > +
> >   /**
> >    * struct idpf_reset_reg - Reset register offsets/masks
> >    * @rstat: Reset status register
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/e=
thernet/intel/idpf/idpf_lib.c
> > index 2c148377540c..a827e0fa67c8 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > @@ -1870,7 +1870,8 @@ static int idpf_check_reset_complete(struct idpf_=
adapter *adapter,
> >                * register for us yet and 0xFFFFFFFF is not a valid valu=
e for
> >                * the register, so treat that as invalid.
> >                */
> > -             if (reg_val !=3D 0xFFFFFFFF && (reg_val & reset_reg->rsta=
t_m))
> > +             if (reg_val !=3D 0xFFFFFFFF &&
> > +                 (reg_val & reset_reg->rstat_m) =3D=3D IDPF_RSTAT_COMP=
LETE)
> >                       return 0;
> >
> >               usleep_range(5000, 10000);
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul
