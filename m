Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D4606A88D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ySyQ0LRf;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrUZtdOI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1F9D810F5;
	Wed, 11 Nov 2026 15:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gdlrGbFShYKj; Wed, 11 Nov 2026 15:07:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 20EFD80FFE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794409661;
	b=idMojD6RK4hTpxJwzuT9ZtmeEuxaSdfoDcgTyWdPhY3wGdji5VT90sRsdzCC02YNQM5/
	 xtBpqtQ4fBgJhEi8ERzA7/GK2ngVj26FoXRoiVrOV8O3YAvzieBy88ndFvdqFbNZPGiL7
	 0ZRX9Hwbq/Fxi8dcg0R3aXGMR0qPi8th6fAScUHzkPdldt8pG6KgIVwB0q297CFChCmyV
	 vF+yTOcASNINj11tlPRsQ0j+HZU4QFCoOTokXtlBaAaA5ExPZM3FugkYHjNExklnzITWB
	 /7lsjSh/LU9FwMySmx+R/y0OM+R0k/l/9iGpsQ+cTFb5XRJyJ8AXEr4hmn1/9xR5cNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794409661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xPQJULbkU5hCzjRLb+o7Q2ZPGSrG+geDlDFuQ+ACSYE=;
	b=pq08EA0JnPArer6ZOaaii5ATGgZf0hFIgYbrA30SQHAlxkDiHfg4/QMWWxpo8Ux9GIrF
	 kLIzEkkK5PQOy6NHqNxkdvqOusSlhvhYVEk7pQQDIXYuFn3NVh0tqxYY+KO2+81gVzkwB
	 YE+E4TerKKn0UzNlwJPqDfgrrumx4mv7I13pzlEAdgrbjTqqpHnK7KNQ8nHBUXrkLQWKI
	 v2izONMgKhr0fHg9IPn5kAUevi9DbE3uUv+ydU94cghUiOn4IzRZQL7UkAAmSmqATGeo9
	 amOxruTQoL96Bi9kQZuhU0PX6KK2wGyqUnEQ+A5xOLwit+X18D0UpKBpq1bonndQMig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrUZtdOI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794409661;
	bh=xPQJULbkU5hCzjRLb+o7Q2ZPGSrG+geDlDFuQ+ACSYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ySyQ0LRfuHs9e28bAbHegZE62NugT8qCgn8Vwx1R1IpRAFxv5JChD+33PUQ8y3nwi
	 k4bK4ol2km1JfiGUub6pNUjB8zCi/gWOM0YoUovsrcX63y3H0pzJNzQbXpxCsNqncw
	 vKYgCZAn8/Yff4XQ6THva0V51VIB+M0P4yHojBO6nXQ/KJLaSqpp8r+tKrsyHbDvs0
	 KSRL0phtjlPPd9BpE+bJ6V4Do64YRKux9p67fqHpRz1gvoEV+DH56HQ2ji238OS/u1
	 6uSta2R2e7uNLGURj2uZ+GTBuwA/w22KzPgZwITu6ztQtYmgODeb453kqR4BGsI7dC
	 vyLioTdv67mIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20EFD80FFE;
	Wed, 11 Nov 2026 15:07:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FCF1335
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 15:07:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 252E380FFE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 15:07:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oZGECnZ4HalW for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 15:07:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C33C80FB3
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WrUZtdOI
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C33C80FB3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 15:07:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B8034039E;
 Wed, 11 Nov 2026 15:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9541F00A05;
 Wed, 11 Nov 2026 15:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794409657;
 bh=xPQJULbkU5hCzjRLb+o7Q2ZPGSrG+geDlDFuQ+ACSYE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WrUZtdOIPk3rBgE7q9E0kNq7qzyNVYuaDW0vRnPknI1kqOWAElXhRHngm+iIudmfw
 h9dJU5kkiqefwNqcPX9l3eVnXPgFQ8bRDTMjrG4KwOddDLyVMEdCo4DXSol5oX4sgq
 Y1ahKzbm/KnSo8PLEiLnFwLH8DzEJbe9tziTQ1OrugRR/+2YaMHeSx9lDrGJvmbWJw
 Ovkm6iZGBuFFoVCToOF847s+oZOTayNcMVUFmDjMO5uYxq4WD90CLsyoA9jd89p8/W
 8+hjCkg/UjtJR0eF01v0IFHbY1gtE37C8/VAJ8mk5BMosrGRj3qlYR+TcmQXlk7TW8
 tz2WNovoYFBJA==
Date: Wed, 11 Nov 2026 15:07:32 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: do not classify EAPOL MAC address as LLDP
Message-ID: <20261111150732.GE18859@horms.kernel.org>
References: <20261104220042.1421735-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104220042.1421735-1-poros@redhat.com>
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 11:00:42PM +0100, Petr Oros wrote:
> 01:80:c2:00:00:03 (Nearest Non-TPMR Bridge) is also the 802.1X PAE
> group address used by EAPOL, and the virtchnl MAC filter API carries no
> ethertype to tell the two apart. ice_vc_can_add_mac() therefore rejects
> it on untrusted VFs, which fails the whole ADD_ETH_ADDR request and
> breaks 802.1X authentication:
> 
> [  128.447213] ice 0000:17:00.2: An untrusted VF 0 is attempting to configure an LLDP multicast address
> [  128.447301] iavf 0000:17:11.0: Failed to add MAC filter, error IAVF_ERR_ADMIN_QUEUE_ERROR
> 
> Drop 0x03 from ice_is_mc_lldp_eth_addr() and treat it as a regular
> multicast MAC. Trusted VFs still get the ETH_P_LLDP forwarding rule
> through the other two LLDP addresses and the rule does not match on
> the destination MAC anyway.
> 
> Fixes: 2296345416b0 ("ice: receive LLDP on trusted VFs")
> Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

