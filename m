Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1886BFEC0F3
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Mar 2026 18:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C72D741273;
	Tue, 24 Mar 2026 18:29:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IPBTH5zW3x6p; Tue, 24 Mar 2026 18:29:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F07C241279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774376946;
	bh=5VMp4SS5F3P0M1XmfAAhBrmRFWjAnWFpCGzWfd4HYYM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=82vjygy8JEwzpyuY4jwkXHYZsndF3G0AlmAr+9DJZ5klVjuLu86F6Vbac7H5JYjoN
	 S+hMAZGPykIAMICbFmldqt7sevusXI18xykNo26vX2VFb78B9SMaW7LzN0IfwBX+Gw
	 qKD+AKvZ+M50RLE975oatMjsDUZG3ot/ORfxQ3NETNvJLsfkoZhgTWw1t4LQWXtaPj
	 7xGELVXPYA+K49GeelFzRERbQbV44pNyzSBMPFp87ol9FReenLBSxWwFzCDRslioca
	 LQkgCHLxVBW/3xiIWtOT8uKeRUhmqeFCFUjUeXunXuXKJS6Zi1nKwww6BHy/VSDgVI
	 qm87YHEVN0iLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F07C241279;
	Tue, 24 Mar 2026 18:29:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BF66353
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 18:29:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE62E60E51
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 18:29:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UTBIP7RI0-Dk for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Mar 2026 18:29:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com;
 envelope-from=stfomichev@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2A88C60E4F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A88C60E4F
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A88C60E4F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 18:29:04 +0000 (UTC)
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so6817907eec.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 11:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774376943; x=1774981743;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5VMp4SS5F3P0M1XmfAAhBrmRFWjAnWFpCGzWfd4HYYM=;
 b=MhBtmytAg2ZJmrTUlo/mEgpG/hXtKLNFY+ilYqR8NPUuLRIZn6cmPMFaD23DEpon+n
 rXMk9SwuqTIM/hCJnhItD/GdxqO3+V3wMKlAGCvyCHn2OXxz8U8qFujiblU7aaxN27TH
 +DZHRKTjoyQhfIz9EJPFuXsLN3iurDKizi/HkgYKhj3BofAbexnOPVF9EKo128sM/nyf
 C2SB4uodOANAxd3n8sbqXAMU4Mv5174bdVh6lTzCoPbXACMOmUIH1ZFOXRf/2sNbrhpp
 5Ub+79Q1xBl2SiC4fau4MjERSZNF2TAd9OG54vbKOz54tUYmv+OX5fgIa/U6jfEt6Lun
 clng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNbW7XxibtW940ENqB1QRojWHED+Cj6mCjkAuhh4EyNU7dsAxsuIINZmlblH+EtOoiXqJ12QDSSLMI13Pw8mQ=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yxx4HfXIJ/UZ98VoU1iIplYguIRV5Dn1clxHEc551fMewqrDYiV
 Uqke/k1qwVxrXdzPL4krBfj94ns9PFwfvmY2C9zKNFtpGzGBWt3z2mE=
X-Gm-Gg: ATEYQzxo/QhIx/94tc6iKNEzMRMExQSGk3OpVq4YL3XedJBxv/3UEglXCflqoq/giNZ
 YEq7nQ6s40ofHbEnm0LPRhhFU7eo3izlrwvahBahcJvhif1zpHPU+iRQ4CN3RkcEXApC6vHcNzs
 4TN1Os9iVqyOdVwpqOpkfBo82bwimF2GvrRp/c4wxzyTaSFNCqEJ9Vd1ccS4Ks1LlB3KqWI49oe
 NJOetC9jc5cpxsOK7mjvMW34rjnHM2OZ4JPDi8nz1ukqa2XfQLiScEhLAiT6U+baJvxJeu/AW94
 cLOYPNX/7PQZNkciZuG0Y6F/3EfHjl0DqqolTTbD0H4z8mUnrDCx7JaGxpiNoii2hZvT2sq3PFt
 hG6hHqrJPTysZ5Q4yABC+amJZoWJjG+udipEZYD4QUsASrtnbOrIjvZSbW4DFuI8tinSBelVYew
 0wcfXdEcG4vAaILF5FafCtCJP/Ign/vMzUwTR+T4ykldINxZgBTTCHQcT/03o0JEaKkE/ZAHTCY
 MZhXftBbRLMLdqUysfaQj8MSsHc
X-Received: by 2002:a05:7300:7b90:b0:2b0:48f7:837d with SMTP id
 5a478bee46e88-2c15d2dfa68mr213205eec.11.1774376942754; 
 Tue, 24 Mar 2026 11:29:02 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14c299sm15827125eec.6.2026.03.24.11.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 11:29:02 -0700 (PDT)
Date: Tue, 24 Mar 2026 11:29:01 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
 johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
 dtatulea@nvidia.com, mohsin.bashr@gmail.com,
 jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
 bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
 leon@kernel.org
