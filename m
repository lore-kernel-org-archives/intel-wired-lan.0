Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0105BC55838
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Aug 2026 12:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A59BB6072C;
	Tue,  4 Aug 2026 12:14:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2i3ZoMwJVF2y; Tue,  4 Aug 2026 12:14:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34B196066C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785845681;
	bh=ms6p7ER/WG9Qjzd8gnC+OsGxIvYrtwElhhEqL7PK6WA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4/HjvOMF7GbVhEyBmDX97c6tdYslMST6hW697sDvUhuPncR3WjLr5+ORurcB3LGAT
	 C0FO0cwghlMMrF5wC3bSqzFp+HyjhlK0l5w7snHVPT72v5dWc3aE99dqjVMU+iJ43t
	 flMmkjlP3+qqHT/stlPBsNO3TvD+cxmrp3HlX8SVdRMCEHfbYEBRcN6xLtNsILWC0i
	 nc7TaW3w9V3FzkI2IsS+bPJ9SirSuSIEVVa0V9MuTglGvYgILgqbAK6+OOpRuvVpov
	 neanyudmyKhGts00tikGPiSxt52j4DfxWYja2vl/rrQw+tItNywAL0dvaeDEtQz50n
	 UnmIPNBvQcRPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34B196066C;
	Tue,  4 Aug 2026 12:14:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DDBC218
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 12:14:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44374400C7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 12:14:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ww7jsnR-XSqZ for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Aug 2026 12:14:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::234; helo=mail-lj1-x234.google.com;
 envelope-from=kerneljasonxing@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 68D2E40071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68D2E40071
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68D2E40071
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 12:14:39 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-39c7fd45465so38511651fa.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 04 Aug 2026 05:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785845677; cv=none;
 d=google.com; s=arc-20260327;
 b=o2y17WTCvVHjmgpOilOuNfM5ltHRrmoUR8qMrPd1gNa8afqSn+lORe5aZjJE/nFMCx
 jV/fYo1nmvhS5GTvZ8SRy2k25BfOuEwfM52QnCbRABKhpfnziaq3rKKwmqfrcBJ21A8r
 t10GUE34LKQjXqrGLqUJFtRsbWoWVwK4UHAHQM9iImoxPA8VKyQNLKAyPkbpdPTk0V/p
 zK2HJ6JZvV9R4LfOKDtAahzNbEfWbskWUFkYGAXGObCYs/Dm5BQ4xJuxsg7e64/LozTB
 PGSPBM41b7iHci8ZctoTWzcs/HrmfdAThPf2liYKGVZXQbn2n2ezc9OBwR2K9Dr2MDda
 a3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ms6p7ER/WG9Qjzd8gnC+OsGxIvYrtwElhhEqL7PK6WA=;
 fh=LjrHcxvzqWuN71lBahaM/OfVIjwtrfPz5KbDJf46wxQ=;
 b=UCSZid35/M9JH3VWWqUHQyNvgzj8EJ7iIJoFYWN1nvBkHn1kH4b5ySABpK9uFsvuD/
 XCW9C8T1ojO5KK/0OetojR1++Fv6j5to7uYoGV75MxOVK6p6+brRU81aJo5Q/PKnvFpj
 JfUft8xqQXGiFbTXltRb3hfhB9Wh3dGs2Mohh62AUxT/qz4kFNElJ0rMI1bUl0lKEov2
 7rfJlMd1It3qDUOIpxKUZynfedy9ApifMI5Tb9ANyM0zLFIeM41nj/i4UMIeJItkBSln
 ZUyaUFu9mXutekLSoNba9tRnGShZlYQZRXOX/sTpyHXLUfvm+tw1TSbh4akAdDAnPprf
 t1pA==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785845677; x=1786450477;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ms6p7ER/WG9Qjzd8gnC+OsGxIvYrtwElhhEqL7PK6WA=;
 b=F4Mo0LhrZ7HJtrfHQpCNs+JkTORWE78Osf1Bbsv+7vYwNB0AJjUR7blGbId/J4dZ5v
 86ahtKBYPYUqM0OY41CzlesonpoZgZBlyi/Yu2ryDXHid5mddxo3skdx8fTpxnG7T8EV
 R89Mpr/Xg7B2IYZqFx0+OjLiXwtXZJt4yaSUlxTNGHaHN6xMvdx0EhG6vmi6+q3c/RIW
 uL391m7Iqp8n76k8eK4tLzec/bkj0UfVeacaM65/gJchMmXGPlAtKlNaxLADDjnxsvWn
 aTYJLV+TPAubtHdb+InSayCrvkRe0EWKFQP7Gj3oza9YTP2NgFzbvbefmluwRCUQouXw
 PKWw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7XDfOFU/GusDS9JDMyDuo39TykEY5mrOL/D/zNblqF5K2rLvEGRmp9H+MIxI2RbHN9iAtlHteTdVdIiAr8rQ=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwvLbObHLNjpMw1Hgf1BDc1KjHK6UYyic+aOjtH2QVUtTtvRbmI
 09rpH09qmtBJ9fGOrhH+VOTd49jfG8T2dRthW2pWtST49/HaUkinXqt7B6f1xAOldXTG8o0LnCh
 dwQigVAFBSstq/jYzySl/CpsPTe3oNvI=
