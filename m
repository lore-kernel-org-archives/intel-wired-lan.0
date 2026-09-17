Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1277C982C1
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 07:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A77F80EC7;
	Thu, 17 Sep 2026 07:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IogPMpL2803Z; Thu, 17 Sep 2026 07:31:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 02AA580EB6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789630265;
	b=CRD6D0kvkPfFZtFsP6JYnmHjBF3RX4Epj+I9yKKISlBNKHBacJ8//Ly7dxAhKHq6xNA9
	 a/fc1xc3rJ48No93Qp7Bpl/6eaOpgIrcrrfa7IlMFY+y4n0sf0V2zmfGwlx2DpKMWBYWQ
	 H06qSPq6p8VGRywTV3ARGgKbOdqeoJYL9cuXfPKW85Nd3E5ng2WiOvp0rWHyh8DEyJ7WS
	 urIZm6cY4xSXyLiXm+KHx1IiJNmGqyuTuANCNjalfuRioW9SbvBZ0udooLitb5hRBeknJ
	 PTmcGU3rtLGVnr9APTMLNUTCiiSZfEVU5QYKz5vPHcSMXRiJIP8fofbTiidciUkGyOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789630265;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6objJweaZWpw7+NL7md5LD9eSBLoXaSePEDNW90ipzg=;
	b=BnGHxJY7Q4Ow+D2NQ0LJSX8DKwQPa2MepOhMiDnCbFtlcD4Vp+dpxNqCqsgWZNUo/9mS
	 gvj+kLIVOdP4oh1vBQdeLbXgE1Kp2x5PzZojZ+15UZMI3l26iBmQuVbt64W/X1B6wMg4C
	 cWozPWuyul7apGpK+Qy0wKrHS+RHh5YsdlkTXAGz4C5SYyQeSN3FFva/AdL/OCQhnxWyX
	 ZHlqncY3wi6h7jg6idu3BB0Vum3zuaPkQlQMq9TH2nWqH8fk0dm36gDz4BPu4wYcFL5ge
	 ZQqblZCZSuwEvOClYjnoDJO3VklcKA1l9sPQUE2ZM7VySDOmv2/l0ZZs1rZh2y7gA/Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789630265;
	bh=6objJweaZWpw7+NL7md5LD9eSBLoXaSePEDNW90ipzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H8J6Cw6M9wmhCjgub7skiWaWdGG6qK092019gl3jWSl66sBVniX1VBI0sN6TFE0pp
	 q/3X+fur3nW4IbYP3moeY4yUBQxuVkiF1V/NdRWImmLy8LWSXH0ggpxBp1RlIW4ywS
	 mWE2xA7ugq/S8NPJVrfYaWb4ylRBWT7S0ie9M3ejLZJsuhTX07q8/cifJzucvAKyS8
	 IHM0yEz3eTQghMy6+z27ivMGblNNkjiCwwErviW+6xiFp72W+qW0YcWPSJDO/P6SI8
	 OX7LCsyFvqjtK1tHL4Zrg4JV0HRhmYZSiLd7vtUzmrD00TzJkc8kqu0Vo1aJN10GVh
	 DAf8Xx1gL78og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02AA580EB6;
	Thu, 17 Sep 2026 07:31:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A3DB024D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 07:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95FC840770
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 07:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jdD_boFKOwih for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 07:31:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F3AC74076D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789630263;
 b=Q8pt1iTxzoogSAAcVOAFNetElmfU2+2HBVqmdcgHGdBBX78OxDcCUyybtvbrccQdpPf7
 nwwj8MqsGWhff/zNSJa7FjLm93s8GDFXOkrEmnneGJylaxzIUtBDgd1MGe/ie0kWPBKqb
 bgkOC+BDxpMmkBTtbIhRf/UUdsQPPNgyPFd/2fL1gpTAiqNdwk8m8r7sgv/XSDNYzkqNM
 OukKA22om8U+bSgQ0DKlUqZfWSoUVYvs26HbzczL//4CYM7f0Maaa1jjIbeVOWM+2w4lk
 FFjYoFRVXqpyw8rhoTKn3tYhmabeuU40kW9oT3ex+mJ6fSOKiwhoexvIe76abll342Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789630263;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=6objJweaZWpw7+NL7md5LD9eSBLoXaSePEDNW90ipzg=;
 b=OJO3XGVpYb3JTduKgBAyiSN3MoWGx+8m6gchwpdAOYEpx1FqrgtNogW8EvCxM2kttFQD
 1v0fAv5PDYEEScTEKDGkqvzvmLUkuwsiNPGtnPQZtMvvnljqEx4SiLi7cETaHTb+uy+Yx
 y5NMZ909kMeKaFIqbF/sxn88iJ3i2uecTlRSzHfkKx+a/v4zXjuPCsNIWO6CbbGsDaySs
 3PUHExA9N8rEBU/CY0WOmA+vwwjUfRVnAxKFzRSk6xoUS4RUIGJTB1VEmFQG3cscHLG4j
 4G3PdcsPY0UT+JHMogpb/YSarVeaJ9+xgCwxFgE+ne5/9JXpSsuxVi4BJKwv58y9LEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ToC1bB9s; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ToC1bB9s
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F3AC74076D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 07:31:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37C6460200;
 Thu, 17 Sep 2026 07:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD791F000FF;
 Thu, 17 Sep 2026 07:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789630260;
 bh=6objJweaZWpw7+NL7md5LD9eSBLoXaSePEDNW90ipzg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ToC1bB9sSTU5A2aTCk4KtUEZTL4BKe/PIYRjNjhS38ybivA7nB/IvicEnudPosyC4
 cFwm8izFtINWckjAmDdgnxyNfeDMoaN2LId40VozXasMRHnFM3wfU+Vjjdwkw0zVt1
 eApUQIr4vhA24ko5FUI6uqcGE8X1SIlMRicQQ498JbwfDUDa991OcKHEBTM2FpEk4w
 Kpg+YAplZZMpwSNsmjx/8STQgB4EXKGJcsjUxvKj7y1wZaSIb5JDjQZCtMzCC5RwfQ
 MjpK57KROnG37XqqEH5R0QWsmqNUHNvwT9jcBQQO+6XG0JG7SbbDnB4llSN3nAa/cz
 3ZHXePJmslGFw==
