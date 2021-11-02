From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 2 Nov 2021 08:20:25 +0000
Subject: [Intel-wired-lan] [PATCH v6 1/2] ice: reduce time to read
 Option ROM CIVD data
In-Reply-To: <20211027224947.644211-1-jacob.e.keller@intel.com>
References: <20211027224947.644211-1-jacob.e.keller@intel.com>
Message-ID: <BYAPR11MB336788506B6F7A1C24982583FC8B9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Thursday, October 28, 2021 4:20 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Intel Wired LAN <intel-
> wired-lan at lists.osuosl.org>
> Cc: pmenzel at molgen.mpg.de
> Subject: [Intel-wired-lan] [PATCH v6 1/2] ice: reduce time to read Option ROM
> CIVD data
> 
> During probe and device reset, the ice driver reads some data from the NVM
> image as part of ice_init_nvm. Part of this data includes a section of the Option
> ROM which contains version information.
> 
> The function ice_get_orom_civd_data is used to locate the '$CIV' data section
> of the Option ROM.
> 
> Timing of ice_probe and ice_rebuild indicate that the ice_get_orom_civd_data
> function takes about 10 seconds to finish executing.
> 
> The function locates the section by scanning the Option ROM every 512 bytes.
> This requires a significant number of NVM read accesses, since the Option
> ROM bank is 500KB. In the worst case it would take about 1000 reads. Worse,
> all PFs serialize this operation during reload because of acquiring the NVM
> semaphore.
> 
> The CIVD section is located at the end of the Option ROM image data.
> Unfortunately, the driver has no easy method to determine the offset manually.
> Practical experiments have shown that the data could be at a variety of
> locations, so simply reversing the scanning order is not sufficient to reduce the
> overall read time.
> 
> Instead, copy the entire contents of the Option ROM into memory. This allows
> reading the data using 4Kb pages instead of 512 bytes at a time.
> This reduces the total number of firmware commands by a factor of 8. In
> addition, reading the whole section together at once allows better indication to
> firmware of when we're "done".
> 
> Re-write ice_get_orom_civd_data to allocate virtual memory to store the
> Option ROM data. Copy the entire OptionROM contents at once using
> ice_read_flash_module. Finally, use this memory copy to scan for the '$CIV'
> section.
> 
> This change significantly reduces the time to read the Option ROM CIVD
> section from ~10 seconds down to ~1 second. This has a significant impact on
> the total time to complete a driver rebuild or probe.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_nvm.c | 47 ++++++++++++++++++------
>  1 file changed, 35 insertions(+), 12 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
