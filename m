From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 10 Dec 2015 22:53:27 +0000
Subject: [Intel-wired-lan] [next PATCH 08/11] ixgbe: Add support for
 VLAN promiscuous with SR-IOV
In-Reply-To: <20151103011013.28233.62670.stgit@localhost.localdomain>
References: <20151103005850.28233.63113.stgit@localhost.localdomain>
 <20151103011013.28233.62670.stgit@localhost.localdomain>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CF61CC@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH 08/11] ixgbe: Add support for VLAN
> promiscuous with SR-IOV
> 
> This patch adds support for VLAN promiscuous with SR-IOV enabled.
> 
> The code prior to this patch was only adding the PF to VLANs that the VF had
> added.  As such enabling promiscuous mode would actually not add any
> additional VLAN filters so visibility was limited.  This lead to a number of issues
> as the bridge and OVS would expect us to accept all VLAN tagged packets when
> promiscuous mode was enabled, and instead we would filter out most if not all
> depending on the configuration of the PF.
> 
> With this patch what we do is set all the bits in the VFTA and all of the VLVF bits
> associated with the pool belonging to the PF.  By doing this the PF is guaranteed
> to receive all VLAN tagged traffic associated with the RAR filters assigned to the
> PF.  In addition we will clean up those same bits in the event of promiscuous
> mode being disabled.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
