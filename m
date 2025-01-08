Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5D0E77199
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Jan 2025 11:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A219F4038E;
	Wed,  8 Jan 2025 11:10:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gshhsRNkievw; Wed,  8 Jan 2025 11:10:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F34840340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1736334645;
	bh=BVGzhzb3Wo/2RwksroARoL775dNH8DrEF/alpc05ZL0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o7u/Sj3MkxFZDggF6Xr0utctwfbANc3Qy1ORWRkbGa9ccmUDkUKsHWxsg7PjV2Xq7
	 Trlq4bfqe1jxpdTvt11/18f9Ns7DT4AZogO73bvgQjQxZPxx7JxfEpd4zeROyVr8nx
	 64JPOAUVuqpCEMhFTydo5gUsv9xD++DjmgdIwObElhvQV/3olsI0BDyOVMNrnatcEJ
	 q+ifUPNpz8wMJsEb2tVtzwY+YksviPec7mzyYM776NvPDHif0aML8fWZJ02Mqh/vyf
	 h2N8p2nRWCU5V1oi37WetRiOEBEqDSgzoDsdGz0KmSCkcHav8b7KmFmq9E2DZcTjGH
	 nQ1kM9pjfEkqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F34840340;
	Wed,  8 Jan 2025 11:10:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C84A01EB8
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jan 2025 11:10:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A843340340
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jan 2025 11:10:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6JD69ZmpM5KN for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Jan 2025 11:10:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=vinschen@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AD59C4031E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD59C4031E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD59C4031E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jan 2025 11:10:42 +0000 (UTC)
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-0mr9kQuENeWRtXIsaKSd9Q-1; Wed,
 08 Jan 2025 06:10:39 -0500
X-MC-Unique: 0mr9kQuENeWRtXIsaKSd9Q-1
X-Mimecast-MFC-AGG-ID: 0mr9kQuENeWRtXIsaKSd9Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8283E19560B3; Wed,  8 Jan 2025 11:10:38 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.193.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28A81195608D; Wed,  8 Jan 2025 11:10:38 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B1EEBA805BC; Wed,  8 Jan 2025 12:10:35 +0100 (CET)
Date: Wed, 8 Jan 2025 12:10:35 +0100
From: Corinna Vinschen <vinschen@redhat.com>
To: Christopher S M Hall <christopher.s.hall@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
 vinicius.gomes@intel.com, netdev@vger.kernel.org,
 rodrigo.cadore@l-acoustics.com
Message-ID: <Z35dK7V_OITEoi71@calimero.vinschen.de>
Mail-Followup-To: Christopher S M Hall <christopher.s.hall@intel.com>,
 intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
 vinicius.gomes@intel.com, netdev@vger.kernel.org,
 rodrigo.cadore@l-acoustics.com
References: <20241106184722.17230-1-christopher.s.hall@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106184722.17230-1-christopher.s.hall@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1736334641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BVGzhzb3Wo/2RwksroARoL775dNH8DrEF/alpc05ZL0=;
 b=ZL3teJBanWPTV2XcsHfie4oEaQC58ev4MHxSE280cbnmoH38AEjirA7xU00LsAwn3JUaQL
 Xg2yqBh20PjhodCanf+8fhFnOwt0L/rUaKew0gFSZvY5Lpz2zHvb7hpWTlkfRHXCCudbTH
 NjbqTd7vu2uHwjBebS/OUeJmDZ5kRHU=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZL3teJBa
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3 0/6] igc: Fix PTM timeout
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

Hi Christopher,

is there any new development in terms of this issue?


Thanks,
Corinna


On Nov  6 18:47, Christopher S M Hall wrote:
> There have been sporadic reports of PTM timeouts using i225/i226 devices
> 
> These timeouts have been root caused to:
> 
> 1) Manipulating the PTM status register while PTM is enabled and triggered
> 2) The hardware retrying too quickly when an inappropriate response is
>    received from the upstream device
> 
> The issue can be reproduced with the following:
> 
> $ sudo phc2sys -R 1000 -O 0 -i tsn0 -m
> 
> Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
> quickly reproduce the issue.
> 
> PHC2SYS exits with:
> 
> "ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
>   fails
> 
> Additional problem description tested by:
> Corinna Vinschen <vinschen@redhat.com>
> 
>   This patch also fixes a hang in igc_probe() when loading the igc
>   driver in the kdump kernel on systems supporting PTM.
> 
>   The igc driver running in the base kernel enables PTM trigger in
>   igc_probe().  Therefore the driver is always in PTM trigger mode,
>   except in brief periods when manually triggering a PTM cycle.
> 
>   When a crash occurs, the NIC is reset while PTM trigger is enabled.
>   Due to a hardware problem, the NIC is subsequently in a bad busmaster
>   state and doesn't handle register reads/writes.  When running
>   igc_probe() in the kdump kernel, the first register access to a NIC
>   register hangs driver probing and ultimately breaks kdump.
> 
>   With this patch, igc has PTM trigger disabled most of the time,
>   and the trigger is only enabled for very brief (10 - 100 us) periods
>   when manually triggering a PTM cycle.  Chances that a crash occurs
>   during a PTM trigger are not zero, but extremly reduced.
> 
> 
> Changelog:
> 
> v1 -> v2: -Removed patch modifying PTM retry loop count
>       	  -Moved PTM mutex initialization from igc_reset() to igc_ptp_init()
> 	   called once in igc_probe()
> v2 -> v3: -Added mutex_destroy() to clean up PTM lock
> 	  -Added missing checks for PTP enabled flag called from igc_main.c
> 	  -Cleanup PTP module if probe fails
> 	  -Wrap all access to PTM registers with PTM lock/unlock
> 
> Christopher S M Hall (6):
>   igc: Ensure the PTM cycle is reliably triggered
>   igc: Lengthen the hardware retry time to prevent timeouts
>   igc: Move ktime snapshot into PTM retry loop
>   igc: Handle the IGC_PTP_ENABLED flag correctly
>   igc: Cleanup PTP module if probe fails
>   igc: Add lock preventing multiple simultaneous PTM transactions
> 
>  drivers/net/ethernet/intel/igc/igc.h         |   1 +
>  drivers/net/ethernet/intel/igc/igc_defines.h |   3 +-
>  drivers/net/ethernet/intel/igc/igc_main.c    |   1 +
>  drivers/net/ethernet/intel/igc/igc_ptp.c     | 113 ++++++++++++-------
>  4 files changed, 78 insertions(+), 40 deletions(-)
> 
> -- 
> 2.34.1

