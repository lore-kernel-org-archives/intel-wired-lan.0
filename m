Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AB4C47258
	for <intel-wired-lan@archiver.kernel.org>; Thu, 25 Jan 2024 11:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 72CD540604;
	Thu, 25 Jan 2024 11:59:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72CD540604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706183958;
	bh=biHPs08dT5XzmM/VMCa9rChUlH5shkrQSS3J208w2iI=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=5mVTQmiPo3BdjjiopiPAbphzlTN0/d8WnRDu5vPTWdE2/JeNSoaXYSRIINM3NNY8o
	 cmwZCMl2ETQv0c1hKKV4wgUZt+PLqFL5LOs6N7B/RqpBVNnLMPrHZCynmLAx9ASUjk
	 AnpmZYiXAuhGLh37EZldYq8WbpbbVNs8C4v9a742/tlkg3jEinAXOcSz++YfYrhzD9
	 HmA/yAmGZrqr72CaSpvAjaQVu6b3c/QhaV341Da34uB197/cv6mtYVQnUfOeoQk2VB
	 uqQZfqN/js8eJbiNxxJHQ81Ph3IoUEPySMEpLtdJeonRpI3mnaCElUGZKt9YHXCyE6
	 cUI8LBcrIdktA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RRHkIC2c-5A4; Thu, 25 Jan 2024 11:59:17 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 83EAC408DA;
	Thu, 25 Jan 2024 11:59:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 83EAC408DA
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 165B61BF20B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 11:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4E6761422
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 11:59:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4E6761422
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bIiL6mqv-3Cw for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 Jan 2024 11:59:15 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 717B7605B3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 11:59:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 717B7605B3
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 99FD6620DC;
 Thu, 25 Jan 2024 11:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01821C433F1;
 Thu, 25 Jan 2024 11:59:11 +0000 (UTC)
Date: Thu, 25 Jan 2024 11:59:09 +0000
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Message-ID: <20240125115909.GK217708@kernel.org>
References: <20240124085532.58841-1-kurt@linutronix.de>
 <20240124085532.58841-3-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124085532.58841-3-kurt@linutronix.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1706183954;
 bh=sy9jnTnu4ekf4cfjw+OBOmGCKjYTwRsNcuaX3R73FmY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z/rv7L1Apr8g+uThWhZEKLyRt2GAuF/PcPSkIfAGWW2iBBScM51/2blHe7ofrnDuf
 MGLwfH4SSvWcjaczDA833/I/kzmiO7XD1TjlJDK6uHTX0Y6GDDILW5qOCRe05FaJXe
 JPjM2DjXBWtAsgSqkrZnJ3QD38ga732MLPVUSdOXlWi5id6aNapzgR8SSIlC+bFiWj
 JYOET5vYHIedEP/RED6XhcTRlicUowSNaBTkN3Rx3PfzcxXrisBtcCOWRfWG3Zbt2r
 nfzwbhSuFRcsYOLeSPHP9bYc4uIqfG/4FTin4Aae+DjaDgEvBWy5aNMn1FladJ5bHO
 Kr4M6MrIDnvdA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Z/rv7L1A
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 2/3] igc: Use netdev
 printing functions for flex filters
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
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jan 24, 2024 at 09:55:31AM +0100, Kurt Kanzenbach wrote:
> All igc filter implementations use netdev_*() printing functions except for
> the flex filters. Unify it.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

