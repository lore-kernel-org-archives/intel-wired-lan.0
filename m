Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84EEE85361
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 12:41:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9990040DAE;
	Fri,  3 Apr 2026 12:41:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0bQ6xS3L8_db; Fri,  3 Apr 2026 12:41:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 040F540CCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775220101;
	bh=Vekzw8GYXZkrzbWPGxO47NxxzrpBBGFPf19yrxCLf/c=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EMwMrQe9zBuAHkIsAYt9N93A+LPNVK7QO/9S+MavxAxwtISTfJebnuGgbW7rOaV0B
	 GKZU+LlBMlZv51E7PSBVk930+M/Sbub/dJ3TFdL0rMSszBQh+XuPbm2am6TYXg2veS
	 psR7TivBWmFXWn1WyegpPUskkiQ2sACUJoIAi4wzKR2VNTLFfbfoj9LzicQDylSiHg
	 SWQYV/3o8zcMw8jh57a+XLL7mOvCa88sH6kvPQQtlU6Iwyk4vOMG9dxhCeWHTNIHtS
	 Kbxl28yR8GWssB3zDK936qNcg4+vOXDowXDUVzKtdLxE08fm889m0Hd94+xhmv583O
	 QeUUkulGAYtSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 040F540CCC;
	Fri,  3 Apr 2026 12:41:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AA0842CC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 12:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A729940CCC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 12:41:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1sCpVFfa3w_S for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 12:41:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A56C540CB1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A56C540CB1
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A56C540CB1
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 12:41:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A88526012A;
 Fri,  3 Apr 2026 12:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4571DC4CEF7;
 Fri,  3 Apr 2026 12:41:36 +0000 (UTC)
Date: Fri, 3 Apr 2026 13:41:33 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>
Message-ID: <20260403124133.GA94926@horms.kernel.org>
References: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
 <20260327072236.129802-5-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072236.129802-5-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775220097;
 bh=z8NrtHzt34fo5KWYtZktd8j1ets5GtZS/kxrf+Fhp5M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PbgrrhNP88JauZDGnFRmvL0Tyl9EH9aDuxtxGwkP2c27zutg9k95vwgi+UqBYlU+T
 0EWA/e2I3o6BD9Zjtqel5L417KMLBoDq2Qdldd4pXthUu7B14D1Tzzgb6pzQS6Mak0
 E/NKXwyztGGzdtnLBHctLbKhGSlKtLBvTuoAcFFqRo1D9OerHEkGr0ltrN4DM8Wy4d
 3yCBPiTdh+PttysA8khDho+JOcfPHOKiukP0JlMaV36vvfJz5izt+LQ+KlVDbQM5yx
 MLjUjKDrVNAAg2X/652SDz13DxabyrpYf36tl4PKsjPW1V7BFR31S78WYc8EQYR5FQ
 59XTwBfAt7RAg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=PbgrrhNP
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: call netif_keep_dst()
 once when entering switchdev mode
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

On Fri, Mar 27, 2026 at 08:22:36AM +0100, Aleksandr Loktionov wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> netif_keep_dst() only needs to be called once for the uplink VSI, not
> once for each port representor.  Move it from ice_eswitch_setup_repr()
> to ice_eswitch_enable_switchdev().
> 
> Fixes: defd52455aee ("ice: do Tx through PF netdev in slow-path")

This problem seems to predate the cited commit.

> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
