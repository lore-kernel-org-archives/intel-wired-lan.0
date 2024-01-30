Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47E9C46CD2
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jan 2024 13:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FF048176A;
	Tue, 30 Jan 2024 13:12:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FF048176A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706620362;
	bh=H/RTD1RwoRpdXnixtMCfeH2Plmj1QSMcfkNvWENkY8o=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=R/GK/9IS9q7DicfPnnTMVyppSXE2tPXhhXD8+Xut91u/0vXmg3DFAnf5hbQ9H3tRZ
	 ewoqp5rTwI6tKN9sPMpLqUM0LbpWTHGcx3C4OgwuvnGLeASH7lGroYaAyaoOdZ93Av
	 AJ8tP7j8MgcL1Jk36xlWv3svvCJSn0qRKO9c2Sfdp4YGIIDKCV/EgveCLLa1b0kkoK
	 iz3Q9k/L8yk9nRxdTBduJnptnY8pod4A6I9o6RudsW50JqKP3NUx7EwPdAi+su7AMM
	 FxHLrbn1GmzKCFl9mArXgbxEyHJ0MrjiGjyWpfQPbSArFCWX5S1OIQJec4iiVlOFaj
	 M39lGale1U7Bg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 51WunzA4VL1k; Tue, 30 Jan 2024 13:12:42 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6C2482325;
	Tue, 30 Jan 2024 13:12:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6C2482325
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 3E5C41BF2A5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jan 2024 13:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 173E960BB0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jan 2024 13:12:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 173E960BB0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T2cSzpExM7-N for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jan 2024 13:12:38 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AD1B60586
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jan 2024 13:12:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AD1B60586
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2086360B47;
 Tue, 30 Jan 2024 13:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CF9C433F1;
 Tue, 30 Jan 2024 13:12:32 +0000 (UTC)
Date: Tue, 30 Jan 2024 13:12:25 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Message-ID: <20240130131225.GI351311@kernel.org>
References: <20240126130503.14197-1-jedrzej.jagielski@intel.com>
 <20240126130503.14197-2-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126130503.14197-2-jedrzej.jagielski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1706620356;
 bh=zJEMnhEsbSau/vuSXwKgJowpq9X91ZF4cDUW9NsJboo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UAOV9sw6SVot2WvXcnG1bTk52CPGXM1bXJ1f2iLd3FawJO3fcxwJUvg4xmBMoQp5O
 UuszCIhnoHiScmobd1pXKDc/f9WkqAQK4TG2tekeaH1J4s0SU19aj5HyBieUFPKXFk
 3mBHJkttqMAGvOcQvO3PJ1ODVlFZVlV4tCKhXvIb9G9Rl+tgP7mnWybTwVWzLdsYsS
 JrfGIqr+txvXb6fVcTHR3EX+Wq6AQEXsmEJ3/1YcBHWuF3B1NFr3mFD5aSZqlEa8M4
 wozyBrjOGmREbtq/KAADJT4fBsEPfi1GHq+6hAjSBiuHyKjgbVNk9/HOs5i1saQMEU
 uTcXzJ66gflCw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=UAOV9sw6
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 2/3] ixgbe: Rearrange args
 to fix reverse Christmas tree
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
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Jan 26, 2024 at 02:05:02PM +0100, Jedrzej Jagielski wrote:
> Clean up the code touched during type conversion by the previous patch
> of the series.
> 
> Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

