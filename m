Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEA0CA600D
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 19:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DDD3813F9;
	Thu,  8 Oct 2026 19:16:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5wzCPx7jDFom; Thu,  8 Oct 2026 19:16:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C331D813F3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791486970;
	b=KR6kCIEjGqQ35PzsgvrNToEhNoPslnBP9Tltm1IDFUDYvxt19Zlc3d6Mg76zlAzf64PE
	 nanIYPi0jvqdvzgnAcfIZM+O1MedlcpAIGVGloEW5EB/DB9eyEarKLr0mm2arlMWz7MV2
	 KGKbB74eePAhF4J9xXZ4h0e/nI/ivgsLcjHLhbgxClg8pVOht3k/yb6J85F+LIvnvlU5u
	 hAvNmWaRVgeEMt7Z/LanzeGnMf941qgr/W5qjQMkbz6DyOPIA+nRRUhMShJOarqqZ+1Yi
	 5tyGU4v0ozY4NntLa9cqflBpDHCR8Z2fZDCF0zRMNfSWfz8/26kxq55WMnF+VrxPh6A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791486970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vHNgfkuwp3jFs7mDECGk1Qye3hSH8mafgl8fIqaQf2c=;
	b=MUlI3m8e3+OuE91r9Y41DhS8/XMYWigsKP3uSumFE0CIlY4q3Hpa52ynDJNFTD0LPOTI
	 kWzP5C0uSYNELqYrc2ckQpoL5SXPftymfPXFlcFY39EvKcV6gLvfaVKzx+Rxn1T8x2QZR
	 Sn0gky6ODeyhoKBj2pJOG9hLQOnzwLv4ee/BUZQov3+I4/LK+JsZqwXzfrDf7Xv15f8Fw
	 0amHk+qa5nJ/FNJYrXzjreAohyeLAeA2+/8t0vd5WrPogwYfLu5DT38NFS0Xt2Rr+QFvd
	 CTyxSI5WhVtFK5CsHfrktum0G6kbTI8mrbhPgCqxxv97xcT/Kkd0OB7NZnN8UtNYX/A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791486970;
	bh=vHNgfkuwp3jFs7mDECGk1Qye3hSH8mafgl8fIqaQf2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N7BFVFNi/Is5gBJr9z3RAguBXvo8oJyYnMasfzKugo6b+7HisejdhCt0IuVC3U349
	 EudXBwHkVl+DPyhEgeGC7a8tNBZs+x9LhNc+1kJxDPKUQg6s8Dmf4II76kI7S/pwhw
	 VWHAmo+K0vIRWolg0Yg0xiYGOUEqkC5c75DKBgl6q2dbQ8Q+h9f+chu1Lvq4wEZQ+f
	 XkKkrCPRj6uV6NqkVlKZJG/pCy7Vn27zI3+7SHr3SXkODRx06jLCTVkMor74ksHWGP
	 YEAPmcTNJdo9qKGSQlBZIhwzcNgg2pVvzCtdAD0QyyLUuHQuX2awmykOxRDLGj930O
	 6dnI91DLaudRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C331D813F3;
	Thu,  8 Oct 2026 19:16:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 64B4B1A6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 19:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EE8860832
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 19:16:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id myOEzRUZgJ09 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 19:16:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4A7EE60670
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::230"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791486968;
 b=B4M7QXnD1ae7F+ymk48DJEtqmxqWqVRAzn6VDo3tFl1Hw1yseQtnYnxoWzKeh03dAL9d
 rJ67c2VjH8HAIcziePpMzzrQCQeszBLDn9jaIKnUKefZPa8SFeKYYMz0rQxfTvJVWJsav
 BKgTaSwScCnEklRyqVOe9b0QqcRgnHzptr4vgsG48wXLXpPaId4CKuMwZmbBlXrV4SVID
 t/ruTFSRLsGOw06aFck24WjMCEn6dOmCpk1TwC4Ahsxi/k0caROl18mDTfiWpQVJqmfCN
 UpxN1Jw9otPZBLu5fXbW/V5gsVUbnW9+HNSQzswMAluUiwxCb13Kdcp7xKT26DjLDlw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791486968;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=vHNgfkuwp3jFs7mDECGk1Qye3hSH8mafgl8fIqaQf2c=;
 b=W5fDp5yyR96cHyOYeWpeIvfeeLaospGzSspRLHlPYqjx8FF7vadK4ol+m+rw7AaCgvXQ
 po253zGE3oSUWDff84efldu/j/k66ov3dWepzKwT3Mi+A7HHY9ay3Na5zF5ae5XEoXX6l
 5xXgR6Z8cph8TT33MTte4++8fYPTgGCFWbthkU95QKVOGaZ9Qiwff7o1oZW/sStUEUGPw
 5uZd/Ea/Z7r+jTEko+zk1ZlrB4UVmgwxuw6I/yFoCLbDk1Tbxgb4+MPn4b6/zc2Ex9ot+
 p/iUXQYGPriRCkfWsnGFQnDGmj78THSNnsBNWE3z373nEnP3rdscSDvvW7LoP2G6FLQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=uWlvDoOH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::230; helo=mail-lj1-x230.google.com;
 envelope-from=boolli@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=uWlvDoOH
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A7EE60670
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 19:16:07 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-3a777d4f321so30026851fa.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 12:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791486965; cv=none;
 d=google.com; s=arc-20260327;
 b=As8QmKQp7T96EZD7PKGtUGdMtCZ4VoDbsPc/7H7jBWulTwBhaNbfciMpVrzDzh+CJ2
 H9mM8WT/v7vMoAW1QTF4m7cTxr48grhPwLw1ejf6zPHBrlfXStDwLJpNg4mdwImLrkSY
 WOdhMANv04o7NqamQTbLm+8vGyCUmK7DnIy8A3Od5BIHoLmF5Ak7IBkv1nAF/b9z8Mdb
 M8Rsr3es4rHJmBl357f8rwW1/EzZmDmzis5Nulceg1dNPMlfRNIioBDUC7EZ757J083r
 1LkveYHQautyNIGuoGwI0uhcFWbTDeZkIyxZnvCXAVPceiQ4d1DIIwWt9CXfTyF45rsa
 2gdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vHNgfkuwp3jFs7mDECGk1Qye3hSH8mafgl8fIqaQf2c=;
 fh=i3ubD1xvrG1VqYIqS9OZqn6+5xP+VwQMX7iWDn1mLQA=;
 b=IUeNTdidESR+RfBS+g8Aed2I1Nqte+/xIDPY6CIhxGhX2BFMJ0fI5C3YEZ3vaKFzzg
 PWJp6koC9lj/mwa3NXa2+c7VjDlpMtijYoIv+arI+2yqKVvsAgiDfuBwvfhxg5BBMF2V
 D5Lbu9/6ev90YQF5HGU1gTwFhXv5bONC8PmxuSIWKFFGVlmdwrotepYkXnUbAZnaKelH
 lKLkly7h2SU2X01B+VZxCvDLowUD4m3yhKLyIxpFFE9577FOa/Csy8nOuhvCFfNSqRWz
 wTtQPKHKtV7ZSH/4UL/IJ3WHFu1HdLRVDYvLjBa08NDRNg0b2Q3Js0vzfyY8qTvZbTgM
 bPlw==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791486965; x=1792091765; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vHNgfkuwp3jFs7mDECGk1Qye3hSH8mafgl8fIqaQf2c=;
 b=uWlvDoOHNawxaJXunmHJzB17sAqAIfYpo6zmFNj6wQ+8pJdu6qI62MeXijrcz10/Rs
 AGir/Tb0BlOFzGQ57Fv8gY0BEWEmDXW0ILShwyv4CxuzOZhc5CO36ZcvH+HsEs3dxIR1
 3+PiI6vJLJPKKpMEFVxOeFB9N2zfaFKY65ymD5ZJ6C6beEkvxItFZt7yVmeSezvNfT77
 3u1bQuQufBbiP6LuwpkxNZe1fTnyBbLxVewqS88ZoRvQ5/ulxw2OfTR63pRm1ixT/i3P
 HQb3YGyV/xeVCo9/Nf7U/nXaVYL3ec6Yrip7JbQSp36OBNUzogUlOTryhW5Kt4SuCJTY
 NwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791486965; x=1792091765;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vHNgfkuwp3jFs7mDECGk1Qye3hSH8mafgl8fIqaQf2c=;
 b=x35GPHfNV/q55a/Ib2iazsUCQ7hP18n5F8MX+ZDpaDtdr77wpzDeq8BkiKhcTdB1NV
 tMlpg6+rH+OIWVB2fWn+Up69hf/aq+94RJL04E56K1csEvQAfNAn8vzwQusfniLogA1n
 upZzU8BTVd9aKx9P3MQxMC0ccKQ1a2lY9TS9g1fsZ1yx0SWuB/U+EmRMh2Uf1l3YoaK/
 DwETN7CaTzDfczyLK7XkN/MP4d+gDfrEUbJ7Mck7DgtfNSBaqv8eAHNQwJzGNst6+eOr
 BOb6mIERG+3uhCgTJBWmnHze4mh0Juc93+Cwu8NgB2sMESm7No9ZtRebIZl3gwjTTX99
 bnlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrARaiwnDYBTwgwjyrFYZ2bkkt+77pAb0S6ODEfnjZDEAoHjk8TUgcwvRPm9VJ9wMyH4u7zWJ4J4w0xt1sUTE=@lists.osuosl.org
