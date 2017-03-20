From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 20 Mar 2017 19:43:50 +0000
Subject: [Intel-wired-lan] [PART2 PATCH 8/9] i40e: add support for
 SCTPv4	FDir filters
In-Reply-To: <20170206223852.31177-9-jacob.e.keller@intel.com>
References: <20170206223852.31177-1-jacob.e.keller@intel.com>
 <20170206223852.31177-9-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040657E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, February 6, 2017 2:39 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PART2 PATCH 8/9] i40e: add support for SCTPv4
> FDir filters
> 
> Enable FDir filters for SCTPv4 packets using the ethtool ntuple interface to
> enable filters. The ethtool API does not allow masking on the verification tag.
> 
> Testing-hints:
>   Ethtool commands to enable sctp4 filters should not produce errors,
>   and should properly direct traffic to the desired queue.
> 
>   ethtool -N <device> flow-type sctp4 <input set> action 1
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: I093e88a8143994c7e6f4b7b17a0bd5cf861d18e4
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 10 ++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 80
> ++++++++++++++++++++++++++
>  4 files changed, 93 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


