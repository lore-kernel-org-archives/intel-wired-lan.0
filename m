From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 10 Dec 2015 22:52:29 +0000
Subject: [Intel-wired-lan] [next PATCH 04/11] ixgbe: Reduce VT code
 indent in set_vfta by introducing jump label
In-Reply-To: <20151103010948.28233.88958.stgit@localhost.localdomain>
References: <20151103005850.28233.63113.stgit@localhost.localdomain>
 <20151103010948.28233.88958.stgit@localhost.localdomain>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CF6161@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH 04/11] ixgbe: Reduce VT code indent in
> set_vfta by introducing jump label
> 
> In order to clear the way for upcoming work I thought it best to drop the level of
> indent in the ixgbe_set_vfta_generic function.  Most of the code is held in the
> virtualization specific section.  So the easiest approach is to just add a jump label
> and jump past the bulk of the code if it is not enabled.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
