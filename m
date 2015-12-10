From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 10 Dec 2015 22:54:07 +0000
Subject: [Intel-wired-lan] [next PATCH 11/11] ixgbe: Clean stale VLANs
 when changing port vlan or resetting
In-Reply-To: <20151103011032.28233.6892.stgit@localhost.localdomain>
References: <20151103005850.28233.63113.stgit@localhost.localdomain>
 <20151103011032.28233.6892.stgit@localhost.localdomain>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CF6220@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, November 02, 2015 5:11 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 11/11] ixgbe: Clean stale VLANs when
> changing port vlan or resetting
> 
> This patch guarantees that the VFs do not have access to VLANs that they were
> not supposed to.  What this patch does is add code so that we delete the
> previous port VLAN after adding a new one, and if we reset the VF we clear all of
> the filters associated with it.
> 
> Previously the code was leaving all previous VLANs mapped to the VF and they
> didn't get deleted unless the VF specifically requested it or if the PF itself was
> reset.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
