Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3715FC5B572
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Aug 2026 13:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFF3080F26;
	Thu, 13 Aug 2026 13:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3HCU_YTi4rb3; Thu, 13 Aug 2026 13:59:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 171BC80EEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786629562;
	bh=O2KvK+dDWD+lxggjkeFjWjKL6VrmWECW2QAh9Fd6p8A=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F2KW2QKhkUldJC0QI7uok+DQiodvxR+MpvcHwPdz9MAYPH8sejH0FLo14lTbtF0WM
	 OS1bkmstZDzVQJ6nBoQ6gTbDPaFKT5VETOo3SYmGInSjPmXZjFoTuH/0vpRRAoSJOh
	 nY9peAN4Xnb2pZxDFytpCB9Ncp4WVSoAgTSzYRjYuUYvflIsEyhnKkjJp0XM2AwVZH
	 RCwGVQiYnp2OSsNqNS5EWhECtAFG1VAeAVySVyGpfqFpay8nEpCyPavYzisaS/rQbP
	 74RDjRRarq0ZyKPSw740nSHwFOiGGD/IPfssNzkt1PbHm5/kE3xhF4020XTpAxW8sm
	 QSliu0u0qlMZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 171BC80EEC;
	Thu, 13 Aug 2026 13:59:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EB341B8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 13:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 14D7140131
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 13:59:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uIQjT0-Oq4Y0 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Aug 2026 13:59:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6EDE9400AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6EDE9400AC
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EDE9400AC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 13:59:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B2D47437AD;
 Thu, 13 Aug 2026 13:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C151F00A3A;
 Thu, 13 Aug 2026 13:59:18 +0000 (UTC)
Date: Thu, 13 Aug 2026 14:59:16 +0100
From: Simon Horman <horms@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20260813135916.GE265046@horms.kernel.org>
References: <20260811181127.1142095-1-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811181127.1142095-1-david.m.ertman@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1786629559;
 bh=O2KvK+dDWD+lxggjkeFjWjKL6VrmWECW2QAh9Fd6p8A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OafavZya8KFKh3Gg3LOhqKz+WkmMIMr1SuUwv+mr+wJik4AthzfHWiTjr9eOrVuJx
 z4WNzDnndpsiyXXjJNJrm0bhEbANBTRaIYEs4NgnQBtj/YMLCWhi7a5U/4edIdSeAl
 qzmD1DTBQp+Hd2vJHEXv1U1rxDzkthlF6udb/NYf35I5WFyah8nUAj7+X2a8NlU/KR
 5x5HARqvQGMBIXX59hzY30+Ko5j58ZpaIPPuVRK1hC/AFDGutBHaDXA43cl39i1Gmv
 nnSOLklkmBDgrf8tLh2psyxhg98zWJ2aCfi+c+iPKO8IB+TxRo/ag6JQcjKvC2tNNO
 c/iNg4H+0M2jQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OafavZya
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: Fix incorrect LLDP
 filter assumptions
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

On Tue, Aug 11, 2026 at 02:11:27PM -0400, Dave Ertman wrote:
> In commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
> necessary"), it was assumed that llpd_fltr_ctrl was a unique application
> of a filter instance and the other command in the flow was generic.
> This is an incorrect assumption, they are both meant to add a filter to
> handle LLDP packets and only varied in the actual AQ call made.  The
> newer AQ call was created to handle a special case in some NVM images
> where a LLDP filter was already existent and the old AQ command would
> generate an error if a new filter was attempted to be added. The newer
> AQ command would detect this case and instead would add the current
> target to the existing filter rule.
> 
> Fix the flow so that the newer command is always used if available and
> only fall back to the older command when that is the only solution.
> 
> Also remove the obsolete state flag from the PF struct.
> 
> Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

