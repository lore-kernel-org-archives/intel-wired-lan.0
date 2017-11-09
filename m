From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 8 Nov 2017 16:32:09 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 2/5] fm10k: Fix
 VLAN configuration for macvlan offload
In-Reply-To: <02874ECE860811409154E81DA85FBB5882ADF424@ORSMSX115.amr.corp.intel.com>
References: <20171102232857.15146.21583.stgit@localhost.localdomain>
 <20171102233336.15146.31137.stgit@localhost.localdomain>
 <20171103100556.00001ff7@intel.com>
 <02874ECE860811409154E81DA85FBB5882ADF292@ORSMSX115.amr.corp.intel.com>
 <CAKgT0UfCaWbHOgwqCpk+uHvVXLM=5n00oqtaHFoTF_BQ4uqh4w@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB5882ADF424@ORSMSX115.amr.corp.intel.com>
Message-ID: <CAKgT0UecfDw2Ft+rSBcprVy95ymY-e2H1pJzWhMRFvxgFH=nVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Nov 8, 2017 at 4:21 PM, Keller, Jacob E
<jacob.e.keller@intel.com> wrote:
>
>
>> -----Original Message-----
>> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
>> Sent: Wednesday, November 08, 2017 3:04 PM
>> To: Keller, Jacob E <jacob.e.keller@intel.com>
>> Cc: Brandeburg, Jesse <jesse.brandeburg@intel.com>; netdev at vger.kernel.org;
>> intel-wired-lan at lists.osuosl.org
>> Subject: Re: [Intel-wired-lan] [jkirsher/next-queue PATCH 2/5] fm10k: Fix VLAN
>> configuration for macvlan offload
>>
>> On Wed, Nov 8, 2017 at 2:05 PM, Keller, Jacob E
>> <jacob.e.keller@intel.com> wrote:
>> >> -----Original Message-----
>> >> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
>> Of
>> >> Jesse Brandeburg
>> >> Sent: Friday, November 03, 2017 10:06 AM
>> >> To: Alexander Duyck <alexander.duyck@gmail.com>
>> >> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
>> >> Subject: Re: [Intel-wired-lan] [jkirsher/next-queue PATCH 2/5] fm10k: Fix
>> VLAN
>> >> configuration for macvlan offload
>> >>
>> >> On Thu, 2 Nov 2017 16:33:45 -0700
>> >> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>> >>
>> >> > From: Alexander Duyck <alexander.h.duyck@intel.com>
>> >> >
>> >> > The fm10k driver didn't work correctly when macvlan offload was enabled.
>> >> > Specifically what would occur is that we would see no unicast packets being
>> >> > received. This was traced down to us not correctly configuring the default
>> >> > VLAN ID for the port and defaulting to 0.
>> >> >
>> >> > To correct this we either use the default ID provided by the switch or
>> >> > simply use 1. With that we are able to pass and receive traffic without any
>> >> > issues.
>> >>
>> >> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>> >>
>> >
>> > Hi,
>> >
>> > I think this isn't quite right, since we recently made changes to the fm10k code
>> to stop assuming VLAN 1 in these cases. I believe it should just pass the
>> default_vid
>> >
>> > Thanks,
>> > Jake
>> >
>>
>> I kind of figured that might be the case. We can probably drop this
>> patch for now and if you want you can work this from our end as the
>> out-of-tree code doesn't make the upstream and I would imagine you
>> guys are planning to upstream that patch at some point.
>>
>> - Alex
>
> I think the patch should just be changed from using
>
> hw->mac.default_vid ? : 1
>
> to just using hw->mac.default_vid directly.
>
> Otherwise, I think the patch is necessary.
>
> Thanks,
> Jake

Doesn't passing a 0 in the case of the value not being populated cause
issues? If I understand the problem I thought passing a 0 in the vlan
ID field caused some sort of error.

- Alex
