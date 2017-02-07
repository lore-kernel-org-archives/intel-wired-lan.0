From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 6 Feb 2017 18:11:50 -0800
Subject: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for
 padding packet
In-Reply-To: <CAKgT0Ufo1FUq=7c=F7QRQRruE7g9PkUJZpvjN7SfeDNqjzRbxQ@mail.gmail.com>
References: <20170123165647.13402.1254.stgit@localhost.localdomain>
 <20170123165906.13402.80385.stgit@localhost.localdomain>
 <309B89C4C689E141A5FF6A0C5FB2118B8C588006@ORSMSX101.amr.corp.intel.com>
 <CAKgT0Uf2uZZOgX_2w7bpBbuFv4_VcTAJ0GnWyZAejEVVvtKBdA@mail.gmail.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C5887B6@ORSMSX101.amr.corp.intel.com>
 <CAKgT0UcEdhJ_sAWgk4Enaa2TsnjoupqQZwHOV7F4CAi1=3cPVQ@mail.gmail.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C5897B3@ORSMSX101.amr.corp.intel.com>
 <CAKgT0Ufo1FUq=7c=F7QRQRruE7g9PkUJZpvjN7SfeDNqjzRbxQ@mail.gmail.com>
Message-ID: <CAKgT0UcwYj8m1PgFxHiYLvD6fy2HXT2etLCQ92urjkDjzO8ayw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Feb 6, 2017 at 5:51 PM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Mon, Feb 6, 2017 at 5:15 PM, Brown, Aaron F <aaron.f.brown@intel.com> wrote:
>>> -----Original Message-----
>>> From: Brown, Aaron F
>>> Sent: Monday, February 6, 2017 3:21 PM
>>> To: 'Alexander Duyck' <alexander.duyck@gmail.com>
>>> Cc: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
>>> <jeffrey.t.kirsher@intel.com>
>>> Subject: RE: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for
>>> padding packet
>>>
>>> >
>>> > -----Original Message-----
>>> > From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
>>> > Sent: Sunday, February 5, 2017 8:45 PM
>>> > To: Brown, Aaron F <aaron.f.brown@intel.com>
>>> > Cc: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
>>> > <jeffrey.t.kirsher@intel.com>
>>> > Subject: Re: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for
>>> > padding packet
>>> >
>>> > On Fri, Feb 3, 2017 at 4:39 PM, Brown, Aaron F <aaron.f.brown@intel.com>
>>> > wrote:
>>> > >> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
>>> > >> Sent: Friday, February 3, 2017 9:58 AM
>>> > >> To: Brown, Aaron F <aaron.f.brown@intel.com>
>>> > >> Cc: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
>>> > >> <jeffrey.t.kirsher@intel.com>
>>> > >> Subject: Re: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for
>>> > >> padding packet
>>> > >>
>>> > >> On Thu, Feb 2, 2017 at 8:01 PM, Brown, Aaron F
>>> > <aaron.f.brown@intel.com>
>>> > >> wrote:
>>> > >> >> From: Intel-wired-lan [mailto:intel-wired-lan-
>>> > bounces at lists.osuosl.org]
>>> > >> On
>>> > >> >> Behalf Of Alexander Duyck
>>> > >> >> Sent: Monday, January 23, 2017 8:59 AM
>>> > >> >> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
>>> > >> >> <jeffrey.t.kirsher@intel.com>
>>> > >> >> Subject: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for
>>> > >> padding
>>> > >> >> packet
>>> > >> >>
>>> > >> >> From: Alexander Duyck <alexander.h.duyck@intel.com>
>>> > >> >>
>>> > >> >> With the size of the frame limited we can now write to an offset
>>> within
>>> > >> the
>>> > >> >> buffer instead of having to write at the very start of the buffer.  The
>>> > >> >> advantage to this is that it allows us to leave padding room for things
>>> > >> >> like supporting XDP in the future.
>>> > >> >>
>>> > >> >> One side effect of this patch is that we can end up using a larger
>>> buffer
>>> > >> >> if jumbo frames is enabled.  The impact shouldn't be too great, but it
>>> > >> >> could hurt small packet performance for UDP workloads if jumbo
>>> > frames
>>> > >> is
>>> > >> >> enabled as the truesize of frames will be larger.
>>> > >> >>
>>> > >> >> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>>> > >> >> ---
>>> > >> >>
>>>
>>> <snip>
>>>
>>> > >>
>>> > >> Well one thing you might try doing is running "ethtool
>>> > >> --set-priv-flags <ethX> legacy-rx on" and seeing if you have the same
>>> > >> problem or not.  Turning on legacy Rx with this patch applied should
>>> > >> only have the effect of adding padding to the front of the frame and
>>> > >> will help to eliminate some of the code as being potentially
>>> > >> responsible for this.
>>> > >
>>> > > Well, I had wiped the old system before I got this message, but after
>>> > rebuilding I still get a dump from running the same netperf_stress test.
>>> The
>>> > trace has changed to a GPF and if I turn on legacy RX as you suggested
>>> > netperf_stress continues to run fine and I do NOT get the dump.  Here is a
>>> > copy of the latest dump I got when running netperf_stress (and with legacy
>>> > RX off.):
>>> >
>>> > Okay so that gives me a bit to go on.  If I am not mistaken that
>>> > system has support for VTd, do you have that enabled in your kernel or
>>> > is it disabled?
>>>
>>> Yes, the system is supposed to be capable of VTd, it was disable in BIOS and
>>> kernel when I was running into this last week.  I enabled in BIOS and added
>>> the intel_iommu=on line to the boot stanza and am still seeing the dump
>>> when I run it.
>>
>> Looks like I spoke to soon about VTd truly being enabled.  It was enabled in BIOS and the stanza set, but INTEL_IOMMU was not set in the kernel's .config file.  I've fixed that now, rebuilt, rebooted, and now the system is running the netperf_stress continually without a crash for far longer than it had earlier.  However, I am still getting a message in the log, every few seconds I will see the following splatted to dmesg:
>> --------------------------------------------------------------------------------------------------------
>> DMAR: DRHD: handling fault status reg 2
>> DMAR: [DMA Write] Request device [08:00.1] fault addr ff9f1000 [fault reason 05] PTE Write access is not set
>> --------------------------------------------------------------------------------------------------------
>>
>> The called out device, 08:00.1, is the slot for the NIC that is engaged in the netperf_stress test.
>>
>> So, still a problem, but changed and not as drastic.
>
> Okay, so that gives me more to go on.  It looks like we are attempting
> to write to pages that we don't have access to.  I suspect we are
> somehow writing a 2K buffer even though we are only supposed to be
> using 1514 bytes and overflowing the end of the page.
>
> Can you send me an ethregs dump for the port?  I'm curious what the
> configuration for the registers is.
>
> Thanks.
>
> - Alex

Never mind.  I think I found the bug.  We weren't locking down RLPML
on 82575, i210, or i211.  I made the mistake of not noticing an if
statement that was calling return in igb_set_rx_mode.

I should have a new version out shortly with a fix for the issue.
