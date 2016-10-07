From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Oct 2016 19:24:35 +0000
Subject: [Intel-wired-lan] [next PATCH S49-V2 03/15] i40e:
	move	i40e_put_mac_in_vlan and i40e_del_mac_all_vlan
In-Reply-To: <1475685046-16900-4-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
 <1475685046-16900-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0FC71@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, October 05, 2016 9:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S49-V2 03/15] i40e: move
> i40e_put_mac_in_vlan and i40e_del_mac_all_vlan
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A future patch will be modifying these functions and making a call to a static
> function which currently is defined after these functions. Move them in a
> separate patch to ease review and ensure the moved code is correct.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I2ca7fd4e10c0c07ed2291db1ea41bf5987fc6474
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 113 ++++++++++++++---------
> -----
>  1 file changed, 56 insertions(+), 57 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


