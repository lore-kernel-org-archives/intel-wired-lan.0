Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCE5C5CFC1
	for <intel-wired-lan@archiver.kernel.org>; Fri, 14 Aug 2026 08:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 367AE80F60;
	Fri, 14 Aug 2026 08:07:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AAZdjoKKB3fO; Fri, 14 Aug 2026 08:07:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75DA880F45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786694836;
	bh=O2KvK+dDWD+lxggjkeFjWjKL6VrmWECW2QAh9Fd6p8A=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bDOeS1lTF4xCEE101AE6i6S7jppUkTBW0wd03WjQ8VMDOmO8ktvctIG0egsnUT+uv
	 asHvoseony8aZilh9Xed1CWHBBFsdohwl30EBOn5m7w+WgrjjIzGTF3mGshZjHkvou
	 p0TtHOOsT2GwBDnTTqqmCaMEbzNbsp7vkyUelVnQQ1spLeqVoaXrbqixIXpf31NaNF
	 IV91B+r9/FYka5fsqhbt3NP3gzbGZDdCEurHelr8g6TWGQg3pncFk4LozANNGMEjCc
	 yoQGfRftCImG5RBEmDGuYN1h/VuUFu1zfgHfceSr69BE2vE+e9aBIKkkR3NRHTDC89
	 R3OD77eWf8TTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75DA880F45;
	Fri, 14 Aug 2026 08:07:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 703E23A0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 08:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 61E7580F45
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 08:07:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nZi-9SpZdtQ3 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 14 Aug 2026 08:07:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B289D80F2C
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B289D80F2C
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Oqw68CnD
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B289D80F2C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 08:07:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8DD341968;
 Fri, 14 Aug 2026 08:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D121C1F00A3A;
 Fri, 14 Aug 2026 08:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786694833;
 bh=O2KvK+dDWD+lxggjkeFjWjKL6VrmWECW2QAh9Fd6p8A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Oqw68CnD/2E21tXqxDG4JzzNMlTCe5opETTVeoyA/RJiIDbJie0HV0g81Is5cT2Cb
 nX4Eu4y/yiVSv50nH/sLk/YtRoyjDui05afb06saBvIxGswSIjNE6xMoGzoVXxLebH
 nChijFRo07KX7FKVQxKFwlyJN6kyvAtn9BPf/9vA+W839itprAT4wH9fhhd4qLdIz+
 AwWFOZQQay39XYev3HiappYIq1PAfhEWfN2qyGVh9DWI/4+wn95sEvCUrGWx3iPXs4
 sdN5UC7B5vo63Vd8zTU7lL8wbOnZ/4tmvlxfd/CXcvYXQtRntBE1TWyxKDn16+E1UX
 FSZYYO2WMiZjA==
Date: Fri, 14 Aug 2026 09:07:09 +0100
From: Simon Horman <horms@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20260814080709.GF265046@horms.kernel.org>
References: <20260811181127.1142095-1-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811181127.1142095-1-david.m.ertman@intel.com>
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

