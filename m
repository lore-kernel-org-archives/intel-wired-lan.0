From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 15 Jan 2016 16:20:21 +0000
Subject: [Intel-wired-lan] [next PATCH 1/2] ixgbe: Do not allow PF to
 add VLVF entry unless it actually needs it
In-Reply-To: <20160107064844.12239.87981.stgit@localhost.localdomain>
References: <20160107064516.12239.98349.stgit@localhost.localdomain>
 <20160107064844.12239.87981.stgit@localhost.localdomain>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180D17549@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, January 06, 2016 10:49 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 1/2] ixgbe: Do not allow PF to add VLVF
> entry unless it actually needs it
> 
> While doing the work on igb I realized there were a few cases where we were
> still adding VLANs to the VLVF entries for the PF when they were not needed.
> This patch cleans that up so that the only time we add a PF entry to the VLVF is
> either for VLAN 0 or if the PF has requested a VLAN that a VF is already using.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
