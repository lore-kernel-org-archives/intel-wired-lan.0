From: Mekala, SunithaX D <sunithax.d.mekala@intel.com>
Date: Fri, 27 Aug 2021 21:36:24 +0000
Subject: [Intel-wired-lan] [next-queue v4 04/13] ice: restart periodic
 outputs around time changes
In-Reply-To: <CO1PR11MB502800310CC895CCE4B5A272A0C89@CO1PR11MB5028.namprd11.prod.outlook.com>
References: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
 <20210824000158.1928482-5-anthony.l.nguyen@intel.com>
 <CO1PR11MB502800310CC895CCE4B5A272A0C89@CO1PR11MB5028.namprd11.prod.outlook.com>
Message-ID: <CO1PR11MB5028978799CA7F7A39F05C0DA0C89@CO1PR11MB5028.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf 
> Of Tony Nguyen
> Sent: Monday, August 23, 2021 5:02 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v4 04/13] ice: restart periodic 
> outputs around time changes
>
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> Wen we enabled auxiliary input/output support for the E810 device, we forgot to add logic to restart the output when we change time. This is important as the periodic output will be incorrect after a time change otherwise.
>
> This unfortunately includes the adjust time function, even though it uses an atomic hardware interface. The atomic adjustment can still cause the pin output to stall permanently, so we need to stop and restart it.
>
> Introduce wrapper functions to temporarily disable and then re-enable the clock outputs.
>
> Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output 
> pins")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
 > drivers/net/ethernet/intel/ice/ice_ptp.c | 49 ++++++++++++++++++++++++  > 1 file changed, 49 insertions(+)
> Tested in CVL
>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
