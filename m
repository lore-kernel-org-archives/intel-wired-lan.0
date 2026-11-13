Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71069606E1D5
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=SaT1Dmxr;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bzLbIXl5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DB6A40977;
	Fri, 13 Nov 2026 17:00:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wU7_QEi51yV5; Fri, 13 Nov 2026 17:00:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A2D8D4098E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794589213;
	b=j531f3weNac/EnBB0ZaMTtT0X+aDA7QfTv3RKPAeoLzrcEdHrnQaa6mKwCP5Jx2kJWdt
	 SKwLIAROkExAXYfwOAGxPBh0o4KogyOitSEWIuWZL4I9UVrCzRgaq66bzVyHQ+0UXUQ7w
	 /4IAGSHTZI7jstMAgn606ZfOIgNynj5eAtkIwNK0S021Cvk8zuLwI6OmhnqjTPsF4Y9Xe
	 dNaHN0HB5LEbZtAR9khXE27kXK5kWA9mXRKRmeODR6xwESe1lrbJiprKWp8wzJx8JOPi0
	 g06RBgDkc0eDdQtE+BpQhqyPYBrULbLCqlPQZO3RFFyziKrs8Cct0SD04f40N4GHvMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589213;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UHCYxYd5XK4zwFxBPXElPTHuvK0+v9+ml9Xij7/pCH4=;
	b=J9Ra6XwuhOO/TUfisJihidSCLG+5pzjhH9sY4ihQ5cgy7hmoX1I/ij6gySTPn+NBfYfn
	 vzmbfUUxsnuuxzmlJO5Oq/YyClYMAaYAgkaWwz4cX0FRVxPTikYIM921+WgdAxdTvizBm
	 VLsZvQR3bZ9VyN4HT8rTked/pxcWat0m6qo/TF7Sx6vbWO+VSXysr334W6uDCQZ5+24UR
	 6JNUYmtavW3uAT75Dx9JEdu2qwtWboR76gOhwEol3XuWCIk9U647v1unBDKU7xh6GbyV/
	 PEq7Z8UhyjY6R/supWc6vhl5y+WBto8UQE/VhQGyayo7DYfuGUb+vtr9OgfwEpwNM2g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794589213;
	bh=UHCYxYd5XK4zwFxBPXElPTHuvK0+v9+ml9Xij7/pCH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SaT1Dmxrl5a02it2YwhmuhEXW5aajWpUQVIR7uCTQ42mKCRpOyFuEn/VL6Tchoit0
	 RlZFqIDWq5elLbl+S0kYBwilGwROTrz46oF3TT9IOzhYzjfXyYch++Ae6Kw3YPhdxN
	 /FhACM6ctnkHrCXTqQoEDr1vfpQK/EGZYdAdYD9psF+UZ4Y3my03S3HfM/wXuwo8+A
	 leVccg2/qKIAvfD0D4ppEin7sXTaFzVA+BrkJ+el0XNKtIIX0DX9sFPWQkEiE8Yq2S
	 k8dKyqovz8bCK9sTxj/wC3HL5r0GtBzVfs2EOCl+8cmHCb7wfOprnU/+qYumwjXdlg
	 hFteMPNUdK07A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2D8D4098E;
	Fri, 13 Nov 2026 17:00:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E83B8178F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 17:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE8908132B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 17:00:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vkCiS7UvjXqN for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 17:00:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED38A812BD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::e36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e36; helo=mail-vs1-xe36.google.com;
 envelope-from=brianvv@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=bzLbIXl5
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED38A812BD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 17:00:10 +0000 (UTC)
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-7d2ca055399so274181137.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794589209; x=1795194009; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UHCYxYd5XK4zwFxBPXElPTHuvK0+v9+ml9Xij7/pCH4=;
 b=bzLbIXl5ufKpYa6//Xef/b5qVoNikxbgMt4e3FXbJKK6y0KGrM4S4GLhDNi4FXWcF9
 uQ2JFfEm1IEs/1JMCfz5xJd39JMEP4BZjPQESaBX01p5/vrxybQ6s8kLlHzo7PGECVkn
 Vg9zi6SC7JvwiI/dsqOa5AAgngAFjHopJyrfMW+FWnXv/5EfK07hvWS/snFpwtjN1Odk
 /9FDXRhmSdvkCVZ2+AYtAPZQJjGnfZo8YxWUNUe0ZdxgJglIK0QL45ew9gjBnLkjTRcg
 /qgTd49sWnh97tOgGFv2Pqx0JC17JcjrkNo7ttJz/DlGSIGH/tW+PXxKBHWERDgmV7w9
 JvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794589209; x=1795194009;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UHCYxYd5XK4zwFxBPXElPTHuvK0+v9+ml9Xij7/pCH4=;
 b=MYv19ul9eB6pzPmywibDO87GyEaKOrFJsheA7JmqEKEdgLls9jhadQEM21vEF6ahrE
 fGyLIPnMYaS2gF7rRn1EXm1wwbaNIEy4EWrFI4FVipODULyLWIBsh4gDVsqo6SR1XvWh
 aKwzzCKsspisRqtesPovP7PZOvid4GkPclYVdofI/IPw8pPdTmiL4LIYmcUOQQtgCv+8
 YGgvzmjVZn+FTV+pzhEKkXV5ICD0mSIZrFPRNBDvclbON5mpU8A1PGvyuiPTVHvCcbFB
 /DOQmiUsNpcH4J/R4QRV6NqVrLy+MEgAqopyeomMGgcFK37Mlfoql8kdAhymMDyZTx8j
 Y6xg==
