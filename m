Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF63CF2577
	for <intel-wired-lan@archiver.kernel.org>; Sat, 12 Oct 2024 18:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 838E34078D;
	Sat, 12 Oct 2024 18:42:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gE8Jj86jXS1B; Sat, 12 Oct 2024 18:42:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 896EB40592
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1728758571;
	bh=Z9Vw9tqTsh2NIgXn2Uom2hDgSwNfIr0HX3ljk/NnuIg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8d55+E3cc3448b3HDkA2fGQqrtkufA/Hbu7+BTYCVsILmTkFHosbwdgQN4WbUJBR1
	 1fw2+LTBpUSf2S1wB3dNrLwvXwyNC0D5uxJ606Xdl6Mr95O75JeWHez2CE96KGMEZr
	 AMsWY1w0/4IPxqjp3LLX5lBrK/H8lyi9vNnUNYgdBW9sUpVVof7j7ehZnOd/MhB1Ce
	 vuDE8nPILcR7hp8SDUsHWI2uYtERPAMWIrgvVqoPya/eVSj9VZx9AvdXrzH16is1VT
	 FB10QRAh2azpvKeJuHcQrcmmAUNEKpxjiSH2JxG9a0st6T9Q2W2wUT0jtXN8Osz2qp
	 oY83DMEMV0knw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 896EB40592;
	Sat, 12 Oct 2024 18:42:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 21E3D1BF408
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Oct 2024 18:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C40240592
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Oct 2024 18:42:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oGAHoGL3lvMq for <intel-wired-lan@lists.osuosl.org>;
 Sat, 12 Oct 2024 18:42:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8C0CF40523
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C0CF40523
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C0CF40523
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Oct 2024 18:42:47 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1szh4R-009oTJ-PA; Sat, 12 Oct 2024 20:42:31 +0200
Date: Sat, 12 Oct 2024 20:42:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Message-ID: <f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch>
References: <20241011195412.51804-1-gerhard@engleder-embedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011195412.51804-1-gerhard@engleder-embedded.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=Z9Vw9tqTsh2NIgXn2Uom2hDgSwNfIr0HX3ljk/NnuIg=; b=HfAJmhSL4g3kOsUQKML81Gg3vK
 sClunIM9MCqsdL+9gFNEypLQ8lYWeBayvoeKYpt/HMWgZvZH7EtYtKvtyX7HtgWPJcDMIZ8Jsgpwy
 2e5CO39h4Uaa+TI9PRz6T8dh3IHqbasKUqaO98Wf/gLUgAVCkMlN/L5QrcA6kb0OrEtw=;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=HfAJmhSL
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next] e1000e: Fix real-time
 violations on link up
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: przemyslaw.kitszel@intel.com, Gerhard Engleder <eg@keba.com>,
 edumazet@google.com, netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Oct 11, 2024 at 09:54:12PM +0200, Gerhard Engleder wrote:
> From: Gerhard Engleder <eg@keba.com>
> 
> Link down and up triggers update of MTA table. This update executes many
> PCIe writes and a final flush. Thus, PCIe will be blocked until all writes
> are flushed. As a result, DMA transfers of other targets suffer from delay
> in the range of 50us. The result are timing violations on real-time
> systems during link down and up of e1000e.
> 
> Execute a flush after every single write. This prevents overloading the
> interconnect with posted writes. As this also increases the time spent for
> MTA table update considerable this change is limited to PREEMPT_RT.
> 
> Signed-off-by: Gerhard Engleder <eg@keba.com>
> ---
>  drivers/net/ethernet/intel/e1000e/mac.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
> index d7df2a0ed629..f4693d355886 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -331,9 +331,15 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
>  	}
>  
>  	/* replace the entire MTA table */
> -	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
> +	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
>  		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
> +#ifdef CONFIG_PREEMPT_RT
> +		e1e_flush();
> +#endif
> +	}
> +#ifndef CONFIG_PREEMPT_RT
>  	e1e_flush();
> +#endif

#ifdef FOO is generally not liked because it reduces the effectiveness
of build testing.

Two suggestions:

	if (IS_ENABLED(CONFIG_PREEMPT_RT))
		e1e_flush();

This will then end up as and if (0) or if (1), with the statement
following it always being compiled, and then optimised out if not
needed.

Alternatively, consider something like:

	if (i % 8)
		e1e_flush()

if there is a reasonable compromise between RT and none RT
performance. Given that RT is now fully merged, we might see some
distros enable it, so a compromise would probably be better.

	Andrew
