Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7D8CD4F50
	for <intel-wired-lan@archiver.kernel.org>; Mon, 18 May 2026 18:32:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03E3260710;
	Mon, 18 May 2026 18:32:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wMZrx0L3M2Fv; Mon, 18 May 2026 18:32:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A51D9606C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779129166;
	bh=55pspnq4vaqq2Tx53zBMhbfmf3FZ2LXpvndEzZlPMcg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u+0yhywcQ2ZatKgGbbG2A1xhGDnpHQAJMy0c7olI/g/JGB6dn9jMcC/TMCbGhIvOh
	 NqDfxFCgUeGNbzZHy+CddPlyJxXVAg8NVaruOwsYBb5W/8MgGp5oxZXMY/hPgcW6yq
	 x9ZxAnsrlaOHWHmIBVuE5A7wKYwhMRXBTCZlqNhxV8iLmOihN+6sYXLoqrebKeGmXz
	 +ZCqNLpMnO/gkwg6g3f9mfMTmLMwSqGlpQKaoorXGr3DY2lpbZ9JB4dnayXopR6kB9
	 GZee4tkAKCZYxzzod8uqPAIYywDje9IA0dc7eqRw/EFbAteZOLz4KhXpnJQjdI7p5t
	 LGclZemjONSUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A51D9606C0;
	Mon, 18 May 2026 18:32:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C99491B2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 May 2026 18:32:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA47040921
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 May 2026 18:32:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGDTyiCqbYbA for <intel-wired-lan@lists.osuosl.org>;
 Mon, 18 May 2026 18:32:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 201104091E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 201104091E
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 201104091E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 May 2026 18:32:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6214D44518;
 Mon, 18 May 2026 18:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99763C2BCB7;
 Mon, 18 May 2026 18:32:41 +0000 (UTC)
Date: Mon, 18 May 2026 19:32:38 +0100
From: Simon Horman <horms@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Blair Steven <blair.steven@alliedtelesis.co.nz>,
 Carl Smith <carl.smith@alliedtelesis.co.nz>
Message-ID: <20260518183238.GE98116@horms.kernel.org>
References: <20260514003733.1718771-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514003733.1718771-1-chris.packham@alliedtelesis.co.nz>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1779129164;
 bh=0RaJhtpEWtU3k0n7Y9j7Zkx9qNKgrBCTo8uIa101wog=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JyhlgZovN73HWmKI3crtE6jK8YSJhJP+DNC3a1VBckhD1IKOpEmOM1s/YK5NN7B97
 100R11BiJv5d6rHzoLNaEXlKwmi+hcwisSfLhkQJ7sX7m6qBgK9Lz/WmxrjBXaluxS
 lCb+x1KubsFK3dJK7Q51n0ZMijfTS75+zhXQgBxmgbwuDZQ4Upn+DuC8uRxyAPqKQG
 y79+ghnrAAg304oZh6quO0j4Vr7oBOBW17Y5AlWQ1NWYWLoqxq0mJhfjUpwQHyrv/v
 cpxJwVojC4dBE88xdSIIMQ3pW4Vw3/uiN0Ywt9XOZ3trslPcVpi5cBwo3V/gIeAUWN
 nfmQ2rBRZDJeA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=JyhlgZov
Subject: Re: [Intel-wired-lan] [PATCH net-next] i40e: Avoid repeating RX
 filter warning
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

On Thu, May 14, 2026 at 12:37:33PM +1200, Chris Packham wrote:
> When the i40e runs out of space for RX filters the driver switches to
> promiscuous mode and warns that it has done so. In scenarios with a
> large number of these filters this can generate a lot of warnings. For
> example:
> 
>   $ dmesg -c > /dev/null
>   $ ip link add dev br0 type bridge vlan_filtering 1 vlan_default_pvid 1
>   $ ip link set dev eth7 master br0
>   $ bridge vlan add vid 1 dev eth7 pvid untagged self
>   $ bridge vlan add vid 2-4094 dev eth7 tagged
>   $ dmesg
>   [   25.601705] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>   [   25.601833] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>   [   25.601961] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>   [   25.602088] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>   [   25.602216] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>   [   25.602344] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
>   ...
> 
> Use test_and_set_bit() so that the warning is only issued when the
> driver enables promiscuous mode and not on the addition of subsequent RX
> filters.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Resend with net-next tag

Reviewed-by: Simon Horman <horms@kernel.org>

