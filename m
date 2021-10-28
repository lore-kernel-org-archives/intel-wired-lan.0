From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 28 Oct 2021 17:56:41 +0000
Subject: [Intel-wired-lan] [PATCH v7 1/2] ice: reduce time to read
 Option ROM CIVD data
In-Reply-To: <a9ab1f26-69f6-9f31-8ffb-14a7bfa21505@molgen.mpg.de>
References: <20211027232255.669167-1-jacob.e.keller@intel.com>
 <a9ab1f26-69f6-9f31-8ffb-14a7bfa21505@molgen.mpg.de>
Message-ID: <CO1PR11MB5089365FA06C9EBEE67291B3D6869@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Wednesday, October 27, 2021 11:43 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
> lan at lists.osuosl.org; linux-pci at vger.kernel.org
> Subject: Re: [PATCH v7 1/2] ice: reduce time to read Option ROM CIVD data
> 
> [Cc: +linux-pci for ideas how to work with Option ROMs]
> 
> Dear Jacob,
> 
> 
> On 28.10.21 01:22, Jacob Keller wrote:
> > During probe and device reset, the ice driver reads some data from the
> > NVM image as part of ice_init_nvm. Part of this data includes a section
> > of the Option ROM which contains version information.
> >
> > The function ice_get_orom_civd_data is used to locate the '$CIV' data
> > section of the Option ROM.
> >
> > Timing of ice_probe and ice_rebuild indicate that the
> > ice_get_orom_civd_data function takes about 10 seconds to finish
> > executing.
> >
> > The function locates the section by scanning the Option ROM every 512
> > bytes. This requires a significant number of NVM read accesses, since
> > the Option ROM bank is 500KB. In the worst case it would take about 1000
> > reads. Worse, all PFs serialize this operation during reload because of
> > acquiring the NVM semaphore.
> >
> > The CIVD section is located at the end of the Option ROM image data.
> > Unfortunately, the driver has no easy method to determine the offset
> > manually. Practical experiments have shown that the data could be at
> > a variety of locations, so simply reversing the scanning order is not
> > sufficient to reduce the overall read time.
> >
> > Instead, copy the entire contents of the Option ROM into memory. This
> > allows reading the data using 4Kb pages instead of 512 bytes at a time.
> > This reduces the total number of firmware commands by a factor of 8. In
> > addition, reading the whole section together at once allows better
> > indication to firmware of when we're "done".
> >
> > Re-write ice_get_orom_civd_data to allocate virtual memory to store the
> > Option ROM data. Copy the entire OptionROM contents at once using
> 
> Option ROM
> 
> > ice_read_flash_module. Finally, use this memory copy to scan for the
> > '$CIV' section.
> >
> > This change significantly reduces the time to read the Option ROM CIVD
> > section from ~10 seconds down to ~1 second. This has a significant
> > impact on the total time to complete a driver rebuild or probe.
> 
> Thank you for taking up the challenge and looking into this, and for
> decreasing the time.
> 
> OT: Out of curiosity, how does it work on UEFI systems without using
> Compatibility System Mode (CSM) and just ?EFI drivers??
> 


This code is just about accessing the version data that we report via devlink info.

Thanks,
Jake

> >   ice_get_orom_civd_data(struct ice_hw *hw, enum ice_bank_select bank,
> >   		       struct ice_orom_civd_info *civd)
> >   {
> > -	struct ice_orom_civd_info tmp;
> > +	u8 *orom_data;
> 
> I know the function names use orom, but oprom is already used in other
> subsystems.
> 

Sure, but there's dozens of instances in this driver where we use the short 'orom'. Not worth changing that in this patch series.

> >   }
> 
> Please excuse my ignorance. I would have though, that the system
> firmware already put that Option ROM into memory. There is a function
> `pci_map_biosrom()` declared in `arch/x86/include/asm/probe_roms.h` and
> implemented in `arch/x86/kernel/probe_roms.c`, which might be used?
> 

Sure. This function is used to read the version data that we report about the flash contents via devlink info.

I believe the reasoning this is done during rebuild is because there wasn't a need to scan it on demand since it won't change unless you do a flash update.

We read information on the 3 major components of the flash during init: the EMP firmware versions, the Option ROM version data, and something we call netlist which I understand contains some configuration TLVs

The point of this separate function is to be able to report precisely what version of the firmware image that we have loaded onto the device.

This gets reported in devlink info:
pci/0000:af:00.1:
  driver ice
  serial_number 00-01-00-ff-ff-00-00-00
  versions:
      fixed:
        board.id K91258-000
      running:
        fw.mgmt 6.1.5
        fw.mgmt.api 1.7.9
        fw.mgmt.build 0x6986bfdb
        fw.undi 1.3025.0
        fw.psid.api 3.10
        fw.bundle_id 0x80008e6a
        fw.app.name ICE OS Default Package
        fw.app 1.3.27.0
        fw.app.bundle_id 0xc0000001
        fw.netlist 3.10.2000-3.1e.0
        fw.netlist.build 0x4154dfac
      stored:
        fw.undi 1.3025.0
        fw.psid.api 3.10
        fw.bundle_id 0x80008e6a
        fw.netlist 3.10.2000-3.1e.0
        fw.netlist.build 0x4154dfac

Specifically, fw.undi contains the version of the Option ROM image. We report both the "running" version, and, if there is a pending bank switch during next firmware load, the version stored in the inactive flash bank that will be switched to next load.

Thanks,
Jake

> Kind regards,
> 
> Paul

