Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9922ED7B91
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Apr 2026 09:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70C1361CDB;
	Tue, 14 Apr 2026 09:16:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lnmJb5QQIXjA; Tue, 14 Apr 2026 09:16:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A42E461C04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776158193;
	bh=uI0+Ba9k4EIghN0Dkl8qHIQOWdis5PGXG4J0An3GzAU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hAb9pgXpzQ+mIdq5yhdzgxV9V8dCTG/Sv6Mws+03i5ISrltulm6DXJIJwsbMm1cIA
	 /j5K/J1ASQkDN5Qf+flFiMbmshzMxAZREMnoOyPzjZooBiMz8yVHTALghUosSkfw+U
	 NfCCf3GYesyV828RRDs5su4bs3qAxrYFxJsUurtLhLqJVfTSbRxVXGWCjyfV/Hdo0Z
	 6RMNjy2EqnPxv6hBu/HiL3EUU+YMAP0VcBHDTvCOGccMxKFs2pq3SHOJ6BqNygJa6i
	 2spcV9l/bkKuU90SNLGub+FtvLmS5IFVqebdgRXHMENONs2XflGfSrcz/WeUqHdmdr
	 hBoxSgvw8Qpiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A42E461C04;
	Tue, 14 Apr 2026 09:16:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 374F0283
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 09:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 28BB284C4D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 09:16:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XHYE4tQ1-vMG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Apr 2026 09:16:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 802F884C4A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 802F884C4A
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 802F884C4A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 09:16:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B75B040B06;
 Tue, 14 Apr 2026 09:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E78DC2BCB5;
 Tue, 14 Apr 2026 09:16:29 +0000 (UTC)
Date: Tue, 14 Apr 2026 10:16:27 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <20260414091627.GX469338@kernel.org>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-5-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410074921.1254213-5-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776158190;
 bh=XdU3+uXpTQHIkDhg40fCylMNlGQWcd1ytCGfIDJGre4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NwGVb1PjURl89jj6D0za1hOgBuYJOHOhbHYJAVHRMEPiRxT7rNp/VoQL2DttNvyVV
 AzP1cQje3+dbP1GSuMYiT/qXdkSiHReAtUWQzwSz9biONaTrzE8e2VoWalqKGtfHuQ
 dlcS9GVEF4e5kSSiS9U0JZAUlz5EYr5U/8A2mmDf3CGN+yLvDj+8xi0yfQ8mzyiyMH
 J05Iy1sPTEcHKdB9MAYsIFEEsHdDryjrfntuB8YYXZaJx8awahZlsQUX/U8GvGs4lK
 1/FybHYNiGtX+zI0WbFdwICFc1lZj0OVmPrCH+lNGvZxV335gOXO0jGW9usRS1dxXz
 /6qXrLknPeprw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NwGVb1Pj
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 4/10] ice: reorder
 ice_flash_info fields to eliminate padding
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

On Fri, Apr 10, 2026 at 09:49:15AM +0200, Aleksandr Loktionov wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_flash_info structure has a u16 sr_words field before a u32
> flash_size value. This creates a 2-byte hole as well as 3 bytes of
> padding at the end of the structure due to the blank_nvm_mode bitfield.
> 
> Re-order the structure to place flash_size first, which gives a better
> layout and reduces padding.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>
