Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A99C1099B20
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 17:09:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA13E61BA7;
	Fri, 20 Mar 2026 17:09:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GRxheaLyhIlx; Fri, 20 Mar 2026 17:09:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96FCF61B63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774026572;
	bh=S+DZrZkziPue8ZqlFpL/Ora4qprj6quS1ri13kp8YtM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O74usKLPUZZoa/F2IST78FP0gpMVe63/8mGtaR57REVj0z4MWR4r6D5oYseII5uoL
	 O9QSiw7pqS3b9BnKHIFZOA5bTPrsZ7+z53MZz3LuSIOtEuUo8gW876NtN6CSWdmi7T
	 h98oCQhtXxF+u7py4YGalvfnUk1ZgZ02FE+G668VoblZnL93XJ9xh5/kkhOGJ6lvWk
	 yBae6FlkScML13LTkUD/gvv+UaSdPPwJJ1fcAPt4xlQ3HurhOcXTgqKouzHcRWT2ob
	 7epJnpftp97b3ldfWpW6eW5gtMze/60bKIH+9DLpIusT2CzRd8R0YgYjLRPepOYEmB
	 MoX7xzRjSKAzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96FCF61B63;
	Fri, 20 Mar 2026 17:09:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F109265
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 17:09:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24F8C400F9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 17:09:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NLCv5Io4m745 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 17:09:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 839F0400E3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 839F0400E3
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 839F0400E3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 17:09:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E67BC4054D;
 Fri, 20 Mar 2026 17:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E1BC4CEF7;
 Fri, 20 Mar 2026 17:09:26 +0000 (UTC)
Date: Fri, 20 Mar 2026 17:09:24 +0000
From: Simon Horman <horms@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Piotr Raczynski <piotr.raczynski@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20260320170924.GD74886@horms.kernel.org>
References: <20260319135859.690041-1-lgs201920130244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319135859.690041-1-lgs201920130244@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774026569;
 bh=lRbE13y4NP2q1YPi151RjqScvqFxmQUg5LjL6Onp7Ig=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DA+BhzT1JbT/eC+GkBCKUPLNVjcEM252ppfZC+ReJ0qVaF8PvftLgrU53I01sReI+
 UBfnIQHKbWTgGcSsSW/Zkj+s9r9TqamJRVLFfSk6VQs8vHNs0OJV8pQEqtPZfmInvh
 htxzvxLM7ho0Q2Xg6gSC/a+kERxrzWP6Hm1G9N9RBtrfCKCy4nw50c2yN738vDJYLh
 z1Cdl/hNsavUazIMl01i1N6lEdiWupiqW65ugfoQwv8/HdxZCgAfely7jYQO1OJ8p/
 T66NJP/ytYil7Go86OnWAxQtgm0tNTwes0nZFHJ+ISz3asyx1VyBjluJ9o67CW4OWN
 d636jAkIV5mnw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=DA+BhzT1
Subject: Re: [Intel-wired-lan] [PATCH v2] ice: fix double free in
 ice_sf_eth_activate() error path
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

On Thu, Mar 19, 2026 at 09:58:59PM +0800, Guangshuo Li wrote:
> When auxiliary_device_add() fails, ice_sf_eth_activate() jumps to
> aux_dev_uninit and calls auxiliary_device_uninit(&sf_dev->adev).
> 
> The device release callback ice_sf_dev_release() frees sf_dev, but
> the current error path falls through to sf_dev_free and calls
> kfree(sf_dev) again, causing a double free.
> 
> Keep kfree(sf_dev) for the auxiliary_device_init() failure path, but
> avoid falling through to sf_dev_free after auxiliary_device_uninit().
> 
> Fixes: 13acc5c4cdbe ("ice: subfunction activation and base devlink ops")
> Cc: stable@vger.kernel.org
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - replace goto xa_erase with return err after auxiliary_device_uninit()
>   - avoid xa_erase() in the auxiliary_device_uninit() path since it is already
>     done in ice_sf_dev_release()

Reviewed-by: Simon Horman <horms@kernel.org>

