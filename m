Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6D9C021B3
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Feb 2025 15:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D50C409D4;
	Thu, 20 Feb 2025 15:04:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rLfr-td261Kd; Thu, 20 Feb 2025 15:04:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C6E340B50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740063875;
	bh=ajw+6IfwgA6ixht+ns+aGhYQFHKLIR4nSXgjiVT595o=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H68DCTWDaqnJ6hCvLwatl8EPpWgBgjdSDJ1EcTtMz2pxy2efv9W1zPaqW/KHZEx8S
	 PzMlsgGQ/Rj2YFLUNFScJ7xK+3U7BAONq5BF4EuaWEDsyMfs+63tdDZ43wmRzq6tQ5
	 goFSFblUArX1opsmIpk4jqbf9/BWhAjrCORGcVb+5hE6NS8djn74sQ+biijD2awoyv
	 b2b3q5oq+or4lIEWpciS4IpXvchRcUJ36skgmlfq/JcD+U8KTdpYH2y2+fUeQVzGMq
	 C5agH4skM0ohldXiUUffDBwGnod2JgJGl6iLdxea6mfBXNsANjAGNXIiNwbGjVKZ1j
	 beSx7NON+hkCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C6E340B50;
	Thu, 20 Feb 2025 15:04:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AA455CF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Feb 2025 15:04:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D8E18145D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Feb 2025 15:04:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mKRcLMG5JL16 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Feb 2025 15:04:33 +0000 (UTC)
X-Greylist: delayed 319 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 20 Feb 2025 15:04:32 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D0ACE810EB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0ACE810EB
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04::f03c:95ff:fe5e:7468; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04::f03c:95ff:fe5e:7468])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D0ACE810EB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Feb 2025 15:04:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C2B24614C8;
 Thu, 20 Feb 2025 14:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C84EC4CED1;
 Thu, 20 Feb 2025 14:58:29 +0000 (UTC)
Date: Thu, 20 Feb 2025 14:58:27 +0000
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Message-ID: <20250220145827.GB1615191@kernel.org>
References: <20250214085215.2846063-1-larysa.zaremba@intel.com>
 <20250214085215.2846063-5-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214085215.2846063-5-larysa.zaremba@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1740063512;
 bh=/tfx1qw2RHTeEteUmz3XyOvcWQ/CBxZI1aQubqaoy9k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GQGaiDz8BhXds1NsVdgsL5C5QKPMG2nNe3+dsJXy+s8MR0iMZZLsdM+YnCzeM/jwe
 eW/HWx/i1fTV8mbN7OQ1vv0nK4GdaWL0wNw4vvW7GW03tfWGZfmX80HjlM+cg44TC3
 XiGEJqJ+1iCvX0EE1iRhddMS97BAtY17/nG45aOfpAtK9V8Q+BMJ5i4pTD7Ke3IE/3
 OSCD10I3dQdyD8mbJU2KwyIdWsJ3YI3VeMr3soOiRGLiqL4p7Qh4Ne05/rfqCzFlyp
 rLbP6N2wk/eyeuADd5XRRo1LPgELVDjZEl6aoyk0N+DZC6S9UdIZ/U/k+XPUz48qWj
 gavE5LtITPd0Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=GQGaiDz8
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/6] ice: remove headers
 argument from ice_tc_count_lkups
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

On Fri, Feb 14, 2025 at 09:50:38AM +0100, Larysa Zaremba wrote:
> Remove the headers argument from the ice_tc_count_lkups() function, because
> it is not used anywhere.
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