X-Gm-Message-State: AFq9FYIKzCurzFKJwAfr8yKmba2aBs2kPUNVF/HBOR7uCt9H6yOAmyBr
 6l0xQQJRnjfFpquJ4svPx0S4W1O5anKFH8m8VF2mmVVAOHaBH6qedqccqNfijgB4zIj8Qr5riCl
 dw3xV856yNYawJ750BHReR1qxcvl+fn3yxdFgKxZH
X-Gm-Gg: AYBFou0Wh5uvCSCMJCv1K3zEI6dg0FdYgdBGDoBYMR7tNHMBTWA00/P6a13aA0qOIJl
 y9lU4CtzGiEMs2Khx7h8ph/TkCdVW/aKiPiD0uXUquSmdIWaGHMvoTjWbdJ8WqhXR8m5wzMtjPx
 z9BOg0+1Ikjy5JpHx5+ZRsPXhLtzKAQcXzbXzPM4nOC+ofBxgTnKDscpqmzPUdzCo27nKP4fqJf
 AvSO0UvL0Jg/ftkx3SMmkaFS8GgoQYOZ9DUk+vgj26DxQBli3E/+JK1cQsuIlEzKYvqzMyHBLEH
 cGpkHzDVkAyVukkLfEKuXU1BUtoNGZcjz1wd9lun+ignxUS5M2xw8VLZItoGd2FtLh5x0GYH5Wv
 FUNDDV1sGsm2Z3Zklx7TtEQ9g8Jh7g9fgcsF5cSzMsQ==
