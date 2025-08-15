Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E66CA0ED1
	for <intel-wired-lan@archiver.kernel.org>; Fri, 15 Aug 2025 08:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69DFD80AF7;
	Fri, 15 Aug 2025 08:15:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B8pm2b90XmwH; Fri, 15 Aug 2025 08:15:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF38180E33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1755245747;
	bh=J7VKaM9iJKH34FxzXiIc1+Fd96YeVYMts3Y8mchScHA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NRpdl5bejSQgbiFZ9q0GaEj1/C6wkQxmCZsakGtW2IUkerjglw85ic9wyZFb4MD+o
	 rByWnnAFs6TrWejGZ07Q0xZjUTFx593RBD68u8jWpX9OGDJu7f1OPDLm7nXjkcBZJW
	 CRbSAPIU8y7bKHkTFrW/yHwCwBe1NIMFhclazebYnnhH5TZo6rmr21ZK3f1WCZg/+C
	 N8ygVd5rOKmPnvrU4Ke91HtkizA/2AT3FbHzKXQcx2srTIMWkJCNbVwWXQqltREzmV
	 nal4oO3KGNqB7r82n9fDCoMcwbICMgQdPFSRVV520xKlw1n8RVRnyOV+eUROvbm//9
	 8h+o4YRztguDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF38180E33;
	Fri, 15 Aug 2025 08:15:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C51D6228
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Aug 2025 08:15:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ABA86407C1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Aug 2025 08:15:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NyyIdEt3iu6y for <intel-wired-lan@lists.osuosl.org>;
 Fri, 15 Aug 2025 08:15:45 +0000 (UTC)
X-Greylist: delayed 328 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 15 Aug 2025 08:15:44 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EF66C407B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF66C407B4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de;
 receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF66C407B4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Aug 2025 08:15:44 +0000 (UTC)
Date: Fri, 15 Aug 2025 10:10:12 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Message-ID: <20250815081012.gpD_tW0X@linutronix.de>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <a1e9e37e-63da-4f1c-8ac3-36e1fde2ec0a@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1e9e37e-63da-4f1c-8ac3-36e1fde2ec0a@molgen.mpg.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1755245414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J7VKaM9iJKH34FxzXiIc1+Fd96YeVYMts3Y8mchScHA=;
 b=20SJ5Xwdh4qUHhCvZ+SaAOEbWaXwbV385A0CQQ30n0Drk9EFB0h+NjrmnxXYtUeVJBCho0
 VJh0iHScKX9aPI61BwgNItGDXGXVaRVyq0oNXtQXqdTIB/CGVylMBKC98xbzuSjg7nHpE+
 9+hpxTsVcYJ86omUc1WcCSLmzoFE2K9xSE51kFbtpLZHCtpZftJRetKe0UqCkQC6zkFPFK
 q/qNEXcB4gXPBrraPwJP2ztxghp0UACzoTbn4Rk62eJX7zwRMJdsMpKfehgbguFGsJJ7+n
 Z1zT6wX2DJO9DxQ+HDA5jsvaDfpArX5vbmr2j7mq9Z0LzAWAGkBQ4LuOWLfD+A==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1755245414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J7VKaM9iJKH34FxzXiIc1+Fd96YeVYMts3Y8mchScHA=;
 b=qwPsL+1pUwSufHmEQ7kN/yo1DLLp9VPztXweW8OCLeablSkiimeUm6yLsPIk+BLLJakb8g
 OZ1MQH83Dif77oCA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=20SJ5Xwd; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=qwPsL+1p
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: Retrieve Tx timestamp
 directly from interrupt
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

On 2025-08-15 09:55:00 [+0200], Paul Menzel wrote:
> > Therefore, fetch the timestamp directly from the interrupt handler.
> > 
> > The work queue code stays for the Intel 82576. Tested on Intel i210.
> 
> Excuse my ignorance, I do not understand the first sentence in the last
> line. Is it because the driver support different models? Why not change it
> for Intel 82576 too?

The 82576 does not have an interrupt event for this as far as I
remember.

> Do you have a reproducer for the issue, so others can test.

The issue is that the workqueue can be delayed and ptp starts
complaining. If the timestamp can be retrieved directly, there is no
reason for the delay.

Sebastian
