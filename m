Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39AEC77B7C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Jun 2025 09:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EC3640661;
	Tue, 24 Jun 2025 09:40:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0lW-W64zN18F; Tue, 24 Jun 2025 09:40:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9EA24067B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1750758036;
	bh=00yMNFSWtxgt5hkYL1i4qzE9f3cPokzadCSy+chtGqk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=trG/SkMLOrQGtKoY0xAeBTb+hDD45XQzGHRd++WZJBeL1VodBNAdfyouJXbxJbHC0
	 zR0qYod5NcwlwW6ct8nE+PXxOiwOrTx+PsuG9kScto7xy8iNQzK8b7Hre3S6OedXMT
	 6g3Y0esr0t5S/PH1OXQQsjN5uL4XA+8WkJylsNuFeyHVq4V1QTvrkZ74osDLefKHyr
	 +B498y4pGpu4JSkGZUtkSK8mMUloE18WP+3g3boJIYuBXtv/qOUmHVINExJ/6FQMqd
	 pINZIAl/BsCb0SE2RfgNMkyoitveUQthkz3Iyc3JBx8k59y8RU7gOSSL/toYZOaw1y
	 D2nYw8WFOpmZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9EA24067B;
	Tue, 24 Jun 2025 09:40:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A53A5154
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Jun 2025 09:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C0C640653
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Jun 2025 09:40:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tYWi8NB_FLQO for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Jun 2025 09:40:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 039D540266
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 039D540266
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 039D540266
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Jun 2025 09:40:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 644FAA50788;
 Tue, 24 Jun 2025 09:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2075BC4CEE3;
 Tue, 24 Jun 2025 09:40:31 +0000 (UTC)
Date: Tue, 24 Jun 2025 10:40:29 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Madhu Chittim <madhu.chittim@intel.com>
Message-ID: <20250624094029.GA8266@horms.kernel.org>
References: <20250620171548.959863-1-ahmed.zaki@intel.com>
 <20250621121346.GD71935@horms.kernel.org>
 <c4164071-60c8-4b06-a710-70d5fbef2b11@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4164071-60c8-4b06-a710-70d5fbef2b11@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1750758033;
 bh=Cpfcu9O7Ls8RlW8eq9xxiKyHH7JRVWmMSVbstUW5zcY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VMLlRpW+3fB0tMyUrHPX2cg97003Q17gQWB29Np4BkL9bkcC9C+ufG4csJZjG2dP2
 EFOHpybbsFuyRIatceYeW9YjmVpVd0nF4+Za+qCZBNrz5xeqDvTHVxCYPBqqL2109o
 a8wlFnlJIgJpn31Kb2bTzYPiKCScC0dx19M0O9w09FF2rkphRK4k0fE5Nxf84av/An
 rzu/kxFY9BGcqxRKAxj+IKs5kZQeiOHIBbtJ0otZ0yiDlAWTrV3VH/sHsx52EL7BtN
 dRI9dpC2ApI6OTVU8wyEDwK0/urYXoFP3u9EDItN4wMmBUWicStCK4UFqPKfVktak9
 pIQJKvb2qqUKg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VMLlRpW+
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] idpf: preserve coalescing
 settings across resets
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

On Mon, Jun 23, 2025 at 09:48:02AM -0600, Ahmed Zaki wrote:
> 
> 
> On 2025-06-21 6:13 a.m., Simon Horman wrote:
> > On Fri, Jun 20, 2025 at 11:15:48AM -0600, Ahmed Zaki wrote:
> > > The IRQ coalescing config currently reside only inside struct
> > > idpf_q_vector. However, all idpf_q_vector structs are de-allocated and
> > > re-allocated during resets. This leads to user-set coalesce configuration
> > > to be lost.
> > > 
> > > Add new fields to struct idpf_vport_user_config_data to save the user
> > > settings and re-apply them after reset.
> > > 
> > > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > > Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> > 
> > Hi Ahmed,
> > 
> > I am wondering if this patch also preserves coalescing settings in the case
> > where.
> > 
> > 1. User sets coalescence for n queues
> > 2. The number of queues is reduced, say to m (where m < n)
> > 3. The user then increases the number of queues, say back to n
> > 
> > It seems to me that in this scenario it's reasonable to preserve
> > the settings for queues 0 to m, bit not queues m + 1 to n.
> 
> Hi Simon,
> 
> I just did a quick test and it seems new settings are preserved in the above
> scenario: all n queues have the new coalescing settings.

Hi Ahmed,

Thanks for looking into this.

> > But perhaps this point is orthogonal to this change.
> > I am unsure.
> > 
> 
> Agreed, but let me know if it is a showstopper.

If preserving the status of all n queues, rather than just the first m
queues, in the scenario described above is new behaviour added by this
patch then I would lean towards yes. Else no.



