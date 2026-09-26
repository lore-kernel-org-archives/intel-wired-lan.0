Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAFFC9832F
	for <intel-wired-lan@archiver.kernel.org>; Sat, 26 Sep 2026 17:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DD2781180;
	Sat, 26 Sep 2026 17:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wKmffVacpKLj; Sat, 26 Sep 2026 17:06:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0494281166
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790442390;
	b=AZnq2boVkrEgWk+r7JKaueCMO+4c1elt6JfAbcEkrxsocLBYKzNxEtj7ICGkhbyJIIzT
	 zDKLQdv2NIda6QciWHKcdZ51/bhjXoPEtlnZO46TJebNtVRJlvcbsMDc1muS6rA3erlTM
	 Pf0BIsvcj5eMFBbIh5q4U4L7U7xmACTj/ia1qeCZTpY0P/+tZub+g+wCMcVt55ew9riz2
	 rAYBqeSAkFocA6M848M/AKNsQTurZK6J8BE37kRvDuNd0bpFujlX4EAnQFv6jpsLN/3CK
	 bLKFKaBNVyT3+Li7fqU5YmHBtvV7Z0nKQX13eGKCtMLCf1tH4iauzmLHHfJS+B1ofvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790442390;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9BtdidpngfnWVUC1HsuxdkJBJ3X8fnJBx/TSKgGd9xU=;
	b=PIsU/bhK8VFxq69uUOJqWaXmQbp1YuxsjRZqET+kXp8Kxz9VqU6Dp1a+juaYZc6pGdo6
	 evVFYFCVa+v7UGbrEQsk/Gct2qwTnbKfwnvoVkuBy03z4cET1rql84CmuvuMeQrvpJDQc
	 tJYHcMKEtMhBMRjNbEWCdN3uvWktjQAvP/xQ73kdcuiZ4dz27fCLtYQ+8gFW/yu7xHTtA
	 MdLxdGzb6z1glc6DUBp/ce4Js9ply8vRmPEFmlG4JIWm8ucekjR+kHIsFqGcUDx7ZN0BJ
	 7sK2kDe/1d/4tzgdJBbYL47FCHhvsIYnBuUheqzK/6xTF8jktEOx0mNuz4PjPNhgOHA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790442390;
	bh=9BtdidpngfnWVUC1HsuxdkJBJ3X8fnJBx/TSKgGd9xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dTb72pJr0iYjb4CVVw1fWDPRlRxZmL1HN2X9uNiMSMajX1+uFzQ3Bv2knc651mBhn
	 UC0yxWXXy/xis0eSrekBhf2wtHDU+nqnXQx3qScBWw4OAkXGdFSR8kTwyxupAlKF96
	 NJziWNRaRT4hu4ymdL2oe6U5lzv/tj38Jq91p3TMb7rXIxputK/t1MF2mdftWwK6sY
	 mD4+NMKnAwre5Ky8PJb+VMhYLTvickA2776Y1i+NDCS8F8fTaDrGJbVRnaAA+oR0Sk
	 LlZ+YoLp3EnQuVpDm8O+HP1h9sRuG5BJovTFgG2LuvOBcM6H4vSoUdiFHLmRx8tm9k
	 QM0nZT8LbFjlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0494281166;
	Sat, 26 Sep 2026 17:06:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 642C4194
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 17:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5550160623
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 17:06:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zyGX-VrNj-C3 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 26 Sep 2026 17:06:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9FEDF6061E
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790442387;
 b=DxDVro/62h3MXQIxZ+CdNO4paTpEwWAo0V7oAhQmdJ8ZxSnvQ3jeJVmW3ZK+a7C8E8xu
 RkP8xwsK6/JJWyEruhuubMkQ4v1iRfL/MdNmSZ1whoey8ob1qWVTDLZCDWkX+GdrIGc0z
 PBhLASLFHPv9SQkLhVi4M7ij7bI+FZW+pZ/zN/fvTtuF3Cn5+ly6fzVbJDkGt1NfivH+J
 9p6Ex0s20NU164ibrHDQ95G0+JAx3kq6fV3PiD+tvFGl8rMoblg7Qg1og3+VqFvT1vVEp
 eJBSTlrzZoQgnAchKHVRPY0+ae+UVV1ZEqRPaWjHZfjjF9kvd8vZ4GjEzds9sICD/hA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790442387;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=9BtdidpngfnWVUC1HsuxdkJBJ3X8fnJBx/TSKgGd9xU=;
 b=mKtdbz2lbx+bpmNcnl0oxW13zxjT5jx6SCvQH8f4dS9oIOrMR/roGy6aJKT9LIldUuNL
 ewB16BBZaHC8YiLMQdSieKvMM6xwRSiGfD6Vx0wJ72UdZwzEuoRvP6QrP+6kbT2FwRQ15
 BQuS7bvVKUODd230zBWH2KCNJmAFx1ASIDWL/kS1+gKMf/95HnemjfdP4N5gHJFrjujwN
 6MVuACHb/m4fkzp/ZJg1UC5viR20eSfv+gZ7XUs+lFHq6aHGUhRPtCtbUi/YVulwq/nPC
 OUvNZOmm0/4bpfW9+ptf8bVUFqC+ojFAXStblR0Angu1ZbLKR+OiwWZy8awtAOlO9ow==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QzzslouL; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QzzslouL
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9FEDF6061E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 17:06:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 27D2C43EEC;
 Sat, 26 Sep 2026 17:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04651F000FF;
 Sat, 26 Sep 2026 17:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790442387;
 bh=9BtdidpngfnWVUC1HsuxdkJBJ3X8fnJBx/TSKgGd9xU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QzzslouLHrok74kyX6JcCbT1TmdPtqI/kWukYFpYCCvLd6Xzwqq1uBE81GDqzW7nM
 jvjh0iawlHEMy5CpDSux0SWmAdatDap5JO5rAoynX9ztee+sRf92eOWjR3W60/IM//
 Qb55zAmOFE3HYfGcNmq4xrINtemsHFZYtLEWf/eG85kS4gCXFUtv5UPY0zBdO/GCE7
 FBH6Umm2ytvp3aq45BG04eacit6EX9RRCCKVcOvl05RfFa1DQVr1iICFsmeI18Y63h
 bJo285q9xd3wHX0GT3ds2hq86s0+pnsoFt1XXFYy3ziGITav66eVIul0yM91bqWuq7
 BR69WOo6hNBJA==
