Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C613C4167B
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Nov 2023 16:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 33E204018F;
	Fri,  3 Nov 2023 16:57:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33E204018F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1699030628;
	bh=Rdde/Hwd9FQrizZVXVdpjP+obAWdL0O3BUf7ecrXVns=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=pTOiJimtu7IRkCzEQispYOKdbCgASI0scQhrx/xcCDtnXQYHC/AtPiw7tQq50QO0W
	 ii+kjz9jApeSaDCpoDdrwqSxZOLVr4XXwOwHjfeuYxj/KpMCM8+jh/u/mX/M4yVt1j
	 YBEhFp2zMgxMJ60So9cw1pN6958gJ9xnPvcDfwyC/pp+si5/IMuJ3CBU0A3ZdYN/ok
	 3X6pLYpvInaePCX9R5u5HPWrVyi4KJqysCujjiMFofE0SUT6Q3O5VrzNUGBBV4qSkn
	 hBCzIa9IOOjTgPKa0Kh6/SvfTYlzi1ECGGK5AcoLi2Bj6VJf4JFhEx/e5f4NHJH7hS
	 ZU7G1ypTAWvzA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bVZ6lhiKnRn6; Fri,  3 Nov 2023 16:57:07 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 36D2340191;
	Fri,  3 Nov 2023 16:57:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 36D2340191
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 7E5F01BF3FD
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Nov 2023 16:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C0094012B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Nov 2023 16:57:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C0094012B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gkoAO99As3V4 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Nov 2023 16:57:03 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB2E7400AB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Nov 2023 16:57:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB2E7400AB
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E5F59CE221D;
 Fri,  3 Nov 2023 16:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825A1C433C7;
 Fri,  3 Nov 2023 16:56:56 +0000 (UTC)
Date: Fri, 3 Nov 2023 16:56:54 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20231103165654.GC714036@kernel.org>
References: <20231024142010.175592-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231024142010.175592-1-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1699030618;
 bh=9r2Teb9LmUKE38493V8+tN4Nwput4XeDIrc8Gf3eW4c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G6mgJybqE9ukoRP1F84YJOboWy6zKjdoQ13Zwa7L9xQroBO/5O9WRjjdWLZFJ7Fdf
 vQAZ0SQRHDBf0DxXOZSeAaNYm6oApvVye545UYR3nfw9XOxV3eACSwxHbr61hSJtk+
 OuO8oxRWbUW8htMl2mqcrnqH3xHEbTLcpLUaTj9tUYCZOiadJkYeLZR7NkPi84qaC3
 AehMV8F0Wj3yfjXQ3xMK69KQPv2gfJgRaOmXaJOotgkg46jRfyUhLoMP2pjsV2hce8
 YMKl7hLVHIddvWK6JdkEP1NMiMOaJG81/FAau3aP0INwtJE4VMJRJihE6lJ3IlieCx
 aANRaMeyAljUA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=G6mgJybq
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: change
 vfs.num_msix_per to vf->num_msix
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
Cc: netdev@vger.kernel.org, yahui.cao@intel.com, marcin.szycik@linux.intel.com,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Oct 24, 2023 at 04:20:10PM +0200, Michal Swiatkowski wrote:
> vfs::num_msix_per should be only used as default value for
> vf->num_msix. For other use cases vf->num_msix should be used, as VF can
> have different MSI-X amount values.
> 
> Fix incorrect register index calculation. vfs::num_msix_per and
> pf->sriov_base_vector shouldn't be used after implementation of changing
> MSI-X amount on VFs. Instead vf->first_vector_idx should be used, as it
> is storing value for first irq index.
> 
> Fixes: fe1c5ca2fe76 ("ice: implement num_msix field per VF")
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
