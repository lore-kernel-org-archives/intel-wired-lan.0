Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C895C25B76
	for <intel-wired-lan@archiver.kernel.org>; Sat,  8 Jun 2024 12:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FC6681230;
	Sat,  8 Jun 2024 12:59:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t8nSp0p8N1sb; Sat,  8 Jun 2024 12:59:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 878AF8136D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717851595;
	bh=i+KbbXY9gJxYyxX36iT3rKk9uSP+5btRiXp2nWgBhyg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=0CpBixZjtZgxEQXE7rn/hLDCUgvDfDW5G7sIcbqXIT2nkkkvb7GDTjYGiXcJxJO9a
	 LfYl4V8PrBL/yejLShT2MCQKCrCciLuRGuM9XZ+Zfbh/xvKannWnCbzp3jQmSEZyU3
	 klqFSL37N5FsWHF8Om44GcjS8T2A+1kvlB9cUTRrDRruheHDqJiYeVzOgJDDrS4OZX
	 MejM/9L+MEjkgvFQN0y2Op1aiK/7g8EhxFSYRfDB12/xtvj/cHcSM8LJGPO06ezWe4
	 cswINTRfW9KlbBBiBEniMtc/OMKUbSRD/6jRL6NU7LCCDChzZSO4Yp0wddBrAEeGSa
	 3rmnTxpoxwfzg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 878AF8136D;
	Sat,  8 Jun 2024 12:59:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id CF2751BF20D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4EBD426DF
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:59:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SVyAx2XC---5 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  8 Jun 2024 12:59:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C41B9426DD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C41B9426DD
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C41B9426DD
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:59:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 82A94CE1D29;
 Sat,  8 Jun 2024 12:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA490C2BD11;
 Sat,  8 Jun 2024 12:59:49 +0000 (UTC)
Date: Sat, 8 Jun 2024 13:59:47 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Message-ID: <20240608125947.GC27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-11-mateusz.polchlopek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-11-mateusz.polchlopek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717851590;
 bh=Kz4eb2k8dxXqorGumPATCT1fbeT9by6ERngbLi3EnJ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UBmHCc+GbsJ84xO2zw02iaN1GUPQhDuMnEb04/80Ky+T/ecH54J1v9x6sMURJK24g
 81FycrJUZk7aBZfBEO8WUVJ2IEN3N/GF2NTTjPeLO5aWJNwi/UhkUnJWXfLcP8LXP5
 SyPQWxZ1XKg2c8La2Vntii4+6fHv7s+r4LHuQ/jvnFB29qKvtMMIw8Ht2BFf+QwVgc
 b1YOswwU0jiYnGaSr5j49aRyptAa6H1ttCBQTqj5aia4GJca0FtqVCFXCcUsV1cnTH
 lb0qVJnUI/mQFWU03pcM3sDIA5Rzqw9BkkBGXQzIOOUjhHYIEWwS8Wv/J9WfdmQgW+
 /2ruRaKAbe3uA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=UBmHCc+G
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 10/12] iavf: Implement
 checking DD desc field
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
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jun 04, 2024 at 09:13:58AM -0400, Mateusz Polchlopek wrote:
> Rx timestamping introduced in PF driver caused the need of refactoring
> the VF driver mechanism to check packet fields.
> 
> The function to check errors in descriptor has been removed and from
> now only previously set struct fields are being checked. The field DD
> (descriptor done) needs to be checked at the very beginning, before
> extracting other fields.
> 
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

