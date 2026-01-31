Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A158D79742
	for <intel-wired-lan@archiver.kernel.org>; Sat, 31 Jan 2026 07:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 168BD60AF5;
	Sat, 31 Jan 2026 07:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gQhdEo5CzUre; Sat, 31 Jan 2026 07:04:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4587A60AE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769843050;
	bh=9+22T3qAILLWnarXKk2rk2jH9okIYXXwV2PNBFUkk50=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TJtqYv6gyznBhV3EXdelDO0KpiDnc/UAli2F7TI4/bPWaNbZOX2X1ZboZqjk/DEnz
	 CxQytSxwPwUzTAnRM+vNTcm5tpoEBWUgbc8ycgySioWrON/MshswEkpPQLHkIze09B
	 onhj1Aog2X66gy+HJhDdEiP2XvHg7ENohAT2Eo34EHbZHEZJlgs9zYe41cKUcBQD/y
	 hxoX+BsFFNVgzpxaq+InFCRboGYH86dI3ABs6gg2FKYPTRpkYBskFojs7Sg6fom8aa
	 U++w6Jj9qYejIuMIG6gTRWE4a7IDwqciTwP5Z07Bvk1oLABIqh8P6Rw6+j+b3lRNVS
	 d5dwurjt2mhNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4587A60AE4;
	Sat, 31 Jan 2026 07:04:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C53681F6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 07:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A075783C1C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 07:04:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JOeYUE-88zhc for <intel-wired-lan@lists.osuosl.org>;
 Sat, 31 Jan 2026 07:04:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B94DE83C15
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B94DE83C15
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B94DE83C15
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 07:04:07 +0000 (UTC)
Received: from ms-a2 (248.212.13.160.dy.iij4u.or.jp [160.13.212.248])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60V73ZSS013433
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 31 Jan 2026 16:03:36 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: kohei@enjuk.jp
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, bjorn@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 lihaoxiang@isrc.iscas.ac.cn, linux-kernel@vger.kernel.org,
 magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, stable@vger.kernel.org
Date: Sat, 31 Jan 2026 07:02:38 +0000
Message-ID: <20260131070335.38303-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131061304.27368-1-kohei@enjuk.jp>
References: <20260131061304.27368-1-kohei@enjuk.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=9+22T3qAILLWnarXKk2rk2jH9okIYXXwV2PNBFUkk50=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:To:Subject:Date:Message-ID;
 s=rs20251215; t=1769843017; v=1;
 b=DFLkZzagAsrFRi53NMETPhbWhcFfg4o9hcQnuMUXLA+1j4H5WwvOjBmv9eykxz5T
 jW4UkQWDIv0yMUtX7cCJmimqaWrj4WIBnkAI92WdByrBv4TyXcH8m9t10KgRqlPZ
 gehnhZxXZZGTayYdVsFSyM1NRhDOFiHR4/lSqYNWNjwhiytG9SSnXes38QxL7qDS
 obF5Rs+DGcWrwMzi+cR8+pBgExZOKFVCiSP2D/2wELUankdMn2dKpSDiLbQQEFls
 1dQlmUkmdZG0t+sMc+C3AqruS/u9w9a7hT4mBomgbSaG7+5EheuasQ4ZAW//4dQU
 ofR8nH7F98rogpqaFEHOLg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=DFLkZzag
Subject: Re: [Intel-wired-lan] [PATCH v2] i40e: add an error handling path in
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

On Sat, 31 Jan 2026 06:12:12 +0000, Kohei Enju wrote:

> On Sat, 31 Jan 2026 13:52:17 +0800, Haoxiang Li wrote:
> 
> > In i40e_xsk_pool_enable(), add an error handling path to
> > prevent potential memory leaks.
> > 
> > Fixes: 1742b3d52869 ("xsk: i40e: ice: ixgbe: mlx5: Pass buffer pool to driver instead of umem")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> > ---
> > Changes in v2:
> > - Add a Fixes tag. Thanks, Paul!
> > - Replace unmap with i40e_xsk_pool_disable() to prevent
> > a limbo state of queues. Thanks, Maciej! 
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 9f47388eaba5..a72a309540c3 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -108,23 +108,26 @@ static int i40e_xsk_pool_enable(struct i40e_vsi *vsi,
> >  	if (if_running) {
> >  		err = i40e_queue_pair_disable(vsi, qid);
> >  		if (err)
> > -			return err;
> > +			goto err_out;
> >  
> >  		err = i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], true);
> >  		if (err)
> > -			return err;
> > +			goto err_out;
> >  
> >  		err = i40e_queue_pair_enable(vsi, qid);
> >  		if (err)
> > -			return err;
> > +			goto err_out;
> >  
> >  		/* Kick start the NAPI context so that receiving will start */
> >  		err = i40e_xsk_wakeup(vsi->netdev, qid, XDP_WAKEUP_RX);
> >  		if (err)
> > -			return err;
> > +			goto err_out;
> >  	}
> >  
> >  	return 0;
> > +
> > +err_out:
> > +	i40e_xsk_pool_disable(vsi, qid);
> 
> I think return err; is missing...
> 
> Also, since i40e_xsk_pool_disable is not declared before this line,
> compilation fails due to a 'Call to undeclared function
> i40e_xsk_pool_disable' error. Adding declaration or moving
> i40e_xsk_pool_enable() after i40e_xsk_pool_disable() is needed.

After skimming the code, I think i40e_xsk_pool_disable() can fail in
this error path, right? 

Let's assume a scenario that i40e_queue_pair_disable() succeeds but
i40e_realloc_rx_xdp_bi() fails in i40e_xsk_pool_enable(). 
At this point, i40e_enter_busy_conf() called by
i40e_queue_pair_disable() has set __I40E_CONFIG_BUSY state.

Then the err_out: path is executed and i40e_xsk_pool_disable() tries to
call i40e_queue_pair_disable() when if_running.
In this case, i40e_enter_busy_conf() fails because __I40E_CONFIG_BUSY is
set, and finally xsk_pool_dma_unmap() isn't called.

Do you have any thoughts on how to handle this case?

Thanks.

> 
> >  }
> >  
> >  /**
> > -- 
> > 2.25.1
