From: Nambiar, Amritha <amritha.nambiar@intel.com>
Date: Wed, 26 Jul 2017 11:18:30 -0700
Subject: [Intel-wired-lan] [PATCH 0/4] Configuring traffic classes via
 new hardware offload mechanism in tc/mqprio
In-Reply-To: <20170721094244.nkkmvb7fvk6akbvq@localhost.localdomain>
References: <149524122523.11022.4541073724650541658.stgit@anamdev.jf.intel.com>
 <1495481472.4878.4.camel@intel.com>
 <20170721094244.nkkmvb7fvk6akbvq@localhost.localdomain>
Message-ID: <d1b736ac-6f6c-0aa5-b76c-0192b054ecaa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 7/21/2017 2:42 AM, Richard Cochran wrote:
> On Mon, May 22, 2017 at 12:31:12PM -0700, Jeff Kirsher wrote:
>> On Fri, 2017-05-19 at 17:58 -0700, Amritha Nambiar wrote:
>>> The following series introduces a new harware offload mode in tc/mqprio
>>> where the TCs, the queue configurations and bandwidth rate limits are
>>> offloaded to the hardware.
>
> ...
>
>> This was meant to be sent out as an RFC, but apparently that did not get
>> conveyed when these were sent out Friday.
>
> I am looking at tc/mqprio and dcb with the purpose of implementing
>
>   - Forwarding and Queuing Enhancements for Time-Sensitive Streams (FQTSS)
>     802.1Q-2014 Clause 34
>
>   - Scheduled Traffic (time based scheduling)
>     P802.1Qbv
>
> using the HW capabilities of the i210.  This series looks like a
> promising avenue for these features.
>
> My question is, did series go anywhere?
>
> I didn't see any follow ups on netdev, but maybe I missed something.

I have submitted another series as non-RFC for next-queue maintained by 
Jeff Kirsher. This is going to come through the next-queue tree. You can 
follow the new series "[PATCH 0/6] Configuring traffic classes via new 
hardware offload mechanism in tc/mqprio" at 
https://www.mail-archive.com/netdev at vger.kernel.org/msg177390.html

>
> Thanks,
> Richard
>
>
>
