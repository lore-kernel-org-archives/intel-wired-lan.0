From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Mon, 22 Jul 2019 14:34:44 +0000
Subject: [Intel-wired-lan] How to update firmware?
In-Reply-To: <14c67f8e-b345-4aae-169f-4b7c9eba5d89@molgen.mpg.de>
References: <f16c92b9-61bf-6ea8-afc9-28e778c2b625@molgen.mpg.de>
 <9B4A1B1917080E46B64F07F2989DADD69AFF0A1B@ORSMSX115.amr.corp.intel.com>
 <14c67f8e-b345-4aae-169f-4b7c9eba5d89@molgen.mpg.de>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD69AFF1015@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If it's a Dell adapter, the answer is you have to ask Dell for updates.

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com


-----Original Message-----
From: Paul Menzel [mailto:pmenzel at molgen.mpg.de] 
Sent: Saturday, July 20, 2019 4:11 PM
To: Fujinaka, Todd <todd.fujinaka@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] How to update firmware?

Dear Todd,


Thank you for your answer. Please find my answers below (interleaved style).


On 20.07.19 18:11, Fujinaka, Todd wrote:
> What part? The 1G parts didn't have much firmware (only one had a
> little) and some of the 10G parts didn't, either.

Sorry, I do not understand. There is a firmware line in the output of `ethtool` and it was indeed updated to 18.8.9 by runnig the
(proprietary) Dell update pragram.

> We don't release the source to the firmware updater and there might 
> not be an update for you anyway.

As written, Dell offers an update.

So, why don?t you release the source for the firmware updater under a free licence? We really like to audit all the programs, we run, and review (by ourselves or others) them.

So main goal would be to have just one update interface, for example `fwupdmgr`, to only deal with one tool. And Intel would have one place to upload the firmware update files to (with security issues addressed like signatures, and good release practices like release notes and so on).


Kind regards,

Paul
