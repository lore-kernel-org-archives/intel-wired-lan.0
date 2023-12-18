Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12837C35274
	for <intel-wired-lan@archiver.kernel.org>; Mon, 18 Dec 2023 12:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B3BD641759;
	Mon, 18 Dec 2023 12:09:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3BD641759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702901350;
	bh=7HT87doCs/xRfSCyWfKVc44TuU14rs3wORmiyYz0JvA=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=RqjuwBySueWDsjTvANVnjCO36UvLbOu9HCgCgGIrpmubKpOx5Mltp1dAeF4W2PIDh
	 SJsNwnZ+btL6KnnOUJop69MYumUPg4d4/aRMnseqFHunLJ31UbcAttVCdEN8wavuQY
	 PQrMjZwVikEl+PI923rTIDQ93AX6YqKWkZZrbKyVGGLkeQT+9bd9NOPagMm0o7kI3y
	 zPYhjg65x9s7DpeHJcjLFLCIfS0bvWyrDpm9QpNBEDoo0B9WTgjddToG7PolWSBtfn
	 TTLgkQOvjkWLwof138MFnj/2rjHFf24CMGxm4pcg84+v0Tcj0cpcQcMX6DfGuXZpLy
	 PjzD4AII/drUA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LvekL6ybX0w5; Mon, 18 Dec 2023 12:09:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id ACF5F40600;
	Mon, 18 Dec 2023 12:09:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ACF5F40600
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 251C01BF31B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Dec 2023 12:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F010B41695
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Dec 2023 12:09:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F010B41695
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SQAVOL3uByfD for <intel-wired-lan@lists.osuosl.org>;
 Mon, 18 Dec 2023 12:09:07 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3058341685
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Dec 2023 12:09:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3058341685
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 0F84BB80E59;
 Mon, 18 Dec 2023 12:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0984BC433CB;
 Mon, 18 Dec 2023 12:09:01 +0000 (UTC)
Date: Mon, 18 Dec 2023 12:08:58 +0000
From: Simon Horman <horms@kernel.org>
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Message-ID: <20231218120858.GC6288@kernel.org>
References: <20231215234807.1094344-1-pavan.kumar.linga@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231215234807.1094344-1-pavan.kumar.linga@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1702901343;
 bh=5T8VNG0SXY77I499chQGBaQNatxLNPqrynNliZvOJrQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hBWD3xupk4+m+SCJsXi49aIaSlqk65+7PrxYDFLV1eYaiB/c7ndk+d2nOgLErI/nz
 rs7Dkq/jxP/mYct5v+Q3uLgnWomh0nu2fAOGWr/KW2ciBY90/kmiUgngc4V1+C/p12
 dqd8OUY0k/BLyg2iGcHk9qavrFGODkM1Wkfo1BlgiWjf1G0iEAJAufdeJfrfJYmy2x
 DEsxM2Ko8LT9Gj+NPUlvS2Z9Fc3KTB8HFLHq4rWQhP26K2SBzjf5O40TX0N1sxIrZb
 8bq5y+P75jdepzrBMhYteGC9tR0Jyo8axxVCtgfEYh/J+OEhejeAsRKw+/qksg17B/
 vRMMeYIITHFfA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=hBWD3xup
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: avoid compiler
 introduced padding in virtchnl2_rss_key struct
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
Cc: netdev@vger.kernel.org, aleksander.lobakin@intel.com,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 larysa.zaremba@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Dec 15, 2023 at 03:48:07PM -0800, Pavan Kumar Linga wrote:
> Size of the virtchnl2_rss_key struct should be 7 bytes but the
> compiler introduces a padding byte for the structure alignment.
> This results in idpf sending an additional byte of memory to the device
> control plane than the expected buffer size. As the control plane
> enforces virtchnl message size checks to validate the message,
> set RSS key message fails resulting in the driver load failure.
> 
> Remove implicit compiler padding by using "__packed" structure
> attribute for the virtchnl2_rss_key struct.
> 
> Also there is no need to use __DECLARE_FLEX_ARRAY macro for the
> 'key_flex' struct field. So drop it.
> 
> Fixes: 0d7502a9b4a7 ("virtchnl: add virtchnl version 2 ops")
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
