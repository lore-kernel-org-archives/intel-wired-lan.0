Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E58C5DF81
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Aug 2026 19:11:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAD0440912;
	Tue, 18 Aug 2026 19:11:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JimjVRVbikGW; Tue, 18 Aug 2026 19:11:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787080279;
	bh=CmDb2knTC5ep3vyIeWqUF5fC8E/mg7myErS7a6E/tro=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HIa4VgYCnaWSlSbBZkOif0gkvNfAyqSajjvVFlQ9llj3C2oyVtYqF0N90/72813U1
	 /VnlpzOz3BfIn/V1rRror9C3qbfhsF4NCHTaXq45eOdZNWuluwf6YjSFeHSsL9hjvZ
	 uactX5dI6dg8eC8l2LYTPTSWXBNCDEXRg5kaMsAPHbygCtXSGHFCmRK5ohuN6VGJxX
	 b22qkL7y7Gc2U/vpFi4JXTJT7EkOcMZHgzpo6tJ6QmaWLUeh00qqVsJoxpRyulJSog
	 pSVhIgXzbuBBHcalY0HI0xtUrXNjQUP3LWWpcX1JkHaiSZieR9zJl84y79YsaikLta
	 +6tsXwLpDkDow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10FD940919;
	Tue, 18 Aug 2026 19:11:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CDD62FD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 19:11:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AB24606B3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 19:11:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nZUDuOeUvDJz for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Aug 2026 19:11:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bEYSULiH
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69F3C60681
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 19:11:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87EC0432C6;
 Tue, 18 Aug 2026 19:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2D71F000E9;
 Tue, 18 Aug 2026 19:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787080276;
 bh=CmDb2knTC5ep3vyIeWqUF5fC8E/mg7myErS7a6E/tro=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bEYSULiHf53V5M8lq8g7q/X7gZF0Rh2tfPI0cMdJaehcgnl0VyPFKdp6XTVsB60/+
 UVcLxGcgduQEfoUvr4GivaGnKi9zyOm7YrrBbEbmHH7WXiJsB7v7l46sFnvUkgCQvn
 WchgPw1Oa2lcsmUh+dfloMDV5+3ZQZMzuxMVzQm1Lf65L9liNZ1eKLSbpRYbJVx3og
 LlvxCyB6qGz5+7p9xLhEQFeLADaFHsytYZ9XmZ6o9Hew5QPUJrpFNoFA+tzp+kdd9C
 HdPpfP0aOlux2fS1Ftrt/946ENJnwr3ShKCcs3UsfEcV+W7c4SCZG5rOXBzgQYsRCx
 4jybb0ElmZ3DA==
Date: Tue, 18 Aug 2026 20:11:10 +0100
From: Simon Horman <horms@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: anthony.l.nguyen@intel.com, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
 Michal Michalik <michal.michalik@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <20260818191110.GK265046@horms.kernel.org>
References: <20260815135700.54202-1-pengpeng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815135700.54202-1-pengpeng@iscas.ac.cn>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] ice: propagate ETH56G
 deskew poll failures
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

On Sat, Aug 15, 2026 at 09:57:00PM +0800, Pengpeng Hou wrote:
> ice_ptp_calc_deskew_eth56g() ignores the return value of
> read_poll_timeout(). If register reads succeed but the DESKEW valid bit
> never appears, the timeout is treated as success. If a register read fails,
> the poll condition can also inspect deskew_i before a successful read and
> continue polling instead of stopping on the hard error. The function then
> returns an int error through its u32 deskew return type.
> 
> Return the deskew value through an output parameter. Stop polling when
> either the read fails or the valid bit appears, then propagate the register
> error or the poll timeout separately before calculating and applying the
> deskew value.
> 
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
> 
> Assisted-by: Codex:gpt-5
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v2: https://lore.kernel.org/all/20260706144325.91320-1-pengpeng@iscas.ac.cn/
> - capture and propagate the read_poll_timeout() result
> - stop the poll immediately on a register read error
> - initialize deskew_i before it is used by the poll condition
> - do not carry the v2 Reviewed-by because the poll logic changed

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

