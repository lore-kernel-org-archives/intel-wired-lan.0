From: Avivi, Amir <amir.avivi@intel.com>
Date: Tue, 2 Jun 2020 10:13:00 +0300
Subject: [Intel-wired-lan] Intel-wired-lan Digest, Vol 268, Issue 43,
 Replay to message number 6,
 Test hints request for e1000e: Relax condition to trigger reset for ME
 workaround patch
In-Reply-To: <mailman.9577.1590117676.59095.intel-wired-lan@osuosl.org>
References: <mailman.9577.1590117676.59095.intel-wired-lan@osuosl.org>
Message-ID: <7cdf1300-973e-6950-8146-d0481661b98b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

------------------------------
> Message: 6 Date: Fri, 22 May 2020 12:20:57 +0900 From: Punit Agrawal 
> <punit1.agrawal@toshiba.co.jp> To: "Brown\, Aaron F" 
> <aaron.f.brown@intel.com> Cc: "Kirsher\, Jeffrey T" 
> <jeffrey.t.kirsher@intel.com>, "daniel.sangorrin\@toshiba.co.jp" 
> <daniel.sangorrin@toshiba.co.jp>, Alexander Duyck 
> <alexander.h.duyck@linux.intel.com>, "David S. Miller" 
> <davem@davemloft.net>, "intel-wired-lan\@lists.osuosl.org" 
> <intel-wired-lan@lists.osuosl.org>, "netdev\@vger.kernel.org" 
> <netdev@vger.kernel.org>, "linux-kernel\@vger.kernel.org" 
> <linux-kernel@vger.kernel.org> Subject: Re: [Intel-wired-lan] [PATCH] 
> e1000e: Relax condition to trigger reset for ME workaround Message-ID: 
> <87367sac4m.fsf@kokedama.swc.toshiba.co.jp> Content-Type: text/plain 
> Hi Aaron, "Brown, Aaron F" <aaron.f.brown@intel.com> writes:
>>> From:netdev-owner at vger.kernel.org  <netdev-owner@vger.kernel.org>  On
>>> Behalf Of Punit Agrawal
>>> Sent: Thursday, May 14, 2020 9:31 PM
>>> To: Kirsher, Jeffrey T<jeffrey.t.kirsher@intel.com>
>>> Cc:daniel.sangorrin at toshiba.co.jp; Punit Agrawal
>>> <punit1.agrawal@toshiba.co.jp>; Alexander Duyck
>>> <alexander.h.duyck@linux.intel.com>; David S. Miller<davem@davemloft.net>;
>>> intel-wired-lan at lists.osuosl.org;netdev at vger.kernel.org; linux-
>>> kernel at vger.kernel.org
>>> Subject: [PATCH] e1000e: Relax condition to trigger reset for ME workaround
>>>
>>> It's an error if the value of the RX/TX tail descriptor does not match
>>> what was written. The error condition is true regardless the duration
>>> of the interference from ME. But the driver only performs the reset if
>>> E1000_ICH_FWSM_PCIM2PCI_COUNT (2000) iterations of 50us delay have
>>> transpired. The extra condition can lead to inconsistency between the
>>> state of hardware as expected by the driver.
>>>
>>> Fix this by dropping the check for number of delay iterations.
>>>
>>> While at it, also make __ew32_prepare() static as it's not used
>>> anywhere else.
>>>
>>> Signed-off-by: Punit Agrawal<punit1.agrawal@toshiba.co.jp>
>>> Reviewed-by: Alexander Duyck<alexander.h.duyck@linux.intel.com>
>>> Cc: Jeff Kirsher<jeffrey.t.kirsher@intel.com>
>>> Cc: "David S. Miller"<davem@davemloft.net>
>>> Cc:intel-wired-lan at lists.osuosl.org
>>> Cc:netdev at vger.kernel.org
>>> Cc:linux-kernel at vger.kernel.org
>>> ---
>>> Hi Jeff,
>>>
>>> If there are no further comments please consider merging the patch.
>>>
>>> Also, should it be marked for backport to stable?
>>>
>>> Thanks,
>>> Punit
>>>
>>> RFC[0] -> v1:
>>> * Dropped return value for __ew32_prepare() as it's not used
>>> * Made __ew32_prepare() static
>>> * Added tags
>>>
>>> [0]https://lkml.org/lkml/2020/5/12/20
>>>
>>>   drivers/net/ethernet/intel/e1000e/e1000.h  |  1 -
>>>   drivers/net/ethernet/intel/e1000e/netdev.c | 12 +++++-------
>>>   2 files changed, 5 insertions(+), 8 deletions(-)
>>>
>> Tested-by: Aaron Brown<aaron.f.brown@intel.com>
> Thanks for taking the patch for a spin.
>
> Jeff, let me know if you're okay to apply the tag or want me to send a
> new version.
Hi Punit,
This patch appears to be effecting some legacy code effecting old hardware.
We tried applying it but we could not get the driver to run the changed 
code lines.
Please provide some test hints(What platforms did you check it on? What 
tests did you run?) regarding this patch.
Thanks,
Amir
> Thanks,
> Punit
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200602/a9ae9bdf/attachment.html>
