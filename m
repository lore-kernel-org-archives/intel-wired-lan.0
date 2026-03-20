Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76718109317F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 07:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 470C18478D;
	Fri, 20 Mar 2026 07:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JtYsBWz22IHV; Fri, 20 Mar 2026 07:35:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8819784746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773992154;
	bh=9PeuPaUAxF6wPEe48zv31ASlM/mVrvhkQC0Ge3mlRlI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TADvsQoLE1IxSqah5vYiG7H8nWLkzKKyWfWxEUyVmxwE4JfAH4E6mEBa2zUSfzciw
	 C51f+cd1kM7wBlqBTfFZHKvA5G+kQvSw+7BmzadnnsCZaR7wI20xi3cOTotNBxxi+h
	 AFUPACN8R2D1ckJoomTXUVSiWSppIBaEwWn2oKd+luFctPkoA5y1Rh/Q3ZeKq+KAFg
	 BW3m/CyLpe6yGcjjxqbp5XdUcfdA96QVMGvNTW41VYj/Ok/4R1Pc+xTLM/+Y5XZqHd
	 62OL0Hf3nVN2uJ50asfljQlzHwc2tr6MeITPZhbrKGdaaS+ZxSTTaD3w/6x2VYteOE
	 ELSiC2aH+weDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8819784746;
	Fri, 20 Mar 2026 07:35:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 468C925C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 07:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23BD084789
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 07:35:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q2R9NGVat2rs for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 07:35:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3259284745
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3259284745
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3259284745
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 07:35:52 +0000 (UTC)
Date: Fri, 20 Mar 2026 08:35:47 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-rt-devel@lists.linux.dev, sgzhang@google.com, boolli@google.com
Message-ID: <20260320073547.yqDmYQ49@linutronix.de>
References: <20260319211335.23236-1-emil.s.tantilov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319211335.23236-1-emil.s.tantilov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1773992149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9PeuPaUAxF6wPEe48zv31ASlM/mVrvhkQC0Ge3mlRlI=;
 b=y8iAz9sMFwZkvlKFSdTHirwcWs3fvhGdg5WOKx0k0FboglbYAI2uVBDTeJ4HudeZaucFbS
 mEubXpZlkuLgCARmp1E9jHuSo5VDW9abwOyuhJKAeFYc+ss8Owc8b5RBpfPoTFD3Yphu34
 iG7fSXsV5KHDfhH6reFd0CZqFR8vjDX/TyBs8LpLIkCuRxHgi2TC7w6bVkIdT0zZDQraeC
 ilA++MWsRDx0V/p9ZibE+vCz04512ddMJgdYhIL5rTOu/V7spGMG0b7KbC1J03GEd0g7T5
 D3rlgWe9B6PyAiIYJ6l0MQATSM5NCQoGQsVKXtvlj8lHsMDLUH/ZGpA3alXPUQ==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1773992149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9PeuPaUAxF6wPEe48zv31ASlM/mVrvhkQC0Ge3mlRlI=;
 b=qgNGs6CoO3SkzuiELhVxh1HMQGJLy4PnEV508XLHDphAOGU1JvTy8pDdYgOhJ3QcpHnm4l
 vPwlXd6i/0uW63BQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=y8iAz9sM; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=qgNGs6Co
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 0/3] idpf: virtchnl locking
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

On 2026-03-19 14:13:32 [-0700], Emil Tantilov wrote:
> The main change in this series is the introduction of local spinlock_t
> which replaces the previous use of completion's raw spinlock. This allows
> us to make consistent use of the xn_bm_lock when accessing the free_xn_bm
> bitmap, while also avoiding nested raw/bh spinlock issue on PREEMPT_RT
> kernels. Additionally, we ensure that the payload size is set before
> invoking the async handler, to make sure it doesn't error out prematurely
> due to invalid size check.

Nice.
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
