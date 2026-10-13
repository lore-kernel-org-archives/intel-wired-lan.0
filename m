Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D6ECC6B0E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 06:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF06180A5A;
	Tue, 13 Oct 2026 06:31:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kNYwQKwKafBi; Tue, 13 Oct 2026 06:31:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 06B0680BEC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791873075;
	b=suF/HUpHOrkWhgzCKPSqNzmxeUAmNxTEFCRM8CN079CDX4dHkRmhw2EErn4rmCFAgxYE
	 o6WB2SKp9tu0EvS1N7LjMgOwKYKgK0M5o9imvxyBoFE1znD+IRAfn3mEBTYlw/DR1pPbU
	 rABxt2h5nTQFAwqdoMdC9rLRYs+9/sf928t/HBv3xVQhHIIcuZ6EgneG4YDbecmi2g+h5
	 EO4S0mrcwoJwGk3doNnbrTrRdo+nhsa8YjtnfK9HyIl+cxQy9/PDoFbSuOtygc4bvnskg
	 sSLkfZAojStNgREOf6jJqYzb/ZBWaVArPP64XIUaksk1SNw7hQRiv6h5yuyLamhGn5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791873075;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=v+gdXINVQVUti3SK1/XE4KS1/MhBDCUm9OzNPpRixhw=;
	b=neMOwEhj0mMSsAfX0IMb3DLpPOanw5T7UUuzWxNb24v/IdSAbdhJLAWmKVF2q6K88Y+3
	 2Y41S3byyXq/8XOFDL6+XOVoc0GCy1uJeSqfVf+Ni35LDlBLLklg+4x8FXUEyhAbKyGRR
	 vVc8fzU6s2oOowfMuCfLqd8DVo5+t+Xdbuh+rCkoi7303+B33pSVWTw1Mi7HyxIUX3IFQ
	 4JaHZ1kPi2HVVCnYZwYxpPy4FiSQTecvUIQcoqV4id3yIWQjZrE/vMiE2FdUU6mzk+2I7
	 OsLxQ1um8X+fOaMAN7g70SMzBVzcHyIxL8Cy+BfoNatRX+1RqnbF8dHtka3oecHL4fQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791873075;
	bh=v+gdXINVQVUti3SK1/XE4KS1/MhBDCUm9OzNPpRixhw=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=yP7RoBHDkJQI/4+za6RAJYqDgh3JmWUvcaD3SVeiD8srtZM3FEnVHq2PUCyWuD4BU
	 T48bXtMrkmvDLD1ba+UaCARF4iwRBPqDJ8BEDmcqZlTBBIom2ctgBVcEIvMjNCSG+3
	 LGL5SaR6XZcO5iUgyVhY4xBqHPwQl9IgvvHlaG5k4SlAbHiOObG5StsDoYNBUEC0ri
	 VAXQIYnSZd4axRNXT2xpg+iE+4Bm1PpbrtGQtr1A6HaGIBzqvqEs4dhzaipuy4C3Va
	 fG1PnPsn91t5X4B6v/1HFbtMAXh3KcdpQgeFsBWCvc/EClZBiqLBuGHrKRJA/AIy57
	 Fk8ytTQXuMx4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06B0680BEC;
	Tue, 13 Oct 2026 06:31:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 98215A58
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 06:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89C7E60629
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 06:31:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7xDzY4BQQ8Fk for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 06:31:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 915F4605FD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791873072;
 b=sRAVSi4rEUI6i3WJvsIMKHhILHfD+GaWaLm5vANG7XLZEh7ixDKWvX09Pdaf9+6r3Stj
 otD1USuHQyr5l9W2SzRITdP7Cs1Xb80Lz/Bly/a3txSmj+xHAU5/v6ZBHHWdvvQ5g5yuE
 O9L5L6xuZ1iplqpES5235FE/ApuOebW0fAHN9H/R36yyys9Ac11MNl1gFiwDnAWB06RLq
 DlhKo1MMaa2TSCPoxM89VRmWHinQ83pgObd1Mf7W/732+OD/t9D1klDRarJGGxHD5byI9
 PhLt29rOZCzZoLLDJX6clcVmL6p5AsSMsfnQfCusu+HeHH9E9Dml+yCJTyu9/M+zfEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791873072;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=v+gdXINVQVUti3SK1/XE4KS1/MhBDCUm9OzNPpRixhw=;
 b=OOp6eXUHg6K96NV/N+raRSoMrdYvAAD+jEWJt3nM61cYVU6bZqWOFZXCaZC+5hTeg7tr
 3sOj+zqPMJx9P7kqhgLQ0nkCB0hDjbbDVITfO1WVWoLMJ7Vmy4CL3spi18kD3PflYM0N5
 wDRpdDQHOlmOkizRliY6eET8lWgBAZlW+4QLZnAuSt0jJpaVBAeGP2gk7wiZIr6pOFl9C
 P+b/WTDAl2HODqGmk6xNHt28TBMYW22xYzrNg7ZuimYP+4d9eJVqs/V5DOaANcJfSquCF
 GJ3BuDsTquZxr8BgJnx1wRN2T2KHg33Y2ZgIi6LuEfmVnMtNJHkwnm1Rtgg8sj7HZ5g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VeGIsn06; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VeGIsn06
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 915F4605FD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 06:31:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4CA4E60136;
 Tue, 13 Oct 2026 06:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE3F1F000FF;
 Tue, 13 Oct 2026 06:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791873070;
 bh=v+gdXINVQVUti3SK1/XE4KS1/MhBDCUm9OzNPpRixhw=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=VeGIsn06T8mSScvmnZZFGGvMjmLoxI1uwZcmxftJ0LbW8c2GbxLPSX+C08Ro0NNvM
 joaeCVRiYGv9H4Bond4IJ/5yKxME1n1Y0u2CArOOwwNQF+0ANlcRsG7wXuC4P3VoRJ
 oxdEexfa8nGhPDxS1wk5YDV3M5dd21tkyp4ECc52ihWbvRdo14GS9rsfbJtcGr77F0
 jqGIX0BPtsllu7eSGxCvNVZ9c74QrV/1CwSVmpzcwsuQ/in4MEAZgO8lXGKm0Zwwtl
 p5kL0KOG42zrC7SHzgu6KJJIQTaTw7XJBlSixu2W+Eqe2kAcsJ/cIz9lL+Nqpe2OX2
 us77nCwaePicQ==
