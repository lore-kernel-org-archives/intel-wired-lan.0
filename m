From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jun 2020 19:12:18 +0000
Subject: [Intel-wired-lan] [next-queue v2] i40e: detect and log info
 about pre-recovery mode
In-Reply-To: <20200527211204.234642-1-jeffrey.t.kirsher@intel.com>
References: <20200527211204.234642-1-jeffrey.t.kirsher@intel.com>
Message-ID: <MWHPR11MB166348EE43A83D499760C3AA8C890@MWHPR11MB1663.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jeff Kirsher
> Sent: Wednesday, May 27, 2020 2:12 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next-queue v2] i40e: detect and log info about
> pre-recovery mode
> 
> From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> 
> Detect and log information about pre-recovery mode when firmware
> transitions to a recovery mode.
> When a firmware transitions to a recovery mode it stores a number of
> unexpected EMP resets in one of its registers. The number of EMP resets
> ranging from 0x21 to 0x2A indicates that FW transitions to recovery mode.
> Use these values to emit log entry about transition process. Previously the
> pre-recovery mode may not have been detected and there was no log entry
> when NIC was in pre-recovery mode.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
> v2: Fixed conflicts when trying to apply to next-queue tree
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 72 +++++++++++++------
>  .../net/ethernet/intel/i40e/i40e_register.h   |  2 +
>  2 files changed, 52 insertions(+), 22 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


