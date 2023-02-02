Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3A3C61DA4
	for <intel-wired-lan@archiver.kernel.org>; Thu,  2 Feb 2023 17:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FDC441CD9;
	Thu,  2 Feb 2023 17:34:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5FDC441CD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675359265;
	bh=i+/RyO3E7Lym2/CgmZVmsJFy1nHgiyT9Kn3KEe784bs=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=CjGnXrL1Cxmb9SFqJLZQHbvgjv2mfKOXX2iE0A26IJsl/RxDOcrUbKcliiuJ+YXqL
	 DG3pTak06gTnb0KdEknOS2/GcE4PxzxwuoLubLfbAeDTDsi5ewOhB6v5X/Ofa8TLFo
	 jP+PCA8EFlrirlj7sP7ad/2ErR7aBoSDMd7Ql9ZnnCKIsu5a4EVME120yOcRmtum6x
	 47mNKD44Vzzy/VoW/UhT9TWM10MQAtZmxv7w6v1TZfUIgaX4pZ9huE+kwppGer7YR6
	 CSXcYbDGeOxGaUB8dXmrddsmWbB/Bo/zvwrW/n9Gc7UDOFS5Lh5iY3Vjf3oNfZiYq8
	 bjqe+Ce4BZ5Rg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jwXh3PUAp9i4; Thu,  2 Feb 2023 17:34:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 243C441CDE;
	Thu,  2 Feb 2023 17:34:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 243C441CDE
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 56C9B1BF2FB
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Feb 2023 17:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30C0E41CE2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Feb 2023 17:34:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30C0E41CE2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TKwzy67DhxTk for <intel-wired-lan@lists.osuosl.org>;
 Thu,  2 Feb 2023 17:34:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 444D441CD9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 444D441CD9
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Feb 2023 17:34:20 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-a95UP15ePSSzejngx8BWZw-1; Thu, 02 Feb 2023 12:34:17 -0500
X-MC-Unique: a95UP15ePSSzejngx8BWZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8EE7100F90B;
 Thu,  2 Feb 2023 17:34:16 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A60E403D0C1;
 Thu,  2 Feb 2023 17:34:15 +0000 (UTC)
Date: Thu, 2 Feb 2023 18:34:14 +0100
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Message-ID: <Y9v0Fvek9Hc4i+4C@localhost>
References: <20230201143643.2624559-1-mlichvar@redhat.com>
 <7654b674-1589-8e1f-338e-4556dc716f48@intel.com>
MIME-Version: 1.0
In-Reply-To: <7654b674-1589-8e1f-338e-4556dc716f48@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1675359259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QGndi8l2mOfaSOGTtgohUVdRPr+ct+3qXRlRiSfPYlw=;
 b=UyzLnH+ZGsHuc/u31frhct2c/x/fRZghcpnMjnQOOAbeQhzuRvFbaYUh6j42J2uPv4PZY/
 3h0o/WO8miN6IPCRAWWfI0PV2Net7QmlYG7u2sDOZCbBtnRwuDonfvXq37jAXBq/g3Dxo8
 ztSP9haXGaODOuGReZoB9+vRvrh3uuM=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UyzLnH+Z
Subject: Re: [Intel-wired-lan] [PATCH net-next] igb: Fix PPS input and
 output using 3rd and 4th SDP
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
Cc: Matt Corallo <ntp-lists@mattcorallo.com>, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Feb 02, 2023 at 09:10:57AM -0800, Tony Nguyen wrote:
> On 2/1/2023 6:36 AM, Miroslav Lichvar wrote:
> > Fix handling of the tsync interrupt to compare the pin number with
> > IGB_N_SDP instead of IGB_N_EXTTS/IGB_N_PEROUT and fix the indexing to
> > the perout array.
> > 
> > Fixes: cf99c1dd7b77 ("igb: move PEROUT and EXTTS isr logic to separate functions")
> > Reported-by: Matt Corallo <ntp-lists@mattcorallo.com>
> 
> This is marked for net-next but with the fixes and reported-by, should this
> be net?

I wasn't sure with net as the PPS output feature wasn't tested yet and
it touched new code added for I350 since the buggy commit. If that's
ok, make it net.

Thanks,

-- 
Miroslav Lichvar

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
