Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4798BFCD0C5
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Mar 2026 07:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8E9341655;
	Wed, 18 Mar 2026 07:24:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5XKjDSpfAKgb; Wed, 18 Mar 2026 07:24:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 177FA41520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773818685;
	bh=GMXojMRx2DusSv/c5foBS++mXTfilxtffy+hvVganPA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TmB8OvKIof3svtcqIUH5iV95EbHKLxtAPhWNuekFKlIe25f0/t8OLCZOQ6r9EvVbR
	 O4TYpbWnSrIgpBiaRdD51Vl4JjQmyLFM/Ld9rBXOtUpELhHSUrr/C+rRalQzjp1Nox
	 OalGTrePRIQAN0iUUJWDVBiY7KJkkKU4YPtBQivgRqStOF9a4JMEV3NCiPKcYPl8R1
	 0ZNxTMHCYuXaHRerXkX/9LMcgTf7A6bnppw17zJXa/yEbkH+ZXBM6RzSvY+rJUL0/0
	 5NjuQw/11mhp8nPwgLhz4ukul2g+XTRlevu5qRisu86T7lZQFufb1EaTe9o0wnzIXK
	 eefu6+n806h/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 177FA41520;
	Wed, 18 Mar 2026 07:24:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E5FE7D3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 07:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C73CD608F4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 07:24:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GrHUB3gx4BoN for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Mar 2026 07:24:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B6BE4608DF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6BE4608DF
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B6BE4608DF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 07:24:42 +0000 (UTC)
Date: Wed, 18 Mar 2026 08:24:36 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-rt-devel@lists.linux.dev, sgzhang@google.com, boolli@google.com
Message-ID: <20260318072436.4JmVdDfK@linutronix.de>
References: <20260316232819.6872-1-emil.s.tantilov@intel.com>
 <20260317090054.DuPZ6O0O@linutronix.de>
 <7247024b-fc8d-4a75-ba15-a10399db03bc@intel.com>
 <20260317143850.BLrnAox8@linutronix.de>
 <f77ad6b1-1fff-4f3c-a411-5115bb66e31d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f77ad6b1-1fff-4f3c-a411-5115bb66e31d@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1773818678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GMXojMRx2DusSv/c5foBS++mXTfilxtffy+hvVganPA=;
 b=S7lNnBevReHY99KsphuvNO/RK9P26Ns+4nArqabBAs1aBiuHflX+bv+F5qvBlR4+2ljCsv
 4ghLWAw7eXvoyKM4agFSwLDTsQirl6Cb3lYs15mATHR4H9Suz0KRc7xYxnPuwdz/K6v7xt
 OjyBiWzESZ7awsJbWfKleMx6+RkAYeR3iQK0sATcjWYzoLKnpgtiOdn/MSeJcdEuQmv2j2
 rzQAbKFWbZDajTEQZPXi3OVDJ7cuhgvblcvgWupHh+1hf99uXLAhv3JkQP+m3pZMcabAdC
 j3BjhQUMOeqD5xSj5xJt8twr4bWoUUnSx15waNrj2TS6URBSezG/HxHhTSvkPw==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1773818678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GMXojMRx2DusSv/c5foBS++mXTfilxtffy+hvVganPA=;
 b=sYJiqZbWtA9QAURWngFUcR85rU8xJ40MigLKGcHADExuVS2kSkbUQ+itgzSefupLqBrc/8
 N4d7P2Q42WVCnhDw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=S7lNnBev; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=sYJiqZbW
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 0/3] idpf: virtchnl locking
 and async fixes
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

On 2026-03-17 12:30:39 [-0700], Tantilov, Emil S wrote:
> > What would break if you make that lock a spinlock_t?
> 
> Right. Scope and risk - these fixes are specifically for the async
> handler and I did not want to touch the global locking that will
> impact the entire VC handling. We do have series in flight for -next
> that refactor that code, while moving it to libie:
> https://lore.kernel.org/netdev/20251117134912.18566-10-larysa.zaremba@intel.com/

Now I understood. You fiddle with the completion's lock. That is
something that should not have been done.

> ... that also remove the raw spinlock. With that being said, I can look
> into converting the lock to spinlock_t if that is the preferred approach.

The preferred approach is that, if you pick raw_spinlock_t for locking,
you are aware of all the consequences and you have a solid reason for
it. The comment in the file says
| For now, this API is only used from within a workqueue context;
| - * raw_spin_lock() is enough.

that is not it.

> Thanks,
> Emil

Sebastian
