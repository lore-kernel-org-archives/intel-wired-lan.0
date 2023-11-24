Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ADDC61D97
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Nov 2023 11:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 112D860B0B;
	Fri, 24 Nov 2023 11:00:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 112D860B0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700823652;
	bh=4j7dIonebJtV5L72uHnruBlxjjebnNQO+ISQHQ2Dpuc=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=emnw8XN7MTG3fpQG4DjRyq/iZ9WhsTOPP5Adz4WBf0B+wWnd06YxrJegxn1i2ZJI5
	 +I7/Hv9llclgd+QRKsI5mjhaTD2FqI9NQ4h3NHUt5fxT/7YcVuBWGT00GSCvvruXi+
	 IeKYXtUFOx8tyOy4ARKbjJuomj7349fCjUkXFS+7r2oZ8zmqA4Ldr1+7/xlBo4sKLH
	 Fx4Qo37PBVltLly+D7FE8xHDD74P+Ze/mbEc93vmN5uJGNSvFoSO59ko97wtQMe+RJ
	 zZgwQr0lQ7Bk/JncBcVh0KM5dJuF378rXodlrCRgHDLLCDATS8a+qvOY2rxS4Ny2ye
	 KH2sxwVQCUq5A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T8c2Dv_mdnU7; Fri, 24 Nov 2023 11:00:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AC2A614FF;
	Fri, 24 Nov 2023 11:00:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3AC2A614FF
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 20E2B1BF83C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:00:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8EE3840132
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:00:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EE3840132
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R5rXU1oz1gj7 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Nov 2023 11:00:48 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9835401D2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:00:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9835401D2
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 00094B8164A;
 Fri, 24 Nov 2023 11:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3656DC433C8;
 Fri, 24 Nov 2023 11:00:45 +0000 (UTC)
Date: Fri, 24 Nov 2023 11:00:42 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Message-ID: <20231124110042.GF50352@kernel.org>
References: <20231121211921.19834-1-jesse.brandeburg@intel.com>
 <20231121211921.19834-7-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231121211921.19834-7-jesse.brandeburg@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1700823646;
 bh=fZnitmSPXZKwgPdo66YLsPoA9dTxzgOfY2rIV7jtyjQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rMirdcIwo+Xq2KpE8xH6kwLW/X9NWRIjhkC2dJV8cwJB1J4Lztd7CSrXvpzv5qpys
 bp/OYnOrEqCJ4SL5yBaKwcyRf8G4nQgfqNt7EzrkzRAXi/COtYu/3VlWqOUN7t+Bxs
 27HGO2iqVAKLXJ9a+2lALzz0REjoaCd1TdscCXklVd5DBw26NFoyu6gDCRa3q3RlXT
 1IE0UjLWsIubjperZxEZOvfBZRnW1ZH/MzIuvNnW6GFfCNrw9M1poKeCmhw1+6QbR0
 DhB3tU9HmI5EkLQxmwxDCH62YcRzfSNrgaJxQQy5EWddgpwsDEQaeJCPFKB2siV1NM
 4YhLsLDBWTUcg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=rMirdcIw
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 06/13] ice: field prep
 conversion
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
Cc: Julia Lawall <Julia.Lawall@inria.fr>, netdev@vger.kernel.org,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Nov 21, 2023 at 01:19:14PM -0800, Jesse Brandeburg wrote:
> Refactor ice driver to use FIELD_PREP(), which reduces lines of code
> and adds clarity of intent.
> 
> This code was generated by the following coccinelle/spatch script and
> then manually repaired.
> 
> Several places I changed to OR into a single variable with |= instead of
> using a multi-line statement with trailing OR operators, as it
> (subjectively) makes the code clearer.
> 
> A local variable vmvf_and_timeout was created and used to avoid multiple
> logical ORs being __le16 converted, which shortened some lines and makes
> the code cleaner.
> 
> @prep@
> constant shift,mask;
> type T;
> expression a;
> @@
> -(((T)(a) << shift) & mask)
> +FIELD_PREP(mask, a)
> 
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
