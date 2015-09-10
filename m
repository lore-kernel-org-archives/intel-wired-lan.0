From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Sep 2015 16:15:44 +0000
Subject: [Intel-wired-lan] [next PATCH S13 14/15] i40e: fix ip-ip
	GRE	encapulation
In-Reply-To: <1440798961-17326-15-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-15-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A6115@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Friday, August 28, 2015 2:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S13 14/15] i40e: fix ip-ip GRE
> encapulation
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The i40e driver will soon be capable of offloading GRE traffic but in the
> meantime, don't let the driver tell the OS that it can offload types of traffic it
> cannot.
> 
> This fixes a bug where if you stack a GRE MAC in IP tunnel over i40e, all TSO
> packets will be sent with invalid checksums causing really bad throughput.
> 
> NOTE: I still see some retransmits that are unexplained when testing with
> vxlan or ip/mac tunnels (GRE) but the throughput is more like what is
> expected with multi-gigabit on a single flow.
> 
> Reported-by: Stefan Assman <sassman@redhat.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Ie31843b150695b2b1889e306b8c33c1d2da29a9e
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 36
> ++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, patch breaks build of kernel. Builds normally with patch reverted. Error received is "drivers/net/ethernet/intel/i40e/i40e_main.c:8351:2: error: implicit declaration of function 'vxlan_features_check' [-Werror=implicit-function-declaration]"make 
