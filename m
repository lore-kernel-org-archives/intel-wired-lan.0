Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4293C5478C
	for <intel-wired-lan@archiver.kernel.org>; Fri,  1 Mar 2024 07:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 755F741D71;
	Fri,  1 Mar 2024 07:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ci3J4QWgf-d2; Fri,  1 Mar 2024 07:59:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D34C741BB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1709279965;
	bh=zr17gvSSYZaVH9ib6UrODiLALqn6xS5V58WYpS0qdvY=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=kZYqJBOBJyR6BqexbNOOmfjmVwzApo2fpGQf5x9vBLRCJg7L5NLIVfVdSu1Lqq2Wl
	 k0+FY18DOltvvFXhxE24jn0SxpT3auEtzmoAlAsmIgvgaJQRY0PMJuzSew2MFNnGpG
	 ukP8fEpaf538y/ohUxJW4PBwZcW3q+iRkAU15UbRZnQ9vpRfrY1JPLwwTpx2p304bE
	 SOdebpNs7p94oQOacA2Pkejq0LYCHFPnHkGCWMlK61y8llgoeJEGXcTDOqK9XlvT62
	 dudteBriJYRI5QRwZqs3DbZTmcTScmd1vqZh9GmrSM/Bb5EnU/5DOvyxNrtSWE46Q9
	 Mrr3GWP63rItQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id D34C741BB0;
	Fri,  1 Mar 2024 07:59:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id AC0B81BF20F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Mar 2024 07:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3FB241BB0
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Mar 2024 07:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7YJpx29zzIwV for <intel-wired-lan@lists.osuosl.org>;
 Fri,  1 Mar 2024 07:59:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=edumazet@google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C79DA41969
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C79DA41969
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C79DA41969
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Mar 2024 07:59:23 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5654ef0c61fso8522a12.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Feb 2024 23:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709279962; x=1709884762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zr17gvSSYZaVH9ib6UrODiLALqn6xS5V58WYpS0qdvY=;
 b=Faqch7AEQTroF/N7lgFF4aWn9eFqCQH/Fae0zCtiqPq92TsLUVqPTtx+A2TQOhqimJ
 RI0b/OOCjyZA3iUJ2k3JjuSFX7SkwBGpcJwU/fPv4D8eLHJudWpbf4f87bK790kh5JXd
 3TGOEOTs7QRYNj8oPHL3RWgCS3rnKFYGR5dErk5pjBQlOiGLWzW+1nqNH01GuTAK6UEr
 PDzrl6U1tLhpzda2F0Z0WBAv3coBEhRzN30oDEQpPrIbrCWEmArmNh2nKrAeAvraro5T
 ez8b5nWYKUVGAqnc4WOEOUhac2e7qXnSgug0qXOre2qlWxKdNVNocUuK8zIksFlmxUl2
 Gh+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXndH5ACE4H6g052ySqAeMlP25ghvhO+Qh5an2lGix1Cz1f9JXSa8oWAFkotvGx6TpYWD+Bz0CrXV6k4sabNihLk/MEN4NuNTlcoDz9GyNSrQ==
X-Gm-Message-State: AOJu0YxZ8Pv72xe7VZ49+0Yv3s3jPowbLecVN+hvT3681BVGfxkdef4C
 8wgIbhElwyvdheJgjKtCh2gz7Q/swS5nxTYM/SUlM6++wRpf1O2wnYXZeKnMnGHmf9ReEKpZlrO
 GF9H6WmpzzYu7RzFMUd/T3SOxOrPynh6gIzt4
X-Google-Smtp-Source: AGHT+IEEtSCK29cB4p97aeoYbUpC06LMrOwaksjc/s10E3lC10NxKJ6xZCv2MJVmnqAp0S0aKLTElVjqSLOxSH4+Kag=
X-Received: by 2002:a05:6402:350e:b0:563:f48a:aa03 with SMTP id
 b14-20020a056402350e00b00563f48aaa03mr113930edd.2.1709279961492; Thu, 29 Feb
 2024 23:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20240301070255.3108375-1-kuba@kernel.org>
In-Reply-To: <20240301070255.3108375-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 08:59:08 +0100
Message-ID: <CANn89iLhOWFaW-iLw77LcgZ-Lzbput9XQt=GtsC_V9yV56_jwg@mail.gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709279962; x=1709884762; darn=lists.osuosl.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zr17gvSSYZaVH9ib6UrODiLALqn6xS5V58WYpS0qdvY=;
 b=L4heBDEXemO69jUSvqYT/adHQEub8PTceds5UMgfEdQt1TTBZgzWob/fnKXrE48gVH
 4onyrRyAwEBwWEECtpxBo9BxLpwerLSA3bxcs9wOPSGRrGUNPeFcBiaMq1VUR4M8w/yJ
 BqRxbrur+QTWqH1mvCKXpvj7XP6iP84Yuyt+RUe0v622KQZddpoFi6Hc7CYyeH2PDINg
 c8p9cBKyDdVF3vlCHnKDTSYN+6HyvX6YNVV3yjMhVacgZ5knWDjcaVcmdp7iY5O026WL
 OjtLaqUrVdxAYzrSOb7otu4frNSPtBjTmVJer+htPL3CZZgsX0/p0dup14VzVLPS+apx
 M/Lw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=google.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20230601 header.b=L4heBDEX
Subject: Re: [Intel-wired-lan] [PATCH net-next] eth: igc: remove unused
 embedded struct net_device
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
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 pabeni@redhat.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Mar 1, 2024 at 8:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> struct net_device poll_dev in struct igc_q_vector was added
> in one of the initial commits, but never used.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
