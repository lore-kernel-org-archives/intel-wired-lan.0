From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 20 Mar 2017 19:41:37 +0000
Subject: [Intel-wired-lan] [PART2 PATCH 4/9] i40e: allow changing input
 set	for ntuple filters
In-Reply-To: <20170206223852.31177-5-jacob.e.keller@intel.com>
References: <20170206223852.31177-1-jacob.e.keller@intel.com>
 <20170206223852.31177-5-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040653D@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PART2 PATCH 4/9] i40e: allow changing input set
> for ntuple filters
> 
> Add support to detect when we can update the input set for each flow type.
> 
> Because the hardware only supports a single input set for all flows of that
> matching type, the driver shall only allow the input set to change if there are
> no other configured filters for that flow type.
> 
> Thus, the first filter added for each flow type is allowed to change the input
> set, and all future filters must match the same input set. Display a diagnostic
> message whenever the filter input set changes, and a warning whenever a
> filter cannot be accepted because it does not match the configured input set.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: c22e1c267ae37518bb036aca4a5694681449f283
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 148
> ++++++++++++++++++++++++-
>  1 file changed, 145 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


