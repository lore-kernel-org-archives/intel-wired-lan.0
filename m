Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053EBC88E77
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 13:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97C3D4072E;
	Wed, 16 Sep 2026 13:54:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id epP3KMpTl8wr; Wed, 16 Sep 2026 13:54:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0BBA540712
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789566847;
	b=BuBY0kxFSBxa5akka/xOff5RxqFz8X3xyRQ06gZkPgtodpADxdyzK94Rafp6e+h8Di8d
	 3AzvqSHp1nVeuUsIJtDQDX1lCvZu9KqmYo++6hvU+/7aPKKzrEsED4xeuFraDIvdHVAUP
	 4+ity7dpzLuE/bVWYgFj9ybAUUqW4fGWzjL35wyk6Tw8DFDDnDmckt7vSWp98SYGPQV4F
	 9HtdHN0pGay5PseQ7eqwwwJL7TJzS03k62Bto6t0AwZJw4HEYUrZSopBjDnIwLjNu7irc
	 eE7PaAFOo3MwdsoyBkHtpxX6215iQToqhU5s/dAi+07+7GHq0AyO6/WLgJgagLgNYsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789566847;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=T9gdB9pKTrrQAGFKq8sKZdE4OBE6MPiU4pD/VQNGsl0=;
	b=GusYwT6prjUFFOFg58IW3PjDIBlFnG0vE1ys2jYkE4sUKe5+zBeARuyWrkHj/B+3BC4q
	 KxqMeFm4A8pu66fH+UgzUxg5dzxocicpKTH7bncsdZK/rIW9RBpa5nCz6yEyqAn9OZpi9
	 pmDsnX8hfJriJR0xZCRG6R+mCMmoKUAN52oHthjZFwrOUdeZa2tif919k01uk72mzT3mr
	 msG47vl7c/SipMekRXcIziaJwRmZbsUk3VeomL0dCPiZMjiLHlAfAediFPzH3JYIrUIYJ
	 D85nRADc9JmvndjNdoBDrilyN8G/VGWOUANbB2VlX7qdQlrJkuu8E7seFKJRl2AA5Iw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789566847;
	bh=T9gdB9pKTrrQAGFKq8sKZdE4OBE6MPiU4pD/VQNGsl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NkixnyfrpULfolCk23PGSahQCqhk/9aAL5qasOkZMEEBXYAQ29ryN0Pf95uTaoNjw
	 NtTaZqNfPxDP3ZCBDRTyepNqGh51oUta2zpRJyANeIvNyHofyaGezdv/eRWKpWP++t
	 lGjq13C4gvlyzGeXtRnEL6VbiXsZArHsktS14RY65MFJohECQ9fHjNKc4p89E6zB2V
	 I2qCiuoguvNVlkA9R5NI/6RRSdI0JpYdiHZHRI1Qg6CAz6XL8kveqq7iwrkyIMb7iH
	 HebNzjLeeXYXGvObkj8ynILVgj99CdlrhKSLbMo2KTxZ7W3q3xkZDOVjWm9s5Kxvej
	 z+is05iQmdZaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BBA540712;
	Wed, 16 Sep 2026 13:54:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 02108DD7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E806D402F5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:54:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wfcHV2FXFF0p for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 13:54:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BDBCC402E1
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789566845;
 b=OLsofIXUlxVSBKwMWwwcCG8l+vBJsTVWhGtlGGtfimCLOY/0nM/9hP0UCY6DdOrXW6eR
 0lXdvv7T/CfGkV1MSYpokIbkPKNnDzhSaNFIC8rCL7RObxozxnV5AkBwaXECo42e5b9em
 oejMmr/cIOliQYtT7HpyKoESKhYiUdHeT0WHJGvxvfqdbJ09ttY+i1qsSHxFhXwd/tgOi
 eqOPecoYzkYdo7nbR6+1TERf0UjyKzmkx37ZH7z7WeRPHurAiiwXcBeyJti62A69EShmp
 iJzAdKU0ltHhm+wgPIuZFKc1BSQOaumxnOu0edRahMS4gDxd4ITJKTc1qJ19J59qfhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789566845;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=T9gdB9pKTrrQAGFKq8sKZdE4OBE6MPiU4pD/VQNGsl0=;
 b=FmpL2hLrnUnRJOx0Aqc0lwgjWrcrFTRBg/fULDhzcl+QQlAqmdLYnvEliCo+in9dUNBZ
 fr4RXftdzw8AvSh+ZhXf3snYB5fZq1b8Z4v17v3fFnGc7Yf8NZUXADIKO6hllcpqpAwZr
 sAggQpK2lfQ/tQxcMS/BDn0bfwgRuj4PIzs3++WUysxIbo4ZqDtinbZCWkXcNstsQf8aT
 3QQIWzlMcUJYIPA2lPrN9e4wnJ6xveaQ7Bs/vH4keVvwLvJyI90jBxii6S7wWCjh+db0n
 IJGIs0c9em4wbd8OecDdeCMLgkV2GeM4R69E1OHnN2XwZCLznHM9vsKxZO4iovIe6tw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Y4YJsVY3; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Y4YJsVY3
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BDBCC402E1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:54:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BF22E602CB;
 Wed, 16 Sep 2026 13:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB7B1F000FF;
 Wed, 16 Sep 2026 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789566842;
 bh=T9gdB9pKTrrQAGFKq8sKZdE4OBE6MPiU4pD/VQNGsl0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Y4YJsVY3AfN3egOYzaErN6dchwdXROQmTBk6VUcq1ev0N6iulsL0ROP3/rLHZgmYd
 oRa3iFjuhfKHT9QrNTulS1CLCezu7Mf+wrQyft1zu5sMQXnyr+gpQCtaMcLnuwrGto
 0S3aQ1V2cur/qTlvePBMXZ/4/EA5/DKZHy7YicY+A3JyJplpeNPcnAFS5Jj1rv+DKp
 hMWiE2ORab3lGeg3PXQ0fC7H8w/jpG5eDB1ui4eFsqZLnzYC0fmQ5J3x0VthTqv3n4
 ITFl6NsPeqT0u9fMCrja3qjULZuDbST+XA6bxqjQnwfC5VorGcclIfPgofNUXMrbo7
 DYdlBLDCn+Tog==
