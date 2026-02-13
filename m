Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BE7EDF170
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Feb 2026 15:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9353841D2C;
	Fri, 13 Feb 2026 15:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eR7nOdx1R0Mr; Fri, 13 Feb 2026 15:14:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE06741C94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770995642;
	bh=aFFEPcTusdmKMcB1BD0CaAYJ7BU1C0I7jO7XrI4yo8c=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ecOH8i5IJZWc1V6qaCxIAtv9G5c1+fQCNrM0/gOMFHoAf0uqqfl54gWNGvdlwrOy0
	 C1TpoK2N/Wp/JuANlwBEPAFwEhq6L1p6srogF9mzvymQrdn5l8zXlUbkjd5QcDz3Z+
	 xvWq5W8DI9YhRj1lUu5ZOIt7vsNcn/bksijj/wI85DqZK4AFgYaF51sbk78TnbzH9d
	 fy6ypF6Z3g9LkmPYWn7vkOfUuGUSLXLsE37gIBZzy3w/DoKliurvppm5a1yOMmFSRp
	 dqUDtfYrh9unAx9ipkh9IV3p7DL1BQFbIn9txUGUhpNey20c3mUPD3WeSlQ4nkrmg6
	 8/HO5tXDt4aGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE06741C94;
	Fri, 13 Feb 2026 15:14:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BDE0EC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 15:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E3B1607BB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 15:14:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7GaHyyDrcN3A for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Feb 2026 15:14:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 785D46074E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 785D46074E
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 785D46074E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 15:14:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E8B16001A;
 Fri, 13 Feb 2026 15:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F38EC116C6;
 Fri, 13 Feb 2026 15:13:57 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 jedrzej.jagielski@intel.com, anthony.l.nguyen@intel.com,
 pmenzel@molgen.mpg.de, netdev@vger.kernel.org
Date: Fri, 13 Feb 2026 15:13:44 +0000
Message-ID: <20260213151344.2513857-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213030940.1809797-1-aleksandr.loktionov@intel.com>
References: <20260213030940.1809797-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770995639;
 bh=3bq173aJ5nk+kZXQK+mYY1RtdGNP6XtLgOFXb3IkeiY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s4jSZ0ILRX0h9SzisEh1YWZmn6dTUbhxn2kagXrzEJlHs7/l1XLroPzUajfE8Dw3F
 eoPNIOVD6pf0UdhzOtAc/4bZSRGsBPw3laI2Xj9galB9mpQpShnOBCboLhGcLLzoNM
 VUC9HFi5hPF1HcJp1sv9jjrL8njpJneBPn1o7PY+foR4dflBfIbmnu9NG1s455Gcy6
 M5XKP1Kio32x62BeloRXu8oMABUeGeKmctAPBIA2u6VvqMUaXM9AC2QRYtC2pAO/hi
 8o7C94D0KdLTSgNWFsvd9HJVK0Li5htJpdyJXTFVOtse1+LsI/Qe9sfm3/K95JT+s0
 VknEvxTBTlATw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=s4jSZ0IL
Subject: Re: [Intel-wired-lan] [iwl-next,
 v3] ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()

This commit adds a u32 member to union ixgbe_hic_hdr2 to ensure 4-byte
alignment on the stack, preventing unaligned 32-bit accesses when
ixgbe_host_interface_command() treats the buffer as a u32 array.

> ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
>
> ixgbe_host_interface_command() treats its buffer as a u32 array. The
> local buffer we pass in was a union of byte-sized fields, which gives
> it 1-byte alignment on the stack. On strict-align architectures this
> can cause unaligned 32-bit accesses.
>
> Add a u32 member to union ixgbe_hic_hdr2 so the object is 4-byte
> aligned, and pass the u32 member when calling
> ixgbe_host_interface_command().
>
> No functional change on x86; prevents unaligned accesses on
> architectures that enforce natural alignment.
>
> Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")

Does this Fixes tag point to the correct commit? The alignment issue
appears to have been introduced by commit 6a14ee0cfb19 ("ixgbe: Add X550
support function pointers") from 2014-12-05, which introduced both the
union ixgbe_hic_hdr2 without a u32 member for proper alignment and the
ixgbe_update_flash_X550() function that passes this buffer to
ixgbe_host_interface_command().

Commit 49425dfc7451 from 2016-04-01 only added support for the x550em_a
MAC type and did not introduce the alignment bug.

Should the Fixes tag be:
Fixes: 6a14ee0cfb19 ("ixgbe: Add X550 support function pointers")

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> index 61f2ef67defd..eb5bf3b6bbb5 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> @@ -2798,6 +2798,7 @@ struct ixgbe_hic_hdr2_rsp {
>  };
>
>  union ixgbe_hic_hdr2 {
> +	u32 buf[1];
>  	struct ixgbe_hic_hdr2_req req;
>  	struct ixgbe_hic_hdr2_rsp rsp;
>  };

[ ... ]
