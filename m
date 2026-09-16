Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7357C88E77
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 14:05:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C0E86082A;
	Wed, 16 Sep 2026 14:05:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EymW2uDmmu3y; Wed, 16 Sep 2026 14:05:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1500B6081F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789567520;
	b=JKAgK/V2N9m5sBvyEmosssxbEUxHQAddAcds0B2WzLPsT1VpKh9I092RZVsLgbQNu7Rh
	 23RbeGo/cg9tD5JS/GsQeAyu1AwJoqvJWhWlQPeBAdntQ2Nn8BYiArbXphOcHcGC1BJUF
	 vqjNBpKNz+AMiFo1Ql61FB4c5zbxBBQo8ZOfQLCHK0vNdbXqb8TQ//a3AysGqLXMRANf4
	 qvPtzuZmz6YHGJ1/T6gML5MnDNZ1Atmk93OhmqLb/WqnptIQlTQnAWwyC25jJVwU4cTJ5
	 v7Ne0/ek2gTlsJGy4dCf1VTPyTyjHbaFgH0FQ9GqfTQ2vyjn4VUZbUcf9CYuqjWIrUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789567520;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y8iCSrcNz8wtHNgVBNqPdLAWG2tsycKaP7DS/aKDN/g=;
	b=Cfn0eXXh6Io3bLq0fcnbaljBi3erLz/2McW13oJMGpSFU9TEQSLj7CxPTcc+WOB8Zwd5
	 ymZDFHra3lwi4sThbjnVgBPFcTj6+jD1gq4YvYKNxbv/WTWs7wA+d7EYCwUbAGMQUhfKi
	 638vNSlvEMgql0F81EefsxgJPHiVHS7mj8rlp8B8KEUS7TO9rN2yI7ioS5qo5p9FjAXI7
	 BMWSjNThSAEPbTKQ4wBXtCeQ/+s4ImgJQr2pEZdPq+4wXD2RX1MnZ5SFmwFDWc6oUFePk
	 V3IBAeMC1aehrmELE1qXBe80hqY0Ms/cX86JJFb+wfZiKyEeGYTZPd7sSrTUEklrONQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789567520;
	bh=Y8iCSrcNz8wtHNgVBNqPdLAWG2tsycKaP7DS/aKDN/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PhdOdzuJNDWkf5pWly0x9+da1Qb9tJ024R3mctwId9toccEXvof/dwlEgsR2dB8+T
	 K/WxP9l5A/ISxhnCe7WeajEQpYVuzdENKlrkl9rjds9O1g099xZiJPnR2LaKNF/6Vm
	 adCBGkrz7LTN83gWph774RpJ7/XBHMsV3INf+dOJqV/J1CZa5YMDVnDyI9C9EBWwcJ
	 L9ZKdV/G+njwAk8Qqzu/3hmZymNbq94b4ADr+5iQNgPQ+sHZ3kp8fV4aKv/W11hgUS
	 zXKcXZn4HteudbXKTUPRgJSigRwApYruYS7MQYPEVAYox7eI7a5TYC1hxiBNt3bpbW
	 4lP1Ct0EC45Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1500B6081F;
	Wed, 16 Sep 2026 14:05:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C199352
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D6C880EA8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHTLux3tNNxz for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 14:05:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6B81C80E95
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789567518;
 b=g0gfXPX+yb6NiVSIUC8i3YjhWHjJ0TblNL8USn9vVIr5lynIEWgurebXKXu1jjVTWaoC
 zePNLNBYJgpf4qHGBkIicCUZ6GbiajDG6eoFwCRThzNUDxQdu/E8UqLp6Eu/8KrWi11jw
 Ra+FszALUE14AfY/y0nwTkp962NrGtKE1sH78tlPkI2QzIY6VoWa84kSkHt+UN3S/U/4O
 FM3JrJQH5Pl9uRjj7pFwqCvRQyN/qbwe7pUH6UBWgeXF8exQ3yIg5UokhOhvl20biWYm6
 wcrfN8iDXhUi919SzjMrqI6XHKTk8ZZh53hM6r0xRH0iJrhtbmsq5L+vtaFx7uXUE6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789567518;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=Y8iCSrcNz8wtHNgVBNqPdLAWG2tsycKaP7DS/aKDN/g=;
 b=qlGHhioDf3Kddk5a1HOs0xOyLt1AKThkJ9Kqm4cf6zMS8HSSiTc8ipQhMrtNqO3lmGCl
 mtMnEkk26G223SyzEjzAmjNomSv5nKGHt1nyjwLkRfShGVKPGkc0Q7NRzxZtyUxIueoUm
 tmvwrRbzl9uJXjXFtDg2kWQAOJSh+9dbURs5y1jgiy1s0B04w1bwDbii9C1QLq/EnkpT3
 isj5RzIlX8HDZFSRvBYszwwyhwTMNiS5/xORd11TybzX1E5rDqSSjKqqYNUymAaiI+XSe
 +iYQdnx9XHEPvVbG305VuH+Q9ZWjV0iLzgPPBTRweqId3i9e07daAM3QPB2FTEeELFg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TNwywOo6; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TNwywOo6
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B81C80E95
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:05:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCEBA60234;
 Wed, 16 Sep 2026 14:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8408A1F00893;
 Wed, 16 Sep 2026 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789567516;
 bh=Y8iCSrcNz8wtHNgVBNqPdLAWG2tsycKaP7DS/aKDN/g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TNwywOo6Ti6R12nTlwm7mc5g7JwCjmsJrx3IVkd4C4s+tgUAJZF3nI5Z0mr4uxoYI
 UNW3bOr3e6ejBd7UcO+wiH5TIoCja51uvSEPsqwqlnxoM5pJypMuBR+KZ39ID5BJq9
 nihxWc6QfCNOiKxIPXjqNd9gPeLop5K7Dj9ZQl8wOmqHtKNLslnoB8FkXU/Mt33K1d
 oCN1Jj7XEY6TTwZWNhYFPowVPxqQVpf7lFkZpafm3h/u+i8AfSzDlcYE14gN+U+q3p
 fLR8QVu0c9/H84HlY4h35n4IREUQBG3LhFd1JJ0mtywzr1emZRJ/FeqAuRbOyy0BjN
 XiTA2EVrVGO/A==
Date: Wed, 16 Sep 2026 15:05:13 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Tomasz Lichwala <tomasz.lichwala@intel.com>
Subject: Re: [PATCH iwl-net v2 1/3] ice: fix asymmetric pause negotiation
 reporting in ethtool
Message-ID: <20260916140513.GK51261@horms.kernel.org>
References: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
 <20260915125529.3975723-2-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125529.3975723-2-aleksandr.loktionov@intel.com>
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

On Tue, Sep 15, 2026 at 02:55:27PM +0200, Aleksandr Loktionov wrote:
> From: Tomasz Lichwala <tomasz.lichwala@intel.com>
> 
> Add Asym_Pause to the supported link modes so that asymmetric pause
> negotiation is properly reported via ethtool. Without Asym_Pause in
> the supported modes, 'ethtool -a' incorrectly shows 'RX/TX negotiated: off'
> for asymmetric pause configurations, even when pause is properly
> negotiated and functional at the hardware level.
> 
> Fixes: 5a056cd7ead2 ("ice: add lp_advertising flow control support")
> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

