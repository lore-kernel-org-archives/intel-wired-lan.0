Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B0DC61DF4
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Nov 2023 11:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D16D60B0B;
	Fri, 24 Nov 2023 11:00:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D16D60B0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700823622;
	bh=faWyoPSePqmMEGObNjgfkkxv9RgPimX3kTu3EH5qjGU=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=tWJk1b6djP9Fy7QYIEoUJ/Xaoniz0IsPsQUdND6dfJFtUqiLtuqee63TAsjYXd4JK
	 Zu6zdSpc4c8azLbnjrcmkSBKrqlgC/RSFQlAA8yYlMEPpeQYUATUognHKQhlyzipMs
	 0gqlB228VfqfDm1TpaoUyk2c7Vq3TZ0zTKmpWZL/0w0hIz9/F6e/4wV76JxDUzECRE
	 K2AG1kU4PH1WNvUiemo0LAlw2ODM4SrnWvCT6mN4SOkdQvRAlOIRH8BVzEcItW8Ygb
	 +YtJuJpeGiXK4UYrfWyCKQhXtLv8W9vY4gEtK4ftSJEtwZF4tSOYf5QRH4s1aP7MKr
	 t0Pq0cuEJtWsw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7uKjUub4NRwf; Fri, 24 Nov 2023 11:00:21 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4D79614FD;
	Fri, 24 Nov 2023 11:00:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A4D79614FD
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id D9AF71BF83C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C061C81FA0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:00:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C061C81FA0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O6ypseGzaUfP for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Nov 2023 11:00:19 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FADA81ED0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:00:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FADA81ED0
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9085FCE28E9;
 Fri, 24 Nov 2023 11:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F67AC433C7;
 Fri, 24 Nov 2023 11:00:14 +0000 (UTC)
Date: Fri, 24 Nov 2023 11:00:12 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Message-ID: <20231124110012.GD50352@kernel.org>
References: <20231121211921.19834-1-jesse.brandeburg@intel.com>
 <20231121211921.19834-5-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231121211921.19834-5-jesse.brandeburg@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1700823615;
 bh=RoWlJ2va+y/OxqSBAjsmw7/96mjaT9pyzABKA6pSDt4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xb5YXvbzQuc+IT1DrmFWUT0E5XW0ZdLmh5dpXmpaHUZKxZTGaCz9qVO46Ezu+BU7n
 1cbWIItZdjPAhJkk5khCy1lr0Nq8TJI03Tw/5QAy5K34azVODhwqQKl8KVZ1UtdVjp
 FSsDP8IhPTFw8dRz95YHmJ1ok52FprbhSSjzJegQO1VVc0ViZwnybVNkS1OXe5re5d
 kWG84MMJsgMduQVA2N9PD8MdAjB4tO6M7hZ1q/90yNPBrF6+x/v9htrJphetolXr8U
 h4/UsixGQEwOSiAluN9D2xTsBnM66tglzQZkWvswEezgvnY8/rgMmFxER/XJLA9MSg
 rgZdsSE99Cr4g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Xb5YXvbz
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 04/13] i40e: field prep
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

On Tue, Nov 21, 2023 at 01:19:12PM -0800, Jesse Brandeburg wrote:
> Refactor i40e driver to use FIELD_PREP(), which reduces lines of code
> and adds clarity of intent.
> 
> This code was generated by the following coccinelle/spatch script and
> then manually repaired.
> 
> Refactor one function with multiple if's to return quickly to make lines
> fit in 80 columns.
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
