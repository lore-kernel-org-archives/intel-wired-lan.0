Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA81BC624D6
	for <intel-wired-lan@archiver.kernel.org>; Sat,  5 Sep 2026 16:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76BBD40AAF;
	Sat,  5 Sep 2026 16:44:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eJokwxw_YXvY; Sat,  5 Sep 2026 16:44:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 92AF040AB4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788626646;
	b=JDg1MpuOCk+wsYj4TjLxXoI833bnKDBqZvtpvT2+TkV7QaUmxk3cKHQHuKHk4syTkXI7
	 ZddYglG3yY9oP5kzdebyNoHMTZEjfB0aYRToxlw3GRytkfpRqJHex2LYCkakpRNjWc1l9
	 05qd7OjJcMnjXW3eEbPXV8iboMHYTyAuS88fFsuZ7lzIV5VQIOKP2S8Vv+Qdj3G7Yh4yi
	 E0P3h1kMrtfedKG/i92lFgQubTb4sGPn71nbD/rOvjmHqPptcEJC1aENOf8qzviHOcKxT
	 uNCSlahEyXZCPY1NQE6Pne/g49hbnp1xZ0c6MB3dTwXHun1mAF9roqrIVKkWBNagsWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788626646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LWaaU5zyScA+VJ02eCufXGlRBF8ep/hpmQdGT9xk1D8=;
	b=eKgiswZBjWdHgpgxxvxG4IzXwtndxPaH1HrI+lSOXaLzaZSGjS2FjxNsfM4UzKkb2Qth
	 kdM/5RGbW0GcmmQZc+CxHPRibr95yBcYe0RXuF9G2hYldYNgpVJceZV68tiikGkcHhtBM
	 2p75K+qBfy0WHCTZhPr7SctTPL/43V3MNzSp0fRQpEot9nAp4SGfELEaMUSOvNGDSoRvi
	 mauX+8r3b/veRIbQy3VmeYSyTQvnX9Gb7vSasIcspJshgRDBKPX6zGTvg5G9+5OC47PwJ
	 N5yZId/XPrvBMNmyqP6z9zZYuWDhoDc6JvKXJIlg9ciw/+5yg3FPEGRKtPdx00s4+LA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788626646;
	bh=LWaaU5zyScA+VJ02eCufXGlRBF8ep/hpmQdGT9xk1D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZtAYKq3XiUharz7SKXWANar8eZ7EHxAtoRnwlT4d6Dzb2JlzVBn64QArd0sCBqtT2
	 oR4UTqHWopg8N2CRfFKXNNaWgYD48qInxh6EcpmdiJlULauFUhnSeS7nXSF50krU75
	 VkjrYhdsXsyJ9WMxqVsgVjrFeKD66DB30W/YyZnUSYRU93JuXn8cgSSQuMomtCovfg
	 4CU7oUjbzFVzlytrTl6WoBRhD43lpRezTxOUEcj4Y1aCOVe7KXhoFZlb7xUx5fm25R
	 4U1749fm47v+oM/aqr377/KGi7+MccN8yfjQxQQkmvtjEq3D5Xl2krW/VauTmab+5U
	 znJ+LMvZUfbiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92AF040AB4;
	Sat,  5 Sep 2026 16:44:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E6D0B88
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 16:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 212DB40067
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 16:44:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PJU0pcKNxnK5 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  5 Sep 2026 16:44:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3A1C44004C
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788626644;
 b=o/M7j5rmtPMlJ2lN/HRpdV9fsFTLWJZfCrB/9HWEB8qIjy6LiKzcVORbzEOG0lTv02pe
 5yOEge6Qaufk62NwPmt3LumIznPEukqbSr+mhVQQtUmZckb4x1+d59HT1gofniTOFxu9s
 46DAOX2Lpf7gKYV28Wc+TD/cvfRhwIIz6rKp/VoYJJLJz4mb19c6bbuBVHH7kZ/GRtECu
 QGiEdKFtfVg6EFxeCXZFqj+O2arCVbiqtMT2mdykLqtT6sHLWD97cPP15ViOLAdfXaHGh
 cLdt3WD/z+osJTZfts0KKArg/MELjhPjYKbpX8RJgAiQw0Wtq7W0hrvWI4qGDxaJW3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788626644;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=LWaaU5zyScA+VJ02eCufXGlRBF8ep/hpmQdGT9xk1D8=;
 b=juXFK1I4+8CNxBoUYJK52ovEW0IHLrVKo5kUi2WFPzAxKTgVXe3B+RVXFiTW8qUgVI2w
 D5U70Bn2HuDmGOV7PRs6o1/0yzE+Z1oWSDaw+4vXQBuIrqpWIYFpwiRJXFZQqeGKEmVdG
 fu8DMB4GLjy026bxdAuuX9N4WwQI7aTb2sHVpuvKfbsZdWiIzrwSlZE5+nOvhmw0rRGZt
 68IV+E5T/9I6qlpS2v9Gyko8bxUhnUe5xIiudgJCh5vRy5EvTXxTiOzmCy6gf03AzFoNg
 r+WZrV29cpnnNIXWZ0p7UWnde08oYQZ5TZ/wBjiKYHNUtuimhvnQ2xPZmKK+ikO5ZTw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JNXGIKey; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JNXGIKey
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A1C44004C
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 16:44:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E6A544522;
 Sat,  5 Sep 2026 16:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999E61F00A3A;
 Sat,  5 Sep 2026 16:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788626642;
 bh=LWaaU5zyScA+VJ02eCufXGlRBF8ep/hpmQdGT9xk1D8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JNXGIKey5pisbmytxYo7UefMTE3aD9X+bgOEHTATZJQ4/Wnn5WuULPujASquUWeyl
 pk2O5BLuIHkzVGnWM1j3gSgFf9DQXzsyKPXBQE3MZP7F9SE7w/OQcGqIc6j6QLXlAL
 StqG3AVsrbLVMiz7JQu7iCT2tpDm+g+LbwRG/LDHgdDMHAnGXjYiTmOtYYp5w3xPLP
 Tso6XsLb4glCAKSQ4i+xnN65UHQWkUkTFp/Pgwj8zcF4NdarwpVF05Pt9DJpjZ7Iyk
 6Wzv5T72IxSt2ol6OY58Y+C0adcJGdE4CfRzAVEzhnYLp0aw1xC4Hm+2xMqMzQp6N6
 aVmMcG0P0zlzQ==
