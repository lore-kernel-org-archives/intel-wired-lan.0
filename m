Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB15C4332F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Dec 2022 16:29:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6133481336;
	Fri, 16 Dec 2022 16:29:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6133481336
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671208174;
	bh=xPlWXBzsBEGy8t11hSoy2Z6nv6LIHaX80gyiSDVTuFM=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=kLxqqiK3Yb2Gc7Ku7CQkJgIUS8oYa6RXlieAjWN214KrgM8liCEm0xrBQiBZnr25q
	 PlT2aePZcIrRnfewkF6/xSCCg3f0XBNbxJ+BbJr1t3Zo4wGrHgwGrxBrercyDrGonr
	 39Qlvz1oMBysU1A6oIfiN4O0rHmnqmiskwkM9LiST45sNFqmGrQtgnwCuSPjoZXjAB
	 bhvvC7ugLsAqXJ+lKWiza8KUVMBWwriTSeK0N6JO5R0i7lNFYW5qBROFwWUAlO52sH
	 vMGBEYwTvDvRNrO62O0D8a5fOY2wC1rvFIll7NjrEMnWhn7L+8cNRjI4jkMrfane1w
	 p0Es5sSL2VZyA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6eMMWpq8hONR; Fri, 16 Dec 2022 16:29:33 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 755CD81344;
	Fri, 16 Dec 2022 16:29:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 755CD81344
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 72B221BF2C3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 16:29:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4AAFA415FD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 16:29:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AAFA415FD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GNRiYNx0gJTg for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Dec 2022 16:29:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C85D415CD
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C85D415CD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 16:29:30 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id m4so2829685pls.4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 08:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kP/FoMB1Yj/qY7ZBSatxXAMle19ZjD4rvZ91q9C/PSM=;
 b=D0iBX9XgcnAGoaN3u7JstCC5nCWEptQkqkJv9cxbIbLe+YwwHULXRQLfN++ZQIQ1BV
 PuAHSHv8u3IitPPfUI9FMNpX1Vaocl8Y2bJLO/FbT4AhjQDvPdvXE8Hb8Kga+3kBeSyM
 Ogikd/9yGhCdAndgyK/H54d8XfPkfssEpllZt1Xqay6uEWhLQxiZw/l4bTNobzxY5eh2
 OAzvFxonCQQ8qqVz8H0zUjaRpvYYCAEpQTL1eEr28IHhaxhvsAFQDAExLfOe+cynaUYQ
 YFzloc7miyuuz1P4wwP+1zmL6D51UIe5P1UWBn6GHKXEBMz42z5XPrDaEszqE7sMVVJ6
 Fqkg==
X-Gm-Message-State: ANoB5plAnGZkJrxYypEuB/vHFlleZ9EWxQlTUVQTxqvlshNO++hh6gGt
 1D+yKWGWtUGS9wZnqwQhpqg=
X-Google-Smtp-Source: AA0mqf7/EWAwq/mPcEBrQBEIPEl7QKavJQnPIidVqOy2mCfvTOaaHp565ziXNcoVzGI6iysNBs6FCw==
X-Received: by 2002:a05:6a20:1be2:b0:a7:ce31:f342 with SMTP id
 cv34-20020a056a201be200b000a7ce31f342mr27044309pzb.52.1671208169840; 
 Fri, 16 Dec 2022 08:29:29 -0800 (PST)
Received: from [192.168.0.128] ([98.97.117.20])
 by smtp.googlemail.com with ESMTPSA id
 s24-20020a63f058000000b00473c36ea150sm1659196pgj.92.2022.12.16.08.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Dec 2022 08:29:29 -0800 (PST)
Message-ID: <c4109e30b644df218b7e601071a64197bf17b1f4.camel@gmail.com>
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org
Date: Fri, 16 Dec 2022 08:29:28 -0800
In-Reply-To: <20221215225049.508812-1-mschmidt@redhat.com>
References: <20221215225049.508812-1-mschmidt@redhat.com>
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kP/FoMB1Yj/qY7ZBSatxXAMle19ZjD4rvZ91q9C/PSM=;
 b=W/OL8VTWs3dVmAhVDxbmhuv9Rd7+/pdKHXI44Jpe/hfHlPvPzddof3IsVDLys9PoNw
 j0Uj8/uHeYac+sO4Lx4ScVVG2ZZ8mDyqCW1G7Jh1sV53Fm7nJNJDwbz5vYMnsSZTHR8Q
 uLg7j3bVCcp0ar4gCYBb4uf+sEB8vSY4le4wC43Pua74B68gtQeaMv7dInSVgVP381vx
 BG3rpIHlsA3RBzQnl2riakl6p0mdqy6S2GYUaYP1Z8YZIbDd6tvTfHguQIFSzXkI2OOy
 Telvj864fhJLJDKzDqAMAkNofeeSO2RGrzDhRU7Yg/js+GOD/CO5nKghMNnlgQZYLxHq
 qCDQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=W/OL8VTW
Subject: Re: [Intel-wired-lan] [PATCH net v2 0/2] iavf: fix temporary
 deadlock and failure to set MAC address
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
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
 Patryk Piotrowski <patryk.piotrowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 2022-12-15 at 23:50 +0100, Michal Schmidt wrote:
> This fixes an issue where setting the MAC address on iavf runs into a
> timeout and fails with EAGAIN.
> 
> Changes in v2:
>  - Removed unused 'ret' variable in patch 1.
>  - Added patch 2 to fix another cause of the same timeout.
> 
> Michal Schmidt (2):
>   iavf: fix temporary deadlock and failure to set MAC address
>   iavf: avoid taking rtnl_lock in adminq_task
> 
>  drivers/net/ethernet/intel/iavf/iavf.h        |   4 +-
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    |  10 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 135 ++++++++++--------
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   8 +-
>  4 files changed, 86 insertions(+), 71 deletions(-)
> 

The series looks good to me.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
