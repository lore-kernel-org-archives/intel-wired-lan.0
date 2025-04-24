Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497A9C369AB
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Apr 2025 17:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CCBC6FCCC;
	Thu, 24 Apr 2025 17:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmRDFpry5rnq; Thu, 24 Apr 2025 17:19:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA4616FCAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1745515143;
	bh=jTiX4klxoldVSkfI53cYkQ//AWyRiHDVO6lOEls8oDc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CpZ9HgHpnpYwaJ8jZDhTy4JyUC66WNQjzubO5MEpBuWAuCDe1axJrmg7u4I8bDKCz
	 hFlh/eqNVRfZKnFiLC1+eJ4LfyWoL5bBobelg9dCwlcyuZermJGnGf0r/WRqsfrxaD
	 C7iw0Rouz+CiIDtRDq9PGuwebOrT3nNvqjfMOkyx6VZN7l2BHTLVZ/pWR8vvaH8Nzh
	 UdwjNiZhR1RO+8sXNB/mqt67cw98FeauTuDJxWbJ7kDgLcugNnFYtivXJ3eMccJcB/
	 s2zXvzMrtOnOPehJ5MnYHU+MaBZREeZlGLILrIDl+Zgc1qNd5XAaqXR8lFTc96Qjtx
	 t1jSoQQqhp+GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA4616FCAF;
	Thu, 24 Apr 2025 17:19:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 254D22A6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Apr 2025 17:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A3C181E29
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Apr 2025 17:19:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ANpXL8JrAmbZ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Apr 2025 17:19:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 66F6A81E0F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66F6A81E0F
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66F6A81E0F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Apr 2025 17:19:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B86885C64C0;
 Thu, 24 Apr 2025 17:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63044C4CEE3;
 Thu, 24 Apr 2025 17:18:58 +0000 (UTC)
Date: Thu, 24 Apr 2025 18:18:56 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <20250424171856.GK3042781@horms.kernel.org>
References: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>
 <20250424162444.GH3042781@horms.kernel.org>
 <dc357533-f7e3-49fc-9a27-4554eb46fd43@jacekk.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc357533-f7e3-49fc-9a27-4554eb46fd43@jacekk.info>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1745515140;
 bh=UTw/8mwpp1aAVyqy5jlKWuEcFbcgEiGTY6G17jcDkik=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KOGHdP2l+R7HFxRxhUl8RIBFTlITlwCa0aHlQw7QjEU/k/OgkcstzDPfdLF8JBFiG
 NVpRMKXz29UjZtdZATZ0MJrECO7uEAhbjD3tXzsmDz5IQ4jltIVPcbShwMTCc2BP45
 U2DqYiHVAV4ne7gD9Y87xo2mZAVjgFj38Cnpd113JUZP/WMt2G16os8WSVp7q3vyuF
 Go2A0YY9kbXsgqTrPZBSUS5XxrpMe8yi5UjIcMe/jtt2tGQhsV56puE/7nqQ+LHpz5
 MJqVoj4kA0liuBNJfU1/ooMjL54loJtTnK76hMYHi0qIpGI2arB9Do177Il2OQIjuo
 LbThoRp4li7dQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=KOGHdP2l
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: disregard NVM checksum on tgp
 when valid checksum mask is not set
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

On Thu, Apr 24, 2025 at 06:46:45PM +0200, Jacek Kowalski wrote:
> > > Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM
> > > checksum")
> > 
> > I think that while the commit cited above relates to this problem, this
> > bug actually dates back to the patch I'm citing immediately below. And I
> > think we should cite that commit here. IOW, I'm suggesting:
> > 
> > Fixes: fb776f5d57ee ("e1000e: Add support for Tiger Lake")
> 
> I had my doubts when choosing a commit for the "Fixes" tag, but since
> my setup would most likely work up until 4051f68318ca9, I selected it
> specifically.
> 
> On my laptop NVM write attempt does (temporarily) fix a checksum
> and makes driver loading possible. Only after 4051f68318ca9, which
> disabled this code path (because it broke someone else's setup), I'd
> be unable to use my network adapter anymore.

Thanks, in that case things aren't as clear as I had assumed
when writing my previous email.

If the problem only occurs after 4051f68318ca9 then I think
it is fine to use that commit in the Fixes tag.

Although I do wonder if commit 4051f68318ca9 is backported,
will this patch (once accepted) end up being backported far enough?
