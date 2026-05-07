Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34ADCD343F
	for <intel-wired-lan@archiver.kernel.org>; Thu,  7 May 2026 11:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C178410C0;
	Thu,  7 May 2026 11:46:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lHBqKAL1WtKK; Thu,  7 May 2026 11:46:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5FA1410F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778154410;
	bh=m6FCCupoIWsmvH6K3sNzVCgdJLI2sbweqUsWhYleiXk=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cuToUaGEeTDBsgy7PfGU7FzBaMMlhio9nlnXDY4xstCUaFDHh4yXOkjCsx+ayEQhg
	 /RLPDfkcoenYA7b7iZRq98oRS6KgC7Nz0ILEi4hStuoh/F63wVu+Tven9AAUqOLwtW
	 60UC4qvMNuXpC/S/NV/eich+SqdqULLGDvUsRQE4tAvfUAKFcgHr5+QPc/opbj8AtX
	 /nAKpZVlmRm+Ia6sMqkR1a5yXT9Xdh2lRpEdNF4k00Z/XWzSzw47FNNpjnXvPy/Bie
	 K4y4xWfiAzIwOLxZF0ykAVglRti7n39QL5lztekeXuKrSZLmLlJhiuqwIn8AXX9/gN
	 Sm14lo0M92eMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5FA1410F9;
	Thu,  7 May 2026 11:46:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9819711B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 May 2026 11:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7697F83B95
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 May 2026 11:46:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KSmwbybFO-tW for <intel-wired-lan@lists.osuosl.org>;
 Thu,  7 May 2026 11:46:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9C14083B94
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C14083B94
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C14083B94
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 May 2026 11:46:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B2EB740A74;
 Thu,  7 May 2026 11:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED95C2BCB2;
 Thu,  7 May 2026 11:46:46 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: 'Simon Horman' <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org
Date: Thu,  7 May 2026 12:45:11 +0100
Message-ID: <20260507114507.910365-5-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504142451.4161845-4-aleksandr.loktionov@intel.com>
References: <20260504142451.4161845-4-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1778154407;
 bh=sfcWi70OrJmTlIsQy/5eBouz7VizDbkkSc+bXyA42Oc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Df6/mn91eCgAO0YqDxN2RNhD9vBAvJNq7Xpipg/plNYuNtnKrCwnnXfj34QEdlkEC
 PTbxPDONSQmhdLpGeC/ra9hLrG/c57ocwP1d/XhWJfwZh1XGlwT8oF7pbyuBDo3s5a
 VzW8CiQR3lKCRxa0LZWpWQm9SKyw6Bpt58UfnMoFnWHb5hR+pnvLK/wufABvKz22Je
 ml29tCUCRWOFpK0gD79VX3Qv4I9nXpVvYD5JdQl/ci204eA9HMYp8afNk6HtXvqpvv
 5zwx74dYgcz9eQtOQWPAN4gUKHp1Nsjstt9t+vqK4PeMqgFvkTpxTkSNrwahRv4GPG
 y5iF3N84eJmIA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Df6/mn91
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 3/5] ice: add correct
 handling of SMA/u.FL states
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

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says:

I would also like to add that as a fix the patch description should
describe the user-visible effects of the bug, and how the fix addresses
them.

Thanks!
---
ice: add correct handling of SMA/u.FL states

This commit renames ICE_SMA2_UFL2_RX_DIS to ICE_SMA2_UFL2_RX_EN, stating that
the hardware bit is actually active high for enabling RX. It updates the uses
of the macro in ice_dpll.c to reflect the new name.

>     The ICE_SMA2_UFL2_RX_DIS bit name is wrong: the bit is active high
>     (setting it *enables* RX for u.FL2 / SMA2), not active low.  Rename
>     it to ICE_SMA2_UFL2_RX_EN and invert the use sites in ice_dpll.c so
>     that enabling the u.FL2 pin clears the bit (as it used to do) and
>     disabling sets it.

The commit message claims that setting the bit enables RX (active high), but
then states that enabling the pin clears the bit (active low). Could this
description be clarified to explain exactly whether the hardware uses active
high or active low logic?

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 62f75701d6520..7e8bb63b262a0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -672,7 +672,7 @@ ice_dpll_sw_pins_update(struct ice_pf *pf)
>  		p->active = false;
>  
>  	p = &d->ufl[ICE_DPLL_PIN_SW_2_IDX];
> -	p->active = (data & ICE_SMA2_DIR_EN) && !(data & ICE_SMA2_UFL2_RX_DIS);
> +	p->active = (data & ICE_SMA2_DIR_EN) && !(data & ICE_SMA2_UFL2_RX_EN);

If the bit is renamed to an _EN suffix and is active high, should the logic be
inverted here? This code still treats the bit as active low by checking for it
being cleared (!(data & ICE_SMA2_UFL2_RX_EN)).

[ ... ]

> @@ -1264,10 +1264,10 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
>  	case ICE_DPLL_PIN_SW_2_IDX:
>  		if (state == DPLL_PIN_STATE_SELECTABLE) {
>  			data |= ICE_SMA2_DIR_EN;
> -			data &= ~ICE_SMA2_UFL2_RX_DIS;
> +			data &= ~ICE_SMA2_UFL2_RX_EN;
>  			enable = true;
>  		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
> -			data |= ICE_SMA2_UFL2_RX_DIS;
> +			data |= ICE_SMA2_UFL2_RX_EN;
>  			enable = false;
>  		} else {

Similarly, does this code still apply active low logic by clearing the _EN bit
when enable is true, and setting it when enable is false?

If the bit is truly active high as the commit message suggests ("setting it
enables RX"), shouldn't the bitwise operations be inverted to match?
