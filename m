Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAC3ED7B8B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Apr 2026 08:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AEE561CC8;
	Tue, 14 Apr 2026 08:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BQesj-O-H4TS; Tue, 14 Apr 2026 08:44:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AE8861CB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776156264;
	bh=ET3wte8K+UK2w7PAn9uF87YFkYStoAXBNwNcEqaM2oI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=shgbUgW0+nAUZXOuMshktGgXFyslmq7I5itam8O53qceNxlsWLQp4xWrXz11UME65
	 NusyzDZbuFuYRSFd9Mx5FuAMtZi0SFGrx0L5l8iYV81tjxSS6koAk23uL+hZP+IzUT
	 RvxLQw/cal9DxmOVqAb3lQGKVliuMfz4mkP4x5XHvo3NG7FMi6ElwM/erA44MPyz5D
	 ZCYbbjkXgIiAntD9yQNcWOn+todj0VvYJdeK7HeFUMFxkkW2cBJq7UVqkUMWjlNc7M
	 iANYQd217v4G+LeNCVjU6Dp9W4z9ACokbnd7PXYgDS8M/kz0gAYZkGDeGwCHiqe3hY
	 K7d3GwSQsR4Hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AE8861CB3;
	Tue, 14 Apr 2026 08:44:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 246BB283
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 08:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 16B0A4076A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 08:44:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ORhHJSDIDhhD for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Apr 2026 08:44:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 63A13406F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63A13406F6
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 63A13406F6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 08:44:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6837A60018;
 Tue, 14 Apr 2026 08:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048D9C19425;
 Tue, 14 Apr 2026 08:44:18 +0000 (UTC)
Date: Tue, 14 Apr 2026 09:44:16 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>
Message-ID: <20260414084416.GW469338@kernel.org>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-2-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410074921.1254213-2-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776156260;
 bh=s/RPIBdbqtGV3I+qgmGFUomO2XQA39NxOhQnddEQNNk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ma97uWBCalFaX0n7G7DL1RiXBCVKhs+9NXOThx7gK7GXW/QQPYAApBlVF+7Dw+k/z
 wjvZhox7JSgHEknoB/PQW2vf2a5lyyZWV6M/HNgOgtIq/8Uoavd4B47aPcWFSD/sGd
 iCSc3RwNkfetixCuE7YMiu7yCyYCVK8fuBtZxnIfprvlAniYbYwtIgQtGrkhfWWb7g
 roqigTciyc3SWshbHYlewOgCjgGWSfzr2K2clXXtsOg/iyXGWYoLVNO5QL7GFyLRFU
 9FBhaGrK4taWLBhP5vBFDqY2U3u1A7CmUeDcevGnQpOaVrQyKSeY3ecs6R2sTpVYYG
 e4pxX+j4BkC6Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ma97uWBC
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 1/10] ice: translate FW to SW
 for max num TCs encoding
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

On Fri, Apr 10, 2026 at 09:49:12AM +0200, Aleksandr Loktionov wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> The FW uses a 3-bit field in a TLV to represent the maximum number of
> Traffic Classes supported per interface. Since the maximum value is 8,
> and at least one TC must be supported, the encoding uses bit values of
> 000 to represent 8 TCs.
> 
> The driver currently does not translate this value and reports 0 max TCs
> to the DCBNL interface instead of 8.
> 
> Add a translation when interfacing with the FW to use 0x0 as the value
> for 8 max TCs.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

I'm not sure if you want to reconsider this as a bug fix.
But the code changes look good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
