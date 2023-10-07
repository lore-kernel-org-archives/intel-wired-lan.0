Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7803FE94139
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Oct 2023 00:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F390460D67;
	Sat,  7 Oct 2023 00:22:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F390460D67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696638177;
	bh=wbovWgD4iwAO8Y8VsE3OnTg/AwPYMyDz9RqSZcXPvH0=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=dDTRRGUrcRREnPR6IqPf2nlc6Cbe7CCyzrQdOy2kuZbcvaDMOb1mRSFeXAk+SfPQU
	 IMRjTAN8QfBm9CLB0PytyLris0eU3oKoKIGsvj+W2M5aB6gg24YFLl8O53rFrQWZr2
	 tnfKQSRRCbg/UbEM8k3WggZgjcwVowiKV+6WbEVz2nwhsx+KBofctOXNMq21vM1QnN
	 U5b/QsSI4PldpRlyc0jVFzLFg/XbYj2Fhzia+Pist61ONRFRqinR8pCEUxN4ror7LO
	 5deB0tPCZPzqXOdaVCgaVGvWzGlnlSACdNMW0t6LKK70Yc7hmCZetcoxI8oZMfbS9u
	 9jgxlrmbMGa+g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BY8WSb3SeAJf; Sat,  7 Oct 2023 00:22:55 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EC9960DFA;
	Sat,  7 Oct 2023 00:22:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7EC9960DFA
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 3E4201BF294
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Oct 2023 00:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14FA783638
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Oct 2023 00:22:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14FA783638
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TyPJjZsSr-lD for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Oct 2023 00:22:52 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DED4F835EF
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Oct 2023 00:22:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DED4F835EF
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A95DF612D8;
 Sat,  7 Oct 2023 00:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D98C433C7;
 Sat,  7 Oct 2023 00:22:49 +0000 (UTC)
Date: Fri, 6 Oct 2023 17:22:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Message-ID: <20231006172248.15c2e415@kernel.org>
In-Reply-To: <20231006224726.443836-2-ahmed.zaki@intel.com>
References: <20231006224726.443836-1-ahmed.zaki@intel.com>
 <20231006224726.443836-2-ahmed.zaki@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1696638170;
 bh=1BUaZMMqeVoMjxtWGj61G/fPUFnRdfmeq8RRHm9Afao=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tXBV49x9rKgM6epMxAqC8fscSz1He1fGGH+TQlQOP3lInkJgrxGQPxCV0iXAdzsIg
 gjGnly/3owUlWuEvkYpfPdQ0lbfj0qm7WTEn/8RIlZuNjggB4Uy+vFnDLQnUIigCyc
 /gtMtNyya3K29aEFAhOduPLa7Xc2svO/ZZRoNNjyw6ZWMa0oVOV+NJ5AEivmA476uY
 J8V876MGA9t5r5/bE7iItYOk4CCwOFOVY4D1VsuGTWu3ly7Rnj2X7s9aG+zikDZdKX
 EOSEYM/Yg+ii7/f/TkhX47i9yzYVftobwMhYfyomsK3SHf1Xhj8xdXVJkWNKzW6o7u
 A65nmtO1Nj0aw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=tXBV49x9
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 1/6] net: ethtool: allow
 symmetric RSS hash for any flow type
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
Cc: mkubecek@suse.cz, andrew@lunn.ch,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>, corbet@lwn.net,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, jesse.brandeburg@intel.com,
 edumazet@google.com, anthony.l.nguyen@intel.com, horms@kernel.org,
 vladimir.oltean@nxp.com, intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri,  6 Oct 2023 16:47:21 -0600 Ahmed Zaki wrote:
> Symmetric RSS hash functions are beneficial in applications that monitor
> both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
> Getting all traffic of the same flow on the same RX queue results in
> higher CPU cache efficiency.
> 
> Only fields that has counterparts in the other direction can be
> accepted; IP src/dst and L4 src/dst ports.
> 
> The user may request RSS hash symmetry for a specific flow type, via:
> 
>     # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric
> 
> or turn symmetry off (asymmetric) by:
> 
>     # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n

Thanks for the changes, code looks good!

The question left unanswered is whether we should care about the exact
implementation of the symmetry (xor, xor duplicate, sort fields).
Toeplitz-based RSS is very precisely specified, so we may want to carry
that precision into the symmetric behavior. I have a weak preference 
to do so... but no willingness to argue with you, so let me put Willem
on the spot and have him make a decision :)

Please make sure to CC Willem and anyone else who commented on previous
revisions on future versions!
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
