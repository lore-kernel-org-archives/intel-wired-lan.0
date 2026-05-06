Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCED8CD37AA
	for <intel-wired-lan@archiver.kernel.org>; Thu,  7 May 2026 22:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A9926110C;
	Thu,  7 May 2026 22:01:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZO9kQNQyCHMD; Thu,  7 May 2026 22:00:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C607D61100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778191259;
	bh=6DRjfEWCwxFjiwZKR36Dkjheso+euX81gimPA00RoXo=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DHPqFYJA81Lz27f4a1fhC1oSg2tV71xCo3gQgl7wxR8MLdE8TLCEPkQ/XTYb2tyUM
	 b9COP2vVoQ9PvH/NmRR117MmM53OtA0Z5UqkOzMbPCMg435hJcpYb5/csCNGCB6MMW
	 wnmQ65e9LSSign0ciLXlGjnyIMiKhtkyEioH1MKvTP8Q3HvHMMSoRFyY6mPebJqFzp
	 64zD3TJefUZxqXuT5GpsmKDCCvtuFuArGtxhaqQpSYpdf5vxVReRcMxi7vfzh5gEif
	 QdKt0dDuTpfSCS9ULjpPIIINmRcODoOFaDcM/mS5C62h6nJwCVXHYb2as4y/HXA4YI
	 jbOl44tgUkLXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C607D61100;
	Thu,  7 May 2026 22:00:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 07B39280
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 May 2026 17:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05B6460E9D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 May 2026 17:25:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SflI7nmTBwwf for <intel-wired-lan@lists.osuosl.org>;
 Wed,  6 May 2026 17:25:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=fred@cloudflare.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3988B60E7E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3988B60E7E
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3988B60E7E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 May 2026 17:25:31 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7bdc947aaa3so22918227b3.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 06 May 2026 10:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778088330; x=1778693130;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DRjfEWCwxFjiwZKR36Dkjheso+euX81gimPA00RoXo=;
 b=nafy0hoU8nzJzTb4lwaksw6KNtqQKKofXhqQg5GdPYmfD9sZN1VPYWuRespaTKHs5i
 FCO8TuizS58nqi1V6+eyOSbMCfVie7YwBTHEie/l/lipWvt7NHXsITqi/zm6dRyMd+Dn
 W/d0roo3d5IkRZjXs1N+8yJaU+q89lNCAChFdG/3Xc6LeVqSP7tnPGg4WPMDIa6rQAO9
 UxwDjNTDxPdzTAkoK2fgU//LMsq57ZgdJMG9Hhs4Xcz+Ssr/zcWgujp9YAkbyGUiJhsW
 ECeEfgRZQnR8kPTwZts+VuisVK1A6AJrmS7llG283jTbyVbs1zByahFVcG/itCIH4fJe
 7pHA==
X-Gm-Message-State: AOJu0Yzr/4Gf4Lsf/LvTWBPM3EwAI7RkH3fhfvD2sWLA4RzMHps5TgQq
 49hT3Q9VyyF58UEoFS9jXUGnGvUOW5rsGRQfIi0+EJnLc9ZE4tA2njqxEt9BIRPMRQo=
X-Gm-Gg: AeBDieuaR6TjkOrQdmSl7unTY9W3u+adpl/zs557xsEuTV/hMNqRB0APgctR+EKXRRO
 APBVQ7jL8lK+IQj64zhfnQgJlwoMmNVJk9YpbNrSPCeVG6ucLo1WMkRlBsp0iuCVUPCHDuMip8/
 Mym36UjT08zL7rBSBUfZFbh0jd0mGo7KIoVbJwclp71mARVL+O6IBy7ZMzfMn561Ov3nmZeorV+
 H0W+rg05XM1qPJkKF2fwZoFHbqzxAmce2icxKRB74D/pVDpxZGMcMeI5SUQ5ML/KXT/bUaFdbDZ
 tkuxYgopDSoSDwyKOf7sq3p0arjV8bHE7Q7r8/BgrwKkZRp7K37aVZgOa/TxBObDNgnEkOFmcNd
 lsLd1/5MkYEL9AEpcpKwiYISObvPo9OnsYip5HuVhUWYA7Wegre3DSbQD6Pi7pN5iuTaR4UukWS
 aKYW8fpL8zEH/K
X-Received: by 2002:a05:690c:81:b0:7bd:5c5b:a4c1 with SMTP id
 00721157ae682-7bdf5eb839cmr50865067b3.33.1778088329599; 
 Wed, 06 May 2026 10:25:29 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:5c])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7bd6652750asm81257917b3.10.2026.05.06.10.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:25:29 -0700 (PDT)
Date: Wed, 6 May 2026 12:25:27 -0500
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Message-ID: <aft5h-Ygbjjr4uwk@CMGLRV3>
References: <20260504110058.2373236-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504110058.2373236-1-sergey.temerkhanov@intel.com>
X-Mailman-Approved-At: Thu, 07 May 2026 22:00:57 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1778088330; x=1778693130;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6DRjfEWCwxFjiwZKR36Dkjheso+euX81gimPA00RoXo=;
 b=ZOwoHlD+i/wej8xPIa0jqZvpR0NJqtmKOcp4Qe4IEhW32f5YDVak1N66+YnPp2k2yT
 zGUl6TC2Np0znsWstIYNfVmfV9Ya4iyePYw4jLbLm+tTcldCWvIsA9nwGUuVqp76x6xX
 TpzGsuzsfHbe4SMTmNwqyZnu/mD77mB7/P+MDQfr6uBXJii5V3v6b2EtSdaY7pK09fj0
 7Jlj3Ytq4A77RhOb4pBtRv17sDadaNpYe/P+siCI/CWiuZdUNHKpWeZCVsv6oiumoWo+
 mEgB4AKv+ItvHetDseiNa0HTB7v5RN0I9Ij+NijZIYHzJDFeiUP1SqDv9xGnIWTSadrn
 dnpw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=ZOwoHlD+
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 0/3] Rework ctrl_pf pointer
 usage in struct ice_adapter
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
From: Frederick Lawler via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Frederick Lawler <fred@cloudflare.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Sergey,

On Mon, May 04, 2026 at 11:00:55AM +0000, Sergey Temerkhanov wrote:
> Rework usage of the control PF pointer in struct ice_adapter, so that
> it is always has a consistent state, since it is global for an adapter.
> Utilize RCU for reading the pointer value and atomic operations for
> changing it. Zero out the ctrl_pf pointer when the control PF is removed.
> 

I'd like to test this series, but I'm having a hard time backporting to
6.18. Is there any prior work I might need to pull in?

Best,
Fred
