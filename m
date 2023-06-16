Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48424EB64D7
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Jun 2023 15:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA5CD40121;
	Fri, 16 Jun 2023 15:29:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA5CD40121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686929377;
	bh=MmCu+ecvO7BPh4g8FL10pBUAa0vtT/jltkI/A+l1BiU=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=TQm6g5vMBi69MNeXfLNlFqSLViG/jSV7dl69kG+3D1fCErmRCsqRPfPU3pUdR9LZc
	 PJXPtiVyr82BWas41Rg3eAl0pGPpFxvFQ889wtGN9SIqyLvrCMtVmcnpLMGHzw2dP7
	 IyTXPXN8qMftHvHxQvxotwKHWGd/3/Hpyvg/Lg+QArQtoKpEgdhzeIrmRiQF7zsvib
	 gL73kT0/RWch4JDmWNcSDrAtiCNwbjYnrDfDsxUTr2u811v6iFegg2jQj1b5V+qtsQ
	 G7CV/7rpst3EodfaFmuQOoxJcFUKSUhwexyYQmP2ryFs2tXyFctWqwFkudFrPhh4M2
	 NFtjPNLnaXNIA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QkQdtO16EVXY; Fri, 16 Jun 2023 15:29:37 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id E89B140129;
	Fri, 16 Jun 2023 15:29:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E89B140129
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 9E0091BF2C7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Jun 2023 15:29:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7914A611A5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Jun 2023 15:29:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7914A611A5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KVcD7LVGyo9u for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Jun 2023 15:29:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83F5E61162
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 83F5E61162
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Jun 2023 15:29:34 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5A82F637EE;
 Fri, 16 Jun 2023 15:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F062C433C8;
 Fri, 16 Jun 2023 15:29:32 +0000 (UTC)
Date: Fri, 16 Jun 2023 08:29:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
Message-ID: <20230616082931.4d265f51@kernel.org>
In-Reply-To: <DM4PR11MB6117E6A199A2CEF4694A6E0C8258A@DM4PR11MB6117.namprd11.prod.outlook.com>
References: <20230614145302.902301-1-piotrx.gardocki@intel.com>
 <168689522302.30897.3895006000334449942.git-patchwork-notify@kernel.org>
 <DM4PR11MB6117E6A199A2CEF4694A6E0C8258A@DM4PR11MB6117.namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1686929372;
 bh=uHw14CfDgFm3qF/lgfQPttPTHtaxTk+P7o41vYD1ukA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=k9qll1hWMhgOSBLmYNjwhB2Ub/qewRLy57iEOm4B9BkDJW8lyCnUgbkDQjBcnLd8s
 7SnRSRjpb3xw41XxL1c7Zdv0CPs4DxpMvMQlg/waSEJOLPxXvW+6zzSEH3k364hBbR
 9RdCdy3P7Od0pqFToZk64/v1PFVtSx5AWmoGG69wf9dGwMXcYY5Ek8qL+ljs9li4Hg
 hkEyTDGMW9Sd5dOUztdPPYv1UwtP/8YcklwrJELht7j5SqoJe3JLiOIlAeYq7uePov
 PgeZIdo26/4FtB9LiyKyV1KyI4ojyVaN4beLOivZajQJUwpVUEpvcL9zAAGxAq/tx3
 Vc2IuLXyo74Jg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=k9qll1hW
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 0/3] optimize procedure of
 changing MAC address on interface
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
Cc: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "simon.horman@corigine.com" <simon.horman@corigine.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gRnJpLCAxNiBKdW4gMjAyMyAxMDowMjoxMiArMDAwMCBGaWphbGtvd3NraSwgTWFjaWVqIHdy
b3RlOgo+ID4gSGVyZSBpcyB0aGUgc3VtbWFyeSB3aXRoIGxpbmtzOgo+ID4gICAtIFtuZXQtbmV4
dCx2MywxLzNdIG5ldDogYWRkIGNoZWNrIGZvciBjdXJyZW50IE1BQyBhZGRyZXNzIGluIGRldl9z
ZXRfbWFjX2FkZHJlc3MKPiA+ICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL25ldGRldi9uZXQt
bmV4dC9jL2FkNzJjNGEwNmFjYwo+ID4gICAtIFtuZXQtbmV4dCx2MywyLzNdIGk0MGU6IHJlbW92
ZSB1bm5lY2Vzc2FyeSBjaGVjayBmb3Igb2xkIE1BQyA9PSBuZXcgTUFDCj4gPiAgICAgaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9uZXRkZXYvbmV0LW5leHQvYy9jNDVhNmQxYTIzYzUKPiA+ICAgLSBb
bmV0LW5leHQsdjMsMy8zXSBpY2U6IHJlbW92ZSB1bm5lY2Vzc2FyeSBjaGVjayBmb3Igb2xkIE1B
QyA9PSBuZXcgTUFDCj4gPiAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9uZXRkZXYvbmV0LW5l
eHQvYy85Njg2OGNjYTc5NzEgIAo+IAo+IEFoLCBzbyBuZXh0IHRpbWUgSSB3aWxsIHJlc3BvbmQg
dG8gZWFjaCByZXZpc2lvbiB3aXRoIHJldi1ieSB0YWdzIPCfmIkKCkkgbWF5IGhhdmUgZG9uZSB0
aGlzIHNsaWdodGx5IG91dCBvZiBzcGl0ZSA6UApZb3UgdGVsbCB0aGUgbWFuIHRoYXQgaGUgZGlk
bid0IGtlZXAgeW91ciBSLWIgdGFnLCB3aHkgbm90IHRocm93IGl0IGluCmFnYWluIGluIG9uZSBv
ZiB5b3VyIHJlc3BvbnNlcz8gSXQncyBiaXQgb2YgYSBQSVRBIGZvciBtZSB0byBhZGQgaXQKbWFu
dWFsbHkuIE9uZSB0YWcgaW4gcmVwbHkgdG8gdGhlIGNvdmVyIGxldHRlciBpcyBlbm91Z2ggRldJ
VyAoYXQgbGVhc3QKb24gbmV0ZGV2LCBJIGV4cGxhaW5lZCB0byBCUEYgZm9sa3MgaG93IHRvIGdl
dCB0aGUgdGFnIHByb3BhZ2F0aW9uCmZyb20gY292ZXIgbGV0dGVyIHRvIHdvcmsgYnV0IEknbSBu
b3QgMTAwJSBzdXJlIHRoZXkgc2V0IGl0IHVwIGZvcgp0aGVtc2VsdmVzKS4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtd2lyZWQtbGFuIG1haWxp
bmcgbGlzdApJbnRlbC13aXJlZC1sYW5Ab3N1b3NsLm9yZwpodHRwczovL2xpc3RzLm9zdW9zbC5v
cmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC13aXJlZC1sYW4K
