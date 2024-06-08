Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79644C27C55
	for <intel-wired-lan@archiver.kernel.org>; Sat,  8 Jun 2024 12:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48AFC83147;
	Sat,  8 Jun 2024 12:58:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Os5Fez8h88gp; Sat,  8 Jun 2024 12:58:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B163282101
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717851505;
	bh=tFuW/oMr2bnG4kKKZ0kjqy2qpu1Jel23fsXSONqHWVI=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=wdmDQMN6sciIk97/6xd44x6GtPDtEaAJ5+UJJas0Z4SE1YSArUWYrKG1IKUQ0v87j
	 X1dEFrE0HfUyg1v0Lu2I45jKZoeG5fyvmce4t9h7A4ndBsNpsbfOk7aol1/6x4hQLJ
	 tBHJaqrte/A497X53qSmsmFtiyJD+unEqDD/LiZFcDpnqrMXUn6uLJF8jqsih7+aoV
	 85riLf8P6syloNp0xXeZMvyrekZKIFqd5RbRxP+zEKi2Nvj4X1LvaTWChdHX8yIEwl
	 TOiTQU508wAbSgaG23QA5DED150ysoU4p8vsWsOKcG7S+0kG+L+b6J54ixkxrW1+1C
	 KpudbEA6T532Q==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id B163282101;
	Sat,  8 Jun 2024 12:58:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id B033E1BF47E
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D31582160
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EcE-1TN4CbJY for <intel-wired-lan@lists.osuosl.org>;
 Sat,  8 Jun 2024 12:58:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 08DDC81FB7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08DDC81FB7
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08DDC81FB7
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:58:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3DC006126B;
 Sat,  8 Jun 2024 12:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDE2C2BD11;
 Sat,  8 Jun 2024 12:58:20 +0000 (UTC)
Date: Sat, 8 Jun 2024 13:58:18 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Message-ID: <20240608125818.GX27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-6-mateusz.polchlopek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-6-mateusz.polchlopek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717851501;
 bh=54Xh9Wz7EJxKcPESg+VRQVI6gfrctMlq/VGRmr0KWYQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EfUl0t4TaYPL7kh093aYRIJmjU4AF8RVUd6g+cG920ByTrGAevRwwrRT315fhrMJ6
 AVHIOSX+WBWG3il2b4R0Or4TEjJvyF+fYASDqqxqtbN94D8nxtTSGqacy1xj/6i1Vd
 7jR+5btkN6YB1tDIgudWJOqu2q/n2wU+Qq5eoTr+QkUKTUt8D65vdhK+pYcVoa4nuh
 G00xgLBmGyvbpgL2JBqWNAX8zvnA7PNNINQ6Jdn/k+0QRyETPLpK/yz8g3yMheICHu
 ZFRSc0/6dYqP1MZ66viGVc/xDTFozyA4GLKm0YotTeSdn9teLCzMN+kju3BE5hc8cl
 bT47bahqV7jZw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EfUl0t4T
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 05/12] iavf: negotiate PTP
 capabilities
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
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Wojciech Drewek <wojciech.drewek@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jun 04, 2024 at 09:13:53AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add a new extended capabilities negotiation to exchange information from
> the PF about what PTP capabilities are supported by this VF. This
> requires sending a VIRTCHNL_OP_1588_PTP_GET_CAPS message, and waiting
> for the response from the PF. Handle this early on during the VF
> initialization.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