Date: Sat, 26 Sep 2026 18:06:22 +0100
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com,
 anthony.l.nguyen@intel.com, arkadiusz.kubalewski@intel.com,
 davem@davemloft.net, edumazet@google.com,
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
 Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-net 2/2] ice: remove redundant cross-timestamp PTP
 command
Message-ID: <20260926170622.GB13925@horms.kernel.org>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
 <20260925222824.270640-3-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925222824.270640-3-grzegorz.nitka@intel.com>
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

On Sat, Sep 26, 2026 at 12:28:24AM +0200, Grzegorz Nitka wrote:
> The cross-timestamp capture path programs GLTSYN_CMD with READ_TIME before
> starting the ART/device capture and clears it with NOP afterwards.
> 
> It was assumed that this change was needed for E823 devices, which
> turned out to be not true. The hardware supported by this driver
> does not require it.
> 
> Since GLTSYN_CMD is shared with other PTP operations, touching it here
> only adds a potential race source.
> Remove the redundant source command programming instead of adding another
> guard around it.
> 
> Testing hints:
> Verify crosstimestamp path, for example with phc2sys tool, on
> E822/E823/E825/E830 devices. Please note that the phc2sys tool performs
> cross-timestamping by default when supported by the hardware. This can
> be observed when the reported delay is 0, indicating that the system
> time and PHC time were latched simultaneously.
> 
> Fixes: 88c360e49f51 ("ice: Support cross-timestamping for E823 devices")
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

