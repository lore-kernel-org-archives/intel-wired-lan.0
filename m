Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F090C88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 20:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8339980826;
	Tue, 15 Sep 2026 20:33:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cDT8dYkaDIKO; Tue, 15 Sep 2026 20:32:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ED5CF80664
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789504378;
	b=mT0nL89t5a/4kQmrULzHdqiAhBJok4HY+ACMax4++dRdXPAN4knL4x9UzIHlruFdPg7/
	 IIJUWGLep8KUx0D90CmcD2m5A2atEZVLhJ5a5DYXmb0eo1eGzhwqDO/RfsgfFovamk2bj
	 b60meZMFFfcFq/L6/I117ApTWpwVMD1tBv3xgeLXPhyIG8mIRM+6J46VZZ+N0qRj1C8K2
	 jm5T0QqKPVlQnZcZ+KCdx3SaGZx4ZD9Eqy4dyFA31Oh61JWAPbAjKaJiKqlRAYBvhyigQ
	 kIjaQIkVHh72GgdEgYEczZk4g4jR80ty/A5caa1fFjAS1AiJ6EgKG6nQQhfT6VsYYTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789504378;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Content-Type:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R25rhAzUJl436ZsvBEWGJ7075mhj4oKyyWiuR3mZV6M=;
	b=XlQcSDCp09Q+O1+Kmdjrcwf8z0aKzFeCQGcQu/DcZnLfavJF1V32JakVRIFXEpAc72vd
	 ED5eNagIF2hqE6IWvnCMbHjasUWoyVvSZXCebNS8hOV9HxDxdJ6MilVbpSrmvxptN/aKg
	 pp5kJfCzljZnPSEc6b2R/vKYGf013leYg+lPxDFhr4pQ9yc3JjbluPDgXMkR1OGUQMLqH
	 /m+b9VmKPN1/9XDEh14TrsG9dWUXg9EHW8/JOwf+yC+lcFoGZARxY+WusuxgOJWSHqxnp
	 8fYKj4wyTbDql0+XtDwaHqlhXHBHk0lVk3l8hE7wekFX1E3dUSfvy9tJjstXaOcD5fg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmx.com;
	dkim=pass header.d=gmx.com header.i=vikdon@gmx.com header.a=rsa-sha256 header.s=s31663417 header.b=VIO1hJUf;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789504378;
	bh=R25rhAzUJl436ZsvBEWGJ7075mhj4oKyyWiuR3mZV6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9nGnbkOF1rQEJ1lMHGTMg2QK/VbTQz1YitMolNZQJ2224XT99L63riiJ+Ye1lXr6f
	 W38pwRu5KVX9FybLE3X3J+QRnI9fvkGEyweVIqS3CiTfdwVeaQLN9nkyOUURZS9led
	 u7MxTGT6XqOCc9Ad/XKXQ1BEdPTxFxUh6czq2P6g+yM+me1voZ9J3UWJ1r4cAw3kc9
	 +mwUfKaMxvEAxNWkDTm2WXK80qGkBe1iaMYsJTzSX8FaC1MSz99h4C87ohVs21Ti4y
	 bIKtQ1cvSzLDUC10uk8umTLLN7NYbaw48dOnCLewUlB0BaDI004g8DpVUk5y3uyqGa
	 ULAKZpaqnAPUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED5CF80664;
	Tue, 15 Sep 2026 20:32:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E237023F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 20:32:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE59F80649
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 20:32:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ygVZihG7rYtr for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 20:32:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0748080664
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789504373;
 b=VF2XM9NOeTWcarbyg7cafaTjnhAhCKFrTaQfBxFLtyzK93g8sxfIu4vAEbSXCr1bU89K
 agmDoX4bd5HYSJLZ/LOpUB0xTPu94GajAOiFYRbcI5IP/j7vJIs+yM3C4EAH4PGX0jEs9
 lbOwMRcytVeh6oz1TPjP0S4rUctx3Qbc4YaTeT7KDv6QZDvLLvyWRb75aa4BlBcXcAK/z
 9DcVfdE9834IR05J1UJ+LlC6QBVVJ/HGol1T9VdnEzrOpQ/sjwHbrW4ayFzwbpfOR9n/p
 mG1LNbQEV1xUrP26DeMZvPXpagPu19cTzg2I7Xd/iVqMylK0CpRObdLs3M3EOm4/ULw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789504373;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Content-Type:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=pkwOMruNW9sg9to7M1bEoob24W0VzJvQRGEn0i30ryQ=;
 b=ErnHxqJZlX7rKZkWhT9YLDs/KBdCpfoYyCzXHVIaT3KlXgEy4DXGRQSJF8ethsbbPK4G
 0uFk7LFyVGTm80RJjYkMdDYj2CYVouOeWenhJjYRsMK18DgKAfW4tu5PS0mF8aD05h2n9
 qpA7LNFC5qAEDOwixvHtO89p9vfiQWp6yiusCUoJJsAkrx5IlywjAtEEwjtC43AXOtLai
 oWstExvptpcOZXwAupQaslefhP/3+CldK1dpyrzY6vDEwYLJoOzrz1O5pAfMJhI+aDZiS
 Uwtqznudn49VqAtuVha4UW42ukooFLFFye6PWVGH+kiXBfgLLxQbtwYGgChoIArm5YQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmx.com; 
 dkim=pass header.d=gmx.com header.i=vikdon@gmx.com header.a=rsa-sha256
 header.s=s31663417 header.b=VIO1hJUf; 
 arc=none smtp.remote-ip=212.227.17.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.21;
 helo=mout.gmx.net; envelope-from=vikdon@gmx.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.com header.i=vikdon@gmx.com header.a=rsa-sha256
 header.s=s31663417 header.b=VIO1hJUf
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0748080664
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 20:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1789504363; x=1790109163; i=vikdon@gmx.com;
 bh=pkwOMruNW9sg9to7M1bEoob24W0VzJvQRGEn0i30ryQ=;
 h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:From:In-Reply-To:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=VIO1hJUfPnLuTsQyHi46rnlIN9vz1Em7CokCs/U0qx+51BAYyIuZUlK1e7LZ5gcn
 oJfMokjThtb9fNenN7rJ6RRbAhNrw/CkKsrY7C78tsTwNijwPobQuXS4WiEEFaXm/
 j20wc8yk2Ceuu3eisvxyBmNRgs2O7KjGaL0iaXhG2J38slABStf2UAxLQbCuSHNaE
 1p5j7usRrgN1CchmuR2RapbtGAPxN5us5s3X2QHeeqfRdeIx56HPdrAAhrnoQnztm
 aQlPvkyJAzwTBsYMjXElLcJuRvAeNE3xBurZwe2bxxxQHZMMUqEt9ZkKfGOcuRi0n
 6XCQWvn7fk7UP7XQRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5mGB-1wiYWe1wfj-00vlvU; Tue, 15
 Sep 2026 22:32:43 +0200
Content-Type: multipart/mixed; boundary="------------BgV5HUUsbU3tOtBmZAMYkB7N"
Message-ID: <e6e1722b-a36b-4784-b763-0d7bae8945fb@gmx.com>
Date: Tue, 15 Sep 2026 22:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [e1000e] Intel I219-LM host becomes unreachable
 under VM network load when AMT SOL/IDER is active
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
Cc: intel-wired-lan@lists.osuosl.org
References: <1dbf956a-e981-4b2a-ab5e-ddbd5905663c@gmx.com>
 <46dde8c9-1d39-40d1-b1d0-973d274fffc8@intel.com>
Content-Language: uk
From: Viktor Donner <vikdon@gmx.com>
In-Reply-To: <46dde8c9-1d39-40d1-b1d0-973d274fffc8@intel.com>
X-Provags-ID: V03:K1:doEp8GBaDG3yO8xd5+y9u1W3vkNou1xX7r7KWgJr5Tr92FzjuyB
 ngjW9SUpYMt/8MGeVp31KeQrH5C2PXaNEZxwlK2oZKyoem/ZmnPPyYJGHPN9/oUu/1H32R4
 Pc2hg61LNUut+tEplzV1yfZPiPnOBpi6+3U2I8QgWtKkZxytJ1VADODoS3vT/L4ND7GTFV6
 6qXao7wt7B3X4/bctMFug==
UI-OutboundReport: notjunk:1;M01:P0:9lTdYxb0ZIM=;2a3xHDgyabHeTkl+O1VZuiIa2PH
 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
 mHoMGjaAGv5WGJ
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

This is a multi-part message in MIME format.
--------------BgV5HUUsbU3tOtBmZAMYkB7N
Content-Type: multipart/alternative;
 boundary="------------urVGT9MJs0PlCqiw4j0JVoWq"

--------------urVGT9MJs0PlCqiw4j0JVoWq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

|Hi, I reproduced the issue again after a clean Proxmox VE installation.=
=20
Updated environment: - Proxmox VE: 9.2.20 - Kernel: 7.0.14-17-pve - NIC:=
=20
Intel I219-LM - Driver: e1000e - Firmware: 0.4-4 During the failure: -=20
nic0 remained UP and LOWER_UP - link remained detected at 1000 Mb/s/full=
=20
duplex - the ARP/neighbour entry for the gateway 192.168.1.10 changed to=
=20
FAILED - ping returned "Destination Host Unreachable" from the host -=20
rx_missed_errors reached 14867 - rx_errors, tx_errors, CRC, frame,=20
carrier and timeout counters remained zero - the kernel log contained no=
=20
e1000e Tx hang, watchdog, reset or register dump Bringing nic0 down and=20
up, running ifreload, and flushing the neighbour table restored=20
connectivity without rebooting. I then disabled the following offloads:=20
ethtool -K nic0 tso off gso off gro off After that, several speed tests=20
completed successfully and rx_missed_errors did not increase. This=20
appears reproducible with offloads enabled and is mitigated by disabling=
=20
them. Please let me know whether testing TSO, GSO and GRO individually,=20
or collecting any specific e1000e trace/debug data, would be useful.=20
Regards, Viktor|



On 16.07.2026 13:03, Ruinskiy, Dima wrote:
> On 12/07/2026 14:56, Viktor Donner wrote:
>> Hello,
>>
>> I am reporting an issue involving the e1000e driver, Intel I219-LM,
>> network offload, and Intel AMT/ME remote-management state.
>>
>> Environment:
>> - Host: Proxmox VE 9.2.4
>> - Kernel: 7.0.14-4-pve
>> - NIC: Intel I219-LM
>> - Driver: e1000e
>> - Driver version: 7.0.14-4-pve
>> - Firmware version: 0.4-4
>> - PCI address: 0000:00:1f.6
>> - Link: 1000 Mb/s, full duplex
>> - Host bridge: Linux bridge vmbr0
>> - Guest traffic: VirtIO VM network interface
>>
>> Observed behavior:
>> When running a speed test inside a VM, at approximately 600+ Mbit/s
>> download traffic, the Proxmox host becomes completely unreachable over
>> the network:
>>
>> - no ICMP response
>> - no SSH access
>> - no Proxmox web interface
>> - the physical/vPro console initially remains available
>> - a normal reboot may hang, requiring an AMT hardware reset/power cycle
>>
>> The NIC still appears administratively UP and LOWER_UP, and the bridge
>> configuration and IP address remain present.
>>
>
> Hi Viktor,
> I'm not very familiar with Proxmox, so just to make sure I understand=20
> the setup - 7.0.14-4-pve is the host kernel, and the e1000e drives the=
=20
> I219-LM device on the host, whereas the VM is running VirtIO which is=20
> bridged over vmbr0 to the host?
>
> And eventually after the speed test has been running for some time -=20
> the host NIC hangs with all the above symptoms?
>> Relevant boot messages while MeshCommander / AMT remote management was
>> active:
>>
>> =C2=A0=C2=A0=C2=A0 e1000e 0000:00:1f.6 (uninitialized): Reset blocked b=
y ME
>> =C2=A0=C2=A0=C2=A0 e1000e 0000:00:1f.6: PHY reset is blocked due to SOL=
/IDER session.=20
> > > After completely closing MeshCommander and rebooting, these messages
>> disappeared. TSO/GSO/GRO were enabled again, and repeated speed tests
>> did not reproduce the host lockup.
>
> So the issue only occurs if MeshCommander is active at the same time=20
> that the speed test is running in the VM, and TSO/GSO are enabled?
>
>> Please advise:
>> 1. Is this a known e1000e/I219-LM issue?
> We get various reports of I219-LM hangs related to TSO/GSO from time=20
> to time (GRO specifically is not supported by I219). Not sure whether=20
> I have seen one mentioning the specific scenario you are running.
>
>> 2. Is blocking PHY reset during SOL/IDER expected to prevent recovery
>> =C2=A0=C2=A0 =C2=A0from a TX/RX hang?
> This depends on the cause of the hang. If it is the part of the data=20
> path that is specific to the host - then it should not prevent=20
> recovery, but if it is somewhere in the PHY - it might.
>
>> 3. Are there recommended driver parameters or mitigations other than
>> =C2=A0=C2=A0 =C2=A0disabling TSO/GSO/GRO?
>> 4. What additional traces or register dumps would be useful?
> A dmesg dump from the host at the time of the failure may help. Were=20
> the above two messages the only ones from e1000e? Normally, if there=20
> is a Tx hang in the data path of the e1000e driver - it will show in=20
> the log with a dump of some registers.
>
>>
>> Hardware:
>> - Motherboard: Gigabyte Q370M D3H GSM PLUS rev. 1.0
>> - Primary NIC: Intel I219-LM
>> - Secondary NIC: Intel I211 using the igb driver, currently not cabled
>>
>> Regards,
>> Viktor D
>> vikdon@gmx.com
>

--------------urVGT9MJs0PlCqiw4j0JVoWq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-=
8">
  </head>
  <body>
    <pre dir=3D"ltr"><code>Hi,

I reproduced the issue again after a clean Proxmox VE installation.

Updated environment:
- Proxmox VE: 9.2.20
- Kernel: 7.0.14-17-pve
- NIC: Intel I219-LM
- Driver: e1000e
- Firmware: 0.4-4

During the failure:
- nic0 remained UP and LOWER_UP
- link remained detected at 1000 Mb/s/full duplex
- the ARP/neighbour entry for the gateway 192.168.1.10 changed to FAILED
- ping returned "Destination Host Unreachable" from the host
- rx_missed_errors reached 14867
- rx_errors, tx_errors, CRC, frame, carrier and timeout counters remained =
zero
- the kernel log contained no e1000e Tx hang, watchdog, reset or register =
dump

Bringing nic0 down and up, running ifreload, and flushing the neighbour
table restored connectivity without rebooting.

I then disabled the following offloads:

    ethtool -K nic0 tso off gso off gro off

After that, several speed tests completed successfully and
rx_missed_errors did not increase.

This appears reproducible with offloads enabled and is mitigated by
disabling them. Please let me know whether testing TSO, GSO and GRO
individually, or collecting any specific e1000e trace/debug data, would
be useful.

Regards,
Viktor</code></pre>
    <br>
    <br>
    <div class=3D"moz-cite-prefix">On 16.07.2026 13:03, Ruinskiy, Dima
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:46dde8c9-1d39-40d1-b1d0-973d274fffc8@intel.com">On
      12/07/2026 14:56, Viktor Donner wrote:
      <br>
      <blockquote type=3D"cite">Hello,
        <br>
        <br>
        I am reporting an issue involving the e1000e driver, Intel
        I219-LM,
        <br>
        network offload, and Intel AMT/ME remote-management state.
        <br>
        <br>
        Environment:
        <br>
        - Host: Proxmox VE 9.2.4
        <br>
        - Kernel: 7.0.14-4-pve
        <br>
        - NIC: Intel I219-LM
        <br>
        - Driver: e1000e
        <br>
        - Driver version: 7.0.14-4-pve
        <br>
        - Firmware version: 0.4-4
        <br>
        - PCI address: 0000:00:1f.6
        <br>
        - Link: 1000 Mb/s, full duplex
        <br>
        - Host bridge: Linux bridge vmbr0
        <br>
        - Guest traffic: VirtIO VM network interface
        <br>
        <br>
        Observed behavior:
        <br>
        When running a speed test inside a VM, at approximately 600+
        Mbit/s
        <br>
        download traffic, the Proxmox host becomes completely
        unreachable over
        <br>
        the network:
        <br>
        <br>
        - no ICMP response
        <br>
        - no SSH access
        <br>
        - no Proxmox web interface
        <br>
        - the physical/vPro console initially remains available
        <br>
        - a normal reboot may hang, requiring an AMT hardware
        reset/power cycle
        <br>
        <br>
        The NIC still appears administratively UP and LOWER_UP, and the
        bridge
        <br>
        configuration and IP address remain present.
        <br>
        <br>
      </blockquote>
      <br>
      Hi Viktor,
      <br>
      I'm not very familiar with Proxmox, so just to make sure I
      understand the setup - 7.0.14-4-pve is the host kernel, and the
      e1000e drives the I219-LM device on the host, whereas the VM is
      running VirtIO which is bridged over vmbr0 to the host?
      <br>
      <br>
      And eventually after the speed test has been running for some time
      - the host NIC hangs with all the above symptoms?
      <br>
      <blockquote type=3D"cite">Relevant boot messages while MeshCommander
        / AMT remote management was
        <br>
        active:
        <br>
        <br>
        =C2=A0=C2=A0=C2=A0 e1000e 0000:00:1f.6 (uninitialized): Reset bloc=
ked by ME
        <br>
        =C2=A0=C2=A0=C2=A0 e1000e 0000:00:1f.6: PHY reset is blocked due t=
o SOL/IDER
        session. </blockquote>
      &gt; &gt; After completely closing MeshCommander and rebooting,
      these messages
      <br>
      <blockquote type=3D"cite">disappeared. TSO/GSO/GRO were enabled
        again, and repeated speed tests
        <br>
        did not reproduce the host lockup.
        <br>
      </blockquote>
      <br>
      So the issue only occurs if MeshCommander is active at the same
      time that the speed test is running in the VM, and TSO/GSO are
      enabled?
      <br>
      <br>
      <blockquote type=3D"cite">Please advise:
        <br>
        1. Is this a known e1000e/I219-LM issue?
        <br>
      </blockquote>
      We get various reports of I219-LM hangs related to TSO/GSO from
      time to time (GRO specifically is not supported by I219). Not sure
      whether I have seen one mentioning the specific scenario you are
      running.
      <br>
      <br>
      <blockquote type=3D"cite">2. Is blocking PHY reset during SOL/IDER
        expected to prevent recovery
        <br>
        =C2=A0=C2=A0 =C2=A0from a TX/RX hang?
        <br>
      </blockquote>
      This depends on the cause of the hang. If it is the part of the
      data path that is specific to the host - then it should not
      prevent recovery, but if it is somewhere in the PHY - it might.
      <br>
      <br>
      <blockquote type=3D"cite">3. Are there recommended driver parameters
        or mitigations other than
        <br>
        =C2=A0=C2=A0 =C2=A0disabling TSO/GSO/GRO?
        <br>
        4. What additional traces or register dumps would be useful?
        <br>
      </blockquote>
      A dmesg dump from the host at the time of the failure may help.
      Were the above two messages the only ones from e1000e? Normally,
      if there is a Tx hang in the data path of the e1000e driver - it
      will show in the log with a dump of some registers.
      <br>
      <br>
      <blockquote type=3D"cite">
        <br>
        Hardware:
        <br>
        - Motherboard: Gigabyte Q370M D3H GSM PLUS rev. 1.0
        <br>
        - Primary NIC: Intel I219-LM
        <br>
        - Secondary NIC: Intel I211 using the igb driver, currently not
        cabled
        <br>
        <br>
        Regards,
        <br>
        Viktor D
        <br>
        <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:vikdon@gmx.co=
m">vikdon@gmx.com</a>
        <br>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------urVGT9MJs0PlCqiw4j0JVoWq--

--------------BgV5HUUsbU3tOtBmZAMYkB7N
Content-Type: text/plain; charset=UTF-8; name="e100e.txt"
Content-Disposition: attachment; filename="e100e.txt"
Content-Transfer-Encoding: base64

cm9vdEB2ZHByb3g6fiMgZXRodG9vbCAtaSBuaWMwDQpldGh0b29sIC1rIG5pYzANCmV0aHRv
b2wgLVMgbmljMA0KbHNwY2kgLW5udnYgLXMgMDA6MWYuNg0KZHJpdmVyOiBlMTAwMGUNCnZl
cnNpb246IDcuMC4xNC0xNy1wdmUNCmZpcm13YXJlLXZlcnNpb246IDAuNC00DQpleHBhbnNp
b24tcm9tLXZlcnNpb246IA0KYnVzLWluZm86IDAwMDA6MDA6MWYuNg0Kc3VwcG9ydHMtc3Rh
dGlzdGljczogeWVzDQpzdXBwb3J0cy10ZXN0OiB5ZXMNCnN1cHBvcnRzLWVlcHJvbS1hY2Nl
c3M6IHllcw0Kc3VwcG9ydHMtcmVnaXN0ZXItZHVtcDogeWVzDQpzdXBwb3J0cy1wcml2LWZs
YWdzOiB5ZXMNCkZlYXR1cmVzIGZvciBuaWMwOg0KcngtY2hlY2tzdW1taW5nOiBvbg0KdHgt
Y2hlY2tzdW1taW5nOiBvbg0KICAgICAgICB0eC1jaGVja3N1bS1pcHY0OiBvZmYgW2ZpeGVk
XQ0KICAgICAgICB0eC1jaGVja3N1bS1pcC1nZW5lcmljOiBvbg0KICAgICAgICB0eC1jaGVj
a3N1bS1pcHY2OiBvZmYgW2ZpeGVkXQ0KICAgICAgICB0eC1jaGVja3N1bS1mY29lLWNyYzog
b2ZmIFtmaXhlZF0NCiAgICAgICAgdHgtY2hlY2tzdW0tc2N0cDogb2ZmIFtmaXhlZF0NCnNj
YXR0ZXItZ2F0aGVyOiBvbg0KICAgICAgICB0eC1zY2F0dGVyLWdhdGhlcjogb24NCiAgICAg
ICAgdHgtc2NhdHRlci1nYXRoZXItZnJhZ2xpc3Q6IG9mZiBbZml4ZWRdDQp0Y3Atc2VnbWVu
dGF0aW9uLW9mZmxvYWQ6IG9mZg0KICAgICAgICB0eC10Y3Atc2VnbWVudGF0aW9uOiBvZmYN
CiAgICAgICAgdHgtdGNwLWVjbi1zZWdtZW50YXRpb246IG9mZiBbZml4ZWRdDQogICAgICAg
IHR4LXRjcC1tYW5nbGVpZC1zZWdtZW50YXRpb246IG9mZg0KICAgICAgICB0eC10Y3A2LXNl
Z21lbnRhdGlvbjogb2ZmDQogICAgICAgIHR4LXRjcC1hY2NlY24tc2VnbWVudGF0aW9uOiBv
ZmYgW2ZpeGVkXQ0KZ2VuZXJpYy1zZWdtZW50YXRpb24tb2ZmbG9hZDogb2ZmDQpnZW5lcmlj
LXJlY2VpdmUtb2ZmbG9hZDogb2ZmDQpsYXJnZS1yZWNlaXZlLW9mZmxvYWQ6IG9mZiBbZml4
ZWRdDQpyeC12bGFuLW9mZmxvYWQ6IG9uDQp0eC12bGFuLW9mZmxvYWQ6IG9uDQpudHVwbGUt
ZmlsdGVyczogb2ZmIFtmaXhlZF0NCnJlY2VpdmUtaGFzaGluZzogb24NCmhpZ2hkbWE6IG9u
IFtmaXhlZF0NCnJ4LXZsYW4tZmlsdGVyOiBvZmYgW2ZpeGVkXQ0Kdmxhbi1jaGFsbGVuZ2Vk
OiBvZmYgW2ZpeGVkXQ0KdHgtZ3NvLXJvYnVzdDogb2ZmIFtmaXhlZF0NCnR4LWZjb2Utc2Vn
bWVudGF0aW9uOiBvZmYgW2ZpeGVkXQ0KdHgtZ3JlLXNlZ21lbnRhdGlvbjogb2ZmIFtmaXhl
ZF0NCnR4LWdyZS1jc3VtLXNlZ21lbnRhdGlvbjogb2ZmIFtmaXhlZF0NCnR4LWlweGlwNC1z
ZWdtZW50YXRpb246IG9mZiBbZml4ZWRdDQp0eC1pcHhpcDYtc2VnbWVudGF0aW9uOiBvZmYg
W2ZpeGVkXQ0KdHgtdWRwX3RubC1zZWdtZW50YXRpb246IG9mZiBbZml4ZWRdDQp0eC11ZHBf
dG5sLWNzdW0tc2VnbWVudGF0aW9uOiBvZmYgW2ZpeGVkXQ0KdHgtZ3NvLXBhcnRpYWw6IG9m
ZiBbZml4ZWRdDQp0eC10dW5uZWwtcmVtY3N1bS1zZWdtZW50YXRpb246IG9mZiBbZml4ZWRd
DQp0eC1zY3RwLXNlZ21lbnRhdGlvbjogb2ZmIFtmaXhlZF0NCnR4LWVzcC1zZWdtZW50YXRp
b246IG9mZiBbZml4ZWRdDQp0eC11ZHAtc2VnbWVudGF0aW9uOiBvZmYgW2ZpeGVkXQ0KdHgt
Z3NvLWxpc3Q6IG9mZiBbZml4ZWRdDQp0eC1ub2NhY2hlLWNvcHk6IG9mZg0KbG9vcGJhY2s6
IG9mZiBbZml4ZWRdDQpyeC1mY3M6IG9mZg0KcngtYWxsOiBvZmYNCnR4LXZsYW4tc3RhZy1o
dy1pbnNlcnQ6IG9mZiBbZml4ZWRdDQpyeC12bGFuLXN0YWctaHctcGFyc2U6IG9mZiBbZml4
ZWRdDQpyeC12bGFuLXN0YWctZmlsdGVyOiBvZmYgW2ZpeGVkXQ0KbDItZndkLW9mZmxvYWQ6
IG9mZiBbZml4ZWRdDQpody10Yy1vZmZsb2FkOiBvZmYgW2ZpeGVkXQ0KZXNwLWh3LW9mZmxv
YWQ6IG9mZiBbZml4ZWRdDQplc3AtdHgtY3N1bS1ody1vZmZsb2FkOiBvZmYgW2ZpeGVkXQ0K
cngtdWRwX3R1bm5lbC1wb3J0LW9mZmxvYWQ6IG9mZiBbZml4ZWRdDQp0bHMtaHctdHgtb2Zm
bG9hZDogb2ZmIFtmaXhlZF0NCnRscy1ody1yeC1vZmZsb2FkOiBvZmYgW2ZpeGVkXQ0Kcngt
Z3JvLWh3OiBvZmYgW2ZpeGVkXQ0KdGxzLWh3LXJlY29yZDogb2ZmIFtmaXhlZF0NCnJ4LWdy
by1saXN0OiBvZmYNCm1hY3NlYy1ody1vZmZsb2FkOiBvZmYgW2ZpeGVkXQ0KcngtdWRwLWdy
by1mb3J3YXJkaW5nOiBvZmYNCmhzci10YWctaW5zLW9mZmxvYWQ6IG9mZiBbZml4ZWRdDQpo
c3ItdGFnLXJtLW9mZmxvYWQ6IG9mZiBbZml4ZWRdDQpoc3ItZndkLW9mZmxvYWQ6IG9mZiBb
Zml4ZWRdDQpoc3ItZHVwLW9mZmxvYWQ6IG9mZiBbZml4ZWRdDQpOSUMgc3RhdGlzdGljczoN
CiAgICAgcnhfcGFja2V0czogNDM4NjI1OQ0KICAgICB0eF9wYWNrZXRzOiA0NjA1OTUxDQog
ICAgIHJ4X2J5dGVzOiA1MzgxOTAwMDE3DQogICAgIHR4X2J5dGVzOiAyMzQ3ODQ3ODMyDQog
ICAgIHJ4X2Jyb2FkY2FzdDogMjM5DQogICAgIHR4X2Jyb2FkY2FzdDogNjQNCiAgICAgcnhf
bXVsdGljYXN0OiAxNTM5DQogICAgIHR4X211bHRpY2FzdDogMjI4DQogICAgIHJ4X2Vycm9y
czogMA0KICAgICB0eF9lcnJvcnM6IDANCiAgICAgdHhfZHJvcHBlZDogMA0KICAgICBtdWx0
aWNhc3Q6IDE1MzkNCiAgICAgY29sbGlzaW9uczogMA0KICAgICByeF9sZW5ndGhfZXJyb3Jz
OiAwDQogICAgIHJ4X292ZXJfZXJyb3JzOiAwDQogICAgIHJ4X2NyY19lcnJvcnM6IDANCiAg
ICAgcnhfZnJhbWVfZXJyb3JzOiAwDQogICAgIHJ4X25vX2J1ZmZlcl9jb3VudDogMA0KICAg
ICByeF9taXNzZWRfZXJyb3JzOiAxNTM5OA0KICAgICB0eF9hYm9ydGVkX2Vycm9yczogMA0K
ICAgICB0eF9jYXJyaWVyX2Vycm9yczogMA0KICAgICB0eF9maWZvX2Vycm9yczogMA0KICAg
ICB0eF9oZWFydGJlYXRfZXJyb3JzOiAwDQogICAgIHR4X3dpbmRvd19lcnJvcnM6IDANCiAg
ICAgdHhfYWJvcnRfbGF0ZV9jb2xsOiAwDQogICAgIHR4X2RlZmVycmVkX29rOiAwDQogICAg
IHR4X3NpbmdsZV9jb2xsX29rOiAwDQogICAgIHR4X211bHRpX2NvbGxfb2s6IDANCiAgICAg
dHhfdGltZW91dF9jb3VudDogMA0KICAgICB0eF9yZXN0YXJ0X3F1ZXVlOiAyMjkNCiAgICAg
cnhfbG9uZ19sZW5ndGhfZXJyb3JzOiAwDQogICAgIHJ4X3Nob3J0X2xlbmd0aF9lcnJvcnM6
IDANCiAgICAgcnhfYWxpZ25fZXJyb3JzOiAwDQogICAgIHR4X3RjcF9zZWdfZ29vZDogNjEy
MTANCiAgICAgdHhfdGNwX3NlZ19mYWlsZWQ6IDANCiAgICAgcnhfZmxvd19jb250cm9sX3hv
bjogMA0KICAgICByeF9mbG93X2NvbnRyb2xfeG9mZjogMA0KICAgICB0eF9mbG93X2NvbnRy
b2xfeG9uOiAwDQogICAgIHR4X2Zsb3dfY29udHJvbF94b2ZmOiAwDQogICAgIHJ4X2NzdW1f
b2ZmbG9hZF9nb29kOiA0MjIzNDM1DQogICAgIHJ4X2NzdW1fb2ZmbG9hZF9lcnJvcnM6IDAN
CiAgICAgcnhfaGVhZGVyX3NwbGl0OiAwDQogICAgIGFsbG9jX3J4X2J1ZmZfZmFpbGVkOiAw
DQogICAgIHR4X3NtYnVzOiAyNjgyNjYNCiAgICAgcnhfc21idXM6IDE2MTYzOA0KICAgICBk
cm9wcGVkX3NtYnVzOiAwDQogICAgIHJ4X2RtYV9mYWlsZWQ6IDANCiAgICAgdHhfZG1hX2Zh
aWxlZDogMA0KICAgICByeF9od3RzdGFtcF9jbGVhcmVkOiAwDQogICAgIHVuY29ycl9lY2Nf
ZXJyb3JzOiAwDQogICAgIGNvcnJfZWNjX2Vycm9yczogMA0KICAgICB0eF9od3RzdGFtcF90
aW1lb3V0czogMA0KICAgICB0eF9od3RzdGFtcF9za2lwcGVkOiAwDQowMDoxZi42IEV0aGVy
bmV0IGNvbnRyb2xsZXIgWzAyMDBdOiBJbnRlbCBDb3Jwb3JhdGlvbiBFdGhlcm5ldCBDb25u
ZWN0aW9uICg3KSBJMjE5LUxNIFs4MDg2OjE1YmJdIChyZXYgMTApDQogICAgICAgIERldmlj
ZU5hbWU6IE9uYm9hcmQgLSBFdGhlcm5ldA0KICAgICAgICBTdWJzeXN0ZW06IEdpZ2FieXRl
IFRlY2hub2xvZ3kgQ28uLCBMdGQgRGV2aWNlIFsxNDU4OmUwMDBdDQogICAgICAgIENvbnRy
b2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3At
IFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgrDQogICAgICAgIFN0
YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5U
QWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0NCiAgICAgICAg
TGF0ZW5jeTogMA0KICAgICAgICBJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTI5
DQogICAgICAgIElPTU1VIGdyb3VwOiAxMQ0KICAgICAgICBSZWdpb24gMDogTWVtb3J5IGF0
IGExMzAwMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTEyOEtdDQogICAg
ICAgIENhcGFiaWxpdGllczogW2M4XSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMw0KICAg
ICAgICAgICAgICAgIEZsYWdzOiBQTUVDbGstIERTSSsgRDEtIEQyLSBBdXhDdXJyZW50PTBt
QSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspDQogICAgICAgICAgICAgICAgU3Rh
dHVzOiBEMCBOb1NvZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MSBQTUUtDQog
ICAgICAgIENhcGFiaWxpdGllczogW2QwXSBNU0k6IEVuYWJsZSsgQ291bnQ9MS8xIE1hc2th
YmxlLSA2NGJpdCsNCiAgICAgICAgICAgICAgICBBZGRyZXNzOiAwMDAwMDAwMGZlZTAwMzE4
ICBEYXRhOiAwMDAwDQogICAgICAgIEtlcm5lbCBkcml2ZXIgaW4gdXNlOiBlMTAwMGUNCiAg
ICAgICAgS2VybmVsIG1vZHVsZXM6IGUxMDAwZQ0KDQpyb290QHZkcHJveDp+IyBqb3VybmFs
Y3RsIC1rIC1iIC0tbm8tcGFnZXIgfCBsZXNzDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtl
cm5lbDogTGludXggdmVyc2lvbiA3LjAuMTQtMTctcHZlIChidWlsZEBwcm94bW94KSAoZ2Nj
IChEZWJpYW4gMTQuMi4wLTE5KSAxNC4yLjAsIEdOVSBsZCAoR05VIEJpbnV0aWxzIGZvciBE
ZWJpYW4pIDIuNDQpICMxIFNNUCBQUkVFTVBUX0RZTkFNSUMgUE1YIDcuMC4xNC0xNyAoMjAy
Ni0wOS0xMFQxMDoxNlopICgpDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5lbDogQ29t
bWFuZCBsaW5lOiBCT09UX0lNQUdFPS9ib290L3ZtbGludXotNy4wLjE0LTE3LXB2ZSByb290
PS9kZXYvbWFwcGVyL3B2ZS1yb290IHJvIHF1aWV0DQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94
IGtlcm5lbDogS0VSTkVMIHN1cHBvcnRlZCBjcHVzOg0KU2VwIDE1IDE4OjU4OjI2IHZkcHJv
eCBrZXJuZWw6ICAgSW50ZWwgR2VudWluZUludGVsDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94
IGtlcm5lbDogICBBTUQgQXV0aGVudGljQU1EDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtl
cm5lbDogICBIeWdvbiBIeWdvbkdlbnVpbmUNClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2Vy
bmVsOiAgIENlbnRhdXIgQ2VudGF1ckhhdWxzDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtl
cm5lbDogICB6aGFveGluICAgU2hhbmdoYWkgIA0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBr
ZXJuZWw6IEJJT1MtcHJvdmlkZWQgcGh5c2ljYWwgUkFNIG1hcDoNClNlcCAxNSAxODo1ODoy
NiB2ZHByb3gga2VybmVsOiBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4
MDAwMDAwMDAwMDA1ZWZmZl0gIFN5c3RlbSBSQU0NClNlcCAxNSAxODo1ODoyNiB2ZHByb3gg
a2VybmVsOiBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMDVmMDAwLTB4MDAwMDAwMDAw
MDA1ZmZmZl0gIGRldmljZSByZXNlcnZlZA0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJu
ZWw6IEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwMDAwNjAwMDAtMHgwMDAwMDAwMDAwMDlm
ZmZmXSAgU3lzdGVtIFJBTQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEJJT1Mt
ZTgyMDogW21lbSAweDAwMDAwMDAwMDAwYTAwMDAtMHgwMDAwMDAwMDAwMGZmZmZmXSAgZGV2
aWNlIHJlc2VydmVkDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5lbDogQklPUy1lODIw
OiBbbWVtIDB4MDAwMDAwMDAwMDEwMDAwMC0weDAwMDAwMDAwODJjM2JmZmZdICBTeXN0ZW0g
UkFNDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5lbDogQklPUy1lODIwOiBbbWVtIDB4
MDAwMDAwMDA4MmMzYzAwMC0weDAwMDAwMDAwODJjM2NmZmZdICBBQ1BJIE5WUw0KU2VwIDE1
IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwODJj
M2QwMDAtMHgwMDAwMDAwMDgyYzNkZmZmXSAgZGV2aWNlIHJlc2VydmVkDQpTZXAgMTUgMTg6
NTg6MjYgdmRwcm94IGtlcm5lbDogQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDA4MmMzZTAw
MC0weDAwMDAwMDAwODgxNjNmZmZdICBTeXN0ZW0gUkFNDQpTZXAgMTUgMTg6NTg6MjYgdmRw
cm94IGtlcm5lbDogQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDA4ODE2NDAwMC0weDAwMDAw
MDAwODhmZTZmZmZdICBkZXZpY2UgcmVzZXJ2ZWQNClNlcCAxNSAxODo1ODoyNiB2ZHByb3gg
a2VybmVsOiBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDg4ZmU3MDAwLTB4MDAwMDAwMDA4
OTA2M2ZmZl0gIEFDUEkgZGF0YQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEJJ
T1MtZTgyMDogW21lbSAweDAwMDAwMDAwODkwNjQwMDAtMHgwMDAwMDAwMDg5NWE2ZmZmXSAg
QUNQSSBOVlMNClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVsOiBCSU9TLWU4MjA6IFtt
ZW0gMHgwMDAwMDAwMDg5NWE3MDAwLTB4MDAwMDAwMDA4OWVmZWZmZl0gIGRldmljZSByZXNl
cnZlZA0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEJJT1MtZTgyMDogW21lbSAw
eDAwMDAwMDAwODllZmYwMDAtMHgwMDAwMDAwMDg5ZWZmZmZmXSAgU3lzdGVtIFJBTQ0KU2Vw
IDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAw
ODlmMDAwMDAtMHgwMDAwMDAwMDhmN2ZmZmZmXSAgZGV2aWNlIHJlc2VydmVkDQpTZXAgMTUg
MTg6NTg6MjYgdmRwcm94IGtlcm5lbDogQklPUy1lODIwOiBbZ2FwIDB4MDAwMDAwMDA4Zjgw
MDAwMC0weDAwMDAwMDAwZGZmZmZmZmZdDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5l
bDogQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBlMDAwMDAwMC0weDAwMDAwMDAwZWZmZmZm
ZmZdICBkZXZpY2UgcmVzZXJ2ZWQNClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVsOiBC
SU9TLWU4MjA6IFtnYXAgMHgwMDAwMDAwMGYwMDAwMDAwLTB4MDAwMDAwMDBmZGZmZmZmZl0N
ClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVsOiBCSU9TLWU4MjA6IFttZW0gMHgwMDAw
MDAwMGZlMDAwMDAwLTB4MDAwMDAwMDBmZTAxMGZmZl0gIGRldmljZSByZXNlcnZlZA0KU2Vw
IDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEJJT1MtZTgyMDogW2dhcCAweDAwMDAwMDAw
ZmUwMTEwMDAtMHgwMDAwMDAwMGZlYmZmZmZmXQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBr
ZXJuZWw6IEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwZmVjMDAwMDAtMHgwMDAwMDAwMGZl
YzAwZmZmXSAgZGV2aWNlIHJlc2VydmVkDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5l
bDogQklPUy1lODIwOiBbZ2FwIDB4MDAwMDAwMDBmZWMwMTAwMC0weDAwMDAwMDAwZmVkZmZm
ZmZdDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5lbDogQklPUy1lODIwOiBbbWVtIDB4
MDAwMDAwMDBmZWUwMDAwMC0weDAwMDAwMDAwZmVlMDBmZmZdICBkZXZpY2UgcmVzZXJ2ZWQN
ClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVsOiBCSU9TLWU4MjA6IFtnYXAgMHgwMDAw
MDAwMGZlZTAxMDAwLTB4MDAwMDAwMDBmZWZmZmZmZl0NClNlcCAxNSAxODo1ODoyNiB2ZHBy
b3gga2VybmVsOiBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGZmMDAwMDAwLTB4MDAwMDAw
MDBmZmZmZmZmZl0gIGRldmljZSByZXNlcnZlZA0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBr
ZXJuZWw6IEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAxMDAwMDAwMDAtMHgwMDAwMDAwYzZj
N2ZmZmZmXSAgU3lzdGVtIFJBTQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IE5Y
IChFeGVjdXRlIERpc2FibGUpIHByb3RlY3Rpb246IGFjdGl2ZQ0KU2VwIDE1IDE4OjU4OjI2
IHZkcHJveCBrZXJuZWw6IEFQSUM6IFN0YXRpYyBjYWxscyBpbml0aWFsaXplZA0KU2VwIDE1
IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IGVmaTogRUZJIHYyLjcgYnkgQW1lcmljYW4gTWVn
YXRyZW5kcw0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IGVmaTogQUNQSSAyLjA9
MHg4OTQ4YzAwMCBBQ1BJPTB4ODk0OGMwMDAgVFBNRmluYWxMb2c9MHg4OTRmMTAwMCBTTUJJ
T1M9MHg4OWM0NDAwMCBTTUJJT1MgMy4wPTB4ODljNDMwMDAgRVNSVD0weDg2MWYzOTE4IE1F
TUFUVFI9MHg4M2VlOTAxOCBNT0t2YXI9MHg4OWM1YzAwMCBJTklUUkQ9MHg4MmQ3MmYxOCBS
Tkc9MHg4OTA2MzAxOCBUUE1FdmVudExvZz0weDg5MDVlMDE4IA0KU2VwIDE1IDE4OjU4OjI2
IHZkcHJveCBrZXJuZWw6IHJhbmRvbTogY3JuZyBpbml0IGRvbmUNClNlcCAxNSAxODo1ODoy
NiB2ZHByb3gga2VybmVsOiBlZmk6IFJlbW92ZSBtZW0zODogTU1JTyByYW5nZT1bMHhlMDAw
MDAwMC0weGVmZmZmZmZmXSAoMjU2TUIpIGZyb20gZTgyMCBtYXANClNlcCAxNSAxODo1ODoy
NiB2ZHByb3gga2VybmVsOiBlODIwOiByZW1vdmUgW21lbSAweGUwMDAwMDAwLTB4ZWZmZmZm
ZmZdIGRldmljZSByZXNlcnZlZA0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IGVm
aTogTm90IHJlbW92aW5nIG1lbTM5OiBNTUlPIHJhbmdlPVsweGZlMDAwMDAwLTB4ZmUwMTBm
ZmZdICg2OEtCKSBmcm9tIGU4MjAgbWFwDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5l
bDogZWZpOiBOb3QgcmVtb3ZpbmcgbWVtNDA6IE1NSU8gcmFuZ2U9WzB4ZmVjMDAwMDAtMHhm
ZWMwMGZmZl0gKDRLQikgZnJvbSBlODIwIG1hcA0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBr
ZXJuZWw6IGVmaTogTm90IHJlbW92aW5nIG1lbTQxOiBNTUlPIHJhbmdlPVsweGZlZTAwMDAw
LTB4ZmVlMDBmZmZdICg0S0IpIGZyb20gZTgyMCBtYXANClNlcCAxNSAxODo1ODoyNiB2ZHBy
b3gga2VybmVsOiBlZmk6IFJlbW92ZSBtZW00MjogTU1JTyByYW5nZT1bMHhmZjAwMDAwMC0w
eGZmZmZmZmZmXSAoMTZNQikgZnJvbSBlODIwIG1hcA0KU2VwIDE1IDE4OjU4OjI2IHZkcHJv
eCBrZXJuZWw6IGU4MjA6IHJlbW92ZSBbbWVtIDB4ZmYwMDAwMDAtMHhmZmZmZmZmZl0gZGV2
aWNlIHJlc2VydmVkDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5lbDogU01CSU9TIDMu
MS4xIHByZXNlbnQuDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5lbDogRE1JOiBHaWdh
Ynl0ZSBUZWNobm9sb2d5IENvLiwgTHRkLiBRMzcwTSBEM0ggR1NNIFBMVVMvUTM3ME0gRDNI
IEdTTSBQTFVTLCBCSU9TIEYxN2EgMDYvMTIvMjAyNQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJv
eCBrZXJuZWw6IERNSTogTWVtb3J5IHNsb3RzIHBvcHVsYXRlZDogNC80DQpTZXAgMTUgMTg6
NTg6MjYgdmRwcm94IGtlcm5lbDogc2VjdXJlYm9vdDogU2VjdXJlIGJvb3QgZGlzYWJsZWQN
ClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVsOiB0c2M6IERldGVjdGVkIDMxMDAuMDAw
IE1IeiBwcm9jZXNzb3INClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVsOiB0c2M6IERl
dGVjdGVkIDMwOTkuOTk5IE1IeiBUU0MNClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVs
OiBlODIwOiB1cGRhdGUgW21lbSAweDAwMDAwMDAwLTB4MDAwMDBmZmZdIFN5c3RlbSBSQU0g
PT0+IGRldmljZSByZXNlcnZlZA0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IGU4
MjA6IHJlbW92ZSBbbWVtIDB4MDAwYTAwMDAtMHgwMDBmZmZmZl0gU3lzdGVtIFJBTQ0KU2Vw
IDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IGxhc3RfcGZuID0gMHhjNmM4MDAgbWF4X2Fy
Y2hfcGZuID0gMHg0MDAwMDAwMDANClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVsOiBN
VFJSIG1hcDogNCBlbnRyaWVzICgzIGZpeGVkICsgMSB2YXJpYWJsZTsgbWF4IDIzKSwgYnVp
bHQgZnJvbSAxMCB2YXJpYWJsZSBNVFJScw0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJu
ZWw6IHg4Ni9QQVQ6IENvbmZpZ3VyYXRpb24gWzAtN106IFdCICBXQyAgVUMtIFVDICBXQiAg
V1AgIFVDLSBXVCAgDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5lbDogbGFzdF9wZm4g
PSAweDg5ZjAwIG1heF9hcmNoX3BmbiA9IDB4NDAwMDAwMDAwDQpTZXAgMTUgMTg6NTg6MjYg
dmRwcm94IGtlcm5lbDogZm91bmQgU01QIE1QLXRhYmxlIGF0IFttZW0gMHgwMDBmY2UzMC0w
eDAwMGZjZTNmXQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IGVzcnQ6IFJlc2Vy
dmluZyBFU1JUIHNwYWNlIGZyb20gMHgwMDAwMDAwMDg2MWYzOTE4IHRvIDB4MDAwMDAwMDA4
NjFmMzk1MC4NClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVsOiBlODIwOiB1cGRhdGUg
W21lbSAweDg2MWYzMDAwLTB4ODYxZjNmZmZdIFN5c3RlbSBSQU0gPT0+IGRldmljZSByZXNl
cnZlZA0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IFVzaW5nIEdCIHBhZ2VzIGZv
ciBkaXJlY3QgbWFwcGluZw0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IHNlY3Vy
ZWJvb3Q6IFNlY3VyZSBib290IGRpc2FibGVkDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtl
cm5lbDogUkFNRElTSzogW21lbSAweDc5OTE5MDAwLTB4N2VjYzFmZmZdDQpTZXAgMTUgMTg6
NTg6MjYgdmRwcm94IGtlcm5lbDogQUNQSTogRWFybHkgdGFibGUgY2hlY2tzdW0gdmVyaWZp
Y2F0aW9uIGRpc2FibGVkDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5lbDogQUNQSTog
UlNEUCAweDAwMDAwMDAwODk0OEMwMDAgMDAwMDI0ICh2MDIgQUxBU0tBKQ0KU2VwIDE1IDE4
OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFhTRFQgMHgwMDAwMDAwMDg5NDhDMEIwIDAw
MDBFNCAodjAxIEFMQVNLQSBBIE0gSSAgICAwMTA3MjAwOSBBTUkgIDAwMDEwMDEzKQ0KU2Vw
IDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IEZBQ1AgMHgwMDAwMDAwMDg5NENB
RDA4IDAwMDExNCAodjA2IEFMQVNLQSBBIE0gSSAgICAwMTA3MjAwOSBBTUkgIDAwMDEwMDEz
KQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IERTRFQgMHgwMDAwMDAw
MDg5NDhDMjMwIDAzRUFENyAodjAyIEFMQVNLQSBBIE0gSSAgICAwMTA3MjAwOSBJTlRMIDIw
MTYwNTI3KQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IEZBQ1MgMHgw
MDAwMDAwMDg5NUE2MDgwIDAwMDA0MA0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6
IEFDUEk6IEFQSUMgMHgwMDAwMDAwMDg5NENBRTIwIDAwMDEyQyAodjA0IEFMQVNLQSBBIE0g
SSAgICAwMTA3MjAwOSBBTUkgIDAwMDEwMDEzKQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBr
ZXJuZWw6IEFDUEk6IEZQRFQgMHgwMDAwMDAwMDg5NENBRjUwIDAwMDA0NCAodjAxIEFMQVNL
QSBBIE0gSSAgICAwMTA3MjAwOSBBTUkgIDAwMDEwMDEzKQ0KU2VwIDE1IDE4OjU4OjI2IHZk
cHJveCBrZXJuZWw6IEFDUEk6IEZJRFQgMHgwMDAwMDAwMDg5NENBRjk4IDAwMDA5QyAodjAx
IEFMQVNLQSBBIE0gSSAgICAwMTA3MjAwOSBBTUkgIDAwMDEwMDEzKQ0KU2VwIDE1IDE4OjU4
OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IE1DRkcgMHgwMDAwMDAwMDg5NENCMDM4IDAwMDAz
QyAodjAxIEFMQVNLQSBBIE0gSSAgICAwMTA3MjAwOSBNU0ZUIDAwMDAwMDk3KQ0KU2VwIDE1
IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFNTRFQgMHgwMDAwMDAwMDg5NENCMDc4
IDAwMDIwNCAodjAxIEFMQVNLQSBBIE0gSSAgICAwMDAwMTAwMCBJTlRMIDIwMTYwNTI3KQ0K
U2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFNTRFQgMHgwMDAwMDAwMDg5
NENCMjgwIDAwMTdENSAodjAyIEFMQVNLQSBBIE0gSSAgICAwMDAwMzAwMCBJTlRMIDIwMTYw
NTI3KQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFNTRFQgMHgwMDAw
MDAwMDg5NENDQTU4IDAwODA4RiAodjAxIEFMQVNLQSBBIE0gSSAgICAwMDAwMDAwMSBJTlRM
IDIwMTYwNTI3KQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFNTRFQg
MHgwMDAwMDAwMDg5NEQ0QUU4IDAwMzFDNyAodjAyIEFMQVNLQSBBIE0gSSAgICAwMDAwMzAw
MCBJTlRMIDIwMTYwNTI3KQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6
IEhQRVQgMHgwMDAwMDAwMDg5NEQ3Q0IwIDAwMDAzOCAodjAxIEFMQVNLQSBBIE0gSSAgICAw
MDAwMDAwMiAgICAgIDAxMDAwMDEzKQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6
IEFDUEk6IFNTRFQgMHgwMDAwMDAwMDg5NEQ3Q0U4IDAwMUJFMSAodjAyIEFMQVNLQSBBIE0g
SSAgICAwMDAwMTAwMCBJTlRMIDIwMTYwNTI3KQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBr
ZXJuZWw6IEFDUEk6IFNTRFQgMHgwMDAwMDAwMDg5NEQ5OEQwIDAwMEY5RSAodjAyIEFMQVNL
QSBBIE0gSSAgICAwMDAwMTAwMCBJTlRMIDIwMTYwNTI3KQ0KU2VwIDE1IDE4OjU4OjI2IHZk
cHJveCBrZXJuZWw6IEFDUEk6IFNTRFQgMHgwMDAwMDAwMDg5NERBODcwIDAwMkQxQiAodjAy
IEFMQVNLQSBBIE0gSSAgICAwMDAwMDAwMCBJTlRMIDIwMTYwNTI3KQ0KU2VwIDE1IDE4OjU4
OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFVFRkkgMHgwMDAwMDAwMDg5NERENTkwIDAwMDA0
MiAodjAxIEFMQVNLQSBBIE0gSSAgICAwMDAwMDAwMiAgICAgIDAxMDAwMDEzKQ0KU2VwIDE1
IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IExQSVQgMHgwMDAwMDAwMDg5NERENUQ4
IDAwMDA1QyAodjAxIEFMQVNLQSBBIE0gSSAgICAwMDAwMDAwMiAgICAgIDAxMDAwMDEzKQ0K
U2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFNTRFQgMHgwMDAwMDAwMDg5
NERENjM4IDAwMjdERSAodjAyIEFMQVNLQSBBIE0gSSAgICAwMDAwMTAwMCBJTlRMIDIwMTYw
NTI3KQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFNTRFQgMHgwMDAw
MDAwMDg5NERGRTE4IDAwMEZGRSAodjAyIEFMQVNLQSBBIE0gSSAgICAwMDAwMDAwMCBJTlRM
IDIwMTYwNTI3KQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IERCR1Ag
MHgwMDAwMDAwMDg5NEUwRTE4IDAwMDAzNCAodjAxIEFMQVNLQSBBIE0gSSAgICAwMDAwMDAw
MiAgICAgIDAxMDAwMDEzKQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6
IERCRzIgMHgwMDAwMDAwMDg5NEUwRTUwIDAwMDA1NCAodjAwIEFMQVNLQSBBIE0gSSAgICAw
MDAwMDAwMiAgICAgIDAxMDAwMDEzKQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6
IEFDUEk6IERNQVIgMHgwMDAwMDAwMDg5NEUwRUE4IDAwMDBBOCAodjAxIEFMQVNLQSBBIE0g
SSAgICAwMDAwMDAwMiAgICAgIDAxMDAwMDEzKQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBr
ZXJuZWw6IEFDUEk6IEJHUlQgMHgwMDAwMDAwMDg5NEUwRjUwIDAwMDAzOCAodjAxIEFMQVNL
QSBBIE0gSSAgICAwMTA3MjAwOSBBTUkgIDAwMDEwMDEzKQ0KU2VwIDE1IDE4OjU4OjI2IHZk
cHJveCBrZXJuZWw6IEFDUEk6IFRQTTIgMHgwMDAwMDAwMDg5NEUwRjg4IDAwMDAzNCAodjA0
IEFMQVNLQSBBIE0gSSAgICAwMDAwMDAwMSBBTUkgIDAwMDAwMDAwKQ0KU2VwIDE1IDE4OjU4
OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IEFTRiEgMHgwMDAwMDAwMDg5NEUwRkMwIDAwMDBB
MCAodjMyIEFMQVNLQSBBIE0gSSAgICAwMDAwMDAwMiAgICAgIDAxMDAwMDEzKQ0KU2VwIDE1
IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFdTTVQgMHgwMDAwMDAwMDg5NEUxMDYw
IDAwMDAyOCAodjAxIEFMQVNLQSBBIE0gSSAgICAwMTA3MjAwOSBBTUkgIDAwMDEwMDEzKQ0K
U2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFJlc2VydmluZyBGQUNQIHRh
YmxlIG1lbW9yeSBhdCBbbWVtIDB4ODk0Y2FkMDgtMHg4OTRjYWUxYl0NClNlcCAxNSAxODo1
ODoyNiB2ZHByb3gga2VybmVsOiBBQ1BJOiBSZXNlcnZpbmcgRFNEVCB0YWJsZSBtZW1vcnkg
YXQgW21lbSAweDg5NDhjMjMwLTB4ODk0Y2FkMDZdDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94
IGtlcm5lbDogQUNQSTogUmVzZXJ2aW5nIEZBQ1MgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg4
OTVhNjA4MC0weDg5NWE2MGJmXQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFD
UEk6IFJlc2VydmluZyBBUElDIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4ODk0Y2FlMjAtMHg4
OTRjYWY0Yl0NClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVsOiBBQ1BJOiBSZXNlcnZp
bmcgRlBEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDg5NGNhZjUwLTB4ODk0Y2FmOTNdDQpT
ZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5lbDogQUNQSTogUmVzZXJ2aW5nIEZJRFQgdGFi
bGUgbWVtb3J5IGF0IFttZW0gMHg4OTRjYWY5OC0weDg5NGNiMDMzXQ0KU2VwIDE1IDE4OjU4
OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFJlc2VydmluZyBNQ0ZHIHRhYmxlIG1lbW9yeSBh
dCBbbWVtIDB4ODk0Y2IwMzgtMHg4OTRjYjA3M10NClNlcCAxNSAxODo1ODoyNiB2ZHByb3gg
a2VybmVsOiBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDg5
NGNiMDc4LTB4ODk0Y2IyN2JdDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5lbDogQUNQ
STogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg4OTRjYjI4MC0weDg5
NGNjYTU0XQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFJlc2Vydmlu
ZyBTU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4ODk0Y2NhNTgtMHg4OTRkNGFlNl0NClNl
cCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVsOiBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJs
ZSBtZW1vcnkgYXQgW21lbSAweDg5NGQ0YWU4LTB4ODk0ZDdjYWVdDQpTZXAgMTUgMTg6NTg6
MjYgdmRwcm94IGtlcm5lbDogQUNQSTogUmVzZXJ2aW5nIEhQRVQgdGFibGUgbWVtb3J5IGF0
IFttZW0gMHg4OTRkN2NiMC0weDg5NGQ3Y2U3XQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBr
ZXJuZWw6IEFDUEk6IFJlc2VydmluZyBTU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4ODk0
ZDdjZTgtMHg4OTRkOThjOF0NClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVsOiBBQ1BJ
OiBSZXNlcnZpbmcgU1NEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDg5NGQ5OGQwLTB4ODk0
ZGE4NmRdDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5lbDogQUNQSTogUmVzZXJ2aW5n
IFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg4OTRkYTg3MC0weDg5NGRkNThhXQ0KU2Vw
IDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFJlc2VydmluZyBVRUZJIHRhYmxl
IG1lbW9yeSBhdCBbbWVtIDB4ODk0ZGQ1OTAtMHg4OTRkZDVkMV0NClNlcCAxNSAxODo1ODoy
NiB2ZHByb3gga2VybmVsOiBBQ1BJOiBSZXNlcnZpbmcgTFBJVCB0YWJsZSBtZW1vcnkgYXQg
W21lbSAweDg5NGRkNWQ4LTB4ODk0ZGQ2MzNdDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtl
cm5lbDogQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg4OTRk
ZDYzOC0weDg5NGRmZTE1XQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6
IFNTRFQgMHgwMDAwMDAwMDg5NEQ0QUU4IDAwMzFDNyAodjAyIEFMQVNLQSBBIE0gSSAgICAw
MDAwMzAwMCBJTlRMIDIwMTYwNTI3KQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6
IEFDUEk6IEhQRVQgMHgwMDAwMDAwMDg5NEQ3Q0IwIDAwMDAzOCAodjAxIEFMQVNLQSBBIE0g
SSAgICAwMDAwMDAwMiAgICAgIDAxMDAwMDEzKQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBr
ZXJuZWw6IEFDUEk6IFNTRFQgMHgwMDAwMDAwMDg5NEQ3Q0U4IDAwMUJFMSAodjAyIEFMQVNL
QSBBIE0gSSAgICAwMDAwMTAwMCBJTlRMIDIwMTYwNTI3KQ0KU2VwIDE1IDE4OjU4OjI2IHZk
cHJveCBrZXJuZWw6IEFDUEk6IFNTRFQgMHgwMDAwMDAwMDg5NEQ5OEQwIDAwMEY5RSAodjAy
IEFMQVNLQSBBIE0gSSAgICAwMDAwMTAwMCBJTlRMIDIwMTYwNTI3KQ0KU2VwIDE1IDE4OjU4
OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFNTRFQgMHgwMDAwMDAwMDg5NERBODcwIDAwMkQx
QiAodjAyIEFMQVNLQSBBIE0gSSAgICAwMDAwMDAwMCBJTlRMIDIwMTYwNTI3KQ0KU2VwIDE1
IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFVFRkkgMHgwMDAwMDAwMDg5NERENTkw
IDAwMDA0MiAodjAxIEFMQVNLQSBBIE0gSSAgICAwMDAwMDAwMiAgICAgIDAxMDAwMDEzKQ0K
U2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IExQSVQgMHgwMDAwMDAwMDg5
NERENUQ4IDAwMDA1QyAodjAxIEFMQVNLQSBBIE0gSSAgICAwMDAwMDAwMiAgICAgIDAxMDAw
MDEzKQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFNTRFQgMHgwMDAw
MDAwMDg5NERENjM4IDAwMjdERSAodjAyIEFMQVNLQSBBIE0gSSAgICAwMDAwMTAwMCBJTlRM
IDIwMTYwNTI3KQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFNTRFQg
MHgwMDAwMDAwMDg5NERGRTE4IDAwMEZGRSAodjAyIEFMQVNLQSBBIE0gSSAgICAwMDAwMDAw
MCBJTlRMIDIwMTYwNTI3KQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6
IERCR1AgMHgwMDAwMDAwMDg5NEUwRTE4IDAwMDAzNCAodjAxIEFMQVNLQSBBIE0gSSAgICAw
MDAwMDAwMiAgICAgIDAxMDAwMDEzKQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6
IEFDUEk6IERCRzIgMHgwMDAwMDAwMDg5NEUwRTUwIDAwMDA1NCAodjAwIEFMQVNLQSBBIE0g
SSAgICAwMDAwMDAwMiAgICAgIDAxMDAwMDEzKQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBr
ZXJuZWw6IEFDUEk6IERNQVIgMHgwMDAwMDAwMDg5NEUwRUE4IDAwMDBBOCAodjAxIEFMQVNL
QSBBIE0gSSAgICAwMDAwMDAwMiAgICAgIDAxMDAwMDEzKQ0KU2VwIDE1IDE4OjU4OjI2IHZk
cHJveCBrZXJuZWw6IEFDUEk6IEJHUlQgMHgwMDAwMDAwMDg5NEUwRjUwIDAwMDAzOCAodjAx
IEFMQVNLQSBBIE0gSSAgICAwMTA3MjAwOSBBTUkgIDAwMDEwMDEzKQ0KU2VwIDE1IDE4OjU4
OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFRQTTIgMHgwMDAwMDAwMDg5NEUwRjg4IDAwMDAz
NCAodjA0IEFMQVNLQSBBIE0gSSAgICAwMDAwMDAwMSBBTUkgIDAwMDAwMDAwKQ0KU2VwIDE1
IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IEFTRiEgMHgwMDAwMDAwMDg5NEUwRkMw
IDAwMDBBMCAodjMyIEFMQVNLQSBBIE0gSSAgICAwMDAwMDAwMiAgICAgIDAxMDAwMDEzKQ0K
U2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFdTTVQgMHgwMDAwMDAwMDg5
NEUxMDYwIDAwMDAyOCAodjAxIEFMQVNLQSBBIE0gSSAgICAwMTA3MjAwOSBBTUkgIDAwMDEw
MDEzKQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFJlc2VydmluZyBG
QUNQIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4ODk0Y2FkMDgtMHg4OTRjYWUxYl0NClNlcCAx
NSAxODo1ODoyNiB2ZHByb3gga2VybmVsOiBBQ1BJOiBSZXNlcnZpbmcgRFNEVCB0YWJsZSBt
ZW1vcnkgYXQgW21lbSAweDg5NDhjMjMwLTB4ODk0Y2FkMDZdDQpTZXAgMTUgMTg6NTg6MjYg
dmRwcm94IGtlcm5lbDogQUNQSTogUmVzZXJ2aW5nIEZBQ1MgdGFibGUgbWVtb3J5IGF0IFtt
ZW0gMHg4OTVhNjA4MC0weDg5NWE2MGJmXQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJu
ZWw6IEFDUEk6IFJlc2VydmluZyBBUElDIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4ODk0Y2Fl
MjAtMHg4OTRjYWY0Yl0NClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVsOiBBQ1BJOiBS
ZXNlcnZpbmcgRlBEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDg5NGNhZjUwLTB4ODk0Y2Fm
OTNdDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5lbDogQUNQSTogUmVzZXJ2aW5nIEZJ
RFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg4OTRjYWY5OC0weDg5NGNiMDMzXQ0KU2VwIDE1
IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFJlc2VydmluZyBNQ0ZHIHRhYmxlIG1l
bW9yeSBhdCBbbWVtIDB4ODk0Y2IwMzgtMHg4OTRjYjA3M10NClNlcCAxNSAxODo1ODoyNiB2
ZHByb3gga2VybmVsOiBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJsZSBtZW1vcnkgYXQgW21l
bSAweDg5NGNiMDc4LTB4ODk0Y2IyN2JdDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5l
bDogQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg4OTRjYjI4
MC0weDg5NGNjYTU0XQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFJl
c2VydmluZyBTU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4ODk0Y2NhNTgtMHg4OTRkNGFl
Nl0NClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVsOiBBQ1BJOiBSZXNlcnZpbmcgU1NE
VCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDg5NGQ0YWU4LTB4ODk0ZDdjYWVdDQpTZXAgMTUg
MTg6NTg6MjYgdmRwcm94IGtlcm5lbDogQUNQSTogUmVzZXJ2aW5nIEhQRVQgdGFibGUgbWVt
b3J5IGF0IFttZW0gMHg4OTRkN2NiMC0weDg5NGQ3Y2U3XQ0KU2VwIDE1IDE4OjU4OjI2IHZk
cHJveCBrZXJuZWw6IEFDUEk6IFJlc2VydmluZyBTU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVt
IDB4ODk0ZDdjZTgtMHg4OTRkOThjOF0NClNlcCAxNSAxODo1ODoyNiB2ZHByb3gga2VybmVs
OiBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDg5NGQ5OGQw
LTB4ODk0ZGE4NmRdDQpTZXAgMTUgMTg6NTg6MjYgdmRwcm94IGtlcm5lbDogQUNQSTogUmVz
ZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg4OTRkYTg3MC0weDg5NGRkNThh
XQ0KU2VwIDE1IDE4OjU4OjI2IHZkcHJveCBrZXJuZWw6IEFDUEk6IFJlc2VydmluZyBVRUZJ
IHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4ODk0ZGQ1OTAtMHg4OTRkZDVkMV0NClNlcCAxNSAx
ODo1ODoyNiB2ZHByb3gga2VybmVsOiBBQ1BJOiBSZXNlcnZpbmcgTFBJVCB0YWJsZSBtZW1v
cnkgYXQgW21lbSAweDg5NGRkNWQ4LTB4ODk0ZGQ2MzNdDQpTZXAgMTUgMTg6NTg6MjYgdmRw
cm94IGtlcm5lbDogQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0g
MHg4OTRkZDYzOC0weDg5NGRmZTE1XQ0KDQoNClNlcCAxNSAxODo1ODoyOCB2ZHByb3gga2Vy
bmVsOiBlMTAwMGUgMDAwMDowMDoxZi42IG5pYzA6IGVudGVyZWQgYWxsbXVsdGljYXN0IG1v
ZGUNClNlcCAxNSAxODo1ODoyOCB2ZHByb3gga2VybmVsOiBlMTAwMGUgMDAwMDowMDoxZi42
IG5pYzA6IGVudGVyZWQgcHJvbWlzY3VvdXMgbW9kZQ0KU2VwIDE1IDE4OjU4OjI4IHZkcHJv
eCBrZXJuZWw6IHNvZnRkb2c6IGluaXRpYWxpemVkLiBzb2Z0X25vYm9vdD0wIHNvZnRfbWFy
Z2luPTYwIHNlYyBzb2Z0X3BhbmljPTAgKG5vd2F5b3V0PTApDQpTZXAgMTUgMTg6NTg6Mjgg
dmRwcm94IGtlcm5lbDogc29mdGRvZzogICAgICAgICAgICAgIHNvZnRfcmVib290X2NtZD08
bm90IHNldD4gc29mdF9hY3RpdmVfb25fYm9vdD0wDQpTZXAgMTUgMTg6NTg6MjggdmRwcm94
IGtlcm5lbDogUlBDOiBSZWdpc3RlcmVkIG5hbWVkIFVOSVggc29ja2V0IHRyYW5zcG9ydCBt
b2R1bGUuDQpTZXAgMTUgMTg6NTg6MjggdmRwcm94IGtlcm5lbDogUlBDOiBSZWdpc3RlcmVk
IHVkcCB0cmFuc3BvcnQgbW9kdWxlLg0KU2VwIDE1IDE4OjU4OjI4IHZkcHJveCBrZXJuZWw6
IFJQQzogUmVnaXN0ZXJlZCB0Y3AgdHJhbnNwb3J0IG1vZHVsZS4NClNlcCAxNSAxODo1ODoy
OCB2ZHByb3gga2VybmVsOiBSUEM6IFJlZ2lzdGVyZWQgdGNwLXdpdGgtdGxzIHRyYW5zcG9y
dCBtb2R1bGUuDQpTZXAgMTUgMTg6NTg6MjggdmRwcm94IGtlcm5lbDogUlBDOiBSZWdpc3Rl
cmVkIHRjcCBORlN2NC4xIGJhY2tjaGFubmVsIHRyYW5zcG9ydCBtb2R1bGUuDQpTZXAgMTUg
MTg6NTg6MjggdmRwcm94IGtlcm5lbDogbnZtZSBudm1lMDogdXNpbmcgdW5jaGVja2VkIGRh
dGEgYnVmZmVyDQpTZXAgMTUgMTg6NTg6MzEgdmRwcm94IGtlcm5lbDogZTEwMDBlIDAwMDA6
MDA6MWYuNiBuaWMwOiBOSUMgTGluayBpcyBVcCAxMDAwIE1icHMgRnVsbCBEdXBsZXgsIEZs
b3cgQ29udHJvbDogTm9uZQ0KU2VwIDE1IDE4OjU4OjMxIHZkcHJveCBrZXJuZWw6IHZtYnIw
OiBwb3J0IDEobmljMCkgZW50ZXJlZCBibG9ja2luZyBzdGF0ZQ0KU2VwIDE1IDE4OjU4OjMx
IHZkcHJveCBrZXJuZWw6IHZtYnIwOiBwb3J0IDEobmljMCkgZW50ZXJlZCBmb3J3YXJkaW5n
IHN0YXRlDQpTZXAgMTUgMTk6MDQ6MDQgdmRwcm94IGtlcm5lbDogdGFwMTAwaTA6IGVudGVy
ZWQgcHJvbWlzY3VvdXMgbW9kZQ0KU2VwIDE1IDE5OjA0OjA0IHZkcHJveCBrZXJuZWw6IHZt
YnIwOiBwb3J0IDIoZndwcjEwMHAwKSBlbnRlcmVkIGJsb2NraW5nIHN0YXRlDQpTZXAgMTUg
MTk6MDQ6MDQgdmRwcm94IGtlcm5lbDogdm1icjA6IHBvcnQgMihmd3ByMTAwcDApIGVudGVy
ZWQgZGlzYWJsZWQgc3RhdGUNClNlcCAxNSAxOTowNDowNCB2ZHByb3gga2VybmVsOiBmd3By
MTAwcDA6IGVudGVyZWQgYWxsbXVsdGljYXN0IG1vZGUNClNlcCAxNSAxOTowNDowNCB2ZHBy
b3gga2VybmVsOiBmd3ByMTAwcDA6IGVudGVyZWQgcHJvbWlzY3VvdXMgbW9kZQ0KU2VwIDE1
IDE5OjA0OjA0IHZkcHJveCBrZXJuZWw6IHZtYnIwOiBwb3J0IDIoZndwcjEwMHAwKSBlbnRl
cmVkIGJsb2NraW5nIHN0YXRlDQpTZXAgMTUgMTk6MDQ6MDQgdmRwcm94IGtlcm5lbDogdm1i
cjA6IHBvcnQgMihmd3ByMTAwcDApIGVudGVyZWQgZm9yd2FyZGluZyBzdGF0ZQ0KU2VwIDE1
IDE5OjA0OjA0IHZkcHJveCBrZXJuZWw6IGZ3YnIxMDBpMDogcG9ydCAxKGZ3bG4xMDBpMCkg
ZW50ZXJlZCBibG9ja2luZyBzdGF0ZQ0KU2VwIDE1IDE5OjA0OjA0IHZkcHJveCBrZXJuZWw6
IGZ3YnIxMDBpMDogcG9ydCAxKGZ3bG4xMDBpMCkgZW50ZXJlZCBkaXNhYmxlZCBzdGF0ZQ0K
U2VwIDE1IDE5OjA0OjA0IHZkcHJveCBrZXJuZWw6IGZ3bG4xMDBpMDogZW50ZXJlZCBhbGxt
dWx0aWNhc3QgbW9kZQ0KU2VwIDE1IDE5OjA0OjA0IHZkcHJveCBrZXJuZWw6IGZ3bG4xMDBp
MDogZW50ZXJlZCBwcm9taXNjdW91cyBtb2RlDQpTZXAgMTUgMTk6MDQ6MDQgdmRwcm94IGtl
cm5lbDogZndicjEwMGkwOiBwb3J0IDEoZndsbjEwMGkwKSBlbnRlcmVkIGJsb2NraW5nIHN0
YXRlDQpTZXAgMTUgMTk6MDQ6MDQgdmRwcm94IGtlcm5lbDogZndicjEwMGkwOiBwb3J0IDEo
ZndsbjEwMGkwKSBlbnRlcmVkIGZvcndhcmRpbmcgc3RhdGUNClNlcCAxNSAxOTowNDowNCB2
ZHByb3gga2VybmVsOiBmd2JyMTAwaTA6IHBvcnQgMih0YXAxMDBpMCkgZW50ZXJlZCBibG9j
a2luZyBzdGF0ZQ0KU2VwIDE1IDE5OjA0OjA0IHZkcHJveCBrZXJuZWw6IGZ3YnIxMDBpMDog
cG9ydCAyKHRhcDEwMGkwKSBlbnRlcmVkIGRpc2FibGVkIHN0YXRlDQpTZXAgMTUgMTk6MDQ6
MDQgdmRwcm94IGtlcm5lbDogdGFwMTAwaTA6IGVudGVyZWQgYWxsbXVsdGljYXN0IG1vZGUN
ClNlcCAxNSAxOTowNDowNCB2ZHByb3gga2VybmVsOiBmd2JyMTAwaTA6IHBvcnQgMih0YXAx
MDBpMCkgZW50ZXJlZCBibG9ja2luZyBzdGF0ZQ0KU2VwIDE1IDE5OjA0OjA0IHZkcHJveCBr
ZXJuZWw6IGZ3YnIxMDBpMDogcG9ydCAyKHRhcDEwMGkwKSBlbnRlcmVkIGZvcndhcmRpbmcg
c3RhdGUNClNlcCAxNSAxOTowNjoyMCB2ZHByb3gga2VybmVsOiBlMTAwMGUgMDAwMDowMDox
Zi42IG5pYzA6IERldGVjdGVkIEhhcmR3YXJlIFVuaXQgSGFuZzoNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFRESCAgICAgICAgICAgICAgICAgIDw2OD4NCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFREVCAgICAgICAgICAgICAgICAgIDxiNz4NCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5leHRfdG9fdXNlICAgICAgICAgIDxi
Nz4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5leHRfdG9fY2xlYW4gICAg
ICAgIDw2Nz4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidWZmZXJfaW5mb1tu
ZXh0X3RvX2NsZWFuXToNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRpbWVf
c3RhbXAgICAgICAgICAgIDwxMDAwMmI3ZjM+DQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBuZXh0X3RvX3dhdGNoICAgICAgICA8Njg+DQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBqaWZmaWVzICAgICAgICAgICAgICA8MTAwMDJiZTAwPg0KDQoNCg0K
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUEhZIDEwMDBCQVNFLVQgU3RhdHVz
ICA8N2MwMD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQSFkgRXh0ZW5kZWQg
U3RhdHVzICAgIDwzMDAwPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBDSSBT
dGF0dXMgICAgICAgICAgICAgPDEwPg0KU2VwIDE1IDIzOjAwOjAyIHZkcHJveCBrZXJuZWw6
IGUxMDAwZSAwMDAwOjAwOjFmLjYgbmljMDogRGV0ZWN0ZWQgSGFyZHdhcmUgVW5pdCBIYW5n
Og0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVERIICAgICAgICAgICAgICAg
ICAgPDY4Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVERUICAgICAgICAg
ICAgICAgICAgPGI3Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbmV4dF90
b191c2UgICAgICAgICAgPGI3Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bmV4dF90b19jbGVhbiAgICAgICAgPDY3Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJ1ZmZlcl9pbmZvW25leHRfdG9fY2xlYW5dOg0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdGltZV9zdGFtcCAgICAgICAgICAgPDEwMDAyYjdmMz4NCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG5leHRfdG9fd2F0Y2ggICAgICAgIDw2OD4NCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGppZmZpZXMgICAgICAgICAgICAgIDwx
MDBkOGIzODA+DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZXh0X3RvX3dh
dGNoLnN0YXR1cyA8MD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNQUMgU3Rh
dHVzICAgICAgICAgICAgIDw4MDA4Mz4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBQSFkgU3RhdHVzICAgICAgICAgICAgIDw3OTZkPg0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFBIWSAxMDAwQkFTRS1UIFN0YXR1cyAgPDdjMDA+DQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgUEhZIEV4dGVuZGVkIFN0YXR1cyAgICA8MzAwMD4NCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBQQ0kgU3RhdHVzICAgICAgICAgICAgIDwxMD4N
ClNlcCAxNSAyMzowMDowNCB2ZHByb3gga2VybmVsOiBlMTAwMGUgMDAwMDowMDoxZi42IG5p
YzA6IERldGVjdGVkIEhhcmR3YXJlIFVuaXQgSGFuZzoNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFRESCAgICAgICAgICAgICAgICAgIDw2OD4NCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFREVCAgICAgICAgICAgICAgICAgIDxiNz4NCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG5leHRfdG9fdXNlICAgICAgICAgIDxiNz4NCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5leHRfdG9fY2xlYW4gICAgICAgIDw2
Nz4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidWZmZXJfaW5mb1tuZXh0X3Rv
X2NsZWFuXToNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRpbWVfc3RhbXAg
ICAgICAgICAgIDwxMDAwMmI3ZjM+DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBuZXh0X3RvX3dhdGNoICAgICAgICA8Njg+DQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBqaWZmaWVzICAgICAgICAgICAgICA8MTAwZDhiYjQwPg0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbmV4dF90b193YXRjaC5zdGF0dXMgPDA+DQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTUFDIFN0YXR1cyAgICAgICAgICAgICA8ODAwODM+
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUEhZIFN0YXR1cyAgICAgICAgICAg
ICA8Nzk2ZD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQSFkgMTAwMEJBU0Ut
VCBTdGF0dXMgIDw3YzAwPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBIWSBF
eHRlbmRlZCBTdGF0dXMgICAgPDMwMDA+DQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgUENJIFN0YXR1cyAgICAgICAgICAgICA8MTA+DQpTZXAgMTUgMjM6MDA6MDUgdmRwcm94
IGtlcm5lbDogZTEwMDBlIDAwMDA6MDA6MWYuNiBuaWMwOiBOSUMgTGluayBpcyBEb3duDQpT
ZXAgMTUgMjM6MDA6MDUgdmRwcm94IGtlcm5lbDogdm1icjA6IHBvcnQgMShuaWMwKSBlbnRl
cmVkIGRpc2FibGVkIHN0YXRlDQpTZXAgMTUgMjM6MDA6MjkgdmRwcm94IGtlcm5lbDogZTEw
MDBlIDAwMDA6MDA6MWYuNiBuaWMwOiBOSUMgTGluayBpcyBVcCAxMDAwIE1icHMgRnVsbCBE
dXBsZXgsIEZsb3cgQ29udHJvbDogTm9uZQ0KU2VwIDE1IDIzOjAwOjI5IHZkcHJveCBrZXJu
ZWw6IHZtYnIwOiBwb3J0IDEobmljMCkgZW50ZXJlZCBibG9ja2luZyBzdGF0ZQ0KU2VwIDE1
IDIzOjAwOjI5IHZkcHJveCBrZXJuZWw6IHZtYnIwOiBwb3J0IDEobmljMCkgZW50ZXJlZCBm
b3J3YXJkaW5nIHN0YXRlDQpTZXAgMTUgMjM6MDA6NDQgdmRwcm94IGtlcm5lbDogdm1icjA6
IHRoZSBoYXNoX2VsYXN0aWNpdHkgb3B0aW9uIGhhcyBiZWVuIGRlcHJlY2F0ZWQgYW5kIGlz
IGFsd2F5cyAxNg0KU2VwIDE1IDIzOjEyOjM3IHZkcHJveCBrZXJuZWw6IHZtYnIwOiB0aGUg
aGFzaF9lbGFzdGljaXR5IG9wdGlvbiBoYXMgYmVlbiBkZXByZWNhdGVkIGFuZCBpcyBhbHdh
eXMgMTY=

--------------BgV5HUUsbU3tOtBmZAMYkB7N--
