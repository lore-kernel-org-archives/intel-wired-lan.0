Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F93C02183
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Jan 2025 21:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25DE97049B;
	Fri, 17 Jan 2025 21:22:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7r5Nx8D9AqUT; Fri, 17 Jan 2025 21:22:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C1FD70499
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1737148933;
	bh=/2ljQ+ToC/Mrn+hGDWBUtW5XHRW1AEb66dvHNcMn+xM=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=cI4K8CEsIj4ey8dioGz3e1XliWDg8Mpm1AKtpxgvp5G7tmMqD/aPAk8IXMAssOb1S
	 jUHshhGadIUkzxwoFbxY/6jzRnWq6QfT+gqDdOiTcZsIAVxAUJirvCzsqtlyWr/wt9
	 QWq65780AIQRNnqsYLlg3tGNatnuii6FOQPFxHDBW+ouz866JnHZpKhS0oe05rhqc5
	 jDDh3ck4jsuZMJ4zqYcrPrAzb/+rDxUvZqULJW7GdtqtlAyi8+YUdxa0tR7Kb9Hmgi
	 SeVVS2KYZRxtECENfbV2ICjEreJ4H1sFi5PJT2Wxjfh5KKrXG73xWKtJQf8Y4kUGbg
	 JBMdthS9VvxbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C1FD70499;
	Fri, 17 Jan 2025 21:22:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 08C0969
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jan 2025 21:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5A7E415AF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jan 2025 21:22:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rHUZakRIOfNn for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Jan 2025 21:22:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91;
 helo=nyc.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 208E24246C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 208E24246C
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 208E24246C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jan 2025 21:22:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B19DAA43443;
 Fri, 17 Jan 2025 21:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E5DC4CEDD;
 Fri, 17 Jan 2025 21:22:08 +0000 (UTC)
Date: Fri, 17 Jan 2025 13:22:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Message-ID: <20250117132208.1f87a2dc@kernel.org>
In-Reply-To: <20250117151900.525509-1-maciej.fijalkowski@intel.com>
References: <20250117151900.525509-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1737148929;
 bh=/2ljQ+ToC/Mrn+hGDWBUtW5XHRW1AEb66dvHNcMn+xM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tr3l9tOS3s2mvzS//wIP0Ls4aiih6Av+C7PouZnPdEcqVTmg2raxbf2c0e6EfH5QE
 dOJFORRk4FCt/U8apwR4lbhwc/VFBi8RFqgCvbu7ZlUPlFITLEV9kzyxWtw2TjQBsu
 4kzzhBwlkyiqjbD3GB9gTqGp0mDbKWmlwQ/hOrlEHspXwsKHxvFKDReG02rhZjPvlV
 k1t2qwX6Y+vrY1PJlVoTsh3Rg/Z+GIRO6V/r32WV1XSepMVZ/BfdGfQBWLHlp23Tx1
 i89RWI/DdpFVT+XaFMGhB5belCXfx45zn64M08Fws+WGR9zCVIWtav15hhMBbaEtaU
 gtstHBxA/VtcA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tr3l9tOS
Subject: Re: [Intel-wired-lan] [PATCH v2 intel-net 0/3] ice: fix Rx data
 path for heavy 9k MTU traffic
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
Cc: netdev@vger.kernel.org, xudu@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
 intel-wired-lan@lists.osuosl.org, jmaxwell@redhat.com,
 magnus.karlsson@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, 17 Jan 2025 16:18:57 +0100 Maciej Fijalkowski wrote:
> Subject: [PATCH v2 intel-net 0/3] ice: fix Rx data path for heavy 9k MTU traffic

nit: could you use iwl-net and iwl-next as the tree names?
That's what we match on in NIPA to categorize Intel patches.
