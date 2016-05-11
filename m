From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 11 May 2016 13:24:57 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v2 2/3] ixgbe/ixgbevf: Add
 support for GSO partial
In-Reply-To: <305E19FFAC908240AB6DEBD1E2D8C1E180D94916@ORSMSX108.amr.corp.intel.com>
References: <20160414210725.14141.25917.stgit@ahduyck-xeon-server>
 <20160414211931.14141.18864.stgit@ahduyck-xeon-server>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2658@ORSMSX104.amr.corp.intel.com>
 <305E19FFAC908240AB6DEBD1E2D8C1E180D94916@ORSMSX108.amr.corp.intel.com>
Message-ID: <CAKgT0Ue=s=+N_uJ31P_bKpkKuKJ+xVVvbNf59O31izqtP9gFdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, May 11, 2016 at 11:47 AM, Schmitt, Phillip J
<phillip.j.schmitt@intel.com> wrote:
>
>
>> -----Original Message-----
>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>> Behalf Of Bowers, AndrewX
>> Sent: Wednesday, April 20, 2016 2:21 PM
>> To: intel-wired-lan at lists.osuosl.org
>> Subject: Re: [Intel-wired-lan] [next-queue PATCH v2 2/3] ixgbe/ixgbevf: Add
>> support for GSO partial
>>
>> > -----Original Message-----
>> > From: Intel-wired-lan
>> > [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of
>> > Alexander Duyck
>> > Sent: Thursday, April 14, 2016 2:20 PM
>> > To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
>> > <jeffrey.t.kirsher@intel.com>; alexander.duyck at gmail.com
>> > Subject: [Intel-wired-lan] [next-queue PATCH v2 2/3] ixgbe/ixgbevf:
>> > Add support for GSO partial
>> >
>> > This patch adds support for partial GSO segmentation in the case of tunnels.
>> > Specifically with this change the driver an perform segmenation as
>> > long as the frame either has IPv6 inner headers, or we are allowed to
>> > mangle the IP IDs on the inner header.  This is needed because we will
>> > not be modifying any fields from the start of the start of the outer
>> > transport header to the start of the inner transport header as we are
>> > treating them like they are just a block of IP options.
>> >
>> > Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>> > ---
>> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  133 ++++++++++++++--
>> > -----
>> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  129
>> > +++++++++++++++-----
>> >  2 files changed, 180 insertions(+), 82 deletions(-)
>>
>> Tested-by: Andrew Bowers <andrewx.bowers@intel.com> GRE tunnel traffic
>> works as expected with speed increase with GSO on
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at lists.osuosl.org
>> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>
> Alex,
> Turns out this patch is causing an error when attempting to create a VLAN.
> Would you be interested in submitting a follow on patch to address this?
> Here's repro steps:
> 1. Install Fedora 23 and compile the next-queue kernel (v4.6-rc6) with dev-queue branch
> 2. Reboot with kernel-4.6.0-rc6_20160506.next_queue_dev_queue.
> 3. Created vlan 3260 interface with Spring Fountain
>
> [root at lin-nd3-114 ~]# ip l a enp130s0f0.3260 l enp130s0f0 type vlan id 3260
> RTNETLINK answers: Invalid argument
>
> Expected result: vlan 3260 interface should be created.
>
> Actual result: Can't get vlan interface.

I think I found the issue.  It looks like a few lines got swapped when
I was working on the patch.

I have submitted a patch to fix it that should be available in the
next few minutes.

Thanks.

- Alex
