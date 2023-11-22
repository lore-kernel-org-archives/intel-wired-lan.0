Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC273C61D97
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Nov 2023 19:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 79A7040B5E;
	Wed, 22 Nov 2023 19:14:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 79A7040B5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700680465;
	bh=XRRbGgdLj1zTqdpow9YcY8MvXBJug48koB2HSwv4KaY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=p30qmeN+m3/DYgRr9tmFQVz4YwGQWXf42a84AkOKfj7RWdkcueTrcboEbGny6gtOx
	 o6UqrGcaot1YFra9rK1V56z4Fmcj9MzTVU9QzwfeMs2W6t/GGW0kRC97mq4LpIzqrN
	 vMGjTZp3q2B1ve1kBsK2m9nh1461870e7Mq5e0jzMPmDotHxjkUHX+yUICgTbt1lHB
	 XOlbPVPBaW7hcC+5k+3X+izPy993x7bRapPGf9vGyj9cxjDPUMMe8axlx1X7pwKz1E
	 XIu+NbGjVtE7sRhIFQ8bCACPVBzu1O+KFd3EmaT07VZy39zYry5UYMFOMER9KhRBX5
	 N+CEMbisxXCpw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SFfN8zONRHGU; Wed, 22 Nov 2023 19:14:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 400684156F;
	Wed, 22 Nov 2023 19:14:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 400684156F
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 1AEF21BF5A3
 for <intel-wired-lan@osuosl.org>; Wed, 22 Nov 2023 19:14:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E5A54417E5
 for <intel-wired-lan@osuosl.org>; Wed, 22 Nov 2023 19:14:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5A54417E5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dCAXtsBz2lp1 for <intel-wired-lan@osuosl.org>;
 Wed, 22 Nov 2023 19:14:21 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 284BA417A0
 for <intel-wired-lan@osuosl.org>; Wed, 22 Nov 2023 19:14:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 284BA417A0
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 02912CE2576;
 Wed, 22 Nov 2023 19:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E471C433C7;
 Wed, 22 Nov 2023 19:14:15 +0000 (UTC)
Date: Wed, 22 Nov 2023 19:14:12 +0000
From: Simon Horman <horms@kernel.org>
To: Pawel Kaminski <pawel.kaminski@intel.com>
Message-ID: <20231122191412.GC6731@kernel.org>
References: <20231121013206.2321-1-pawel.kaminski@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231121013206.2321-1-pawel.kaminski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1700680456;
 bh=3uUNLffVdKPjS8Q4KLxSXXCEhTPX2bXSPf70fTAieZo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Eq75cjTfd5GJ+DsSDsMy2Rtc0r3643pav2O6pLdTtCoQykMBgLm/fwbXdRQQOgUB9
 n7r0SEHPZfbm7pyL5PiDzqn6heLXEjfXhIlz4bRpnt93QzcFX6zElk0LH0rQyCFypl
 Auz3u/lkSBfOyJJgqa+KBh/6zIsu8sZ3VQsfH8iaNIzUl/Rcxa2FzTgcjpra69U6Af
 EMlxFZU4YzYmx/rUZEGq9OAelFsrYwORgFsXMpxdEeas9wo8F9IE1MPZV5YPSH9YAL
 T/1PDJ8wMnnjvIxP/0uvG7Mp9dB7khzq/oxQTD78bw8ld5FCgNYuwR0HzndZVX6TEC
 kjPFPZCnB7xig==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Eq75cjTf
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: Improve logs for max
 ntuple errors
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
Cc: intel-wired-lan@osuosl.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Nov 20, 2023 at 05:32:06PM -0800, Pawel Kaminski wrote:
> Supported number of ntuple filters affect also maximum location value that
> can be provided to ethtool command. Update error message to provide info
> about max supported value.
> 
> Fix double spaces in the error messages.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Pawel Kaminski <pawel.kaminski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
