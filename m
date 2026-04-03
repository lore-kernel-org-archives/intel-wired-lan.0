Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884E6E85367
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 13:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4260581D35;
	Fri,  3 Apr 2026 13:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gaKQuQbVG1Ur; Fri,  3 Apr 2026 13:36:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D31F8148B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775223397;
	bh=FAWTKl7eTjel3XvREjio+ebl/i6gz//Xb16K7dilKXs=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EKHJj24oXOogbG1+q9x8ig4IgELpHH96sFajl2Ib0zuIcmWsUP2b2ZB1LHYNqjEYo
	 B6sGlJjzqI8Kvh5RH5vOGnrGWuy5gbbZfA6cUYTRp9lI19m9x4uAdxunj3H5kOnXN3
	 H8VAxgdLwBtSgjA7C5faANBWdSqpSAM7z0kGIxE1lEiz5rsfuluck/pXix9sWNvzko
	 zPL84eswwoZWahC0o2mRSxiugNeu8lFOoieDXOKpUmh7/JeswG0uSCk4Th1LyeJ9dH
	 GFAV+m6/B7CKWH5Wz96I6wt6fx2BZT1QcBClIBj86BoQWX9X3UZmZ+q9+cvfk724Jk
	 pdFxwWiIvDTDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D31F8148B;
	Fri,  3 Apr 2026 13:36:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E04501A9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 13:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D7AF040094
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 13:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GSnTxJojAM1E for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 13:36:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 47D004003D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47D004003D
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47D004003D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 13:36:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C66B404C3;
 Fri,  3 Apr 2026 13:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7CBC4CEF7;
 Fri,  3 Apr 2026 13:36:33 +0000 (UTC)
Date: Fri, 3 Apr 2026 14:36:31 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>
Message-ID: <20260403133630.GD113102@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-2-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-2-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775223394;
 bh=ZwehJ0cfzWa1ZDciwDC6ku8OtW6tyhu80bL6r2pUeBU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XtP4DPq+DJ5BpMoipIhL3ue/oxwnt/P8be9NMrmbuMBtAEEYoBZ0WXrIvCM+uGT+7
 wTmuVpCKuEoiHMbdYcmUxYzqN+AAKcCxmIDxHl4BaarYzYcvWdlX1bWU0cC1sH0ycQ
 AO7vPHBTqILV5bZ6cVDn1F9yUk5+pFKoZwkQ4aYZBVjWTsrStyATIlJHGTKnhCxw9Q
 uZj0q+XYTKQ3gDISIG5CoCsMTZ/L9xf51SZFIEnfVd+TVFA0IBEpSVoNh14zF0+G1q
 RNL695RPDxSK/YImMYRFFe7Huo72y4F8n5I2RjS/Gw5v72t+fAq+Yi35rBeEvBEPmL
 XdUK18A/Yhf+w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=XtP4DPq+
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ixgbe: add bounds check for
 debugfs register access
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

On Fri, Mar 27, 2026 at 08:30:36AM +0100, Aleksandr Loktionov wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Prevent out-of-bounds MMIO accesses triggered through user-controlled
> register offsets.  IXGBE_HFDR (0x15FE8) is the highest valid MMIO
> register in the ixgbe register map; any offset beyond it would address
> unmapped memory.
> 
> Add a defense-in-depth check at two levels:
> 
> 1. ixgbe_read_reg() -- the noinline register read accessor.  A
>    WARN_ON_ONCE() guard here catches any future code path (including
>    ioctl extensions) that might inadvertently pass an out-of-range
>    offset without relying on higher layers to catch it first.
>    ixgbe_write_reg() is a static inline called from the TX/RX hot path;
>    adding WARN_ON_ONCE there would inline the check at every call site,
>    so only the read path gets this guard.
> 
> 2. ixgbe_dbg_reg_ops_write() -- the debugfs 'reg_ops' interface is the
>    only current path where a raw, user-supplied offset enters the driver.
>    Gating it before invoking the register accessors provides a clean,
>    user-visible failure (silent ignore with no kernel splat) for
>    deliberately malformed debugfs writes.
> 
> Add a reg <= IXGBE_HFDR guard to both the read and write paths in
> ixgbe_dbg_reg_ops_write(), and a WARN_ON_ONCE + early-return guard to
> ixgbe_read_reg().
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This feels like a bug fix to me, assuming users can
cause out of range access using the debugfs 'reg_ops' interface,

If so I think it should have a Fixes tag and go via iwl-net.

...
