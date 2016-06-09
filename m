From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 9 Jun 2016 18:57:18 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: restore D0 power state upon
 probe
In-Reply-To: <CAKgT0UdFekv7wKshpuq-VqO6YZR-98aG1FB2oS-4Vz3OrV3m8Q@mail.gmail.com>
References: <20160608002043.10367-1-jacob.e.keller@intel.com>
 <CAKgT0UdmTRUesM9hD9ifUw=+rx117=Ck7bzEgezHX=WGR2rArQ@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB5857AE09FD@ORSMSX115.amr.corp.intel.com>
 <CAKgT0UdjL=4d7vXi4oCYw4G7fTe864vA4=1=2HYTK9KBQPLuQA@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB5857AE0C0D@ORSMSX115.amr.corp.intel.com>
 <CAKgT0Uft298E1zAkEJ+R7SGrA9oisS6Ufpkmo7V-KD+eBvLXnQ@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB5857AE0C33@ORSMSX115.amr.corp.intel.com>
 <CAKgT0Ueno8VjnHDZsqGOU+t5h2DJQOkOLO8vJk8z-ZMpgn5_MA@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB5857AE19DE@ORSMSX115.amr.corp.intel.com>
 <CAKgT0UdFekv7wKshpuq-VqO6YZR-98aG1FB2oS-4Vz3OrV3m8Q@mail.gmail.com>
Message-ID: <1465498638.11216.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2016-06-09 at 10:54 -0700, Alexander Duyck wrote:
> No, it will but you have to actually be re-enabling the device to
> trigger it.
> 
> You might try replacing the call to pci_enable_device_mem with
> pci_reenable_device and see if that works for you.??I suspect this is
> probably a bug that is common in many of the drivers out there.
> 
> - Alex

Changing the pci_enable_device_mem() to a pci_reenable_device() inside
the .io_slot_reset seems to have worked, and is much cleaner than my
alternative approach. I think this is the right way since we aren't
really wanting to disable the device in this section and matches up
with what the .slot_reset wants without breaking other flows.

I'll have a patch for that in a bit.

Thanks,
Jake
