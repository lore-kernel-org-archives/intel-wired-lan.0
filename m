From: Dong, Eddie <eddie.dong@intel.com>
Date: Thu, 26 Nov 2015 03:15:35 +0000
Subject: [Intel-wired-lan] [RFC PATCH V2 0/3] IXGBE/VFIO: Add live
 migration support for SRIOV NIC
In-Reply-To: <CAKgT0UevBmRLpM1PvuuVDUW79A66RcPrfO8uGiqL1RiALW7apg@mail.gmail.com>
References: <1448372298-28386-1-git-send-email-tianyu.lan@intel.com>
 <5654722D.4010409@gmail.com>	<56552888.90108@intel.com>
 <CAKgT0UcSrewenfM2YdVojHFFqfK2aVbBN5LH8=BFzc1p0f9hvQ@mail.gmail.com>
 <56556F98.5060507@intel.com>
 <CAKgT0UevBmRLpM1PvuuVDUW79A66RcPrfO8uGiqL1RiALW7apg@mail.gmail.com>
Message-ID: <A12AC9D104E08D47BAF23C492F83C53B25CDE9E3@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Wed, Nov 25, 2015 at 12:21 AM, Lan Tianyu <tianyu.lan@intel.com> wrote:
> > On 2015?11?25? 13:30, Alexander Duyck wrote:
> >> No, what I am getting at is that you can't go around and modify the
> >> configuration space for every possible device out there.  This
> >> solution won't scale.
> >
> >
> > PCI config space regs are emulation by Qemu and so We can find the
> > free PCI config space regs for the faked PCI capability. Its position
> > can be not permanent.
> 
> Yes, but do you really want to edit every driver on every OS that you plan to
> support this on.  What about things like direct assignment of regular Ethernet
> ports?  What you really need is a solution that will work generically on any
> existing piece of hardware out there.

The fundamental assumption of this patch series is to modify the driver in guest to self-emulate or track the device state, so that the migration may be possible.
I don't think we can modify OS, without modifying the drivers, even using the PCIe hotplug mechanism.  
In the meantime, modifying Windows OS is a big challenge given that only Microsoft can do. While, modifying driver is relatively simple and manageable to device vendors, if the device vendor want to support state-clone based migration.

Thx Eddie