Message-ID: <sashiko-outbox-169099@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v4 2/2] idpf: keep the mailbox up while tearing
 down vports on shutdown
To: "Tian Xun Ng" <luckilystar08@gmail.com>, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261012063027.27750-3-luckilystar08@gmail.com>
References: <20261012063027.27750-1-luckilystar08@gmail.com>
 <20261012063027.27750-3-luckilystar08@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:31:09 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] idpf: Use-After-Free in idpf_handle_event_link() due to concurrent=
 teardown
--

commit b8311fab0c0442230fa268ded8ce6b4805cfd5c0
Author: Tian Xun Ng <tianxun.ng@bytedance.com>

idpf: keep the mailbox up while tearing down vports on shutdown

This commit sets IDPF_REMOVE_IN_PROG during shutdown to keep the mailbox up
while vports are destroyed, ensuring teardown messages reach the device. It
also bounds transaction timeouts during teardown to prevent unresponsive
control planes from delaying reboots.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/et=
hernet/intel/idpf/idpf_main.c
> index 129bccaa6baa8..2e018d02f7dfe 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -194,8 +194,18 @@ static void idpf_shutdown(struct pci_dev *pdev)
>  {
>  	struct idpf_adapter *adapter =3D pci_get_drvdata(pdev);
> =20
> +	/* As in idpf_remove(): keep the event task from being requeued, and
> +	 * destroy the vports while the mailbox is still up.
> +	 */
> +	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
>  	cancel_delayed_work_sync(&adapter->serv_task);
>  	cancel_delayed_work_sync(&adapter->vc_event_task);
> +
> +	/* Bound the teardown transactions and Tx queue marker waits started
> +	 * from here on, so that an unresponsive control plane costs a single
> +	 * timeout. A transaction already in flight keeps its own timeout.
> +	 */
> +	WRITE_ONCE(adapter->vc_xn_timeout_ms, IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);
>  	idpf_vc_core_deinit(adapter);

[Severity: High]
Does setting IDPF_REMOVE_IN_PROG here introduce a use-after-free regression
during teardown?

In idpf_vc_core_deinit(), when IDPF_REMOVE_IN_PROG is set, the mailbox task
is explicitly requeued:

drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:idpf_vc_core_deinit() {
	if (!remove_in_prog) {
		libie_ctlq_xn_shutdown(adapter->xnm);
	} else {
		/* ... */
		cancel_delayed_work_sync(&adapter->mbx_task);
		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
	}

	idpf_ptp_release(adapter);
	idpf_deinit_task(adapter);
	...
}

This allows the mailbox task to run concurrently with idpf_deinit_task()
which destroys the vports. If a hardware event (like a link state change)
arrives during this window, the mailbox task can call idpf_handle_event_lin=
k()
which looks up the vport locklessly:

drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:idpf_handle_event_link() {
	np =3D netdev_priv(vport->netdev);
	np->link_speed_mbps =3D le32_to_cpu(v2e->link_speed);
	if (vport->link_up =3D=3D v2e->link_status)
		return;
	vport->link_up =3D v2e->link_status;
}

Meanwhile, idpf_deinit_task() might have already freed the vport via
idpf_vport_rel() without synchronizing against the mailbox task or clearing
the lookup array first:

drivers/net/ethernet/intel/idpf/idpf_lib.c:idpf_vport_rel() {
	kfree(vport);
	adapter->num_alloc_vports--;
}

Could this lead to memory corruption if an unsolicited hardware event arriv=
es
while idpf_vc_core_deinit() is tearing down the vports?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012063027.2775=
0-1-luckilystar08@gmail.com?part=3D2
