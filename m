Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9B1C25B75
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 May 2024 18:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B51E42427;
	Fri, 31 May 2024 18:15:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I08Gj5p4DIZT; Fri, 31 May 2024 18:15:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8349242418
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717179328;
	bh=/zgSP2yavrchCs0Wdr4flKzKBoJuamTWmsnZPjWE+z4=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=gS1pa33UterXYjj2JmmA5PAyFM8z0FzeIg1DpIWOvj2fU6jdfRc+2RT5B6jycPH9M
	 qn1vh60hultI3SU+FQBh1bBfGL1ptbJiSS5yG7/330I1j5CYV1+vX0Cj0QgwiQKtSG
	 DAPiPyfkzOHg5Zrsjp0nEX3BhQKdQdK5AaklPncaKXkAidJFy0PJOoRj7x6QkA/z3+
	 UWiNHhA6g/LHkvKDchJe2E911cIYlj9+gvFem8C1NXPf6WaUIYRsPKxdn7NywHes2s
	 /FJbk6g3rhM0unxP5hGl55xcTQgp+62T8OtkVZDNuKlmUH/9zlBKBwL24hYCw5xTG0
	 3+OR/MV5CI4Ug==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8349242418;
	Fri, 31 May 2024 18:15:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 006A51BF36D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED9A5606CB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:15:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G5C3Jl-37v1z for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 May 2024 18:15:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 41FD4606AA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41FD4606AA
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 41FD4606AA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 18:15:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id EF3A6CE1B4D;
 Fri, 31 May 2024 18:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E06C116B1;
 Fri, 31 May 2024 18:15:20 +0000 (UTC)
Date: Fri, 31 May 2024 19:15:17 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20240531181517.GH491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-5-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-5-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717179323;
 bh=Wqf/4nMRINsqR/TmXLZx/sDAoqGQhcSMG3F2Th/6ffU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VesrkjJv6up1diwqXuGtbYujr0cqQ07UxSj8iPxgUp6nKGcVSyQK1x6q6bOr6hp8K
 ASQoIP6fkAzBXFwkHysbiQe7YgMm0sZMlxy5cCUkqpwA5SJ25KPlWRJ1fwUZ4rSImJ
 dDGS6oMkPXA/1b07Ibpjq/JsvHk+52Ofthn9Fvfr9pBz03QLZhQ61W6FTlXbse8Uxh
 rxMhGCVTBM15edO3d13YwDZOeREOnHXlvRIasrcv3reJuUL1z59kVH4Y6u1UGDJs+/
 mWDGWiUPp3PC+D0C2bPpUbyjEEWAVUD0VJDTdgT+HB+xFf0kkugMEMMCvsS7LxUAA9
 qzqTK9rXXwbhA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=VesrkjJv
Subject: Re: [Intel-wired-lan] [iwl-next v3 04/15] ice: treat subfunction
 VSI the same as PF VSI
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
Cc: shayd@nvidia.com, maciej.fijalkowski@intel.com,
 mateusz.polchlopek@intel.com, netdev@vger.kernel.org, jiri@nvidia.com,
 kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
 intel-wired-lan@lists.osuosl.org, pio.raczynski@gmail.com,
 sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
 wojciech.drewek@intel.com, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, May 28, 2024 at 06:38:02AM +0200, Michal Swiatkowski wrote:
> When subfunction VSI is open the same code as for PF VSI should be
> executed. Also when up is complete. Reflect that in code by adding
> subfunction VSI to consideration.
> 
> In case of stopping, PF doesn't have additional tasks, so the same
> is with subfunction VSI.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

