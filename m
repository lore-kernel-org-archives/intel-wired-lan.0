Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A936C79F99
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 18:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 920F860732;
	Tue,  8 Sep 2026 18:31:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n-JpfF0eN_dT; Tue,  8 Sep 2026 18:31:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EF29360733
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788892296;
	b=FQEAVtWL8DYBOUN/wn3PIqhs8VLfCAUhFJVHqEdBEi6F+l/Gwx6D2bwGFmAbcvnESGa4
	 URinupDkv8FFQiCJo7iuCbhM2+IK3LSoD91IGqHXO+8OLoO/CQE6hpnuKnYtWgjZJ25/g
	 ezEguAnffRn4KOWxbpKa3E2oFVf6BvOqcQ5REjcl2FppgQbIMg/0wtftFZiiKnuw7HY0c
	 RRG7iQy9yoXHwweEMylUlnBxnPT9KNnxLW8q8+4SCCCsZxOlzQgB2B4q5cGKQEoE9eUKz
	 rV3O8Md9yIWJQUEw8rlLkVUwfnVZhn4Q9ct8NiX3xPIZbW6sevK6c5nAAz8ivZC2cgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788892296;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6cZDfge7+OG+kjdYRJde9UV0lkM6osQI8hAMk9OLaKs=;
	b=VFr8J1CZkhiKqtuUsDS1pCO4hgWJtJCU+QGKWzV5LNGBB3m3PoJ121CaF4N9DM3fb0l2
	 tmuuEw3EqA5fECQE6svuQsnfEG1hRJR4Tt7XX1JKK6AeLS+SHZruqbwCFZd2SYCDHxKBK
	 q2ute+9IMCVKs4l4KR4DjonluQFrz+6A/kMLHqT46WuHe2nMl8XSN+Z/TDaK899rg/rcy
	 HyAqtixO4/1tiZHtru/5APhfk6iD2mJ9suvmME0H+ByreiK58+jFTHxxFf63FFKRDTs70
	 21xUvpL4SZPFrVJPRSYliH4mucZ7pVx8VQyDRw3LQaI9FezrFt+7egSD9KBrOIydmcg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788892296;
	bh=6cZDfge7+OG+kjdYRJde9UV0lkM6osQI8hAMk9OLaKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vx07hBHasMlvC35gQWqjnsk66Cvn4OK6d6tjGPoKsHuXadaveNolNdBMfQPPP0wnu
	 wFeGFh7TVt3RBIpsfQ17o++X/862fN36+7L/klZUkDHqJAy91Hi6M8cMCOFjIx2VFy
	 8F4fSgMmVH3KjqD5ZqFLHkHyOr/zY0w41IXCBXfMPkHDB48jKHAlm3Te39cIKPuk1g
	 h2pSSGUjezMFdcxbYtwdMfVv4fwfaVoYaWBssFaWN4sUq71tb0NGv07tB7o/H5vKCD
	 O5+62P+j6AVLl4PN5nsaA71Lexun+i7Kp3Gus9RTIUTEoVUsgpFVlV2S3657bk/C9e
	 6IrcYErMzVViw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF29360733;
	Tue,  8 Sep 2026 18:31:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 14CEB769
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:31:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1204040692
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:31:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mC3nFa3TFsW1 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 18:31:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 59C724068E
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788892293;
 b=AwbH4atMf/h4iod8zbGQKdOIYljn0VkbLZ9lR/G/Ruk33QPJD/QaH61cwSq6aZyfvBOK
 lZTYbbvfXNXxcmDtR4s2GizMqDoynrdg2jk/mqbywjvGxz1+lw6pPG6Vg1tfrVuxne2V1
 3J3/mjyEyJeOft2AACw9Gritn3UZW2VvkGynO4vVLYhVvUZ+VWZOlgm0yF2SYpSjRETbk
 j9epGYdC8M2PCGsjLZpokIA9YzLNv22yPVa9bPQDD9gF2bIok/o4+7b/h7CnZq6LvP6iC
 BSvFIRXor/iYjSahI3n1+rp/hw7qtUlwCbDXUI8FWWuJfnRNsyFW6d6koeg44BUCCCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788892293;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=6cZDfge7+OG+kjdYRJde9UV0lkM6osQI8hAMk9OLaKs=;
 b=W9f3DBEqMdlZbGSzdypbQNw8iytc3qApTiDwLbtsIidMNbAukYzt5yh0i/+vzeJNJIYK
 FGXrA58ThycZ4gW4NX+kzYSS2QaAN25kklprHTTdUgF/EkCe5UaZd8OBiz9LBVpPCotby
 g1npd9IT0QDMih1TeUMOXQ3MXGDwNp+aUTH4LXdonPLi4a5vLAYdgi6Z48lmgL0krJ0Z6
 XFzmXbQE9D0Ngn2lohnUuSDBoDwE631T9Jf+Ns5jxUvG5KRvJ6c08s8sWu0uhwhVKTe95
 8oob7Gi2CmSwR1PppdZpHHwMGasvIY9im+AFCY1fzIm2rweIiGpyohcHp395VfdTx9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RV4ymRzt; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RV4ymRzt
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59C724068E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:31:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D0144199E;
 Tue,  8 Sep 2026 18:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E391F00A3A;
 Tue,  8 Sep 2026 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788892292;
 bh=6cZDfge7+OG+kjdYRJde9UV0lkM6osQI8hAMk9OLaKs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RV4ymRzt7Lu5dJwvFDAif4TWvHlfUweRaL6NQi+7IpectWu4m6w+olWMLLdtFyUQo
 Aa8ds3802eo320xxDh4NF0WLV5JRin3mtYTfxPScWJ9xgXZWK62Oe/kfYfASEyiAH8
 kMNbrCYAgoR3y02G49MfGZgfhkApjecFiKd3VtD4/2Bg8xwdkn2zdJ0WAsOCvQLR6n
 ig6xDzA4jcd8tbfviDvLhMnBrYLbI4yIiJ53KF5lXraPp0QVu477EZv4G3nssVyt2y
 ledOgk4d+9t0+s/4vieFxGAVHuH/DK3v5LUw0JRN6pETEnbeaWg01jESas7xOLTtqd
 Mk7xpb5pAKmMQ==
