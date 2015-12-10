From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 10 Dec 2015 22:52:00 +0000
Subject: [Intel-wired-lan] [next PATCH 02/11] ixgbe: Fix SR-IOV VLAN
 pool	configuration
In-Reply-To: <20151103010935.28233.72294.stgit@localhost.localdomain>
References: <20151103005850.28233.63113.stgit@localhost.localdomain>
 <20151103010935.28233.72294.stgit@localhost.localdomain>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CF6135@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, November 02, 2015 5:10 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 02/11] ixgbe: Fix SR-IOV VLAN pool
> configuration
> 
> The code for checking the PF bit in ixgbe_set_vf_vlan_msg was using the wrong
> offset and as a result it was pulling the VLAN off of the PF even if there were VFs
> numbered greater than 40 that still had the VLAN enabled.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
