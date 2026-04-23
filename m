Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FB3FDEE3F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Apr 2026 18:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60685821DC;
	Thu, 23 Apr 2026 18:55:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6f8g92eYBLOq; Thu, 23 Apr 2026 18:55:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94C30821D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776970539;
	bh=RAXpIeK+LhCKngTRYBotZcTm6p1Cp2JAdEiGgrCla4o=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ChTRmj/fnphn5yBUCYqbqQ0efF11yY/iDDpiaPUSP4pUKBjm5T4O8pY4d8QyafnNc
	 syLpAV6r174+zHmLsj0E87HrzCZLdNhoKrtariy/sNBiQTL8oTzLOCZcv4pzF3f7Ci
	 APBwf3KsixWMhyhZ8zummWfENMFUKgcDCvE4kHZicmmmFKdpsIqlL5acKuFZN4loj8
	 MjXDZtzomf4cOJiYnE06KsDA42+MessjUquNYS0jngYBwg3iPizUdN2OBjrLz/3u3K
	 I5Myq2gtxDTskDiC7yOK1FgHq8dSvy8R7fXWRplJ58Q9zmNYZbZEdYyRHE37BhdLrc
	 SbRZV8dO32n3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94C30821D8;
	Thu, 23 Apr 2026 18:55:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7401E231
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Apr 2026 18:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 653B560F14
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Apr 2026 18:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QQc11UU8ahbP for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Apr 2026 18:55:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B3FE960D77
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3FE960D77
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3FE960D77
 for <intel-wired-lan@osuosl.org>; Thu, 23 Apr 2026 18:55:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F147360181;
 Thu, 23 Apr 2026 18:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36726C2BCAF;
 Thu, 23 Apr 2026 18:55:33 +0000 (UTC)
Date: Thu, 23 Apr 2026 19:55:30 +0100
From: Simon Horman <horms@kernel.org>
To: Corinna Vinschen <vinschen@redhat.com>
Message-ID: <20260423185530.GI900403@horms.kernel.org>
References: <IA3PR11MB898664A49E614F197D4FED6EE52C2@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260421111236.875379-1-vinschen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421111236.875379-1-vinschen@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776970534;
 bh=4yoTlqQgbbVE28AVWHdC5lL1x5os8T5h1viP5QpkKlQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lQ9yjLNhzeNgz5LnKP7c5B4CVVdkDK1FCMsDtp50OIQeKLf5otwlCPfWdgWSPycw/
 XTvQQiA9S+ZybzC9eqC7oQzsM81L7y6MNR7n4RHDo2QaO/5k9PX7EV1EEAok+xCXA+
 f3xysYpsbXmlJ00lhGseIfBYTZq0JzKgi7HG5BkJ5ydr9JUbYQPm6Gid/Hg6hSDHz5
 liAN2JVUnjU+EY4FBqBhoJoIltNPHvSjLCUCMvKUosbMN6Kk79SCWlApAasPYFpayE
 JUE8mai8Fd4DutEfbulAEx6LvAf6+32ED2XpeKNOTrex27dKq87SQDqapgCZUOuE1Y
 Qv/sCT2faOyhQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lQ9yjLNh
Subject: Re: [Intel-wired-lan] [PATCH net] iavf: iavf_virtchnl_completion:
 drop duplicate ether_addr_equal() test
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
Cc: intel-wired-lan@osuosl.org, stable@vger.kernel.org,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, netdev@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Apr 21, 2026 at 01:12:36PM +0200, Corinna Vinschen wrote:
> This is just a simple cleanup fix.  Commit 35a2443d0910f ("iavf: Add
> waiting for response from PF in set mac") introduced a duplicate
> ether_addr_equal() check, so the current code tests the new MAC twice
> against the former MAC.
> 
> Remove the outer ether_addr_equal() test, remnant of commit c5c922b3e09b
> ("iavf: fix MAC address setting for VFs when filter is rejected")
> 
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> Fixes: 35a2443d0910f ("iavf: Add waiting for response from PF in set mac")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> Added CC: stable@vger.kernel.org

Hi,

This feels more like a cleanup for net-next (without a Fixes tag)
than a fix for net. I'm missing where the bug is here.
