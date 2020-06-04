From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jun 2020 19:15:03 +0000
Subject: [Intel-wired-lan] [next-queue v2] i40e: Remove scheduling while
 atomic possibility
In-Reply-To: <20200529211039.1673605-1-jeffrey.t.kirsher@intel.com>
References: <20200529211039.1673605-1-jeffrey.t.kirsher@intel.com>
Message-ID: <MWHPR11MB1663A1999980991234AC66128C890@MWHPR11MB1663.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jeff Kirsher
> Sent: Friday, May 29, 2020 2:11 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next-queue v2] i40e: Remove scheduling while
> atomic possibility
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> In some occasions task held spinlock, while being rescheduled due to
> mutex_lock.  Moved function call outside of atomic context.  Without this
> patch there is a race condition, which might result in scheduling while atomic.
> 
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2: fixed trailing whitespace
> 
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 222 +++++++++++-------
>  1 file changed, 135 insertions(+), 87 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


