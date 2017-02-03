From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 3 Feb 2017 22:52:20 +0000
Subject: [Intel-wired-lan] [next PATCH S59 5/6] i40e: Allow untrusted
 VFs to	have more filters
In-Reply-To: <1485808177-6333-6-git-send-email-bimmy.pujari@intel.com>
References: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
 <1485808177-6333-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5DC10@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, January 30, 2017 12:30 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S59 5/6] i40e: Allow untrusted VFs to
> have more filters
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Our original filter limit of 8 was based on behavior that we saw from Linux
> VMs. Now we're running Other Operating Systems under KVM and we see
> that they commonly use more MAC filters. Since it seems weird to require
> people to enable trusted VFs just to boot their OS, bump the number of
> filters allowed by default.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I76b2dcb2ad6017e39231ad3096c3fb6f065eef5e
> ---
> Testing Hints : Boot Windows Server 2016 in a VM and make sure the host
> doesn't complain about untrusted VFs.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


