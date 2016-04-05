From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Apr 2016 20:46:57 +0000
Subject: [Intel-wired-lan] [next PATCH 1/2] i40e/i40evf: Clean up
 feature	flags
In-Reply-To: <20160402070319.13504.88242.stgit@localhost.localdomain>
References: <20160402070114.13504.22615.stgit@localhost.localdomain>
 <20160402070319.13504.88242.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACC6D@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Saturday, April 02, 2016 12:05 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; alexander.duyck at gmail.com
> Subject: [Intel-wired-lan] [next PATCH 1/2] i40e/i40evf: Clean up feature
> flags
> 
> The feature flags list for i40e and i40evf is beginning to become pretty
> massive.  I plan to add another 4 or so features to these drivers and
> duplicating the flags for each and every flags list is becoming a bit repetitive.
> 
> The primary change here is that we now build our features list around
> hw_encap_features.  After that we assign that to vlan_features,
> hw_features, and finally map that onto features.  In addition we end up
> throwing features onto hw_encap_features that end up having no effect
> such as the Rx offloads and SCTP_CRC.  However that should have no impact
> and makes things a bit easier for us as hw_encap_features is one of the less
> updated features maps available.
> 
> For i40evf I went through and sanity checked a few features as well.
> Specifically RXCSUM was being set as a read-only feature which didn't make
> much sense.  I have updated things so we can clear the NETIF_F_RXCSUM
> flag since that is really a software feature and not a hardware one anyway so
> disabling it is just a matter of ignoring the result from the hardware.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
> 
> Testing-hints:
>   The only real testing required for this patch is to verify the features
>   make sense after the patch has been applied.  Most of the change is to
>   deal with things like the fact that we were allowing VLAN filtering to be
>   toggled but didn't actually do anything to disable it when it was.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c     |   61 +++++++++------------
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |   66 +++++++++++---------
> ---
>  2 files changed, 58 insertions(+), 69 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Feature flags still make sense with patch applied