X-Received: by 2002:a2e:a7c1:0:b0:3a9:849c:b169 with SMTP id
 38308e7fff4ca-3a9a2ccce5emr14774661fa.26.1791486964690; Thu, 08 Oct 2026
 12:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20261008173334.2881475-1-brianvv@google.com>
In-Reply-To: <20261008173334.2881475-1-brianvv@google.com>
From: Li Li <boolli@google.com>
Date: Thu, 8 Oct 2026 12:15:51 -0700
X-Gm-Features: AclHuK8hC5pBINOHNd6sNHM56enXqSpYjYbwB1ohtsEoxneiKD6Ai1AkI3QhDQY
Message-ID: <CAODvEq4UbfswP9fQdbjOvwiDE2bopLPxiBHr-5+e40p=OVpkrA@mail.gmail.com>
Subject: Re: [iwl-net PATCH] idpf: wait for the reset completed state in
 idpf_check_reset_complete()
To: Brian Vazquez <brianvv@google.com>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>, 
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, 
 Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, linux-kernel@vger.kernel.org, 
 David Decotigny <decot@google.com>, Emil Tantilov <emil.s.tantilov@intel.com>
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

Reviewed-by: Li Li <boolli@google.com>


On Thu, Oct 8, 2026 at 10:33=E2=80=AFAM Brian Vazquez <brianvv@google.com> =
wrote:
>
> PFGEN_RSTAT[1:0] / VFGEN_RSTAT[1:0] (PFR_STATE / VFR_STATE) encode the
> function reset progress as a 2-bit state, not a flag:
>
>   00b - reset in progress
>   01b - reset completed, written by the control plane
>   10b - function active, written by the control plane once the function
>         has completed VIRTCHNL2_OP_VERSION
>   11b - reserved
>
> idpf_check_reset_complete() tests (reg_val & rstat_m) as a boolean, with
> rstat_m =3D GENMASK(1, 0), so any non-zero state is taken as "completed",
> although only 01b carries that meaning.
>
> That only works if hardware moves the field to 00b as soon as the reset
> is triggered. On the devices tested it does not: PFSWR transitions
> PFR_STATE to 00b only when the field currently reads 01b. When the
> function is active (10b) the field keeps its value until the control
> plane finishes the reset and writes 01b, which takes a few hundred
> milliseconds.
>
> Consequently, on a hard reset of an active function
> (IDPF_HR_FUNC_RESET) the first poll sees 10b, returns immediately, the
> driver re-creates the mailbox and sends VIRTCHNL2_OP_VERSION while the
> reset is still being processed. The control plane tears the mailbox
> down underneath it, VERSION is never answered, and the driver sits in a
> 60 second virtchnl timeout (-ETIME) before going through a second hard
> reset which then succeeds.
>
> Make idpf_check_reset_complete() wait for the state to be exactly 01b.
> This is the stricter reading of the register definition and it does not
> depend on how the field got to its current value: functions that are
> still in progress (00b) or active (10b) keep polling until the control
> plane reports completion.
>
> Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
> Signed-off-by: Brian Vazquez <brianvv@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h     | 2 ++
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/etherne=
t/intel/idpf/idpf.h
> index 470bc23c844c..ce8a1bd0ec8b 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -166,6 +166,8 @@ struct idpf_netdev_priv {
>         spinlock_t stats_lock;
>  };
>
> +#define IDPF_RSTAT_COMPLETE            0x01
> +
>  /**
>   * struct idpf_reset_reg - Reset register offsets/masks
>   * @rstat: Reset status register
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/eth=
ernet/intel/idpf/idpf_lib.c
> index 2c148377540c..a827e0fa67c8 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1870,7 +1870,8 @@ static int idpf_check_reset_complete(struct idpf_ad=
apter *adapter,
>                  * register for us yet and 0xFFFFFFFF is not a valid valu=
e for
>                  * the register, so treat that as invalid.
>                  */
> -               if (reg_val !=3D 0xFFFFFFFF && (reg_val & reset_reg->rsta=
t_m))
> +               if (reg_val !=3D 0xFFFFFFFF &&
> +                   (reg_val & reset_reg->rstat_m) =3D=3D IDPF_RSTAT_COMP=
LETE)
>                         return 0;
>
>                 usleep_range(5000, 10000);
> --
> 2.56.0.385.gd3acb90ef8-goog
>
