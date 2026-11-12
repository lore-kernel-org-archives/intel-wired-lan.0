Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38DF606A339
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=g73OaClh;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8VZoVXV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76F8960A3C;
	Thu, 12 Nov 2026 18:00:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gBpofyjONWPK; Thu, 12 Nov 2026 18:00:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4FDE3607F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794506412;
	b=J6P7MkcYn9iuvxuZUtMFb0lRgylde/v/cU0zQrveMCyjnjY1LZZjBJx6VMFiRfYOA4nN
	 HhMJG0KxHFz92rvRDC3aW+WWKonXGwz2wkoYGf2m1OHPTar/VBTXDcpT0kiFaIt2ldKb6
	 X7uSxmo5JaVg3FLp5pyHq+GhCVMwzJ1Wa++X47sD8MS0eaWPidfDik3ICxB/ibEgmQpnU
	 U/QOXg4IwJFBsJbfIZbv7w+TAm0nEg38GlbRM1tkczqEkMb/StBIGWqrGkmI3t1S+jWHn
	 MFuFeQ8ubc3MlHMoghWcOkaRtypCr/N7oVgPeLrG8wPT+N2Zi5BVDnf1/9hsThu77yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794506412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7YRNISiJxbIUTsLygKufgFidBAmVPMdjexsRlPS3F+o=;
	b=hEK7YDYvpM0O4Nbxo1uSTQvPcbUTDb2Iq6nkD/SmNBdT+PWq5FMr4OhAXHCq/yz0gRlY
	 UDO4rRQxDOZa637fWjeO1qqCjFwuyB3RxFAEU6pRSDWUU6v0esXbJt9mUlT4EZjT+kVdZ
	 E63b6DQaqYX8ZxErSUFSn4qaM934hP9sb56FcRHGC2rBF1F0F5jOpH7G0fcUOvW+retRM
	 Rpx8qFB9ZyHh54g1rWhWp7/ayUDJ8fNho6To880JM2twFnDU4ZPVs5avyD59oYRMbYwhI
	 by7LOUPcHFM68KbXswK3XxRemcBdENH7m+HVzikixBHW4Y5kvGeVQ9h1yQdZxaGEwUw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794506412;
	bh=7YRNISiJxbIUTsLygKufgFidBAmVPMdjexsRlPS3F+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g73OaClhOGIhDzp6y4bPGRAlumsRr1lFSVZ6oHH8xU0iUw2vlaMZbsKK+6CJ8nrWl
	 i9THy5+pojEkCBb4krBZIlw3N4KxcKLdtNbF0qlgcLJI7DJlsKjTfo1ZYIMgoybp2w
	 BAIb1GcsxQCiDU1xUJc0OnU5DQ6x53TqWqR/K6FDf8OVbVfV2wtQgDoBQaSIPdaHpW
	 0ETh220FQaLsJP8I7yaXkeoQgJ76clw99NxMYSVEcshJCqtnlHFTnnBqwvDbT313LS
	 /JyT148nvKsGgbXk3k2WH1XzkU7KmroSDP81GWvWQTjRAF2dxpGGaUBndfsXt1Qzzf
	 hRw48jUGJ5H1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FDE3607F7;
	Thu, 12 Nov 2026 18:00:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C0A641370
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 18:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5FDD40D3A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 18:00:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RRJwII7DzLpY for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 18:00:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D2FC140A5C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=I8VZoVXV
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D2FC140A5C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 18:00:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1FF05623B4;
 Thu, 12 Nov 2026 18:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D663B1F000C5;
 Thu, 12 Nov 2026 18:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794506408;
 bh=7YRNISiJxbIUTsLygKufgFidBAmVPMdjexsRlPS3F+o=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=I8VZoVXVKR/KHWYA4AbPmug8HNRy6tbNVRdhAAEwFR3a66h2lckakXfARjRTNO/RL
 VMhSA1QilwQ80v4Ahjx7tDyVET2DelGsLakOfjoDQjTviRt3Ue5FHxh/Yp1CU64ivT
 XlmFaa9ay/sKZDjSZfkNKpdZdrYrMWjm4kKdyrcAF6Uz4gIiRlTw5FYrdeh6rINcx8
 zaQ1DqtvR4dGIh0CebUMqG8H7SFFNbWHSaEJrFs47DcCRznHlKA/UWANxAdjwsNkdw
 R2cL3wuFRrXn8/SERVHlNV+jpVrq26qHmkK17QWXkkaIkj+zYKXsad7y83nKOcaTGo
 TdXyOf7DlWPyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B4586380AA7D; Thu, 12 Nov 2026 18:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] ice: dpll: fix updates of the SyncE CGU registers
 on E825
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <179450640727.567589.292897520370852621.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:00:07 +0000
References: <20261110094350.184185-1-ivecera@redhat.com>
In-Reply-To: <20261110094350.184185-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, arkadiusz.kubalewski@intel.com,
 grzegorz.nitka@intel.com, aleksandr.loktionov@intel.com, poros@redhat.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, mschmidt@redhat.com, 
 jramaseu@redhat.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 10:43:48 +0100 you wrote:
> All E825C PFs share the CGU registers R10 and R11, which hold the mux and
> the divider of the two recovered clock outputs. Both patches fix how a link
> change updates them, both found in review:
> 
> - Patch 1 adds a lock shared by all PFs around the read-modify-write
>   sequences of these registers. A link change on one PF could undo an RCLK
>   pin change made by another PF.
> - Patch 2 lets a link change set the divider of an output only when its
>   port drives that output. Every port set it from its own link speed,
>   which is wrong when ports run at different speeds.
> 
> [...]

Here is the summary with links:
  - [net,1/2] ice: dpll: serialize changes of the SyncE CGU registers
    https://git.kernel.org/netdev/net/c/0afbc079d87e
  - [net,2/2] ice: dpll: set the SyncE divider only for the port driving the output
    https://git.kernel.org/netdev/net/c/164721e16b82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


