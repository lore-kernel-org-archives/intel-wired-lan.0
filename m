From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 19:10:38 +0000
Subject: [Intel-wired-lan] [next PATCH S37 11/15] i40e: Fix RSS to not
 be	limited by the number of CPUs
In-Reply-To: <1463419605-30746-12-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-12-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D69EB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, May 16, 2016 10:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S37 11/15] i40e: Fix RSS to not be
> limited by the number of CPUs
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> Limiting qcount to pf->num_lan_msix, effectively limits the RSS queues to
> only use the number of CPUs, and ignore all other queues. We don't want to
> do this. If the user has changed the RSS settings to use more queues then
> CPUS, we want to trust they know what they are doing and let them. More
> importantly, if we tell them that is what we did, we want to actually do it and
> allow traffic into all of the queues we have allocated. This does not change
> the default setting to initially allocate only the number of CPUS of queue
> pairs.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: Ie941a96e806e4bcd016addb4e17affb46770ada5
> ---
> Testing Hints: Make sure that RSS can hit all queues up to the maximum for
> XL710,X710,X722, including a NPAR nic.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com
RSS not limited by number of CPUs
