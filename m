From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 09 Jun 2021 16:07:20 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v5 3/4] igc: Enable PCIe PTM
In-Reply-To: <d8740484-3879-1c13-65ce-82d3e71cb96c@molgen.mpg.de>
References: <20210605002356.3996853-1-vinicius.gomes@intel.com>
 <20210605002356.3996853-4-vinicius.gomes@intel.com>
 <70d32740-eb4b-f7bf-146e-8dc06199d6c9@molgen.mpg.de>
 <87sg1sw56h.fsf@vcostago-mobl2.amr.corp.intel.com>
 <939b8042-a313-47db-43d9-ea37e95b724b@molgen.mpg.de>
 <87r1havm15.fsf@vcostago-mobl2.amr.corp.intel.com>
 <d8740484-3879-1c13-65ce-82d3e71cb96c@molgen.mpg.de>
Message-ID: <87k0n2vdqv.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Paul,

>> 
>>> Regarding my comment, I did not mean returning an error but the log
>>> *level* of the message. So, `dmesg --level err` would show that message.
>>> But if there are PCI controllers not supporting that, it?s not an error,
>>> but a warning at most. So, I?d use:
>>>
>>> 	dev_warn(&pdev->dev, "PTM not supported by PCI bus/controller
>>> (pci_enable_ptm() failed)\n");
>> 
>> I will use you suggestion for the message, but I think that warn is a
>> bit too much, info or notice seem to be better.
>
> I do not know, if modern PCI(e)(?) controllers normally support PTM or 
> not. If recent controllers should support it, then a warning would be 
> warranted, otherwise a notice.
>

From the Intel side, it seems that it's been supported for a few years.
So, fair enough, let's go with a warn.


Cheers,
-- 
Vinicius
