Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7978EC982E1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 10:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49AB8605EE;
	Mon, 21 Sep 2026 10:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z08-8Z4-_dir; Mon, 21 Sep 2026 10:35:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B83E56064C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789986908;
	b=VOqAUzEqmBFRtK3LfzIgY0g49LXcuwjEyqiK0Nv4O9DJYJlAHgCLSj3PNv7rOp8wDz7d
	 HUaScXBU6UZEMwZyhoMki+PjDHYkUzM2UtgiTL23c6glkOJ2gyoqIdLRQr746YNNI/y+l
	 bsCQ/H3xr10J8AYtXLeHrUH/7bS+PheFwoEKPgPv5fYbDrk42YF4gxNI8UjCJa/Vm3wgI
	 3rGbGoYVHp76BdWl/P3e8v7Rf9RTZ9tcns3SkElVRGn/2KqerxUS6cWijyJ44B+ehsvIa
	 gUmxi9kI/HeHobb8KKz3XieUXK90GnfR+byB3cNBrCEpRhYfsGT4Ew86zWg7VVsYUuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789986908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=I30Ewh0A4iIJlrqKf0LygIu6KmBp+u8wLYMgm6eVSf4=;
	b=UlNh8Hc2CNmYAA/qayd1rMP7VGA+Z3fboIp7a1fsUF6GXOdAvlmnYXN7swTvv7h8yHCk
	 RYhcgy6SEyi3suCQbUtwqekrVJ7eUVW5U6hmLfePqdcoaZSRO3Es/thoOGtTRg9PPf0HK
	 m8CA6/fIG3aAjOOcFiYRR+iPqWvw8OJsfOl14jB8YipoaKiF5XeormezeOAxDyKD1uzfU
	 QpS6H0CmoVYWqj1DUkVkSozO708UL6kxxACVfabDzHbLFujAgGyxgL7xyPrwS2wtE8msb
	 XNB2etazya1awghrBb3AYEW5nffFl2Ohfr21/LuyZAiZzifKEeGKSlmzPJV/cqo87Mw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmJq15PT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789986908;
	bh=I30Ewh0A4iIJlrqKf0LygIu6KmBp+u8wLYMgm6eVSf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3UI9VbScCznHFSYGlL9LgIAZsDuQGccnSnKXkOSUHJEsPcHcCF/17JQ7ON2pZKuBv
	 GBUn/laJWhkX91wER1f3QtM4DLJdimtKpjoFYUcnIk0ss/YWLKgF8BeO2RZ38mZ9kX
	 rMCeM+CIQy9nssBNIQVde+q92O1Y3m9mmw7hlnqi26Ir2lGI4b/Scu2u6KYREPke14
	 CXyFxC5jCBaOaYp15f9fhzniS/+R3M89zJGFkk/pi2ernhoVkT85ES2WLhQzbOnCRN
	 7CBuuW+H3EhwIAtWfuu88tpIC9aRJdxKU8ZYK/xwWojGXhazn4aYAnSYNP1mVZ8WN+
	 0C+c50coEi2Ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B83E56064C;
	Mon, 21 Sep 2026 10:35:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED79F1FFC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 10:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D36036064C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 10:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HojA5W1eAqWO for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 10:35:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 18DFF605EE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789986906;
 b=W0wSLALcKVg9znX51jMkve2DwCspvQHPr4MycgZ3knz1vaZKjF97NqVmyelD5F38NsMC
 uw7jWslO9LCLo+/h7USiT9GNH60+JQW5AvKBdVmQofhBKhx+05luaTO0UEKzpj08V1K8x
 J2Hre/BHGGJxGNZpzYrsRSuHQa+T7Opx6vs73YBcQxef3fjC5spLFxx6MGdEb8FOqqL8A
 nU5gorJON99eR0r3KIc/132tvwo5dDKf5KaFN2ikIEeWWOPxAGsZQWkTyML8xP/8IJeLp
 K8hcc6T/vg579ZLMgX+tRyd5YtiwefWmA/C5p+Q0LkXab1n6AQQWliAsB1R6p3qpeTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789986906;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=I30Ewh0A4iIJlrqKf0LygIu6KmBp+u8wLYMgm6eVSf4=;
 b=AFz3eHh+qWpzwFRgMuD1pj8PqA14uGwuO3sASmMPsMYK2kcpUvTNDUsbkip5DhKVSPlD
 F3vGmXYbGzkOrU0mz8DaG9M9BJA++AtrtuknaJ4Np7AwDZeqnMMrMraU1vI49GUkFHp1F
 wImIjo2XkLeHseEyREJYE1f611yK2HwPEcNNzIItKuAPeQ5zjX0zqKkSuMihZ6uk56jq/
 zkCj1q9q1dvRWSb6nKE96TWWg1L0S6++fBGgKJsGRmCUSk5KQkR+mrq12V+GgZEcNKRjC
 qhk3bYmlVES2BRHeIIuonIA2W9HZbzOuKFhW7vqtcXhGXjkfNba+JMjML5WprnKz4iQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=LmJq15PT; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=LmJq15PT
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18DFF605EE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 10:35:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC759600C8;
 Mon, 21 Sep 2026 10:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE911F00893;
 Mon, 21 Sep 2026 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789986903;
 bh=I30Ewh0A4iIJlrqKf0LygIu6KmBp+u8wLYMgm6eVSf4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LmJq15PTOZlTn6Qnbcley78JQ41EEFMIeZrLieQnmKzWABl0titF4b56Tb2S3xQLu
 yvzopubsppUb8WR6TWuZT6NAb/hicyeVuKo0Npu26qokDJLuhD1KQkSliaLd6H+nLV
 m6Ouaw17Xi1OVJHb4zdvLAFlTC3Sw1E6Dp2U26NsT+Pv/JnBXbICNzU6JtOMAeDee/
 cDAy0qmuEKRIG6tEAvwKy8aF4gr1Zms9B2NboRL6/fjunxXEoIDQCRfT38otg90Xyx
 WMCk8/h9Gh5hkt2Sflgc9Sq/QvfeJQc9+CdhVVGMhbkQ8vsY8FWyImaYgiMuvTM3E/
 LdOjdSp7YLzcQ==
Date: Mon, 21 Sep 2026 11:34:59 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, sln@onemain.com, stable@vger.kernel.org
Subject: Re: [PATCH] ixgbevf: fix xfrm_state reference leak in
 ixgbevf_ipsec_rx()
Message-ID: <20260921103459.GH13925@horms.kernel.org>
References: <20260917111418.2148632-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917111418.2148632-1-vulab@iscas.ac.cn>
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

On Thu, Sep 17, 2026 at 11:14:18AM +0000, Wentao Liang wrote:
> ixgbevf_ipsec_find_rx_state() returns the state with an extra reference,
> which is handed over to the secpath on the success path. When
> secpath_set() fails, the state has not been stored anywhere yet and the
> reference is dropped on the floor.
> 
> Release it before returning.
> 
> Fixes: 0062e7cc955e0 ("ixgbevf: add VF IPsec offload code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

