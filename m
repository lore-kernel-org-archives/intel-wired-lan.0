Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34286E95375
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Feb 2026 10:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F07EF60A89;
	Wed,  4 Feb 2026 10:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Gbin0_VE6yy; Wed,  4 Feb 2026 10:29:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B7DA60A6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770200989;
	bh=LSzzOC7CskprS16p2UJfaq2VcAqlVwkR2HemZkdOkY0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XWFMMELGooj3jnDOJtfwbXEaaKNorQntzc+zgfgCS7AfNIwuNUuT/1lPvHonnUDUZ
	 lf3A7AnhMgMio/yIy+h+p+XKFH1piJLAPJ3/Et68b4SN0/5IzLu/n31cBTUuxkhQSO
	 CmqWps0mFjS2VI0lnT2MiqFJXEaCH9/XmRqj02HIujJSbtAbaHhaGoPIDrYwwCs23A
	 G0dzTKQV3R3VUjn7K9WNKqjaTdduaK26D8yQtx1YjzpGVFaR4sk/5zq47JIfQdwbfO
	 jdjKARxQ+E0widvjpWsZ4aXLZNTNMMtC+7tyA5EpJZ1jKPYAga/ZdjJDZiXmGb3jd7
	 HwpwpomF1txoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B7DA60A6F;
	Wed,  4 Feb 2026 10:29:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BAD9F4
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 10:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CBDE80CEB
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 10:29:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oL6bw4iGcAnH for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Feb 2026 10:29:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AE3AE80C6D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE3AE80C6D
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE3AE80C6D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 10:29:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A77F16012B;
 Wed,  4 Feb 2026 10:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91DBC4CEF7;
 Wed,  4 Feb 2026 10:29:42 +0000 (UTC)
Date: Wed, 4 Feb 2026 10:29:40 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, kohei.enju@gmail.com
Message-ID: <aYMflIxseCDvgmdq@horms.kernel.org>
References: <20260131163037.88108-1-kohei@enjuk.jp>
 <20260131163037.88108-4-kohei@enjuk.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131163037.88108-4-kohei@enjuk.jp>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770200985;
 bh=YIUU21IB9wMtKDb5k3cUtJycso1XbTtnuYNTeLOpXFo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PUURnUy75lFJ47lfvr6v7SQEKYbogXwdwVBX1uYvo9wwxAKPjry4jY7BZ4Ftr3Bsl
 o5wrRfoxCcGXcGLhwN/yErAUskFE3Sl/Yg8+YDSLjQUr+FuB0PBASFq5bdNkfNpKJX
 jOA73CIpo8zd3beVs1wR/MzPrPnLaBIjfTjkfuDszlImxkbm314uo1+gNZj2M91kWn
 Gmn0q7axBlAROst6JIxfM51NoUMN4yo+0gVnH2bxfi8hguAEL83m9A1GLn2SSuW2Xu
 TNCtNQiujADfonQ2JDOif2BJzcYBhCSGWrEFcMHcxscX6eGEzdrAUU4Zf6/X7VpECH
 NdfWHDa+vtwfA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PUURnUy7
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 3/3] igc: allow
 configuring RSS key via ethtool set_rxfh
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

On Sat, Jan 31, 2026 at 04:29:38PM +0000, Kohei Enju wrote:
> Change igc_ethtool_set_rxfh() to accept and save a userspace-provided
> RSS key. When a key is provided, store it in the adapter and write the
> RSSRK registers accordingly.
> 
> This can be tested using `ethtool -X <dev> hkey <key>`.
> 
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Reviewed-by: Simon Horman <horms@kernel.org>

