Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4C606A31C
	for <intel-wired-lan@archiver.kernel.org>; Sun,  8 Nov 2026 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=i/z8ZVH6;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XITnjmgL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D0D880D1E;
	Sun,  8 Nov 2026 14:52:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yj7aC7AqiVDi; Sun,  8 Nov 2026 14:52:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B5AEE80D30
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794149556;
	b=iW1QBlnW+L9Gifj+ihdoWCEnzs3FCNBHzwqWM0wbE2tE3qaPCwfkbwTP82IFfMlxj3r2
	 Za6OZo/wTQMdcrlt693ozfzcZ++E0g7VCCxl5R3jCHyCazVJY96qilk/BozU/7UtO/iLZ
	 kDwO7aDTvDuMOdO0bgLLRx5js7di8uHK/dt+szMVcEXxwZa9cMp7Eoes/j7d6ckg8ebb2
	 CfMmcKXyVXywUpUsBXe1E6s4xTf7slriKik0jDXMrGWWtkh95jsMB9VyGwZheu9rttzjX
	 b44pcLN5ncxIgMh2X1ahSSFh5p25OLbB/E402kB9bmNx7nzdZlT3by3Hns84sSEuHXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794149556;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=c4qUhS6iO9qdFWWn+fVlySOPe5Btth3gk1PByj9XlFw=;
	b=C/pBKWefXlgSrOvfNyux96EtarD9re29agA1+mTorD5nH/62Cy7idmiQTfr4Uwv8msB+
	 OLTe5ihxeuMM5fAIYJAvOT7J7Qmq+PIs7CXLWJjlH+osQHv0aFVozFHB8gsjpRL/MFp/c
	 i6+GVB0ZVD9glIzBNzZhJrm7TlH4utBwJ7+9Jd/o3gztZgvNCOcM/WPVnanHPkdVUf3co
	 wfbjJnUUm7R5/2zNqFt4M+yYN60Ody62s0gF0jPjOtwbYNNtUiaEl8aYQVoooUr3SW3tG
	 oN/ze16/qy/bCmPORnPWedETSN15b/dA6XMGWAk7BFNNnTf7C2ngy5zkHrdiyHVbnBQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794149556;
	bh=c4qUhS6iO9qdFWWn+fVlySOPe5Btth3gk1PByj9XlFw=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=i/z8ZVH6HY1mgsEbpGpSOF6esjd/UoTQ06pXYdW/snSFieyQ6ZfQy4N/lZF1dRTm8
	 dvV3VK2d5dfJVO6sxIuzGNwAmf1yjY7gKukqxPUeMf0e0eS8vKW+dO/XcwrgEIDyRp
	 qnY8tkLZ4YhvODwv4aaQgU5BfTDyBwK5heRRrC8m4mpftA8ksAO1V0Vpo5qG7f15Yi
	 ykD2uVJYJb+9bNByQi4oHK066Q493Tb2SLFuYH498WMAp1VhH0iFHybfeN47q0F65D
	 ExTFXXQ3MUY12pu6MrO0cet2AEor73Q5BhmR4cQWJphLUQDymvtXysyEyssHrr34zR
	 S2eZsjL9gUXew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5AEE80D30;
	Sun,  8 Nov 2026 14:52:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C67F62AC
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 14:52:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B7B29405ED
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 14:52:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jWAWjd8s-n2D for <intel-wired-lan@lists.osuosl.org>;
 Sun,  8 Nov 2026 14:52:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B9EF340574
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XITnjmgL
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9EF340574
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 14:52:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7E5F4091E;
 Sun,  8 Nov 2026 14:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC761F0089F;
 Sun,  8 Nov 2026 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794149553;
 bh=c4qUhS6iO9qdFWWn+fVlySOPe5Btth3gk1PByj9XlFw=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=XITnjmgLR9inWIdj/dez4Rh/fi48Nu1yS5N/oAmoVLpVaUNmqy0/nkncvkLgTZGIf
 Zu77OcnCtnovQBwSIqC4oTTMkNQwwFkNtFtRBa0LqhufTEFX3u9d2dZ5TmqtEz0uw+
 KsuZ9BXeXGoYRzfFtZBL4vreYBpJayeq+Pg+Mg+IHS9K1TIXx0kmwal0oLwozweckF
 XRpNytmQPzBnqSXoHurFHITjlO1dQUIiW72rMefhjQDjJBYkwV6K6hjNvZWjk8qshq
 bWDbLJaRQ6VPKI2slsUI5WG6kEIbR6toZ5na7ozAEPNtJaNJ4zd3V8PF4FBODztGt9
 PTihikNlVA24A==
Message-ID: <sashiko-outbox-203816@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v1 1/2] igc: remove unused extended wakeup
 filter definitions
To: "Sasha Neftin" <sashaneftin@gmail.com>, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261108144503.97783-1-sashaneftin@gmail.com>
References: <20261108144503.97783-1-sashaneftin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 14:52:33 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] igc: commit message omits removal of IGC_WUFC_FLX1 through
  IGC_WUFC_FLX7
--

commit da9a0d24a19cd51d91534d22701d18bfafb24621
Author: Sasha Neftin <sashaneftin@gmail.com>

igc: remove unused extended wakeup filter definitions

This commit removes unused flexible wakeup filter bitmask definitions from
igc_defines.h.

> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/e=
thernet/intel/igc/igc_defines.h
> index ab55b88d4d96a..369aaccbd24e8 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -26,13 +26,6 @@
>  #define IGC_WUFC_BC		0x00000010 /* Broadcast Wakeup Enable */
>  #define IGC_WUFC_FLEX_HQ	BIT(14)	   /* Flex Filters Host Queuing */
>  #define IGC_WUFC_FLX0		BIT(16)	   /* Flexible Filter 0 Enable */
> -#define IGC_WUFC_FLX1		BIT(17)	   /* Flexible Filter 1 Enable */
> -#define IGC_WUFC_FLX2		BIT(18)	   /* Flexible Filter 2 Enable */
> -#define IGC_WUFC_FLX3		BIT(19)	   /* Flexible Filter 3 Enable */
> -#define IGC_WUFC_FLX4		BIT(20)	   /* Flexible Filter 4 Enable */
> -#define IGC_WUFC_FLX5		BIT(21)	   /* Flexible Filter 5 Enable */
> -#define IGC_WUFC_FLX6		BIT(22)	   /* Flexible Filter 6 Enable */
> -#define IGC_WUFC_FLX7		BIT(23)	   /* Flexible Filter 7 Enable */

[Severity: Low]
Should the commit title and message also mention removing IGC_WUFC_FLX1
through IGC_WUFC_FLX7, since they currently only describe removing the
extended IGC_WUFC_EXT_FLX9 through IGC_WUFC_EXT_FLX31 definitions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108144503.9778=
3-1-sashaneftin@gmail.com?part=3D1
