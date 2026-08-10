Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB998C5AE49
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 14:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5769A6071C;
	Mon, 10 Aug 2026 14:00:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XZPi0pUpRUrF; Mon, 10 Aug 2026 14:00:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFD3860707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786370400;
	bh=46MZNjNXhKCE5DS6Jx+nsMAYwugJX53AXQsLnuBwmDo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YXAPusw8vb1wQm3lBGBhnMBbLsBDh6F5YtXtqUie458wvzXXOJf8YHEVFl7rCAtlj
	 GzvpvN2CDuXkbfLQ6N99zF3NEQNY0CNhcNsMjrjQvIsrOJF2IvbIFuCMPTBNY7lLuh
	 8TS94OWtFQN4Cxbfzekx8LDTx7K1j2PQNxfWQbrb9XgHGHP/AfvyB7oQI+cyB6zhDb
	 Pyb78CKMYv5Tf+j3wsbDMnyYD4TKpOAQ0iBvnRHIm/K0jtoslsRqOoLMCuOAqVKNa2
	 D8rzK7JCgfD2TnTNV7+toP7Si+R1e0dEG4iW6Df6KtGo7EzRG00g09N7gQ4RYXpgur
	 qdx0bL5TNlzQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFD3860707;
	Mon, 10 Aug 2026 14:00:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 812EC10E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 13:59:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7EDE7400A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 13:59:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x24fMRPWz6-h for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Aug 2026 13:59:59 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com;
 envelope-from=jhs@mojatatu.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B5F054008A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5F054008A
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5F054008A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 13:59:58 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84e04df8c46so1800372b3a.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 06:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786370398; cv=none;
 d=google.com; s=arc-20260327;
 b=a0y7+6T94GcQ5I3upnAmfFvFdhbIIIY4tx9ptPvmUlHG+nG/1b1SWStUbWs0Z4oIWj
 8eMrdbvPQIxYZ0viFW3+jlY8cc3yMz2foGpZCggdsnNWD56prjpEtnshQtc0WdUligom
 Ti7wXD4eDSJyBL/rBXYq4ycljTdCtXS5qJmJYDLJsjqvXC9v08YwMKfnypQgi31GSc+d
 h+VOwYiKIucZZTOEDjVC4Zq59EOKGc6WZYxAoMjIeLZGlyof70Hu14CV5Yy3qv0C1bDS
 9AOWaZVTxCUzZisg3sg+ouW3var3livSyLEW2FsubfVt7d2kgkNq6S7oss6oz/SaDggY
 rxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=46MZNjNXhKCE5DS6Jx+nsMAYwugJX53AXQsLnuBwmDo=;
 fh=SZDtgOgmAPVdXPBv014kG5UWqwnVnE54pyfLPZrJk40=;
 b=GDgBrmLidlNsscQf7agRyg6kJIwlzw+JDyv1AVi03QHzn79Yg2JmbCF3+2djAp75SI
 Xr3d2Yiu9PlgBs3kOtxNlgzvQ1Ayz1pBxCd98x6ww8i6KZyOoi0hvD2EEKPEcf8EmLJr
 eKP5cO1bQ59XPvgaBey2Lpy9iqWcGehtZMpy4fnjN6A3xVdivaCsPRZV2gv420z24xbw
 As4E2Cqz2LkZIVCSBX1+eP2uV6nWSWT2FXXighth4EiSPZuqzcleF5sGLH3k7sE7aghN
 b3hXgoNbZfG66hCZs6GJpGlLnX5Gm/MOyNiN6ev698/K5UNCMZkIWzvuDe0unwHUb5N4
 pEqA==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786370398; x=1786975198;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=46MZNjNXhKCE5DS6Jx+nsMAYwugJX53AXQsLnuBwmDo=;
 b=epuDlRKAYHvSWIbenndC8Uu8Q2AR+DUXBnVMNpv4c3ReKHvKl6H6nNCFMoBXHKaz0u
 n5pKLLjbaD+oYVEaAEkjofw0s1yf0XJqKbDBkmfuWGv57ZXLCUSK98rh0QN3DE1uxiOC
 OvKP2fZxLEBzMODusvlrdvWtppct7j9/Bu411Vvk5w11FSlv2wOgU3eh7lr2HaFlOEg7
 7/vXR+uqNFQt508nZr2y/LBDp6gWtk2Tl52C5eybFsAVa2Tcs7bvqmMYTZx7sCNa7d81
 IwK6c7sgL8I3vSzEcaOVuklRpXTOhMmt0nZDLJsVEL3QQl93qQsAIJ0CY+12emMUYWeM
 m7CA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rppf561nL6SO36WN7GHEyLKaIMcCVvypWDizLfUw+CBj+Qjt3g3WlBAg7HPUg4ud8lQ8cMeWmo1UyOV6q4QsSs=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwKIV9fW8JlKtIJ21ZWldthe6NcttpuQGvtZKNzEx7RnI/SuAc+
 k0H4hjQf1yjmKGdieRwmY/saL6WjefpyivGUV5P+jnWTjjA8HR/cOWDjcUdmqP19xL3WNPX0Qh0
 Gk8lQdLpvjVkJmKDVaSLDkoQs7we0rcv6/nPm8rTj
