Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749EFC79FA0
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 09:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2353B4052E;
	Tue,  8 Sep 2026 09:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eq5Tt6TMnkhy; Tue,  8 Sep 2026 09:26:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 490E44052A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788859568;
	b=MIYbc0U2MV1FOEUYMXabEnOC6fuwU7Z0ErjqkDfXp5kdXPhp3MMV/aoGTpkrJ35g3i9W
	 /vbIcLqnGoEz5BKsysXXZpgGj5dNe6cntBQGiIXoHpQU17o9djpTcCB4m4UyObbK8T/on
	 xv+kmLDNPHXiQD4o6b9igg5pSmP9xpP4DNoVtiF4AW+MDZiVi7SlqIvjL5gpV6XhPoH33
	 wJrePi+jUFLMzTDXVkQfTI/VzhXCRbpTfvBO/Zl4qNh9RbQtgJnpFFLZUVEbxlVdIq0z+
	 0ptTurnxgBZYi5B8AzZMJKQuBdEIotKbvqNo+tmIi0AojH2C2V7L08tV3HfW5O/kIgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788859568;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o69IttcuA7tEu2aNd7IWY/GFsPeUHYiH4+43qLbSxr4=;
	b=ePMDB1z/tBsvAalJkygENMF4tCkHyFfI/0vmHlSm7BB/HY+2nJoEOM1qQIm6j9FOduLT
	 salwRnyfYUuCIpmD0KZRgk+RuZe4NNeY1DdvekVcRicNWlV5k9ZHlQARJoGN2SHOZZbBx
	 YdDI9tlM6bPxdriK0SsItOJEcssYsn3ZQsiHHHW36i0mIZmshYjvjsXAgZOqZtK2QxIIT
	 feV/L9AlQhge8LXqeTSi2kaqt2NicjWfOkMY8W4Q8AMNqI+loaQqZEfWNWR0phLegVt6/
	 acWocwF4QTvVsqAgrP3NfWP65nYQLe4D0TngwyOj+FdiJvKOpbryyCz6xFCJE278nsg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JcJWZiWy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788859568;
	bh=o69IttcuA7tEu2aNd7IWY/GFsPeUHYiH4+43qLbSxr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EOnQSniclh/BSPVGvyW2koSBtWhfV+rsP8XcqKgB20sSGM/JCh2Rh/RRTLKx5zeeM
	 r+3bD1hx+BpXw12DukXhQ0rUG78P+IMDXc8sx8Rosqe9nfZjGuuJd5o+++YobTivyl
	 5jHmgdPTum12CGKdUmCv5mKjHYM+7H63hXH67IXGl+atmYpihOwNgVPqAO7mWPqOG2
	 DGKvchRCb4tDxgTSupAU82r3DN5yhfAdrY6iBVQt/wzCBIJC1MtQ+kYCAYSdA6X0L/
	 MOfaySw6dcSeU30wU+g5xbtvCWQIJ8oWkOx5iBFawRHiDztuJOg6l9+1+pC/7WKi8V
	 ld+alyg8xIrgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 490E44052A;
	Tue,  8 Sep 2026 09:26:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E86F472C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 09:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C58924052A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 09:26:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LReh7GxRIAwk for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 09:26:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1FF4E40527
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788859566;
 b=khx7dlawMmgJ5IgTSRmgIfgGq613h6KPOgJdsz82HN6oZ/oNXqcpfSrhFp5TX2XJy1hg
 WZb216YNcAmHYPMwih9rvCKTR4rOUptHh5RorVZZzIY3U7zAJviiFOwFvGCexQpwX2zAN
 yJ4T9dX+sNuZZjzT/jxC2hHFaqGrwewoDf2zfRhCFlIZ2G3JTEAIkzBMAHMUeoQ+NGCyY
 QryqTJV0vHHn08oekk+GfpxUppvXoz4DKknf7r61qIGs2E7Q/nPv4t3lKis2uKSm3vkRR
 1q049j0szYHAWTqiSfFmIXIRgEhkR/LlQvrgUrETraFcPwYSfRtrBcBP08nrDgq3cBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788859566;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=o69IttcuA7tEu2aNd7IWY/GFsPeUHYiH4+43qLbSxr4=;
 b=rEr0P/j1DWtabsbXRVpJd7lfhWn88TRh0atpoNzpN7vjiOI4ThREBxKUXiDnBkjoyOlN
 nvMe/iUaW8vuDV6V6fGAqLeNLbovLhacMCBsb+SvW6jqLWuSlxY+d2Jphb9/Z7JpTNbOC
 EywNEMAvwGNW5lhW8QBE4UdbBy2Krkn2CbuV7CEQN1R8buJcWaRMqWMdu7uqoz68uZYKj
 67UbILUZtAAxb07Mc/Fy39z8MDogWrdjgZNttFy2Pged/foN1hQfNLl1BTBm0bOwFCmWo
 CxTjZoa2lDCNc08zMIxqEcjJAx+GsgXDD2nSWCF0f1gnijOjKf0akUIefMD+laDYwNg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JcJWZiWy; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JcJWZiWy
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1FF4E40527
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 09:26:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2755860A93;
 Tue,  8 Sep 2026 09:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D131F00A3A;
 Tue,  8 Sep 2026 09:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788859562;
 bh=o69IttcuA7tEu2aNd7IWY/GFsPeUHYiH4+43qLbSxr4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JcJWZiWyuNXSBXu33ocUnSilnVKHTJPyZfPQ/D5JSsXezRh4OfA9gIgz2xZJH/jhV
 hcB7WL/AdHcKT5W68v3mBSZ1D8rAxtxcnyvDBmiTr+FRAo0OlzvlDCEsp5v2ieZOKi
 o2lXHejcSnhPxNXlQxtMT2UWymiWyksbYs1C0YzR7SVuFnTg0FqRAmDsHdoaHnnUIX
 JU321VdkHKCKYv5RBZzGkE0CNs8l+H1T13Pi0a+orsdN7aPj04CBMmhcYUil8LSHAs
 g/90mUJPsX+Cl81g9gA+wC3tXd1Rx757idGPB5cLkutCMStyOVT6za88mNYJrjc1Xf
 8P0FbPxOVTq/w==
Date: Tue, 8 Sep 2026 10:25:59 +0100
From: Simon Horman <horms@kernel.org>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net] idpf: fix NULL pointer dereference and memory
 leak in interrupt request
Message-ID: <20260908092559.GP40544@horms.kernel.org>
References: <20260904091827.911123-1-zhangyunfei1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904091827.911123-1-zhangyunfei1@kylinos.cn>
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

On Fri, Sep 04, 2026 at 05:18:27PM +0800, Zhang Yunfei wrote:
> The kasprintf() call in idpf_vport_intr_req_irq() can return NULL on
> memory pressure, but the result is passed directly to request_irq()
> without a NULL check. The IRQ core then stores this pointer as
> action->name and dereferences it later from /proc/interrupts and
> procfs, leading to a NULL pointer dereference.
> 
> Add a NULL check after kasprintf() and bail out with -ENOMEM.
> 
> Additionally, when request_irq() fails, request_threaded_irq() frees
> the irqaction itself without taking ownership of the name string, so
> the caller-allocated name is leaked. Free it on the error path only.
> On the success path the name is owned by the irq action and released
> later via kfree(free_irq(...)) in the cleanup loop, so it must not be
> freed here.
> 
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> Cc: stable@vger.kernel.org # 6.7
> Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>

Reviewed-by: Simon Horman <horms@kernel.org>
