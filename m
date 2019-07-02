From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jul 2019 22:50:41 +0000
Subject: [Intel-wired-lan] [PATCH S22 05/16] ice: separate out control
 queue lock creation
In-Reply-To: <20190626092027.52845-5-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
 <20190626092027.52845-5-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FBDF2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, June 26, 2019 2:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S22 05/16] ice: separate out control queue
> lock creation
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_init_all_ctrlq and ice_shutdown_all_ctrlq functions create and
> destroy the locks used to protect the send and receive process of each
> control queue.
> 
> This is problematic, as the driver may use these functions to shutdown and
> re-initialize the control queues at run time. For example, it may do this in
> response to a device reset.
> 
> If the driver failed to recover from a reset, it might leave the control queues
> offline. In this case, the locks will no longer be initialized.
> A later call to ice_sq_send_cmd will then attempt to acquire a lock that has
> been destroyed.
> 
> It is incorrect behavior to access a lock that has been destroyed.
> 
> Indeed, ice_aq_send_cmd already tries to avoid accessing an offline control
> queue, but the check occurs inside the lock.
> 
> The root of the problem is that the locks are destroyed at run time.
> 
> Modify ice_init_all_ctrlq and ice_shutdown_all_ctrlq such that they no longer
> create or destroy the locks.
> 
> Introduce new functions, ice_create_all_ctrlq and ice_destroy_all_ctrlq.
> Call these functions in ice_init_hw and ice_deinit_hw.
> 
> Now, the control queue locks will remain valid for the life of the driver, and
> will not be destroyed until the driver unloads.
> 
> This also allows removing a duplicate check of the sq.count and rq.count
> values when shutting down the controlqs. The ice_shutdown_ctrlq function
> already checks this value under the lock. Previously commit dec64ff10ed9
> ("ice: use [sr]q.count when checking if queue is
> initialized") needed this check to happen outside the lock, because it
> prevented duplicate attempts at destroying the locks.
> 
> The driver may now safely use ice_init_all_ctrlq and ice_shutdown_all_ctrlq
> while handling reset events, without causing the locks to be invalid.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c   |   6 +-
>  drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 112 ++++++++++++++----
>  3 files changed, 91 insertions(+), 29 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