Message-ID: <acLX7XCmoc-tFCbD@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
 johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
 dtatulea@nvidia.com, mohsin.bashr@gmail.com,
 jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
 bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
 leon@kernel.org
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-9-sdf@fomichev.me>
 <CACKFLi=j7DO_d46jwZnmZ=OfmkoFA3AXUoX4nmF0tQuYt5Y3UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLi=j7DO_d46jwZnmZ=OfmkoFA3AXUoX4nmF0tQuYt5Y3UQ@mail.gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774376943; x=1774981743; darn=lists.osuosl.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5VMp4SS5F3P0M1XmfAAhBrmRFWjAnWFpCGzWfd4HYYM=;
 b=PQRIOR0GgAqoxGIjsOvf2FxNF8aoXCo7hRp+qJpwvfnlxE4mYObCNhWt1Hq8biO4jC
 GbtmslyDO5OWbhscjIKpF4fSVYhPFKglI4cSjM8DJe4SJBfOI15QiNlpAH8UJthMMERd
 BFgYMbK1C53q3kYZ2lOG5YNASLi9LPYLNBYD2f8Ku5bazQ8hZ54SiNwmAyn/hKBTzS0R
 nqr7q6JFOQPPoWoUfBNyxh9TgDR50Ec4y+AXumTjrxnEByBUGYsebKQXp+ggu5pfviFB
 JyiN19hk5UPpAL5t66kbL5Yv1pi614ba7rF4zKZ7JCUib6CtIZ9+Wk3gncggulJgWV6V
 JkPg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PQRIOR0G
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 08/13] bnxt: use snapshot
 in bnxt_cfg_rx_mode
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

On 03/23, Michael Chan wrote:
> On Thu, Mar 19, 2026 at 6:25 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > With the introduction of ndo_set_rx_mode_async (as discussed in [0])
> > we can call bnxt_cfg_rx_mode directly. Convert bnxt_cfg_rx_mode to
> > use uc/mc snapshots and move its call in bnxt_sp_task to the
> > section that resets BNXT_STATE_IN_SP_TASK. Switch to direct call in
> > bnxt_set_rx_mode.
> >
> > 0: https://lore.kernel.org/netdev/CACKFLi=5vj8hPqEUKDd8RTw3au5G+zRgQEqjF+6NZnyoNm90KA@mail.gmail.com/
> >
> > Cc: Michael Chan <michael.chan@broadcom.com>
> > Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++++++++++++---------
> >  1 file changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > index 225217b32e4b..12265bd7fda4 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -11039,7 +11039,8 @@ static int bnxt_setup_nitroa0_vnic(struct bnxt *bp)
> >         return rc;
> >  }
> >
> > -static int bnxt_cfg_rx_mode(struct bnxt *);
> > +static int bnxt_cfg_rx_mode(struct bnxt *, struct netdev_hw_addr_list *,
> > +                           struct netdev_hw_addr_list *);
> >  static bool bnxt_mc_list_updated(struct bnxt *, u32 *,
> >                                  const struct netdev_hw_addr_list *);
> >
> > @@ -11135,7 +11136,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
> >                 vnic->rx_mask |= mask;
> >         }
> >
> > -       rc = bnxt_cfg_rx_mode(bp);
> > +       rc = bnxt_cfg_rx_mode(bp, &bp->dev->uc, &bp->dev->mc);
> >         if (rc)
> >                 goto err_out;
> >
> > @@ -13610,11 +13611,12 @@ static void bnxt_set_rx_mode(struct net_device *dev,
> >         if (mask != vnic->rx_mask || uc_update || mc_update) {
> >                 vnic->rx_mask = mask;
> >
> > -               bnxt_queue_sp_work(bp, BNXT_RX_MASK_SP_EVENT);
> > +               bnxt_cfg_rx_mode(bp, uc, mc);
> >         }
> >  }
> >
> > -static int bnxt_cfg_rx_mode(struct bnxt *bp)
> > +static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
> > +                           struct netdev_hw_addr_list *mc)
> >  {
> >         struct net_device *dev = bp->dev;
> >         struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
> > @@ -13623,7 +13625,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
> >         bool uc_update;
> >
> >         netif_addr_lock_bh(dev);
> > -       uc_update = bnxt_uc_list_updated(bp, &dev->uc);
> > +       uc_update = bnxt_uc_list_updated(bp, uc);
> 
> Will the uc list snapshot change between bnxt_set_rx_mode() and
> bnxt_cfg_rx_mode() with the direct call now?  In the original deferred
> update implementation, the uc list can change and that's why we check
> in both functions.

The snapshot is gonna be the same for bnxt_set_rx_mode->bnxt_cfg_rx_mode path.

So you're saying that it's ok to remove the one in bnxt_cfg_rx_mode
because it's called either from bnxt_set_rx_mode (with a new list) or,
explicitly, via the BNXT_RX_MASK_SP_EVENT retry mechanism (where we know
that we need to redo the updates anyway)?

This makes me wonder whether I need to push the retrying mechanism to
the core stack... Right now, if some of the allocations in wq handler
fail, we just give up, maybe I should handle it better. And I can plug
the signal from the driver (make ndo_set_rx_mode_async return int)
in the same retry mechanism.
