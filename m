Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5D8CA600C
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 19:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B60780E07;
	Thu,  8 Oct 2026 19:22:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKNGUtPFoRSk; Thu,  8 Oct 2026 19:22:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8EC0780DBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791487355;
	b=doEEBbtwwSmJHfR10jSed31tQyql9qZB2rZGrqKOJYgUr+pFElT/pnEqKNsGoRUoilYQ
	 JDDKrTuvcNuV5AL8b8YdPe6zj34Sl3rTRdYl2NSV9HcURpolE+D3rpAx0e0jzAR6cxArD
	 Qtc82Zw/mqFnMsb3r4olfDg5o2ie02XtFN9RPhoqBMRXmmexJfIuEywXzs83KW+2+f5YF
	 8wg4n+Y3yIoSnNHfaVqjs9snZEFHGJU+WeX9O6FM5GGE0J49SjWmwajruLCrvpl861pPP
	 ym38Wl4VyrCc1vLv58cZImVJDDYn/4AoAjnLLc2uqbVolDeRD7uooTybQnmVF587ioQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791487355;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HmvTIBcQxpjE0Q5G82DExkCUKuqcSZhaYlKA+bieC6s=;
	b=LOdWf/dQI5lJlSS6WvleN9A7FILltJizSPvzXT4ltJEC7nHQb1Z+7eaRHoRcPFRzbH3t
	 elz6JyTDtTjntWzTQsalG8h86GLzRIMhLlQX315yBmeFDBazQaKoOCbKDMz3HoklLu5P3
	 XvhIzPjRwZlovxl+8WI3t0J7n7kNPPihWyx34VbIq40j3w4CXLJ+3cJmlEDui/3sGfyNg
	 dZCRbhEl5zH9Te8yiodFB39XJPDe68T/A3ArS19DCGTrKq4Q9InXXmhikSCYsp2tUkLVz
	 wTo2ygStitIugqdq3Uxli0YFbV8NpRNZxJcDz/q9gcCNBwZsK31ydWEVUqawTnJUIxg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791487355;
	bh=HmvTIBcQxpjE0Q5G82DExkCUKuqcSZhaYlKA+bieC6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3hXq8fR40OrIcCckBiF55dKinO380cAobb3gHyAcY7Fku0l2h7SP7YSKEes9XGyMu
	 zqURX+lu1WDR10yEkqOuWqPc50pDJYuteCNZ5LH874SMJyi0NMF6Ta2TKiyUFShote
	 T6X7X52BvQD2Bqc0i7YxxQ1c5ES3ETylPwTYO3EwCyjQGNtTxVoQp+xUyUDpcPSA1e
	 MogOYbPdyIsb4OBWI/B7eEKv0Kf3QnCIJp4DZqWq6nUeoBwAY6XXhjF/5DRxiI0m/s
	 jzdoFk0HvhxsdkQQyJVwIe1EUI8u/hQyfhgVyxJmGTvj00lmWybEIPQCpDwsZ5NkzV
	 L5Dbrl6HLzl1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EC0780DBA;
	Thu,  8 Oct 2026 19:22:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BBC0C2E0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 19:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADF8C404A8
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 19:22:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3m6cHVK1NMW1 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 19:22:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D7A054047C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791487354;
 b=HDGUWxGgiW2LyQy63d7zOUznuAegmq2TuxvCzgtRLVOW91zmRJNELECJPvufXLYAnfo3
 uG0NxBPeXLU8iadzhauGDu8JLtu6mmiCI+IMeDOfRaqLhGm3XCZ2e9lC3e1obtNOCYCXn
 oEoMrda6EeaD4X3PSr9IroL3JdIzKQNZ/Ljw0r4aXIpb8DoGFvZWy2zLam5VvUBWDWfE0
 uV8h1UCtAeHktdx8TxW1BLE75TjQV8NDl/iZ/pF8QGkfgfkNxaN5a0S0+hePZn8UMF24B
 q/LhQ6YlvVJeCVsa619KiutUGsu3q4ZWl2WRe8EP6XQYxAvZomBQY3Yl+Bnlbv+CuKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791487354;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=HmvTIBcQxpjE0Q5G82DExkCUKuqcSZhaYlKA+bieC6s=;
 b=M7d+phYvm1ILPpLx1M+zcnVksPXNDtbfeOT1nezqVu0ajzXdfgYjrKqMo0Yd+ZbPVElU
 ZnvavWzgz8+xnj9IBUewVqqGh66KQLlwCLF1Rho6BoZF829dvOPgaLVGAXLUQd14TOKEm
 FxGy2pEoXVUupK4z9KuvXA7DLiLiMqnvi3q5k9qH6qKqiKnDWmJt3mwbtu+Mu8iPnNdVq
 MzVn+ez+hzREayiug8aFNguvUatDJ8wKCwq03MxFcKf4BsNghOCqy4zEjx4h6tt/NYSJC
 oyyZCnw7vlZsl94fmRLjMWuwTnfqgQ3SV+0mYJBRy1aw0AQ5sdSD+QeobFEV7IKbt3g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XoAIJywl; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XoAIJywl
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7A054047C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 19:22:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E2F9439EA;
 Thu,  8 Oct 2026 19:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3026C1F000FF;
 Thu,  8 Oct 2026 19:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791487352;
 bh=HmvTIBcQxpjE0Q5G82DExkCUKuqcSZhaYlKA+bieC6s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=XoAIJywlXtaocSnvtDEBNLmUI6Fm7HmOrrBHwJZMxP9BUEAh6oNW3oAm5QOIC1RMf
 2Ucgb31lEGShPF+5RWAPM58ldgsmm5+EiiWzAT18Qjx/VDB5OmNBFhUNB5+5RdPPM4
 haXwHSbBmY2XMpFnTU6wQrPjAffi8Be77mSCCuCGQZTcNxViCEL9RU41M7tlwrEX0D
 oFnHxMt4dylbLh50wP13NRvbevnzfhk17v5pmtBcoIsxO2ipCsVX/BcqTDhV+4dq5L
 PU+yfc3acd6R3AJ9ufFvwXwAjRK99bGbCy8bdYj3yRzmMu1IZ0atsqT29b+vMFTTtO
 37GmARNCPu/rQ==
Date: Thu, 8 Oct 2026 12:22:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <przemyslaw.kitszel@intel.com>, <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-net] ice: keep the RSS hash function on
 indirection-only updates
Message-ID: <20261008122231.7713313c@kernel.org>
In-Reply-To: <asfjGzjV7scRJpis@boxer>
References: <20261007200311.730443-1-maciej.fijalkowski@intel.com>
 <20261008083412.23481894@kernel.org> <asfjGzjV7scRJpis@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 8 Oct 2026 20:38:19 +0200 Maciej Fijalkowski wrote:
> > Could you double check if we need the trailing else as well? 
> > Not 100% sure now if I added it just in case or it mattered :S  
> 
> else part seems to be just a move from hfunc being initialized to
> ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ.

of course, lack of caffeine
