Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D06CA0FF2
	for <intel-wired-lan@archiver.kernel.org>; Tue, 26 Aug 2025 16:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E8FC6067E;
	Tue, 26 Aug 2025 16:35:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FBJmx8paaih9; Tue, 26 Aug 2025 16:35:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B61E86062C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1756226156;
	bh=vCR/1vRllJ2gc8RoJVA+sCnC6S5vVJdc/lfgoXwz7WU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k2PXBi3OA3v6OCk95Le61qDsepXfdp8yqmoGlIkVo204bNU1rygPeV9V5Jyx1Miju
	 YnNXibBxGGFuY2sgCwxcC0Tcd4wv4g5Lg4I+s0q0v81x7bB5T3AZwh3VlJ+iO/mt7u
	 FfU6mi+k4NndGkuLD9nXRALQY6DEcFO6JBK04S7fpSKaLRAB5GGUxwhCTJAw/AJVhB
	 /1BtDFK5iEibn6fIF4sbpogo4gc+Di9+PjDok4Ad8EszxEPXbLm7wSIKyux+9CJ2BV
	 WJGsjrcy7L/KSBRzl4v8Z2rr5il7HEO5nJ516eKCz8P0TIWJQhvIPnxSYbeCn/yciW
	 K3L+Rij2z+Knw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B61E86062C;
	Tue, 26 Aug 2025 16:35:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B8EC0114
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Aug 2025 16:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9FAF8404B7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Aug 2025 16:35:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fXWrI4NU5QrF for <intel-wired-lan@lists.osuosl.org>;
 Tue, 26 Aug 2025 16:35:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 23850404B5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23850404B5
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23850404B5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 Aug 2025 16:35:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E23E643278;
 Tue, 26 Aug 2025 16:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE65FC4CEF1;
 Tue, 26 Aug 2025 16:35:51 +0000 (UTC)
Date: Tue, 26 Aug 2025 17:35:49 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>, jeremiah.kyle@intel.com,
 leszek.pepiak@intel.com, Lukasz Czapnik <lukasz.czapnik@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20250826163549.GI5892@horms.kernel.org>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-5-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813104552.61027-5-przemyslaw.kitszel@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1756226153;
 bh=BZBDOJvV73+BhoP7SobMXwQs7BVx+ppjYMAdXcPOIws=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i8/kVg+lK6tR95nPwCMXd0w7l6/njP6JOsiKcUPmJKtPwblqk9Xt23m/4Fcha1wUX
 Xh/DuLe4rls49TlOekNQywk0fZPTDSalj6DRHGCzjdwfDTsmswpAxITv9LaCG4C781
 uRxm6WOf/63+f61ZRGdXKWDltq8uW8R0tzDQX56zRNQxM2tbIk8MNHqScipMuO1HZJ
 AX5UW3n5PUAxpwAnbQFidtY4WCwjKsArqHkVsyog/sZdRV1akNXw4HwJLY0xsuBwqe
 +9zxML2BFcwKYyjtx4zH7RLosT4YAK0oTx08zVHCQXCT6cy1XPUy/DvuackfR8Eryy
 xvUMS7+EaESig==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=i8/kVg+l
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 4/8] i40e: fix input
 validation logic for action_meta
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

On Wed, Aug 13, 2025 at 12:45:14PM +0200, Przemek Kitszel wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> Fix condition to check 'greater or equal' to prevent OOB dereference.
> 
> Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

