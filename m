Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9888CC369AB
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Apr 2025 19:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CE768113B;
	Tue, 15 Apr 2025 19:46:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WnhmxDoJen_d; Tue, 15 Apr 2025 19:46:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AFE3680BF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1744746410;
	bh=XcSAipvOk7QdqHottTE0QAFIpuVevSHr/OJdHlNnGdE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=wkeu3oKfuLeXM4ba4xy1s2rxmHpICfaAuUPbuC1tBt1miy0M053loT0+osH3ch8cM
	 bQsmDte9WnzmT7qnn4MZ7VHCVBpRcTD6OU9qIKh6oTDcQM23CoKczmGXq7mYMI93GQ
	 S3Z/YNOYis4Z72ksLWKnU95/RCTrzEqk7PTrsEpgv3Zlv7/YWrtRY+rnZug48LhXhT
	 1vWPGEucLxSjEqUTaWFhHEBld+zJIw/JwsfbRNMf37McWaxPpqY2//vMYlFRFAl8Eu
	 UinoYMrc7Wp5jyb1caZGshjymbaKSkad0YUoKBqaWYWoeP44IKU1IDAs0s9/gAaVXP
	 sEuIp4U7d7lBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFE3680BF8;
	Tue, 15 Apr 2025 19:46:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 83083109
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Apr 2025 19:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E97441802
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Apr 2025 19:46:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id duZJHqq4CujB for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Apr 2025 19:46:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EC07340187
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC07340187
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC07340187
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Apr 2025 19:46:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AC0A35C5958;
 Tue, 15 Apr 2025 19:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EFAC4CEE7;
 Tue, 15 Apr 2025 19:46:44 +0000 (UTC)
Date: Tue, 15 Apr 2025 20:46:42 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20250415194642.GH395307@horms.kernel.org>
References: <20250414131241.122855-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414131241.122855-1-przemyslaw.kitszel@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1744746407;
 bh=Lehm73pFOv1XPw6aNSbvciO5SUYCc++FebrjAsZmbgg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W0REqlYLPqmDBuCvzojlLQA7o2kllp4dWQcXkMlA3Omr171j/D1LlZGIFCjCNDwws
 izVDF07qNNR6eCtksuVPYOBQlGTCrNt7Jf8Sds4Ct4+yawqfT5pEhDaQQWca4DnqN4
 I5haM9kxGzxcJSPzkQDgakt1dmsC4gPPzIdXrPgHthsCZdARsJG2y/aVuQcUNi+3V6
 Bl79QH3Q8/jShegTO2NNyWSi1WqXu/u/4KJ7VGiq4Qj7c9v7Ydyrff4/LMhtUsgCuH
 uVyBJoQkOq8zAOJ4YdaYldDYMi2vl7BdYUPA6npfttdz274Nfppj9BA3uag8C7QLTV
 4ySVAhLl+2OUg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=W0REqlYL
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v4] ice: use DSN instead of
 PCI BDF for ice_adapter index
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
Cc: Jiri Pirko <jiri@resnulli.us>,
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Apr 14, 2025 at 03:12:41PM +0200, Przemek Kitszel wrote:
> Use Device Serial Number instead of PCI bus/device/function for
> the index of struct ice_adapter.
> 
> Functions on the same physical device should point to the very same
> ice_adapter instance, but with two PFs, when at least one of them is
> PCI-e passed-through to a VM, it is no longer the case - PFs will get
> seemingly random PCI BDF values, and thus indices, what finally leds to
> each of them being on their own instance of ice_adapter. That causes them
> to don't attempt any synchronization of the PTP HW clock usage, or any
> other future resources.
> 
> DSN works nicely in place of the index, as it is "immutable" in terms of
> virtualization.
> 
> Fixes: 0e2bddf9e5f9 ("ice: add ice_adapter for shared data across PFs on the same NIC")
> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Jiri Pirko <jiri@resnulli.us>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> CC: Karol Kolacinski <karol.kolacinski@intel.com>
> CC: Grzegorz Nitka <grzegorz.nitka@intel.com>
> CC: Michal Schmidt <mschmidt@redhat.com>
> CC: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> CC: Michal Kubiak <michal.kubiak@intel.com>
> CC: Simon Horman <horms@kernel.org>
> 
> v4:
>  - Add fixes tag for real... (Simon)
>  - extend commit message (Simon)
>  - pass dsn to ice_adapter_new() to have simpler code
>    (I happened to do that as (local) followup) (me)

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