Date: Wed, 16 Sep 2026 14:53:58 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2] ice: fix LLDP AQ filter fallback not working
 on E82x and E830 hardware
Message-ID: <20260916135358.GJ51261@horms.kernel.org>
References: <20260915125525.3975646-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125525.3975646-1-aleksandr.loktionov@intel.com>
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

On Tue, Sep 15, 2026 at 02:55:25PM +0200, Aleksandr Loktionov wrote:
> Commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
> necessary") restructured ice_vsi_cfg_sw_lldp() to first attempt a
> generic ethernet Rx filter and, on failure, fall back to the specialized
> LLDP filter control AQ command (0x0A0A) via ice_lldp_fltr_add_remove().
> This fallback is gated by ice_fw_supports_lldp_fltr_ctrl(), which only
> accepted E810, causing two distinct omissions.
> 
> E82x (ICE_MAC_GENERIC, e.g. E822/E823) support the same LLDP filter
> control AQ command with the same minimum firmware API version as E810
> (>= 1.7.1). On E82x systems where the generic ethernet LLDP Rx filter
> cannot be added, the AQ fallback silently returns -EOPNOTSUPP and the
> port is left with no LLDP Rx filter.
> 
> E830 has been supported since kernel 6.9 and implements the same AQ
> command but requires a higher minimum API version (>= 1.7.11). Starting
> with NVM 1.2 / FW 7.9.1, the generic ethernet LLDP Rx filter path is
> blocked on E830, making the AQ fallback the only viable option. With
> ice_fw_supports_lldp_fltr_ctrl() returning false for E830, no LLDP Rx
> filter is installed after a firmware-update-triggered reset (e.g. NVM
> 1.1->1.2 on an E830-CC in HPE DL380 Gen11), and the interface stays
> link-down with complete loss of network connectivity.
> 
> Replace the single-type if-chain with a switch on hw->mac_type so each
> family's version requirement is explicit. E810 and E82x share the 1.7.1
> constants; E830 gets its own 1.7.11 constants. The default branch returns
> false, covering any future MAC type that does not implement the command.
> 
> Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2: rewrite as a single combined patch using a switch on
> hw->mac_type, instead of two separate patches (E82x fix, then a
> follow-up E830 fix layered on top).

Reviewed-by: Simon Horman <horms@kernel.org>