From: Simon Horman <horms@kernel.org>
To: aaron.ma@canonical.com
Cc: Simon Horman <horms@kernel.org>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 henry.w.tieman@intel.com, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH 1/2] ice: restore DDP state during PFR recovery
Date: Sat,  5 Sep 2026 17:43:50 +0100
Message-ID: <20260905164350.150004-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903074706.602087-1-aaron.ma@canonical.com>
References: <20260903074706.602087-1-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260903074706.602087-2-aaron.ma@canonical.com?part=1
---
Subject: ice: restore DDP state during PFR recovery

This patch serializes rebuilds across PFs of the same adapter while allowing
each PFR to complete independently. It reloads the DDP package from its
cached copy and restores the default DVM recipes before rebuilding the
remaining PF state.

Fixes: 462acf6aca85 ("ice: Enable DDP package download")

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3aa..a97a1941cec6a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -659,7 +659,9 @@ static void ice_do_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  	 */
>  	if (reset_type == ICE_RESET_PFR) {
>  		pf->pfr_count++;
> +		mutex_lock(&pf->adapter->rebuild_lock);
>  		ice_rebuild(pf, reset_type);
> +		mutex_unlock(&pf->adapter->rebuild_lock);

[Severity: High]
Can this cause a use-after-free of pf->adapter during concurrent device
removal?

If a device reset triggered in the service task takes longer than the
timeout, ice_remove() proceeds to teardown and calls ice_adapter_put().
For the last PF on the adapter, this drops the refcount to zero and frees
the adapter structure memory.

However, the service task is only explicitly halted by ice_deinit_dev()
after this point:

ice_remove()
    ...
    ice_adapter_put(pdev);
    ice_deinit_hw(&pf->hw);
    ice_deinit_dev(pf); /* service task halted here */

If the service task was executing ice_do_reset(), it will eventually
complete the rebuild and call mutex_unlock(&pf->adapter->rebuild_lock),
dereferencing the freed adapter structure.

>  		clear_bit(ICE_PREPARED_FOR_RESET, pf->state);
>  		clear_bit(ICE_PFR_REQ, pf->state);
>  		wake_up(&pf->reset_wait_queue);
> @@ -704,7 +706,9 @@ static void ice_reset_subtask(struct ice_pf *pf)
>  		} else {
>  			/* done with reset. start rebuild */
>  			pf->hw.reset_ongoing = false;
> +			mutex_lock(&pf->adapter->rebuild_lock);
>  			ice_rebuild(pf, reset_type);
> +			mutex_unlock(&pf->adapter->rebuild_lock);

[Severity: High]
Similarly, does this reset subtask release the rebuild_lock on a potentially
freed adapter structure if the remove timeout expired while the rebuild was
in progress?

>  			/* clear bit to resume normal operations, but
>  			 * ICE_NEEDS_RESTART bit is set in case rebuild failed
>  			 */

[ ... ]
