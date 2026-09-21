Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A6BC982E1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 10:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42523605EE;
	Mon, 21 Sep 2026 10:34:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YHrPGY50H30U; Mon, 21 Sep 2026 10:34:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B683B60604
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789986841;
	b=PN2lMmAyPl+ya+Mt+QnkRSJr4UGDhGMhX5I+YcZ6HfxhL6gfk+94UKRBpGvr76vrIFsW
	 WBO5xOtP6ygf23o9AcWx09KSgv2Bd2vSQcE0vp14F8QGFoczvmNcqMpxzyNygJ2qxHruo
	 G6XTzcXWs0sirqGovFwGtVCHO/TdzgFQWgUMQMupfpEJRwa21woFEoejoo9yIdEJvvFgU
	 KL9eZYSR+IVtGLQ0vVSGvQuu2g/hXAe+i6N+V/DOyAg3LHzMw3cYAY/qqhp3f0qCfjfgl
	 GVpTq8PCvgB3FwJRBNvknGMJZD6QV9CUebUrC61aH8eNGsRF7IqVDWeAxIYt7aaIh3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789986841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Rztqd+MY24DPWdq7PhM6VuYGeRPhihwJZrVKB7CRiZ0=;
	b=sb1HgBbgahHOqcLaI8TaUQTIUKRzqw7KecotWw35IIqbqH7yJtcEKhfX9tal9fy+8/yM
	 /gRp+rNSsbmBX6vj+LjIvdbqjUTto8k7XM/8X9InXkD9c66s9W0cww1BZ3K3wQvS7OkHv
	 WjxENmasxUqc2zKnLvofoWUsqvrM0t1+poN88xhylCq3QK9+XnH/ZYQik2F3LDHXakckY
	 +qfXHIHdjZoM0IMaE45rdUtxY5IQcATAH/ILdoIO+h7bP39DsUvO9jMmZxG44YskLXjQj
	 it9NchxTtZ4eOWpMQknhrk2Z9gCMEpmSA3SHK0muo8Px/sNBMeI2k3JEU90WlHexAeQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789986841;
	bh=Rztqd+MY24DPWdq7PhM6VuYGeRPhihwJZrVKB7CRiZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Aj+Tma+3MNGeeGe8rVf1YcZDuBOcGQn5Q2As5elbX3ItrnKOAxafb4cLYiZUijltT
	 nY1/5XEy7AYUb/dwp/KQXxy0nA55EBKRWx5A8RvQF468lBZUbqaxomVJlLkkjgRdKn
	 csP15SmikctsluVwuv0PyDUIJ77trBT2kBxS7KFUpgaWYVt9QaCieQMJ565TPjvOUN
	 XONcYuKAIpjS577bKYFiENlVySPImDsX+wE/YnJQbeDQgMHVrOt3JcJKD4hvFtEGLo
	 0cMO9uSC37OzbIjE5MFeqPhX3zWIA0Qr0AJJ9XsTVndOWP9q1YceiSZfjPGW2Ilt/V
	 rguMwrzmc2Gag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B683B60604;
	Mon, 21 Sep 2026 10:34:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D3D201FFC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 10:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA8BA40B00
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 10:33:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zn-oJZP40Dc7 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 10:33:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1619740B56
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789986839;
 b=edoCT7YOjnFBt1mP+vuRjRgCtXoB1wSIM5yBkLSuhkJShYI9MfZdwKq4xri23G/YwsDR
 cwgTSqfrDP7QXjxiqMU0Q48WV7QJHKBiATtvk5ARZEOo9el3d0arfr/AXj22+9q3EEnxW
 td2VyT1eC75b8i8z3KQcgYY8EYCsJrAxRyrRTR9MVGbCHL/PreAs+zk7sROE6fkE/eznF
 sIxbV8PhSVd+WTkSXervysgRorI1UGHtyGLgFYpvfrvI1jsQLunEXuk+8GxdbQZ9rkhp6
 4Rkbac4q2CR97pdM8eQSBqkibHpljtHYU0agAJVnB4VTpdqTc9O/joMD/pz+3xQ/sVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789986839;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=Rztqd+MY24DPWdq7PhM6VuYGeRPhihwJZrVKB7CRiZ0=;
 b=pHPrD2i7AFUwdUvEMREIl7pw0/fxebICPSBdW9oQCr2oKW83qREdfOo0suDjSxqLlB7T
 F4jbc5ZT3UnQDFc6TYLkGksJ4mZwPI0M7vcpkxIYncdTvwJZSsSgNJjp4CyOVFxszitgr
 4t7kT4u5H/kkCxIHF04ch2grhoDUWZTzeBzGv8QbxqPEkBJ67h8grc2VSAMHnpwdGImlY
 +EUJgKDLW37S39TJZOh7reySDwxWlMiI9JcsoCZZbgM5d+nvwvpFjaEwbYBEVvNeewAss
 SD3cCRD9NcWpzkkCCsDg6AvCRGWvIFLXn5FtWI/KdeatZG0v/Xgmxx2VkCJztj0Eadw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nyQJl5Re; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nyQJl5Re
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1619740B56
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 10:33:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3280F4195D;
 Mon, 21 Sep 2026 10:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF3C1F000FF;
 Mon, 21 Sep 2026 10:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789986837;
 bh=Rztqd+MY24DPWdq7PhM6VuYGeRPhihwJZrVKB7CRiZ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nyQJl5Re1+3/vrVGvcvtJebvFdXp67TCN9PDhVQ3+oTcIjJRodyOWM6QqsekG9KfC
 rb++zJqZQfrvBR0jc4WgP5eDNbc0u8aGg3T6WeCRqZUqgw4VYWoUBTZyKk0wNW3Jzk
 A35LFusrNPNo04SBIiMxeILF5FYuHx20JbjkzKgPXv5KxKkdHEdC9iz19JHF3cdhqn
 Zc6Gh1S5S0Pv4GevjoCYbAFiDOHkCzKYR0PXXSUPi+E9nJiqzG/NXoxfh3ARh4ajVO
 SSq5Go3hhdd9SrJXQHRdfsx1yUk0xjClmvDuf75YmOYtjorqxkBPTRydXs0s3qUEf7
 vl+eDgmrjzS1g==
Date: Mon, 21 Sep 2026 11:33:52 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, sln@onemain.com, stable@vger.kernel.org
Subject: Re: [PATCH] ixgbe: fix xfrm_state reference leak in ixgbe_ipsec_rx()
Message-ID: <20260921103352.GG13925@horms.kernel.org>
References: <20260917111317.2148568-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917111317.2148568-1-vulab@iscas.ac.cn>
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

On Thu, Sep 17, 2026 at 11:13:17AM +0000, Wentao Liang wrote:
> ixgbe_ipsec_find_rx_state() returns the state with an extra reference,
> which is handed over to the secpath on the success path. When
> secpath_set() fails, the state has not been stored anywhere yet and the
> reference is dropped on the floor.
> 
> Release it before returning.
> 
> Fixes: 92103199f10a3 ("ixgbe: process the Rx ipsec offload")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

