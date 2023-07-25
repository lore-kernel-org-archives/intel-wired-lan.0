Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE65C04A6A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Jul 2023 18:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8AF3610E4;
	Tue, 25 Jul 2023 18:37:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8AF3610E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690310222;
	bh=bO0BZI21BDiGT22NmhFJCn/CY8B2YKYNz1R7llio0lQ=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=NOam4HMlu9AuqhsoilHibapDR/NCpJvsr8Vk9Q11MscDK9jruvBH1cZwLebx+a1OM
	 q40TTQmlueqJjFv2Uc7AxjNUb0CPxcRj4D9vjSociONS0mYj4DzlIJcGdwVuQ8zuZA
	 y1Xx8wQAAc4/Aax8xfQDYG/GhuqHLtAeuVx9E8h1aPo1QCFsA1EwI7piSc/AbZyVwN
	 54Vs/7TIkyWwmIfDXB6/+38IQMF0ION8UR/OfCsxmPNiUlwtry8MdgBVKSkG0jRvCJ
	 aJ68qrkL1sZ8vbTLwUzr0MRURrdtWB+BqKCRe2hrESgm67SCmqwu/1PGh+TsNoC6Vk
	 09BS0IhDOBU6g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 20z2ySpcv__L; Tue, 25 Jul 2023 18:37:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE7FA610F2;
	Tue, 25 Jul 2023 18:37:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE7FA610F2
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 6C6C01BF376
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Jul 2023 18:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D5DA41582
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Jul 2023 18:36:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D5DA41582
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YOdvIRZ_FDQo for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Jul 2023 18:36:58 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9027F41578
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Jul 2023 18:36:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9027F41578
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 74FC461873;
 Tue, 25 Jul 2023 18:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3088BC433C9;
 Tue, 25 Jul 2023 18:36:55 +0000 (UTC)
Date: Tue, 25 Jul 2023 21:36:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230725183652.GR11388@unreal>
References: <20230723075042.3709043-1-linma@zju.edu.cn>
 <20230724174435.GA11388@unreal>
 <20230724142155.13c83625@kernel.org>
 <20230725054046.GK11388@unreal>
 <20230725095327.385616f1@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230725095327.385616f1@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1690310216;
 bh=bjmPK5i8hRDzGjUnFu1I3rEttWK5DLd8NhrusoG1LHM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SdcIkVwfwM8nNchwnyAIYUyNEQfIrLNu4VzEIYuK/6yR399E7HquUzR/dEqLDwynl
 cs+FB8L8PqQoFeknYUPYeowW+xWD6OekN6l/qDJixjEoe/qvUSv000ZEbMnilgzoFK
 iWFmJyTNaRFJ9FXuDqJfTWqKLFHGv72a3Hf8BSbDFjglnjwciYyPG5YtvrCxnfokXZ
 f7VYTKBs5OGzYR725ZwuO+mGVGSSvWMD8y5bmlBdzNoKOPRJvrrWkOT7WUzs3fh+fk
 uvEePo1Adzoa0h0Eqnn0xXtyVmeLUJdR3LA+GNYvxiM94trezxoCn99BSE8nB7PLMY
 2jvafCCIQiVjA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=SdcIkVwf
Subject: Re: [Intel-wired-lan] [PATCH v1] i40e: Add length check for
 IFLA_AF_SPEC parsing
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
Cc: ast@kernel.org, hawk@kernel.org, daniel@iogearbox.net,
 netdev@vger.kernel.org, richardcochran@gmail.com, john.fastabend@gmail.com,
 jesse.brandeburg@intel.com, Lin Ma <linma@zju.edu.cn>, edumazet@google.com,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 pabeni@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jul 25, 2023 at 09:53:27AM -0700, Jakub Kicinski wrote:
> On Tue, 25 Jul 2023 08:40:46 +0300 Leon Romanovsky wrote:
> > > Empty attributes are valid, we can't do that.  
> > 
> > Maybe Lin can add special version of nla_for_each_nested() which will
> > skip these empty NLAs, for code which don't allow empty attributes.
> 
> It's way too arbitrary. Empty attrs are 100% legit, they are called
> NLA_FLAG in policy parlance. They are basically a boolean.

I afraid that these nla_length() checks will be copied all other the
kernel without any understanding and netlink API doesn't really provide
any hint when length checks are needed and when they don't.

Thank
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
