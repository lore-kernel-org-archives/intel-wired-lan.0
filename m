Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC50CA0EED
	for <intel-wired-lan@archiver.kernel.org>; Mon, 25 Aug 2025 07:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C17261C76;
	Mon, 25 Aug 2025 07:54:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8N1oia3o0PRk; Mon, 25 Aug 2025 07:54:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C413C61C7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1756108442;
	bh=6HSbEb9TE9a0hDvp7QsHnLnkasX81TE79idDzsvFWLk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eB8vmE5PkzfmsRqyfez2HhRGH5WOcaZYtyV4K0LmiomolEfZ/cSr8mm7Uzq2FzWor
	 ip1HTlgSI7iuW0g3bKRFTxFzryhy3S2gT9/yds0kqLycagoG8iXslEruMvjX248z2G
	 J/rRda6WNPqe2GIpKhJ71VheebT3fLt9gSmgq74xg69Ok7M04rgclfsPZlJUVCrxos
	 AdAI43VRu3e/w3oad68iLdtiUOHIO8Ohu9N/Cwneyjq/nPJhzlxalnY/eSKIRvD07T
	 HJpfgRid2qMmUzUHgiirecY4IuQ99LOtek+j4avAaby9CGDqPHROxNQr6TiuYxzVji
	 Q49PA9scRICLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C413C61C7F;
	Mon, 25 Aug 2025 07:54:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B256B114
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Aug 2025 07:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3EDE4286E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Aug 2025 07:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LCRJHZ96Iqa4 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 25 Aug 2025 07:54:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mlichvar@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0D4E042864
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D4E042864
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D4E042864
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Aug 2025 07:54:00 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-X2vwgUQBPU2mq6GV33TESg-1; Mon,
 25 Aug 2025 03:53:55 -0400
X-MC-Unique: X2vwgUQBPU2mq6GV33TESg-1
X-Mimecast-MFC-AGG-ID: X2vwgUQBPU2mq6GV33TESg_1756108432
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEB51180035B; Mon, 25 Aug 2025 07:53:51 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE621180044F; Mon, 25 Aug 2025 07:53:46 +0000 (UTC)
Date: Mon, 25 Aug 2025 09:53:44 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jacob Keller <jacob.e.keller@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Message-ID: <aKwWiGkbDyEOS9-z@localhost>
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <20250822075200.L8_GUnk_@linutronix.de>
 <87ldna7axr.fsf@jax.kurt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldna7axr.fsf@jax.kurt.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1756108439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6HSbEb9TE9a0hDvp7QsHnLnkasX81TE79idDzsvFWLk=;
 b=K5KRz0zFZMoCubx5eW9wVvJqOBwWtvLE0S72gkqYUVbx97Bu5rs4fqPzv3iW5nUIEKlcZ2
 GH+8oINfYpnh/K/U+sAyUWe54NyzvkGffgGnQ2FFNWRyBzZaghPZVejqDUAOmO2UJIUvEZ
 weFqUAuYflf7ujvk3n4MPoX+82IyGeI=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K5KRz0zF
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] igb: Convert Tx
 timestamping to PTP aux worker
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

On Sat, Aug 23, 2025 at 09:29:36AM +0200, Kurt Kanzenbach wrote:
> Also I couldn't really see a performance degradation with ntpperf.

I was testing with an I350, not I210. Could that make a difference?

> In my
> tests the IRQ variant reached an equal or higher rate. But sometimes I
> get 'Could not send requests at rate X'. No idea what that means.

That's ntpperf giving up as the HW is too slow to send requests at
that rate (with a single process calling sendmmsg() in a loop). You
can add the -l option to force ntpperf to continue, but the printed
rate values will no longer be accurate, you would need to measure it
by some other way, e.g. by monitoring the interface packet counters.

-- 
Miroslav Lichvar

