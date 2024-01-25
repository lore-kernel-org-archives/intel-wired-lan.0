Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC27C47258
	for <intel-wired-lan@archiver.kernel.org>; Thu, 25 Jan 2024 11:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A60440604;
	Thu, 25 Jan 2024 11:59:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A60440604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706183983;
	bh=QwlYYP+yaZyVTbLqCJZZlNKMpIz8nZM5nExtNJ/XoMY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=X3FdCb/BboUgVXo4wdgYMDVS4TSOGGCJiX2HYlDzraD4zhZ+MsfulBKbcLfSQy2uu
	 QNPu3hHfCJVLxa9IPhgbMqsga2oR+cr+5RZ4NCIh7RGuo5Z84qhDo0RWcms1z5p90z
	 hiZzhTPcrZA3/yzA0iar3ZwI+M5xY1N5w8tppGGDauowm6hBS4w/+hJ7VQv6pTfylq
	 51esrNSAcPv7prsEfc1JebJ/ID5EWHSrOqsxgtD4rgarRtGlBSt863ims2ZUwPByUu
	 OW/xaBHo+Ub8pFI+GeCSn2D0pKewuGtQOroVru5BrPckcxTMUaMW4GtUotgu1KtgKE
	 t7jSwsZr2Xk9Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tDDxJ0PpgYkC; Thu, 25 Jan 2024 11:59:42 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2819D43561;
	Thu, 25 Jan 2024 11:59:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2819D43561
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 5A1881BF20B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 11:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30D4640ACB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 11:59:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30D4640ACB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cDjrmliHA1Q0 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 Jan 2024 11:59:39 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C0DE40604
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 11:59:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C0DE40604
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1953DCE3240;
 Thu, 25 Jan 2024 11:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD4DC433F1;
 Thu, 25 Jan 2024 11:59:32 +0000 (UTC)
Date: Thu, 25 Jan 2024 11:59:29 +0000
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Message-ID: <20240125115929.GL217708@kernel.org>
References: <20240124085532.58841-1-kurt@linutronix.de>
 <20240124085532.58841-4-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124085532.58841-4-kurt@linutronix.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1706183974;
 bh=s23dJ35CvjO2GLs4pQrm0dyzy7mxAGZCc+mvoDskWpo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KPclyHyy1qSMFLrfvbLhr2zSNMA65LCs2SoekDzINxCRRmYuDlKgOzER9s9bgiRnu
 Pm3Te2JT8g7a3EuxxRp/fJBqewgpZ4X8U3jDI0kMpBMmmJ8OX5amPb3iio/CUcBEO6
 gUjmaYi8uAm3fRB3WUb2gwahelL/npqSOt/Vw7LMnKQsyI/MtjQ/7Av7rmzT5WH+TN
 TQBo6afXxVIR5GX5R7KZ3GEaENO6krNQxfsdAk3HQn2GLqNUchkb9p4A+ghhS2BzSd
 x2SDfiL/Iwup2NYX9u6UEMlNVXZocyaoJaaMk6PQC5rlpEYBE90BgE21dwvOW9d4c9
 w679kjA8PGCfg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=KPclyHyy
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 3/3] igc: Unify filtering
 rule fields
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
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jan 24, 2024 at 09:55:32AM +0100, Kurt Kanzenbach wrote:
> All filtering parameters such as EtherType and VLAN TCI are stored in host
> byte order except for the VLAN EtherType. Unify it.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