Date: Thu, 17 Sep 2026 08:30:57 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] ixgbe: remove ixgbe_ping_all_vfs() from link
 state change handlers
Message-ID: <20260917073057.GV51261@horms.kernel.org>
References: <20260915125547.3975992-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125547.3975992-1-aleksandr.loktionov@intel.com>
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

On Tue, Sep 15, 2026 at 02:55:47PM +0200, Aleksandr Loktionov wrote:
> When multiple VFs are brought up simultaneously, a VF can receive a CTS
> (Clear To Send) mailbox message instead of the expected RESET | (N)ACK
> response, because the watchdog fires a gratuitous ping right as the VF
> mailbox transaction is in progress.
> 
> Remove the ixgbe_ping_all_vfs() call from both ixgbe_watchdog_link_is_up()
> and ixgbe_watchdog_link_is_down().  Both paths contain an identical call
> with the same race window during VF initialization: link-state changes
> (up or down) can arrive while VFs are mid-initialization, and the
> gratuitous ping from either direction collides with the VF mailbox state
> machine for the same reason.
> 
> Link-state changes are already communicated to VFs through the normal
> mailbox protocol; these extra pings are redundant on both paths.

Thanks for including the paragraph above. It was very helpful.

> 
> This removes the last two callers of ixgbe_ping_all_vfs(), so remove
> the now-unused function and its declaration as well.
> 
> Suggested-by: Sebastian Basierski <sebastianx.basierski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

