From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Mar 2017 23:49:47 +0000
Subject: [Intel-wired-lan] [next PATCH S62 1/6] i40evf: enforce
 descriptor	write-back mechanism for VF
In-Reply-To: <1489177325-13156-2-git-send-email-bimmy.pujari@intel.com>
References: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
 <1489177325-13156-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040A57E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, March 10, 2017 12:22 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S62 1/6] i40evf: enforce descriptor
> write-back mechanism for VF
> 
> From: Preethi Banala <preethi.banala@intel.com>
> 
> The current driver mode is to use a write-back mechanism for the head
> register which indicates transmit completions. The VF driver needs to be able
> to work on hardware that exclusively uses descriptor write-back, so change
> the default driver mode of operation to descriptor write-back for VF. In our
> analysis, performance wasn't significantly different with either write-back
> method.
> 
> Testing Hints:
> 1) load PF driver in host
> 2) create two VMs and load VF driver in both
> 3) create SRIOV VFs in host and direct attach one VF to each VM
> 4) Assign ip address in the same subnet for both VFs.
> 5) Use iperf to send TCP/UDP traffic.
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> Change-ID: Ia92e4ec77c2df8dc4515c71d53746d57d77759af
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 64 +++-------------------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h      | 14 -----
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  4 --
>  3 files changed, 7 insertions(+), 75 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


