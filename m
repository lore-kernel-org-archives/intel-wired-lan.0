Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0699606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 05:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=2r32y6UN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXAb+EOB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A27FB60686;
	Thu, 26 Nov 2026 05:04:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LekeKcFciHug; Thu, 26 Nov 2026 05:04:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1ECD6069A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795669463;
	b=jdHKuHvefBXgL0kbopt//PfvT4KBeO3qflfR3wV8nUGu23uVbWB3JY8LS+/ds8bAPJB9
	 7ShYHxuwoid6CKNN4/xGcY+h1FJToa4szqWTjzXIrUb1Z59bX4oZgH5+chHpOSM/+SCWI
	 pAolLpOo88phv+X2z85I2sZXVLVjwJCuNqmp4AQfIdCLToYqliLlU81RtW+9XkUHpebea
	 lUZdslqkt/pZl9tff0qGXpmFKETNgn75AmWEuYupOobdVZ8TTG4c9pNYmSw9kT22xRKoR
	 5QiKJgch9AnWANWugL0+EOjWo44vxefJh7WEpJEiWOqPHX3MNBV+QO/HQeWKv4FPZiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795669463;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=9z7kIRsbScYAFhDCYlI1hjzVdeVnGoaYtI6UEzcTFZo=;
	b=EL3zTGUV9GaDfkPfQo8/dmpzvA4osgpn//cItcjZGWxXvlGuU1ZM8B6vY9oR/h9QWAmO
	 +MhF4oq4NWbibwX70tLy6dh2++oSwE6YkKkEikBnMhmoCnak+97xqGiR+OC4EvbrIrZ1K
	 ViMs4pc/iU+Qz4d2TUfdwP+WeIgPqanapem4JHkx2/srwJTGdaWLetU4VLnTSehO4zMH+
	 Nyk259V1IB/SYGY9d/2nvCSB8FXI388YLdLiEyTyXOI7obt7wgQYFZwb5mb8VId3d+PRY
	 RJRacPX/VEnZWLsWD3wfyyirD1AfvtKzoML2TUXMnykHZI3nO8pFa9zJjOObJgrGz/g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795669462;
	bh=9z7kIRsbScYAFhDCYlI1hjzVdeVnGoaYtI6UEzcTFZo=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=2r32y6UNpaIP7hwyFQtjKjphDc6YJF2AArIw/pt6dWLjdElokke/A2d7GWYA7+M+O
	 bhk/qmaiT9kfEsK/eYeuqaF2ADIXzLqCAYmmDZxpKIXYNIMqKc5E/VKXdj+q1ASjcR
	 LiVeeV4XOacTlwuMcv22AvGb1DbwHDDYFISfUb4jGLzKoBBFP+KM3kOKnb029hyJua
	 4v9e8u9PciKBt3mj4Ns16ktxE7gKXkofxgmOUG7RJ2BsAl8spsSrNzdJpq+iFGyMYu
	 TfMFs9xGlodRQQjhnSoA95atkox/0x34vKct4ZCXUtCDZvKNShdg4VvpL6m8sGcVEi
	 Q4BKfXx8JuDmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1ECD6069A;
	Thu, 26 Nov 2026 05:04:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C50BC32D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 05:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2D4340430
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 05:04:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LoBWKX3fdQya for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 05:04:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C4CFD4034C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lXAb+EOB
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4CFD4034C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 05:04:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 51DBE618D5;
 Thu, 26 Nov 2026 05:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85C61F000C4;
 Thu, 26 Nov 2026 05:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795669459;
 bh=9z7kIRsbScYAFhDCYlI1hjzVdeVnGoaYtI6UEzcTFZo=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=lXAb+EOBDuZxviTFkXX+uf/F0tAdNJUs6z/nYTD2/4nREP/foSTcOJ5KUEOGGjAbr
 pZcjmROotwHTS0XnaxZkvNQvlmSxm3BCgzOeXQVvs5ywH4ULt8blz67kGDXBVjRAIb
 0/aNOB3LLsQZCm6/UUHccVGvgNvMt/Fh5e9CFJN6R5axo+/a2f1jZVWk6zOW8n2XXw
 fYNrs5o882Ga/FwXQ6fJrThslG+OpwN9HhjnsPkTF+bvN0r9l+lr3MFZW7djHvJJhO
 BIyK4ePHvrJR2JQm0tQhoTH0m7OwSbEItGtKNM6q84EDr3vg2xQsPzsWKpDnN5W3RE
 gFXdq9E3abnSQ==
Message-ID: <sashiko-outbox-234759@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] idpf: fix vport_id used as array index in MAC filter
 async handler
To: guohongyu <guohongyu@cmss.chinamobile.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
References: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 05:04:18 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] idpf: use-after-free of vport in
  idpf_mac_filter_async_handler() on remove
--

commit 6b177b36cf8b8b2ad682680d9ce0837d77dda78f
Author: guohongyu <guohongyu@cmss.chinamobile.com>

idpf: fix vport_id used as array index in MAC filter async handler

This commit indexes adapter->vport_config[] by vport->idx instead of the
raw vport_id from the virtchnl payload in idpf_mac_filter_async_handler().

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_virtchnl.c
> index dac1d9fc4ab12..7870e8f810fa9 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3781,7 +3781,7 @@ static void idpf_mac_filter_async_handler(void *ctx,
>  	if (!vport)
>  		goto invalid_payload;
> =20
> -	vport_config =3D adapter->vport_config[le32_to_cpu(ma_list->vport_id)];
> +	vport_config =3D adapter->vport_config[vport->idx];

[Severity: Medium]
Can dereferencing vport->idx here cause a use-after-free of vport during
driver removal or shutdown?

CPU0                                    CPU1 (mbx_wq)
idpf_remove()
  set_bit(IDPF_REMOVE_IN_PROG, ...)
  idpf_vc_core_deinit()
    queue_delayed_work(..., &mbx_task)
    idpf_deinit_task()
      idpf_vport_dealloc()
                                        idpf_mac_filter_async_handler()
                                          vport =3D idpf_vid_to_vport(...)
        idpf_vport_rel()
          kfree(vport)
                                          vport->idx  <-- use-after-free
        adapter->vports[i] =3D NULL;

During removal, idpf_vc_core_deinit() keeps mbx_task running across
idpf_deinit_task() and relies on async callbacks to bail out when
IDPF_REMOVE_IN_PROG is set, as idpf_ptp_get_tx_tstamp_async_handler()
does.  Because idpf_vport_dealloc() frees vport inside idpf_vport_rel()
before clearing adapter->vports[i], and nothing serializes it against
idpf_vid_to_vport(), an arriving MAC filter error reply can obtain a
dangling vport pointer and read vport->idx after vport is freed.

Checking test_bit(IDPF_REMOVE_IN_PROG, adapter->flags) at the start of
idpf_mac_filter_async_handler() would prevent the handler from running
while vports are being torn down.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126020854.2339=
71-1-guohongyu@cmss.chinamobile.com?part=3D1
