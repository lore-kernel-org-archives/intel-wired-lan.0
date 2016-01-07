From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Jan 2016 22:40:34 +0000
Subject: [Intel-wired-lan] [next PATCH S26 05/12] i40e: allocate memory
 safer
In-Reply-To: <1451932392-15538-6-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
 <1451932392-15538-6-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97E602@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Monday, January 04, 2016 10:33 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S26 05/12] i40e: allocate memory
> safer
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The sync_vsi_filter function was allocating memory in such a way that it could
> sleep (GFP_KERNEL) which was causing a problem when called by the team
> driver under rcu_read_lock(), which cannot be held while sleeping.  Found
> with lockdep.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I4e59053cb5eedcf3d0ca151715be3dc42a94bdd5
> ---
> Testing-Hints:
> Run lockdep enabled kernel and try these steps:
>   teamd -t team0 -rd -c '{"runner":{"name":"activebackup"}}'
>   teamdctl team0 port add ens3f0
>   teamdctl team0 port add ens3f0
>   teamdctl team0 port add ens3f1
>   ip link set team0 up
>   ip link add link team0 name team0.3 type vlan id 3
>   ip l set team0.3 up
>   ip link del team0.3
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, no lock errors reported with lock validator
