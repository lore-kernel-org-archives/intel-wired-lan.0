Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB612C38142
	for <intel-wired-lan@archiver.kernel.org>; Tue, 31 Jan 2023 14:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7299960B45;
	Tue, 31 Jan 2023 14:40:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7299960B45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675176022;
	bh=5fg34iPEKEPSbbfHVOMvBoaEZ71DVGjG30mBMtRCzTA=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=dUlDMx8E5xFPvBrM/ICQvAxxui1yd93BMO8Yg6zB4E1TlZy/yogID2mu4OWdO8myc
	 9vRurQgqVLFSWb7EaQFmlR87ka/X99BYfmExQ/LknzzUrU984WKkHoNvXwl37GD+xT
	 WD0a8iQq2pHNcUJtNavwuXsWVNXsIPu65VmBmciucFxJqFpBtYtfKywt+imFD0ytBx
	 B2bKbgLY7V5sYjY1xzayvEFFlhlQK7MSHCUU+qEtzS7YsNoVg3/N4FHIxVZq7U0QIc
	 nn4swJ98RFqJaMxRhDfgTMuit7iRO2M/BYqqKLqjo2Qrg+yxB2SGE4B5Yjo5WxRJi2
	 TksgR5EYAU/+g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2cZDjKpJnmb6; Tue, 31 Jan 2023 14:40:21 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C3EB60B2C;
	Tue, 31 Jan 2023 14:40:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C3EB60B2C
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 7E2851BF48C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 31 Jan 2023 14:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56D214039D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 31 Jan 2023 14:40:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56D214039D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l_PgVejPJxIB for <intel-wired-lan@lists.osuosl.org>;
 Tue, 31 Jan 2023 14:40:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5915A4037E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5915A4037E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 31 Jan 2023 14:40:19 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-hjZxRiXwNb2ZDonfJgo8Iw-1; Tue, 31 Jan 2023 09:40:15 -0500
X-MC-Unique: hjZxRiXwNb2ZDonfJgo8Iw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD8D3811E9C;
 Tue, 31 Jan 2023 14:40:14 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AC4CC15BAD;
 Tue, 31 Jan 2023 14:40:13 +0000 (UTC)
Date: Tue, 31 Jan 2023 15:40:13 +0100
From: Miroslav Lichvar <mlichvar@redhat.com>
To: chrony-users@chrony.tuxfamily.org
Message-ID: <Y9koTVr+6rY/O2sc@localhost>
References: <4fc70178-dea4-4b88-dc32-8774f977af27@bluematt.me>
MIME-Version: 1.0
In-Reply-To: <4fc70178-dea4-4b88-dc32-8774f977af27@bluematt.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1675176018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oyZjJKFuLo4HXYosv+ucqXvxaDrz/rjp0fVBhPfcwXE=;
 b=XEaKufNAcv0leZZj/AtFpQhcs36TlzQKmsOIloYW7aRiYBoB1ZvzMiYQ6RnIklVdK60w/W
 2WGW0Jti3wctTSqrPPAhqc8Bea4R64fp6+pIOncXOza/rCKM9b+nIEfQ6s99IZnpXilErS
 Rr0Paq7QFvLI4kPISNQTtvwK7pAjZqI=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XEaKufNA
Subject: Re: [Intel-wired-lan] 5.10 -> 6.1 i211 second PPS pin on SDP-3 gone
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
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jan 30, 2023 at 11:24:19PM -0800, Matt Corallo wrote:
> I have a device with two separate PPS time sources wired up to two of the
> Software Defined Pins on an Intel i211 NIC (ala
> https://blog.dan.drown.org/apu2-ntp-server-2/). This works great with chrony
> 4.0 (and even better in 4.3, thanks!) on Linux 5.10.
> 
> However, I just tried to upgrade to 6.1 and the second PPS went silent. The
> testptp utility in the kernel tree shows the first pin working fine, but
> when I hook the fourth pin up to channel two (as chrony does as well), I get
> radio silence.

I suspect it was broken in commit cf99c1dd7b77 ("igb: move PEROUT
and EXTTS isr logic to separate functions"), which seems to confused
the number of timestamping channels with number of pins.

Can you please try it with this change?

--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6874,7 +6874,7 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
        struct ptp_clock_event event;
        struct timespec64 ts;
 
-       if (pin < 0 || pin >= IGB_N_EXTTS)
+       if (pin < 0 || pin >= IGB_N_SDP)
                return;
 
        if (hw->mac.type == e1000_82580 ||


If that works, I'll submit it as a proper patch.

-- 
Miroslav Lichvar

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
