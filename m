From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jun 2020 19:11:26 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: detect and log info about
 pre-recovery mode
In-Reply-To: <20200526105615.3315-1-piotr.kwapulinski@intel.com>
References: <20200526105615.3315-1-piotr.kwapulinski@intel.com>
Message-ID: <MWHPR11MB1663B0288BF79CBAC954E8658C890@MWHPR11MB1663.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Piotr Kwapulinski
> Sent: Tuesday, May 26, 2020 3:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: detect and log info about pre-
> recovery mode
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
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 74 +++++++++++++------
>  .../net/ethernet/intel/i40e/i40e_register.h   |  2 +
>  2 files changed, 53 insertions(+), 23 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


