Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D011DC982EA
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Sep 2026 07:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71F1C40623;
	Wed, 23 Sep 2026 07:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cqa9MwBcljFF; Wed, 23 Sep 2026 07:12:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EF268405E7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790147565;
	b=HB5DasOkXVWtOAML+HQFChMDHVe2GYCmDG5p+RkQ0JgO0iIy5CLkEf8mFr+577DDmnYd
	 ZNGShujSUGJfeFhGgQdWXIUJROKkirn/ikH19CDptUnsj/2IlcjZFUxUc/ItDi7EXa8qr
	 crINbqQ6g3Y/x5sMa1yzOwF7MA5zE+EqOOcfJUUaneINv/T5fF8mHltU7wRFCz5BXTlmC
	 5HF3+lgOiz2SamU4JhRUvkNsQUaBunU73Hd+Ri4KMU6kctD6usgkQGPabvXtC+aAz4znB
	 /e5F7phbARYASUWyikVxL4fvri6+C1EueRTt3kg8xoOUcWUyp19ZJjnjUNi0fTzlUtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790147565;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=X+oV1KMq3qgE16ONyrZlpyy/bGTkSWXzskYuTikO3wA=;
	b=VdlvgM4eJNkVGcHkpBwcGA5IB+xjTgFIHl+zj3Fz/fiKLUTJwQSIkaunBifJQBIhI++Y
	 evSeseNcCxs+o/DANHlVgbJ0PuD7h36pQm4QOghstMDIrlCsT1mrd/YvINffoblgBOXRy
	 g9C9u3uAjP6qwpzdhieb4nL10a69MixwAMqLFmntjhBfBaHcldeno51g5dHFvnAGzDA4f
	 w84qkKWf6MpRHLyPyTAzdxtMezo+pS4BIkTrqcTXrUcS8raJ6xyeVrNZzggpxVr3Qto2y
	 7CNcZE/4qml6uiTZR8YGenE0qqIqAN2qTNxSN/WkMzSL/KWY3cvYdiKn1VEmYRlPt+A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLNONArh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790147565;
	bh=X+oV1KMq3qgE16ONyrZlpyy/bGTkSWXzskYuTikO3wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mhQsCc7A8ZWpK6voR08K8fVVMv4l+HPp7KOEV5pghz0Y1byL4Wrp2txODWBGc2ghY
	 KtDQ6BBD4HO5yViCMojz7YmYEXv2hM3PmdIwM9EtiB/NUkeDaOjZnhGhJ2GJLpDKHc
	 JMK7Fg7Wzz6U9tc+7xF8VLxC6Jaue+C4XVU/8bgPz5vkSL+juAplM+Ou6C4HsxI97a
	 /DOaw65/7vzhTvdXNpZyGbfkoY/oU14fo1O5CJVXCvpF4+GOgsHK+FBL0YO+piIVpt
	 sdWmxahqIcT1uRA61bH+7L0KE2OLYHJ7GrM8XRx6aX9fqwW/I5rzdKL4FOy0BF2wHC
	 F0RKGSQ9gSMpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF268405E7;
	Wed, 23 Sep 2026 07:12:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C3C21498
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 07:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B54C7405E7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 07:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DIuOkD8EgvqF for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Sep 2026 07:12:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1159B405E5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790147563;
 b=WAkYXCJT96rFJqqZaiIZGNph7epl+Ovn1ghyjdGPSUpsxncFUVodnypNaanK2f8CmCL7
 W0C//EUzkRXkQ+RYQobgwtPJpV+9OVFZ+jRDZI773uSe1KsoCyW/sNVIBrXRJMzm7T4vL
 Yig+Ht4gg0w8eNhqRWLYq7mvnENHbkvIELQ9Vzfd05GMfIwiGyJdx5a1t5VZN5c5unaQP
 tFMpu/8RpfSFwrPKTEFFIaGIJzTAtODHuxzEPJ1xVKoQ/+2+fM9aCYXScGGGsTE0WDZuM
 j13NJYLlOX/ymdDdsC8CyBLCQkPn0T5aCTg7hk1UbBuoKS0u448GtoIddBYlPkTCLDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790147563;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=X+oV1KMq3qgE16ONyrZlpyy/bGTkSWXzskYuTikO3wA=;
 b=TZ47S2IgG4Y73OAdBf+Kn1lNdkql0aUeamsDxYYzI6oGeW9WCyEB+Hv7zW8s1xCi97DS
 DFG34qdUxJIhcTJ54ofbzisrr33itkhbYFpO2Mrc6ZRhObWl/m/Hw+1qBbHYJw2qxBRA3
 knwe1rPTJeO0C1MkxAszhWEFhtoJPIeNQLKiWZvda2kKSB7FOxr14CHMKu0ESbd1dOyi4
 JiNWmcdHP6H1R1UU0KyDKwrP391ZqYGmmfS8eFoudx+eMw0inJkai5RgoDcDJMGO+G/fV
 ePGRR9/1444UyPPIkqiOOuJF7Tcyx5u0M/WGC1qEiruIZzzIi+Y/hT4nvsPeeQXwF6g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iLNONArh; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iLNONArh
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1159B405E5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 07:12:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 732B5600AA;
 Wed, 23 Sep 2026 07:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111B71F000FF;
 Wed, 23 Sep 2026 07:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790147561;
 bh=X+oV1KMq3qgE16ONyrZlpyy/bGTkSWXzskYuTikO3wA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iLNONArhrqjPaae5avg9VcLOTFCqgC6dMa0lLWXbwdn6h6o7veGdqI2w0leBu6+NA
 4+RAOiPlc4cAWNYrFNwlOMwF9fhRBLXLarjmaPRaVhgbcxgWLO4T8WuHQ5aClKdH9x
 xT0W0pwf7ZdjZsJIVuDkWwli4ag235JjZKJz+jbyPPDZAMMk+tx3pXoGIZbt8pK6tA
 uYIEx16D3b+icN6Zs1IH7bfXaL0K0Sn1X1rMxOPiATJ/IhndGcXsADRubfv6pmKsUX
 IWGy7Gz0ogYjc1kBQxjs322CGYCKEjy2gZZ+Hutk1q8mw8SgE+A4cR1aWxIkee3fVx
 SE2uLx7qjebDQ==
Date: Wed, 23 Sep 2026 08:12:36 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: restore double VLAN port parameters on
 devlink reload
Message-ID: <20260923071236.GI13925@horms.kernel.org>
References: <20260921100000.1152575-1-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921100000.1152575-1-poros@redhat.com>
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

On Mon, Sep 21, 2026 at 12:00:00PM +0200, Petr Oros wrote:
> Set Port Parameters with the double VLAN flag is issued from probe and
> from ice_rebuild(), but not from the devlink reinit path. ice_init_hw()
> resets the PF there and the port ends up in single VLAN mode while the
> driver keeps operating in DVM, so outer VLAN tags requested through the
> Tx descriptor by the PF and by VFs are silently not inserted until the
> next probe.
> 
> Move the call into ice_init_dev(), which is shared by probe and reinit.
> 
> Fixes: 31c8db2c4fa7 ("ice: implement devlink reinit action")
> Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

