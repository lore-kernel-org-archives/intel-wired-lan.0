Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6807AC021B3
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Feb 2025 13:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31B1283834;
	Thu, 20 Feb 2025 13:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y7zaWGIMEiRH; Thu, 20 Feb 2025 13:13:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9207C83A77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740057221;
	bh=3CMGz0e7HPpaEPPltfuOZj7hb1sFhZriOUBJV5LJjis=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QIOX4qB3hcdbERNG+D7kGPu6VEMKKTt14adwmiZy3iKlxP5fN0vl+k1PV8BnKsfpo
	 1/XNYd56BKXtbN1T4MBfNyevSWDYBhENyK793+Wrbyf/BOZCgAXv7iDBxEkR33zQkk
	 owho8FLhAfdNd7hmk5huuYz5aIv5xEk7M/SnNdKuD2yGNHR9D+/VZL77gfR/r2j9vl
	 jGCr4AfAanF+QxaaAQO/lEd8hXGkRXlx4CdP+nl1kC55WF7Vhx3Wqoh90za+7KI8xk
	 AqXt4dba6I9rpkO7yIykMnZCEGh0ItoYyoMO9yhmFRP2JygSud+KwkOHgaSrYfZOo+
	 lCZ12xSjy5DoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9207C83A77;
	Thu, 20 Feb 2025 13:13:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 914ABD92
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Feb 2025 13:13:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 80D726084A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Feb 2025 13:13:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JJse14npNYr5 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Feb 2025 13:13:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DEA3F607DF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DEA3F607DF
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DEA3F607DF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Feb 2025 13:13:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 094595C587C;
 Thu, 20 Feb 2025 13:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41FDC4CEE2;
 Thu, 20 Feb 2025 13:13:37 +0000 (UTC)
Date: Thu, 20 Feb 2025 13:13:35 +0000
From: Simon Horman <horms@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Milena Olech <milena.olech@intel.com>
Message-ID: <20250220131335.GW1615191@kernel.org>
References: <20250207180254.549314-1-arkadiusz.kubalewski@intel.com>
 <20250207180254.549314-3-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207180254.549314-3-arkadiusz.kubalewski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1740057218;
 bh=WQcEldoWuMY6VD0LP+8O3EEjoZrdZmMF74r13S0RwKc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KQ1ymUiMCKGtZOeo15FjA+xnOiX2xHNY4jqtmA0dSTQayzX+9IAEmXhvD5TdCpmF1
 2hiJYNpIuaZxb8cecPil++fiZpFZia7HioE1vdUB87yGOsEwJaMdd1jf9BSs3rALkv
 UWPQmVtp72Pr8iavg5wCD99rUilsKZqkgMUX34ZsQYYd1Bq7TIDITClLrlsPiemxPU
 RzQl9Ads1Wxzy/ABPGhGDpXRRudkHG8Cqd8dMRf0ovEJjNrcX0wd84h6oDku4yxnVR
 ELONhRGhMkohFOxte1AhH8N1OcXdlglM8tnUErGhDsVHFO5dRF9hMzX+ZzfyEe5Qrb
 I3p1JMdkf6jiA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=KQ1ymUiM
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/3] ice: change SMA pins to
 SDP in PTP API
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

On Fri, Feb 07, 2025 at 07:02:53PM +0100, Arkadiusz Kubalewski wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> This change aligns E810 PTP pin control to all other products.
> 
> Currently, SMA/U.FL port expanders are controlled together with SDP pins
> connected to 1588 clock. To align this, separate this control by
> exposing only SDP20..23 pins in PTP API on adapters with DPLL.
> 
> Clear error for all E810 on absent NVM pin section or other errors to
> allow proper initialization on SMA E810 with NVM section.
> 
> Use ARRAY_SIZE for pin array instead of internal definition.
> 
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

