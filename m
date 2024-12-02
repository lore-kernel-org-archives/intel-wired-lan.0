Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57BED78326
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Dec 2024 14:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FD3181A5C;
	Mon,  2 Dec 2024 14:26:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WEvpL_NTnKA1; Mon,  2 Dec 2024 14:26:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE00181AEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1733149603;
	bh=IsetdH9fDJjJoU2ZBEaP9ADCNUPzurAqcJVWe/8HxBs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QgoG9/ns8OsA1+HHb3YkUtCf5F1m11NRtmdfMHGXuKwrDr+yVbRW5g/G+ttJDdQ2t
	 kVU1+ZB4jCKulaHg0+d3g8021NcjiA8ofBwWjhNZvJp8auACT0XKJuG0NLrxTVrtD9
	 ogcGfQ0FTJ9BtVmIuEv1khVJ4VvaGnCcwgk0STJ8QaifNH17fudNxo13yGJZJx1bkP
	 aeHvka1NbchS7csAf0Cu56tD8z7/9osbLibtHOVnXHFoiVSCKQqjI0BDeo5ypZzYoP
	 rsA7gOC0cosH8GHSHBvgJxeuZsZxa3iSYsS4piU/aOmEmzIE/MAA5nZA5hcJciE1Oo
	 ONTN7OLUKFcgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE00181AEA;
	Mon,  2 Dec 2024 14:26:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D53F060
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Dec 2024 14:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD1DD81320
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Dec 2024 14:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vzvblp0i8G2j for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Dec 2024 14:26:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 22D438111D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22D438111D
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22D438111D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Dec 2024 14:26:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 02DE45C5F77;
 Mon,  2 Dec 2024 14:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA66C4CED6;
 Mon,  2 Dec 2024 14:26:40 +0000 (UTC)
Date: Mon, 2 Dec 2024 06:26:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
Message-ID: <20241202062639.30ddac57@kernel.org>
In-Reply-To: <96df3bc7-85ab-4e21-a26d-3785874454a8@intel.com>
References: <20241109001206.213581-1-ahmed.zaki@intel.com>
 <20241109001206.213581-2-ahmed.zaki@intel.com>
 <20241111185334.447a5253@kernel.org>
 <96df3bc7-85ab-4e21-a26d-3785874454a8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1733149600;
 bh=AmudBNYCJmeJXtRs6H3kdNst2ZYo2l226+VYOM8fXGY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=G//t/2svnDaX5LCybS8wzt8zWQKKB0wN68CiNYSI9Nlkwgz6vPqviFIDXb3gr68El
 HkT6vPuKGy379ZlG9t8E7SWIuZcdyty/1PHQ4SXjai0N1VQgzm2DuYx/VWw0Eu2Cez
 HR6/5cAA+t/iAd7uonbB16fXbsdvjBmJ4P71VaCzSzw1dXd/PKzy4k7VbGI3h7qRRX
 55pATJxv59xmbKWMLnabVbq44SieWsY16TOR3Rfv9yDIDg4ZOBeUN2EoCo7mRuM1mC
 J7BN667yCC6faFfyYr63uFFe2/w1Br34ighiyz6FD+8+7+W0wBn8NaCCSJXMVwIxd6
 XIjQgj6SDk96Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=G//t/2sv
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 1/2] idpf: preserve IRQ
 affinity settings across resets
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

On Mon, 2 Dec 2024 06:03:45 -0700 Ahmed Zaki wrote:
> On 2024-11-11 7:53 p.m., Jakub Kicinski wrote:
> > On Fri,  8 Nov 2024 17:12:05 -0700 Ahmed Zaki wrote:  
> >> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> >>
> >> Currently the IRQ affinity settings are getting lost when interface
> >> goes through a soft reset (due to MTU configuration, changing number
> >> of queues etc). Use irq_set_affinity_notifier() callbacks to keep
> >> the IRQ affinity info in sync between driver and kernel.  
> > 
> > Could you try doing this in the core? Store the mask in napi_struct
> > if it has IRQ associated with it?
> > 
> > Barely any drivers get this right.  
> 
> The napi structs are allocated/freed with open/close ndos. I don't think 
> we should expect the user to re-set CPU affinity after link down/up.

The napi_config struct is persistent.
