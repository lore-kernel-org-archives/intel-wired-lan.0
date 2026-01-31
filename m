Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18167D79741
	for <intel-wired-lan@archiver.kernel.org>; Sat, 31 Jan 2026 06:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8CBA83DC5;
	Sat, 31 Jan 2026 06:13:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D8InQM2EpGkf; Sat, 31 Jan 2026 06:13:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 161FC83D9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769840039;
	bh=vpaHteD97DiVFaAs0Ate1NmbUcN7m/ErCU3DJJSYNzQ=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sHdLYOuLa9+ABRP2RsUx/gk2eqdmKtUJ/p8hWouT/jR0sh5FcYrBLmmVGOGQVXDua
	 wRqWdwzLOBFOv+ufA/0bD5splOZhmcppuWg19ZwBv4zolUvDR5GCuLBewgYEl1dLiV
	 Sqpmt6EDFDgXNoiR0pSoTeOu6pXfbr/2r6TWIruHXuT8qOXHDBplCD5wftq/0SeBPC
	 TUdK0dWlmsMOjwhoSD5hiJV/SZmv6/ouiBgBnjSqy3m5VbhsapZ5LEVvsjJ85e7s9m
	 +o0hbiALH9NgbZZ2IAjaQul23KtOitTCnmSflDQJiJyOqzW/7l3jwg3hZ3wycwc5lc
	 pvQixfN0A+S4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 161FC83D9B;
	Sat, 31 Jan 2026 06:13:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A186D1E0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 06:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 900BF40860
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 06:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nTAQOp1Tg475 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 31 Jan 2026 06:13:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 24CAB407D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24CAB407D3
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24CAB407D3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 06:13:55 +0000 (UTC)
Received: from ms-a2 (248.212.13.160.dy.iij4u.or.jp [160.13.212.248])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60V6D4tN072210
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 31 Jan 2026 15:13:05 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: lihaoxiang@isrc.iscas.ac.cn
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, bjorn@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, magnus.karlsson@intel.com,
 netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, stable@vger.kernel.org
Date: Sat, 31 Jan 2026 06:12:12 +0000
Message-ID: <20260131061304.27368-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131055217.729048-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260131055217.729048-1-lihaoxiang@isrc.iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=vpaHteD97DiVFaAs0Ate1NmbUcN7m/ErCU3DJJSYNzQ=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:To:Subject:Date:Message-ID;
 s=rs20251215; t=1769839987; v=1;
 b=XBgenLn4wgnJ1zMAW/kbmMJyhALGrl1AWnKI5gzGzCR0l8i9KZbBLIDcu0tePkHc
 rOGF0PSUBXIVaYHmG/9n4d3faCODXk0AA2ogUrazk3Gzn+9EN0tWrhG+eOUTzLlK
 wpuUpzN6Xn3XtwUW29KXyLQ5JX0nTvYOAzgXSLHlEZ7Pw9vceAjcbwZyIX5/dLag
 95lbE4NuAlvETCjmWsU+yPEYbKa2gv5EwzWwbzu1LLdw/yxbCYuOo3yP/QmpnYi8
 H+tr4Wwf4t+WC0tytEuU9K04OYW/0QntG0I9yG3Lu1xE64Q6hieIvZjI4d+1FbQ9
 BKYHYasNAQrt8K6nJmEzRw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=XBgenLn4
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

On Sat, 31 Jan 2026 13:52:17 +0800, Haoxiang Li wrote:

> In i40e_xsk_pool_enable(), add an error handling path to
> prevent potential memory leaks.
> 
> Fixes: 1742b3d52869 ("xsk: i40e: ice: ixgbe: mlx5: Pass buffer pool to driver instead of umem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
> Changes in v2:
> - Add a Fixes tag. Thanks, Paul!
> - Replace unmap with i40e_xsk_pool_disable() to prevent
> a limbo state of queues. Thanks, Maciej! 
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..a72a309540c3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -108,23 +108,26 @@ static int i40e_xsk_pool_enable(struct i40e_vsi *vsi,
>  	if (if_running) {
>  		err = i40e_queue_pair_disable(vsi, qid);
>  		if (err)
> -			return err;
> +			goto err_out;
>  
>  		err = i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], true);
>  		if (err)
> -			return err;
> +			goto err_out;
>  
>  		err = i40e_queue_pair_enable(vsi, qid);
>  		if (err)
> -			return err;
> +			goto err_out;
>  
>  		/* Kick start the NAPI context so that receiving will start */
>  		err = i40e_xsk_wakeup(vsi->netdev, qid, XDP_WAKEUP_RX);
>  		if (err)
> -			return err;
> +			goto err_out;
>  	}
>  
>  	return 0;
> +
> +err_out:
> +	i40e_xsk_pool_disable(vsi, qid);

I think return err; is missing...

Also, since i40e_xsk_pool_disable is not declared before this line,
compilation fails due to a 'Call to undeclared function
i40e_xsk_pool_disable' error. Adding declaration or moving
i40e_xsk_pool_enable() after i40e_xsk_pool_disable() is needed.

>  }
>  
>  /**
> -- 
> 2.25.1
