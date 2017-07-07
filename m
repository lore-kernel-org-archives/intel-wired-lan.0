From: Greg Rose <gvrose8192@gmail.com>
Date: Fri, 7 Jul 2017 09:18:14 +0100
Subject: [Intel-wired-lan] [PATCH 1/2] i40e/i40evf: rename
 vf_offload_flags to vf_cap_flags in struct virtchnl_vf_resource
In-Reply-To: <9BBC4E0CF881AA4299206E2E1412B62650491AAE@ORSMSX102.amr.corp.intel.com>
References: <20170629131225.9251-1-sassmann@kpanic.de>
 <20170629131225.9251-2-sassmann@kpanic.de>
 <9BBC4E0CF881AA4299206E2E1412B62650490D08@ORSMSX102.amr.corp.intel.com>
 <CALgkqUpFST=oiS+yAFpkCiRS6JPqVg9R7_+3GMNvWoVnB_zoXg@mail.gmail.com>
 <9BBC4E0CF881AA4299206E2E1412B62650491AAE@ORSMSX102.amr.corp.intel.com>
Message-ID: <CALgkqUpJL6OWgv8o7ii4mW31GVjiwfAttb_Wxbdb7yqMSRp9zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jul 6, 2017 at 4:26 PM, Wyborny, Carolyn
<carolyn.wyborny@intel.com> wrote:
>> -----Original Message-----
>> From: Greg Rose [mailto:gvrose8192 at gmail.com]
>> Sent: Thursday, July 06, 2017 7:25 AM
>> To: Wyborny, Carolyn <carolyn.wyborny@intel.com>
>> Cc: Stefan Assmann <sassmann@kpanic.de>; intel-wired-lan at lists.osuosl.org;
>> netdev at vger.kernel.org; davem at davemloft.net
>> Subject: Re: [Intel-wired-lan] [PATCH 1/2] i40e/i40evf: rename
>> vf_offload_flags to vf_cap_flags in struct virtchnl_vf_resource
>>
>> On Wed, Jul 5, 2017 at 10:15 PM, Wyborny, Carolyn
>> <carolyn.wyborny@intel.com> wrote:
>> >
>> > > -----Original Message-----
>> > > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
>> Behalf
>> > > Of Stefan Assmann
>> > > Sent: Thursday, June 29, 2017 6:12 AM
>> > > To: intel-wired-lan at lists.osuosl.org
>> > > Cc: netdev at vger.kernel.org; davem at davemloft.net;
>> sassmann at kpanic.de
>> > > Subject: [Intel-wired-lan] [PATCH 1/2] i40e/i40evf: rename
>> vf_offload_flags to
>> > > vf_cap_flags in struct virtchnl_vf_resource
>> > >
>> > > The current name of vf_offload_flags indicates that the bitmap is
>> > > limited to offload related features. Make this more generic by renaming
>> > > it to vf_cap_flags, which allows for other capabilities besides
>> > > offloading to be added.
>> > >
>> > > Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>> > > ---
>> >
>> > Hello Stefan,
>> >
>> > Thanks for the patch series, but we believe the vf should be ignorant of its
>> trusted status.
>>
>> Hi Carolyn,
>>
>> Might I ask why?
>>
>> Thanks,
>>
>> - Greg
>
> Hello Greg,
>
> The trusted status of the vf is something that pf manages, mostly for security reasons.  The mailbox model of communication between them relies on the pf to have authority over the vf.  In most things, the vf asks permission from the pf for changes in its configuration and this keeps the pf as the gatekeeper between trusted and regular vf's.  However, the issue here is that changing the MAC address from within the vf does not go through the mailbox, so it cannot tell if the vf is trusted or not.   We are working on a redesign of this feature to fix that instead of having the vf sort of know its trusted.  If, for some reason, we are unable to redesign it that way we would reconsider this method instead.
>
> Thanks,

Thanks, that was my concern, that by allowing the VF to set it's own
MAC then it would implicitly know it was trusted.

Regards,

- Greg
>
> Carolyn
