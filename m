From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 25 Nov 2015 07:32:03 -0800
Subject: [Intel-wired-lan] [RFC PATCH V2 0/3] IXGBE/VFIO: Add live
 migration support for SRIOV NIC
In-Reply-To: <56556F98.5060507@intel.com>
References: <1448372298-28386-1-git-send-email-tianyu.lan@intel.com>
 <5654722D.4010409@gmail.com> <56552888.90108@intel.com>
 <CAKgT0UcSrewenfM2YdVojHFFqfK2aVbBN5LH8=BFzc1p0f9hvQ@mail.gmail.com>
 <56556F98.5060507@intel.com>
Message-ID: <CAKgT0UevBmRLpM1PvuuVDUW79A66RcPrfO8uGiqL1RiALW7apg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Nov 25, 2015 at 12:21 AM, Lan Tianyu <tianyu.lan@intel.com> wrote:
> On 2015?11?25? 13:30, Alexander Duyck wrote:
>> No, what I am getting at is that you can't go around and modify the
>> configuration space for every possible device out there.  This
>> solution won't scale.
>
>
> PCI config space regs are emulation by Qemu and so We can find the free
> PCI config space regs for the faked PCI capability. Its position can be
> not permanent.

Yes, but do you really want to edit every driver on every OS that you
plan to support this on.  What about things like direct assignment of
regular Ethernet ports?  What you really need is a solution that will
work generically on any existing piece of hardware out there.

>>  If you instead moved the logic for notifying
>> the device into a separate mechanism such as making it a part of the
>> hot-plug logic then you only have to write the code once per OS in
>> order to get the hot-plug capability to pause/resume the device.  What
>> I am talking about is not full hot-plug, but rather to extend the
>> existing hot-plug in Qemu and the Linux kernel to support a
>> "pause/resume" functionality.  The PCI hot-plug specification calls
>> out the option of implementing something like this, but we don't
>> currently have support for it.
>>
>
> Could you elaborate the part of PCI hot-plug specification you mentioned?
>
> My concern is whether it needs to change PCI spec or not.


In the PCI Hot-Plug Specification 1.1, in section 4.1.2 it states:
 In addition to quiescing add-in card activity, an operating-system
vendor may optionally implement a less drastic ?pause? capability, in
anticipation of the same or a similar add-in card being reinserted.

The idea I had was basically if we were to implement something like
that in Linux then we could pause/resume the device instead of
outright removing it.  The pause functionality could make use of the
suspend/resume functionality most drivers already have for PCI power
management.

- Alex