Date: Tue, 8 Sep 2026 19:31:27 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Henry Tieman <henry.w.tieman@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH v2 1/2] ice: restore DDP state during PFR recovery
Message-ID: <20260908183127.GD40544@horms.kernel.org>
References: <20260907115221.926007-1-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907115221.926007-1-aaron.ma@canonical.com>
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

On Mon, Sep 07, 2026 at 07:52:20PM +0800, Aaron Ma wrote:
> The firmware package and switch recipes are shared by all PFs of an
> adapter. However, each PF rebuilds independently after system resume. The
> resulting package downloads and recipe updates can interleave, causing
> firmware timeouts and leaving interfaces unusable.
> 
> PFR also clears package-derived firmware state on affected devices. The
> existing PFR path only rebuilds the driver's block tables, so VLAN recipe
> programming can fail after the reset.
> 
> The failure is reported as:
> 
>   ice 0000:04:00.0: Update pkg failed: err -5
>   ice 0000:04:00.0: package load failed, -12
>   ice 0000:04:00.0: Rebuild failed, unload and reload driver
> 
> This was observed on an Intel E810-XXV-2 adapter (PCI ID 8086:159b,
> revision 02) with NVM package 1.0.0.18 and ICE OS Default DDP package
> 1.3.43.0.
> 
> Serialize rebuilds across PFs of the same adapter, while allowing each PFR
> to complete independently. Reload the DDP package from its cached copy and
> restore the default DVM recipes before rebuilding the remaining PF state.
> Abort recovery if either operation fails.
> 
> In addition, stop the service task before tearing down resources in
> ice_remove() so that an in-flight rebuild completes and cannot dereference
> pf->adapter after ice_adapter_put().
> 
> Fixes: 462acf6aca85 ("ice: Enable DDP package download")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> v1 -> v2:
> - Stop service task early in ice_remove() to prevent use-after-free on
>   pf->adapter if rebuild is in flight.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>
