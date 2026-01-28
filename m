Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B80D35698
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Jan 2026 09:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D197E406A7;
	Wed, 28 Jan 2026 09:22:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R3hAsuylZbIa; Wed, 28 Jan 2026 09:22:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C23540767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769592124;
	bh=2fjoNUbfOIM8UhUstTCpYZgfZ8OMpqLgrhdWkrlQ4T8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yXu5Xluk7c90wHMEvP2lXGRXcrtvDMuGRaFfKedpcoXWFS35xSxx++HbSMQBsCE8q
	 Xpmt3sLqR//Tz2O/pLb1G3ShYlYCMVEXza1RgwyoznvDBZBeM/OjvhEis1MQeCIli3
	 hYphqlTqtMCbayuOXtbmGKPmE23WlTU4uSjD40OYiVr0ihTIbuEALJA46f7FsSEhw3
	 UkZVighrCfUXxvwZQC4D2C6G8PUoX1caEnqaJhkCPMjnwdL3NBNlY3JXgJAINJMfzg
	 +mIKhAdc0xYgIbJQc6ebLfe1fWfm8teS9GyeK4X6g9ZVm2aJD6OQWW5hwkHruSlqBm
	 pI7ibEQ8g528g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C23540767;
	Wed, 28 Jan 2026 09:22:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AAEA1AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 09:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C40360722
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 09:22:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GY-NDfabhCzs for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Jan 2026 09:22:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C6B1D60657
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6B1D60657
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6B1D60657
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 09:22:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 00E1F42E22;
 Wed, 28 Jan 2026 09:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CBDC4CEF1;
 Wed, 28 Jan 2026 09:21:57 +0000 (UTC)
Date: Wed, 28 Jan 2026 09:21:55 +0000
From: Simon Horman <horms@kernel.org>
To: Brian Vazquez <brianvv@google.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Brian Vazquez <brianvv.kernel@gmail.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 David Decotigny <decot@google.com>, Li Li <boolli@google.com>,
 "Singhai, Anjali" <anjali.singhai@intel.com>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Message-ID: <aXnVM9MBRuXWgACz@horms.kernel.org>
References: <20260123204058.651080-1-brianvv@google.com>
 <IA3PR11MB8986BB2FDDBB664CB318FB15E593A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <aXj652w2_ogi6ysW@horms.kernel.org>
 <CAMzD94T=VS8J5A1VZH_KriY7BMHf90rrGEK=4Jyuzc3SxHJhKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzD94T=VS8J5A1VZH_KriY7BMHf90rrGEK=4Jyuzc3SxHJhKA@mail.gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769592120;
 bh=2fjoNUbfOIM8UhUstTCpYZgfZ8OMpqLgrhdWkrlQ4T8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f03/7C7N5F6vtRxB7CndZoLyobtXPUCg6ICyN3DjS2ENDHcR2YY/6NPBMw2RhJDqe
 xTtNVrHgp+cc98ai0UoIDj+9gkaJBCHajjYTEuxIBijx32xKg9oG5Aa+ccbDGP/C1N
 WM4LzQA8z6/lQncvDI56B6yFkq25IZlcRnIGIVLBIFMqqytorNTBx9nHQV7yenJpYl
 0brQDtdVVvNsMCRgI92n1MqquU4CraHyyvYmu9H7nrNcnRwEmswdY6057wwP8R83zk
 DvxcICzmKkplfwzjgISpC7K7lVD1ag64oRBNBQGcY14+c1Hjn0rT5jHCTukR4OPWi0
 VSBiRdVAuYf1Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=f03/7C7N
Subject: Re: [Intel-wired-lan] [iwl-net PATCH] idpf: change IRQ naming to
 match netdev and ethtool queue numbering
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

On Tue, Jan 27, 2026 at 06:36:14PM -0500, Brian Vazquez wrote:
> Hey Simon, last version is v3 it does have the Fixes tag now. Thanks!

Great, thanks.
And sorry for not noticing that earlier.
