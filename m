Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FC9C982E1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 14:19:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BE6A6065E;
	Mon, 21 Sep 2026 14:19:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mWcKtX_IO21v; Mon, 21 Sep 2026 14:19:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CD6D060604
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790000378;
	b=MROp5XlxwuSwca5z/XdwCrZW8ZgkPCM8q73MowO3LKxX98r4uxem8cezbPdbMgF+fPw2
	 wf6WyLawdXATYUsguxQDwCrYA/7fUAJr8GUr20vWQEJ14C+SWsks5ORiTVpVWHzy9DbYE
	 SHl2T3Rn4phJYHTtTaRRy41gNmrIJFKKeg/qlRbD0kikrA9ICaNkoAOTv5oJVmFmQ6nXr
	 4+/DJin2MtZfMUXd9Ir9W6Ophk36952TQlHwuTNWO3lPDU4groNhznlPHkQqO5m7ll2Gi
	 +HOfvqIt2JWkgwxq+nkjpENQ9qJk5NdFLAklGFSD5bidYJM9uBcETfMgkA4cR3vihaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790000378;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9pZqmiWn61ItGF8y5ww5UwHxjIOErc/ctQgUFUZ8frQ=;
	b=EWztJ8MleNXr9nhmAXX4L2Gpjg+8ip52H7VrFDK6hriKyio4faz+lSN5JEcaWp7nL9uY
	 twg0lr8+uybjQayzS9fp38kwWayyAgk8gJ0y/QbUr4Wi4EIkmnlL3cjYWMsemrPGZuEhW
	 wSXK7c7mx6JhOVk/l/2gcKm8J8C+P8INHb7mYTdPp6xFKQzQVOKSIrXrzaNuCLf6FdSrf
	 RJ4HReJEmNbKnd3W3etkclajQcyBCDyomiyZe1tLoLZCHLFEL8LyHPZthOETm91+EMzMc
	 SawRGM2+PVv1D8GGg/pCXwdWbAfaNmaBaCaj6VXhIw5kLGN2tbsQerCtmLe+Jyt+1lw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790000378;
	bh=9pZqmiWn61ItGF8y5ww5UwHxjIOErc/ctQgUFUZ8frQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0aGCZiQ+orbm1xM3k8fqEOIvmH1ZP2nWwBbtpNmV9jMcS9Pj/KVAXPc4y46ZCRfX/
	 WK5LWnbMmKVvPAdZZsQ+ZaVdlovAPKwVPHBRJIuEkiK8n627iExa4RAWGlrKBvXBsJ
	 3q4kGSods7x+JU1RtDoyq9reZxhYTQbiXy/O6Wcm8kIr4JfTA7Abg+k8at7qvOuh3Q
	 SCoNJZmfxmvCJOdd9zTaEB2GaP27S3B9JWUre6r/56lxWslsoli35FIv0kBPIBccSe
	 JbGP7Adn3wVNHPGF+TiNvRi3rQcOYU3jSfGx75zdFKtNkO3U3+6kE24p3EMlYZwvBp
	 x+qP6Xd5hOmEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD6D060604;
	Mon, 21 Sep 2026 14:19:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 61C8E2EB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 14:19:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 537B64070E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 14:19:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kCwVSpqUF7qB for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 14:19:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B5008406FB
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790000376;
 b=tWiszIP5fpBKKMRt2NRtJYlW2MAS/4tUvo07bQT1SP5wC/csXx3qpSr6ir/zySVeuJpH
 zh4mAC89Um01zJVZcwxiJklAmpf62a+yslu57YS4XD/lzRwZpKh0mDgupzVP896ZuJfDc
 8swtINjfQHnEafslvWNQxYM37hq1FXTxSh8BDinSzHjHm2QA7ZeMbzlPcxkKL6km8yRCn
 I1tjJCOvILmQ6fLqoBfvt2mP1gCc7/Qsccaih458h30lIezvvP8aWEX8/NCN5wpwOW6vG
 2u5Hb2W/R/xHFwwlZ7/AbECLLkgOTjt27SSZuoINWNgF71A+RVbyAf9cGMC24jqJexQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790000376;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=9pZqmiWn61ItGF8y5ww5UwHxjIOErc/ctQgUFUZ8frQ=;
 b=mdekxeA3hmXBQ0oWwfGepNpryBM7EslB3veGrXM4ikC8oDefs205djfKqdzXTy2mb6IP
 xu6GUEVhw7Zmn/enfdM9wAnXuSY4q3BokCcGeEnFGEK+W5xmCSHGPcpzafQYBPvOYeOuJ
 Vwi0IYaHWqd/5npcXnjKqfuGxJFNJfu3nTELWBtUeT4vWxnboDS7DcXSpwbwBqWp8Nmvb
 Uljyl6UDFl6iIZ4LLr4JuvMSi9eub/KsET0LDVbidN9TZ7uNDZiUqlbDuXOh96J0gSvU8
 4R81HzIVcOUsz9KPolSZjzs2RsPMt7tzLyqoiF9irOCFyns/Um7x9x9x9wAjhswguJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=exDntT7R; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=exDntT7R
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5008406FB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 14:19:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 166A2600C8;
 Mon, 21 Sep 2026 14:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2E21F00898;
 Mon, 21 Sep 2026 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790000374;
 bh=9pZqmiWn61ItGF8y5ww5UwHxjIOErc/ctQgUFUZ8frQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=exDntT7ROjzoXXM5pa3HJBRowLZNlEF8TeFkTUQySPe2wSoKk8e1L6oJUVpha9laQ
 SO5LTEDi6W0bMnrG9w49r8IrksEfhZGGV6mS+KAhIcmqAguDWN2BWNc9ZpxVHq+zHA
 SI9LARuhBbaVzQh5tt55MXhxtnvr+DsRWeV7gfe2E85pEKmYJBTaNFB11HuvATCV8t
 9zQ6EwYi1aYbsX+T6Df0hs7xHViO4w5t5vm4rW88x0a9/kJ2oQOs7qsLhhqkm8saiu
 mDepiPjLrkTsmmSMfnCRZ7aBcpxbRfmOzACwYSEk5Wrw3hl9WEWVd7TGtGtOzCDWLK
 ZudEy6PGZgrrA==
Date: Mon, 21 Sep 2026 15:19:31 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [PATCH iwl-net v3 3/3] ice: support RDMA on 4+-port E830 devices
Message-ID: <20260921141931.GS13925@horms.kernel.org>
References: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
 <20260918133234.4169074-4-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918133234.4169074-4-aleksandr.loktionov@intel.com>
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

On Fri, Sep 18, 2026 at 03:32:34PM +0200, Aleksandr Loktionov wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> E810 and E82X devices do not support RDMA on configurations with more
> than 4 ports. This limitation does not apply to E830 devices, which
> have a different hardware design and support RDMA regardless of the
> port count.
> 
> Narrow the RDMA capability disable condition to skip E830 devices.
> Move the 'RDMA functionality is not available' notice inside that same
> condition so it is only printed when RDMA is actually being disabled,
> instead of unconditionally whenever num_funcs > 4 -- otherwise E830
> would log a spurious warning even though RDMA stays enabled.
> 
> Fixes: ba1124f58afd ("ice: Add E830 device IDs, MAC type and registers")
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thanks for the v3 update.

Reviewed-by: Simon Horman <horms@kernel.org>
