Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4077C4345F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 25 Apr 2024 07:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A70060E2E;
	Thu, 25 Apr 2024 07:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N6W88I7m_qQz; Thu, 25 Apr 2024 07:47:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DEB7760EC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1714031263;
	bh=r6u2GQrZIUPc3UtWj+HqbRZ4C2sJ6DI8OwDGnwuEGQw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=UOIUzdfwCuXFyEIdRZPhwmNhdteRZt1IS2UJnzXnhDceuBbfOwq+qG1ht4Rn1oSie
	 khUHF82DODd0cwQUp2LHM5VqWiiNtyAxa9RnikPTlXjz4fWJc4+2kFYhe5oEigl/r0
	 JuHvIiUb55IrADuD5moORLzTRIbxrtSzw0Kby+/nftT+S6h7l0Tj5+UcUcFmk2A2Wi
	 1gdgtMWYZWTE6MWmDxG1Iv6mrA2jxLZ7YcQuJPwfyH1GTvqHVyihITVA2lOtk8saPV
	 pVHkB8rSmtyMCB1DSRgDG0NWDBLUUazvqCgdSJedLLBtr9hnKU0WrNpvzXzNTYvGKh
	 aenqTXjBOEj0w==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEB7760EC7;
	Thu, 25 Apr 2024 07:47:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 077251BF588
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Apr 2024 07:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E67644029B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Apr 2024 07:47:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LLpWBKA9i1HP for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 Apr 2024 07:47:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=vinschen@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 25F52419C6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 25F52419C6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 25F52419C6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Apr 2024 07:47:40 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-McY1q1EaOMCsVovORRBbHA-1; Thu,
 25 Apr 2024 03:47:35 -0400
X-MC-Unique: McY1q1EaOMCsVovORRBbHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 806E53813F2E;
 Thu, 25 Apr 2024 07:47:34 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FDDA47B;
 Thu, 25 Apr 2024 07:47:34 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 25647A80BA0; Thu, 25 Apr 2024 09:47:33 +0200 (CEST)
Date: Thu, 25 Apr 2024 09:47:33 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Message-ID: <ZioKlQR9z8RWGFAB@calimero.vinschen.de>
Mail-Followup-To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
References: <20240423102455.901469-1-vinschen@redhat.com>
 <033cce07-fe8f-42e6-8c27-7afee87fe13c@lunn.ch>
 <8734raxq4z.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734raxq4z.fsf@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1714031259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6u2GQrZIUPc3UtWj+HqbRZ4C2sJ6DI8OwDGnwuEGQw=;
 b=GUUSGQTBz1UFAP/JIAtepYX+/e/RaprOzVmUuknbNAd9aNDc7m8TQasX1BXu+UzkxaPZD/
 j56+EfpLa2LphT57XUgh0sxHpDXeZxox47qYZNTwE4BBYzAE2YwARuWMNswiiCJamGeONl
 DHSu1Ilk06OD2kynSpWCI+l3HsGrP0o=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GUUSGQTB
Subject: Re: [Intel-wired-lan] [PATCH] igc: fix a log entry using
 uninitialized netdev
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
Cc: Andrew Lunn <andrew@lunn.ch>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Apr 24 17:06, Vinicius Costa Gomes wrote:
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> > On Tue, Apr 23, 2024 at 12:24:54PM +0200, Corinna Vinschen wrote:
> >> During successful probe, igc logs this:
> >> 
> >> [    5.133667] igc 0000:01:00.0 (unnamed net_device) (uninitialized): PHC added
> >>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> The reason is that igc_ptp_init() is called very early, even before
> >> register_netdev() has been called. So the netdev_info() call works
> >> on a partially uninitialized netdev.
> >> 
> >> Fix this by calling igc_ptp_init() after register_netdev(), right
> >> after the media autosense check, just as in igb.  Add a comment,
> >> just as in igb.
> >
> > The network stack can start sending and receiving packet before
> > register_netdev() returns. This is typical of NFS root for example. Is
> > there anything in igc_ptp_init() which could cause such packet
> > transfers to explode?
> >
> 
> There might be a very narrow window (probably impossible?), what I can
> see is:
> 
> 1. the netdevice is exposed to userspace;
> 2. userspace does the SIOCSHWTSTAMP ioctl() to enable TX timestamps;
> 3. userspace sends a packet that is going to be timestamped;
> 
> if this happens before igc_ptp_init() is called, adapter->ptp_tx_lock is
> going to be uninitialized, and (3) is going to crash.

The same would then be possible on igb as well, wouldn't it?


> If there's anything that makes this impossible/extremely unlikely, the
> patch looks good:
> 
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> 
> Cheers,
> -- 
> Vinicius


Corinna

