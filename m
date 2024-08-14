Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6419BC3DA4A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Aug 2024 13:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 310D38101B;
	Wed, 14 Aug 2024 13:50:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n_tZTK_oFpoH; Wed, 14 Aug 2024 13:50:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCA8A80ECF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1723643428;
	bh=72nBbqk6IbdHlPZKpVzR64dCO/TEOtPgfQS5TuERCXQ=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=1JNOy9krPaJkbqScem0Q+3oetiXdW2yTPtBNh2FboNJmRNiPmS5Y9rT9pSYrw6RnE
	 VF3AcBg/Dn++oxyMVFKbKEDft139W2J96sZ6ZwUN850TGUMR3PhmFLdjtmdwWppHTa
	 RGzOCCe96ELYVpZB4rBsNqGp5cdThaLSGcOAv+NoNB3CAnSpFvrh12aN3X4Nk3F77i
	 g66vlFT++ZmSkUd34OYpv9yAamKKGYLQNEY3kGdFHcSLYL0+VF5DmPVdMsY2zYB/L4
	 E/mkJKeSfYpiVmd3e4D39CTBn81HW02M+13aDNWGZe383O4hjM4mJUN8/96200CCSx
	 j7yol+1h3d7YQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCA8A80ECF;
	Wed, 14 Aug 2024 13:50:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 58C9F1BF2FF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Aug 2024 13:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44D6E40163
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Aug 2024 13:50:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7GDPgJ-CPD3R for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Aug 2024 13:50:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 04DB8400B9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 04DB8400B9
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04DB8400B9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Aug 2024 13:50:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B4E2BCE19C3;
 Wed, 14 Aug 2024 13:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EA8C32786;
 Wed, 14 Aug 2024 13:50:17 +0000 (UTC)
Date: Wed, 14 Aug 2024 14:50:15 +0100
From: Simon Horman <horms@kernel.org>
To: Daiwei Li <daiweili@google.com>
Message-ID: <20240814135015.GB322002@kernel.org>
References: <20240814045553.947331-1-daiweili@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814045553.947331-1-daiweili@google.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1723643420;
 bh=Kw+XlTMl2iL53nQYEy4hsiCKGhI9ZACh2cz6PiKd0Y0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=idHyUaVcWvfxVmA90KoxoIgzCUebYlKNJuASj6XGcJY5KD9cvaDlsksrOoFOPxEN2
 zL2RGNPWR1F2Hrg9v/N8V2rlfpsVAja0mLveUInj6N31j6qtS6dH6U8nvyw831I2oW
 f/X/4CufUTlYykN/THi8WTwOw1zkK21xtufeyPmuaiMcAf1+5MZQ17gvCWhv+pw2bK
 nOgdGI3pOWmb5K52KtlfDwaGHL7YMH6Qf/rjvDh9o0SFteGOnNGLY3/AzlnPaS8IPu
 fIbz0fWdoOeGxwUGcuikPcx4gqvx8L7mYntXgnEPhhf/zCDqXlXKp3LtJcTRhn0iLX
 on/wRZiOuG7Jg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=idHyUaVc
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] igb: Fix not clearing
 TimeSync interrupts for 82580
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
Cc: sasha.neftin@intel.com, vinicius.gomes@intel.com, netdev@vger.kernel.org,
 richardcochran@gmail.com, kurt@linutronix.de, linux-kernel@vger.kernel.org,
 przemyslaw.kitszel@intel.com, edumazet@google.com, anthony.l.nguyen@intel.com,
 kuba@kernel.org, intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Aug 13, 2024 at 09:55:53PM -0700, Daiwei Li wrote:
> 82580 NICs have a hardware bug that makes it
> necessary to write into the TSICR (TimeSync Interrupt Cause) register
> to clear it:
> https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/
> 
> Add a conditional so only for 82580 we write into the TSICR register,
> so we don't risk losing events for other models.
> 
> Without this change, when running ptp4l with an Intel 82580 card,
> I get the following output:
> 
> > timed out while polling for tx timestamp increasing tx_timestamp_timeout or
> > increasing kworker priority may correct this issue, but a driver bug likely
> > causes it
> 
> This goes away with this change.
> 
> This (partially) reverts commit ee14cc9ea19b ("igb: Fix missing time sync events").
> 
> Fixes: ee14cc9ea19b ("igb: Fix missing time sync events")
> Closes: https://lore.kernel.org/intel-wired-lan/CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com/
> Tested-by: Daiwei Li <daiweili@google.com>
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Daiwei Li <daiweili@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

