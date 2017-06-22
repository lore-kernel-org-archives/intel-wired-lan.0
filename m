From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Jun 2017 17:13:42 +0000
Subject: [Intel-wired-lan] [next PATCH S73-V2 2/9] i40e: remove
 WQ_UNBOUND	and the task limit of our workqueue
In-Reply-To: <20170620221701.46765-2-jeffrey.t.kirsher@intel.com>
References: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
 <20170620221701.46765-2-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAB8DE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, June 20, 2017 3:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S73-V2 2/9] i40e: remove
> WQ_UNBOUND and the task limit of our workqueue
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> During certain events such as a CORER, multiple devices will run a work task
> to handle some cleanup. This can cause issues due to a single-threaded
> workqueue which can mean that a device doesn't cleanup in time. Prevent
> this by removing the single-threaded restriction on the module workqueue.
> This avoids the need to add more complex yielding logic in our service task
> routine. This is also similar to what other drivers such as fm10k do.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