X-Forwarded-Encrypted: i=1;
 AL+hErGDEoC63qpmO4OHqIZVHi1i/QbrIRzWBHkz3aTYxHoQ3H/omgKTIHE6iu5RUDk3cfkwYdW/Y+N7GRMS+97fzbs=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/mcJL6PutYeiMuox9+vASi1+2OMXT7R/oF+EbDePLlXl8HBxSf
 +1qBWWBX8hcncSQ7bUqKonsHGxNAZV5WsHRVpajC6SN2VS+j0O+/GUwixwrx8XqZazibyMk/2vV
 Xe4XQ0pAZWobFcOqH9PdX1VtrmgTenUaTHFIM6nS8
X-Gm-Gg: AYBFou1K+AuKlVb+OUqVqzrGq4OmhRdW+ZqOOUlZYSFH3tEoVEEIAeGqia/sHYRDC1E
 UWYJxPEZUwT3QpTN4foYZy5IAMt+Hfsw3q2bYmbunXeoKu8Cns+8x6YFFU1q0i5rteOMq6XlHYe
 MIT9aBhQdWFIF2ckyYPppb5aV+v0Nes1Up9kaBcdeewsxyxYWlwxupCxK1SdGUz0rCZCljkVulA
 u3TwBI1TT1ZXapzOUgCCQuNXQzwUZMWpylNTsLzb7OsDlUDqE4Eci2RdpZwf59v74NTmIu53wv4
 o0qIldutc4b1TogktUoiX7QjgykRGggVzNwRewZvn7pSdC/bnXzCfwDPT9NFzHusxAXWh1EXpQc
 TFS2ukrADj5wkwdIPz0HYBzQ7UmgkrVngFhQ/
X-Received: by 2002:a05:6102:6054:b0:7c8:1fd5:82b5 with SMTP id
 ada2fe7eead31-7d64d760b84mr707578137.14.1794589208188; Fri, 13 Nov 2026
 09:00:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112011108.1524624-1-sgzhang@google.com>
