From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 10 Dec 2015 22:52:58 +0000
Subject: [Intel-wired-lan] [next PATCH 06/11] ixgbe: Add support for
 adding/removing VLAN on PF bypassing the VLVF
In-Reply-To: <20151103011000.28233.82392.stgit@localhost.localdomain>
References: <20151103005850.28233.63113.stgit@localhost.localdomain>
 <20151103011000.28233.82392.stgit@localhost.localdomain>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CF619A@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH 06/11] ixgbe: Add support for
> adding/removing VLAN on PF bypassing the VLVF
> 
> This patch adds support for bypassing the VLVF entry creation when the PF is
> adding a new VLAN.  The advantage to doing this is that we can then save the
> VLVF entries for the VFs which must have them in order to function, versus the
> PF which can fall back on the default pool entry.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