X-Gm-Gg: AR+sD10IpHXd98DoGBDqlcQiMq+lCVnvE8eWxXrozVsWt2CfNvaTcc25s+y7Q8TRXta
 ixjQw6Hf871kH9GWcJ5rx/oTNhRwvpcRvmbCjvKlKvmoAmwsTbus9PIbUzb6vQrr8de9QPkiKEn
 3cOGDXinQmR55d9NC4/lOKNdePYKPzWE04ufTCiahjGaGsFTYhFF04kK0Qm3NixydVczjCUtJSW
 ESJ0OAoepMjk5UzK/eMDhW/7yysQkvtcP838eZrDU1ZkVy/YqQi69W7/ERw3il4um3ilhp2+OPo
 y7n3ysfW5V0c2XyH2Ex3rQ+fb28ivRD5NAKerRcH/e+PgnMbGeWlpM7/H7GmaiITIQrwMzQSN65
 1siY2SO+LXUxOzaXotrArKeBY0zs/IpwC2LyScuvGlY13p4qfhY5/12LLRlA=
X-Received: by 2002:a05:6512:400e:b0:5b2:a558:b222 with SMTP id
 2adb3069b0e04-5b2f0ce19c1mr609896e87.10.1785845676638; Tue, 04 Aug 2026
 05:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Aug 2026 20:13:59 +0800
X-Gm-Features: AUfX_my_EL6N_MS-28suKnKJLSuE06TW9KPNUI3ox4Goimy-hx0bTUFeNm2fQ_k
Message-ID: <CAL+tcoDDRQz9KJmABC3R+CzVxiS70r+-0=aB86yDdrPHU1EPRA@mail.gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 anthony.l.nguyen@intel.com, joshua.a.hay@intel.com, 
 przemyslaw.kitszel@intel.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785845677; x=1786450477; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ms6p7ER/WG9Qjzd8gnC+OsGxIvYrtwElhhEqL7PK6WA=;
 b=VJSNzNwM/3LeMiKSh8f0esUmnunJDF+E7TH4M+szWMDF229Grg2CcEkKj9ntMisiDI
 ZBYSwnn9uSOm3uqe7PsTcgZ+TuOxwF9e3S7bPdsn/VN8okHOspNUzLRKpjVt+8ifgEEr
 4UeUD4zR2jh3+II+fEoulDiTiTAgNAsMF1YDL06kXyi+TFPh/LDK6In7C6Q2fQuawA+k
 oEPNZXRZTdq/aGHaLKOXtyLTO258cPF518p4pcpE7fIZMfkgYuH2jCwZ72vxMoVdqfYC
 W3VD++aued9gq28+ktQbrQfonlFKZo1Agu+SSnI6hL7ByqqAbAzb0c/XTdCk4IP12Npz
 DHEA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VJSNzNwM
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: add missing
 cpu_to_le32 in idpf_tx_splitq_build_flow_desc
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

On Tue, Aug 4, 2026 at 5:08=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
> to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
> field in a single operation.
>
> Descriptors are in little endian. Add missing cpu_to_le32 and cast to
> __le32 to ensure the fields are written correctly also on big endian
> platforms.
>
> Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason
