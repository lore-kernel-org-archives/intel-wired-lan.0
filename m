From: Aaron Sierra <asierra@xes-inc.com>
Date: Fri, 2 Dec 2016 14:46:30 -0600 (CST)
Subject: [Intel-wired-lan] [PATCH] igb: reset the PHY before reading the
	PHY ID
In-Reply-To: <CO2PR0801MB6475BDA6E8A945DEC51B1B1AE8F0@CO2PR0801MB647.namprd08.prod.outlook.com>
References: <1589605144.308560.1480435436440.JavaMail.zimbra@xes-inc.com>
 <20161201031318.GA6368@outlook.office365.com>
 <1279201741.206062.1480609194012.JavaMail.zimbra@xes-inc.com>
 <CO2PR0801MB6475BDA6E8A945DEC51B1B1AE8F0@CO2PR0801MB647.namprd08.prod.outlook.com>
Message-ID: <1327348432.729242.1480711590904.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

----- Original Message -----
> From: "Chris Arges" <carges@vectranetworks.com>
> Sent: Thursday, December 1, 2016 5:17:52 PM

>> ________________________________________
>> From: Aaron Sierra <asierra@xes-inc.com>
>> Sent: Thursday, December 1, 2016 10:19 AM
>> To: Chris Arges
>> Cc: Jeffrey T Kirsher; Matwey V. Kornilov; Jochen Henneberg; intel-wired-lan
>> Subject: Re: [PATCH] igb: reset the PHY before reading the PHY ID
>> 
>> Chris,
>> Can you provide any more information about your environment than you
>> already have? I've only found that you're using an I210. Is it embedded
>> in the baseboard or an add-in device? Please share very verbose lspci
>> output for this device:
>> 
>>    lspci -vvv -n -s <[bus]:[device].[function]>
>> 
>> What kernel version did you use in your testing? Did my patch apply
>> cleanly or with "fuzz" reported by the patch command?
>> 
>> -Aaron S.
> 
> Aaron,
> I applied your patch cleanly against 4.4 (testing this on Ubuntu 16.04 fwiw)
> which I think didn't backport well. Using mainline 4.9rcX I was able to get
> your patch working. Would there be a recommended modification for a stable
> patch?
> 
> For completeness,
> $ lspci -vvv -n -s 07:00.0
> 07:00.0 0200: 8086:1533 (rev 03)
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
>	SERR- FastB2B- DisINTx+
>	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
>	>SERR- <PERR- INTx-
>	Latency: 0, Cache Line Size: 128 bytes
>	Interrupt: pin A routed to IRQ 16
>	Region 0: Memory at 91200000 (32-bit, non-prefetchable) [size=512K]
>	Region 2: I/O ports at 3000 [size=32]
>	Region 3: Memory at 91280000 (32-bit, non-prefetchable) [size=16K]
>	Capabilities: <access denied>
>	Kernel driver in use: igb
>	Kernel modules: igb
> 

Chris,
Thanks for double-checking. You've got a copper NIC and I'm testing with a
"flashless copper" NIC (8086:157b).

The patch that caused things to break for you doesn't seem to be in linux-stable's
linux-4.4.y branch, so this patch shouldn't be needed there. Though it does apply
cleanly like you said.

I did another sanity check against linux-4.5.y and found that this patch applies
cleanly there and also still solves the problem for me.

-Aaron S.
