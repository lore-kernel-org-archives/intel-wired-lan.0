From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 1 Sep 2017 19:19:39 +0000
Subject: [Intel-wired-lan] [PATCH 0/2] i40e: fix firmware update
In-Reply-To: <20170901140234.7840-1-sassmann@kpanic.de>
References: <20170901140234.7840-1-sassmann@kpanic.de>
Message-ID: <02874ECE860811409154E81DA85FBB5882A98333@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Stefan Assmann
> Sent: Friday, September 01, 2017 7:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; sassmann at kpanic.de
> Subject: [PATCH 0/2] i40e: fix firmware update
> 
> The first patch fixes the firmware update which is currently broken and
> results in a bad flash (corrupt firmware). Recovery is possible with a
> fixed driver.
> The second patch reverts a commit that causes the firmware checksum
> verification to fail right after a successful flash. This is related to
> a recent workqueue change. Haven't gotten to the bottom of this yet, but
> for the sake of a smooth firmware update experience let's revert the
> commit for now.

Hi Stefan,

Thanks for these patches, I apologize for the time it took for us to respond to this. 

The first patch is functionally correct, and I'm surprised we missed sending an equivalent ourselves. It looks like some related changes occurred around this code, and we failed to submit the patch.

I think Jeff would prefer if we send the version based directly on the out-of-tree code, which I will be reviving and submitting shortly.

The second issue I believe is not fixed correctly by the patch, I'm unsure why exactly changing the WQ would cause this but I believe that a similar patch which creates a non-locked version of i40e_nvm_read_buffer() will resolve this, and I will be sending that patch as well, which I believe is the real fix versus halting the work queue.

Thanks,
Jake

> 
> Stefan Assmann (2):
>   i40e: use non-locking i40e_read_nvm_word() function during nvmupdate
>   Revert "i40e: remove WQ_UNBOUND and the task limit of our workqueue"
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++++-------
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c  | 24 ++++++++++++++++++++++--
>  2 files changed, 27 insertions(+), 9 deletions(-)
> 
> --
> 2.13.5


