Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434A6C25B10
	for <intel-wired-lan@archiver.kernel.org>; Thu,  9 May 2024 11:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC8C96059B;
	Thu,  9 May 2024 11:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9JB9gFwiM2yV; Thu,  9 May 2024 11:14:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D5F6605AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715253246;
	bh=XBhNbVzR5327olKp38oRP+7QC1vGtVlA1636WRhZ8m8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=xw3W60VXJKQOBHSnIxeuucfo8vSEQ7Au51QyW8FHULQRe5V0RvDqjlKjlCmKVpoNL
	 cFJb668ZbOJX80KPgm3yerNbh8X1KFQhuIjjz2tVRVyAYctDYzS96h1Dbh4qV/D4i6
	 ydJ6nkFZdSJIMuN6Q70F/3G028vBIs2BkM/TofRHmVGdftdAkct5Flj/jKhU56PVuO
	 ke3t2AcpmvJIUjW+9/dckpKLx7b1B2KCcjGDuPLuPZEAo9SMEw+wqJCai1bzv3ltYV
	 dhwWrqsdq2Dev/ngbbVNwJDoQ84m2aMUkYNv9RvxSm+ktxG4s927tABFQG6EHITSQX
	 Bev+jiDmVgpHw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D5F6605AE;
	Thu,  9 May 2024 11:14:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 2574C1BF361
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 May 2024 11:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 106E98132E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 May 2024 11:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mXhyZuopjNhO for <intel-wired-lan@lists.osuosl.org>;
 Thu,  9 May 2024 11:14:03 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8033E81316
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8033E81316
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8033E81316
 for <intel-wired-lan@lists.osuosl.org>; Thu,  9 May 2024 11:14:01 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41c1b75ca31so5505685e9.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 09 May 2024 04:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715253240; x=1715858040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBhNbVzR5327olKp38oRP+7QC1vGtVlA1636WRhZ8m8=;
 b=H+BXNMvaqO/1zbXSBA5LEPYuXGYS//nPEpjHvllzECJwAjqRgymN8yTJpRgwPBtQrA
 pb/bKhP52Jtnm6oDY4d0l7XAIwbCk97k8K7VXyy6komofp0JQFjiAjDO8OvPrUcHorlq
 JbnEcc6zjZB46pVWP3O6ikNUatFi/nF72B/ZehlxIPCgG9s/yqibDAWdMsdjyYUbsBrx
 A+kgL4gNDVk/pfEkdlFYz7KnPgA1bH0EgMNszqGqnbLsx76YKxsGDnJtIqTzDffHv1Cz
 YWRlMa+fpEHdW0Qqa1LEl8Yn8QeDPmg6RfCUduW2Mivul+F1VP2ycKA0L2nTqMwTeZS4
 TRiw==
X-Gm-Message-State: AOJu0Yyl8D+8fqyGgycrU8FzRbozXCPWvsO2AdSZils3RX9uOpZsSv+Q
 BqJx22qL7JYPpin3dhOHUlLc4zjB9iHayZ8jUShqviAtklJegiMCDeANDA3D2U8=
X-Google-Smtp-Source: AGHT+IFpw4SnGTrtArDbcU2PAGbCg1ZgJFJuQgGVS0IRiH+ldNpoUZMEhV0eTxF2os1Cwsyke+rq6Q==
X-Received: by 2002:a05:600c:4688:b0:419:f630:57c2 with SMTP id
 5b1f17b1804b1-41f72593be5mr47718265e9.37.1715253239723; 
 Thu, 09 May 2024 04:13:59 -0700 (PDT)
Received: from localhost ([193.47.165.251]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fa90e93absm41784305e9.9.2024.05.09.04.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 04:13:59 -0700 (PDT)
Date: Thu, 9 May 2024 13:13:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <Zjyv8xAEDhtzXAIx@nanopsycho.orion>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-7-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507114516.9765-7-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715253240; x=1715858040;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XBhNbVzR5327olKp38oRP+7QC1vGtVlA1636WRhZ8m8=;
 b=koULYsWp4ROdyTLGmJAbzXTg7gwUwOi30/+CI7f25xsQTL7Yok9+JvbYLdW23R007K
 D8n1iMXNIPulZixbCLqDu/poRXHfjZK+Ci8OzgxNuVqmbC2HBMpktXItBG9gDSe4gYMj
 sSqh74IstiKlwb9zLo0gFv/trnX7WaeANbOouRKaABqSbn1V2EDX5RXEvMdNjuc7jXp/
 tOl9aY4lh4ewY+nZCoxh4zXZsyIuPFUmk/ycojUcRG8DW7v2rqwNVUaOMCGjfp27gyQX
 euY6gDBWsqf0uWZT9O94cEvIXWDrRC3V1qguEqTeRijN48NC5mx8Tofgj9zZ7aa6JiOM
 Yk2A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=resnulli.us
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com
 header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=koULYsWp
Subject: Re: [Intel-wired-lan] [iwl-next v1 06/14] ice: base subfunction aux
 driver
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
Cc: shayd@nvidia.com, maciej.fijalkowski@intel.com,
 mateusz.polchlopek@intel.com, netdev@vger.kernel.org, jiri@nvidia.com,
 michal.kubiak@intel.com, intel-wired-lan@lists.osuosl.org,
 pio.raczynski@gmail.com, sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
 wojciech.drewek@intel.com, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Tue, May 07, 2024 at 01:45:07PM CEST, michal.swiatkowski@linux.intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Implement subfunction driver. It is probe when subfunction port is
>activated.
>
>VSI is already created. During the probe VSI is being configured.
>MAC unicast and broadcast filter is added to allow traffic to pass.
>
>Store subfunction pointer in VSI struct. The same is done for VF
>pointer. Make union of subfunction and VF pointer as only one of them
>can be set with one VSI.
>
>Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Perhaps it would make things clearer for reviewer to have all patches
related to sf auxdev/devlink/netdev at the end of the patchset, after
activation patch. Not sure why you want to mix it here.