In-Reply-To: <20261112011108.1524624-1-sgzhang@google.com>
From: Brian Vazquez <brianvv@google.com>
Date: Fri, 13 Nov 2026 11:59:55 -0500
X-Gm-Features: AclHuK_36w4X0Vb1j6PMfyNVfQLXnMNvnnYRJqgmsyGgLC4L1v_Ze30b5mGksjY
Message-ID: <CAMzD94T95F96c0oq+4POQsMHfkWOWjODNK_n27Xw6BsdaGExog@mail.gmail.com>
Subject: Re: [PATCH iwl-net] idpf: preserve tcp-data-split setting across hard
 resets
To: Ray Zhang <sgzhang@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michal Kubiak <michal.kubiak@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 David Decotigny <decot@google.com>, Li Li <boolli@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks for the patch Ray,

Since header-split is on by default on this device, and vport_config
is allocated zeroed, what about fliping the the user_flag meaning?

  __IDPF_USER_FLAG_HSPLIT -> __IDPF_USER_FLAG_HSPLIT_DIS

If we do that then config starts with the right value on the
user_config, if it's flipped user_config is already persistent acrros
hard resets.  And then we can just delete the call
idpf_vport_set_hsplit(vport, ETHTOOL_TCP_DATA_SPLIT_ENABLED) from
idpf_vport_init and do not worry about where it should be.

On Wed, Nov 11, 2026 at 8:11=E2=80=AFPM Ray Zhang <sgzhang@google.com> wrot=
e:
>
> idpf_vport_init() runs on both initial probe and hard reset, and
> unconditionally calls idpf_vport_set_hsplit() with
> ETHTOOL_TCP_DATA_SPLIT_ENABLED. If a user disabled header split via
> 'ethtool -G <dev> tcp-data-split off', a subsequent hard reset sets
> __IDPF_USER_FLAG_HSPLIT again and silently re-enables header split.
>
> Move the default idpf_vport_set_hsplit() call to idpf_cfg_netdev(),
> which runs after idpf_vport_init() sets rxq_model and returns early on
> hard reset when IDPF_VPORT_REG_NETDEV is already set.
>
> Found by code inspection. Reproduced and verified on an Intel IPU PF
> (8086:1452) by disabling tcp-data-split via ethtool and triggering a
> function reset from a test module via idpf_idc_request_reset(): before
> this change tcp-data-split reverted to 'on' after reset, and with this
> change it stays 'off' (with rx-hsplit remaining 0).
>
> Fixes: 9b1aa3ef2328 ("idpf: add get/set for Ethtool's header split ringpa=
ram")
> Signed-off-by: Ray Zhang <sgzhang@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c      | 1 +
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/eth=
ernet/intel/idpf/idpf_lib.c
> index cd1b173e3b27..db6603711be4 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -945,6 +945,7 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
>         netdev->vlan_features |=3D netdev->features | other_offloads;
>         netdev->hw_enc_features |=3D dflt_features | other_offloads;
>         idpf_xdp_set_features(vport);
> +       idpf_vport_set_hsplit(vport, ETHTOOL_TCP_DATA_SPLIT_ENABLED);
>
>         idpf_set_ethtool_ops(netdev);
>         netif_set_affinity_auto(netdev);
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_virtchnl.c
> index 928de868fa62..fc56437b01ab 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3381,8 +3381,6 @@ int idpf_vport_init(struct idpf_vport *vport, struc=
t idpf_vport_max_q *max_q)
>         memcpy(vport->rx_itr_profile, rx_itr, IDPF_DIM_PROFILE_SLOTS);
>         memcpy(vport->tx_itr_profile, tx_itr, IDPF_DIM_PROFILE_SLOTS);
>
> -       idpf_vport_set_hsplit(vport, ETHTOOL_TCP_DATA_SPLIT_ENABLED);
> -
>         idpf_vport_init_num_qs(vport, vport_msg, rsrc);
>         idpf_vport_calc_num_q_desc(vport, rsrc);
>         idpf_vport_calc_num_q_groups(rsrc);
> --
> 2.56.0.611.g1030f0b940-goog
>
