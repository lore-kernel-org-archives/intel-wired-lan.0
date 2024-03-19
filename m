Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD26C54E60
	for <intel-wired-lan@archiver.kernel.org>; Tue, 19 Mar 2024 11:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C911581E45;
	Tue, 19 Mar 2024 11:36:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YRmzROMua3a6; Tue, 19 Mar 2024 11:36:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38DF881E3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1710848219;
	bh=FXrRHrookVpqSYXFvNmkcbNNDOMJQ8Hsm84n41mkVJo=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=4VuPntH/MJIoHKoEw0Ql1EGix1/3DSFP1f2X70m7jKG2bqBLFu4f154n6ZEcqT5/8
	 kOtEpXPvSGS66uGvsIAkcM7jthanLE19eiSAFn+Tu5BV66szON+/xvuvajEONG3uB7
	 jCYQ/6gt1THVAh+cJ9p6L8OBuUSM7tpEswMnrwPrRfMhFnIlRDvivvDn1SS5Snahko
	 lyhsih/olxnI+xE5h8qAaBdrV5YU/7OTaWJX0wnENHTHpaJjovQ8vAMsk8yZ9R+utC
	 pgTKdo5ri2hcQr7azNcaW3DpCuIlB8afo3PGNkOYcHmIPweg4068gxlWcPHXjpusPO
	 D8KYDqEUAtXNg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38DF881E3F;
	Tue, 19 Mar 2024 11:36:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id EF1F41BF427
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 Mar 2024 11:36:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E912581E3D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 Mar 2024 11:36:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oM_oT6BtxlnU for <intel-wired-lan@lists.osuosl.org>;
 Tue, 19 Mar 2024 11:36:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 374A481E3B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 374A481E3B
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 374A481E3B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 Mar 2024 11:36:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 8B3A4CE0D9B;
 Tue, 19 Mar 2024 11:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922E8C433C7;
 Tue, 19 Mar 2024 11:36:51 +0000 (UTC)
Date: Tue, 19 Mar 2024 11:36:49 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20240319113649.GG185808@kernel.org>
References: <20240315110821.511321-1-michal.swiatkowski@linux.intel.com>
 <20240315110821.511321-2-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315110821.511321-2-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1710848212;
 bh=6+wCK+ovT17KkvKndAS+QtxFK5cQkQusDV9tIeTnBSc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lzIHfCf/Y3AubpqAhxj3EHKJa3//OTapYMMAZ+DnxzxEay52ewrs0WKIX/yQMtHCS
 aUZES6NoSJtAn1yVLTp4/YrM53WHuu0nNZ0XN7wabzDT5ykxJP+nfodBv5sPEhsMrF
 8fIQCgFKiKDPrCgm7CjOWkyfK3/5Lhc/yPhwaIx16yao3q3ut4i5vRZcaETjMhmaLH
 aT971ZzOccqZ7NnYSE6iv8wblsOet6kR25KyfnIoiWlFieh7LlPysf3yc2/DOxo5O+
 8hqddHe7qYmoHj1aol10mvA/64TY37Ohw2qfUTcgvcu6Pst1krbJtFMXy3IXOdnFTx
 pWTWLuA9qL3+Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=lzIHfCf/
Subject: Re: [Intel-wired-lan] [iwl-net v1 1/2] ice: tc: check src_vsi in
 case of traffic from VF
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
Cc: netdev@vger.kernel.org, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Mar 15, 2024 at 12:08:20PM +0100, Michal Swiatkowski wrote:
> In case of traffic going from the VF (so ingress for port representor)
> source VSI should be consider during packet classification. It is
> needed for hardware to not match packets from different ports with
> filters added on other port.
> 
> It is only for "from VF" traffic, because other traffic direction
> doesn't have source VSI.
> 
> Set correct ::src_vsi in rule_info to pass it to the hardware filter.
> 
> For example this rule should drop only ipv4 packets from eth10, not from
> the others VF PRs. It is needed to check source VSI in this case.
> $tc filter add dev eth10 ingress protocol ip flower skip_sw action drop
> 
> Fixes: 0d08a441fb1a ("ice: ndo_setup_tc implementation for PF")
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

