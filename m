From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 09 Jun 2021 17:04:09 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v5 3/4] igc: Enable PCIe PTM
In-Reply-To: <20210609232034.GA2681266@bjorn-Precision-5520>
References: <20210609232034.GA2681266@bjorn-Precision-5520>
Message-ID: <87eedavb46.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Wed, Jun 09, 2021 at 04:07:20PM -0700, Vinicius Costa Gomes wrote:
>> Hi Paul,
>> 
>> >> 
>> >>> Regarding my comment, I did not mean returning an error but the log
>> >>> *level* of the message. So, `dmesg --level err` would show that message.
>> >>> But if there are PCI controllers not supporting that, it?s not an error,
>> >>> but a warning at most. So, I?d use:
>> >>>
>> >>> 	dev_warn(&pdev->dev, "PTM not supported by PCI bus/controller
>> >>> (pci_enable_ptm() failed)\n");
>> >> 
>> >> I will use you suggestion for the message, but I think that warn is a
>> >> bit too much, info or notice seem to be better.
>> >
>> > I do not know, if modern PCI(e)(?) controllers normally support PTM or 
>> > not. If recent controllers should support it, then a warning would be 
>> > warranted, otherwise a notice.
>> 
>> From the Intel side, it seems that it's been supported for a few years.
>> So, fair enough, let's go with a warn.
>
> I'm not sure about this.  I think "warning" messages interrupt distro
> graphical boot scenarios and cause user complaints.  In this case,
> there is nothing broken and the user can do nothing about it; it's
> merely a piece of missing optional functionality.  So I think "info"
> is a more appropriate level.

Good point. "info" it is, then. 


Cheers,
-- 
Vinicius