X-Gm-Gg: AR+sD10JSeuZQ8Qn9Cx8ea3BdO9AjGYOS4TV/SGC+W9Rb3rEsshPwk4sPPlOvNj8xFL
 LAarnJOnXBg79tiXYcnQe4cGKOhj+uM9in2nZhsb1BSE/zydv8NBamg7e5FB4TWe5dfmE4RJbZh
 Mu6S/zOxkuAZCoHC+2B6dW/LV59Ol6OykrnLUC5+AjW0y0jWRJkWOlDstdUpsbyQh+Joz//jPrk
 UendDxWek3j6Lrg1EHD2F3GHWwQj1eU0CrqeaADpBHtKVDTpzMMpJVcXXtWYy9jplOUqZFCwfgE
 lkBQRIMAHORYfjXtX+Fi0CBMimvmUnalhJKUST0wRC5vvw==
X-Received: by 2002:a05:6a00:3310:b0:848:5540:2377 with SMTP id
 d2e1a72fcca58-84f5dfbad07mr26834874b3a.17.1786370397896; Mon, 10 Aug 2026
 06:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260807100356.1083774-1-jedrzej.jagielski@intel.com>
In-Reply-To: <20260807100356.1083774-1-jedrzej.jagielski@intel.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 10 Aug 2026 09:59:46 -0400
X-Gm-Features: AUfX_mxRG5jLc08nNMpM49kTVM0uIbxQQVBUXgRTCxaHxX5AM-qtREHzLHaaOE4
Message-ID: <CAM0EoM=L4LBAnyxf+NG1D_dY2nre8fKgVxoycXK=sY-9Ruc9+w@mail.gmail.com>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 anthony.l.nguyen@intel.com, kuba@kernel.org, jiri@resnulli.us, 
 edumazet@google.com, stable@vger.kernel.org, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mojatatu.com; s=google; t=1786370398; x=1786975198; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=46MZNjNXhKCE5DS6Jx+nsMAYwugJX53AXQsLnuBwmDo=;
 b=dCI7rOAVNBNV9gruWxIEhK/i7d5lv6dyz9mgYlbSvyiuK772U8dLLbiJujdeCX4hTj
 AtOc6w045rqIKAFwetkXurdHncsJ5yG9w62VQqoVWKgt4E181oBuBGu26hOeYLVVKMGg
 fS2MAVjqw0Gc/cqpeza5Ce2XLT82ydRoYZDeo=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=mojatatu.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256
 header.s=google header.b=dCI7rOAV
Subject: Re: [Intel-wired-lan] [PATCH net v1] net/sched: cls_u32: feed
 u32_replace_hw_knode() with correct set of flags
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

Hi,

On Fri, Aug 7, 2026 at 6:23=E2=80=AFAM Jedrzej Jagielski
<jedrzej.jagielski@intel.com> wrote:
>
> Fix u32_change() to pass proper variable to u32_replace_hw_knode().
>
> When trying to offload u32 cmd by adding skip_sw attributes it gets
> ignored and it cannot be correctly processed by HW and tc_cls_u32_offload
> struct which is then passed to driver lacks skip_sw var enabled.
>
> u32_replace_hw_knode is fed with the TCA_ACT_* flags (bits 16+)
> instead of TCA_CLS_* flags (bits 0-4) which actually stores the flags
> parsed by tc, so tc_skip_sw() always returns false. This leads to
> ignoring some of the attibutes which are meant to be configured on filter
> setup.
>
> None of the TCA_ACT_FLAGS_* is actually used within
> u32_replace_hw_knode(), so there is no point in passing them.
>
> Looks like commit 695176bfe5de ("net_sched: refactor TC action init API")
> shadowed the local flags variable which used to be set with
> nla_get_u32(tb[TCA_U32_FLAGS]) with the flags as the new function param
> while not replacing for none of the u32_replace_hw_knode() calls.
>

The sashiko reviews look legit to me. Mainly: your change makes
u32_replace_hw_knode() able to fail for the first time (with the
action flags it always returned 0), which turns three previously-dead
error paths into reachable bugs.
So IMO, this needs a v2.
Suggestions for v2 from the sashiskos (I typically suck at these
summaries, so may miss something):
- Release n->ht_down on the create-path error (e.g. drop the reference
explicitly before kfree(n), or reuse __u32_destroy_key()).
- Consider switching the update path to tc_setup_cb_replace() (as
cls_bpf's cls_bpf_offload_cmd does) so old/new flags and in_hw_count
are accounted for correctly, and the old rule is re-installed on
failure.
- Mention in the commit message that skip_sw add/replace commands that
used to succeed (and were silently skipped by u32_classify()) will now
return -EOPNOTSUPP or -EINVAL when the block/driver cannot offload.

Also seems worth Cc: stable backport.

cheers,
jamal




> Fixes: 695176bfe5de ("net_sched: refactor TC action init API")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  net/sched/cls_u32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 8f30cc82181d..dc6e455e64ec 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -935,7 +935,7 @@ static int u32_change(struct net *net, struct sk_buff=
 *in_skb,
>
>                 u32_bind_filter(tp, new, base, tb);
>
> -               err =3D u32_replace_hw_knode(tp, new, flags, extack);
> +               err =3D u32_replace_hw_knode(tp, new, userflags, extack);
>                 if (err) {
>                         u32_unbind_filter(tp, new, tb);
>
> @@ -1161,7 +1161,7 @@ static int u32_change(struct net *net, struct sk_bu=
ff *in_skb,
>                 struct tc_u_knode __rcu **ins;
>                 struct tc_u_knode *pins;
>
> -               err =3D u32_replace_hw_knode(tp, n, flags, extack);
> +               err =3D u32_replace_hw_knode(tp, n, userflags, extack);
>                 if (err)
>                         goto errunbind;
>
> --
> 2.31.1
>
